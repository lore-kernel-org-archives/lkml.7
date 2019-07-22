Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7DCC76195
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31E121BF6
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfGVJOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 05:14:12 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39100 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfGVJOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:14:11 -0400
Received: by mail-qk1-f196.google.com with SMTP id w190so28031449qkc.6;
        Mon, 22 Jul 2019 02:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TAsHQCwByo0xm+Ou+Z8f3siTb0OiXHpS7X8zBNWanlM=;
        b=nJJFVzi1SLmE76p1V08DCGdzG741ivLkMDeUbLQSYdSqMhKSyqCwGnlB4G4FTMB+9B
         ysZxltpARl5AoR5/Th0oeZ4G4iKD/jxVo1PRoQO4lR3atnUzJo8pToCRBV+tEGNLUv/U
         Go0DjSIZ99l6rXqZpYUG4weptl1kUw1h7hSTojoD/PUnb+D7vgNEpmGVcWjLzBx7NJKW
         bxRfnxLiroBGOdTRfrc3XDiZUMcIoYNqSO9O199Ue5DRJBEgGS2dq39CbxoCJRlwHe7g
         Xta4kvwNOc6pRtVijPa+cz5daLBB6uqHq+ExATVD4ZJMWx36Lv0tMRAapAv/0+vTJZrW
         uF4Q==
X-Gm-Message-State: APjAAAUeBZs6VmEg4ntL9uV0ZLnB2tTjRd1PllXwQutNXYTGgBUYLlgA
        0SKwswfA7c7unrLWzUk7xd6/fu8yc1WsyMY0JhM=
X-Google-Smtp-Source: APXvYqwlY7qaXPeSLQnwZKRSkvohTm0gOv49ddiB/N23W1ch5uaCiEC2qqiDPxrQGAKS7evl9G5YQHXezsrDWYwOS54=
X-Received: by 2002:a37:76c5:: with SMTP id r188mr45322695qkc.394.1563786850518;
 Mon, 22 Jul 2019 02:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190703132255.852025-1-arnd@arndb.de> <20190709161630.7963-1-f.fainelli@gmail.com>
In-Reply-To: <20190709161630.7963-1-f.fainelli@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 22 Jul 2019 11:13:54 +0200
Message-ID: <CAK8P3a0eosUb0mZ_rDayChXC36w5Xj0gqtcKOcPCP8MEiMm3bQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: bcm47094: add missing #cells for mdio-bus-mux
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vivek Unune <npcomplete13@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 9, 2019 at 6:16 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On Wed,  3 Jul 2019 15:22:45 +0200, Arnd Bergmann <arnd@arndb.de> wrote:
> > The mdio-bus-mux has no #address-cells/#size-cells property,
> > which causes a few dtc warnings:
> >
> > arch/arm/boot/dts/bcm47094-linksys-panamera.dts:129.4-18: Warning (reg_format): /mdio-bus-mux/mdio@200:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
> > arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
> > arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
> > arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
> > arch/arm/boot/dts/bcm47094-linksys-panamera.dts:128.22-132.5: Warning (avoid_default_addr_size): /mdio-bus-mux/mdio@200: Relying on default #address-cells value
> > arch/arm/boot/dts/bcm47094-linksys-panamera.dts:128.22-132.5: Warning (avoid_default_addr_size): /mdio-bus-mux/mdio@200: Relying on default #size-cells value
> >
> > Add the normal cell numbers.
> >
> > Fixes: 2bebdfcdcd0f ("ARM: dts: BCM5301X: Add support for Linksys EA9500")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
>
> Applied to devicetree/fixes, thanks!

I just noticed this never made it into linux-next or the merge window.
Did it get dropped by accident?

       Arnd
