Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284D6C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 06:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E370B21019
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 06:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vrBcJWBc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfEHGXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 02:23:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40286 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbfEHGXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 02:23:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so6266312wre.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 23:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZwBzr8t2c5//Qv+vOM+zb95AmHVIIGSZXeL3Vx6exVA=;
        b=vrBcJWBcO/7Ca/wCszwmavvuoj/LUQTTspcBW80sF2q5NXECfCj1CYpRR0Ymh86esM
         wC5aqb6fneiaVB+DVT2+HxGNfDWa3GtkT1kH9mbTPsOL3+lG/aW69GuQ/pTbcH5g4MUh
         CabAQreSIZguHDS2GWNSs2NwST7dPUFl3eYZiVq5WFVK5lZH8czZyfNtyeMQstVgUxeO
         KpK6T8VKiwhONHMv++TL35cIY3w/Gi1lbyxywlaxz7DiyTOyHS5ZC26Y9IxP3igvil1k
         Km0rcqRB7vfy4uuB7sU+5XYskfOilw+t/cgTJF5i25utVk0ZPQJwOfRsdw75mHPF4RSM
         M+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZwBzr8t2c5//Qv+vOM+zb95AmHVIIGSZXeL3Vx6exVA=;
        b=ZsrV0AGWFV9m0bivuDk4SRE08zblEGEUP91rZ5eVDtmSbqr1tbQTLH0rwbleRE8mMI
         XVDApydc2ViLaymdnf0p2uKZzdPynlrr9MO1g1a3UP8+GW+H1uxFNIVcR214rHHNFTgS
         XPztJhFNBMpvP4ak+3OzG3Z7bR3zu6BvaGqN+s/EfYJwTp90eLBM13I53gfVu9Y1l1BR
         G5zBsl3OWf8bhb5e7EqV6kvHsgTKqM0wWdQTb48bPkwB/Hwl0HhWl2WNWgl8fQbj3oik
         XLYuMxga1rxjjXg1L4IqDm0PcjpPdnYlJpwosiiJfPqUX8frUFBrS8O+N2/8zZ0gNd7Y
         g/fA==
X-Gm-Message-State: APjAAAUGE07wHuvI5SUCDaPtyCD3Vnm8/gGP3roBJ/NQTAWxW5I9sJ9a
        VySKEkm2Fwx+GhIpAI1EUIw37Q==
X-Google-Smtp-Source: APXvYqyXAkfBLVqlYoyJPdjpjDrpRcXI6/fi/QgJCYsn/IaX8rp3yx2DcxxSO3Hdqj0BOr9Mlvh+HA==
X-Received: by 2002:adf:e390:: with SMTP id e16mr2475754wrm.321.1557296611983;
        Tue, 07 May 2019 23:23:31 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id b10sm1835950wme.25.2019.05.07.23.23.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 23:23:31 -0700 (PDT)
Date:   Wed, 8 May 2019 07:23:28 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Claudiu.Beznea@microchip.com
Cc:     bbrezillon@kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, thierry.reding@gmail.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [RESEND][PATCH v3 0/6] add LCD support for SAM9X60
Message-ID: <20190508062328.GD7627@dell>
References: <1556195748-11106-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1556195748-11106-1-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c  |  18 ++--
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c    | 120 +++++++++++++++++++++++-
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h    |   2 +
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c |   2 +-
>  drivers/pwm/pwm-atmel-hlcdc.c                   |   1 +
>  5 files changed, 132 insertions(+), 11 deletions(-)

Not sure why I am receiving this set.

Could you please drop me from future submissions.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
