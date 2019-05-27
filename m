Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2D6C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 07:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A756E21707
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 07:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="M++fSJWI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfE0HLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 03:11:31 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39762 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfE0HLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 03:11:31 -0400
Received: by mail-ed1-f68.google.com with SMTP id e24so25222065edq.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 00:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wA1JuhUgVmAMcVow8fyZg95eHwvIww+RlmWs6LbIHEw=;
        b=M++fSJWIrvusFTZQ6drpas8GACMqPkJmizwitxjxCh2T5tic14cebDSsGUjQ5C3oKe
         VvT54XZ4qbUx63jthl0C7W3mIHhORCyHmX8zG8ZFWKfrev0OvL1WfpFwNZix0KpRtkSA
         dVwTfIRQixKE2cr5XCKMidd0wP6GhEiDcKelQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=wA1JuhUgVmAMcVow8fyZg95eHwvIww+RlmWs6LbIHEw=;
        b=RbIPFFE72QiySRdCLDnHlfTgYMNUoWg0M9bxhx9Na3nN8PMUPaHFscAAbomqd/k54q
         +EfWC8504m02C44RQYQtSd11gvlqY0+tRHoBnlSIEkF4VPuF9Sea2brBNlquk5ytiwKS
         0JQhgcpx5JFu9oKckY6ega7IdJs4iPPbKu1zAoZy65wSOa8ya4ZevY007jdqsbZep5QF
         pxiKPpNcvloynn8/KnGnI8y3WoXvSfCHrmhGB+oOY+cgqDvuv3shry0pbYg+WkDnH4lS
         O7wYEyu8QEJ+pvqaYekb32TDM4rdvj+vZjZbFiBWrfQbSHq8t/t/FuariBoq7QJ9cRBH
         bTXQ==
X-Gm-Message-State: APjAAAX24emuilycWYPEHV0BbZVCtsgAyrhTLmcC/44HRN1LouhQgb9D
        BGf2tPNLCAAIvy/lYztVUY7/FXrrZug=
X-Google-Smtp-Source: APXvYqzQpmBvFwoEJCPko6O9rivTi+mlWfwidR3MWcOARh7DAtnArIQGclbOBWliqvv6nqMfC0ymbg==
X-Received: by 2002:a50:ba1a:: with SMTP id g26mr120202668edc.90.1558941089378;
        Mon, 27 May 2019 00:11:29 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x22sm3057778edd.59.2019.05.27.00.11.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 00:11:28 -0700 (PDT)
Date:   Mon, 27 May 2019 09:11:26 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>,
        Jon Nettleton <jon.nettleton@gmail.com>
Subject: Re: [PATCH 32/33] staging/olpc_dcon: Add drm conversion to TODO
Message-ID: <20190527071126.GL21222@phenom.ffwll.local>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>,
        Jon Nettleton <jon.nettleton@gmail.com>
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
 <20190524085354.27411-33-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524085354.27411-33-daniel.vetter@ffwll.ch>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 10:53:53AM +0200, Daniel Vetter wrote:
> this driver is pretty horrible from a design pov, and needs a complete
> overhaul. Concrete thing that annoys me is that it looks at
> registered_fb, which is an internal thing to fbmem.c and fbcon.c. And
> ofc it gets the lifetime rules all wrong (it should at least use
> get/put_fb_info).
> 
> Looking at the history, there's been an attempt at dropping this from
> staging in 2016, but that had to be reverted. Since then not real
> effort except the usual stream of trivial patches, and fbdev has been
> formally closed for any new hw support. Time to try again and drop
> this?
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Jens Frederich <jfrederich@gmail.com>
> Cc: Daniel Drake <dsd@laptop.org>
> Cc: Jon Nettleton <jon.nettleton@gmail.com>

Hi Greg

Again get_mainatiners didn't pick you up on this somehow (I manually added
you now for the next round). Do you want to pick this up to staging, or
ack for merging through drm/fbdev as part of the larger fbdev/fbcon
rework?

Also, I think time to retry and attempt at dropping this imo ...

Thanks, Daniel

> ---
>  drivers/staging/olpc_dcon/TODO | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/staging/olpc_dcon/TODO b/drivers/staging/olpc_dcon/TODO
> index 665a0b061719..fe09efbc7f77 100644
> --- a/drivers/staging/olpc_dcon/TODO
> +++ b/drivers/staging/olpc_dcon/TODO
> @@ -1,4 +1,11 @@
>  TODO:
> +	- complete rewrite:
> +	  1. The underlying fbdev drivers need to be converted into drm kernel
> +	     modesetting drivers.
> +	  2. The dcon low-power display mode can then be integrated using the
> +	     drm damage tracking and self-refresh helpers.
> +	  This bolted-on self-refresh support that digs around in fbdev
> +	  internals, but isn't properly integrated, is not the correct solution.
>  	- see if vx855 gpio API can be made similar enough to cs5535 so we can
>  	  share more code
>  	- convert all uses of the old GPIO API from <linux/gpio.h> to the
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
