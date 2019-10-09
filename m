Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E07CC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77DBA20B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xq47ib1o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731290AbfJINm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 09:42:56 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50938 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731072AbfJINmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:42:55 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x99DgXJs086811;
        Wed, 9 Oct 2019 08:42:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570628553;
        bh=s1ULam50Hr59d2Q+B3GgfeudAX6pTL2y0nYltbe755s=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=xq47ib1oRQsmvETxShS6fOnordxgxaJcSSgGFM92czD3ma6v6RsgHtdocnk6ya6+Y
         /Tq78BNHjY72gI3CiG3IEAUnE+2H1sQdGhT6oincmZyiw/gKU0PTNehFq0x/XJ6M4h
         rxfcBAf0cifMHRCCf9XPzzdsZkCivhFAHfX4cBbE=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x99DgWYf087295;
        Wed, 9 Oct 2019 08:42:33 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 9 Oct
 2019 08:42:29 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 9 Oct 2019 08:42:29 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x99DgTen078224;
        Wed, 9 Oct 2019 08:42:29 -0500
Subject: Re: Serial 8250 DMA Broken on OMAP3630
To:     Adam Ford <aford173@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Tony Lindgren <tony@atomide.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHCN7x+oXNA6WRiq1OnDdcgDTJrm-QyazyYLw-ow0vPMMmrVbQ@mail.gmail.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <3d5b3a12-a21c-f464-e7d1-252ccd768ff8@ti.com>
Date:   Wed, 9 Oct 2019 19:13:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHCN7x+oXNA6WRiq1OnDdcgDTJrm-QyazyYLw-ow0vPMMmrVbQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On 06/10/19 10:34 PM, Adam Ford wrote:
> Has anyone else had any issues using the CONFIG_SERIAL_8250_DMA on the OMAP?
> 
> I can use the DMA on the legacy, omap-serial driver, but when I enable
> the DMA on the 8250-omap driver, I get missing frames in Bluetooth.
> 
> The older driver seems to have an ISR that seems to address a variety
> of items compared to the very tiny ISR for 8250-omap.c.
> 
> I am not exactly sure where to start, but if someone has any
> suggestions on how I can troubleshoot, please let me know.  As of now,
> I have to disable CONFIG_SERIAL_8250_DMA to get the Bluetooth
> connected to UART2 operational on a DM3730 at 3,000,000 baud, but it
> appears to work just fine after some patches I just submitted for
> handling RTS/CTS.  The legacy omap-serial driver works fine with DMA.
> 

Mainline omap-serial does not support DMA (evident from lack of
dmaengine API calls) and therefore is not a regression. So OMAP3 UART
DMA was never tested at least with 8250 driver.
I am not sure enabling UART DMA on OMAP3 would be a trivial job. We need
analyse of whether all erratas workarounds are implemented and see if
there any difference wrt DMA integration itself. Do we know if UART DMA
ever worked on OMAP3 previously?

> adam
> 

-- 
Regards
Vignesh
