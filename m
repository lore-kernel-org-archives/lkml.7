Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CAFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2252087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfCLOto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:49:44 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40863 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfCLOtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:49:43 -0400
Received: by mail-ed1-f65.google.com with SMTP id r23so2530780edm.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 07:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0tE4/XIt59mjUidEVb82cePCrd8MzutbHAUiK/qFDsQ=;
        b=OsZ0wIbdanVREuAA47pSZY/QdyHjDe9dEwjwXRD/6R+KO34CigPgrwRP6LdQkJddYf
         jPhzArFoiB0J/1smfYz1ZiFRHhyt+WkIshItSJdDd27gFerNgU53CvXZyTEywWjyeU3i
         xgO4HpvluUVK4+YXVuvwnA0LgjI06e9mdJtuqmt3izRe6MZXFP/va1ChnxXouRa+2cKN
         jX1J8Q0K569BivPdrhXuyU9YXbU81vyALCH+CaaRGRklAUMnBGAVBUK/hxvHfMLanvzd
         96uz3fCinX+6UcOSpPTusMJQDjmGmuYFYSgBzPMzlyrUbLR7+/utwHkLUMsCilQb+Y87
         5cnw==
X-Gm-Message-State: APjAAAXcev8+iXs7MFrZXwWQTQ0rrdtKQWuEcx+5uaLwJAgOKSsqOQ/c
        CYMH6UIs7LEiYV89zjkz/E7q6jxyQ0U=
X-Google-Smtp-Source: APXvYqyQd1l+0Mk27QnIgxHOdAzyTS+xrkzklofF6a1+qu0SilTQzb5ItQMxD0eLz7TchTDK4tL91g==
X-Received: by 2002:a50:cb49:: with SMTP id h9mr3639785edi.197.1552402180969;
        Tue, 12 Mar 2019 07:49:40 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id p10sm399812eds.81.2019.03.12.07.49.39
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 07:49:40 -0700 (PDT)
Subject: Re: [PATCH 1/2] i2c: i2c-designware-platdrv: Allow a dynamic adap. nr
 without an ACPI fwnode
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>, linux-i2c@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190311112216.31391-1-hdegoede@redhat.com>
 <20190311112216.31391-2-hdegoede@redhat.com>
 <20190311125207.GR9224@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4437cb77-ae48-bcc9-56cc-e81e9da011a8@redhat.com>
Date:   Tue, 12 Mar 2019 15:49:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190311125207.GR9224@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11-03-19 13:52, Andy Shevchenko wrote:
> On Mon, Mar 11, 2019 at 12:22:15PM +0100, Hans de Goede wrote:
>> Before this commit the i2c-designware-platdrv assumes that if the pdev
>> has an apci-companion it should use a dynamic adapter-nr and otherwise
>> it will use pdev->id as adapter-nr.
>>
>> On some devices e.g. the Apollo Lake using Acer TravelMate Spin B118,
>> some of the LPSS i2c-adapters are enumerated through PCI and do not have
>> an ACPI fwnode. These devices are handled as mfd devices so they end up
>> using the i2c-designware-platdrv driver.
>>
>> This results in the i2c-adapter being registered with the mfd generated
>> pdev->id as adapter-nr, which conflicts with existing adapters, triggering
>> a WARN(id < 0, "couldn't get idr") in i2c-core-base.c and causing the
>> adapter registration to fail.
>>
>> This commit adds support for setting a "linux,use-dynamic-adapter-nr"
>> device property on the device to make i2c-designware-platdrv use dynamic
>> adapter-nrs on devices without an ACPI fwnode, together with changes to
>> drivers/mfd/intel-lpss-pci.c to set this, this fixes the WARN.
>>
> 
>> Before this commit the setting of the adapter.nr was somewhat convoluted,
>> in the acpi_companion case it was set from dw_i2c_acpi_configure, in the
>> non acpi_companion case it was set from dw_i2c_set_fifo_size() based on
>> tx_fifo_depth not being set yet. This commit also cleans this up.
> 
> Can we split this to two patches, i.e. one is almost the same as this one,
> except the second one adds a new property check to the conditional?

Ok, I've split the patch for v2 of the series.

> If you agree to do so, you may add mine Rb tag to the first one out of three.
> 
>> Note the "linux,use-dynamic-adapter-nr" is meant for kernel internal use
>> only, therefor it is NOT documented under Documents/devicetree/bindings.
> 
> To the second and third ones, can we rather check if the device has fwnode
> either ACPI or swnode? AFAIU now we have swnode assigned during MFD device
> registration and can easily distinguish this w/o any additional properties.

Detecting a swnode is non trivial, it may be either the primary or secondary
fwnode depending if the device already had a node before calling
device_add_properties.

More importantly deciding this based on the presence of a swnode feels like
its "wrong".

But I've come up with a better solution. I've analyzed all ways a designware_i2c
compatible platform-device can be instantiated and all cases except for:

drivers/mfd/intel_quark_i2c_gpio.c
drivers/mfd/intel-lpss-pci.c

Are always using dynamic adapter numbers already. The Quark X1000 has only
1 i2c controller, so there using dynamic adapter numbers will not make a
difference.

And the intel-lpss-pci.c case is the one which we actually want to fix,
devices using this code have many i2c busses so using a fixed bus number
leads to the bus-number conflicts this patch is trying to fix.

So we can simply always use dynamic adapter numbers, see the commit message
of the second patch in v2 of this series for the full analysis.

Regards,

Hans
