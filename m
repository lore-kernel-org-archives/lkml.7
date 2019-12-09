Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D5CC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 15:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029E420726
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 15:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="T0U0RYf/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfLIPFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 10:05:35 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58534 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfLIPFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 10:05:34 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB9F5NDJ130665;
        Mon, 9 Dec 2019 09:05:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575903923;
        bh=XNER3J3YDTiVz49WC0ITFYur4Q7s4xSP545U1ahkPeo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=T0U0RYf/NxPInPqdVS5xs2WZZqG02iJDAD6F3Fi/9Ru2MTZgY5jrzUAHSL5x2Mn7c
         C/scQrm8z/1tV/bKh/5RYQhZMg/WnwCnCS6pU9HRkzO3LX56MfuOC5hVfooU8pMMUV
         4vH+/j/+UmC6uPtytAJJStE5PSY/QBp6mWjvuQFY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB9F5NDt108360
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Dec 2019 09:05:23 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 9 Dec
 2019 09:05:22 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 9 Dec 2019 09:05:21 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB9F5JIq111204;
        Mon, 9 Dec 2019 09:05:20 -0600
Subject: Re: [PATCH v3 2/2] drm/bridge: tc358767: Expose test mode
 functionality via debugfs
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
CC:     <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>
References: <20191209050857.31624-1-andrew.smirnov@gmail.com>
 <20191209050857.31624-3-andrew.smirnov@gmail.com>
 <45afdff8-4f91-f5be-a299-d0c7fed71ea7@ti.com>
 <CAHQ1cqH8XTYysd1Nv2Q0EziXfJWeemZeyyZZ3OKoCv8=XrHZWA@mail.gmail.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <f873e4de-eabf-2746-8ad8-3d3c7d64a270@ti.com>
Date:   Mon, 9 Dec 2019 17:05:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAHQ1cqH8XTYysd1Nv2Q0EziXfJWeemZeyyZZ3OKoCv8=XrHZWA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2019 16:38, Andrey Smirnov wrote:
> On Mon, Dec 9, 2019 at 1:38 AM Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>>
>> (Cc'ing Daniel for the last paragraph)
>>
>> On 09/12/2019 07:08, Andrey Smirnov wrote:
>>> Presently, the driver code artificially limits test pattern mode to a
>>> single pattern with fixed color selection. It being a kernel module
>>> parameter makes switching "test pattern" <-> "proper output" modes
>>> on-the-fly clunky and outright impossible if the driver is built into
>>> the kernel.
>>
>> That's not correct, /sys/module/tc358767/parameters/test is there even if the driver is built-in.
>>
> 
> True, I'll drop the "impossible" part of the descrption. Having to
> unbind and bind device to the driver to use that parameter definitely
> falls under "clunky" for me still, so I'll just stick to that in the
> description.

You don't need to re-bind. You can change the module parameter at runtime, and if the driver happens 
to use the value, then it uses the new value. If I recall right, changing the module parameter and 
then doing a full modeset from userspace made the driver to use the test mode (I'm not 100% sure, 
though).

In any case, I'm not advocating for the use of module parameter here =)

>> Hmm, actually, just echoing 0 to tstctl multiple times, it makes the screen go black and then
>> restores it with every other echo.
>>
> 
> Strange, works on my setup every time. No error messages in kernel log
> I assume? Probably unrelated, but when you echo "0" and the screen

No errors.

> stays black, what do you see in DP_SINK_STATUS register:
> 
> dd if=/dev/drm_dp_aux0 bs=1 skip=$((0x205)) count=1 2>/dev/null | hexdump -Cv
> 
> ? Note that this needs CONFIG_DRM_DP_AUX_CHARDEV to be enabled.

I'll check this later, and do a few more tests.

>>> +     debugfs = debugfs_create_dir(dev_name(dev), NULL);
>>> +     if (!IS_ERR(debugfs)) {
>>> +             debugfs_create_file_unsafe("tstctl", 0200, debugfs, tc,
>>> +                                        &tc_tstctl_fops);
>>> +             devm_add_action_or_reset(dev, tc_remove_debugfs, debugfs);
>>> +     }
>>> +
>>
>> For me this creates debugfs/3-000f/tstctl. I don't think that's a clear or usable path, and could
>> even cause a name conflict in the worst case.
>>
> 
> I agree on usability aspect, but I am not sure I can see how a
> conflict can happen. What scenario do you have in mind that would
> cause that? My thinking was that the combination of I2C bus number +
> I2C address should always be unique on the system, but maybe I am
> missing something?

Well, the dir name doesn't have "i2c" anywhere, so at least in theory, some other bus could have 
"3-000f" address too.

Maybe bigger problem is that it's not at all obvious what "3-000f" means. All the other debugfs dirs 
make sense when you look at the name, and "3-000f" looks very odd there.

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
