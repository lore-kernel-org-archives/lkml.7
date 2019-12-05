Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81DEC2BD09
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 10:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98DC124648
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 10:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXinTFDY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbfLEKxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 05:53:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31463 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729099AbfLEKxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 05:53:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575543214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N9MiSBkYrxLRkaMO4KvAeXN7MtJgEoseaGFx+AejKDY=;
        b=NXinTFDYwVfmXdCQboBEJ1YMb0Hn+oAU4OyKgqOVI7YzyzKdam6C8OdxwvhAkgjqDrjuik
        X2SGF4aGpAM370rIxuv6Nq390EHM4D4NkpfMJBbYLJa/bYSOXSf8L7TcI86RE9qrWk1IpM
        IAp5xPdazTbn+SBigHS4jSEjdJWTTtI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-oPqQrZWzMAuonqEFauweYg-1; Thu, 05 Dec 2019 05:53:31 -0500
Received: by mail-wm1-f72.google.com with SMTP id z2so722052wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 02:53:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N9MiSBkYrxLRkaMO4KvAeXN7MtJgEoseaGFx+AejKDY=;
        b=aDqoXI6v9YUi9Ej2F1nexySz/YG5qFvm48Ub/EvyTiRlBxytDGLaJRpcvqfHinESAs
         MidKYjOb7onOBFXxMVRkUAmdVAVrteTMNwDSEInkpH9/J7nDC8Ji2ITcH7kCO4mwwYdK
         YKWqVVAOvV0j6bUW3Q73DXh3FIhZEIm1O+HXC86uyXKWKGp/TTyYiMGv+/mnG9dT1TRv
         q75VJQxbF23lK3AXAeAFR0XNbPYBuF7PvZewr0ehgsZ8xz1bG5ShbvbUu5HZ86eQ0n+l
         q2vZJlvaCbnEaNp9VAqyYiV6+zkY3N0JcwWAJv2f0FZ7fHLszQ9By8xrE/4qwa3g8Vo8
         SnNw==
X-Gm-Message-State: APjAAAURaUW9yHy5g51Ni1KrX2ZNR0eiA5I6u5Kvl5At9uILSahrZYs6
        JNB1Xou2e9Axhvd6H71ZQBtClzVdo+ueCobE0nkTX+f+fjQCB8JNtRF1PfbQEEfDpXXVuokYEyY
        ON7erNy1wNeAUnnMmvvAP5D1K
X-Received: by 2002:a05:600c:305:: with SMTP id q5mr4663228wmd.167.1575543210703;
        Thu, 05 Dec 2019 02:53:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqz8Siikx+RenjGmb9/JgaiAJarJ4WUklGanKOUVM3RJ8HVeGo3sn10PEYhU/9toFV3BE5uKLQ==
X-Received: by 2002:a05:600c:305:: with SMTP id q5mr4663212wmd.167.1575543210518;
        Thu, 05 Dec 2019 02:53:30 -0800 (PST)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id x132sm1419084wmg.0.2019.12.05.02.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 02:53:29 -0800 (PST)
Subject: Re: [PATCH 4.19 082/321] ACPI / LPSS: Ignore
 acpi_device_fix_up_power() return value
To:     Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
References: <20191203223427.103571230@linuxfoundation.org>
 <20191203223431.423864271@linuxfoundation.org> <20191204212735.GC7678@amd>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ffcc90cc-3b75-af81-832b-1387fcca7e06@redhat.com>
Date:   Thu, 5 Dec 2019 11:53:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191204212735.GC7678@amd>
Content-Language: en-US
X-MC-Unique: oPqQrZWzMAuonqEFauweYg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04-12-2019 22:27, Pavel Machek wrote:
> Hi!
> 
>> From: Hans de Goede <hdegoede@redhat.com>
>>
>> [ Upstream commit 1a2fa02f7489dc4d746f2a15fb77b3ce1affade8 ]
>>
>> Ignore acpi_device_fix_up_power() return value. If we return an error
>> we end up with acpi_default_enumeration() still creating a platform-
>> device for the device and we end up with the device still being used
>> but without the special LPSS related handling which is not useful.
>>
>> Specicifically ignoring the error fixes the touchscreen no longer
>> working after a suspend/resume on a Prowise PT301 tablet.
> 
> I'm pretty sure it does, but:
> 
> a) do you believe this is right patch for -stable? Should it get lot
> more testing in mainline as it.... may change things in a wrong way
> for someone else?

This has already been answered by Rafael.

> b) if we are ignoring errors now, should we at least printk() to let
> the user know that something is wrong with the ACPI tables?

acpi_device_fix_up_power() fails when the ACPI _PS0 method fails and
when there are errors while executing an ACPI method the ACPI subsystem
already is pretty verbose about this.

Regards,

Hans


> 
> Best regards,
> 									Pavel
> 
>> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
>> index b21c241aaab9f..30ccd94f87d24 100644
>> --- a/drivers/acpi/acpi_lpss.c
>> +++ b/drivers/acpi/acpi_lpss.c
>> @@ -665,12 +665,7 @@ static int acpi_lpss_create_device(struct acpi_device *adev,
>>   	 * have _PS0 and _PS3 without _PSC (and no power resources), so
>>   	 * acpi_bus_init_power() will assume that the BIOS has put them into D0.
>>   	 */
>> -	ret = acpi_device_fix_up_power(adev);
>> -	if (ret) {
>> -		/* Skip the device, but continue the namespace scan. */
>> -		ret = 0;
>> -		goto err_out;
>> -	}
>> +	acpi_device_fix_up_power(adev);
> 
> 
> 
>>   	adev->driver_data = pdata;
>>   	pdev = acpi_create_platform_device(adev, dev_desc->properties);
> 

