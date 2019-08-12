Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32831C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78A820842
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pdwnw6J6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbfHLKYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:24:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50631 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbfHLKYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:24:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id v15so11645308wml.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 03:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=s4c+tCeURwefVMli54iWLwLzBmEiKHEDXmTByXMYRso=;
        b=Pdwnw6J67H7oh9kG9MSsgYoXkdh501ITQ+vyaKqx8I5koutjUs8WxYTHY5P0rqX6Kq
         FaJXpKcfefMm4VvtL/T6xaZGzTTQbUvKGJjM3I/VFvcQ0DCQNwC3aIyfjU8ZQE8aV7g7
         9g3kQVmNLS6toK1woedUfVsC4xMma3jCX71ZaUNgjQXgWMjSKTalINYNo0lIBdu0I+hJ
         17w3MPAddEkIGRcFIe2LvCBFqSgsJmdDHFVMgeMzpZduUCHCqzSgED1SJRfCyUPNakpL
         9xeXwF0IS9HV4qQurL3bnDZLlZ71Z80zwSqsUy4bpkmEiqz8FUjO1UEe+jypGDtzO1uA
         w5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=s4c+tCeURwefVMli54iWLwLzBmEiKHEDXmTByXMYRso=;
        b=r8NZqHXe6ocGryN9e90u2N13oVBvzv1PfM2hU2V3fWAlaAg4fSCbg19wMgfbGqS4qw
         1liIzUH4d4IyECUoMlp4Cjd1z8R9r1m0cVeYQlvoFZDfGzCi2+bL2PyOd6uWhFdAGlWy
         q4DQfJ2b3n1o6chWpaz9pn6Eh7+VkLaIRLEp0jtFdPVTZfKg7jhnhZX/hI9PON47E95A
         106C8JTNFT2OZ2527oI8He2FnISuelGXMgyhNONHFlHL/hM8/J+92N0GI+Ge449qlvM0
         eQKnTnt+hjl1VaByYajhg2XH23NWeQ5kxKt20P142OeIzPd5YLeLyY+EKdOqimmoBjJ1
         oFaA==
X-Gm-Message-State: APjAAAXXpDvIiRE/4wclTYn7PKkqQ2onzpVsMQWsTBA0Fm08PkruIbJF
        /aR3SqZfsb90LGkpSZ5CIZHVTw==
X-Google-Smtp-Source: APXvYqyxkApIE8+Qfsn+A8tYWpIpvwdj9Lwb/49n7m31aXieEdChiennESHmI1ox7hWldcSQUf7guw==
X-Received: by 2002:a1c:7e85:: with SMTP id z127mr27612402wmc.95.1565605493088;
        Mon, 12 Aug 2019 03:24:53 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id l14sm10411976wrn.42.2019.08.12.03.24.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 03:24:52 -0700 (PDT)
Date:   Mon, 12 Aug 2019 11:24:50 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>, arnd@arndb.de
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2 1/3] arm64: imx8mq: add imx8mq iomux-gpr field defines
Message-ID: <20190812102450.GK26727@dell>
References: <cover.1565367567.git.agx@sigxcpu.org>
 <e0562d8bb4098dc4cdb4023b41fb75b312be22a5.1565367567.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e0562d8bb4098dc4cdb4023b41fb75b312be22a5.1565367567.git.agx@sigxcpu.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Aug 2019, Guido Günther wrote:

> This adds all the gpr registers and the define needed for selecting
> the input source in the imx-nwl drm bridge.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  include/linux/mfd/syscon/imx8mq-iomuxc-gpr.h | 62 ++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 include/linux/mfd/syscon/imx8mq-iomuxc-gpr.h

I would like Arnd to look at this please.

> diff --git a/include/linux/mfd/syscon/imx8mq-iomuxc-gpr.h b/include/linux/mfd/syscon/imx8mq-iomuxc-gpr.h
> new file mode 100644
> index 000000000000..62e85ffacfad
> --- /dev/null
> +++ b/include/linux/mfd/syscon/imx8mq-iomuxc-gpr.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2017 NXP
> + *               2019 Purism SPC
> + */
> +
> +#ifndef __LINUX_IMX8MQ_IOMUXC_GPR_H
> +#define __LINUX_IMX8MQ_IOMUXC_GPR_H
> +
> +#define IOMUXC_GPR0	0x00
> +#define IOMUXC_GPR1	0x04
> +#define IOMUXC_GPR2	0x08
> +#define IOMUXC_GPR3	0x0c
> +#define IOMUXC_GPR4	0x10
> +#define IOMUXC_GPR5	0x14
> +#define IOMUXC_GPR6	0x18
> +#define IOMUXC_GPR7	0x1c
> +#define IOMUXC_GPR8	0x20
> +#define IOMUXC_GPR9	0x24
> +#define IOMUXC_GPR10	0x28
> +#define IOMUXC_GPR11	0x2c
> +#define IOMUXC_GPR12	0x30
> +#define IOMUXC_GPR13	0x34
> +#define IOMUXC_GPR14	0x38
> +#define IOMUXC_GPR15	0x3c
> +#define IOMUXC_GPR16	0x40
> +#define IOMUXC_GPR17	0x44
> +#define IOMUXC_GPR18	0x48
> +#define IOMUXC_GPR19	0x4c
> +#define IOMUXC_GPR20	0x50
> +#define IOMUXC_GPR21	0x54
> +#define IOMUXC_GPR22	0x58
> +#define IOMUXC_GPR23	0x5c
> +#define IOMUXC_GPR24	0x60
> +#define IOMUXC_GPR25	0x64
> +#define IOMUXC_GPR26	0x68
> +#define IOMUXC_GPR27	0x6c
> +#define IOMUXC_GPR28	0x70
> +#define IOMUXC_GPR29	0x74
> +#define IOMUXC_GPR30	0x78
> +#define IOMUXC_GPR31	0x7c
> +#define IOMUXC_GPR32	0x80
> +#define IOMUXC_GPR33	0x84
> +#define IOMUXC_GPR34	0x88
> +#define IOMUXC_GPR35	0x8c
> +#define IOMUXC_GPR36	0x90
> +#define IOMUXC_GPR37	0x94
> +#define IOMUXC_GPR38	0x98
> +#define IOMUXC_GPR39	0x9c
> +#define IOMUXC_GPR40	0xa0
> +#define IOMUXC_GPR41	0xa4
> +#define IOMUXC_GPR42	0xa8
> +#define IOMUXC_GPR43	0xac
> +#define IOMUXC_GPR44	0xb0
> +#define IOMUXC_GPR45	0xb4
> +#define IOMUXC_GPR46	0xb8
> +#define IOMUXC_GPR47	0xbc
> +
> +/* i.MX8Mq iomux gpr register field defines */
> +#define IMX8MQ_GPR13_MIPI_MUX_SEL		BIT(2)
> +
> +#endif /* __LINUX_IMX8MQ_IOMUXC_GPR_H */

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
