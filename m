Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791C1C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 15:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7132133F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 15:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="eFlhJjrc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfHNPF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 11:05:28 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40920 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfHNPF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 11:05:27 -0400
Received: by mail-ed1-f66.google.com with SMTP id h8so22061616edv.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 08:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=YxKKl2+ta7DCrBjwxKfDaOLOlVGeS7FS1r5qqRf9Yzw=;
        b=eFlhJjrcaVLUFfvD+Ziul+v9iGSYRnCw8JhZxJuIuCUq5BLTzN2aprorJK+Zgm5Dom
         vJHpvWlwR0PILuTSyvFXRnnHviVZwXGayxbj5KmUgJCX6ZJFFQTULeph0R9nNZRNBkO2
         lR7F5D6DkLb/6WuKZEpQf9jVfO7pG+CeNLi7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=YxKKl2+ta7DCrBjwxKfDaOLOlVGeS7FS1r5qqRf9Yzw=;
        b=uNSPRkSSx1yTRDwa3dvn8g+qy8m9lq7OfZEsisURhIWwUTMO1VCsmdwcuMz6eAYjoP
         T5wE+Gd0xrEWD39En3Xn44w+HMbBH/Rgx6ke4iLiaDf/4FavTN30YKAUOzHkdeOjSpMv
         3D2ND+44nFpuMQRjHbBorKZp2tNeBilsNrPhFY89IH8TidLmuCpcTuUsGOuRIfc1i7pe
         T6YkjSYXaqf6KiQQBchhOa/AkKCaqYsMiwzTevOlX9dtkopgtUPAoNDUMA7KHwyXJpau
         p13e+EEK4m8LKqVOnhp1mK4Po8DZOHEXD2I7xAFFGVJnydA4pCCi+8BITkUeuCcCM/1p
         Dl8w==
X-Gm-Message-State: APjAAAWZr5eyWUYNyRYJFiuSNUSvyv2bJgvJHjW2HN+0vL2ooAobdaPc
        9mykmth2YYjvQVffZpJtvM/uxw==
X-Google-Smtp-Source: APXvYqyoqDqttrUFCa8gHGrAixJ9GL/dnreYE3IQnI01ouKzd8sNF9P/k0lURlw5zbckNgXnaWIJnw==
X-Received: by 2002:a50:ce5a:: with SMTP id k26mr43298edj.218.1565795125918;
        Wed, 14 Aug 2019 08:05:25 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x10sm8663edd.73.2019.08.14.08.05.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 08:05:25 -0700 (PDT)
Date:   Wed, 14 Aug 2019 17:05:23 +0200
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
Subject: Re: [PATCH 08/26] drm/dp_mst: Refactor
 drm_dp_send_enum_path_resources
Message-ID: <20190814150523.GH7444@phenom.ffwll.local>
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
 <20190718014329.8107-9-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190718014329.8107-9-lyude@redhat.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 09:42:31PM -0400, Lyude Paul wrote:
> Use more pointers so we don't have to write out
> txmsg->reply.u.path_resources each time. Also, fix line wrapping +
> rearrange local variables.
> 
> Cc: Juston Li <juston.li@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index ec6865e1af75..57c9c605ee17 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -2350,12 +2350,14 @@ static void drm_dp_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
>  	kfree(txmsg);
>  }
>  
> -static int drm_dp_send_enum_path_resources(struct drm_dp_mst_topology_mgr *mgr,
> -					   struct drm_dp_mst_branch *mstb,
> -					   struct drm_dp_mst_port *port)
> +static int
> +drm_dp_send_enum_path_resources(struct drm_dp_mst_topology_mgr *mgr,
> +				struct drm_dp_mst_branch *mstb,
> +				struct drm_dp_mst_port *port)
>  {
> -	int len;
> +	struct drm_dp_enum_path_resources_ack_reply *path_res;
>  	struct drm_dp_sideband_msg_tx *txmsg;
> +	int len;
>  	int ret;
>  
>  	txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
> @@ -2369,14 +2371,20 @@ static int drm_dp_send_enum_path_resources(struct drm_dp_mst_topology_mgr *mgr,
>  
>  	ret = drm_dp_mst_wait_tx_reply(mstb, txmsg);
>  	if (ret > 0) {
> +		path_res = &txmsg->reply.u.path_resources;
> +
>  		if (txmsg->reply.reply_type == DP_SIDEBAND_REPLY_NAK) {
>  			DRM_DEBUG_KMS("enum path resources nak received\n");
>  		} else {
> -			if (port->port_num != txmsg->reply.u.path_resources.port_number)
> +			if (port->port_num != path_res->port_number)
>  				DRM_ERROR("got incorrect port in response\n");
> -			DRM_DEBUG_KMS("enum path resources %d: %d %d\n", txmsg->reply.u.path_resources.port_number, txmsg->reply.u.path_resources.full_payload_bw_number,
> -			       txmsg->reply.u.path_resources.avail_payload_bw_number);
> -			port->available_pbn = txmsg->reply.u.path_resources.avail_payload_bw_number;
> +
> +			DRM_DEBUG_KMS("enum path resources %d: %d %d\n",
> +				      path_res->port_number,
> +				      path_res->full_payload_bw_number,
> +				      path_res->avail_payload_bw_number);
> +			port->available_pbn =
> +				path_res->avail_payload_bw_number;
>  		}
>  	}
>  
> -- 
> 2.21.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
