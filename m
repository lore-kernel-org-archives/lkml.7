Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504E7C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F9212077B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbgAILwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 06:52:45 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:55667 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728614AbgAILwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 06:52:44 -0500
X-Originating-IP: 90.65.102.129
Received: from localhost (lfbn-lyo-1-1670-129.w90-65.abo.wanadoo.fr [90.65.102.129])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 58E2120003;
        Thu,  9 Jan 2020 11:52:42 +0000 (UTC)
Date:   Thu, 9 Jan 2020 12:52:41 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Eugen.Hristev@microchip.com
Cc:     jic23@kernel.org, robh+dt@kernel.org, Nicolas.Ferre@microchip.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, a.zummo@towertech.it,
        Ludovic.Desroches@microchip.com
Subject: Re: [PATCH 04/10] rtc: at91rm9200: use of_platform_populate as
 return value
Message-ID: <20200109115241.GX3040@piout.net>
References: <1576686157-11939-1-git-send-email-eugen.hristev@microchip.com>
 <1576686157-11939-5-git-send-email-eugen.hristev@microchip.com>
 <20191218164348.GN695889@piout.net>
 <04264cb0-61a9-aba3-82ad-e7d12fd8441e@microchip.com>
 <20191218165831.GO695889@piout.net>
 <91cc67e1-7e14-f7b9-da77-b16d9e158f20@microchip.com>
 <20191219102321.GR695889@piout.net>
 <20191223111636.4698123b@archlinux>
 <7e67d601-e17e-f82c-edeb-824fc3dd89db@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e67d601-e17e-f82c-edeb-824fc3dd89db@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/2020 11:19:45+0000, Eugen.Hristev@microchip.com wrote:
> I started to work on this, I am trying to add and probe the 
> rtc_adc_trigger with platform_device_add.
> 
> However, some issues arise: this means that the rtc_adc_trigger will not 
> be OF-compatible, so, how can I identify the driver to probe ?
> Second, by adding a new platform device from the RTC driver, would mean 
> that I would have to supply it's probe/remove functions, which I cannot 
> have here. Those are in the rtc_adc_trigger iio driver.
> 
> In fact, the question is, which is the mechanism you suggested, to be 
> able to probe the rtc_adc_trigger, from inside the rtc driver, without 
> using a child node in DT, as you requested ?
> The rtc_adc_trigger needs a MEM resource, and a parent, and it must 
> reside inside the IIO subsystem.
> 

As suggested earlier in the thread, you can use platform_add_device
which fits all your requirements.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
