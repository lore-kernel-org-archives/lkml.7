Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7731EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 09:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB78204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 09:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="J14VFDqV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfKLJGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 04:06:40 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42336 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfKLJGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 04:06:39 -0500
Received: by mail-wr1-f66.google.com with SMTP id a15so17550739wrf.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 01:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ljiUffEus+Z4ZY4w7IrdP4JG4tKVQVn7p9V/dpEqKPg=;
        b=J14VFDqV427U1m/I8tlQ/s9mnARqI8lVo3sVKaubQlrUK+k+38KWzQbhhhuIRx7dXq
         5W6uhDjkv7eJcUe/QimuoNxOogx2nRGJwpWFauFKZzEH72yJOKbYa5laUd7d65uxN4Ly
         EbRSeMULmWGbIjCePgDaXlFW+sXswPcT8wLyohRc5KMnlcnhFJiUZK2cLegX4vwdGHc0
         yphP2PMh3zil164BK27vD4qIgeEZy2h4grNq7zjrFnTjJ9tcFQhU+6M89+Qwr7Ioc41z
         dpn1FZt3hOUniM9MTT+SmBbSgwQN6+UKiWcz20+Y0XLxZm/MEtgOMg5dtsWUk5QCnpz/
         9gWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ljiUffEus+Z4ZY4w7IrdP4JG4tKVQVn7p9V/dpEqKPg=;
        b=l4p3dgMFuuwSD4NfAO6URP27F37054eYHH5Ou5+EffsticteOKrIdfBPrvSAtsqBof
         dirqEbiEWRJBW9pbni0eWUhSZ3ROeemT2TS+LLTVREpMxyI7RndKELuRkgloubmOXR6V
         WNMlPNQ3Mk6zCLvH40JJYhusx95ni/VNeMzMRKX5aiYkGllVUNqNPcMYBesNnjaakmdi
         xtp5kvMbzE5YMoLfgq4/Zem3X4JGwnV8JXXk3ICTEmx7rVZakg7RuqUtz9kOxUQDs7SE
         iY+RkiKP279HB4yBY08Y0V6KQ9jvjVxyQ/dAGbUL7GiaySTKqcr7BoO50Eu5HJFUOSO4
         G5cg==
X-Gm-Message-State: APjAAAXWXJEST58SAY/fgdwCpNWkzLVYx3mOhxKaknAQ0NPyOk3SF0kX
        PXJVlllcWIY+fKtOr0FYaCtz+w==
X-Google-Smtp-Source: APXvYqwxlHl+WAUsL0eDxP8/ZRVrsIACmWwurxGJ76YiQmbnXdX/L9VGsTVJ3x+YwcGDa5o+Bu9u7A==
X-Received: by 2002:a5d:4684:: with SMTP id u4mr19840346wrq.352.1573549596506;
        Tue, 12 Nov 2019 01:06:36 -0800 (PST)
Received: from [10.1.2.12] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y8sm2133333wmi.9.2019.11.12.01.06.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 01:06:35 -0800 (PST)
Subject: Re: [PATCH] soc: amlogic: socinfo: Avoid soc_device_to_device()
To:     =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>
References: <20191111221521.1587-1-afaerber@suse.de>
 <20191112054003.GD1210104@kroah.com>
 <0673ba51-108c-76c4-5c71-00804d8ea661@suse.de>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <ee3a4c3b-0f99-cc79-a438-08254fe38694@baylibre.com>
Date:   Tue, 12 Nov 2019 10:06:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0673ba51-108c-76c4-5c71-00804d8ea661@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2019 09:11, Andreas Färber wrote:
> Am 12.11.19 um 06:40 schrieb Greg Kroah-Hartman:
>> On Mon, Nov 11, 2019 at 11:15:21PM +0100, Andreas Färber wrote:
>>> The helper soc_device_to_device() is considered deprecated.
>>> For a driver __init function the predictable prefix text
>>> "soc soc0:" from dev_info() does not add real value, so use
>>> pr_info() to emit the info text without such prefix.
>>>
>>> While at it, normalize the casing of "detected" for GX.
>>>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>> Cc: Neil Armstrong <narmstrong@baylibre.com>
>>> Signed-off-by: Andreas Färber <afaerber@suse.de>
>>> ---
>>>  drivers/soc/amlogic/meson-gx-socinfo.c | 4 +---
>>>  drivers/soc/amlogic/meson-mx-socinfo.c | 4 ++--
>>>  2 files changed, 3 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
>>> index 01fc0d20a70d..105b819bbd5f 100644
>>> --- a/drivers/soc/amlogic/meson-gx-socinfo.c
>>> +++ b/drivers/soc/amlogic/meson-gx-socinfo.c
>>> @@ -129,7 +129,6 @@ static int __init meson_gx_socinfo_init(void)
>>>  	struct device_node *np;
>>>  	struct regmap *regmap;
>>>  	unsigned int socinfo;
>>> -	struct device *dev;
>>>  	int ret;
>>>  
>>>  	/* look up for chipid node */
>>> @@ -192,9 +191,8 @@ static int __init meson_gx_socinfo_init(void)
>>>  		kfree(soc_dev_attr);
>>>  		return PTR_ERR(soc_dev);
>>>  	}
>>> -	dev = soc_device_to_device(soc_dev);
>>>  
>>> -	dev_info(dev, "Amlogic Meson %s Revision %x:%x (%x:%x) Detected\n",
>>> +	pr_info("Amlogic Meson %s Revision %x:%x (%x:%x) detected\n",
>>
>> This should message should just be removed entirely.
>>
>>>  			soc_dev_attr->soc_id,
>>>  			socinfo_to_major(socinfo),
>>>  			socinfo_to_minor(socinfo),
>>> diff --git a/drivers/soc/amlogic/meson-mx-socinfo.c b/drivers/soc/amlogic/meson-mx-socinfo.c
>>> index 78f0f1aeca57..7db2c94a7130 100644
>>> --- a/drivers/soc/amlogic/meson-mx-socinfo.c
>>> +++ b/drivers/soc/amlogic/meson-mx-socinfo.c
>>> @@ -167,8 +167,8 @@ static int __init meson_mx_socinfo_init(void)
>>>  		return PTR_ERR(soc_dev);
>>>  	}
>>>  
>>> -	dev_info(soc_device_to_device(soc_dev), "Amlogic %s %s detected\n",
>>> -		 soc_dev_attr->soc_id, soc_dev_attr->revision);
>>> +	pr_info("Amlogic %s %s detected\n",
>>> +		soc_dev_attr->soc_id, soc_dev_attr->revision);
>>
>> Same here, no need to polute the kernel log for when all is going just
>> fine.
>>
>> That's why we created "common" driver init helpers, to prevent the
>> ability for this type of noise from even being able to be created at
>> all.
> 
> Let's have that discussion in the central thread please.
> 
> Fact here is that Amlogic GX's kernel output (and this code getting
> mirrored into U-Boot) made me aware of this driver in the first place.

As Uwe said in the common thread, this print doesn't polute the kernel log at all,
it's pretty useful for CI, like kernelCI, to check the test coverage on SoCs revisions.

Yes it's duplicated in U-boot, but a little fraction of the boards in kCi uses this
U-Boot version, they often use the vendor bootloader.

And BTW, by moving dev_info to pr_info actually changes the output format.

Can you be more precise about why "soc_device_to_device()" is now suddently deprecated ?

Neil

> 
> Regards,
> Andreas
> 

