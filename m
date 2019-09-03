Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E81C3A5A7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFF421897
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="ELdqVliy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfICUfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 16:35:30 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34082 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfICUfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:35:30 -0400
Received: by mail-yw1-f66.google.com with SMTP id n126so6415965ywf.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 13:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pwr73Ifq5MZWDOqqYWVQ92kOUvydUL8kklQud78eUJs=;
        b=ELdqVliyxeTW51ck6ee9Q2LraeCgUxfmOGv6+fiEQimkCVjhBsD0gEFVO66Dbyfn0g
         G1X3aEEQl4YN95BV8MPCAEv3ZTd2YyFmrTZRumnAQnKdQNuknxSIgNveJ2oosciek7Ay
         5oO3x3M3mQsIuE2ARuQ2ETH5jVeeFB2JftVPut9IGtPxIzpczsosbGc0RBiKc/S8z7iL
         uzmOSJxRb3pFLBTCp49IvcL96BhnVEdcQqC6kG3jOLZtMZxtG52TcqTmnYoSBB38oJ0f
         RX8JxSX/FbNQCz5wI14K1b8itHtewNvBXxteMX8t4BIpBcgFU3qWDHRm7L4ykZm9MZNu
         /siA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pwr73Ifq5MZWDOqqYWVQ92kOUvydUL8kklQud78eUJs=;
        b=eAE1q9+JEw63aCMwOHwvjtEnYtWvbpyJ/GGuXToZYhjPEi+6AQ8FONK6Kbr/0Jz9pg
         RI5LZrF02dYlpO8KetCDosc05kshx7Sq4pyGVE59CFLcS8dqTGLXagAe2WRT5bKqu109
         q/KklXtN1cNfzkhfvjwJ7BqbNvIqiN/65nnzYOTO58i/FX3j8ml8lJQFyoCMnnzZgTM5
         Sw6XRQnU5KKJeTGAMPm5enf3tCCuEuT67rPMmg6TZAeaqIH763lW0XiwZoaVX2edy/+i
         A/hRHbKzJKPzzwML595CvKZE7vNG+rwegBcLeQISS8Gk0HSCbLQS0OGNA+TaAEgrwaTg
         jTmw==
X-Gm-Message-State: APjAAAWmnVc1bDPXqRfcHA3QzsQlPbS7yrmm2FzGxvcvwTX5aesWH3uW
        pIsYsGNck/UHBf+0y3xipdf3Mg==
X-Google-Smtp-Source: APXvYqwfJOUxosRmo8V5dxesORSeHIuM6ShnQY1aGpiUXTG5KqY5PTIzvrDeoLFx+EYtGBdQr4va3Q==
X-Received: by 2002:a81:84d4:: with SMTP id u203mr26754902ywf.106.1567542929119;
        Tue, 03 Sep 2019 13:35:29 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id g69sm3777935ywb.97.2019.09.03.13.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 13:35:25 -0700 (PDT)
Date:   Tue, 3 Sep 2019 16:35:24 -0400
From:   Sean Paul <sean@poorly.run>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sravanthi Kollukuduru <skolluku@codeaurora.org>,
        Bruce Wang <bzwang@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Enrico Weigelt <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Allison Randal <allison@lohutok.net>,
        Boris Brezillon <bbrezillon@kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/10] drm/msm: add kms->flush_commit()
Message-ID: <20190903203524.GJ218215@art_vandelay>
References: <20190829164601.11615-1-robdclark@gmail.com>
 <20190829164601.11615-7-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829164601.11615-7-robdclark@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 09:45:14AM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Add ->flush_commit(crtc_mask).  Currently a no-op, but kms backends
> should migrate writing flush registers to this hook, so we can decouple
> pushing updates to hardware, and flushing the updates.
> 
> Once we add async commit support, the hw updates will be pushed down to
> the hw synchronously, but flushing the updates will be deferred until as
> close to vblank as possible, so that multiple updates can be combined in
> a single frame.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c  |  6 ++++
>  drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c |  6 ++++
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c |  6 ++++
>  drivers/gpu/drm/msm/msm_atomic.c         |  9 ++++--
>  drivers/gpu/drm/msm/msm_kms.h            | 40 ++++++++++++++++++++++--
>  5 files changed, 63 insertions(+), 4 deletions(-)
> 

/snip

> diff --git a/drivers/gpu/drm/msm/msm_kms.h b/drivers/gpu/drm/msm/msm_kms.h
> index 10dd171b43f8..bb70c1758c72 100644
> --- a/drivers/gpu/drm/msm/msm_kms.h
> +++ b/drivers/gpu/drm/msm/msm_kms.h
> @@ -30,12 +30,47 @@ struct msm_kms_funcs {
>  	irqreturn_t (*irq)(struct msm_kms *kms);
>  	int (*enable_vblank)(struct msm_kms *kms, struct drm_crtc *crtc);
>  	void (*disable_vblank)(struct msm_kms *kms, struct drm_crtc *crtc);
> -	/* modeset, bracketing atomic_commit(): */
> +
> +	/*
> +	 * Atomic commit handling:
> +	 */
> +
> +	/**
> +	 * Prepare for atomic commit.  This is called after any previous
> +	 * (async or otherwise) commit has completed.
> +	 */
>  	void (*prepare_commit)(struct msm_kms *kms, struct drm_atomic_state *state);
> +
> +	/**
> +	 * Flush an atomic commit.  This is called after the hardware
> +	 * updates have already been pushed down to effected planes/
> +	 * crtcs/encoders/connectors.
> +	 */
> +	void (*flush_commit)(struct msm_kms *kms, unsigned crtc_mask);
> +
> +	/* TODO remove ->commit(), use ->flush_commit() instead: */
>  	void (*commit)(struct msm_kms *kms, struct drm_atomic_state *state);
> -	void (*complete_commit)(struct msm_kms *kms, unsigned crtc_mask);
> +
> +	/**
> +	 * Wait for any in-progress flush to complete on the specified
> +	 * crtcs.  This should not block if there is no in-progress
> +	 * commit (ie. don't just wait for a vblank), as it will also
> +	 * be called before ->prepare_commit() to ensure any potential
> +	 * "async" commit has completed.
> +	 */
>  	void (*wait_flush)(struct msm_kms *kms, unsigned crtc_mask);
>  
> +	/**
> +	 * Clean up are commit is completed.  This is called after

s/are/our/?

With that fixed,

Reviewed-by: Sean Paul <sean@poorly.run>



> +	 * ->wait_flush(), to give the backend a chance to do any
> +	 * post-commit cleanup.
> +	 */
> +	void (*complete_commit)(struct msm_kms *kms, unsigned crtc_mask);
> +
> +	/*
> +	 * Format handling:
> +	 */
> +
>  	/* get msm_format w/ optional format modifiers from drm_mode_fb_cmd2 */
>  	const struct msm_format *(*get_format)(struct msm_kms *kms,
>  					const uint32_t format,
> @@ -45,6 +80,7 @@ struct msm_kms_funcs {
>  			const struct msm_format *msm_fmt,
>  			const struct drm_mode_fb_cmd2 *cmd,
>  			struct drm_gem_object **bos);
> +
>  	/* misc: */
>  	long (*round_pixclk)(struct msm_kms *kms, unsigned long rate,
>  			struct drm_encoder *encoder);
> -- 
> 2.21.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
