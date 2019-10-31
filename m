Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B493DCA9ECF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81AAE2080F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572527036;
	bh=jgcUqfyJ9Vc1K6JhIpHGG9TMI2W4z/QM29anylCoXU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SxHV+vH0BK+rtSOTfnp60SmcyP8OPnqwvW9i1xIIi0z7f2KeFm2KvhHvI3ztnLG22
	 BnmyPEU6ylF1X0VSg27R1tAfwn6yychEgoj3C1F6/3toNmRdx975QDru57nufG7ORj
	 WqVcygNGw9hq9FsJm0XppovhBrOg7/rrUkObd6GQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfJaNDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 09:03:55 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42444 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfJaNDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 09:03:55 -0400
Received: by mail-ed1-f68.google.com with SMTP id s20so4694003edq.9;
        Thu, 31 Oct 2019 06:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+PQJyexbtnGDK2uJq7K6j7gmpF2unU6d9dx98JUUEas=;
        b=AojeMhBWYJS97cErx3m68443NdswQ3IeevaeKl+AdmSKwPek1vzKfXyWv+/EEU3+1C
         7q1lVjCo5Qmo1IYYysSgCsORoB22iALbcLM447LO8Trr2Vpa++ywZgLLSngMrFXhqWFe
         NIGq2lejBGmiDWkRldqudamW4x4C1obGtLTxnF/WdzhNpydoLRTecR1weYXbqndvx3Ev
         1w0O0xpruA70AUrtDuTsgop2Y/C/Cal+DwF9GXpxNCeWdRY8KXSiVUehMgFwJytSaRq7
         Dumgy4skKHLE8mY1mm0IjUknU1B2Z4y/s2j1d20KmNX4GNebKhQNztL1h+w7jp6c4DOG
         yXXg==
X-Gm-Message-State: APjAAAUgGqww/XWebDCVXCXKPOD4OGBCxTDkA2SJQxXuTatxTquPCMlP
        zRPdMICmtj20ZBvAMbFoDvI=
X-Google-Smtp-Source: APXvYqzN1wPdv61svA4m7DqM1igoTJ4AGX/nNpkJSYDUyg2S+Rlm9iUoqctcZfZGzWGx1r79/34yEA==
X-Received: by 2002:a17:906:1f8b:: with SMTP id t11mr3797383ejr.191.1572527033117;
        Thu, 31 Oct 2019 06:03:53 -0700 (PDT)
Received: from pi3 ([194.230.155.180])
        by smtp.googlemail.com with ESMTPSA id c15sm86411edl.16.2019.10.31.06.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 06:03:52 -0700 (PDT)
Date:   Thu, 31 Oct 2019 14:03:50 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/11] ARM: dts: imx6ul-kontron-n6310-s: Move common
 nodes to a separate file
Message-ID: <20191031130350.GB27967@pi3>
References: <20191029112655.15058-1-frieder.schrempf@kontron.de>
 <20191029112655.15058-4-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191029112655.15058-4-frieder.schrempf@kontron.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 11:27:51AM +0000, Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> The baseboard for the Kontron N6310 SoM is also used for other SoMs
> such as N6311 and N6411. In order to share the code, we move the
> definitions of the baseboard to a separate dtsi file.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>  arch/arm/boot/dts/imx6ul-kontron-n6310-s.dts  | 405 +----------------
>  arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi | 414 ++++++++++++++++++
>  2 files changed, 415 insertions(+), 404 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

