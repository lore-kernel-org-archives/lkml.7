Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9523DC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 21:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B6E20848
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 21:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O5bWnXaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgABV1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 16:27:13 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51355 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726194AbgABV1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 16:27:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578000430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PpYbVzWZkkwXmuxKU68lA7mgW4bz/XGYjmci9VZh6ZU=;
        b=O5bWnXaI3rvbpMXDq7orZBjFCTNaRzBbqhqFwXwQba2M166wz8gZ1+zVYqjbbyrhEVAg5+
        NPjB14mKznioFV1+BMRUJ2USCXKEEjIFsX4TXwKa28LeC2rzAjk1sRGhsGq+5jNMouC0dP
        Xqwj93f0Qd9nw+OsaXqymePKum1we0I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-DrHyY_0ZMkaqQ6e_Rd1OZw-1; Thu, 02 Jan 2020 16:27:09 -0500
X-MC-Unique: DrHyY_0ZMkaqQ6e_Rd1OZw-1
Received: by mail-wr1-f72.google.com with SMTP id y7so22235117wrm.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 13:27:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PpYbVzWZkkwXmuxKU68lA7mgW4bz/XGYjmci9VZh6ZU=;
        b=jB4+IBbDkioJ8tK61vIu0Gn4Qg8biBHok3AN4mMxF6IjxYQM4bMgPZWT9r3eNuArhq
         7dRbrytpDBXpuI8/nN5VL1AO+ArrrPXyhz6RBVV190dOkMVTa0DB7oys5vhTeGrFUvX+
         eamT15tvyufesGDAWj+GSKR8YRLZpMAHMjcsMgMFqBSzGbdl91iPGt7nOtZu8xsFYD+k
         KNUq2UmTIo3sgcIGFIkT43swcAEnbgD46Gak5KdTAHFOU/ASdCDrMQfb74hFL5BHvn3f
         sJXaQke+3vkXMNozir/P0vEM4lLMaSZPNpiDPXckG4bcIlVtA+BPKxvRHZYzmJhCWK8H
         zOUA==
X-Gm-Message-State: APjAAAURUhwMSX4XsEW7kwCO2kW82VqYiOxsx4D5UJ5QxpOBIaq6/tgT
        IIhczkGs9qV0QwIEaNerWpnc5INxOH2zIgFMFihVkwUFWk8pzoit1z9306uLNHpQuMueXrfI9mn
        wg71OouiKzrn9BdR6qNdG0U/F
X-Received: by 2002:a05:6000:1187:: with SMTP id g7mr29395664wrx.109.1578000428333;
        Thu, 02 Jan 2020 13:27:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqxzTcuAi7Pt7nocywZojYU3QnxHnmj9Zekuq4+JDJeNLdhsFfNQ//LfZ2fZaVTc9W4d6sCEYQ==
X-Received: by 2002:a05:6000:1187:: with SMTP id g7mr29395655wrx.109.1578000428180;
        Thu, 02 Jan 2020 13:27:08 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id q11sm56704622wrp.24.2020.01.02.13.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2020 13:27:07 -0800 (PST)
Subject: Re: [PATCH] ACPI: button: Add a DMI quirk for Razer Blade Stealth 13
 late 2019 lid-switch
To:     Jason Ekstrand <jason@jlekstrand.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191206175409.335568-1-jason@jlekstrand.net>
 <20200102202754.24028-1-jason@jlekstrand.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7eba4578-42e2-69da-99a3-2fc316a588b8@redhat.com>
Date:   Thu, 2 Jan 2020 22:27:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200102202754.24028-1-jason@jlekstrand.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02-01-2020 21:27, Jason Ekstrand wrote:
> Running evemu-record on the lid switch event shows that the lid reports
> the first close but then never reports an open.  This causes systemd to
> continuously re-suspend the laptop every 30s.  Resetting the _LID to
> open fixes the issue.
> 
> v2: Updated the comment to better describe the behavior of ACPI
> 
> Signed-off-by: Jason Ekstrand <jason@jlekstrand.net>

Thanks, looks good to me now:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   drivers/acpi/button.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 662e07afe9a1..ef5d473e7992 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -122,6 +122,17 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
>   		},
>   		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
>   	},
> +	{
> +		/*
> +		 * Razer Blade Stealth 13 late 2019, notification of the LID device
> +		 * only happens on close, not on open and _LID always returns closed.
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Razer"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Razer Blade Stealth 13 Late 2019"),
> +		},
> +		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
> +	},
>   	{}
>   };
>   
> 

