Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CAAC3A5AB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A499420449
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732381AbfIEKRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 06:17:54 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40718 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfIEKRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 06:17:53 -0400
Received: by mail-qt1-f194.google.com with SMTP id g4so2109353qtq.7;
        Thu, 05 Sep 2019 03:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RffJ7InQL31j5GA0tk88FRNmNw9DfUtPHCAY7O517yY=;
        b=b8XbRLWCAXrLgkKAA616QdR+QSFLo+jmrxfrCrIIxmKxBMLIJcrsWlnTn49rukInuS
         URNGnMtDMRzw6r5QpPjvfJBXCzMBQoUo+q62Gif75X1aoBf1Yfe86rcsre7RcLmPD4C4
         8Slc2/3kVNXmN9Wgep5qzMzMf37PIFbBsH5TxmtAv8KhFGLhlhRZH94rVscGixV1u2Mm
         IXZ2nmAPiChSMNLowHZC3X5GPUiDxop60oSUuhWj7S6lG4zY2jBoh2P6tD/W7VaBauN7
         vfxdDuEkQ5aAE34Z1eXg657QDPEQLwQwd4g7taybsfhHKtYcPeJ3S34aeFtOaq9xD8J2
         +AvQ==
X-Gm-Message-State: APjAAAV+YIZdyLElQc1yYObgDe9xIPyEoA/wbupGnaAoVJeejfafpa2/
        WmE0NCNh1ITjlVkPtgN8ozQhNZBwQP6e8fJNK3c=
X-Google-Smtp-Source: APXvYqwuebU2u/F2gHA1bDb+BAE+/VJQoganY1fAoMnsD+auDbyJLIa9btOXgvoh8se4YaEzjBq01+7ONjYkz7KCiJ4=
X-Received: by 2002:ac8:342a:: with SMTP id u39mr2699225qtb.7.1567678672404;
 Thu, 05 Sep 2019 03:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190830220743.439670-1-lkundrak@v3.sk> <20190830220743.439670-17-lkundrak@v3.sk>
In-Reply-To: <20190830220743.439670-17-lkundrak@v3.sk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 5 Sep 2019 12:17:36 +0200
Message-ID: <CAK8P3a1oqj5wXFgf+99=H4=hNrpnrwa05c+YctN64tHLvmoz5g@mail.gmail.com>
Subject: Re: [PATCH v3 16/16] ARM: dts: mmp3: Add MMP3 SoC dts file
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     "To : Olof Johansson" <olof@lixom.net>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "Cc : Rob Herring" <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 31, 2019 at 12:12 AM Lubomir Rintel <lkundrak@v3.sk> wrote:

> +/ {
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +
> +       aliases {
> +               serial0 = &uart1;
> +               serial1 = &uart2;
> +               serial2 = &uart3;
> +               serial3 = &uart4;
> +       };

Better move the aliases into the per-board file, not every board
would have all four uarts connected, or labeled in that particular
order.

        Arnd
