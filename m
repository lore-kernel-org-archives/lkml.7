Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF2DC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 06:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB92E20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 06:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfHSGaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 02:30:20 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5148 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726174AbfHSGaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 02:30:20 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 434CF35303F54581EDF2;
        Mon, 19 Aug 2019 14:30:17 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 19 Aug
 2019 14:30:13 +0800
Subject: Re: [PATCH] f2fs: fix to avoid data corruption by forbidding SSR
 overwrite
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20190816030334.81035-1-yuchao0@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <3349ceea-85ac-173a-81a4-1188ce3804ca@huawei.com>
Date:   Mon, 19 Aug 2019 14:30:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190816030334.81035-1-yuchao0@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/8/16 11:03, Chao Yu wrote:
> There is one case can cause data corruption.
> 
> - write 4k to fileA
> - fsync fileA, 4k data is writebacked to lbaA
> - write 4k to fileA
> - kworker flushs 4k to lbaB; dnode contain lbaB didn't be persisted yet
> - write 4k to fileB
> - kworker flush 4k to lbaA due to SSR
> - SPOR -> dnode with lbaA will be recovered, however lbaA contains fileB's
> data
> 
> One solution is tracking all fsynced file's block history, and disallow
> SSR overwrite on newly invalidated block on that file.
> 
> However, during recovery, no matter the dnode is flushed or fsynced, all
> previous dnodes until last fsynced one in node chain can be recovered,
> that means we need to record all block change in flushed dnode, which
> will cause heavy cost, so let's just use simple fix by forbidding SSR
> overwrite directly.
> 

Jaegeuk,

Please help to add below missed tag to keep this patch being merged in stable
kernel.

Fixes: 5b6c6be2d878 ("f2fs: use SSR for warm node as well")

Thanks,

> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/segment.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 9d9d9a050d59..69b3b553ee6b 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2205,9 +2205,11 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
>  		if (!f2fs_test_and_set_bit(offset, se->discard_map))
>  			sbi->discard_blks--;
>  
> -		/* don't overwrite by SSR to keep node chain */
> -		if (IS_NODESEG(se->type) &&
> -				!is_sbi_flag_set(sbi, SBI_CP_DISABLED)) {
> +		/*
> +		 * SSR should never reuse block which is checkpointed
> +		 * or newly invalidated.
> +		 */
> +		if (!is_sbi_flag_set(sbi, SBI_CP_DISABLED)) {
>  			if (!f2fs_test_and_set_bit(offset, se->ckpt_valid_map))
>  				se->ckpt_valid_blocks++;
>  		}
> 
