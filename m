Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E088C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F7A21473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YctiqwJ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfDHPmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:42:37 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36256 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfDHPmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:42:37 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x38FgQmS122896;
        Mon, 8 Apr 2019 10:42:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554738146;
        bh=ubC53etRM76aIlQ/nQNUXRTvm+KMt6BVtTYAqjDn7qg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YctiqwJ8nTtn347yUbUKQByAT2L7JloNJ2cFrgGvwlnR4CEOYHHKP7vdrxvrhfoBO
         7bBoE1XxpwcLv4UBj1JRIuJo03JDE4aGEJjBCue1kcDUdJAHSrhqP3n59TE0rUImvU
         QNHbp8UaVOuGahkuN5A6KzvaayKJxJ0wJwEbBfg0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x38FgQHC013450
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Apr 2019 10:42:26 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 8 Apr
 2019 10:42:26 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 8 Apr 2019 10:42:26 -0500
Received: from [172.22.110.173] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x38FgPmY087765;
        Mon, 8 Apr 2019 10:42:26 -0500
Subject: Re: [GIT PULL v2] LM3532 backlight support improvements and
 relocation
To:     Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <robh@kernel.org>
CC:     <lee.jones@linaro.org>, <tony@atomide.com>,
        <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190407190951.27288-1-jacek.anaszewski@gmail.com>
 <20190407221740.GA6327@amd> <20190407225011.GA9120@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <97e64469-4c09-ff6b-7bd4-c8f1580512e0@ti.com>
Date:   Mon, 8 Apr 2019 10:42:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190407225011.GA9120@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 4/7/19 5:50 PM, Pavel Machek wrote:
> Hi!
> 
>>> Changes since v1:
>>>
>>> - synchronized DT label properties in DT bindings with what has been agreed
>>>   for the patch "ARM: dts: omap4-droid4: Update backlight dt properties"
>>>
>>> The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:
>>>
>>>   Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)
>>>
>>> are available in the git repository at:
>>>
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds.git tags/lm3532-driver-improvements
>>>
>>> for you to fetch changes up to bc1b8492c764fea940fc66206047e37a7f8d77e1:
>>>
>>>   leds: lm3532: Introduce the lm3532 LED driver (2019-04-07 20:45:49 +0200)
>>>
>>> Thanks,
>>> Jacek Anaszewski
>>>
>>> ----------------------------------------------------------------
>>> LM3532 backlight driver improvements and relocation
>>> ----------------------------------------------------------------
>>> Dan Murphy (4):
>>>       dt: lm3532: Add lm3532 dt doc and update ti_lmu doc
>>
>> Sorry, this one will need more work.
>>
>> When did Rob acknowledge this? I do not remember that mail & quick
>> google does not find it.
> 
> Aha, found it now:
> 
> Date: Fri, 15 Mar 2019 18:35:01 -0500
> From: Rob Herring <robh@kernel.org>
> To: Dan Murphy <dmurphy@ti.com>
> Subject: Re: [PATCH v4 1/4] dt: lm3532: Add lm3532 dt doc and update ti_lmu doc
> 

For reference to all here is the Reviewed-by from Rob.

https://lore.kernel.org/patchwork/patch/1050412/

>  									Pavel
> 


-- 
------------------
Dan Murphy
