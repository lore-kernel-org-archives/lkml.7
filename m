Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32963C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71580206EC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GpRaz3Wz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbfKMRQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:16:52 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46796 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfKMRQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 12:16:51 -0500
Received: by mail-lf1-f65.google.com with SMTP id o65so2567607lff.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 09:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tbmpc8I08dUNbz0TweIhlLBpMYWo1Ddtf0bugPdpg4o=;
        b=GpRaz3WzKyv4b6el90Iz4gY68k6ZMkDSEh2Hm5M0XVO2GvGiQXYLuOeRblysRbV95O
         /o9QxM7Dr9VjPZHJbmlPD+v+xOjqiSGlLuBd177bF9Y5icVTpiZRrTKok3ZZTQ/wDtBz
         OD0/VdGCoCIgoImm/TAEY+RuYIVJBGoif7u3rV8vKwf2bmxMkH46wFW8r/B8lLgHUY/j
         AYfLYXuLFlbVDpa/kxWt9gdsZixvnBRgFarHNgasLVY1VE/8+aqZM1tiw/DA61fKvNnp
         rwq1i9Eyg15IRctXukzSqaoYhr16QJbzTuSfXkLs7LUDp3Zvi+TCTQ1gaTePQTg2eWA7
         0sHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tbmpc8I08dUNbz0TweIhlLBpMYWo1Ddtf0bugPdpg4o=;
        b=K7UVAyDEtJgvzUodH7IFOrAQ9DAZSlaUuF3XeLN0GdSdWimNaG8nEYhyCPsE08juhh
         63B1QVMDReH6/TQRO/R7AQ5OVB5nEKEpdCSlR98eEL1ikf0uyayLdbyqAxTdEik3vzU6
         JNwTQMu2CMIAcMtmGfxAMzZBELWWw8kOEepOl/s2vjFZVo0SpDDmsTg6I13lPqQ7E18A
         bX8pKJcVizq8Pmd88OwwtwTM76nxm14CfF5n88wlz3xsT+pfkjMbi4bDVy1+NqPcJIy2
         Za+Gu7cJGqkbaokcIv834t8YCtneVOMjcPWYGhlzGHLaW/Dv0WyjGweTAy/tfQRO1p37
         ygmQ==
X-Gm-Message-State: APjAAAXxMbw+tNA8GKztctsofr1ODf6hfRkvckiPVYxRfuB9lMW+dLHP
        Rh+l6duEqTusrQedml+vgqQg5Y9QcH7kECa6ELrHzw==
X-Google-Smtp-Source: APXvYqzIPzbgpPUyvUtrneet0HOhaTTyNY9TeCNaIXTIuQ/Kcp/SiKtz7hsji0MJix60noP5lG6p8beaOSZpn4+OlKA=
X-Received: by 2002:ac2:4a8f:: with SMTP id l15mr3446808lfp.5.1573665408550;
 Wed, 13 Nov 2019 09:16:48 -0800 (PST)
MIME-Version: 1.0
References: <20191113094256.1108-1-peter.ujfalusi@ti.com> <20191113094256.1108-6-peter.ujfalusi@ti.com>
In-Reply-To: <20191113094256.1108-6-peter.ujfalusi@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Nov 2019 18:16:37 +0100
Message-ID: <CACRpkdZ=xM2GYTDDLKoFwwdqp09-UDOyqogDW5pLvg4QaZXR6Q@mail.gmail.com>
Subject: Re: [PATCH 5/9] spi: pl022: Use dma_request_chan() directly for
 channel request
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, radu_nicolae.pirea@upb.ro,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andi Shyti <andi@etezian.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 10:42 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:

> dma_request_slave_channel_reason() is:
> #define dma_request_slave_channel_reason(dev, name) \
>         dma_request_chan(dev, name)
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
