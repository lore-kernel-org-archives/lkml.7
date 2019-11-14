Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F7DC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 11:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43431206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 11:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7luye9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfKNLcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 06:32:18 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23366 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726087AbfKNLcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 06:32:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573731136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eGPDOxJmq8wLYBcctg35/K5PZf59EHJV9VNjXKlhwZM=;
        b=Y7luye9DT8hhH0jQI+ZRaCaak3zA5ZSfRMMRD6HGysnB9O8/AIOejLteLfh+/kWYTjrmKq
        FHmHkWJ9iyUZ/zVZI3l5vBSC5lCGmvLDeE9kB4yKCcUDhDpF5LOllNRcWZlGK32XtBM8A+
        8TpPb2t17u4tU5pbBsSToS6ksl4vBUE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-zUnBuLTaPKOAvuosxXLcgw-1; Thu, 14 Nov 2019 06:32:15 -0500
Received: by mail-wm1-f69.google.com with SMTP id f16so3184072wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 03:32:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RZt45pQgw79xE9XzgdJC+yG0nkXIvZyJYcV8pb1nd04=;
        b=ruQaWBmuCrCRaabZkutyua7uEFK3sSr1jZVzwAkILnwtBTkJKLD+zclrVmJ2si5wFM
         48YC9ZTz8mWm00kOfmmvgX52ljqdV0PQI/1STnYrBQ0W5K0IIaenCJ6PWOfm00xhpnTn
         +yHdKXDazzGwWJ76AIr7zJGW3OhGXU3P7ePB/70NkAjmH6ImJtyAmz9QUvy1jhS7JYmC
         NGojjcj6cFgPGLy38kyjuEsY8oDyYW/El9eloV56QvE/k6xKE/qaYkQbE94JEYncHDpm
         8e5Ur4rApGYyuWAOKX6tvK1JdBwHx7euCRn3Vvvl4jcU6rieyvhHSJlxiYCIbLNeFZ2c
         d8QQ==
X-Gm-Message-State: APjAAAXcy5rTvG0DdBKWNI6QS1Zqi6AXRjbV9aow7P8UCTeulFDv7/cZ
        gGux9/UHPHmA3l1Yjy6f5csg/TsB8/mwRbVuUMdAG9a3XWqL910lVCUi6fKVdKJKMCMvkuZI+Wl
        /pUfgiSTCw8SuVwWNfMtPhKoB
X-Received: by 2002:a7b:c748:: with SMTP id w8mr7892861wmk.114.1573731133958;
        Thu, 14 Nov 2019 03:32:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqxqb+wuHoXkrqv7G9jT1s8K11NZRcID1zCY+N4NxoahPNLiVW38bJon4GNLKPoo8ktQX+wLDg==
X-Received: by 2002:a7b:c748:: with SMTP id w8mr7892833wmk.114.1573731133769;
        Thu, 14 Nov 2019 03:32:13 -0800 (PST)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id 205sm13554570wmb.3.2019.11.14.03.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2019 03:32:12 -0800 (PST)
Subject: Re: [PATCH v7 4/8] firmware: Add new platform fallback mechanism and
 firmware_request_platform()
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-input@vger.kernel.org
References: <20191004145056.43267-1-hdegoede@redhat.com>
 <20191004145056.43267-5-hdegoede@redhat.com>
 <20191011152920.GQ16384@42.do-not-panic.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b09922ec-a71e-c1ca-adcc-15f7fd02c2f4@redhat.com>
Date:   Thu, 14 Nov 2019 12:32:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191011152920.GQ16384@42.do-not-panic.com>
Content-Language: en-US
X-MC-Unique: zUnBuLTaPKOAvuosxXLcgw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11-10-2019 17:29, Luis Chamberlain wrote:
> On Fri, Oct 04, 2019 at 04:50:52PM +0200, Hans de Goede wrote:
>> diff --git a/drivers/base/firmware_loader/Makefile b/drivers/base/firmwa=
re_loader/Makefile
>> index 0b2dfa6259c9..fec75895faae 100644
>> --- a/drivers/base/firmware_loader/Makefile
>> +++ b/drivers/base/firmware_loader/Makefile
>> @@ -3,7 +3,7 @@
>>  =20
>>   obj-$(CONFIG_FW_LOADER_USER_HELPER) +=3D fallback_table.o
>>   obj-$(CONFIG_FW_LOADER)=09+=3D firmware_class.o
>> -firmware_class-objs :=3D main.o
>> +firmware_class-objs :=3D main.o fallback_platform.o
>>   firmware_class-$(CONFIG_FW_LOADER_USER_HELPER) +=3D fallback.o
>=20
> Why not just:
>=20
> firmware_class-$(CONFIG_EFI_EMBEDDED_FIRMWARE) +=3D fallback_platform.o
>=20
>>   obj-y +=3D builtin/
>> diff --git a/drivers/base/firmware_loader/fallback.h b/drivers/base/firm=
ware_loader/fallback.h
>> index 21063503e4ea..c4350f2e7cc2 100644
>> --- a/drivers/base/firmware_loader/fallback.h
>> +++ b/drivers/base/firmware_loader/fallback.h
>> @@ -66,4 +66,6 @@ static inline void unregister_sysfs_loader(void)
>>   }
>>   #endif /* CONFIG_FW_LOADER_USER_HELPER */
>>  =20
>> +int firmware_fallback_platform(struct fw_priv *fw_priv, enum fw_opt opt=
_flags);
>> +
>=20
> Inline this if not defined.
>=20
>>   #endif /* __FIRMWARE_FALLBACK_H */
>> diff --git a/drivers/base/firmware_loader/fallback_platform.c b/drivers/=
base/firmware_loader/fallback_platform.c
>> new file mode 100644
>> index 000000000000..7e9d730e36bf
>> --- /dev/null
>> +++ b/drivers/base/firmware_loader/fallback_platform.c
>> @@ -0,0 +1,33 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <linux/efi_embedded_fw.h>
>> +#include <linux/property.h>
>> +#include <linux/security.h>
>> +#include <linux/vmalloc.h>
>> +
>> +#include "fallback.h"
>> +#include "firmware.h"
>> +
>> +int firmware_fallback_platform(struct fw_priv *fw_priv, enum fw_opt opt=
_flags)
>> +{
>> +#ifdef CONFIG_EFI_EMBEDDED_FIRMWARE
>=20
> And we can do away with this eyesore.

Ok will fix for the next version.

> Otherwise looks good!

Thanks.

Regards,

Hans

