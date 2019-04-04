Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B257C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1EE2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="E5xS03X6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbfDDTXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:23:45 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:42642 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730275AbfDDTXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 15:23:45 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x34JNbnI078945;
        Thu, 4 Apr 2019 14:23:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554405817;
        bh=DGkc/VfGsLgtv4bR0og0NgUmtBX9VcmZUbsKQUVlX4I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=E5xS03X6aKqNoGAFujvdbvH9vbtTf854ZGavPmlrX4gLBFJhTr6vTS3StPAgxWZrj
         nkZf58jNXMMYcEEx6UlnKw2oVFnQa1EJHQ+DKhOZt8wb+a+xJ59537RClYbKgK9Xm6
         XtOg/adpdAygSY/aMDGo5vomBRoT4Xh2SnmtQ87g=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x34JNbgZ103384
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Apr 2019 14:23:37 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 4 Apr
 2019 14:23:37 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 4 Apr 2019 14:23:37 -0500
Received: from [172.22.84.10] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x34JNaNu015463;
        Thu, 4 Apr 2019 14:23:37 -0500
Subject: Re: [PATCH 4/4] leds: lm3532: Introduce the lm3532 LED driver
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Tony Lindgren <tony@atomide.com>
CC:     <robh+dt@kernel.org>, <pavel@ucw.cz>, <lee.jones@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>
References: <20190321142838.22985-1-dmurphy@ti.com>
 <20190321142838.22985-4-dmurphy@ti.com> <20190404000909.GY49658@atomide.com>
 <f4c0a946-fd0f-0071-0039-cfaea2f27ccc@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <f278edc7-1614-0410-9aa7-2e3a6fc7818b@ti.com>
Date:   Thu, 4 Apr 2019 14:23:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f4c0a946-fd0f-0071-0039-cfaea2f27ccc@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony

On 4/4/19 1:48 PM, Jacek Anaszewski wrote:
> Hi Tony,
> 
> Thanks for the feedback.
> 
> On 4/4/19 2:09 AM, Tony Lindgren wrote:
>> * Dan Murphy <dmurphy@ti.com> [190321 14:29]:
>>> Introduce the Texas Instruments LM3532 White LED driver.
>>> The driver supports ALS configurability or manual brightness
>>> control.
>>>
>>> The driver also supports associating LED strings with specific
>>> control banks in a group or as individually controlled strings.
>>
>> I'm seeing slightly different naming under /sys/class/leds:
>>
>> lm3532:backlight
>> lm3532:platform::kbd_backlight
> 
> The problem is in the "platform:" being a part of DT
> label property. It should not be included there if devicename
> section is added in the driver.
> 

Feel free to make it whatever you want I am not married to the naming convention for Droid 4.
It was a suggestion in the code review

https://lore.kernel.org/patchwork/patch/1048806/

<snip>



-- 
------------------
Dan Murphy
