Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B20CA9ED3
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 04:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFFE215EA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 04:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaFAH/Yq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfKCExk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 00:53:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39912 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfKCExk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 00:53:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id x28so6667278pfo.6;
        Sat, 02 Nov 2019 21:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5/13KcmLPI0bN8HRF/7zYPWlnhQwokAxPHIa/JyvfeM=;
        b=WaFAH/YqpChvdHCIf9fj1bOuaKgJUVJiZdCLc9L7GTm0+Ysoj3FE1kegXpZo3ONpH0
         IfKZtq1VgqOrI+7nRgxZiDAMbIZfNSKGekSfT46DwOojNzLCm1pjugohJUxbicHys17k
         gfmv0TfjUTP+13QJhXPUKMmwrF29jjCWkzoOs6PRx5dOfJND6VhIgDfKYYZkX2kwSta7
         bQ6Vsji75jlzdIp6Q1OJjeug1HFUkvDY4IeTXNoTBqenmgUCCHqok3K4ko3ni1zjE/nt
         KeIbYUpTGsKf9drZ+LGi/x2yOfoAqUVYoEqBTvVZdn/+4iEQMVitk/U8HZyYg333v3W+
         3ueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5/13KcmLPI0bN8HRF/7zYPWlnhQwokAxPHIa/JyvfeM=;
        b=ReeoE50SMXB+vn6uFbympU3t8XqSiEKfmX4Md0Y/KfA2NbNPF1gPnGQPFwxCZFz1Cr
         0KBVOS634v/oysHptqLIRb0tP0Rk/R247s2GaChwLPgGwrd4kbmN3BrkvqLOa9NBTWeb
         BtI3ylei2tBGuTCdNrVAEf32RZtdt+WQ1yfaMAzK1UFU9jG0KeV1cBk8oEWRAv4vSAZk
         JUTMml0Nwq3mVX8QkThs+Dv0LpKA07nNkchJ391YuFc8W2dh3p0Y9Ssuk4MApbWtT2s3
         1UbrRztcU/s9DhtaupB3cuPpXydHsB5+af6J7RfSYi/q5UCSWCv+uSX0vO0Ecvzm9h3v
         KSgQ==
X-Gm-Message-State: APjAAAVgfIplzr66lTEgiU57No28AW8AcbmcNDtQWfpm8Z6lBeFqKc7Y
        3/DOcFE4k1y7I5+gbMur6DXOYUvc
X-Google-Smtp-Source: APXvYqw0PSv3xkM313s1KctMFadu5FuMdjk59YKkKBiB7gsLzZ+QrGsGTzH8uFnN5XB7+CV0CJY6JQ==
X-Received: by 2002:a62:1b4a:: with SMTP id b71mr23836921pfb.167.1572756819354;
        Sat, 02 Nov 2019 21:53:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 10sm11652109pgs.11.2019.11.02.21.53.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Nov 2019 21:53:38 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] docs: hwmon: Document bel-pfe pmbus driver
To:     Tao Ren <rentao.bupt@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        taoren@fb.com
References: <20191029182054.32279-1-rentao.bupt@gmail.com>
 <20191029182054.32279-3-rentao.bupt@gmail.com>
 <20191102153115.GA5205@roeck-us.net>
 <20191103044432.GA3364@taoren-ubuntu-R90MNF91>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <0b5c8a99-db37-5c13-ded8-f3ee611340e8@roeck-us.net>
Date:   Sat, 2 Nov 2019 21:53:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191103044432.GA3364@taoren-ubuntu-R90MNF91>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/19 9:44 PM, Tao Ren wrote:
> On Sat, Nov 02, 2019 at 08:31:15AM -0700, Guenter Roeck wrote:
>> On Tue, Oct 29, 2019 at 11:20:54AM -0700, rentao.bupt@gmail.com wrote:
>>> From: Tao Ren <rentao.bupt@gmail.com>
>>>
>>> Add documentation for bel-pfe pmbus driver which supports BEL PFE1100 and
>>> PFE3000 power supplies.
>>>
>>> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
>>
>> Applied after adding bel-pfe to index.rst.
>>
>> Thanks,
>> Guenter
> 
> Thank you Guenter. I didn't know index.rst needs to be updated; will
> do it for my future doc patches.
> 
No worries. This is a result of the effort to convert the documentation
to .rst format, which makes everything a bit more difficult (such as
the need to add new files to the index). I am still getting used to
it myself.

Guenter

> 
> Cheers,
> 
> Tao
> 
>>> ---
>>>   No change in v2.
>>>
>>>   Documentation/hwmon/bel-pfe.rst | 112 ++++++++++++++++++++++++++++++++
>>>   1 file changed, 112 insertions(+)
>>>   create mode 100644 Documentation/hwmon/bel-pfe.rst
>>>
>>> diff --git a/Documentation/hwmon/bel-pfe.rst b/Documentation/hwmon/bel-pfe.rst
>>> new file mode 100644
>>> index 000000000000..4b4a7d67854c
>>> --- /dev/null
>>> +++ b/Documentation/hwmon/bel-pfe.rst
>>> @@ -0,0 +1,112 @@
>>> +Kernel driver bel-pfe
>>> +======================
>>> +
>>> +Supported chips:
>>> +
>>> +  * BEL PFE1100
>>> +
>>> +    Prefixes: 'pfe1100'
>>> +
>>> +    Addresses scanned: -
>>> +
>>> +    Datasheet: https://www.belfuse.com/resources/datasheets/powersolutions/ds-bps-pfe1100-12-054xa.pdf
>>> +
>>> +  * BEL PFE3000
>>> +
>>> +    Prefixes: 'pfe3000'
>>> +
>>> +    Addresses scanned: -
>>> +
>>> +    Datasheet: https://www.belfuse.com/resources/datasheets/powersolutions/ds-bps-pfe3000-series.pdf
>>> +
>>> +Author: Tao Ren <rentao.bupt@gmail.com>
>>> +
>>> +
>>> +Description
>>> +-----------
>>> +
>>> +This driver supports hardware monitoring for below power supply devices
>>> +which support PMBus Protocol:
>>> +
>>> +  * BEL PFE1100
>>> +
>>> +    1100 Watt AC to DC power-factor-corrected (PFC) power supply.
>>> +    PMBus Communication Manual is not publicly available.
>>> +
>>> +  * BEL PFE3000
>>> +
>>> +    3000 Watt AC/DC power-factor-corrected (PFC) and DC-DC power supply.
>>> +    PMBus Communication Manual is not publicly available.
>>> +
>>> +The driver is a client driver to the core PMBus driver. Please see
>>> +Documentation/hwmon/pmbus.rst for details on PMBus client drivers.
>>> +
>>> +
>>> +Usage Notes
>>> +-----------
>>> +
>>> +This driver does not auto-detect devices. You will have to instantiate the
>>> +devices explicitly. Please see Documentation/i2c/instantiating-devices.rst for
>>> +details.
>>> +
>>> +Example: the following will load the driver for an PFE3000 at address 0x20
>>> +on I2C bus #1::
>>> +
>>> +	$ modprobe bel-pfe
>>> +	$ echo pfe3000 0x20 > /sys/bus/i2c/devices/i2c-1/new_device
>>> +
>>> +
>>> +Platform data support
>>> +---------------------
>>> +
>>> +The driver supports standard PMBus driver platform data.
>>> +
>>> +
>>> +Sysfs entries
>>> +-------------
>>> +
>>> +======================= =======================================================
>>> +curr1_label		"iin"
>>> +curr1_input		Measured input current
>>> +curr1_max               Input current max value
>>> +curr1_max_alarm         Input current max alarm
>>> +
>>> +curr[2-3]_label		"iout[1-2]"
>>> +curr[2-3]_input		Measured output current
>>> +curr[2-3]_max           Output current max value
>>> +curr[2-3]_max_alarm     Output current max alarm
>>> +
>>> +fan[1-2]_input          Fan 1 and 2 speed in RPM
>>> +fan1_target             Set fan speed reference for both fans
>>> +
>>> +in1_label		"vin"
>>> +in1_input		Measured input voltage
>>> +in1_crit		Input voltage critical max value
>>> +in1_crit_alarm		Input voltage critical max alarm
>>> +in1_lcrit               Input voltage critical min value
>>> +in1_lcrit_alarm         Input voltage critical min alarm
>>> +in1_max                 Input voltage max value
>>> +in1_max_alarm           Input voltage max alarm
>>> +
>>> +in2_label               "vcap"
>>> +in2_input               Hold up capacitor voltage
>>> +
>>> +in[3-8]_label		"vout[1-3,5-7]"
>>> +in[3-8]_input		Measured output voltage
>>> +in[3-4]_alarm           vout[1-2] output voltage alarm
>>> +
>>> +power[1-2]_label	"pin[1-2]"
>>> +power[1-2]_input        Measured input power
>>> +power[1-2]_alarm	Input power high alarm
>>> +
>>> +power[3-4]_label	"pout[1-2]"
>>> +power[3-4]_input	Measured output power
>>> +
>>> +temp[1-3]_input		Measured temperature
>>> +temp[1-3]_alarm         Temperature alarm
>>> +======================= =======================================================
>>> +
>>> +.. note::
>>> +
>>> +    - curr3, fan2, vout[2-7], vcap, pin2, pout2 and temp3 attributes only
>>> +      exist for PFE3000.
> 

