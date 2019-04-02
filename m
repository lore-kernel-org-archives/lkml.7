Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C71FC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1AA2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WFWJkXSC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbfDBNjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:39:35 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60370 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfDBNjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:39:35 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x32DdXb5023880;
        Tue, 2 Apr 2019 08:39:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554212373;
        bh=kZb+FRtQrpTzAAWRWYzh7F2xIyNGLDG3X72MTEx9bFo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=WFWJkXSCdwk96Tk1TbksEliw3zpZozc5RTLE9AzbjF3QottFOP5YL2PPTbilKc2FA
         pE3D2dS1jbK01VmaScFhaC8OrR/DBn8HFuDr+52SVmpFEcct19rB20l9GwiiVV5b24
         PPDJqanP32jAOHUxfOC4hXoN2tfVSrj5+5yN/KQQ=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x32DdXpU073655
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Apr 2019 08:39:33 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 2 Apr
 2019 08:39:30 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 2 Apr 2019 08:39:30 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x32DdTIu069972;
        Tue, 2 Apr 2019 08:39:29 -0500
Subject: Re: [RFC PATCH 0/4] bus: ti-sysc: Add generic enable/disable & PRUSS
To:     <tony@atomide.com>
CC:     <nsekhar@ti.com>, <s-anna@ti.com>, <linux-kernel@vger.kernel.org>
References: <20190402133752.6912-1-rogerq@ti.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <c720c3c3-c793-f2b1-57d3-2105bcbb73a0@ti.com>
Date:   Tue, 2 Apr 2019 16:39:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190402133752.6912-1-rogerq@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/2019 16:37, Roger Quadros wrote:
> Hi Tony,
> 
> Non legacy modules will rely on generic enable/disable functions.
> 
> I had to disable usb_otg_ss3 and 4 on am57xx idk to be able to boot.
> It is explicitly stated in TRM to not use USB3 and 4 on AM57xx, and
> I haven't seen any dra7 based board using them so let's keep it disabled.
> 
> Handle the PRU-ICSS type as it needs some special handling especially
> during suspend/resume.

I forgot to mention that this must be applied on top of
https://lkml.org/lkml/2019/3/25/1180

> 
> cheers,
> -roger
> 
> Roger Quadros (4):
>   ARM: dts: dra7: Keep usb_otg_ss3 and usb_otg_ss4 disabled
>   bus: ti-sysc: Add generic enable/disable functions
>   bus: ti-sysc: Add support for PRU-ICSS type
>   bus: ti-sysc: Ensure PRU-ICSS doesn't break suspend/resume
> 
>  .../devicetree/bindings/bus/ti-sysc.txt       |   1 +
>  arch/arm/boot/dts/dra7-l4.dtsi                |   2 +
>  drivers/bus/ti-sysc.c                         | 171 ++++++++++++++++++
>  include/linux/platform_data/ti-sysc.h         |   7 +-
>  4 files changed, 180 insertions(+), 1 deletion(-)
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
