Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF4BC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D08D206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VJzpvllK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733004AbfDQRZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:25:10 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55264 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732321AbfDQRZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:25:10 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3HHOijJ092593;
        Wed, 17 Apr 2019 12:24:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555521884;
        bh=yVgnOiQL608EUWHuPLXH7eDvrVEaDH7Dpfk7s4HRDzM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=VJzpvllKd8av1n4Ii5yYXX1nl4IsJV+6V7vj2xN6ZZihogZ27yp32pY6lIMw1MlI/
         qzk/dhAvXAuOJuUetu/cDVzs9i/esgGS+4ktUpVgLiy4oyVRFjL9tjatjnheXlE7V6
         rtHya+ZkJSgt2cC+ayd579W8qTbYn7bvVsfsFGzw=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3HHOiHc068018
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 17 Apr 2019 12:24:44 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 17
 Apr 2019 12:24:43 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 17 Apr 2019 12:24:43 -0500
Received: from [10.250.138.29] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3HHOaal044307;
        Wed, 17 Apr 2019 12:24:38 -0500
Subject: Re: [PATCH v3 0/5] MTD: Add Initial Hyperbus support
To:     Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
CC:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        <linux-mtd@lists.infradead.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        <devicetree@vger.kernel.org>, Mason Yang <masonccyang@mxic.com.tw>,
        <linux-arm-kernel@lists.infradead.org>, <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>
References: <20190412092923.24919-1-vigneshr@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <9e8575e2-b8de-341d-7ab5-08055b84c805@ti.com>
Date:   Wed, 17 Apr 2019 22:54:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412092923.24919-1-vigneshr@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergei,

On 12/04/19 2:59 PM, Vignesh Raghavendra wrote:
> Vignesh Raghavendra (5):
>    mtd: cfi_cmdset_0002: Add support for polling status register
>    dt-bindings: mtd: Add binding documentation for HyperFlash
>    mtd: Add support for HyperBus memory devices
>    dt-bindings: mtd: Add bindings for TI's AM654 HyperBus memory
>      controller
>    mtd: hyperbus: Add driver for TI's HyperBus memory controller
> 

Thanks for all the reviews!
Were you able to test this series with your hardware? Would like to get 
this into v5.2-rc1 if possible

Regards
Vignesh
