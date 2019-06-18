Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E3AC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC7B21479
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gLGf7oP0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbfFROmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 10:42:20 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:44464 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfFROmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 10:42:19 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5IEg1QA118051;
        Tue, 18 Jun 2019 09:42:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560868921;
        bh=fHHIeoL6WrP+o42wBxL4d1KUkoVV62hUdcAiyBMH/XQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=gLGf7oP07AkblPP3ulwC9txJLKLwro1GDBXcIVluar7oyAlsYELqfH51VIgbo5Ppo
         pO9S5r8OxfbKyjo1O+AUbknfIBdXie09X2HJYSUAUERgI52PzVI/6dGwob19QEGfVX
         AN1BHbhjFQQt+1uphJfMnaKr9+TeuvKRbAVNV83Y=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5IEg1d2096318
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Jun 2019 09:42:01 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 18
 Jun 2019 09:42:00 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 18 Jun 2019 09:42:00 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5IEfvLs105464;
        Tue, 18 Jun 2019 09:41:57 -0500
Subject: Re: [PATCH 0/6] arm64: Initial support Texas Instrument's J721E
 Platform
To:     Nishanth Menon <nm@ti.com>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>
References: <20190522161921.20750-1-nm@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <6ae8cfc9-5bf0-14ec-109f-bafbf2cb7eac@ti.com>
Date:   Tue, 18 Jun 2019 17:41:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522161921.20750-1-nm@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/2019 19:19, Nishanth Menon wrote:
> Hi,
> 
> This series adds support for the latest new SoC, J721E, from Texas Instruments.
> 
> The series is an based off v5.2-rc1 and has the following driver
> dependencies for a successful boot:
> 1.  https://lore.kernel.org/lkml/20190429131533.25122-1-afd@ti.com (for newer firmware)
> 2.  https://lore.kernel.org/linux-arm-kernel/1555093342-428-1-git-send-email-t-kristo@ti.com/
>      - Clock IDs cannot be guarenteed to be sequential, has to be
>        discovered from hardware description in dts
>      - Clock IDs on this massive chip also exceeds 255, so, the support
>        for the same is expected in follow on patches.
> 
> The full series is available here (including dependencies):
> https://github.com/nmenon/linux-2.6-playground/commits/upstream/v5.2-rc1/j7es-base-v1
> 
> Boot Log: https://pastebin.ubuntu.com/p/j3NtfF8FQr/
> 
> NOTE:
>   - If Greg is ok, we can pick up the uart compatibility via the k3 tree,
>     else, I can spawn it off the series.

Assuming here that Greg is ok with me picking up patch #2.

>   - I will resubmit patch 6 (defconfig update) separately once again once
>     patches 1-5 hit the next tree or for 5.3-rc2 which ever is convenient.
> 

Seems it should be possible just to queue up everything, no need to 
repost stuff.

That said, queuing the whole series towards 5.3 with the mentioned fixes.

-Tero

> The J721E SoC belongs to the K3 Multicore SoC architecture platform
> for automotive applications such as infotainment, cluster, premium
> Audio, Gateway, industrial and a range of broad market applications.
> This SoC is designed around reducing the system cost by eliminating
> the need of an external system MCU and is targeted towards ASIL-B/C
> certification/requirements in addition to allowing complex software
> and system use-cases.
> 
> The Linux development follows AM654 in most of the configurations, but
> adds new capabilities (details in follow on patches).
> 
> See J721E Technical Reference Manual (SPRUIL1, May 2019)
> for further details: http://www.ti.com/lit/pdf/spruil1
> 
> Nishanth Menon (6):
>    dt-bindings: arm: ti: Add bindings for J721E SoC
>    dt-bindings: serial: 8250_omap: Add compatible for J721E UART
>      controller
>    arm64: dts: ti: Add Support for J721E SoC
>    soc: ti: Add Support for J721E SoC config option
>    arm64: dts: ti: Add support for J721E Common Processor Board
>    arm64: defconfig: Enable TI's J721E SoC platform
> 
>   .../devicetree/bindings/arm/ti/k3.txt         |   3 +
>   .../bindings/serial/omap_serial.txt           |   1 +
>   arch/arm64/boot/dts/ti/Makefile               |   2 +
>   .../dts/ti/k3-j721e-common-proc-board.dts     |  50 +++++
>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 202 ++++++++++++++++++
>   .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |  72 +++++++
>   arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi   |  29 +++
>   arch/arm64/boot/dts/ti/k3-j721e.dtsi          | 176 +++++++++++++++
>   arch/arm64/configs/defconfig                  |   1 +
>   drivers/soc/ti/Kconfig                        |   5 +
>   10 files changed, 541 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
>   create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>   create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
>   create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
>   create mode 100644 arch/arm64/boot/dts/ti/k3-j721e.dtsi
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
