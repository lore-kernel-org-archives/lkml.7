Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC06C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34C9208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CWpQiyUr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfFZGAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 02:00:42 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54470 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfFZGAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 02:00:41 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5Q60FSI085347;
        Wed, 26 Jun 2019 01:00:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561528815;
        bh=HVUML4z+0uJ3/8NRfZVvuXjLtrK+2oCxRsdfu2L1a6M=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=CWpQiyUrkMBOHsPtmLblyp5/OJuonzQnj2fMi494DDmBzu19N58HhjR094H07ThD0
         WdazApgdj2HdhNHDu4mXZzg96r3Ug3SL2h0YHliiTN3RNNJscmrCoMJKdwSAxS5FhM
         hDa8XZg88rrN8st2CNYwc5hLgprqNF7+g0fH9I+k=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5Q60Fhj077983
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Jun 2019 01:00:15 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 26
 Jun 2019 01:00:14 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 26 Jun 2019 01:00:14 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5Q60B6h031555;
        Wed, 26 Jun 2019 01:00:12 -0500
Subject: Re: [PATCH v7 3/5] mtd: Add support for HyperBus memory devices
To:     <masonccyang@mxic.com.tw>
CC:     Boris Brezillon <bbrezillon@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
References: <20190620172250.9102-1-vigneshr@ti.com>
 <20190620172250.9102-4-vigneshr@ti.com>
 <OF97D41CEB.1200A9E4-ON48258425.0006AA42-48258425.000700E5@mxic.com.tw>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <1131067e-a86d-f794-f6ae-be0a2b3e5832@ti.com>
Date:   Wed, 26 Jun 2019 11:30:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <OF97D41CEB.1200A9E4-ON48258425.0006AA42-48258425.000700E5@mxic.com.tw>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/06/19 6:46 AM, masonccyang@mxic.com.tw wrote:
> Hi Vignesh,
> 
>>
>> Subject
>>
>> [PATCH v7 3/5] mtd: Add support for HyperBus memory devices
>>
>> Cypress' HyperBus is Low Signal Count, High Performance Double Data Rate
>> Bus interface between a host system master and one or more slave
>> interfaces. HyperBus is used to connect microprocessor, microcontroller,
>> or ASIC devices with random access NOR flash memory (called HyperFlash)
>> or self refresh DRAM (called HyperRAM).
>>
>> Its a 8-bit data bus (DQ[7:0]) with  Read-Write Data Strobe (RWDS)
>> signal and either Single-ended clock(3.0V parts) or Differential clock
>> (1.8V parts). It uses ChipSelect lines to select b/w multiple slaves.
>> At bus level, it follows a separate protocol described in HyperBus
>> specification[1].
>>
>> HyperFlash follows CFI AMD/Fujitsu Extended Command Set (0x0002) similar
>> to that of existing parallel NORs. Since HyperBus is x8 DDR bus,
>> its equivalent to x16 parallel NOR flash wrt bits per clock cycle. But
>> HyperBus operates at >166MHz frequencies.
>> HyperRAM provides direct random read/write access to flash memory
>> array.
>>
>> But, HyperBus memory controllers seem to abstract implementation details
>> and expose a simple MMIO interface to access connected flash.
>>
>> Add support for registering HyperFlash devices with MTD framework. MTD
>> maps framework along with CFI chip support framework are used to support
>> communicating with flash.
>>
>> Framework is modelled along the lines of spi-nor framework. HyperBus
>> memory controller (HBMC) drivers calls hyperbus_register_device() to
>> register a single HyperFlash device. HyperFlash core parses MMIO access
>> information from DT, sets up the map_info struct, probes CFI flash and
>> registers it with MTD framework.
>>
>> Some HBMC masters need calibration/training sequence[3] to be carried
>> out, in order for DLL inside the controller to lock, by reading a known
>> string/pattern. This is done by repeatedly reading CFI Query
>> Identification String. Calibration needs to be done before trying to 
> detect
>> flash as part of CFI flash probe.
>>
>> HyperRAM is not supported at the moment.
>>
>> HyperBus specification can be found at[1]
>> HyperFlash datasheet can be found at[2]
>>
>> [1] https://www.cypress.com/file/213356/download
>> [2] https://www.cypress.com/file/213346/download
>> [3] http://www.ti.com/lit/ug/spruid7b/spruid7b.pdf
>>     Table 12-5741. HyperFlash Access Sequence
>>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> 
> Cypress has announced the inclusion of Cypress’ high-bandwidth 
> HyperBus™ 8-bit serial memory interface into the new eXpanded SPI (xSPI) 
> electrical interface standard from the JEDEC Solid State Technology 
> Association 
> 
> for detail, please goes to
> https://www.cypress.com/news/cypress-hyperbus-memory-interface-instant-applications-incorporated-jedec-xspi-electrical 
> 

Thanks for the link!
Announcement seems to be from March 2018 since then Cypress has
published detailed HyperBus protocol in public domain . Comparing JEDEC
xSPI specification and HyperBus protocol that Cypress has published,
they seem to be following 8D-8D-8D Profile 2.0 with Extended Command
Modifier of JEDEC xSPI spec.
Did you see anything missing/different?

I need to study xSPI spec in more detail, but seems like as long as we
support HyperBus Protocol spec from Cypress we should be safe.

-- 
Regards
Vignesh
