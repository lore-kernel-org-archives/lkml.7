Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53666C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 00:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 236B7206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 00:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="dl06ZL/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfDCAXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 20:23:07 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42367 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfDCAXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 20:23:07 -0400
Received: by mail-qt1-f195.google.com with SMTP id p20so17280699qtc.9;
        Tue, 02 Apr 2019 17:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AQU0UmSUQjCjWhQD0cwp3WsrLbAxYZS7pwvflPfeqwk=;
        b=dl06ZL/zBEfP9CYuwbaChO0p+5sshlqKT+3sb8LKjtyPy/lUtUTLnDdzVYKiLRy28y
         8YgRlwETZAlLD4q+kFuO7qBCW1U6wIZORuj4o9KegsjCBPUgMgcFyA4w9AhCxr0n/p9h
         gKAH7tEBQqh/G43amUrbghj5K7vrK2hZ1Xkhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AQU0UmSUQjCjWhQD0cwp3WsrLbAxYZS7pwvflPfeqwk=;
        b=klGMu2XQIAPrGZHn8w/WPD1gGmSTz5QGYh0J0liT98VC8mP0baGOetdq/FoK3QHBdH
         zqqit5+1K2XQlWkELnXby9RjdU9ZGFv2tBhxkCCxeVSH8pKtDzvdxEK9jwEgLvdEN4dY
         SKxsNkHhZbxsHpYf/olQCfzlf3ib23Vpk0a9GNvt0hP1alCbtsFDpZFKlNMxYxSCg1jW
         qGnSEwecIGwmh4Vg3JbdLGENcppOpEN4oyOvLpy58g/tN6WA3+VbAUwZ0Ev7awxkaFUa
         o+pLkGTv6MFE5yltnuayftxaDWpXQjJ8IN9qKd88uo01g77p1Mcn7YaQi1WlvLFeTBN+
         WWfg==
X-Gm-Message-State: APjAAAWbWCcH9qtdPOVUvoFJF014+VcTS5qZ9Mz/7/fZYr3GrQEOTsjg
        4BM62HpGUKX2uufEDTibqjjwsWl4/ZrSoRImRRw=
X-Google-Smtp-Source: APXvYqzEKjU95VCL3aBh7dQGGLkH45xy4YG02E4zYFPVw0Qb4b89lLs5Y78yrKQe218KtEnZXcFVyf8aG45TR7v8DYQ=
X-Received: by 2002:a0c:d155:: with SMTP id c21mr60573834qvh.64.1554250985938;
 Tue, 02 Apr 2019 17:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <1554231713-14137-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1554231713-14137-1-git-send-email-linux@roeck-us.net>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 3 Apr 2019 00:22:54 +0000
Message-ID: <CACPK8XfXxVa-XszCAp=uYyZF38BRXH=ugutFEmKoiq7DeapsiA@mail.gmail.com>
Subject: Re: [PATCH] watchdog: Convert to use devm_platform_ioremap_resource
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Baruch Siach <baruch@tkos.co.il>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Nancy Yuen <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Wan ZongShun <mcuos.com@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Kukjin Kim <kgene@kernel.org>, Barry Song <baohua@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Apr 2019 at 19:02, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Use devm_platform_ioremap_resource to reduce source code size,

This is a strange name for a function that doesn't take nor return a
'struct resource'.

However, the intent is welcome as many drivers do redundant checking
of the platform_get_resource result before passing to
devm_ioremap_resource.

> improve readability, and reduce the likelyhood of bugs.

>  drivers/watchdog/aspeed_wdt.c     | 4 +---

Acked-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel
