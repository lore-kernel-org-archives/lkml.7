Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEBCC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CCF121925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfKLILo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 03:11:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:36264 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725775AbfKLILo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 03:11:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1AEE8B2E9;
        Tue, 12 Nov 2019 08:11:42 +0000 (UTC)
Subject: Re: [PATCH] soc: amlogic: socinfo: Avoid soc_device_to_device()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
References: <20191111221521.1587-1-afaerber@suse.de>
 <20191112054003.GD1210104@kroah.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <0673ba51-108c-76c4-5c71-00804d8ea661@suse.de>
Date:   Tue, 12 Nov 2019 09:11:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191112054003.GD1210104@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 12.11.19 um 06:40 schrieb Greg Kroah-Hartman:
> On Mon, Nov 11, 2019 at 11:15:21PM +0100, Andreas Färber wrote:
>> The helper soc_device_to_device() is considered deprecated.
>> For a driver __init function the predictable prefix text
>> "soc soc0:" from dev_info() does not add real value, so use
>> pr_info() to emit the info text without such prefix.
>>
>> While at it, normalize the casing of "detected" for GX.
>>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> Cc: Neil Armstrong <narmstrong@baylibre.com>
>> Signed-off-by: Andreas Färber <afaerber@suse.de>
>> ---
>>  drivers/soc/amlogic/meson-gx-socinfo.c | 4 +---
>>  drivers/soc/amlogic/meson-mx-socinfo.c | 4 ++--
>>  2 files changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
>> index 01fc0d20a70d..105b819bbd5f 100644
>> --- a/drivers/soc/amlogic/meson-gx-socinfo.c
>> +++ b/drivers/soc/amlogic/meson-gx-socinfo.c
>> @@ -129,7 +129,6 @@ static int __init meson_gx_socinfo_init(void)
>>  	struct device_node *np;
>>  	struct regmap *regmap;
>>  	unsigned int socinfo;
>> -	struct device *dev;
>>  	int ret;
>>  
>>  	/* look up for chipid node */
>> @@ -192,9 +191,8 @@ static int __init meson_gx_socinfo_init(void)
>>  		kfree(soc_dev_attr);
>>  		return PTR_ERR(soc_dev);
>>  	}
>> -	dev = soc_device_to_device(soc_dev);
>>  
>> -	dev_info(dev, "Amlogic Meson %s Revision %x:%x (%x:%x) Detected\n",
>> +	pr_info("Amlogic Meson %s Revision %x:%x (%x:%x) detected\n",
> 
> This should message should just be removed entirely.
> 
>>  			soc_dev_attr->soc_id,
>>  			socinfo_to_major(socinfo),
>>  			socinfo_to_minor(socinfo),
>> diff --git a/drivers/soc/amlogic/meson-mx-socinfo.c b/drivers/soc/amlogic/meson-mx-socinfo.c
>> index 78f0f1aeca57..7db2c94a7130 100644
>> --- a/drivers/soc/amlogic/meson-mx-socinfo.c
>> +++ b/drivers/soc/amlogic/meson-mx-socinfo.c
>> @@ -167,8 +167,8 @@ static int __init meson_mx_socinfo_init(void)
>>  		return PTR_ERR(soc_dev);
>>  	}
>>  
>> -	dev_info(soc_device_to_device(soc_dev), "Amlogic %s %s detected\n",
>> -		 soc_dev_attr->soc_id, soc_dev_attr->revision);
>> +	pr_info("Amlogic %s %s detected\n",
>> +		soc_dev_attr->soc_id, soc_dev_attr->revision);
> 
> Same here, no need to polute the kernel log for when all is going just
> fine.
> 
> That's why we created "common" driver init helpers, to prevent the
> ability for this type of noise from even being able to be created at
> all.

Let's have that discussion in the central thread please.

Fact here is that Amlogic GX's kernel output (and this code getting
mirrored into U-Boot) made me aware of this driver in the first place.

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
