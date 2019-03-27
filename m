Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC669C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BED22177E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553730406;
	bh=/vRu2Cp01wKkvgSPO9ehViu3HPHJB4DJR44emvKa7xM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DYVikCY+CnKtLm9fr22mdQWqXodU76Oi3u4aycUiaEFEhV8KX0rhxGGYuS4wyFflN
	 isexMoVKdVm7uBziWeTnfR1SVHAqIWF8LyRbX1BzQyvEshArilM+OYK/QR9zV1E3DL
	 IPjOwMFMHQFsOhvzk1YtYLkv7Ql0aOvTkOpHJpkA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387668AbfC0Xqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:46:44 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38286 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbfC0Xql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:46:41 -0400
Received: by mail-oi1-f196.google.com with SMTP id w137so14359644oiw.5;
        Wed, 27 Mar 2019 16:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nRkh3JyGRKrv1S0DM23KOqhAgJpc9dHWvKG/HZWzlw4=;
        b=bV3IEgGjYeF/HJ681EKJA6WkESWOIQ1KMwTv8X4R/xv/900mbcrv4E/M4znjAJovaR
         kJ3jutPgvuZdyRR4py3D3qzNa8kgGWGVq49bv4T1tlaDccipOdUWTFcYKSUlR0W/I0F1
         bCHowoLsPmXqqzU0R8GBwPZSmdwdA8L+51loh6PLWB4NLZWY66Urp2MHAY7PYSyZtnNY
         30tBV9rREIYPYmLqpQlRlqj55/rG/o+s79fz2QyTlcRaBa6ciccPGIB7Z2WzlIsO123I
         Ut7MO909dwwJrsFjN1ObadCW8Pguiuok016r3PrEDVN9YC3ljtVWLucABfzh51SEoeXB
         pTJQ==
X-Gm-Message-State: APjAAAULx2DKYOZu/0HMWEMLTy7J/+ho5v/z1mbTXO5ueOn8Lt8y/0oy
        jMSzccaw4b+anLdiZij+cw==
X-Google-Smtp-Source: APXvYqyG4fMWDzw47ShVy4QxBFb0eqZGRs0d4G+qJbBJjB6Ioe3VLBtoG4tamlvcODFK63Wx1q2oyA==
X-Received: by 2002:aca:3f84:: with SMTP id m126mr3162588oia.164.1553730400968;
        Wed, 27 Mar 2019 16:46:40 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 66sm10506879otc.25.2019.03.27.16.46.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 16:46:40 -0700 (PDT)
Date:   Wed, 27 Mar 2019 18:46:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/3] dt-bindings: clock: imx8mq: add hdmi phy 27m clock
Message-ID: <20190327234639.GA24736@bogus>
References: <1551929772-22633-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551929772-22633-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Mar 2019 03:40:57 +0000, Anson Huang wrote:
> Add IMX8MQ_CLK_HDMI_PHY_27M clock for i.MX8MQ clock tree.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  include/dt-bindings/clock/imx8mq-clock.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
