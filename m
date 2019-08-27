Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D25C3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 03:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E070B2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 03:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZ/bEeo+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbfH0Dvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 23:51:46 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42664 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbfH0Dvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 23:51:45 -0400
Received: by mail-pf1-f194.google.com with SMTP id i30so13170660pfk.9;
        Mon, 26 Aug 2019 20:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uzw991Nd9jKGjk5uiYDdWpoGos7yXqXk1ZGkmJpLpEc=;
        b=VZ/bEeo+JL0jEB5ajc2gQ8c0lAQWsCg5gV7chmk0uvbopRZahtryHkP6pu2LfI1kJv
         isK0BI2HdUHIqMK6fshtaQ4+Q5Diip+Gv7/lohTtwkpwUYur99cozGU9M99bb6kzRTtk
         eb/ha+mOsD+n5ONGq3fpWc9B52f/i062cvudEoXmRt4ydGKk5hoaVq6xsZGahoQLSgsp
         lOD1fArESLDxXiUeAxaUa0wKKRwSN/6Xy2YCRM2ctTXQlcfUbdjrvfs3PRKEdR1vjrSJ
         bXM3pW4AEg+oJaIAW4NVWyv1PJvTNWS0OSbtUHS+8K3rRLTmDo2dKiIWQfmsVSY4qskw
         WFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uzw991Nd9jKGjk5uiYDdWpoGos7yXqXk1ZGkmJpLpEc=;
        b=fzahIZBGOXY2OEikMXCTm41LtfYNRU/+czXZgVrBfF6wQ2l7hM0q5Oi9mMJZw7+Xa/
         15F2JzDZxIMU/tDQzA68uFqf+SUYmxjIyF6a0CBOpFB8nOukPdfaUujq9rdakem3wQXm
         7/b5rEjp+YIo3yaWNlFqT5PZRKd6CJUyDYhuuUViL5bclK6OFOG0BmNQM6aFIZ/81eW9
         XpnjUnQDlJa/kvStidpk1b1Fdv2OvOuwUc5qRMtor+8paAW6xb79WznW+RLaYnVorqbv
         MEbr5ZZ8OWG2HM4xTfk7XCuusfDy+ZtqF6mL6ZMUhkkL5X/Ch6sBysok7AbqL6Bo9kqQ
         smsw==
X-Gm-Message-State: APjAAAXQl1aiXpJECYsx64O9pfXsbx7nQ0Wx/VJpD0NLMYW+mh3HxONs
        JVWUM9gGlyKm6JFcglQ+2CdC23dL
X-Google-Smtp-Source: APXvYqwMSCQaA5x5qIUZLvllnP98gD/Ag8iZwbgHtzXNc4bCbFCMJoYX8ghjfU7J1gfOnZZ2LLNOsQ==
X-Received: by 2002:a65:6406:: with SMTP id a6mr17840286pgv.393.1566877904887;
        Mon, 26 Aug 2019 20:51:44 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id y16sm13799827pfn.173.2019.08.26.20.51.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 20:51:43 -0700 (PDT)
Subject: Re: [PATCH 1/2] hwmon: Add Synaptics AS370 PVT sensor driver
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190826174942.2b28ff05@xhacker.debian>
 <20190826175029.433632f6@xhacker.debian>
 <35b05950-4a72-9e00-50ab-ecd0a7e759a4@roeck-us.net>
 <20190827105110.0be8d669@xhacker.debian>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e0bfae1c-07f5-f907-0003-2c2f959e8099@roeck-us.net>
Date:   Mon, 26 Aug 2019 20:51:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827105110.0be8d669@xhacker.debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/19 8:02 PM, Jisheng Zhang wrote:
> Hi Guenter,
> 
> On Mon, 26 Aug 2019 06:44:34 -0700 Guenter Roeck wrote:
> 
>>
>>
>> On 8/26/19 3:01 AM, Jisheng Zhang wrote:
>>> Add a new driver for Synaptics AS370 PVT sensors. Currently, only
>>> temperature is supported.
>>>
>>> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
>>> ---
>>>    drivers/hwmon/Kconfig       |  10 +++
>>>    drivers/hwmon/Makefile      |   1 +
>>>    drivers/hwmon/as370-hwmon.c | 158 ++++++++++++++++++++++++++++++++++++
>>>    3 files changed, 169 insertions(+)
>>>    create mode 100644 drivers/hwmon/as370-hwmon.c
>>>
>>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>>> index 650dd71f9724..d31610933faa 100644
>>> --- a/drivers/hwmon/Kconfig
>>> +++ b/drivers/hwmon/Kconfig
>>> @@ -246,6 +246,16 @@ config SENSORS_ADT7475
>>>          This driver can also be built as a module. If so, the module
>>>          will be called adt7475.
>>>
>>> +config SENSORS_AS370
>>> +     tristate "Synaptics AS370 SoC hardware monitoring driver"
>>
>> I think this needs "depends on HAS_IOMEM".
> 
> HWMON depends on HAS_IOMEM, so the dependency has been required
> by the common HWMON, we don't need it here.
> 

This is so wrong :-(. As if I2C or SPI based sensor chips would
require iomem. Oh well, no one complained in 12+ years, so I guess
we are "fine", at least for the time being.

Thanks for noticing.

Guenter
