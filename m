Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5DEC4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA45C21850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="fosrfzKl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbfGEMXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 08:23:54 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42887 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfGEMXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 08:23:53 -0400
Received: by mail-ed1-f67.google.com with SMTP id v15so1460692eds.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 05:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5QgxkK2BzVl/nyok1ckc9QkZXVZfV59w8ef5yaPLIeQ=;
        b=fosrfzKlSYrojK0mZJeW01zCt1CRx0uEqtSUG1WPUH4mKDuv+wAcNyFFU5q1cWLWJS
         lKAMmmb3h6PVVRVvxpDeLu9FKPtx1WQMvWa3w6yLiGAstL4uZ5LOfCWWcMlfgo+pYZPg
         xs/lyLpzcycIvP46/HMX/x1N5cneuFLdIHoq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=5QgxkK2BzVl/nyok1ckc9QkZXVZfV59w8ef5yaPLIeQ=;
        b=dDcNRHQ2g/3gt5SNkQQ/WxMGGZ5Cz55Zy0bA9PPSvbJBQakw56Ccv5cPEQz4u6ORRw
         E6uNtPsZVQVrP0R++QNwoJtjVhxslLBAgni63pUeNQJ6RrYghwt1nq4t0ZR/M3uKz6I3
         LnnZF4qxj3AU7G39jT0+jNLDRcPPm+oXasc7qCaJp0qIWpCGPAFP8yWN6DPx91cLYcBA
         Kup/cGVUFZRR/o3OfFPAXh6xQV8GFCbLmu1N6Ou21LDccL0yXepSxdygoyMPS5pVCBa4
         Y/SHz4Q/hjX9uVVp/ckyDT8Q6s6GfNfCa2IWqruUQec2nIMCcrhGuLmVXttI4+2rOGsh
         v9VA==
X-Gm-Message-State: APjAAAVWcXdqPk9t7dXjp5kFYXhvwfoC+DdChq9iF8k1sbSrc24ER8zY
        gu14VRyr25x4Iw17mubcabPgcA==
X-Google-Smtp-Source: APXvYqx0a1gWOtWT9/MpcV/1byNvLxzqfYN5lsb63pRNcON6/Uz//6V/QxiEEP7duzFtvD/7Xmnsrg==
X-Received: by 2002:a50:b566:: with SMTP id z35mr4279907edd.129.1562329431964;
        Fri, 05 Jul 2019 05:23:51 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id w14sm2648879eda.69.2019.07.05.05.23.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 05:23:51 -0700 (PDT)
Date:   Fri, 5 Jul 2019 14:23:48 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Cc:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>, nd <nd@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ben Davis <Ben.Davis@arm.com>
Subject: Re: [PATCH 1/2] drm/komeda: Disable slave pipeline support
Message-ID: <20190705122348.GN15868@phenom.ffwll.local>
Mail-Followup-To: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>, nd <nd@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ben Davis <Ben.Davis@arm.com>
References: <20190705114357.17403-1-james.qian.wang@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705114357.17403-1-james.qian.wang@arm.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 11:44:16AM +0000, james qian wang (Arm Technology China) wrote:
> Since the property slave_planes have been removed, to avoid the resource
> assignment problem in user disable slave pipeline support temporarily.
> 
> Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@arm.com>

I guess the way you have to enumerate the planes listing the slave planes
wont just automatically work in any fashion and force a lot more fallbacks
to primary plane only. At least until virtualization of plane hw is done.
So makes sense to outright disable all the slave plane stuff for now. And
I think it's ok to keep all the code still, we'll use it again.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_crtc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> index f4400788ab94..8ee879ee3ddc 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> @@ -481,7 +481,7 @@ int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms,
>  		master = mdev->pipelines[i];
>  
>  		crtc->master = master;
> -		crtc->slave  = komeda_pipeline_get_slave(master);

This might cause an unused function warning, might need to annotate it
with __unused.
-Daniel
> +		crtc->slave  = NULL;
>  
>  		if (crtc->slave)
>  			sprintf(str, "pipe-%d", crtc->slave->id);
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
