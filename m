Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0048AC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F7520868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="cz7+iCOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731195AbfFGSTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 14:19:01 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37723 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729817AbfFGSTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:19:01 -0400
Received: by mail-ed1-f67.google.com with SMTP id w13so4287545eds.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 11:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SgapDvu9AZ9bjduDzfdPcw5741fT3T5XkHZzme8aMgw=;
        b=cz7+iCOvp3QtnYJKjfVjS2bko5hNUS6qKdcdu4D68IIitzSC8cQmMbhTSql0v74US2
         2gR0DzB7NNt6+8xhoSgcbI9oGHD8ySJlQ3J5DxiFXewizn1Uz1+kaZQ9ooApg56Ji1id
         XJEwpivJwiDuvvxw6eKyvAG/nmlnyQ2veB6Po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=SgapDvu9AZ9bjduDzfdPcw5741fT3T5XkHZzme8aMgw=;
        b=VurEdEKAQ5s/8LAhvgWVU6t5pf/AQym2jvNWQa6Ni28aPYy16PAJFh/ZKq1gsPfMjF
         lOY8O9osI02FiI58jiyEYMoKfT0+K5gJOhkLlaD7EXSKeR4dMdUIc6dz0rdoXu+8r2fE
         fKnp9yQmmi0DeXV+9YwJ/k4A81Ys8oQgLppmXFd9ulDigud6eW5Sy/jSw5yeyaRR7vEv
         MZZyerOuZ8XXCD5V6wTYI4S7Lo4KpNj+T6eT00dwOPGnnqHhWrlSTNzzjMYNnOCNMh0O
         8FB5zQBHAXpJ9vvG0fVtDiL+wAE3jHQ8b+C/RAJ7IzqhF5+9C/x8oCfAbOVbjtkXY25E
         ifAw==
X-Gm-Message-State: APjAAAU/VwL50ImON0OtR/CZdjoNvktGpG2ULxa38QM2rldDUa9R+FF/
        jQtbCd5tO0iKr6Pk/Je0InQPUA==
X-Google-Smtp-Source: APXvYqyMFYfjRaCLPfHcgcuJZs/84Otob7yqvDwuAVVMsR09fUXE/VI7k5InDN/B9gVoq4GB1K88Lg==
X-Received: by 2002:a50:90af:: with SMTP id c44mr32178174eda.126.1559931539756;
        Fri, 07 Jun 2019 11:18:59 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id y8sm492652ejq.24.2019.06.07.11.18.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 11:18:58 -0700 (PDT)
Date:   Fri, 7 Jun 2019 20:18:56 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Ayan Halder <Ayan.Halder@arm.com>
Cc:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/komeda: Enable/Disable vblank interrupts
Message-ID: <20190607181856.GK21222@phenom.ffwll.local>
Mail-Followup-To: Ayan Halder <Ayan.Halder@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
References: <20190607150323.20395-1-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607150323.20395-1-ayan.halder@arm.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 03:03:39PM +0000, Ayan Halder wrote:
> One needs to set "(struct drm_device *)->irq_enabled = true" to signal drm core
> to enable vblank interrupts after the hardware has been initialized.
> Correspondingly, one needs to disable vblank interrupts by setting
> "(struct drm_device *)->irq_enabled = false" at the beginning of the
> de-initializing routine.

Only if you don't use the drm_irq_install helper. Quoting the kerneldoc in
full:

	/**
	 * @irq_enabled:
	 *
	 * Indicates that interrupt handling is enabled, specifically vblank
	 * handling. Drivers which don't use drm_irq_install() need to set this
	 * to true manually.
	 */
	bool irq_enabled;

Not entirely sure where you've found your quote, but it's not complete.

Cheers, Daniel

> 
> Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_kms.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> index 7b5cde14e3ba..b4fd8ee0d05f 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> @@ -204,6 +204,8 @@ struct komeda_kms_dev *komeda_kms_attach(struct komeda_dev *mdev)
>  	if (err)
>  		goto uninstall_irq;
>  
> +	drm->irq_enabled = true;
> +
>  	err = drm_dev_register(drm, 0);
>  	if (err)
>  		goto uninstall_irq;
> @@ -211,6 +213,7 @@ struct komeda_kms_dev *komeda_kms_attach(struct komeda_dev *mdev)
>  	return kms;
>  
>  uninstall_irq:
> +	drm->irq_enabled = false;
>  	drm_irq_uninstall(drm);
>  cleanup_mode_config:
>  	drm_mode_config_cleanup(drm);
> @@ -225,6 +228,7 @@ void komeda_kms_detach(struct komeda_kms_dev *kms)
>  	struct drm_device *drm = &kms->base;
>  	struct komeda_dev *mdev = drm->dev_private;
>  
> +	drm->irq_enabled = false;
>  	mdev->funcs->disable_irq(mdev);
>  	drm_dev_unregister(drm);
>  	drm_irq_uninstall(drm);
> -- 
> 2.21.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
