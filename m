Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3BEC3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34AD220828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zWVNFJKz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbfH0MDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:03:47 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45958 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbfH0MDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:03:46 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7RC3ZAq082565;
        Tue, 27 Aug 2019 07:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566907415;
        bh=Gx/FVDEvOAy9DQhXBGwcgfOgeHlRY8Nqm4MiJXluNFc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=zWVNFJKzHovUK950fX20Z7Aon5sva+WPQY/264sYvOdwm639fc7mGEPJYNJbPV8Kb
         f5EnF19GK4oKwKodnHH6tL5HQka68v4yKYoHB74c15BP5KloBgYHCjCo53N2TWuCbd
         i/dQDVfsWmPcPnpdrmkjVpeq70PIpu2Hm34zTtq4=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7RC3Zbj101492
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Aug 2019 07:03:35 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 27
 Aug 2019 07:03:35 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 27 Aug 2019 07:03:35 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7RC3ZJL071130;
        Tue, 27 Aug 2019 07:03:35 -0500
Subject: Re: [PATCH v3 1/5] leds: lm3532: Fix brightness control for i2c mode
To:     Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>
CC:     <jacek.anaszewski@gmail.com>, <sre@kernel.org>,
        <nekit1000@gmail.com>, <mpartap@gmx.net>, <merlijn@wizzup.org>,
        <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190820195307.27590-1-dmurphy@ti.com>
 <20190826215822.GY52127@atomide.com> <20190826221413.GA19124@amd>
 <20190826224437.GZ52127@atomide.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <8479fc08-f1b3-7816-ae73-425471286899@ti.com>
Date:   Tue, 27 Aug 2019 07:03:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826224437.GZ52127@atomide.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony

On 8/26/19 5:44 PM, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [190826 22:14]:
>> On Mon 2019-08-26 14:58:22, Tony Lindgren wrote:
>>> Hi,
>>>
>>> * Dan Murphy <dmurphy@ti.com> [190820 19:53]:
>>>> Fix the brightness control for I2C mode.  Instead of
>>>> changing the full scale current register update the ALS target
>>>> register for the appropriate banks.
>>>>
>>>> In addition clean up some code errors and random misspellings found
>>>> during coding.
>>>>
>>>> Tested on Droid4 as well as LM3532 EVM connected to a BeagleBoneBlack
>>>>
>>>> Fixes: e37a7f8d77e1 ("leds: lm3532: Introduce the lm3532 LED driver")
>>>> Reported-by: Pavel Machek <pavel@ucw.cz>
>>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>>> ---
>>>>
>>>> v3 - Removed register define updates - https://lore.kernel.org/patchwork/patch/1114542/
>>> Looks like starting with this patch in Linux next the LCD on droid4
>>> is so dim it's unreadable even with brightness set to 255. Setting
>>> brightness to 0 does blank it completely though.
>>>
>>> Did something maybe break with the various patch revisions or are
>>> we now missing some dts patch?
>> Maybe missing dts patch. We should provide maximum current the LED can
>> handle...
> Or i2c control is somehow broken and only als control now works?

Let me test the next branch.

I did not see this when I wrote the patches on the Droid 4.

But I did not recheck Droid 4.

Dan



> Regards,
>
> Tony
>
