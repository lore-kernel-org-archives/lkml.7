Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4855BC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193FC216E3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfGDHWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 03:22:21 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57550 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726199AbfGDHWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 03:22:21 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 47A2D71C5B86DF84055;
        Thu,  4 Jul 2019 15:22:18 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 4 Jul 2019
 15:22:14 +0800
Subject: Re: [PATCH v3] f2fs: avoid out-of-range memory access
To:     Ocean Chen <oceanchen@google.com>, <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20190703153320.203523-1-oceanchen@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <d3a24db9-72a2-a162-025a-505909cf6ef2@huawei.com>
Date:   Thu, 4 Jul 2019 15:22:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190703153320.203523-1-oceanchen@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/7/3 23:33, Ocean Chen wrote:
> blk_off might over 512 due to fs corrupt and should
> be checked before being used.
> Use ENTRIES_IN_SUM to protect invalid memory access.
> 
> --
> v2:
> - fix typo
> v3:
> - check blk_off before being used
> --
> Signed-off-by: Ocean Chen <oceanchen@google.com>
> ---
>  fs/f2fs/segment.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 8dee063c833f..c3eae3239345 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3401,6 +3401,9 @@ static int read_compacted_summaries(struct f2fs_sb_info *sbi)
>  		if (seg_i->alloc_type == SSR)
>  			blk_off = sbi->blocks_per_seg;
>  
> +                if (blk_off >= ENTRIES_IN_SUM)
> +                  return -EFAULT;

- scripts/checkpatch.pl will complain such format.
- miss to call f2fs_put_page(page, 1) before return.

Thanks,

> +
>  		for (j = 0; j < blk_off; j++) {
>  			struct f2fs_summary *s;
>  			s = (struct f2fs_summary *)(kaddr + offset);
> 
