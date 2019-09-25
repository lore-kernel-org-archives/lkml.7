Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BE7C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306902146E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="CzZfMKa8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389984AbfIYUG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 16:06:59 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:41747 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbfIYUG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 16:06:59 -0400
Received: by mail-yb1-f194.google.com with SMTP id x4so1517491ybo.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 13:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ABB1q+Y6RI6wAP3Xdqh99tjF5hOwjSEUMnXMZT6J1rc=;
        b=CzZfMKa8bfAZ7J9rVawfIImN4IBxaHNbzsDoBVF+7TDRcnO4X2viq87HYwZbCBDRJq
         LEyPe8UbS0mYvr1fbzJS+tWsdcFMGrLBz1YTQCm2nEMTocplBmWSw3lqqQFoHxcekCQG
         vDEfx3/nl9dASKSDx6NnT9fMLBUJZD6YJhg3G+7+BleycoFmJbQ7tzhiLbfQbGFDyHjO
         7qgPDJkFZcLqcv/1lDBGrVYx0GbJ3z1bVC86aPwMTtxQsWVHh6MDUwog35JTpxyflbaY
         iQbpHTMGEeoZq67iCSYh6UQ5owbcpmZcDrhqmHaR2+brZjMuLv2gFwm4YxHrTI8T4jRz
         JVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ABB1q+Y6RI6wAP3Xdqh99tjF5hOwjSEUMnXMZT6J1rc=;
        b=ZtyTYgoYwG6lfNSHH0QNJN75GYCWHnMqsoHaJYBwv7ys4FIuCOOHF6TO7CUhvy3ZGx
         zBC5InhNnT9kEqHzRQF/IhPh4V1nuQ8xLwoelnpGqwnqHOv1Nyp1T2eOJ6BAGdi95Aj/
         gHAApJ+hOdA3SUaokcr8yvMJU7h1DcsAuWtQjM7THs1c9Z9X41xjffgf5VjODH4ydNtu
         1PgQ6Y34lSjCeJHe3k6uS4XrOe0g7cIy3et/9aU5Hs7idli5VFOkI+R0z47iGk4YtLUL
         DSQyehCAyOinZWpEqunxesWGgvZAKPAcHJmcL3oyv/PAQw9Z9qVSw/dxNRze8j09ozwW
         ucBg==
X-Gm-Message-State: APjAAAVciaisiBTZTIZ1Gt558r7VJWBeiEPuHnxmRxxmM5bcvGmjkwcn
        L5cB9dPKj0W3oMGPDzZM2eLbCrPGJXL8cw==
X-Google-Smtp-Source: APXvYqyz8CyPjhHSKjOQo+MhmqkEhTYzNHVW6eZJ8Ahvkq/qMhDQpurnoTbRWih2z82SMccWkrjB/A==
X-Received: by 2002:a25:b28f:: with SMTP id k15mr4219918ybj.381.1569442017953;
        Wed, 25 Sep 2019 13:06:57 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id k137sm1499578ywk.65.2019.09.25.13.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 13:06:57 -0700 (PDT)
Date:   Wed, 25 Sep 2019 16:06:56 -0400
From:   Sean Paul <sean@poorly.run>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, Juston Li <juston.li@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 22/27] drm/nouveau: Don't grab runtime PM refs for HPD
 IRQs
Message-ID: <20190925200656.GN218215@art_vandelay>
References: <20190903204645.25487-1-lyude@redhat.com>
 <20190903204645.25487-23-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190903204645.25487-23-lyude@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 04:46:00PM -0400, Lyude Paul wrote:
> In order for suspend/resume reprobing to work, we need to be able to
> perform sideband communications during suspend/resume, along with
> runtime PM suspend/resume. In order to do so, we also need to make sure
> that nouveau doesn't bother grabbing a runtime PM reference to do so,
> since otherwise we'll start deadlocking runtime PM again.
> 
> Note that we weren't able to do this before, because of the DP MST
> helpers processing UP requests from topologies in the same context as
> drm_dp_mst_hpd_irq() which would have caused us to open ourselves up to
> receiving hotplug events and deadlocking with runtime suspend/resume.
> Now that those requests are handled asynchronously, this change should
> be completely safe.
> 
> Cc: Juston Li <juston.li@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Seems reasonable to me, but would feel better if a nouveau person confirmed

Reviewed-by: Sean Paul <sean@poorly.run>


> ---
>  drivers/gpu/drm/nouveau/nouveau_connector.c | 33 +++++++++++----------
>  1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
> index 56871d34e3fb..f276918d3f3b 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> @@ -1131,6 +1131,16 @@ nouveau_connector_hotplug(struct nvif_notify *notify)
>  	const char *name = connector->name;
>  	struct nouveau_encoder *nv_encoder;
>  	int ret;
> +	bool plugged = (rep->mask != NVIF_NOTIFY_CONN_V0_UNPLUG);
> +
> +	if (rep->mask & NVIF_NOTIFY_CONN_V0_IRQ) {
> +		NV_DEBUG(drm, "service %s\n", name);
> +		drm_dp_cec_irq(&nv_connector->aux);
> +		if ((nv_encoder = find_encoder(connector, DCB_OUTPUT_DP)))
> +			nv50_mstm_service(nv_encoder->dp.mstm);
> +
> +		return NVIF_NOTIFY_KEEP;
> +	}
>  
>  	ret = pm_runtime_get(drm->dev->dev);
>  	if (ret == 0) {
> @@ -1151,25 +1161,16 @@ nouveau_connector_hotplug(struct nvif_notify *notify)
>  		return NVIF_NOTIFY_DROP;
>  	}
>  
> -	if (rep->mask & NVIF_NOTIFY_CONN_V0_IRQ) {
> -		NV_DEBUG(drm, "service %s\n", name);
> -		drm_dp_cec_irq(&nv_connector->aux);
> -		if ((nv_encoder = find_encoder(connector, DCB_OUTPUT_DP)))
> -			nv50_mstm_service(nv_encoder->dp.mstm);
> -	} else {
> -		bool plugged = (rep->mask != NVIF_NOTIFY_CONN_V0_UNPLUG);
> -
> +	if (!plugged)
> +		drm_dp_cec_unset_edid(&nv_connector->aux);
> +	NV_DEBUG(drm, "%splugged %s\n", plugged ? "" : "un", name);
> +	if ((nv_encoder = find_encoder(connector, DCB_OUTPUT_DP))) {
>  		if (!plugged)
> -			drm_dp_cec_unset_edid(&nv_connector->aux);
> -		NV_DEBUG(drm, "%splugged %s\n", plugged ? "" : "un", name);
> -		if ((nv_encoder = find_encoder(connector, DCB_OUTPUT_DP))) {
> -			if (!plugged)
> -				nv50_mstm_remove(nv_encoder->dp.mstm);
> -		}
> -
> -		drm_helper_hpd_irq_event(connector->dev);
> +			nv50_mstm_remove(nv_encoder->dp.mstm);
>  	}
>  
> +	drm_helper_hpd_irq_event(connector->dev);
> +
>  	pm_runtime_mark_last_busy(drm->dev->dev);
>  	pm_runtime_put_autosuspend(drm->dev->dev);
>  	return NVIF_NOTIFY_KEEP;
> -- 
> 2.21.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
