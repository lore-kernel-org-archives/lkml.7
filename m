Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288B3C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 06:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80BE20675
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 06:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tJO8UXWM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfDWGMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 02:12:17 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60738 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDWGMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 02:12:17 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3N6C2MH058379;
        Tue, 23 Apr 2019 01:12:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555999922;
        bh=k+UOFmEsUNmbjD6gX1BZX7XCEjixRWsf6RdCKrtCo7g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=tJO8UXWMLzAElZsTMzDdycHqfDeYSYUvmlJTDoSt0AeEPR54qMz7MePSOzjKbkVp9
         K6kyrZq637TxE1ZruiIbEzTQPju9m0aWCNyymjEBq5lDKfofOOTkmYm/WLP/i963Pt
         N6tfr42+BHHArYwhplerXPdYz6fbhOWTepTIzHoI=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3N6C2hX078028
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Apr 2019 01:12:02 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 23
 Apr 2019 01:12:02 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 23 Apr 2019 01:12:02 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3N6BvcS077231;
        Tue, 23 Apr 2019 01:11:58 -0500
Subject: Re: [PATCH v3 0/5] MTD: Add Initial Hyperbus support
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-mtd@lists.infradead.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        <devicetree@vger.kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mason Yang <masonccyang@mxic.com.tw>,
        <linux-arm-kernel@lists.infradead.org>, <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>
References: <20190423060638.18197-1-vigneshr@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <7e5515f8-340c-bd63-2897-90e0d42cf264@ti.com>
Date:   Tue, 23 Apr 2019 11:42:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423060638.18197-1-vigneshr@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/04/19 11:36 AM, Vignesh Raghavendra wrote:
> 
> 
> Vignesh Raghavendra (5):
>   mtd: cfi_cmdset_0002: Add support for polling status register
>   dt-bindings: mtd: Add binding documentation for HyperFlash
>   mtd: Add support for HyperBus memory devices
>   dt-bindings: mtd: Add bindings for TI's AM654 HyperBus memory
>     controller
>   mtd: hyperbus: Add driver for TI's HyperBus memory controller

Please ignore this series. Ended up sending from stale patch output
directory. Sorry for the noise.

> 
>  .../bindings/mtd/cypress,hyperflash.txt       |   6 +
>  .../devicetree/bindings/mtd/ti,am654-hbmc.txt |  31 +++
>  MAINTAINERS                                   |   8 +
>  drivers/mtd/Kconfig                           |   2 +
>  drivers/mtd/Makefile                          |   1 +
>  drivers/mtd/chips/cfi_cmdset_0002.c           |  90 ++++++++
>  drivers/mtd/hyperbus/Kconfig                  |  23 +++
>  drivers/mtd/hyperbus/Makefile                 |   4 +
>  drivers/mtd/hyperbus/hbmc-am654.c             | 115 +++++++++++
>  drivers/mtd/hyperbus/hyperbus-core.c          | 192 ++++++++++++++++++
>  include/linux/mtd/cfi.h                       |   5 +
>  include/linux/mtd/hyperbus.h                  |  91 +++++++++
>  12 files changed, 568 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/cypress,hyperflash.txt
>  create mode 100644 Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt
>  create mode 100644 drivers/mtd/hyperbus/Kconfig
>  create mode 100644 drivers/mtd/hyperbus/Makefile
>  create mode 100644 drivers/mtd/hyperbus/hbmc-am654.c
>  create mode 100644 drivers/mtd/hyperbus/hyperbus-core.c
>  create mode 100644 include/linux/mtd/hyperbus.h
> 

-- 
Regards
Vignesh
