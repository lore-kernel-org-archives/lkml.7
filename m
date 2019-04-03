Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1FFC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC22421738
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hbZt8Gs1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KIgiWpc5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfDCGDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 02:03:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39020 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfDCGDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 02:03:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 51C72602BA; Wed,  3 Apr 2019 06:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554271391;
        bh=heYcmJnwr7JaCtEYGdD47EkisKeQQ2vqoARqSKxtD70=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hbZt8Gs1vL0itS3cQLjssPHU4VF+u6oGQ9IkqW7a6cVTOkgq2myzIoH4DC+/lDT2i
         AdWs2cNxj0QhYplMCEMA7S27s0+CEk2NgMpZ4kB1lGE8FqB8hyo7YL0Ei6LsJ9Bcdd
         5zO3NF5YL27BLebpc8Pw9AtqNdkmRUVDa9eKr3i8=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5B43E6047C;
        Wed,  3 Apr 2019 06:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554271390;
        bh=heYcmJnwr7JaCtEYGdD47EkisKeQQ2vqoARqSKxtD70=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KIgiWpc5IaTfRoCgps5CAaOxqg+N67jUit7vXf5saa/AcRb6+WihJJdWTgu+eUb/A
         r3EQcAmlD9Fgp+Rug06c09/uToiGjAl+TY3jNmFiPpVtAP45KkEXLfvUR1jHPWf8T6
         lE7Io5AUZqaw9iHcvZYqfat3JEFmDYGFyRZXa3S8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5B43E6047C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] rtc: remove unnecessary Kconfig dependencies
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20190402215447.5849-1-alexandre.belloni@bootlin.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <b9bf27aa-8e3d-efb1-50cb-84f09de22b70@codeaurora.org>
Date:   Wed, 3 Apr 2019 11:33:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402215447.5849-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/3/2019 3:24 AM, Alexandre Belloni wrote:
> Remove the unused "depends on I2C" as the config options are already
> guarded by if I2C.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   drivers/rtc/Kconfig | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 23b4102ee824..7b8e156dbf38 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -448,7 +448,6 @@ config RTC_DRV_PCF85063
>   
>   config RTC_DRV_PCF85363
>   	tristate "NXP PCF85363"
> -	depends on I2C
>   	select REGMAP_I2C
>   	help
>   	  If you say yes here you get support for the PCF85363 RTC chip.
> @@ -603,7 +602,6 @@ config RTC_DRV_FM3130
>   
>   config RTC_DRV_RX8010
>   	tristate "Epson RX8010SJ"
> -	depends on I2C
>   	help
>   	  If you say yes here you get support for the Epson RX8010SJ RTC
>   	  chip.
