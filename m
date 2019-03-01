Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A66C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D9C20850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXVKicEh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfCAFx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 00:53:29 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42139 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbfCAFx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 00:53:29 -0500
Received: by mail-wr1-f66.google.com with SMTP id r5so24460899wrg.9;
        Thu, 28 Feb 2019 21:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rSujFGYUgAqpWL9Qk6QnlIlKB8Ke3h3ycAhVJdiunqg=;
        b=MXVKicEhphkOR5kLrYsVtL1t5Uq62IYLkWMsQxp9ZKexywU2j7bNMTGnftideEwOLN
         Y60pb1QHPRq9X77uktnt5qJEn/37V9gWmD7yh2eUHlPKQtZgoDBWNWpQyHlxCq0OO96p
         cqeByW3NJFIAyjH8GqCSUBqgJfxjSSkpE6AQ0x7YBrvshy4CONMYMPh0JOl3kSHefQDd
         zu5HRA6I4WakmIQG4LN9A6RNIHHMYCSulWtRlPE1Gn00IlSUk5QILF+MWah8YbyyOQ8X
         jRDPF7ghVITDsN9jC8VCiaYZgtF0n5D1s8Nem2zMsTM+z2YQ1FsmaEph8He3xYK67NXX
         +Fyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rSujFGYUgAqpWL9Qk6QnlIlKB8Ke3h3ycAhVJdiunqg=;
        b=Sl9FuzcQgWd9gbBu0pt+4FYxrXVpW+IC9z6elag96zR7zJO8EQaP4G5QHB7SBrm01c
         rDaRiplzGVd4xMioYeKPbKBG92TVwY81SjRuZefO3ySMEZjVwDZci1FBWpUlZHgyN6lg
         lK1HSwfDDmEHtBJrrftQc+7P7yMfg2CtLfHxZSZZGBJeqWMcK2ITBNbajkiN+igrOLKB
         YrGjbT0Syc22ga38F9MJvUa8KRupnn0khI4Gr/LhoPkWsol/2ikN/Vzj3K8PxR9OYWpt
         j/XLmihZlWCeIEQ5Owx+FugsnRG/N0/QeXNRoHswWXm9E2vrIceuwApUV5FJ7lBNjC+j
         o8Rg==
X-Gm-Message-State: APjAAAWaHmSb3HAeoAvK7JOJtLJz1tqUIjdyQ6Bg1HG0hfNOuTLDCvlM
        gbR9UicsEsmAwDAaxsB7ctc=
X-Google-Smtp-Source: APXvYqywoKuM9I3djiVZegD6ZsA7OPgLDSV10ZW4NRwG9LdftFbIO8OqRULUlVDCsJK+f+nnsFRdPg==
X-Received: by 2002:a5d:4710:: with SMTP id y16mr1951147wrq.305.1551419607324;
        Thu, 28 Feb 2019 21:53:27 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id f126sm6725859wmf.6.2019.02.28.21.53.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 21:53:26 -0800 (PST)
Date:   Fri, 1 Mar 2019 06:53:24 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] [PATCH v2 00/10] Allwinner sunxi message box
 support
Message-ID: <20190301055324.GA563@Red>
References: <20190301052947.32032-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301052947.32032-1-samuel@sholland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 11:29:37PM -0600, Samuel Holland wrote:
> This series adds support for the "hardware message box" in sun8i, sun9i,
> and sun50i SoCs, used for communication with the ARISC management
> processor (the platform's equivalent of the ARM SCP). The end goal is to
> use the arm_scpi driver as a client, communicating with firmware running
> on the ARISC CPU, or to use the mailbox to forward NMIs that the
> firmware picks up from R_INTC.
> 
> Changes from v1:
>   - Marked message box clocks as critical instead of hacks in the driver
>   - 8 unidirectional channels instead of 4 bidirectional pairs
>   - Use per-SoC compatible strings and an A31 fallback compatible
>   - Dropped the mailbox framework patch
>   - Include DT patches for SoCs that document the message box
> 
> Samuel Holland (10):
>   clk: sunxi-ng: sun8i: Mark the msgbox clock as critical
>   clk: sunxi-ng: sun9i: Mark the msgbox clock as critical
>   clk: sunxi-ng: sun50i: Mark the msgbox clock as critical
>   dt-bindings: mailbox: Add a sunxi message box binding
>   mailbox: sunxi-msgbox: Add a new mailbox driver
>   ARM: dts: sunxi: a80: Add msgbox node
>   ARM: dts: sunxi: a83t: Add msgbox node
>   ARM: dts: sunxi: h3/h5: Add msgbox node
>   arm64: dts: allwinner: a64: Add msgbox node
>   arm64: dts: allwinner: h6: Add msgbox node
> 
>  .../bindings/mailbox/sunxi-msgbox.txt         |  44 +++
>  arch/arm/boot/dts/sun8i-a83t.dtsi             |  10 +
>  arch/arm/boot/dts/sun9i-a80.dtsi              |  10 +
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi            |  10 +
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  10 +
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  10 +
>  drivers/clk/sunxi-ng/ccu-sun50i-a64.c         |   2 +-
>  drivers/clk/sunxi-ng/ccu-sun50i-h6.c          |   2 +-
>  drivers/clk/sunxi-ng/ccu-sun8i-a23.c          |   2 +-
>  drivers/clk/sunxi-ng/ccu-sun8i-a33.c          |   2 +-
>  drivers/clk/sunxi-ng/ccu-sun8i-a83t.c         |   2 +-
>  drivers/clk/sunxi-ng/ccu-sun8i-h3.c           |   2 +-
>  drivers/clk/sunxi-ng/ccu-sun9i-a80.c          |   2 +-
>  drivers/mailbox/Kconfig                       |  11 +
>  drivers/mailbox/Makefile                      |   2 +
>  drivers/mailbox/sunxi-msgbox.c                | 315 ++++++++++++++++++
>  16 files changed, 429 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/sunxi-msgbox.txt
>  create mode 100644 drivers/mailbox/sunxi-msgbox.c

Hello

Appart from applying/compiling/booting, does it exists some way to test it ? check it works ?

Regards
