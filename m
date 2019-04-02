Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3C5C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1AEE20833
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BXMdBVBB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfDBERR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 00:17:17 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42705 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfDBERR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 00:17:17 -0400
Received: by mail-pl1-f196.google.com with SMTP id cv12so5562439plb.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 21:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BliaVXaQMgn/MWMbXVTwZFVurSNeZYVMFFT4yt3N+RU=;
        b=BXMdBVBBdLW+giRXZioZhfr//ikAYk47u2FOf3sBeJOeaFmtXa5fpX3GxC4E98PDEG
         c774zLuKOIyKNsqgdgEnBcAZxDpdZgVVSU+ELr9M1/4JukCOZdIkw7EW+NTC+IcUGxNq
         eiKxmVA0AcDUykpBQZt13Sdg9dHPSQ2xNgJm7mVrCUqMXNeKX3wrN8Y1+o3bX4dePf5f
         7RYZgaKHhRRK7fS5yypjBp2XB6yKLC491VN8j+UsZKN0QtJXh+1Oz3++K4W0iyaEiq6M
         Y99wDNMlAesmveK5kShAxAx4vucokbMg++K9fbSYqdSMonBGjgg6rt4NfVsb4vK9gS+K
         B3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BliaVXaQMgn/MWMbXVTwZFVurSNeZYVMFFT4yt3N+RU=;
        b=k8VPs+/LHmmRGKGYbS/7oOv5MhT7wwJMI1VdJVMrIuFghicD1CMatkzAYPUd/drH6B
         EDeTNvijPIgK2pl8dBBx337mi++Pc8bfSZ5DfatFTZ53rvAXp2/EzpRq6vacAxtiVWHt
         CynVXUxKsCdn0dW6dklU2thNSE+pX40MR2ATn/Nkrm/c1+J19G0Fynzt/UJ7FkRrG2Gm
         Ern4aw2ubRAZesgKbZYCMazn+DmCUhGhvbF2WfvwSKkKfZDi3j2rXheZm6eMySfvF8RH
         L3bXoSwwX1k0PB1I+vrFtODi3OBhzXn96jZ9m7OjNYy1u/357oWKhn79wVxcRpN/x8ed
         9hXg==
X-Gm-Message-State: APjAAAXHnY1sxcTvNELbnYQKoBdrISBlhoOcrGJTo65K2v4wCFw5XKue
        WdL5skHgohX1DFGi0PDbJ8p0Iw==
X-Google-Smtp-Source: APXvYqxe8c4kuGrS9QUSc7Nwkmplw0p9QPq/CLWdz8HOiMbCORA6HznrVyo+LBqOjIBn4TCmalanxw==
X-Received: by 2002:a17:902:d24:: with SMTP id 33mr67894844plu.246.1554178636259;
        Mon, 01 Apr 2019 21:17:16 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id u4sm37032827pgn.12.2019.04.01.21.17.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 21:17:15 -0700 (PDT)
Date:   Tue, 2 Apr 2019 05:17:07 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Claudiu.Beznea@microchip.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, bbrezillon@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, thierry.reding@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 4/7] mfd: atmel-hlcdc: add compatible for SAM9X60 HLCD
 controller
Message-ID: <20190402041707.GO4187@dell>
References: <1551780434-4580-1-git-send-email-claudiu.beznea@microchip.com>
 <1551780434-4580-5-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1551780434-4580-5-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Mar 2019, Claudiu.Beznea@microchip.com wrote:

> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Add compatible for SAM9X60 HLCD controller.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/mfd/atmel-hlcdc.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
