Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56753C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B123217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558528382;
	bh=7Zt5mFnKGpFUyLLmEh/OXRYTSOMLrj8rJD3n8swXUfc=;
	h=Subject:To:References:From:Date:In-Reply-To:List-ID:From;
	b=PoGvFyKTwBJgfuoHHKpDQRZEhG7GnDp1eZf6nXA1UNlROWEytsdcP7M5FbwDwg5Bj
	 PKHDqaYrS4VSNpE2pjEFpfjVnqC7WmgUYaqCjp2uMErHahi9VLcJWJISe82pmY40UV
	 OZmNFSrIE2TCt9T4KTlFpiIrMd6mS+DTfwE5ML6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbfEVMdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 08:33:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728914AbfEVMdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 08:33:01 -0400
Received: from [192.168.0.101] (unknown [49.77.233.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7A992173C;
        Wed, 22 May 2019 12:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558528380;
        bh=7Zt5mFnKGpFUyLLmEh/OXRYTSOMLrj8rJD3n8swXUfc=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=yzHOC2O3R3OLQEJrB35Gcz5qtnVVlhR47yFsPcd3k7fR5yL45kUjGxl3MHQS5iDXH
         uloVw3UG3yfi3Lw/d+McYNFtiWcmoXaPQFfxIuTAD9dPF94q7UstM+gMvJLO3qrzCM
         BGx6VhaB0BJap+z14TJDaTUAdAhanwaS8DjKZMaM=
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: allow ssr block allocation during
 checkpoint=disable period
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20190521180625.10562-1-jaegeuk@kernel.org>
 <20190521180625.10562-2-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <add17fa8-f381-844b-abf2-17182a00232a@kernel.org>
Date:   Wed, 22 May 2019 20:32:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190521180625.10562-2-jaegeuk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-5-22 2:06, Jaegeuk Kim wrote:
> This patch allows to use ssr during checkpoint is disabled.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/gc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 963fb4571fd9..1e029da26053 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -387,7 +387,8 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
>  			goto next;
>  		/* Don't touch checkpointed data */
>  		if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED) &&
> -					get_ckpt_valid_blocks(sbi, segno)))
> +					get_ckpt_valid_blocks(sbi, segno) &&
> +					p.alloc_mode != SSR))

p.alloc_mode == LFS will be more straightforward. :)

Anyway,

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

>  			goto next;
>  		if (gc_type == BG_GC && test_bit(secno, dirty_i->victim_secmap))
>  			goto next;
> 
