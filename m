Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAD0C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DCA520679
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="VkAzDB4h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732820AbfKTQjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 11:39:05 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36074 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728632AbfKTQjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 11:39:04 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so607087wru.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 08:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/OHSU0fY9M2wF7Dch2vz0TnbVEHM5EwSW33Sj289Ves=;
        b=VkAzDB4ht07A3g+rZWhLc3RvpxR3tanWxlh0EvxiYekr8nCSPHmUlZ/BUMxKCU6BIR
         9nh+QUHzT2vPnAIxSCHtGSFt+oUe6g7QT00ypWhXOjhdXfvmeBgEVseJPixTskmTqIIY
         sfVoKDB/u0Wor54YoTcwiD3ksN/S9/tvZcGZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=/OHSU0fY9M2wF7Dch2vz0TnbVEHM5EwSW33Sj289Ves=;
        b=qJex7IssGn6dz4L+DB7R/3PoMLNPphtgoUtiWFOwJcxJuoFb9piB4TEfGbsE4G9NLh
         JsJ6B/oIifDGS1EW5sjzy5gKSMcb4WWwgV08HvKkGe73On5pZuHY5uHceKcfT3BZXgJ3
         ID4Yq/1gSCE9UlNDhMWShnjWuXPySuSKaRw3Pdz2adny2lBEkkhaFqkaLRvhpe0kQ2L+
         cAXRnwte29zGCsNAHMPKKCXlY7feGpLWfRkCVgnfpkrwRf61Zb3zDBTX4qMCQCfEi7kN
         vFf5y3+pfMJqJUorDOSkevpPC8JSBo7mzam0LKopANAIvj5L+gJq3ZV8xoj3108eU3WC
         tkyQ==
X-Gm-Message-State: APjAAAVCBA6wt6FFcPJhW9EmkgMWAI8Ycy0nzjzg9emKneTaakDfS8kP
        04xCxbvNzeLV9UJiHClTkzrrTw==
X-Google-Smtp-Source: APXvYqxVoHzP5vhF6LkCRi1Hwy3MgV40SQo6RqYoQ3S2Jy5cY6Mt6b3tlm1v83jfAcRsfCuT8TB8DQ==
X-Received: by 2002:adf:fd91:: with SMTP id d17mr4449297wrr.214.1574267942842;
        Wed, 20 Nov 2019 08:39:02 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id x205sm7917798wmb.5.2019.11.20.08.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 08:39:01 -0800 (PST)
Date:   Wed, 20 Nov 2019 17:39:00 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: Re: [PATCH] drm/nouveau: Fix Kconfig indentation
Message-ID: <20191120163900.GP30416@phenom.ffwll.local>
Mail-Followup-To: Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
References: <20191120133619.11415-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120133619.11415-1-krzk@kernel.org>
X-Operating-System: Linux phenom 5.2.0-3-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 09:36:19PM +0800, Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Queued for 5.6 in drm-misc, thanks for your patch.
-Daniel
> ---
>  drivers/gpu/drm/nouveau/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
> index 3558df043592..9c990266e876 100644
> --- a/drivers/gpu/drm/nouveau/Kconfig
> +++ b/drivers/gpu/drm/nouveau/Kconfig
> @@ -2,7 +2,7 @@
>  config DRM_NOUVEAU
>  	tristate "Nouveau (NVIDIA) cards"
>  	depends on DRM && PCI && MMU
> -        select FW_LOADER
> +	select FW_LOADER
>  	select DRM_KMS_HELPER
>  	select DRM_TTM
>  	select BACKLIGHT_CLASS_DEVICE if DRM_NOUVEAU_BACKLIGHT
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
