Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64279C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D0621670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sW33nvnr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730557AbfD3Lq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:46:27 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56384 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbfD3LqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:46:21 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3UBk69L053322;
        Tue, 30 Apr 2019 06:46:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556624766;
        bh=MS/ebHHo25Z4rkEAJDu2R8iPbpujs41yXsTmY3TMBOA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=sW33nvnrlbzw36Q4MkQmmsvf19y3+NPrU9FVMx7iRGTb7/LachkvqCEcAo6iDGxIJ
         eU/E+o03rJW0lfKBTB4mvRocn4rxI0/7II7IB7gBxZggatIKDbbOrVIhKICm+Ic9Vn
         B3rNp2bCx7SHRHlIPBlkx0ANi9AA68n3tI0SytWQ=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3UBk60j120491
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Apr 2019 06:46:06 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 30
 Apr 2019 06:46:06 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 30 Apr 2019 06:46:06 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3UBk6BU042431;
        Tue, 30 Apr 2019 06:46:06 -0500
Date:   Tue, 30 Apr 2019 06:45:12 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Lokesh Vutla <lokeshvutla@ti.com>
CC:     Marc Zyngier <marc.zyngier@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>,
        <linus.walleij@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>
Subject: Re: [PATCH v8 00/14] Add support for TISCI Interrupt controller
 drivers
Message-ID: <20190430114512.pde3uuh5e3qwve3m@kahuna>
References: <20190430101230.21794-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190430101230.21794-1-lokeshvutla@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:42-20190430, Lokesh Vutla wrote:
[...]
> Changes since v7:
> - Rebased on top of latest master.
> - Each patch has respective changes mentioned.
> 
> Grygorii Strashko (1):
>   firmware: ti_sci: Add support to get TISCI handle using of_phandle
> 
> Lokesh Vutla (12):
>   firmware: ti_sci: Add support for RM core ops
>   firmware: ti_sci: Add support for IRQ management
>   firmware: ti_sci: Add helper apis to manage resources
>   genirq: Introduce irq_chip_{request,release}_resource_parent() apis
>   gpio: thunderx: Use the default parent apis for
>     {request,release}_resources
>   dt-bindings: irqchip: Introduce TISCI Interrupt router bindings
>   irqchip: ti-sci-intr: Add support for Interrupt Router driver
>   dt-bindings: irqchip: Introduce TISCI Interrupt Aggregator bindings
>   irqchip: ti-sci-inta: Add support for Interrupt Aggregator driver
>   soc: ti: Add MSI domain bus support for Interrupt Aggregator
>   irqchip: ti-sci-inta: Add msi domain support
>   arm64: arch_k3: Enable interrupt controller drivers
> 
> Peter Ujfalusi (1):
>   firmware: ti_sci: Add RM mapping table for am654
> 

For patches 1..5 (Firmware patches):

Acked-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
