Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF5AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7252E2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="HAoOe27A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbfCKSuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:50:11 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35152 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfCKSuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:50:11 -0400
Received: by mail-ed1-f67.google.com with SMTP id g19so202698edp.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 11:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=e3UhiD6SSnjH+5rLVFWi8sAHS+Yf96/mkMHo2uEeVN8=;
        b=HAoOe27ANY9WfIMiiuJdlM0uwR4U89YPyukJhTiHL4+RvT5jvpmLVHxIrL7OMJiR4K
         DtjoC6sc3IfKZBgPPTZzCP8hK/rFKPzV8JQ+tO7G5sAYq3SUvEYmxYECVTvsyIUXPa3f
         2r5q5OwLZaRuF78l8tv4ZXd3wYXI5bS/s+o+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=e3UhiD6SSnjH+5rLVFWi8sAHS+Yf96/mkMHo2uEeVN8=;
        b=IfD75nrDJKdFTL65y5ycv7ej4e0PjDw3NxN0XYGhtfQAmeVJrD5sbHCOJjH3EX45Uw
         fA2rDfB9d75H4ZjzEw+2mpx3X6Id3fIlmwI5dOdP1vsXB2bV/XzbSZnvg4O28ohV7i0R
         zxgB/wVKBWL8yki2l4YLCeLNDnXFHB4ldFren7gMrbAhWIFM7IzrVoT2FNf4NQxMW3c7
         zjtkf/3IwsHrCi2FfxXoxuO4DWgsh0h8bT1FSjVvmhQK2tDSTHjMLaSDCvI+24+HZw+7
         qZLRXZRlfLffvE3riq/RbLxQR3vQAm4PuWogIa3KCtz6SRkCUlT8F+RFODDUOXdQR05m
         RqSQ==
X-Gm-Message-State: APjAAAXIL1lg+d1ZEuxtgeHClTgzGHACotOruVBY8U6MIJoOtciswMaA
        yi7jt5FhReqURDUI908VE2688ofs7iaNXA==
X-Google-Smtp-Source: APXvYqwrAm5UnHwBrjL/t0kcqZSNQVoEaFCABcPBu2UBMHvHbxlEhG++BqXs1Kpjivy/C1iYTorXYg==
X-Received: by 2002:a17:906:57c5:: with SMTP id u5mr23168636ejr.16.1552330209689;
        Mon, 11 Mar 2019 11:50:09 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id w9sm1397873edq.71.2019.03.11.11.50.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 11:50:09 -0700 (PDT)
Date:   Mon, 11 Mar 2019 19:50:07 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     David Airlie <airlied@linux.ie>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vkms: Remove useless call to drm_connector_register()
Message-ID: <20190311185007.GP2665@phenom.ffwll.local>
Mail-Followup-To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20190310212241.4fsqejz5rlnp7m2k@smtp.gmail.com>
 <20190311132938.GG2665@phenom.ffwll.local>
 <20190311180004.6wljdhyhkmn66lpi@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190311180004.6wljdhyhkmn66lpi@smtp.gmail.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 03:00:04PM -0300, Rodrigo Siqueira wrote:
> On 03/11, Daniel Vetter wrote:
> > On Sun, Mar 10, 2019 at 06:22:41PM -0300, Rodrigo Siqueira wrote:
> > > The function vkms_output_init() is invoked during the module
> > > initialization, and it handles the creation/configuration of the vkms
> > > essential elements (e.g., connectors, encoder, etc). Among the
> > > initializations, this function tries to initialize a connector and
> > > register it by calling drm_connector_register(). However, inside the
> > > drm_connector_register(), at the beginning of this function there is the
> > > following validation:
> > > 
> > >  if (!connector->dev->registered)
> > >    return 0;
> > > 
> > > In this sense, invoke drm_connector_register() after initializing the
> > > connector has no effect because the register field is false. The
> > > connector register happens when drm_dev_register() is invoked.
> > > Therefore, this commit removes the drm_connector_register() from
> > > vkms_output_init().
> > > 
> > > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > > ---
> > >  drivers/gpu/drm/vkms/vkms_output.c | 6 ------
> > >  1 file changed, 6 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> > > index 3b162b25312e..a6cee4c279c2 100644
> > > --- a/drivers/gpu/drm/vkms/vkms_output.c
> > > +++ b/drivers/gpu/drm/vkms/vkms_output.c
> > > @@ -71,12 +71,6 @@ int vkms_output_init(struct vkms_device *vkmsdev)
> > >  
> > >  	drm_connector_helper_add(connector, &vkms_conn_helper_funcs);
> > >  
> > > -	ret = drm_connector_register(connector);
> > 
> > Yeah that's only needed for connectors added when hotplugging at runtime,
> > not for connectors which are created at driver load time.
> > 
> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > 
> > btw same issue exists with the drm_connector_unregister, that's also not
> > needed.
> 
> Thanks for your review :)
> 
> Should I send a V2 that also removes the drm_connector_unregister()? Or
> should I send it in a separated patch?

Either is fine with me. Either has my r-b.
-Daniel

> 
> Best Regards
> 
> > -Daniel
> > 
> > > -	if (ret) {
> > > -		DRM_ERROR("Failed to register connector\n");
> > > -		goto err_connector_register;
> > > -	}
> > > -
> > >  	ret = drm_encoder_init(dev, encoder, &vkms_encoder_funcs,
> > >  			       DRM_MODE_ENCODER_VIRTUAL, NULL);
> > >  	if (ret) {
> > > -- 
> > > 2.21.0
> > 
> > -- 
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> 
> -- 
> Rodrigo Siqueira
> https://siqueira.tech
> Graduate Student
> Department of Computer Science
> University of São Paulo



> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
