Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4A3C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3AFB20820
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732580AbfIEIvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 04:51:46 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38640 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfIEIvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 04:51:45 -0400
Received: by mail-qt1-f196.google.com with SMTP id b2so1876911qtq.5;
        Thu, 05 Sep 2019 01:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p20Q0N9T++jYTpnThB0y4fzC3Jgac/dThX4GFqhd8fQ=;
        b=Lj+4bSwrNI0pmF9vXl4R3SrdYAxXTX9q7/dwYIyhwIMjGgqml7TRqcrEzg5hkfGtKY
         R2l3ez/ZOs3aoTBd1fnIRkC+w4wiGCgTj4aJzgfcRBuQUBL+Tv7bEF+3233XgHxj1rRl
         VfsSBByoZZTeTtW4CRvRxpNnj8N+BbNw+4ve3S5em5ceAn0A+5lQRscQMvJYETFYAkD+
         6W6h89izBN1/2zHZMYq8dDjG9Rqd/hDTEB94RO2DJ08h0be1Od36Flkde1ZGjVLj0klC
         84ygyJPyCpWHJmLHzjxXC7l1C2GMP15nSueTL0OHt+DawKOoK8WGdViGtXaYzzfhO/4k
         dokA==
X-Gm-Message-State: APjAAAXy88dxdP7xdEeUVtwgRPirb/+4z6k1vfjeztIQbWuTw6yiWgV8
        QY6knHk5zx5kQH0NUrF0FRYS+nfA2k+25B+A7+s=
X-Google-Smtp-Source: APXvYqysJScfhnYVEnH4ACpboWpgvQmZTJNertVO4/MovZFR9io6yC6xAJj83VWXiaXtBpeGMc8eZXlYyda0XavhhdM=
X-Received: by 2002:ac8:5306:: with SMTP id t6mr2345068qtn.204.1567673504645;
 Thu, 05 Sep 2019 01:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190905080835.1376-1-james.tai@realtek.com>
In-Reply-To: <20190905080835.1376-1-james.tai@realtek.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 5 Sep 2019 10:51:28 +0200
Message-ID: <CAK8P3a3L7mzR+FUMgG75_hrp4HQm4vJR3hsUO_BkQp_247OLsA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: realtek: Add support for Realtek RTD16XX
 evaluation board
To:     jamestai.sky@gmail.com
Cc:     DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        CY_Huang <cy.huang@realtek.com>,
        Phinex Hung <phinex@realtek.com>,
        "james.tai" <james.tai@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 5, 2019 at 10:10 AM <jamestai.sky@gmail.com> wrote:

> +
> +/ {
> +       model= "Realtek Mjolnir Evaluation Board";
> +       model_hex= <0x00000653>;

The 'mode_hex' property is rather unusual, please drop that for now.

> +       chosen {
> +               bootargs = "console=ttyS0,115200 earlycon";
> +       };
> +
> +       memory@0 {
> +               device_type = "memory";
> +               reg = <0x0 0x0 0x0 0x80000000>;
> +       };
> +
> +       uart0: serial0@98007800 {
> +               compatible = "snps,dw-apb-uart";
> +               reg = <0x0 0x98007800 0x0 0x400>,
> +                       <0x0 0x98007000 0x0 0x100>;
> +               reg-shift = <2>;
> +               reg-io-width = <4>;
> +               interrupts = <0 68 4>;
> +               clock-frequency = <27000000>;
> +               status = "okay";
> +       };

This looks like an on-chip uart. Please move that into rtd16xx.dtsi
instead, and just mark it as 'status="disabled"' there if there are
multiple uarts (and add the other ones as well), then enable
it for the board here.

There should also be an 'aliases'. You normally also want to add

aliases {
        serial0 = &uart0;
};

chosen {
       stdout-path= "serial0:115200n8"
};

in the board file to make earlycon work right.

      Arnd
