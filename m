Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A53C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 00:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02146214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 00:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565052139;
	bh=eZwQBDcR/MKYEfWG81eygG4AefN+C5bI0r2OySbuQH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OnqHF/NPIdjXMC2MwbLKEGFLjRPX1jbapcCLBrpEAPcB3BPFlif0cuSVGm4xWXWif
	 a/o5J7mrGRP+26AFpUfG6K0cUemxGTNJbvmZ/09xQgWi+0CfqwsxZwPrtmBFUALCFs
	 4K0ugUwW9FLh6xcxCJVYCxiarSlwhn6rzug7r8t0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731117AbfHFAmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 20:42:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728483AbfHFAmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 20:42:17 -0400
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F09D2147A;
        Tue,  6 Aug 2019 00:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565052136;
        bh=eZwQBDcR/MKYEfWG81eygG4AefN+C5bI0r2OySbuQH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hZTdUh7m+TxBSmTs1N9DcHxM8FaEQOdounaDItLqslNEzK+yF2IKj+bbhmz8mgVMJ
         /dN79jv0RBiOXWzAmzAamqFYi8tzCE66mk+DmHzlpQtB2jFWpFcM16V4/wIJgzwdLx
         v/S0twBm+UcvLi7A5PnuHNeL+2s37gvWfMf3XW58=
Date:   Mon, 5 Aug 2019 17:42:15 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH] Revert "f2fs: avoid out-of-range memory access"
Message-ID: <20190806004215.GC98101@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190802101548.96543-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802101548.96543-1-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02, Chao Yu wrote:
> As Pavel Machek reported:
> 
> "We normally use -EUCLEAN to signal filesystem corruption. Plus, it is
> good idea to report it to the syslog and mark filesystem as "needing
> fsck" if filesystem can do that."
> 
> Still we need improve the original patch with:
> - use unlikely keyword
> - add message print
> - return EUCLEAN
> 
> However, after rethink this patch, I don't think we should add such
> condition check here as below reasons:
> - We have already checked the field in f2fs_sanity_check_ckpt(),
> - If there is fs corrupt or security vulnerability, there is nothing
> to guarantee the field is integrated after the check, unless we do
> the check before each of its use, however no filesystem does that.
> - We only have similar check for bitmap, which was added due to there
> is bitmap corruption happened on f2fs' runtime in product.
> - There are so many key fields in SB/CP/NAT did have such check
> after f2fs_sanity_check_{sb,cp,..}.
> 
> So I propose to revert this unneeded check.

IIRC, this came from security vulnerability report which can access
out-of-boundary memory region. Could you write another patch to address the
above issues?

> 
> This reverts commit 56f3ce675103e3fb9e631cfb4131fc768bc23e9a.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/segment.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 9693fa4c8971..2eff9c008ae0 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3492,11 +3492,6 @@ static int read_compacted_summaries(struct f2fs_sb_info *sbi)
>  		seg_i = CURSEG_I(sbi, i);
>  		segno = le32_to_cpu(ckpt->cur_data_segno[i]);
>  		blk_off = le16_to_cpu(ckpt->cur_data_blkoff[i]);
> -		if (blk_off > ENTRIES_IN_SUM) {
> -			f2fs_bug_on(sbi, 1);
> -			f2fs_put_page(page, 1);
> -			return -EFAULT;
> -		}
>  		seg_i->next_segno = segno;
>  		reset_curseg(sbi, i, 0);
>  		seg_i->alloc_type = ckpt->alloc_type[i];
> -- 
> 2.18.0.rc1
