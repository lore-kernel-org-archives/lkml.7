Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C32EC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 04:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B7C2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 04:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iUwi2yxD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbfG3Ebr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 00:31:47 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37569 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728405AbfG3Ebr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 00:31:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id b3so28383508plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 21:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jff1v1+xBPkVNib6smzi9or+Z5ivIfKl1/5fyTJeUXM=;
        b=iUwi2yxDTTmnyE3W9f7x2PRFahy0EfU0FRkjor6FL8ZBn1HAc2NNHhXNQiP7DxiNXu
         zexrCt1ieoP6GiruyGPiscfXflKZOURfcgJM0pwFS/XDldhQqEZTrJtDVEhimzEVxy8M
         woNn/63idoITGhRZHnK2nEAbwDzdkrb5pqT2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jff1v1+xBPkVNib6smzi9or+Z5ivIfKl1/5fyTJeUXM=;
        b=Ke93GMqp3wDuKFEys4fjyTS30rBHT8B+UoCpQaDnBzL1rt8CZhenKjuR3psfTiMIqj
         rW2avX0Jk5ag3PWwBQVePhoeT8aTmzb+s5wa4pbFRfm+cW603tNFXg6kDcTTvJrvqvdo
         4QhSauUhJRsogzd+aoMNXUxFPfGwxx25BxkbNKl8A53PjVs5h0bnJRVjw4lS2PjCO2ka
         uhkOOrJ1acNp9OWpz5hQPBxAKAJid6sMs4r75GKB7qusNUeqGiIGv06id9mnO1kljTxB
         8qSyglH5FEEwONw6+Y6RUVCjJis96nKuKVMgm81wH0NNGphsysrYbEBmqgT5W7sRXM0D
         FRlQ==
X-Gm-Message-State: APjAAAXX3hXtclZhgYvUO8jL2Vfm6WQMY8NBnpXqMtgjroWbwXdSsnrz
        lv3uujpl4il3r3Zuoex1JWjwBg==
X-Google-Smtp-Source: APXvYqzLt+3JbxlxdApPdi1+DZco+EZiCDg4gvrywPkbPKK4SrOK6PKWeBkEZPzVR2ez5PRxBD9nvA==
X-Received: by 2002:a17:902:f082:: with SMTP id go2mr118837503plb.25.1564461106724;
        Mon, 29 Jul 2019 21:31:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v12sm54532952pjk.13.2019.07.29.21.31.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 21:31:45 -0700 (PDT)
Date:   Mon, 29 Jul 2019 21:31:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, arnd@arndb.de,
        y2038@lists.linaro.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
Subject: Re: [PATCH 19/20] pstore: fs superblock limits
Message-ID: <201907292129.AC796230@keescook>
References: <20190730014924.2193-1-deepa.kernel@gmail.com>
 <20190730014924.2193-20-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730014924.2193-20-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 06:49:23PM -0700, Deepa Dinamani wrote:
> Also update the gran since pstore has microsecond granularity.

So, I'm fine with this, but technically the granularity depends on the
backend storage... many have no actual time keeping, though. My point is,
pstore's timestamps are really mostly a lie, but the most common backend
(ramoops) is seconds-granularity.

So, I'm fine with this, but it's a lie but it's a lie that doesn't
matter, so ...

Acked-by: Kees Cook <keescook@chromium.org>

I'm open to suggestions to improve it...

-Kees

> 
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> Cc: anton@enomsg.org
> Cc: ccross@android.com
> Cc: keescook@chromium.org
> Cc: tony.luck@intel.com
> ---
>  fs/pstore/inode.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
> index 89a80b568a17..ee752f9fda57 100644
> --- a/fs/pstore/inode.c
> +++ b/fs/pstore/inode.c
> @@ -388,7 +388,9 @@ static int pstore_fill_super(struct super_block *sb, void *data, int silent)
>  	sb->s_blocksize_bits	= PAGE_SHIFT;
>  	sb->s_magic		= PSTOREFS_MAGIC;
>  	sb->s_op		= &pstore_ops;
> -	sb->s_time_gran		= 1;
> +	sb->s_time_gran         = NSEC_PER_USEC;
> +	sb->s_time_min		= S64_MIN;
> +	sb->s_time_max		= S64_MAX;
>  
>  	parse_options(data);
>  
> -- 
> 2.17.1
> 

-- 
Kees Cook
