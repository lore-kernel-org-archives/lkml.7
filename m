Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9C3C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2A12171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlD9l5WV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfDLRfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 13:35:15 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34067 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfDLRfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 13:35:15 -0400
Received: by mail-pg1-f193.google.com with SMTP id v12so5542171pgq.1;
        Fri, 12 Apr 2019 10:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jkaa5jmzbhTsKzYwSroYi/O0CDBrW65uQeV5PjzRPNo=;
        b=BlD9l5WV/+LxcB+yPbks6VYgHQjYcrn3dXmhweu3olLIFZtPo2nLV2AIF4ttFT1FhH
         Pp76BJ6NY28xpWgmEwQGVDF+JB0zHa26ZyGOet6vSe9iZUASgtRtrbgFplChfG3NQHDv
         yUgocDjy5aoh5oEpk8a2bf0TIAwF5LGA4Yh6MZHEqw3dB0w+vRvGl9jl3coFXvRtpD5U
         YieOQ8r3JYlupFwpw9UUz370zgir3drGDeulaYPa5jYCzgMUoQptGWFKgk6JfvXnmBOr
         tTSZPujBosE+igf/t+FoVYWCNqkOold/8Tre5v32ka82d6RGfQeoPjEXfRKy6PDHScMj
         aB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jkaa5jmzbhTsKzYwSroYi/O0CDBrW65uQeV5PjzRPNo=;
        b=pa6NzB7STY2E+XrkxirwByqMaIpHkASz0393D5M9P9xzVZ4Gj+Lpuv9QpO5/fwa3Fn
         V7bZGheGO2ae41+AUDkpufh01YcKDTBmwldPtPx9NTYDVzDD6/F4cFNWfWPY3jHoSEdL
         gyxGSY6vtOPUk/1M/vZSgOwTw+HuHKRMg/zOJf0LVft5YB2N+267o2xqkxw5mR4sRsBP
         9/Xt4JsUawGB006eDZ8bANN1tB8eM9CzQslJTx2nt71a7btHCTh9yS3tEByRZzLShNwd
         SBV7kAk7t+RmJf0MS33llCo8AK1I+BjFa1H4l52KCY8li2B40vB+lvGnFuYQZN6bNIip
         YPww==
X-Gm-Message-State: APjAAAW4gaYMTOuy3qNPSUnDp+FA3UkeBRBPDpw3W0tI9e8+UsBvZvtY
        sHY/nyYp93wvecPMWQpSDoD/hZib
X-Google-Smtp-Source: APXvYqxY2mSLMcy4FveonnZ0SCqIKQS8d1bLY+TdFMozdwzEUdZkL7dQDbxBHs1Qi2a2zqfZW7xrvg==
X-Received: by 2002:a63:1203:: with SMTP id h3mr55584847pgl.164.1555090513762;
        Fri, 12 Apr 2019 10:35:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n65sm115262036pfb.160.2019.04.12.10.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 10:35:12 -0700 (PDT)
Subject: Re: [PATCH V5 0/3] hwmon: pwm-fan: Add RPM support
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1554989411-23666-1-git-send-email-stefan.wahren@i2se.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e176a657-ca6d-7676-8751-9a475d86638f@roeck-us.net>
Date:   Fri, 12 Apr 2019 10:35:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554989411-23666-1-git-send-email-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/19 6:30 AM, Stefan Wahren wrote:
> Contrary to the gpio-fan the pwm-fan driver isn't easy to setup
> with pwmconfig/fancontrol because of the missing hwmon sysfs entry
> for actual revolutions per minute. This series adds this feature.
> 

Series applied to hwmon-next.

Thanks,
Guenter

> Changes in V5:
> - address Guenter's and Robin's comments:
>    - use of_property_read_u32 to get pulses-per-revolution
>    - call platform_get_irq ealier to avoid glitches on the regulator
>    - simplify pwm_fan_attrs_visible
> 
> Changes in V4:
> - remove copy & paste artifact in dt-binding example
> - switch to u64 for rpm calculation
> - drop overflow handling and init atomic
> - handle 0 not as valid irq
> - reduce range of pulses_per_revolution
> - handle probe defer of platform_get_irq
> - delete timer properly in bail-out path
> 
> Changes in V3:
> - rename property interrupt-ratio to pulses-per-revolution
>    to avoid confusion with interrupt binding
> - handle error case pulses-per-revolution = 0
> - bail out properly in case we are unable to request the irq
> 
> Changes in V2:
> - address Guenter's comments:
>    - improve description of interrupts
>    - use atomic_t to avoid races of the pulse counter
>    - measure sample time to make rpm more reliable under load
>    - make sysfs entry fan1_input conditional
> - add dt-property to define interrupts per fan revolution
> - example for fan with RPM support
> 
> Stefan Wahren (3):
>    dt-bindings: hwmon: Add tachometer interrupt to pwm-fan
>    Documentation: pwm-fan: Add description for RPM support
>    hwmon: pwm-fan: Add RPM support via external interrupt
> 
>   .../devicetree/bindings/hwmon/pwm-fan.txt          |  21 +++-
>   Documentation/hwmon/pwm-fan                        |   3 +
>   drivers/hwmon/pwm-fan.c                            | 107 ++++++++++++++++++++-
>   3 files changed, 126 insertions(+), 5 deletions(-)
> 

