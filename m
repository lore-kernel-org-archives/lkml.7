Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CA1C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 01:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C154243D7
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 01:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPrIlAtX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfE3BFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 21:05:12 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42100 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbfE3BFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 21:05:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id r22so2776764pfh.9;
        Wed, 29 May 2019 18:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=beZsP/rjfL8EXcX60xBuuJ47HiagG33HBKhM1gI7z7o=;
        b=IPrIlAtXr2FDMSjX0/bzIEMw/DD91kRI7Kyd2nGYNcDCqviqF1yxJsKXacq5gSvR4M
         mBMuI9tFBSVxJtViMOKIdFfjPHDOCjrob7YTUQIobPby9v3cBSKt/FkrhY8i3ptyz54Z
         SJMLgYl/OVIWGJsq/YfN4ueGa2+iEX3UCeyVg5Jp1Tes3SZMJjw/iPyA/J1TxkwjhnTY
         XaT1Um7uoW+VB7utBeyzIeMfgNu3aQg57D5D/K+wcsh+k0nZyodje++7T7/JYXBVld/k
         +lMCKSyD7OuPJ4KapoZjFyaRryz8wNedo4iha6ZtqqF2vAeSqMW0Fi/9+N2OWe/gURNP
         QiZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=beZsP/rjfL8EXcX60xBuuJ47HiagG33HBKhM1gI7z7o=;
        b=hrE/F3JFe2VqzBTm+lLMrZKhsGL8RPn1vl4UqE+KKMGVsCogQmknof+LrKEBHhgWDh
         vZCdQfUBnenr2ur+4WlmjnYQQs7PvGXx61c2+x+5MjdmmpXq2ts45WlVFosexM0bCzvT
         PzUPxu7X1MDLxjOyz1ccBpMjMDChR+NI9u7wGJUJ8+yOsdSIA8sUVVW4O4AiYny8UFEO
         YtwgnrZ26ASSFEpBfTrJu8+JuwpFnxB44Da2uXtRzvp/KeKExOF8y5oXgnA7u7FR3XQm
         JG2WR3DHAjeWXESHTw6zSba/LrMDwpuTzLxdnVVpWRyc4Q0phsOwPtjT2sIA5ycma3jG
         S4yg==
X-Gm-Message-State: APjAAAX3Aw+7jjuYWfei6rXEXg5pB0tNu3DusCtCrYDnrp96bl3V3z2m
        O3LyEwjT3mCrJjh7ypxMP3Q=
X-Google-Smtp-Source: APXvYqwhXINGpYIe3fien1AMYupfuhGAODKoz3EA3gp4YnMJViJP2gBaJ4YnyeKQZhwk32gigQp88g==
X-Received: by 2002:a17:90a:bf0d:: with SMTP id c13mr675233pjs.88.1559178311313;
        Wed, 29 May 2019 18:05:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s42sm799092pjc.5.2019.05.29.18.05.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 18:05:10 -0700 (PDT)
Subject: Re: [PATCH 2/2] Docs: hwmon: pmbus: Add PXE1610 driver
To:     Vijay Khemka <vijaykhemka@fb.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     joel@jms.id.au, linux-aspeed@lists.ozlabs.org, sdasari@fb.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190529223511.4059120-1-vijaykhemka@fb.com>
 <20190529223511.4059120-2-vijaykhemka@fb.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <0a94e784-41a0-4f2d-f9f8-6b365a1e755e@roeck-us.net>
Date:   Wed, 29 May 2019 18:05:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190529223511.4059120-2-vijaykhemka@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/19 3:35 PM, Vijay Khemka wrote:
> Added support for Infenion PXE1610 driver
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>   Documentation/hwmon/pxe1610 | 84 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 84 insertions(+)
>   create mode 100644 Documentation/hwmon/pxe1610
> 
> diff --git a/Documentation/hwmon/pxe1610 b/Documentation/hwmon/pxe1610
> new file mode 100644
> index 000000000000..b5c83edf027a
> --- /dev/null
> +++ b/Documentation/hwmon/pxe1610
> @@ -0,0 +1,84 @@
> +Kernel driver pxe1610
> +=====================
> +
> +Supported chips:
> +  * Infinion PXE1610
> +    Prefix: 'pxe1610'
> +    Addresses scanned: -
> +    Datasheet: Datasheet is not publicly available.
> +
> +  * Infinion PXE1110
> +    Prefix: 'pxe1110'
> +    Addresses scanned: -
> +    Datasheet: Datasheet is not publicly available.
> +
> +  * Infinion PXM1310
> +    Prefix: 'pxm1310'
> +    Addresses scanned: -
> +    Datasheet: Datasheet is not publicly available.
> +
> +Author: Vijay Khemka <vijaykhemka@fb.com>
> +
> +
> +Description
> +-----------
> +
> +PXE1610 is a Multi-rail/Multiphase Digital Controllers and
> +it is compliant to Intel VR13 DC-DC converter specifications.
> +

And the others ?

> +
> +Usage Notes
> +-----------
> +
> +This driver can be enabled with kernel config CONFIG_SENSORS_PXE1610
> +set to 'y' or 'm'(for module).
> +
The above does not really add value.

> +This driver does not probe for PMBus devices. You will have
> +to instantiate devices explicitly.
> +
> +Example: the following commands will load the driver for an PXE1610
> +at address 0x70 on I2C bus #4:
> +
> +# modprobe pxe1610
> +# echo pxe1610 0x70 > /sys/bus/i2c/devices/i2c-4/new_device
> +
> +It can also be instantiated by declaring in device tree if it is
> +built as a kernel not as a module.
> +

I assume you mean "built into the kernel".
Why would devicetree based instantiation not work if the driver is built
as module ?

> +
> +Sysfs attributes
> +----------------
> +
> +curr1_label		"iin"
> +curr1_input		Measured input current
> +curr1_alarm		Current high alarm
> +
> +curr[2-4]_label		"iout[1-3]"
> +curr[2-4]_input		Measured output current
> +curr[2-4]_crit		Critical maximum current
> +curr[2-4]_crit_alarm	Current critical high alarm
> +
> +in1_label		"vin"
> +in1_input		Measured input voltage
> +in1_crit		Critical maximum input voltage
> +in1_crit_alarm		Input voltage critical high alarm
> +
> +in[2-4]_label		"vout[1-3]"
> +in[2-4]_input		Measured output voltage
> +in[2-4]_lcrit		Critical minimum output voltage
> +in[2-4]_lcrit_alarm	Output voltage critical low alarm
> +in[2-4]_crit		Critical maximum output voltage
> +in[2-4]_crit_alarm	Output voltage critical high alarm
> +
> +power1_label		"pin"
> +power1_input		Measured input power
> +power1_alarm		Input power high alarm
> +
> +power[2-4]_label	"pout[1-3]"
> +power[2-4]_input	Measured output power
> +
> +temp[1-3]_input		Measured temperature
> +temp[1-3]_crit		Critical high temperature
> +temp[1-3]_crit_alarm	Chip temperature critical high alarm
> +temp[1-3]_max		Maximum temperature
> +temp[1-3]_max_alarm	Chip temperature high alarm
> 

