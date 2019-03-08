Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B912AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D222087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DG7sOVlr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfCHN2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:28:41 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34148 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfCHN2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:28:40 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x28DSYOI119809;
        Fri, 8 Mar 2019 07:28:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552051714;
        bh=/5bTgZWk45LxLNK1weT54abNef08D7JFiCuh3dsPBcY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=DG7sOVlrtNLqPZfD+9ruVv5IdfOo6rEhlt7XNgoGves9ealPP6stHy9z/X6JCz8/T
         OCrk/H1kyc3Z7fOHu2Brlvrs3E0TNzeTArtVO5u8TUSZxViRS7VBZYfOwOnAgmrKuq
         nXwRFMieS7mUDqXxrKyhhk9jHIxni0B4ACDEmIh4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x28DSYTn070108
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Mar 2019 07:28:34 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 8
 Mar 2019 07:28:33 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 8 Mar 2019 07:28:33 -0600
Received: from [172.22.114.154] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x28DSXY5019193;
        Fri, 8 Mar 2019 07:28:33 -0600
Subject: Re: [PATCH 4/4] leds: lm3532: Introduce the lm3532 LED driver
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <tony@atomide.com>, <lee.jones@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20190307220947.20057-1-dmurphy@ti.com>
 <20190307220947.20057-4-dmurphy@ti.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <f618b1dc-abf2-88ba-9b73-1a70471adc6b@ti.com>
Date:   Fri, 8 Mar 2019 07:28:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190307220947.20057-4-dmurphy@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On 3/7/19 4:09 PM, Dan Murphy wrote:
> Introduce the Texas Instruments LM3532 White LED driver.
> The driver supports ALS configurability or manual brightness
> control.
> 
> The driver also supports associating LED strings with specific
> control banks in a group or as individually controlled strings.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  drivers/leds/Kconfig                   |  10 +
>  drivers/leds/Makefile                  |   1 +
>  drivers/leds/leds-lm3532.c             | 595 +++++++++++++++++++++++++
>  include/dt-bindings/leds/leds-lm3532.h |  72 +++
>  4 files changed, 678 insertions(+)
>  create mode 100644 drivers/leds/leds-lm3532.c
>  create mode 100644 include/dt-bindings/leds/leds-lm3532.h
> 

After thinking about this dt header I am not happy about having it.
I am thinking of removing this file completely and doing some calculations in the driver
file for the impedance, averaging time and ramp times.

I would still like to get comments on the rest of the code but in v2 the dt bindings header will
go away.

Dan

<snip>
-- 
------------------
Dan Murphy
