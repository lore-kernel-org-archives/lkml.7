Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA198C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 17:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08E2207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 17:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="Eoq43qJc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfIYRpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 13:45:36 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:42419 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfIYRpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 13:45:36 -0400
Received: by mail-yw1-f65.google.com with SMTP id i207so2364829ywc.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 10:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=OHVvzelA+uTT0vqtBbcthTQGTZf18Jq4ZMdyM4vKKZU=;
        b=Eoq43qJcz4SJgYYeUj+gyezjfjzs7Qm+Cu5GqJc716NpshVeHQnj9dI+LxTTuOEgGp
         bCjFNu6mP5Gep2i1UT4sEjF/PMjtC+ZvEyzZiVfwlu5tc1i11q+tj9hGgioti7PG6CY2
         mZkGUUb/SS+B/frYGIr25We6zLL1MpVt09xXtUathb+YXmb1WTJ8BMUbWKIb0kFx2H3/
         /U6F1n0zm3nhrWoBbUm4emctarTkSCMuA0Tp2Gp15VfvkuX7vzu5d6VLLcI/gOvEAsI1
         DnmPlOBm8SiNx+FU7evnY6IEc195qBCAfa6NneYJtmCAXy/daBA2dPWge4KZObulAKDi
         DuBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OHVvzelA+uTT0vqtBbcthTQGTZf18Jq4ZMdyM4vKKZU=;
        b=ZmrZ0hPydVKlEtlW59wV3MI4QogJ6cW5rlcdKTTiZKwV0NGc5FGuTlyBnksYUiQmsn
         udW7Zpx9NrL+UglNm2n4bPdnbw25EnY/E6Uu1MIn6IKeJyquhWXTgh1oUVbFRMUmT86c
         Mo8rhnoVBoaAcDXlRr0uW/tVFMWmQZ+XwUuj9sJrRmO3YIG3dHEizmygQxATZeM2i3Mz
         1AHAAgMyQ/mPHfXmKedSsNiCrglnfi+KDyu0VrphyNksnXKK5kKd8VuytUE+BIuc2ajx
         aNyInm627h38STN4AUuS/pKPSyiFYcnp3rSZOVettnKEuwAnEG1Ay1s5pVl1B7jjWOv1
         rhSA==
X-Gm-Message-State: APjAAAWIDhVxgTUKZQ9IFJ168NkgRmF2/dBilbhANGW56EZ+CIt3LXpB
        6ClstIt/d7ATuW1Zh8InWX3CZA==
X-Google-Smtp-Source: APXvYqwdQF5TZmOn2Waf8wCW11wDqQSX9XejhvOETf2AyAc5oHiV2g3hW8Lg8NybKbf1QT554XdCIw==
X-Received: by 2002:a81:3b09:: with SMTP id i9mr6724791ywa.166.1569433534992;
        Wed, 25 Sep 2019 10:45:34 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id a20sm1413804ywl.76.2019.09.25.10.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 10:45:34 -0700 (PDT)
Date:   Wed, 25 Sep 2019 13:45:34 -0400
From:   Sean Paul <sean@poorly.run>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, Juston Li <juston.li@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/27] drm/dp_mst: Get rid of list clear in
 destroy_connector_work
Message-ID: <20190925174534.GC218215@art_vandelay>
References: <20190903204645.25487-1-lyude@redhat.com>
 <20190903204645.25487-3-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190903204645.25487-3-lyude@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 04:45:40PM -0400, Lyude Paul wrote:
> This seems to be some leftover detritus from before the port/mstb kref
> cleanup and doesn't do anything anymore, so get rid of it.
> 
> Cc: Juston Li <juston.li@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Sean Paul <sean@poorly.run>

> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 36db66a0ddb1..3054ec622506 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -3760,8 +3760,6 @@ static void drm_dp_destroy_connector_work(struct work_struct *work)
>  		list_del(&port->next);
>  		mutex_unlock(&mgr->destroy_connector_lock);
>  
> -		INIT_LIST_HEAD(&port->next);
> -
>  		mgr->cbs->destroy_connector(mgr, port->connector);
>  
>  		drm_dp_port_teardown_pdt(port, port->pdt);
> -- 
> 2.21.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
