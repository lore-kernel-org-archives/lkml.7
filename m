Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F4BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD29206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbfDDOoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 10:44:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38273 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbfDDOoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 10:44:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id k11so4164668wro.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 07:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gn3ol0qrTVAa2jmRcXCm5Aq3GWsoDhBvfBrdtaydM80=;
        b=CaV5t4F1xpbFus7dvURtGA17U385Df/PWW+m2UxvroCfnI7B9q1YLl1ehGqMRxDM98
         EPAk3pSihrC0jXM57z30INOkYSa+OTB/Hsg3DbpzfNkw7e5nJQpIz0d9wEQU3p9grWJk
         EMVPD6ACn7XKDhCaBJk3KmwfADngh6vRKIVj/9ZW+9y5EHjfcDoTn9bm/uXN2kH9ICO/
         2tPq3ADKesDtf2dfYhItI71c2j98aX5wfBgmmM+IYn9GhzHvvjrv3Z0RiGKnuiEsvBPY
         9oDI2jio+KOx09Ep8VYxNSNQ6ybRTc7M6A938zhBkdH8UFHVidRqWbZoGwS6qh6cA3GU
         gDaA==
X-Gm-Message-State: APjAAAUj3tqDXI6r2Ldnjg0o7aSdysrurTcjeG7fznNA8Or4CB+1ad8U
        8COyqpdyOHQVl21huDXgLCE81Q==
X-Google-Smtp-Source: APXvYqwnA+hnHh3AONbyZd1ZyoKqcr7v/nOqKu4SLtPMzyuHhtJsIaRrbrHudQ4hm9tyLjtG7SEJvQ==
X-Received: by 2002:adf:f90c:: with SMTP id b12mr4518262wrr.63.1554389059761;
        Thu, 04 Apr 2019 07:44:19 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id a11sm21161512wrx.5.2019.04.04.07.44.18
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 07:44:19 -0700 (PDT)
Subject: Re: [PATCH v2] extcon: axp288: Add a depends on ACPI to the Kconfig
 entry
To:     Yue Haibing <yuehaibing@huawei.com>, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, wens@csie.org, rjw@rjwysocki.net
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20190404104222.23900-1-yuehaibing@huawei.com>
 <20190404141748.27048-1-yuehaibing@huawei.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9676ba47-f226-b526-af8b-1cd4d725b7c5@redhat.com>
Date:   Thu, 4 Apr 2019 16:44:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404141748.27048-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04-04-19 16:17, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> As Hans de Goede pointed, using this driver without ACPI
> makes little sense, so add ACPI dependency to Kconfig entry
> to fix a build error while CONFIG_ACPI is not set.
> 
> drivers/extcon/extcon-axp288.c: In function 'axp288_extcon_probe':
> drivers/extcon/extcon-axp288.c:363:20: error: dereferencing pointer to incomplete type
>      put_device(&adev->dev);
> 
> Fixes: 0cf064db948a ("extcon: axp288: Convert to use acpi_dev_get_first_match_dev()")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch looks to me, thanks:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
> v2: rework patch
> ---
>   drivers/extcon/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
> index 1ed4b45..de06faf 100644
> --- a/drivers/extcon/Kconfig
> +++ b/drivers/extcon/Kconfig
> @@ -30,7 +30,7 @@ config EXTCON_ARIZONA
>   
>   config EXTCON_AXP288
>   	tristate "X-Power AXP288 EXTCON support"
> -	depends on MFD_AXP20X && USB_SUPPORT && X86
> +	depends on MFD_AXP20X && USB_SUPPORT && X86 && ACPI
>   	select USB_ROLE_SWITCH
>   	help
>   	  Say Y here to enable support for USB peripheral detection
> 
