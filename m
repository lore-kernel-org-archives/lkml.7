Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B12C606CF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 23:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030C92173C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 23:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562629667;
	bh=Cz5Bx6P52fodwps54BhyGetegFSXmNne2sxJp0+kASE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hbIKAA/+Cg1n1wc8FuXJVTc/vUb93KH2CX2zM5B57pEQty++iiqVz6IdWZXTiuf94
	 bs7W8FQnbh/coNvQjy6OPx5I5c8xVi78TnVH36HJsKY2eeNzn7OrnMKfvnDu78FheO
	 KXvF5yK5nzEZ+eryzy8U1Qks7kdeGTIwJ4wvQuZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfGHXrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 19:47:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbfGHXrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 19:47:45 -0400
Received: from localhost (unknown [104.132.1.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5311620693;
        Mon,  8 Jul 2019 23:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562629664;
        bh=Cz5Bx6P52fodwps54BhyGetegFSXmNne2sxJp0+kASE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2hrPj8ntVZhpY8EJmqztIJVe4GDZIvrObL6mQjFwHM60cbL8gV8ih/A8XoBNflH1r
         jgijOIzbrDZfQmWJQOAMCje499k4rfwS6Jvp7Cwrw/dAZVszqkFrqlsMv6RvqEalLP
         fs8lW7zYwmNfhJl0VXqTH6rbWPsDFiXp5IB/rR8s=
Date:   Mon, 8 Jul 2019 16:47:43 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org,
        Park Ju Hyung <qkrwngud825@gmail.com>
Subject: Re: [PATCH] f2fs: improve print log in f2fs_sanity_check_ckpt()
Message-ID: <20190708234743.GC21769@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190708062912.104815-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708062912.104815-1-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08, Chao Yu wrote:
> As Park Ju Hyung suggested:
> 
> "I'd like to suggest to write down an actual version of f2fs-tools
> here as we've seen older versions of fsck doing even more damage
> and the users might not have the latest f2fs-tools installed."
> 
> This patch give a more detailed info of how we fix such corruption
> to user to avoid damageable repair with low version fsck.
> 
> Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/super.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 019422a0844c..3cd6c8d810f9 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2737,7 +2737,8 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
>  
>  	if (__is_set_ckpt_flags(ckpt, CP_LARGE_NAT_BITMAP_FLAG) &&
>  		le32_to_cpu(ckpt->checksum_offset) != CP_MIN_CHKSUM_OFFSET) {
> -		f2fs_warn(sbi, "layout of large_nat_bitmap is deprecated, run fsck to repair, chksum_offset: %u",
> +		f2fs_warn(sbi, "using deprecated layout of large_nat_bitmap, "
> +			  "please run fsck v1.13.0 or higher to repair, chksum_offset: %u",

How about adding the patch name as well?

>  			  le32_to_cpu(ckpt->checksum_offset));
>  		return 1;
>  	}
> -- 
> 2.18.0.rc1
