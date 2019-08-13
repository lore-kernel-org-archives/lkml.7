Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08888C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE54205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="VKfSU73c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbfHMOzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 10:55:14 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41801 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729400AbfHMOzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 10:55:14 -0400
Received: by mail-ed1-f67.google.com with SMTP id w5so4340217edl.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 07:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=tICg/V6ETORM9pfCRmLD3TLnpZGBTlGaeuCvuCv5TCc=;
        b=VKfSU73cdgLiNJ0QL6ha2YwVCeHHA8P/z1P51N5Ovdj3ggIoo/bUrIPO9/Rk7eGKd0
         WY7qwl2uf3YorrMetIsbrmqUIyTy3S6y5FJcvzS12PofM7imZ2KSQK7hNKO5mGBPdBJr
         bHynZ+XKTHpeFRjG8GPE6cZ5Y/ACIVtjlFDvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=tICg/V6ETORM9pfCRmLD3TLnpZGBTlGaeuCvuCv5TCc=;
        b=k0O71atRGcLYFntguBPBBC5Q3tzyIkI5Nh27jRUp6nCjSWr1pvgweBOl+h1P8Pabta
         fbgy5c54wHg4rrZna2XjNspMbYGBN+hmc45TnVjdVjK3pHuG80TIgXg+BR54P6jKBIFM
         lc+HeTMzC1eS3hzeFG4tBHv/22Uz8/XkiJ9+gfIWxQNDnwDGClrdTepJd02/8MevWdEV
         xUrNC5fAY8p9j6JR91WLKdI0WDFW+URAX/snxSsn6DxWOGr+3SfKh87CT3nKVoZ36bDU
         MxZygwMDDTcrGKdzqpCl9UQn6iEHtSv7RlkC4yaQXTBGuWad70FRktYPxiMnK0H2fNQQ
         jKog==
X-Gm-Message-State: APjAAAUp5Ilp1MXzjlwAlbO+m9/jyP2hc0vsewuYOrojyEQqDZRrli3D
        V5iG2uR0cbvO7DmHf1ep/8ZJaA==
X-Google-Smtp-Source: APXvYqxuK867gLSFUvuzX85s579SR5whpAswIiVkcNxwXxfyTEuAyGzBczOhzNpaxZSDusx38vBxnw==
X-Received: by 2002:a50:e618:: with SMTP id y24mr42302798edm.142.1565708112721;
        Tue, 13 Aug 2019 07:55:12 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id c14sm2166531edb.5.2019.08.13.07.55.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 07:55:11 -0700 (PDT)
Date:   Tue, 13 Aug 2019 16:55:09 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, Juston Li <juston.li@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/26] drm/dp_mst: Get rid of list clear in
 drm_dp_finish_destroy_port()
Message-ID: <20190813145509.GX7444@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, Juston Li <juston.li@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Harry Wentland <hwentlan@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
References: <20190718014329.8107-1-lyude@redhat.com>
 <20190718014329.8107-8-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190718014329.8107-8-lyude@redhat.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 09:42:30PM -0400, Lyude Paul wrote:
> This seems to be some leftover detritus from before the port/mstb kref
> cleanup and doesn't do anything anymore, so get rid of it.
> 
> Cc: Juston Li <juston.li@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Maybe move this earlier, before patch 2. Either way:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>


> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 0295e007c836..ec6865e1af75 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -3870,8 +3870,6 @@ static void drm_dp_tx_work(struct work_struct *work)
>  static inline void
>  drm_dp_finish_destroy_port(struct drm_dp_mst_port *port)
>  {
> -	INIT_LIST_HEAD(&port->next);
> -
>  	if (port->connector)
>  		port->mgr->cbs->destroy_connector(port->mgr, port->connector);
>  
> -- 
> 2.21.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
