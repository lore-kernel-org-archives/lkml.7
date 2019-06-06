Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716DDC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBB920866
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vIu0FvNl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfFFJBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 05:01:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40494 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbfFFJBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 05:01:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id p11so1534793wre.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 02:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Pt64RIcODeQjneq8j3TjAtIiNmyobDs0m2HCif4NPjg=;
        b=vIu0FvNlqJvgl8zP64XtXNAaPJgxxguxSD89gPSXVdcqwbaYlQfkljhRw7+PJANJc0
         ll6HngdXaMicahymLrcQ0KY6bsbAHZekqwiMQMKAfOo4vraXPqxYL1gInpEWC9qX5wDc
         aQsxWFC5n7LCYyRFUZnYjUuHd9iZnE5Qh5TtzI4Yfhdnye5PttAIFjhkVzbbGqFGPtn4
         nPjduUdH6GTqNE4ZxmZ9zeS210qPYYFVd2pkKaRKtg6TFFQvBVRZa7AYFe1C7q30mExQ
         Cfyo/gDIFGqnhmcZ89HzuIUZRLUicghXpF5xUTSqrr/+s4D5xQMb8oVDi/YNnvzB88dH
         YB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pt64RIcODeQjneq8j3TjAtIiNmyobDs0m2HCif4NPjg=;
        b=o9cTEGwMwAtGanEco2paEXu5ScNu1gKvvZfhcNHkppkIWl+Eag7vcrfloCxiU+Qxtg
         lrgOsNPVCTL0mEH0NICsOjEsgHrNeedUrjwKiqSDFrVH8nDMhTU60DYTW8IatWqgzQsf
         LsWf6kZjwjgGPXhyX9G+TElfUzZ0dHJ8S1p/vY661vA7/uZo1ejBl05barwzuHZkAuhU
         w5c6vR/92oRangcNVa32Fee4kavwa282ygBHRkZ0AB5t56vXYlYi61Z4KnPE1vJplKc6
         4UlGW260K/d0DAKudRThCDTRDj9CvMyZro7h8j3JHiXYbEBFGoXBOrmEy2u8nWt2CCxO
         id7A==
X-Gm-Message-State: APjAAAXNxAngZMnqX4Oz4EhhIm4qX2uylcO/r44MD8s5HPwja44cTN0F
        58K6E++zqYzgthdKI0WgGWcNJw==
X-Google-Smtp-Source: APXvYqzkd/PdWRtcbIEiYEQp2fiPjq2nWUapdFwgv5uaReCAlrAWUdTwO3vabnQnHmzLFxDos0ttOQ==
X-Received: by 2002:adf:dd91:: with SMTP id x17mr17413345wrl.291.1559811693630;
        Thu, 06 Jun 2019 02:01:33 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id y2sm1390830wra.58.2019.06.06.02.01.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 02:01:32 -0700 (PDT)
Subject: Re: [PATCH 02/13] bus_find_device: Unify the match callback with
 class_find_device
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Andreas Noever <andreas.noever@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Corey Minyard <minyard@acm.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Kershner <david.kershner@unisys.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Airlie <airlied@linux.ie>,
        Felipe Balbi <balbi@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Cameron <jic23@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Len Brown <lenb@kernel.org>, Mark Brown <broonie@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Jamet <michael.jamet@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>
References: <1559747630-28065-1-git-send-email-suzuki.poulose@arm.com>
 <1559747630-28065-3-git-send-email-suzuki.poulose@arm.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <958acbca-5322-d079-2d88-591ed3d12ed7@linaro.org>
Date:   Thu, 6 Jun 2019 10:01:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1559747630-28065-3-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/06/2019 16:13, Suzuki K Poulose wrote:
> There is an arbitrary difference between the prototypes of
> bus_find_device() and class_find_device() preventing their callers
> from passing the same pair of data and match() arguments to both of
> them, which is the const qualifier used in the prototype of
> class_find_device().  If that qualifier is also used in the
> bus_find_device() prototype, it will be possible to pass the same
> match() callback function to both bus_find_device() and
> class_find_device(), which will allow some optimizations to be made in
> order to avoid code duplication going forward.  Also with that, constify
> the "data" parameter as it is passed as a const to the match function.
> 
> For this reason, change the prototype of bus_find_device() to match
> the prototype of class_find_device() and adjust its callers to use the
> const qualifier in accordance with the new prototype of it.
> 
> Cc: Alexander Shishkin<alexander.shishkin@linux.intel.com>
> Cc: Andrew Lunn<andrew@lunn.ch>
> Cc: Andreas Noever<andreas.noever@gmail.com>
> Cc: Arnd Bergmann<arnd@arndb.de>
> Cc: Bjorn Helgaas<bhelgaas@google.com>
> Cc: Corey Minyard<minyard@acm.org>
> Cc: Christian Borntraeger<borntraeger@de.ibm.com>
> Cc: David Kershner<david.kershner@unisys.com>
> Cc: "David S. Miller"<davem@davemloft.net>
> Cc: David Airlie<airlied@linux.ie>
> Cc: Felipe Balbi<balbi@kernel.org>
> Cc: Frank Rowand<frowand.list@gmail.com>
> Cc: Grygorii Strashko<grygorii.strashko@ti.com>
> Cc: Harald Freudenberger<freude@linux.ibm.com>
> Cc: Hartmut Knaack<knaack.h@gmx.de>
> Cc: Heiko Stuebner<heiko@sntech.de>
> Cc: Jason Gunthorpe<jgg@ziepe.ca>
> Cc: Jonathan Cameron<jic23@kernel.org>
> Cc: Jonathan Cameron<jic23@kernel.org>
> Cc: "James E.J. Bottomley"<jejb@linux.ibm.com>
> Cc: Len Brown<lenb@kernel.org>
> Cc: Mark Brown<broonie@kernel.org>
> Cc: Michael Ellerman<mpe@ellerman.id.au>
> Cc: Michael Jamet<michael.jamet@intel.com>
> Cc: "Martin K. Petersen"<martin.petersen@oracle.com>
> Cc: Peter Oberparleiter<oberpar@linux.ibm.com>
> Cc: Rob Herring<robh+dt@kernel.org>
> Cc: Sebastian Ott<sebott@linux.ibm.com>
> Cc: Srinivas Kandagatla<srinivas.kandagatla@linaro.org>
> Cc: Yehezkel Bernat<YehezkelShB@gmail.com>
> Cc: Wolfram Sang<wsa@the-dreams.de>
> Cc:rafael@kernel.org
> Cc: Greg Kroah-Hartman<gregkh@linuxfoundation.org>
> Signed-off-by: Suzuki K Poulose<suzuki.poulose@arm.com>
> ---
>   arch/powerpc/platforms/pseries/ibmebus.c           | 4 ++--
>   drivers/acpi/acpi_lpss.c                           | 4 ++--
>   drivers/acpi/sleep.c                               | 2 +-
>   drivers/acpi/utils.c                               | 4 ++--
>   drivers/base/bus.c                                 | 6 +++---
>   drivers/base/devcon.c                              | 2 +-
>   drivers/char/ipmi/ipmi_si_platform.c               | 2 +-
>   drivers/firmware/efi/dev-path-parser.c             | 4 ++--
>   drivers/gpu/drm/drm_mipi_dsi.c                     | 2 +-
>   drivers/hwtracing/coresight/coresight.c            | 6 +++---
>   drivers/hwtracing/coresight/of_coresight.c         | 2 +-
>   drivers/hwtracing/intel_th/core.c                  | 5 ++---
>   drivers/i2c/i2c-core-acpi.c                        | 4 ++--
>   drivers/i2c/i2c-core-of.c                          | 4 ++--
>   drivers/iio/inkern.c                               | 2 +-
>   drivers/infiniband/hw/hns/hns_roce_hw_v1.c         | 2 +-
>   drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c | 2 +-
>   drivers/net/ethernet/ti/cpsw-phy-sel.c             | 4 ++--
>   drivers/net/ethernet/ti/davinci_emac.c             | 2 +-
>   drivers/net/ethernet/toshiba/tc35815.c             | 4 ++--
>   drivers/nvmem/core.c                               | 2 +-


For NVMEM changes,

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


--srini
