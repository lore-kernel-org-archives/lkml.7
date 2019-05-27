Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50715C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 07:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A7E62075E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 07:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="bz5lv9GX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfE0HJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 03:09:05 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40165 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfE0HJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 03:09:04 -0400
Received: by mail-ed1-f65.google.com with SMTP id j12so25200105eds.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 00:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2OVAiP3AbT5S3JQwppK7lDiLikNBY/Eh8otDHbqTt1I=;
        b=bz5lv9GXu67K0UZ5ZBo/zLJMbksiMirzuNpLtXHrSjqKldsPiZYCokHawAUTG7XBhk
         vvh32N/8ZE45r/Bh1+kGhRqt0zER9ouCxR5hYy0VG6lDRpdevZAhvhV+GIQTt1nDkSH0
         CqwMtAvHoZ9NHUsp4QbJix5wjmUrCs2L90K+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=2OVAiP3AbT5S3JQwppK7lDiLikNBY/Eh8otDHbqTt1I=;
        b=nvByowMVnocj+vclbTg6Csb2Wuv9yMSmc10K8IoPzGSuJ2KVu4ZHWVeO4/VH6wnhWF
         Nuzf+lvaePA9WcEuItDmcZqRWmhk77W124ohgBB8H0I2ziKV37yMO113KzBchk4AR7BF
         VYCpn8Mon3mSVBYnUpJPQWURZih7P1ZssX9w9gZGZlf0IzRregGjLsvjpnsfMxfBw2k0
         Wuh9xg7uha5veEOd4N1yGI+xKGwa9oHWEtm3OtUI95OnBuTy0z2whVzeRz7hjcG7R4nk
         Jm0WsVrnJJMRcZaKPQVnDrdOm4KQmw3YOz74dIi1qa0S9f09UYxLiG9F/3WOrozwqpb1
         kC/A==
X-Gm-Message-State: APjAAAWYYtRn5iIk051qA+yyJW+l5KeZptrNmiDxSeQp3bhUzvhGaVr1
        GKa/60sZjxZ9y2IIFf1XxpzqzBmxbD8=
X-Google-Smtp-Source: APXvYqyfQKMMUcyTT9MY21mZncZ3r4leh9GCF7kd6VRE2wcGOWT+jU8bj311fhTZFjgSifdSy6nCAg==
X-Received: by 2002:a17:906:9145:: with SMTP id y5mr51770439ejw.206.1558940942348;
        Mon, 27 May 2019 00:09:02 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id w10sm2984595eds.88.2019.05.27.00.09.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 00:09:01 -0700 (PDT)
Date:   Mon, 27 May 2019 09:08:58 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Martin Hostettler <textshell@uchuujin.de>,
        Adam Borowski <kilobyte@angband.pl>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH 04/33] vt: More locking checks
Message-ID: <20190527070858.GJ21222@phenom.ffwll.local>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Martin Hostettler <textshell@uchuujin.de>,
        Adam Borowski <kilobyte@angband.pl>,
        Mikulas Patocka <mpatocka@redhat.com>
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
 <20190524085354.27411-5-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524085354.27411-5-daniel.vetter@ffwll.ch>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 10:53:25AM +0200, Daniel Vetter wrote:
> I honestly have no idea what the subtle differences between
> con_is_visible, con_is_fg (internal to vt.c) and con_is_bound are. But
> it looks like both vc->vc_display_fg and con_driver_map are protected
> by the console_lock, so probably better if we hold that when checking
> this.
> 
> To do that I had to deinline the con_is_visible function.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> Cc: Martin Hostettler <textshell@uchuujin.de>
> Cc: Adam Borowski <kilobyte@angband.pl>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Mikulas Patocka <mpatocka@redhat.com>

Hi Greg,

Do you want to merge this through your console tree or ack for merging
through drm/fbdev? It's part of a bigger series, and I'd like to have more
testing with this in our trees, but also ok to merge stand-alone if you
prefer that. It's just locking checks and some docs.

Same for the preceeding patch in this series here.

Thanks, Daniel


> ---
>  drivers/tty/vt/vt.c            | 16 ++++++++++++++++
>  include/linux/console_struct.h |  5 +----
>  2 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index bc9813b14c58..a8988a085138 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -3815,6 +3815,8 @@ int con_is_bound(const struct consw *csw)
>  {
>  	int i, bound = 0;
>  
> +	WARN_CONSOLE_UNLOCKED();
> +
>  	for (i = 0; i < MAX_NR_CONSOLES; i++) {
>  		if (con_driver_map[i] == csw) {
>  			bound = 1;
> @@ -3826,6 +3828,20 @@ int con_is_bound(const struct consw *csw)
>  }
>  EXPORT_SYMBOL(con_is_bound);
>  
> +/**
> + * con_is_visible - checks whether the current console is visible
> + * @vc: virtual console
> + *
> + * RETURNS: zero if not visible, nonzero if visible
> + */
> +bool con_is_visible(const struct vc_data *vc)
> +{
> +	WARN_CONSOLE_UNLOCKED();
> +
> +	return *vc->vc_display_fg == vc;
> +}
> +EXPORT_SYMBOL(con_is_visible);
> +
>  /**
>   * con_debug_enter - prepare the console for the kernel debugger
>   * @sw: console driver
> diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
> index ed798e114663..24d4c16e3ae0 100644
> --- a/include/linux/console_struct.h
> +++ b/include/linux/console_struct.h
> @@ -168,9 +168,6 @@ extern void vc_SAK(struct work_struct *work);
>  
>  #define CUR_DEFAULT CUR_UNDERLINE
>  
> -static inline bool con_is_visible(const struct vc_data *vc)
> -{
> -	return *vc->vc_display_fg == vc;
> -}
> +bool con_is_visible(const struct vc_data *vc);
>  
>  #endif /* _LINUX_CONSOLE_STRUCT_H */
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
