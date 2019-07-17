Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A8FC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 13:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C2F208C0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 13:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OvE+rl3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfGQNr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 09:47:29 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59366 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfGQNr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 09:47:28 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6HDlKab106607;
        Wed, 17 Jul 2019 08:47:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1563371240;
        bh=KE7ll8RGnYW0NspHb1Isx+it3u3F262JZfA7NFbvB3Y=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=OvE+rl3DHZ7If/K/1iJwdCLx5InQVBbexmSEQpkQ1Kme5IQpTazoz/ueXM1ClMQ6I
         GdzxtbsgpT7rXrDsVr9Zxk10m5WmII+hj1yjSZwOhOaNtOAnTJ3ik54N8hvVcRQ5TZ
         IbT8SqyWweaUefOfxcp1QobQtlEtCzRc89qOfR5A=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6HDlK6C122361
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 17 Jul 2019 08:47:20 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 17
 Jul 2019 08:47:20 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 17 Jul 2019 08:47:20 -0500
Received: from [10.250.98.129] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6HDlIet039267;
        Wed, 17 Jul 2019 08:47:18 -0500
Subject: Re: [PATCH v2 2/2] leds: Add control of the voltage/current regulator
 to the LED core
To:     Daniel Thompson <daniel.thompson@linaro.org>
CC:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <dmurphy@ti.com>,
        <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190715155657.22976-1-jjhiblot@ti.com>
 <20190715155657.22976-3-jjhiblot@ti.com>
 <20190716105032.thpcttko5do3u56n@holly.lan>
From:   Jean-Jacques Hiblot <jjhiblot@ti.com>
Message-ID: <9497174a-65b9-bd4f-8ce3-89176930a78c@ti.com>
Date:   Wed, 17 Jul 2019 15:47:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190716105032.thpcttko5do3u56n@holly.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16/07/2019 12:50, Daniel Thompson wrote:
> On Mon, Jul 15, 2019 at 05:56:57PM +0200, Jean-Jacques Hiblot wrote:
>> A LED is usually powered by a voltage/current regulator. Let the LED core
> This is almost certainly nitpicking but since there's enough other
> review comments that you will have to respin anyway ;-)
No problems. comments are welcome.
> Is an LED really "usually powered by a voltage/current regulator"? Some
> LEDs have a software controlled power supply but I'm not sure it is
> the usual case.
True. I'll reword this.
> Likewise its a little confusing to be talking about LEDs with an
> external current regulator since, although that is possible, it is also
> one the main features provided by LED driver chips.

In my experience LED drivers are quite often current sinks. In that case 
the power is provided externally, and sometimes by a managed regulator.

Thanks,

JJ

>
> Daniel.
