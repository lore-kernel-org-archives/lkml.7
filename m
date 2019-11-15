Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2D6C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E4720728
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+osObYV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfKONVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 08:21:35 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35843 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfKONVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 08:21:35 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so10978011wrx.3;
        Fri, 15 Nov 2019 05:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gsJuRTfm0pzdP5qIgYrHTIKYOcEemQZJnf9+HD8U5I0=;
        b=b+osObYVxSvsu+1H3izI5Utot7rnQ3pmwHwA51mifYWIaJatC8XrYJEvdP40HXwBkH
         vVFqCGelUeAOaJb5NatPlUprPRetGvZpX1F7JHoDjXdKzsjEj4PljICZxGpbVKKO97i2
         L70V1xCk6fzlcqUk3u5axb7pAn05xtLoj46JGPweIbc0Ej/BiEM40mwTo0Vm5ICYavSK
         tnl7WdtNfc108S4+ggMDpRhiJ1fbPN2sZwtQq7BHiM7O89H4q0tkEv9gi+Y443YLse0m
         et3J2Dzhyelt2MTvv3NRrtF0iW91OroVwP4gnoLsmfbVFcIOYWGE1LPaH7Og1vhEK2Ag
         fsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gsJuRTfm0pzdP5qIgYrHTIKYOcEemQZJnf9+HD8U5I0=;
        b=oZi8D46Kup+HoX6qIzxkxEhtoRrJqgTC1cb5u9DWE3bh4sayp7v5XMqyESwJZDSW2L
         fyy0pZwUnaHzRh4VDIntjNtI2TT4IXScem1YXwS0mC1Qj35acKEZPBCd10mJyDDrMjj5
         ZJ0gM+7rvgDemRCqzd0Ida6MDGibPvtYCGVMEvfSDOevS0UZTVisK35zPg+wpE42edma
         +n5SHIL5zetkH6iW42h3ZOzmW4inVwAGccUPcWwvAWPm3pGTq6mdMYGHKUOPI4RxfCmm
         gmI3Fhy0N3uysoDhCQLbBZf3G+4A18gXHmYUhapF46GQyGJF9JxcrCDkbISG5FLuwXhL
         BR1A==
X-Gm-Message-State: APjAAAUqVfwG1n9wpN7tufhv5SWn0h096gkWbEcUbmOAm36RLP8q5QUM
        y3Po5BK443gx/BvMH06TH743Az0v
X-Google-Smtp-Source: APXvYqwa19cEKDifksR/7B+DiqFGuiVA1CAVSnlA7IatsJED7NDIaJftyJ7TAzxa9fVjE83KUhnYXw==
X-Received: by 2002:adf:e506:: with SMTP id j6mr15610362wrm.19.1573824093188;
        Fri, 15 Nov 2019 05:21:33 -0800 (PST)
Received: from 5WDYG62 (static-css-cqn-143221.business.bouyguestelecom.com. [176.149.143.221])
        by smtp.gmail.com with ESMTPSA id w10sm9455768wmd.26.2019.11.15.05.21.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Nov 2019 05:21:32 -0800 (PST)
From:   Romain Izard <romain.izard.pro@gmail.com>
X-Google-Original-From: Romain Izard <izard_r@5WDYG62>
Date:   Fri, 15 Nov 2019 14:21:26 +0100
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>
Subject: Re: [PATCH] Revert "ubifs: Fix memory leak bug in alloc_ubifs_info()
 error path"
Message-ID: <20191115132052.GA9185@5WDYG62>
References: <20191024082535.1022-1-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024082535.1022-1-richard@nod.at>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 10:25:35AM +0200, Richard Weinberger wrote:
> This reverts commit 9163e0184bd7d5f779934d34581843f699ad2ffd.
> 
> At the point when ubifs_fill_super() runs, we have already a reference
> to the super block. So upon deactivate_locked_super() c will get
> free()'ed via ->kill_sb().

And without a revert, trying to mount a UBI volume with a squashfs image
on it as a UBIFS partition will lead to kernel panics due to the double
free.

> 
> Cc: Wenwen Wang <wenwen@cs.uga.edu>
> Fixes: 9163e0184bd7 ("ubifs: Fix memory leak bug in alloc_ubifs_info() error path")
> Reported-by: https://twitter.com/grsecurity/status/1180609139359277056
> Signed-off-by: Richard Weinberger <richard@nod.at>

Tested-by: Romain Izard <romain.izard.pro@gmail.com>

> ---
>  fs/ubifs/super.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
> index 7d4547e5202d..5e1e8ec0589e 100644
> --- a/fs/ubifs/super.c
> +++ b/fs/ubifs/super.c
> @@ -2267,10 +2267,8 @@ static struct dentry *ubifs_mount(struct file_system_type *fs_type, int flags,
>  		}
>  	} else {
>  		err = ubifs_fill_super(sb, data, flags & SB_SILENT ? 1 : 0);
> -		if (err) {
> -			kfree(c);
> +		if (err)
>  			goto out_deact;
> -		}
>  		/* We do not support atime */
>  		sb->s_flags |= SB_ACTIVE;
>  		if (IS_ENABLED(CONFIG_UBIFS_ATIME_SUPPORT))
> -- 
> 2.16.4
> 
