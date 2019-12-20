Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAC9C2D0C8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 22:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4464021655
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 22:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576881914;
	bh=ELiLbuJ/+iqHkBkUwX1DqkEECcnxmdK5U5vpZfCDx4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UBXg/sJRZ4V+217EBtoUs8gHts+TrztTMO/EkaxC+mj6xxyqVsnA/pou9YX4ZjuEF
	 XISD0By+3Fls9MKllqS4QAYuoxzPwN3++2N+MqAiGBesFPK2EHaj+1mO7LF3TxWrqH
	 URFLQIynSRpWQDi2spvy2KTdl5p1Hes5KrD9YehY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfLTWpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 17:45:13 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37690 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfLTWpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 17:45:13 -0500
Received: by mail-io1-f67.google.com with SMTP id k24so2267756ioc.4;
        Fri, 20 Dec 2019 14:45:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GrzZQAIvU13tZUBnamTdgJp1IR4Bvtox0FpOX5n6y60=;
        b=oNDT69vK38XTuxKu1YP9jxPCCCHySuIucJARPwBYBMofYUt647ioTWW2ZoUWstm/DF
         /fRT63U44SAXVjPZ0AWR0zyHaz+zBXi+fK249XpsFtLcECrXw3z/ou29NiSgeP236c7u
         AFbYm7kNwm9ZcNMU1N7SQ/0jgnDC4hXdRwYIy6kWxj6396T5ew2uFidVOPv/vhl9K6So
         QYpxWN7zrds3g0Vaqc990g0qecwQ6FVQAVD0xhHZHEzwpwurKMWjOA0sQrvmDCb0IsOb
         HA8m08rBRItXA6cFridH87/+NSs6exGRt6O13Bb4QxyOAGt9TxKYZutCdnP4oqn05ejm
         Lk+g==
X-Gm-Message-State: APjAAAUmOSEcq45lG4ZhbxWalTbvlRdmyEumyaR0Rof7hpJZfFGV8aYI
        y/UWCxtWhEdGtexBvFosjw==
X-Google-Smtp-Source: APXvYqzBx9Q9+Q54FCK7VbIfQprJ91z305BhSeASttR/gPnnX5RkKwNQsiLkQM5DQNqMVxCsp4IJYw==
X-Received: by 2002:a02:cc75:: with SMTP id j21mr13923008jaq.113.1576881912130;
        Fri, 20 Dec 2019 14:45:12 -0800 (PST)
Received: from localhost ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id p5sm5427227ilg.69.2019.12.20.14.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 14:45:11 -0800 (PST)
Date:   Fri, 20 Dec 2019 15:45:10 -0700
From:   Rob Herring <robh@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     p.zabel@pengutronix.de, Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, lee.jones@linaro.org,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH 2/3] dt-bindings: mfd: Convert Allwinner legacy PRCM
 bindings to schemas
Message-ID: <20191220224510.GA19564@bogus>
References: <20191219090712.947490-1-maxime@cerno.tech>
 <20191219090712.947490-2-maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219090712.947490-2-maxime@cerno.tech>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Dec 2019 10:07:11 +0100, Maxime Ripard wrote:
> The Allwinner SoCs have a legacy set of bindings (and a drivers to
> support it in Linux) to support the PRCM unit found in most recent SoCs.
> 
> Now that we have the DT validation in place, let's split into separate file
> and convert the device tree bindings for those controllers to schemas, and
> mark them all as deprecated.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  .../mfd/allwinner,sun6i-a31-prcm.yaml         | 219 ++++++++++++++++++
>  .../mfd/allwinner,sun8i-a23-prcm.yaml         | 200 ++++++++++++++++
>  .../devicetree/bindings/mfd/sun6i-prcm.txt    |  59 -----
>  3 files changed, 419 insertions(+), 59 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/allwinner,sun6i-a31-prcm.yaml
>  create mode 100644 Documentation/devicetree/bindings/mfd/allwinner,sun8i-a23-prcm.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/sun6i-prcm.txt
> 

Applied, thanks.

Rob
