Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24B0C10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828A721906
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="iFbMATaZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfCKN3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:29:45 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39729 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbfCKN3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:29:43 -0400
Received: by mail-ed1-f65.google.com with SMTP id p27so4009285edc.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 06:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3m7ss/8c6yX1mGA4RdYg+uoBuR8oPxWQjMjvdeAjBqY=;
        b=iFbMATaZ9VfrRs7rmBD7nztMvz9zOa8Ho33R+4Ljp5m+n9chAf4IXrirJvaPqKjbg5
         yB3oUZVyJD0mW4h+J4QdmkfA6sHE75r3X2HcZ5XBcNcBCzkqQbc3WvNBgG82saWT5dkN
         aT2Fe3nZfva/3o/u217IMuW4TJKGdVnlHF/gU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=3m7ss/8c6yX1mGA4RdYg+uoBuR8oPxWQjMjvdeAjBqY=;
        b=gVURPD4Neao/rnoEyCCJj00eU7tARe7FNO2umL7beoyvtcYwfiPk5mc3VYBUshxfHH
         Ge4QoSSPIKpHawb0RP36Fs6Dl41g2ZwQLNugOyFoTbgwScUqC1NblyxQwkiQRacEPD7A
         xUNZFtgsZ60eUTCeREkE2fQCprkaVU7JPGCzvudGRdKJVQIlHUgJoLadYB8WwhXpR/Q+
         OjZVAD+5LXtn96lrarXGa/CuVOhj87pCO0V5HBK2wyk25pneyz9brvzu4MdQq1Okf5dn
         gzuhCf3pCOjmmk4htNnzah/ihlIturNZwF0JILJOo0fqOYFaNF1hAFnJzYK9VGfiOODV
         M9KA==
X-Gm-Message-State: APjAAAUGeGPAYUE02OG6BxSN5P0K3WeWmPB2VnC+19eCDFA+/A76DE1R
        KmSw1pOkINeSKKw7jVGZPKAEFA==
X-Google-Smtp-Source: APXvYqz/HpT7MeK2z09rJJ5mmHdIc0FHZcv4y9ax4XUOgcBJbr0E42DqX9/7DXOw6rWLfwUxRvFt6w==
X-Received: by 2002:a17:906:590c:: with SMTP id h12mr2809727ejq.69.1552310981121;
        Mon, 11 Mar 2019 06:29:41 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id w6sm666244eds.0.2019.03.11.06.29.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 06:29:40 -0700 (PDT)
Date:   Mon, 11 Mar 2019 14:29:38 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vkms: Remove useless call to drm_connector_register()
Message-ID: <20190311132938.GG2665@phenom.ffwll.local>
Mail-Followup-To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20190310212241.4fsqejz5rlnp7m2k@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190310212241.4fsqejz5rlnp7m2k@smtp.gmail.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2019 at 06:22:41PM -0300, Rodrigo Siqueira wrote:
> The function vkms_output_init() is invoked during the module
> initialization, and it handles the creation/configuration of the vkms
> essential elements (e.g., connectors, encoder, etc). Among the
> initializations, this function tries to initialize a connector and
> register it by calling drm_connector_register(). However, inside the
> drm_connector_register(), at the beginning of this function there is the
> following validation:
> 
>  if (!connector->dev->registered)
>    return 0;
> 
> In this sense, invoke drm_connector_register() after initializing the
> connector has no effect because the register field is false. The
> connector register happens when drm_dev_register() is invoked.
> Therefore, this commit removes the drm_connector_register() from
> vkms_output_init().
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> ---
>  drivers/gpu/drm/vkms/vkms_output.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> index 3b162b25312e..a6cee4c279c2 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -71,12 +71,6 @@ int vkms_output_init(struct vkms_device *vkmsdev)
>  
>  	drm_connector_helper_add(connector, &vkms_conn_helper_funcs);
>  
> -	ret = drm_connector_register(connector);

Yeah that's only needed for connectors added when hotplugging at runtime,
not for connectors which are created at driver load time.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

btw same issue exists with the drm_connector_unregister, that's also not
needed.
-Daniel

> -	if (ret) {
> -		DRM_ERROR("Failed to register connector\n");
> -		goto err_connector_register;
> -	}
> -
>  	ret = drm_encoder_init(dev, encoder, &vkms_encoder_funcs,
>  			       DRM_MODE_ENCODER_VIRTUAL, NULL);
>  	if (ret) {
> -- 
> 2.21.0

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
