Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F207C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C2A2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hkYiDXBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbfDBTIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:08:09 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35602 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfDBTIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:08:09 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x32J7hP5118890;
        Tue, 2 Apr 2019 14:07:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554232063;
        bh=6bwjt/Ha8WeaNIb3un0v5/gTmmpXp9y1t4guR0NU5oI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hkYiDXBTKFiIXWQgnKNgv2JtET1wU1YA70KOam7BrN2M6CR+knreqM9OmfgmodOQP
         SNaXqHernS6CBCCCFUdHjZSP8p3vWguM26dRNW1S8VLPfcmaYMuMqeZNF5YHoONDJu
         mmM8lM46whcIfQFgoUXq2QG/OV76CptJT0gAOcfQ=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x32J7hL0108755
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Apr 2019 14:07:43 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 2 Apr
 2019 14:07:43 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 2 Apr 2019 14:07:43 -0500
Received: from [172.22.122.115] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x32J7hsp072276;
        Tue, 2 Apr 2019 14:07:43 -0500
Subject: Re: [RFC PATCH 5/5] leds: multicolor: Introduce a multicolor class
 definition
To:     Randy Dunlap <rdunlap@infradead.org>, <robh+dt@kernel.org>,
        <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <marek.behun@nic.cz>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20190401173400.14238-1-dmurphy@ti.com>
 <20190401173400.14238-6-dmurphy@ti.com>
 <5f75eeed-41d5-e0d9-38f8-bf00c5045ba1@infradead.org>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <7e156cac-b654-0d63-be44-efc90ab2decf@ti.com>
Date:   Tue, 2 Apr 2019 14:07:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5f75eeed-41d5-e0d9-38f8-bf00c5045ba1@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy

Thank you.

On 4/1/19 4:10 PM, Randy Dunlap wrote:
> Hi,
> 
> On 4/1/19 10:34 AM, Dan Murphy wrote:
>> Introduce a multicolor class that groups colored LEDs
>> within a LED node.
>>
>> The framework allows for dynamically setting individual LEDs
>> or setting brightness levels of LEDs and updating them virtually
>> simultaneously.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>  drivers/leds/Kconfig                 |  10 +
>>  drivers/leds/Makefile                |   1 +
>>  drivers/leds/led-class-multicolor.c  | 411 +++++++++++++++++++++++++++
>>  include/linux/led-class-multicolor.h |  69 +++++
>>  4 files changed, 491 insertions(+)
>>  create mode 100644 drivers/leds/led-class-multicolor.c
>>  create mode 100644 include/linux/led-class-multicolor.h
>>
>> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
>> index a72f97fca57b..477e108fd2a7 100644
>> --- a/drivers/leds/Kconfig
>> +++ b/drivers/leds/Kconfig
>> @@ -29,6 +29,16 @@ config LEDS_CLASS_FLASH
>>  	  for the flash related features of a LED device. It can be built
>>  	  as a module.
>>  
>> +config LEDS_CLASS_MULTI_COLOR
>> +	tristate "LED Mulit Color LED Class Support"
> 
> 	              Multi

Ack

> 
>> +	depends on LEDS_CLASS
>> +	help
>> +	  This option enables the flash led sysfs class in /sys/class/leds.
> 
> 	                                LED (?)
> 

HA!  This was a copy paste from the Flash class kconfig.  I need to re-write the description anyway.

So your comments actually will turn into a bug fix for the Kconfig on that flag.

Dan
<snip>
-- 
------------------
Dan Murphy
