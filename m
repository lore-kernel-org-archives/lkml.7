Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D257DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E6FA214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Il+btt/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfCKXWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 19:22:08 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45071 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfCKXWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 19:22:08 -0400
Received: by mail-oi1-f193.google.com with SMTP id t82so517110oie.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 16:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=omN81CG5c5q7TuhNjzaQEg2LGxwAF+/lYU27INOB/Hg=;
        b=Il+btt/ygfQE2P85p6hsPE7ssMd+K0R9uYdB2VxwUuY3OObVy9ZEeJDv3Gm2bAlmFy
         Umo0uYbDk2Uy9I6NEc+uquL2rZbsE8lf1A3uhhCU2rfdcQ97RRINNGWLpx1Tb+5fRlMZ
         3vyeLCVAh4+TZ1pQ1396sMFQ4Qpg+/qeFzx1GI7iNW3rAvAs0BZz3NO78vn4HF1iSBXA
         sC46ImVsy3U0FPY5rmRBh/8kYJ46v9kqGC8T8cMnRjlA+Zdigee7M2KPn56NW12WVPcf
         ooG4+apj3pACq4XjObsucMYdm+bjEBYHL9rCRSme0YXviiJ9OdU6ZbVSGlKD2RJFX7Pg
         Ql+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=omN81CG5c5q7TuhNjzaQEg2LGxwAF+/lYU27INOB/Hg=;
        b=k4IAwgPsoE7KvyXYBekmAV+u14X9q+gq695wng8FwIKhKSz92S2uzgtojMVYfOJLZU
         Xr2oRFhK8bZ3uPZpJSZNQYKmy+wrUbeVyPRHlcBVkOdzlmnqqejhUa+7nxMZLInMSCQ8
         BkTAwmzerlofcdyEJ5ki191DQE2QdcVvuAV50veqrsN+MzLudJNviKrqM74lKpmIqTFP
         aFDT4sgXR5yExQgGmRarc+LybiiLamiUkRwdZDyJjog1TDjBrq4jcYQm8zqJe1d0Wsxv
         HBuKfa+EqJwCmKLGB2fzymGqGC0A5qeZnvZFlNPWlgPbeertw/N1mJxEFAC4F3qBIoZU
         Vw9g==
X-Gm-Message-State: APjAAAX2M7m72ezOU2i5/FHFBSen/dKfdl9ZZI7BRuPWA3kkCqfjetbz
        MsHfYvcFJCh6mHNPWioBEGH019IM
X-Google-Smtp-Source: APXvYqyKjueCDlty0T9GR5ajFCMsNBjU6V6zr94U5f73JKeeHgjiWZI5sy/5/BdUbiMPs3X3BDZ04g==
X-Received: by 2002:a05:6808:1d4:: with SMTP id x20mr70131oic.98.1552346526765;
        Mon, 11 Mar 2019 16:22:06 -0700 (PDT)
Received: from griffin ([177.234.13.170])
        by smtp.gmail.com with ESMTPSA id y12sm2760466otk.80.2019.03.11.16.22.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 11 Mar 2019 16:22:06 -0700 (PDT)
Date:   Mon, 11 Mar 2019 17:21:12 -0600
From:   =?utf-8?B?SmVzw7pz?= Castro <x51v4n@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, miguel.bernal@zapopan.tecmm.edu.mx,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hv: utils: fix coding style
Message-ID: <20190311232110.GA1842@griffin>
References: <20190305234542.5243-1-x51v4n@gmail.com>
 <8d9f56e98854efb8858768119d935ac6091cfc50.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d9f56e98854efb8858768119d935ac6091cfc50.camel@perches.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Checkpatch script is showing a coding style error and is showing:
> > 
> > ERROR: else should follow close brace '}'
> > +	}
> > +	else if (hvt->mode == HVUTIL_TRANSPORT_NETLINK) {
> > 
> > This commit fixes the coding style, not a functional change.
> []
> > diff --git a/drivers/hv/hv_utils_transport.c b/drivers/hv/hv_utils_transport.c
> []
> > @@ -139,8 +139,7 @@ static int hvt_op_open(struct inode *inode, struct file *file)
> >  		 * device gets released.
> >  		 */
> >  		hvt->mode = HVUTIL_TRANSPORT_CHARDEV;
> > -	}
> > -	else if (hvt->mode == HVUTIL_TRANSPORT_NETLINK) {
> > +	} else if (hvt->mode == HVUTIL_TRANSPORT_NETLINK) {
> >  		/*
> >  		 * We're switching from netlink communication to using char
> >  		 * device. Issue the reset first.
> 
> Rather than merely shutting up checkpatch warnings,
> please try to improve the code for humans to read.
> 
> This block is probably better as a switch/case and
> the separate bool issue_reset automatic seems
> unnecessary as it's only used in one case.
> 

I'll follow your suggestion and send the v2.

Thanks for your advice to look beyond the scripts, I'll take it into
account for the next patches.

> Perhaps:
> ---
>  drivers/hv/hv_utils_transport.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hv/hv_utils_transport.c b/drivers/hv/hv_utils_transport.c
> index 832777527936..6b27dd7be9bb 100644
> --- a/drivers/hv/hv_utils_transport.c
> +++ b/drivers/hv/hv_utils_transport.c
> @@ -125,35 +125,35 @@ static int hvt_op_open(struct inode *inode, struct file *file)
>  {
>  	struct hvutil_transport *hvt;
>  	int ret = 0;
> -	bool issue_reset = false;
>  
>  	hvt = container_of(file->f_op, struct hvutil_transport, fops);
>  
>  	mutex_lock(&hvt->lock);
>  
> -	if (hvt->mode == HVUTIL_TRANSPORT_DESTROY) {
> -		ret = -EBADF;
> -	} else if (hvt->mode == HVUTIL_TRANSPORT_INIT) {
> +	switch (hvt->mode) {
> +	case HVUTIL_TRANSPORT_INIT:
>  		/*
>  		 * Switching to CHARDEV mode. We switch bach to INIT when
>  		 * device gets released.
>  		 */
>  		hvt->mode = HVUTIL_TRANSPORT_CHARDEV;
> -	}
> -	else if (hvt->mode == HVUTIL_TRANSPORT_NETLINK) {
> +		break;
> +	case HVUTIL_TRANSPORT_NETLINK:
>  		/*
>  		 * We're switching from netlink communication to using char
>  		 * device. Issue the reset first.
>  		 */
> -		issue_reset = true;
>  		hvt->mode = HVUTIL_TRANSPORT_CHARDEV;
> -	} else {
> +		hvt_reset(hvt);
> +		break;
> +	case HVUTIL_TRANSPORT_DESTROY:
> +		ret = -EBADF;
> +		break;
> +	default:
>  		ret = -EBUSY;
> +		break;
>  	}
>  
> -	if (issue_reset)
> -		hvt_reset(hvt);
> -
>  	mutex_unlock(&hvt->lock);
>  
>  	return ret;
> 
> 
