Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81612C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432682084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ua5rusBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfDCMCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 08:02:15 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49142 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfDCMCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 08:02:15 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x33C29gq047496;
        Wed, 3 Apr 2019 07:02:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554292929;
        bh=mECdlB4+A/4stB0JqhAxmchCg1yixa1lztrtSenNZfg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ua5rusBLCyiXdorPsE7ocimw98dImVtfjLN9wqZgUEjHAjNC8Bq7DeOqHQ92tPEYU
         oAtDfaww+W6xZ951sDz7dpH2MC56bLV8LnYpQIa+1uCfIjmr+1B3ItRkUGQ99vWCpW
         T7fprsOAZab722bkJyFjP3SuM4oFcZR8wM6aV9tM=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x33C29O7063165
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 3 Apr 2019 07:02:09 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 3 Apr
 2019 07:02:08 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 3 Apr 2019 07:02:08 -0500
Received: from [172.22.122.115] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x33C28Qp099533;
        Wed, 3 Apr 2019 07:02:08 -0500
Subject: Re: [PATCH 0/5] TI LMU rework
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
References: <20190325142403.30447-1-dmurphy@ti.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <1037091e-1f4a-3922-16ee-282253dad7e0@ti.com>
Date:   Wed, 3 Apr 2019 07:02:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190325142403.30447-1-dmurphy@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On 3/25/19 9:23 AM, Dan Murphy wrote:
> All
> 
> I know that it has been a long time but I put some additional effort into this
> code.  The TI LMU common code right now handles brightness and ramp up/down
> setting for the LM3697.  This so far are the common features I could find.
> 
> The LM3697 driver has the ability to assign HVLED strings to specific control
> banks as well as assigning different max brightnesses to these strings.
> 
> Fault monitoring was removed as the data sheet indicates that this is for
> production tests only.
> 
> I have plans to add additional LED drivers to use the TI LMU but I figured trying
> to add all of them at once would be a daunting review and probably wrought with 
> problems.
> 

I have a new device I need to add to the TI LMU code LM36274.
This will use the MFD ti-lmu code and I will need to create the backlight and regulator drivers.

I need to know how to proceed.  I can base the work off of the LM3532 patchset or use what is in mainline
or base it off this patchset.  The LM36274 would use the ti-lmu-led-common code for brightness setting but the
ramping times are different.

Please let me know how to proceed.

Dan

> Dan
> 
> Dan Murphy (5):
>   dt-bindings: mfd: Update the ramp up/down property
>   leds: TI LMU: Add common code for TI LMU devices
>   dt-bindings: ti-lmu: Modify dt bindings for the LM3697
>   mfd: ti-lmu: Remove support for LM3697
>   leds: lm3697: Introduce the lm3697 driver
> 
>  .../devicetree/bindings/leds/leds-lm3697.txt  |  77 ++++
>  .../devicetree/bindings/mfd/ti-lmu.txt        |  42 +-
>  drivers/leds/Kconfig                          |  14 +
>  drivers/leds/Makefile                         |   2 +
>  drivers/leds/leds-lm3697.c                    | 401 ++++++++++++++++++
>  drivers/leds/ti-lmu-led-common.c              | 131 ++++++
>  drivers/mfd/Kconfig                           |   2 +-
>  drivers/mfd/ti-lmu.c                          |  17 -
>  include/linux/mfd/ti-lmu-register.h           |  44 --
>  include/linux/mfd/ti-lmu.h                    |   1 -
>  include/linux/ti-lmu-led-common.h             |  44 ++
>  11 files changed, 682 insertions(+), 93 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3697.txt
>  create mode 100644 drivers/leds/leds-lm3697.c
>  create mode 100644 drivers/leds/ti-lmu-led-common.c
>  create mode 100644 include/linux/ti-lmu-led-common.h
> 


-- 
------------------
Dan Murphy
