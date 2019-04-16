Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA58C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F03C20693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nYPQUpvy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfDPJoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 05:44:05 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50292 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbfDPJoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 05:44:05 -0400
Received: by mail-wm1-f67.google.com with SMTP id z11so24612575wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 02:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MfQ4ZPfq8jXM3q2KxZn6ZQmaur0tuEEWTcoJmqWC3do=;
        b=nYPQUpvyB8mDur8wr4508xK01nv48ZRydUizGGDjA5AYID2RcTOJffL0liR2C0Ko+Y
         cvjC05Cr2f2eRc8dpb7+JNJ1U8VZw1t/lS1YlEYMqRheTNI4/qOgu9JIRjivv0GbQJeK
         DLYzo0ikbU/4VMGuEyyPJ/KU8exUBUxZYN4FVRb4zbSZDPuQxYHIYp/jQKVo+cq9BDaf
         +y7VthHihzs6bp08/1oaF/KwtIcFU60v/lVbisc4AENFBNdwK+Qw1Itx02DZCcuUsOsn
         SESSRkef0x/mHDGX6gGVTAeFQMjT3WGYnP6Q3LydgxXZVDIYM7WfRLODbO266iWWj8Fu
         4BRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MfQ4ZPfq8jXM3q2KxZn6ZQmaur0tuEEWTcoJmqWC3do=;
        b=SMqcEz5d/j24FdJh6oRIYhgGUQdoeWQxyXGFoBFFXjUz2lJ9NeQfr47dJcHauYqtQl
         RxJ+Q8bJIWcJAKwUwNjGWeLgGmnYdZZxkNj7U68TLpxgqDB8KRvPO7zryasDXDmGHq4o
         oBziE4ZTNHhLTlCosWd8HTPMRe4ucDSDzlfONC7pZ0VurV4xCHnTRfafLjbqdxhX/E8+
         XjZs5pWPmF87p9MxJwIHBnXK5gDM9FqmDk7OB9HL8TOr+MZSrrvoRk2vYBI5LsOl5Z7i
         dfEhz1+d5h8usOG1WTTF2auqklTRU8Ce/yZNmZR5io2NWYWGn00Tn0F3fxNtjg7vRgbL
         gMOA==
X-Gm-Message-State: APjAAAVndE/olUGha4vszqSySviQNPX8qCsnXY1LoDNJNyTrq/7QVum9
        E0dAU6maZ4rQkC/dHrw3slCkUGNXYgU=
X-Google-Smtp-Source: APXvYqxAzc/tnA6WAOzdLFk8lE+cHhuUPfktIj1Iqv14flyD/lN0fctBwBn/s56g9Ykx4gD4k5Ul/Q==
X-Received: by 2002:a7b:cd07:: with SMTP id f7mr26787245wmj.43.1555407843030;
        Tue, 16 Apr 2019 02:44:03 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id d14sm72678469wro.79.2019.04.16.02.44.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 02:44:02 -0700 (PDT)
Subject: Re: [PATCH] nvmem: core: add NVMEM_SYSFS Kconfig
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Gaurav Kohli <gkohli@codeaurora.org>
Cc:     gregkh@linuxfoundation.org, maxime.ripard@bootlin.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190415164011.2638-1-srinivas.kandagatla@linaro.org>
 <3a66797d-347d-2414-14e1-edbcd7c39ae8@codeaurora.org>
 <20190416093454.GN2654@lahna.fi.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <66c3794b-ee84-f746-e686-e5477b78e981@linaro.org>
Date:   Tue, 16 Apr 2019 10:44:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416093454.GN2654@lahna.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/04/2019 10:34, Mika Westerberg wrote:
> On Tue, Apr 16, 2019 at 10:49:22AM +0530, Gaurav Kohli wrote:
>> Hi Srinivas,
>>
>> Thanks for the patch,
>> By default NVMEM_SYSFS should be set true, those whose don't want they can
>> disable the same.
>>
>> If we go with disable option, there are chances of eeprom may break in below
>> case:
>>
>> if (config->compat) {
>>                  rval = nvmem_sysfs_setup_compat(nvmem, config); -> this will
>> return error as config is disabled.
>>                  if (rval)
>>                          goto err_device_del;
>>          }
> 
> I also think this may cause problems with Thunderbolt devices because
> the upgradeable NVM is exposed to the userspace via these sysfs files
> and those are being used by fwupd. If the files disappear it makes NVM
> upgrade somewhat harder ;-)
Thanks Mika and Kohli for input.

As Kohli suggested we could make NVMEM_SYSFS default to y so that the 
sysfs file is available by default like before and user/board specific 
can decide to deselect it.

Let me know if thats Okay with you, I can spin that in v2.

--srini

> 
> At least it would be good to include following as part of this series if
> you plan to disable the sysfs entries by default:
> 
> diff --git a/drivers/thunderbolt/Kconfig b/drivers/thunderbolt/Kconfig
> index f4869c38c7e4..dd5facab0af2 100644
> --- a/drivers/thunderbolt/Kconfig
> +++ b/drivers/thunderbolt/Kconfig
> @@ -7,6 +7,7 @@ menuconfig THUNDERBOLT
>   	select CRYPTO
>   	select CRYPTO_HASH
>   	select NVMEM
> +	select NVMEM_SYSFS
>   	help
>   	  Thunderbolt Controller driver. This driver is required if you
>   	  want to hotplug Thunderbolt devices on Apple hardware or on PCs
> 
