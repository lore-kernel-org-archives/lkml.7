Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52959C47E49
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E122084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571653787;
	bh=k+fKVfyYreCqp6G4mH8/WCYlH0xNk9lCGA13oSnsVP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Y0ZxK+EF1/aPH/Cu8iIbo8uzkc0Bg7fV11nDB33M4VwiX5QTP8Ejl6Y85iW5ZlXDA
	 +XvriCFR5UrnUxN4Fo4I1T4fMKY9iIFnbb1jhIE/Fpg9VgbQ/7qUFkitRIpErONdRV
	 evEoEDJ0GranbcKk+v8E8ocUaOGILIwOY4/fUaHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfJUK3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:29:46 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33152 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfJUK3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:29:45 -0400
Received: by mail-ed1-f66.google.com with SMTP id c4so9613695edl.0;
        Mon, 21 Oct 2019 03:29:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T2kiEHki8gQHRbb/hKRBiHJ6jSiOvzHioA7z3T6/JhE=;
        b=r6+bYWMk2bg9608wUl6DHhQuVxPRo7PUaHrJ1ndG8JBUdZ/52CMfjcfXpoteYdPsj6
         muS8jjsqeGw10kLv1lm1U1Nk3xmoesGAo/1OZDLYIYK05P0CM00q7S2SzFIclLKvQsoP
         2wjWnqbQtOaddQXCIotoek1JauUYXGHEHsE1BUmP0jznan+8ijD7A/qKmi7KV2HaHFyx
         HZHIqGpyDk1YM8oe6ns7JMle4Vv+iK1skxWHxsOlK5zVzhAWf19//jXSm+tqBfrQVhAB
         6Wu5SDMAhaN3EcRj9gNd78nG6mX4opcIMzOLHI6heLO7gMWk0Fzq2iv45K4GUnHHSoEt
         ebbw==
X-Gm-Message-State: APjAAAWb8wjhiSnU0kajsR1e+A//XMOr7UenCO0wA3bnVqNJcC4iKHSh
        sL/gIX0MpLoyVEfMZx3F8Lw=
X-Google-Smtp-Source: APXvYqybsb4F9xNYHToK1I85K/GHqBT18pPOXA/5ILN5589Myyx73mLaxb72wmS/sAZ2T26vfuEd+w==
X-Received: by 2002:aa7:da4f:: with SMTP id w15mr24017636eds.26.1571653784220;
        Mon, 21 Oct 2019 03:29:44 -0700 (PDT)
Received: from pi3 ([194.230.155.217])
        by smtp.googlemail.com with ESMTPSA id j5sm629045edj.62.2019.10.21.03.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 03:29:43 -0700 (PDT)
Date:   Mon, 21 Oct 2019 12:29:41 +0200
From:   "krzk@kernel.org" <krzk@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/10] ARM: dts: Add support for two more Kontron SoMs
 N6311 and N6411
Message-ID: <20191021102941.GB1934@pi3>
References: <20191016150622.21753-1-frieder.schrempf@kontron.de>
 <20191016150622.21753-3-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191016150622.21753-3-frieder.schrempf@kontron.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 03:07:21PM +0000, Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> The N6311 and the N6411 SoM are similar to the Kontron N6310 SoM.
> They are pin-compatible, but feature a larger RAM and NAND flash
> (512MiB instead of 256MiB). Further, the N6411 has an i.MX6ULL SoC,
> instead of an i.MX6UL.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>  .../boot/dts/imx6ul-kontron-n6311-som.dtsi    | 40 +++++++++++++++++++
>  .../boot/dts/imx6ull-kontron-n6411-som.dtsi   | 40 +++++++++++++++++++
>  2 files changed, 80 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6ul-kontron-n6311-som.dtsi
>  create mode 100644 arch/arm/boot/dts/imx6ull-kontron-n6411-som.dtsi
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

