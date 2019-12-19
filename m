Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035B0C2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49402465E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576786424;
	bh=71MW+VSyG7Xukp6U+TvDjG3AJdQqfYOPz/fAClsc5r4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p60RBxmdy76HFAntTYN+rni6bSZQZB+mpRd2I0GC0dmjKaXf3WTgAu/x4gGBp1+fq
	 j6i20kyVKL2/m1pczi26nkpaUlBK8+i+AyTTySjZTxBnieA94lmljVeMoJkfUqQK+2
	 bm6CPFzNdyU8duUwpuKNgsLG9kOcS3w+gGsZ7dpk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfLSUNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 15:13:43 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41431 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfLSUNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 15:13:43 -0500
Received: by mail-ot1-f67.google.com with SMTP id r27so8669765otc.8;
        Thu, 19 Dec 2019 12:13:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:content-language
         :user-agent;
        bh=2exayYeaNZtgQGFmqcZGnZK76NHNb4vFc7u1qrZvIf0=;
        b=foye8m9XT5sO78sJFHXrswUnaxQaBBlBM422IdpUvWoGig8JFYupTSqwNwKOu7DlaO
         vQUlMbcoxv/d1izIVXAl7mz0JHZ706+mUptVgUV3tNj1Iy2oLJotNmlFapeF50JM6DKi
         W8Z/Rqy9yu9rRsYu52Ap4/5AsxNUaY8XPZaxMUMVHH/5m/Wy847JojP4p5+KVcI1pQgv
         LvZKSFtSitTLjiF16/Vct85Rpob108gmnvD8HrJ/pg/1zUUYOjTCA23uWap3cFJLmD/E
         k42DAe1v3kX7v8mZE3mpV2tOodP1bPjUmffTgMd1rk4pz4L5ui544sv94q0AXCu3KWbI
         3e4w==
X-Gm-Message-State: APjAAAWTGAam7B8ep4W/50fICMNuJjctqftaXcuFXZwSY3l1CVlef5m9
        oFuWk1KRecQ4PhiZ1UkhoA==
X-Google-Smtp-Source: APXvYqyIbNokEdgRSN9icS+W0eFCaLPDJrnwYXGGXJ6e0m0OSnKfrq3BWkt8qxc48c3/cbtWC3B/Fw==
X-Received: by 2002:a05:6830:18f1:: with SMTP id d17mr5567978otf.298.1576786422699;
        Thu, 19 Dec 2019 12:13:42 -0800 (PST)
Received: from localhost (ip-184-205-110-29.ftwttx.spcsdns.net. [184.205.110.29])
        by smtp.gmail.com with ESMTPSA id r17sm2381229otq.70.2019.12.19.12.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 12:13:42 -0800 (PST)
Date:   Thu, 19 Dec 2019 14:13:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: imx8mm: Add missing mux options for UART1
 and  UART2 signals
Message-ID: <20191219201340.GA13183@bogus>
References: <20191210141516.6983-1-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210141516.6983-1-frieder.schrempf@kontron.de>
Content-Language: en-US
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Dec 2019 14:15:17 +0000, Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> According to the reference manual and the "Pins Tool" from NXP, the
> signals for UART1 and UART2 can be muxed to the SAI2 and SAI3 pads
> respectively. Let's add the missing options.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
