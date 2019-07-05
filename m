Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C6BC4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0068921852
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zR9tdtpe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbfGELfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 07:35:01 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35274 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfGELfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 07:35:01 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x65BYpDq096314;
        Fri, 5 Jul 2019 06:34:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1562326491;
        bh=blnoL/MWFQnzkGsn5dq36BMBYhm1XiyMPpTo0t1/e6I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=zR9tdtpeup1SDfhhyN5dDMB3l6l9mjNL7EW1niy+QvfOSHjDcQZoBbenpuod3nXpQ
         QMhM+CZPY/OzVCgZ/HV7E6kCPvBT3534sIbqKZy58BuGiFjnQvUV9oQsTbZKG4PMVj
         8Q2m67GBRcn5ljvu3knFGoQd8iwBa+tn9MFOSXYU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x65BYo8j013814
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Jul 2019 06:34:51 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 5 Jul
 2019 06:34:50 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 5 Jul 2019 06:34:50 -0500
Received: from [10.250.97.31] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x65BYmXQ070978;
        Fri, 5 Jul 2019 06:34:48 -0500
Subject: Re: [PATCH 0/4] Add a generic driver for LED-based backlight
To:     Pavel Machek <pavel@ucw.cz>
CC:     <jacek.anaszewski@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <lee.jones@linaro.org>,
        <daniel.thompson@linaro.org>, <jingoohan1@gmail.com>,
        <dmurphy@ti.com>, <linux-leds@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <tomi.valkeinen@ti.com>
References: <20190701151423.30768-1-jjhiblot@ti.com>
 <20190705101434.fw5rpctnqt6dwg6e@devuan>
From:   Jean-Jacques Hiblot <jjhiblot@ti.com>
Message-ID: <e8f24c10-1d88-139c-d0ee-500473ecbe53@ti.com>
Date:   Fri, 5 Jul 2019 13:34:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190705101434.fw5rpctnqt6dwg6e@devuan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05/07/2019 12:14, Pavel Machek wrote:
> On Mon 2019-07-01 17:14:19, Jean-Jacques Hiblot wrote:
>>
>> This series takes it from there and implements the binding that was
>> discussed in https://patchwork.kernel.org/patch/7293991/. In this new
>> binding the backlight device is a child of the LED controller instead of
>> being another platform device that uses a phandle to reference a LED.
> Other option would be to have backlight trigger. What are
> advantages/disadvantages relative to that?

I don't know how this would fit in the model where multiple panels are 
used, each with its own backlight.

Also the notification is only about blanking.

> 									Pavel
>
