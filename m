Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6259C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 21:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC15C20818
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 21:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neEOr/Xh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfKLVL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 16:11:56 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35155 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfKLVL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 16:11:56 -0500
Received: by mail-wr1-f65.google.com with SMTP id s5so9045808wrw.2;
        Tue, 12 Nov 2019 13:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TH0pQYUJAlU7IsOFtdmL7+pSDQHhMRdnIPSaufyDmy8=;
        b=neEOr/XhAjqS2x9v3RgYw6pa2yydP1Q9JSSiLlWFJIxTYLEOLa7mLOTKIl4yhff0jk
         RTpE4J1jRRQ+eHTi6JZsc24l2Ta2bLpMVWmIbTq3dhhi+L7FoDbZm/sOJ3i4rAsyRdDX
         V94VvherLU5TtlZ1ae6EgELdAjwKNl5FCOxABoxwuU98Wt1cEx/ikbcVoxxXx80UPkBg
         hslzLRk+Jc7IbTilicRxneNTDKgQeX2X4A/bUwXN/cpEXqn26xebQHebyNr+1DqzjnFX
         maUbHtdjsdndpPIDgJqQv9CZZcC/X9Z18TeuE29qzO5/xQ2mQpd1qbEQkK6X2pAIPFtg
         q8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TH0pQYUJAlU7IsOFtdmL7+pSDQHhMRdnIPSaufyDmy8=;
        b=BYWXgYFHSCB2KS/We1XIjUMXYBb8yWoHnHjK3o+H5plo8aZpc4lsP65webZimGnV4b
         50nXQnnzpAvCVY2miJz9kdHSwvWCDvIOg9Qll3r111E+F1aUGT7s36EqXVbWMSrKlPNa
         x2OTIKfkd/TDNW/NqhUO78UgPDdz+MJmmbLjCec1jBOsCvzP/Y6H3uCnJjsYVQNQXBxL
         l6f73chXLrGdPf2c4blPpAK4K54lMjtKWIjUo/Ha0U7Aw+0Pbrwsn389HosmCEcjUNYB
         IpiRrzPfrSuqgp3xmdrFTsWO+nEpgpK8zl+F+3onDpjCvuGtWYSVW/rVFaB5V+sj95R0
         H+2w==
X-Gm-Message-State: APjAAAXdzRR8K9PUGXg3fC1NdELAL/IUhO8F+jn4T/b2Kdn6/5xjbMgC
        6l/BurnnReOThfUo1EkNz7xxs4hy4wc=
X-Google-Smtp-Source: APXvYqwPC9fJ42i5AXA+/+UZDEXTSIrJcX9xrFP4nukTIBnH0H3uUwx3Qpgyd/akL0iH1VkPpPpGGw==
X-Received: by 2002:a5d:660b:: with SMTP id n11mr28661241wru.146.1573593112312;
        Tue, 12 Nov 2019 13:11:52 -0800 (PST)
Received: from localhost (ip1f113d5e.dynamic.kabel-deutschland.de. [31.17.61.94])
        by smtp.gmail.com with ESMTPSA id r15sm224436wrc.5.2019.11.12.13.11.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 13:11:50 -0800 (PST)
Date:   Tue, 12 Nov 2019 22:11:48 +0100
From:   Oliver Graute <oliver.graute@gmail.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        =?iso-8859-1?Q?S=E9bastien?= Szymanski 
        <sebastien.szymanski@armadeus.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/3] dt-bindings: arm64: fsl: Add Variscite i.MX6UL
 compatibles
Message-ID: <20191112211148.GF20321@ripley>
References: <1573586526-15007-1-git-send-email-oliver.graute@gmail.com>
 <1573586526-15007-4-git-send-email-oliver.graute@gmail.com>
 <CAOMZO5Dwt6yJ45gE91opUf3nNx24AG00Lk1KPLJ_7Z4F0os7zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5Dwt6yJ45gE91opUf3nNx24AG00Lk1KPLJ_7Z4F0os7zA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/19, Fabio Estevam wrote:
> Hi Oliver
> 
> On Tue, Nov 12, 2019 at 4:22 PM Oliver Graute <oliver.graute@gmail.com> wrote:
> >
> > Add the compatibles for Variscite i.MX6UL compatibles
> 
> You missed your Signed-off-by tag.
> 
> Also, you should remove arm64 from the Subject line as this is a 32-bit SoC :-)

thx, you are right I messed thinks up. Because I also working with
another 64-bit SoC in parallel.  

I'll fix it soon

Best regards,

Oliver
