Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96A1C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D0352075B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zi+4AOGq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfFEGtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 02:49:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39370 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfFEGtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 02:49:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id x4so18222986wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 23:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Aa9SiEOP57dMUPIPXZ4uRkPtqSgf6jJ4AGTncZG28+8=;
        b=zi+4AOGqVMCKl+mid40KDQdfPs+xU211Ce0sh8e2CuDwew50rwR7HmE9RNsXOpW38J
         7nnLm9odQTjC/LvSmcEj3vtRmQ0dK+u2BHtiWxamIssDnHEsuvkR9OdSBvkKwltKKILD
         YIqkE3sdv4UGDkYJIfhmh2vYVKOLpEXRD0bEV1YB3GAZlTQZpLJApMRHd+Knh2tb3kYv
         Tr/5XLuDlozOjb/5OGBOh2EDP71Ysw9vzOHMeSQZmoveZpw1Oo3LEEgP16hPmkbb+nQ0
         Ur+k/LHdXxpVmQJLDfgoejyaW6uiZdPgGrfWtIcaet7s1PmOmI2b5Y1NW8XHmSTPZMqh
         SEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Aa9SiEOP57dMUPIPXZ4uRkPtqSgf6jJ4AGTncZG28+8=;
        b=gHt32h7LMHI7a3iZHwhEAxG6l1wWqmGDZ+K5wawQKbh0YacEsKd1QfV5gIt+CxeGfY
         GWQktGgWj3LKMNrdDxTgLZrRSg8xwVWhW+wJOogJLZYTqjGba20Oo1DpdbxxvoOJFoqV
         CyF5IdXQfJG8OeSSJCe9fse1VN8KvmMHywK/RPh5+8lGvRZSDK0oO3iUfSGFCoAFnmh3
         7jv8qb6RN5f7Srier6x6LGOcXp/n4XWWjwWku26HCP6s8sBOvYktxmsoCX/BeDm1H5U3
         35gRRRWS++PbkmZ0H+1dR9ntGT6dgyr3vSH3zxZOx09LDqBQDO3nL1hihOF9q4oXXbG2
         ap8g==
X-Gm-Message-State: APjAAAWAjytVsR7yP9aHTc/mQ5UuygFrIxbLVRS2p6m0yEyG42ZTeq7O
        TRhq4CmkJsewK2qoG8rBUM8efw==
X-Google-Smtp-Source: APXvYqwajN0uRRCoaJnBR/tXaECbZNfMRnmng7+jNtUyT+LwmBN5T6WdLNxU3OssrQaDRvfxZEYoPQ==
X-Received: by 2002:a5d:6406:: with SMTP id z6mr8042948wru.87.1559717390470;
        Tue, 04 Jun 2019 23:49:50 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id s9sm17126517wmc.1.2019.06.04.23.49.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Jun 2019 23:49:49 -0700 (PDT)
Date:   Wed, 5 Jun 2019 07:49:48 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Claudiu.Beznea@microchip.com
Cc:     bbrezillon@kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, thierry.reding@gmail.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [RESEND][PATCH v3 0/6] add LCD support for SAM9X60
Message-ID: <20190605064948.GI4797@dell>
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

On Thu, 25 Apr 2019, Claudiu.Beznea@microchip.com wrote:

> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Hi,
> 
> These patches adds support for SAM9X60's LCD controller.
> 
> First patches add option to specify if controller clock source is fixed.
> Second patch avoid a variable initialization in atmel_hlcdc_crtc_mode_set_nofb().
> The 3rd add compatibles in pwm-atmel-hlcdc driver.
> The 4th patch enables sys_clk in probe since SAM9X60 needs this.
> Specific support was added also in suspend/resume hooks.
> The 5th patch adds SAM9X60's LCD configuration and enabled it.
> 
> I took the changes of this series and introduced also a fix
> (this is the 6th patch in this series) - if you want to send it separately
> I would gladly do it.
> 
> I resend this to also include Lee Jones for pwm-atmel-hlcdc changes.
> 
> Thank you,
> Claudiu Beznea
> 
> Changes in v3:
> - keep compatible string on patch 3/6 on a single line (I keep here a tab
>   in front of ".compatible" to be aligned with the rest of the code in
>   atmel_hlcdc_dt_ids[])
> - patches 4/7 and 3/7 from v2 were applied so remove them from this version
> - add a fix for atmel_hlcdc (patch 6/6)
> 
> Changes in v2:
> - use "|" operator in patch 1/7 to set ATMEL_HLCDC_CLKSEL on cfg
> - collect Acked-by, Reviewed-by tags
> 
> Claudiu Beznea (4):
>   drm: atmel-hlcdc: add config option for clock selection
>   drm: atmel-hlcdc: avoid initializing cfg with zero
>   pwm: atmel-hlcdc: add compatible for SAM9X60 HLCDC's PWM
>   drm/atmel-hclcdc: revert shift by 8
> 
> Sandeep Sheriker Mallikarjun (2):
>   drm: atmel-hlcdc: enable sys_clk during initalization.
>   drm: atmel-hlcdc: add sam9x60 LCD controller
> 
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c  |  18 ++--
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c    | 120 +++++++++++++++++++++++-
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h    |   2 +
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c |   2 +-
>  drivers/pwm/pwm-atmel-hlcdc.c                   |   1 +
>  5 files changed, 132 insertions(+), 11 deletions(-)

Why is this being sent to me?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
