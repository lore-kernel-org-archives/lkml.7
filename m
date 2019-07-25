Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9E9C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 02:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB18322387
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 02:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lyp35NU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389107AbfGYC0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 22:26:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33617 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389085AbfGYC0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 22:26:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id f20so12940128pgj.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 19:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rDiLShrDC8kXE/WTfd9b1UXLyI+P3zktjRDiUd/p51s=;
        b=Lyp35NU9rgi/xE9LSFdJz8ucylAhLT0GpyLYrfePckLaatp+bs/dAIBPEUj3OcZBz5
         4Lx2lPghPYXcg2qAoaSI8p/zmdsv36ZFuYW9KVIXpY5Mjy6qunX58zXV6Vron6HH1fnm
         9ullmXGJogZxip19X+ahHyzSXz5X/RX5YF78PvSIDXZMb20m3R848GDk8EVXmFfrtg2C
         glLD7B33N9tArYgV4DdYtT2Pb7Xp7C4oBSj3Gn6yOOMC00Cs+FzPmaW8MecDwSOyex7j
         j+VM6enOhfpwoSFpnWzvNd75hAIU04SsgeRto5ZwSSSnbAeJE6Hkqi6ArIsYmXzG6Fo1
         lxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rDiLShrDC8kXE/WTfd9b1UXLyI+P3zktjRDiUd/p51s=;
        b=Thrja7s4HShL/v5r/Pu7K5gmkQEZSFb3LpaNo7cJq3Tc71hz0ZIBfNlVZ/qqiHOPJg
         5ZQDCO2YR3fNiEdiiYRLA5xLO2v0diQK3pWAchpOrKL1vCJ16vgNXltGTwQVhUb07/po
         J7Gd2+ibm70BForHwXuRO78Rg3jk9LtQNN3lRjt6JO1+ohCVmM0SKqdcJAADw5C2hopg
         Je/lXCjnrIjU+nxHwV5284b6TAh6p+yEZemooeo8zFVbVbPbU2P7GJZg8zmnLwYA3MaB
         4g/T2harsGjfAWNUd0h7bRcgg7tzHCyx+58F3xzxAONLxaGTYTIs45TAESJKy5mYA+KJ
         UTSA==
X-Gm-Message-State: APjAAAVl3OzXFdbKV9ZOgcgQ0oRA723kdHOUKl8LtDeVcruaXmhTCmxB
        cjvg8CSFujhM6KJ8/A7VMRAWAg==
X-Google-Smtp-Source: APXvYqyG5lBxKIdnc+rgbPIFai7y5A3KdoVj2i2HUWnhYnSV0eT+/UbQI3E/MDXyuB7N3zQiw+L5Wg==
X-Received: by 2002:aa7:93a5:: with SMTP id x5mr14023218pff.87.1564021573878;
        Wed, 24 Jul 2019 19:26:13 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id 143sm70120417pgc.6.2019.07.24.19.26.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 19:26:13 -0700 (PDT)
Date:   Thu, 25 Jul 2019 07:56:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Anson.Huang@nxp.com
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        leonard.crestez@nxp.com, p.zabel@pengutronix.de, ping.bai@nxp.com,
        daniel.baluta@nxp.com, l.stach@pengutronix.de, abel.vesa@nxp.com,
        angus@akkea.ca, andrew.smirnov@gmail.com, ccaione@baylibre.com,
        agx@sigxcpu.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2 1/4] dt-bindings: opp: Support multiple opp-suspend
 properties
Message-ID: <20190725022611.f6dirdstu3yndcwy@vireshk-i7>
References: <20190709080015.43442-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709080015.43442-1-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-07-19, 16:00, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> Update opp-suspend property's description to support multiple
> opp-suspend properties defined in DT, the OPP with highest opp-hz
> and with opp-suspend property present will be used as suspend opp.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> New patch.
> ---
>  Documentation/devicetree/bindings/opp/opp.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied. Thanks.

-- 
viresh
