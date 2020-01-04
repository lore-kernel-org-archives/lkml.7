Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD59C00523
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602BC222C3
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578098384;
	bh=sZyP0e+mjnxwlVWNCOgdOMQRJvAWhS76NcGzrvEEwbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RYesUR1G0AFZgUNjbJjEJA/0CSRUAgKZCGKEpNwlWysfp/+Jh1bFpCHgApDjkmrqY
	 oq4UvHPa4Fydpw0bISy5M7y09V0GB/4eFPdxt4llVhNv0NB7QGocgyhPNom+y8orcB
	 wi9fIZY2KW8IKXnCYc3sFS6/+ehtMESNdkRtj5KI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbgADAjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 19:39:43 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:32867 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgADAjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 19:39:42 -0500
Received: by mail-io1-f68.google.com with SMTP id z8so43116307ioh.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 16:39:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dKtl1NpRX8aOyUbBGch9yTP0h5jL9ht++jj3F8wRx1Y=;
        b=kELmKdJmt6XxX+QIHGu6VnpNw8lxKh5StCG8yoNV5UaQIyRHxmVegdG927AtSnclKP
         ltEJDLC5GGbjDjH2w0NyJVn6V1zjMy2cBR/kVHDiRuni1shn0fuG/DjUTZcckCNNp/wp
         RgVI8baHWey31hkRFhD1xas6MUagMzkgGgRZtvNAauHAcL1HOKzSnn1JUJSLpAIpfFmX
         DN3JDoVrSQO4H7NE1M5YSgE7IJYDnb8x441ECjt9rYMqpFFSYDBHS/NVATOEngJXR8zm
         1Utdz2OxRprm6uAm5Hs3CxTHPHjtVxzKQIdVUbxWFaBhfNUvVx5PQKuxNuWGxvOAtP+l
         7Mqg==
X-Gm-Message-State: APjAAAWiJCHGZOpxU6vA36KjcfHqIilKKdMCVjEMO1PN8swcCnK/GK69
        PL6jt4PyrNAHzIsvl/kf7LTB7Gs=
X-Google-Smtp-Source: APXvYqyDMFdcEd8PrmOOX1eV9oxqAcdGMBZ5iAVt3AYNrzWs4/dUpVlL9MI3MsaZgUzRu1sTDF1+DA==
X-Received: by 2002:a02:b00c:: with SMTP id p12mr71715421jah.112.1578098381708;
        Fri, 03 Jan 2020 16:39:41 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id g62sm21473703ile.39.2020.01.03.16.39.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 16:39:41 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219b7
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Fri, 03 Jan 2020 17:39:39 -0700
Date:   Fri, 3 Jan 2020 17:39:39 -0700
From:   Rob Herring <robh@kernel.org>
To:     Akash Gajjar <akash@openedev.com>
Cc:     heiko@sntech.de, jagan@openedev.com, tom@radxa.com,
        Akash Gajjar <akash@openedev.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Douglas Anderson <dianders@chromium.org>,
        Vivek Unune <npcomplete13@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kever Yang <kever.yang@rock-chips.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Nick Xie <nick@khadas.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3, 1/1] arm64: dts: rockchip: add ROCK Pi S DTS support
Message-ID: <20200104003939.GA15565@bogus>
References: <20191230145008.5899-1-akash@openedev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230145008.5899-1-akash@openedev.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Dec 2019 20:19:32 +0530, Akash Gajjar wrote:
> ROCK Pi S is RK3308 based SBC from radxa.com. ROCK Pi S has a,
> - 256MB/512MB DDR3 RAM
> - SD, NAND flash (optional on board 1/2/4/8Gb)
> - 100MB ethernet, PoE (optional)
> - Onboard 802.11 b/g/n wifi + Bluetooth 4.0 Module
> - USB2.0 Type-A HOST x1
> - USB3.0 Type-C OTG x1
> - 26-pin expansion header
> - USB Type-C DC 5V Power Supply
> 
> This patch enables
> - Console
> - NAND Flash
> - SD Card
> 
> Signed-off-by: Akash Gajjar <akash@openedev.com>
> ---
> Changes for v2
> - Use pwm-supply for vdd_core node instead of vi-supply
> - Add USB2.0 node support
>  
> Changes for v3
> - Use small S on dts file name
> - Add missing semicolon
> - Remove USB2.0 node support
> 
>  .../devicetree/bindings/arm/rockchip.yaml     |   5 +
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3308-rock-pi-s.dts    | 221 ++++++++++++++++++
>  3 files changed, 227 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
> 

Reviewed-by: Rob Herring <robh@kernel.org>
