Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E3EC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD21C21D7E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="JRkRa/R1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfKGIeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 03:34:01 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34499 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfKGIeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:34:01 -0500
Received: by mail-wm1-f66.google.com with SMTP id v3so4273602wmh.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 00:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=s8siO8c5nG2oA4yleva52f8UrXXloSdu8Edj03PJpK0=;
        b=JRkRa/R1N2W5Q9fECuduw7TIszePzpuIf+wxSx2MpS7SVRD2xH3wNupZLXTrfgmaJh
         mGoLnytxEdFYu1k8s1FTzVDv/O0IW/WSVdoccxvdGjvYKtdyrKLfx+CzEHFryhCO3JAw
         KYb8NmrLgGyx511ItajYvxS7EXqMNegvbQbqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=s8siO8c5nG2oA4yleva52f8UrXXloSdu8Edj03PJpK0=;
        b=fJTMVEJRiGsySmtfzzMDgymG1KZQquWA7aTIG7wxPKNxo8gQktJvbpjezOqmuVFyK6
         uGdnCr0DPltJkrqo0HAgKlKiQTIVCzWYtGgawahcVwNJgNPKruDTKQjq36mx97gp2DAC
         jK0LfA8iQMOLX97qHckFrNYrIaySJjkbNJeLIwhHvcWQwwKSskP9M6TtRWewU4hKNjsk
         xnBJbsoHVH/fqn7q2VHQFrP/h6FcHUzuW8CPtPZA9sFl71+aIKXK5qOglBqQAzYQ5wz5
         vyiDJBOV+m/9YWCSfgc+Jhqt4xbW3NfD3lQPK9AdMJCbrde3LxG37SrqsbG0oPPd+UaT
         fveA==
X-Gm-Message-State: APjAAAXjgD0R0l9ymCxLS48xWz+ejgiOWss7llX1Dj4XYq/4ztF0px3i
        S9m3ee+xY4iRjC0avIQ9oeSZNg==
X-Google-Smtp-Source: APXvYqxKMCfhiclD4wFqY8ApTHpX3Q1Ro0gZKnJrP51xrd4JOijhRLOYoIdKgYqifQ0PrRuhN8PtPg==
X-Received: by 2002:a1c:4946:: with SMTP id w67mr1729615wma.16.1573115636920;
        Thu, 07 Nov 2019 00:33:56 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id v128sm2249296wmb.14.2019.11.07.00.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 00:33:56 -0800 (PST)
Date:   Thu, 7 Nov 2019 09:33:54 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [RFC PATCH 05/12] video: fbdev: matrox: convert to
 i2c_new_scanned_device
Message-ID: <20191107083354.GK23790@phenom.ffwll.local>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <20191106095033.25182-1-wsa+renesas@sang-engineering.com>
 <20191106095033.25182-6-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106095033.25182-6-wsa+renesas@sang-engineering.com>
X-Operating-System: Linux phenom 5.2.0-3-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 10:50:23AM +0100, Wolfram Sang wrote:
> Move from the deprecated i2c_new_probed_device() to the new
> i2c_new_scanned_device(). Make use of the new ERRPTR if suitable.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Ack for merging through whatever tree you think this should best land
through.
-Daniel

> ---
> 
> Build tested only. RFC, please comment and/or ack, but don't apply yet.
> 
>  drivers/video/fbdev/matrox/i2c-matroxfb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/matrox/i2c-matroxfb.c b/drivers/video/fbdev/matrox/i2c-matroxfb.c
> index 34e2659c3189..e2e4705e3fe0 100644
> --- a/drivers/video/fbdev/matrox/i2c-matroxfb.c
> +++ b/drivers/video/fbdev/matrox/i2c-matroxfb.c
> @@ -191,8 +191,8 @@ static void* i2c_matroxfb_probe(struct matrox_fb_info* minfo) {
>  				0x1b, I2C_CLIENT_END
>  			};
>  
> -			i2c_new_probed_device(&m2info->maven.adapter,
> -					      &maven_info, addr_list, NULL);
> +			i2c_new_scanned_device(&m2info->maven.adapter,
> +					       &maven_info, addr_list, NULL);
>  		}
>  	}
>  	return m2info;
> -- 
> 2.20.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
