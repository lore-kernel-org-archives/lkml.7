Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1805C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E31B20833
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C3Mju4yy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbfDBGsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:48:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44140 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfDBGsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:48:52 -0400
Received: by mail-pg1-f195.google.com with SMTP id i2so6036335pgj.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 23:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wqqhpOshfOodSZDcIGAPglJ+O3e5ZBYgiqEoT7BdCo4=;
        b=C3Mju4yyYYV/s231iRmErUBgy7w3R+44E6tTiFacEPZFTA9EupNspRRfnWXsgiReT0
         K+yhbRT7HaNHI0vrekyPCIqX9oqZENJfFAt1XIVbEouuEb3tF1rTrlSgBkwdk82lhZdM
         p6GBtGGm62JqMvZvlh/NkADOtm68YVR3S9uBGPIO/z0DxlWP9UeOls6POaR69eCoO3up
         6WdtnuOnfyjQmil2SYqh6RWUKjfgraB2iySzU13QNR/5OVdttmg4A2t34/L7OXadyDi2
         KiNoLQQ4vgvmrhgXpaLzodOPF1vdcW8CqPaMu0z5i9Mu4mYKGJd73NWnm2Xblpwy9eRc
         hCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wqqhpOshfOodSZDcIGAPglJ+O3e5ZBYgiqEoT7BdCo4=;
        b=IQrqp5TgU7pA31dnYQIE3VjQWDI7SvJpBYFp7/U/99V1ry2BL39fnP3wOWBBl8jK0B
         kOu3u+Qg9q16bNXz5EGUMUXsP0Rk0TG3aS6Zwdr1lytJiMpPJxoZ0WvLYCKnqgYfjmdU
         IhVyHDydpd2o5xkixdbTdbbPiGQuMDsB+Qlo9gI4iNff49NAG+x6Cad3DbCjLSxtmjKg
         Z2jFR7ISw9EJbHXxhMpyp2HN+nq899PPGv2QBBdUzVDf44wHTe7P3/sq0ggm3CaPzgdJ
         ErW85eREGVdzYkTr0blApgTcpYLjfj9qKaE0Qpk7fE7LQwA4cB0Yaro07rjN469Abn39
         1P0A==
X-Gm-Message-State: APjAAAVueK03miprXccR+OTS6irlm91GWw7Euafvb9ArvZ1R+Jvah/+g
        CLKBzoigDO8UINlDvi+xKDwYgA==
X-Google-Smtp-Source: APXvYqyddrSgIMwsV1J9ZanAa0NUJW1WXXZ+A651l1mQbU1UKhz2tfmN0n0yyJh/hu/tHG4Qv7GqFA==
X-Received: by 2002:a63:711d:: with SMTP id m29mr19511042pgc.109.1554187731349;
        Mon, 01 Apr 2019 23:48:51 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id u4sm38874820pgn.12.2019.04.01.23.48.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 23:48:49 -0700 (PDT)
Date:   Tue, 2 Apr 2019 07:48:42 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 1/9] mfd: mt6397: clean up code
Message-ID: <20190402064842.GB4187@dell>
References: <1552275991-34648-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1552275991-34648-2-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1552275991-34648-2-git-send-email-hsin-hsiung.wang@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2019, Hsin-Hsiung Wang wrote:

> clean up code

Please explain what it is that you're cleaning up.

> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  drivers/mfd/mt6397-core.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

The patch is fine though.  When you resubmit, please add my:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
