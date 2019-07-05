Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FD9C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 22:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA912133F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 22:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="kEgPCwAN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfGEW37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 18:29:59 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40467 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfGEW36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 18:29:58 -0400
Received: by mail-io1-f68.google.com with SMTP id h6so13920635iom.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 15:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TiHoVMsFcSLIQMr9uOZIpXIgFEvQNZbBssFZ43ZIIe8=;
        b=kEgPCwANMUFzB8Tbmw0ykNs9VmJkGcKJRMnmQpfjnitHffAN6aT8hGO0cfsK5uox5+
         P0rr3Dc8i0HzwW0k8l/P5waoyng9xc6GttS9MlwMqNljBTc+pUEr9k9F16iopjSwPkkp
         JGxvgcJ3Evzu7W928BVVu8+Bvu4rHhjlX3wxvWpm5GlRYby/ni5DX+/B4sIrXwxyQcW3
         UNy/7pEyCeCC466IWnOqIoDp73E85Yy6cvfo1+E46aMGrkb5U9HAub/FQ2mU3IrnoW8f
         BUcOVZDvtwhXrXo+6XjEZ5X0a6ZE782e3NTITo2MZ2jCidpIpR2uXlVuv2ljV2fTVYWM
         a0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TiHoVMsFcSLIQMr9uOZIpXIgFEvQNZbBssFZ43ZIIe8=;
        b=poaqVZKyQEewlXPsMRHg7s1GZQ+uMLcqskelHQWyfVC9CsSvLxYtIlYfW42ODVq/wG
         MmVIsI3hEWr/UtPPaSRuNQeVD0BpnRh/+eHeiY4Ccv3L8dkmVtwNEljjpgaEUZEzT9X4
         7waieOUD6amKRdr8BlCqsCa4lBZBwPUt+gPHwFj6Gu3unLM+6ivSBr0dXkgk2ZrQi/1r
         o0BU17oOlww+2bt6ZCGo1DbRfBbZ4gR04TqssksMpZeuudn2QboE4X2n0FrmyvSdD+hA
         Q08IBwyCCli4YgrTkFG3WuQE0Jsnh62uhxJsTxI0NpGkHc6iSVMiLSB+/LXOZ2EYVxVM
         kH4w==
X-Gm-Message-State: APjAAAUJs5U9ubhSYiLc+ZpRXE7L0/VKZOWHx9IH1ar/LmpLAEtpPdrF
        oH07ADq/6OrkxEFn7x9wl9aIaS0iDdRrQCdy2wkaqg==
X-Google-Smtp-Source: APXvYqxkIW246ER+0x11WTY5HcsLZYgY0kDKBdaZ85h3vZe4O7pl2xjdYiJwW2/mXxrxy6EmgNSpsuwt+g6Gcc/XNPg=
X-Received: by 2002:a5d:9282:: with SMTP id s2mr6264093iom.36.1562365798212;
 Fri, 05 Jul 2019 15:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <1559636093-26005-1-git-send-email-krzk@kernel.org> <15AEA3356BFC1A54.4080@linux.kernel.org>
In-Reply-To: <15AEA3356BFC1A54.4080@linux.kernel.org>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 5 Jul 2019 15:29:46 -0700
Message-ID: <CAOesGMhBs4qJPis4cO3f6kmwgqpbP2OF00y2PZ3_AE82mYnDkw@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: configs: Remove useless UEVENT_HELPER_PATH
To:     patchwork-soc+owner@linux.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        ARM-SoC Maintainers <arm@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-aspeed@lists.ozlabs.org,
        linux-omap <linux-omap@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 5, 2019 at 3:26 PM Olof Johansson via Linux.Kernel.Org
<olof=lixom.net@linux.kernel.org> wrote:

This didn't work as I anticipated. Please ignore, apologies for the spam.


-Olof
