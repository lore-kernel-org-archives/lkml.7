Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA14CC2D0BE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 14:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDAD206F4
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 14:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SkKosVp5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfLHOFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 09:05:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53619 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726336AbfLHOFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 09:05:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575813920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=30ipBLDOpILVGltlX+yMvZubDIZXAvCZnhKBpoYTnd0=;
        b=SkKosVp5YTE7Hi+oVvSCkJn+2c6pDWpLMZ8JKKGRa6FCydEcMO1GZ+j2iWajZOm/dz4vML
        e0d2wF6PjmSKKP3juJ8JlvHVl9h3l+QOUmKiJirjh725ShF7xWDWFm0pRxeCVZMrW3rnKH
        76F6xBL4tdnPr80KSJA40GtnqIlG3mU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-Jlez8AwzPJG4MblyeZEWbg-1; Sun, 08 Dec 2019 09:05:19 -0500
Received: by mail-wr1-f69.google.com with SMTP id 90so5981148wrq.6
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 06:05:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=30ipBLDOpILVGltlX+yMvZubDIZXAvCZnhKBpoYTnd0=;
        b=AwIEaTXa3n2scZ3RM7+rI+9kMaKUuzgkgUOQgG8KbbfA/2J3UaKoKW/tV3R3v2AFDj
         FZYvGCx7xC6GKz9QHeIS+oNbDzU/WNA2HaW7fFP/qQo/rx/r4YgUKHADP1oDCsF4Ypxb
         WAvCTaS1tykRR4E/qAmRTNmllDfFW7KHn4xySBocPlknLJuDGwm6G16CF1tkQGOkRL30
         f5I8MwEK1dhJZ2tSwp18nurZgKG1/cqaAdsmEndf4Ic+kaBX/40ibBu0W2Z7O6MwdYSC
         3BeFDFsTOZm2o6HcJKEoQ85VCW934B1wTJ6+clfSzzDFoRU3gPl3hbyb2dBLUQDaWu6Y
         0ppg==
X-Gm-Message-State: APjAAAW+i97jfUXWRtuOLg109ngrUGAu0CeNip8Q/1IY8MdFp7QJVyHs
        5mvDq9L+3OF9Upm/nZzkwMXSDqXOZZgbsCXaqrRncqYWU7xpYUqMGI4S7RvMA8bk7bunUErcEup
        iwEVtFn/q9fPJvV+gkCe/pRPW
X-Received: by 2002:adf:ebc3:: with SMTP id v3mr3828228wrn.280.1575813918079;
        Sun, 08 Dec 2019 06:05:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqwClxrwfKXccjCy3DgP3KyYWvRyxieD/Vi/Ud1fqKAxEpVX6n6WXJ4jmC4eyZLJ/l742BKMfA==
X-Received: by 2002:adf:ebc3:: with SMTP id v3mr3828207wrn.280.1575813917877;
        Sun, 08 Dec 2019 06:05:17 -0800 (PST)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id q6sm24703020wrx.72.2019.12.08.06.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2019 06:05:17 -0800 (PST)
Subject: Re: [PATCH] ACPI: button: Add a DMI quirk for Razer Blade Stealth 13
 late 2019 lid-switch
To:     Jason Ekstrand <jason@jlekstrand.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191206175409.335568-1-jason@jlekstrand.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3565c99f-3cc4-32cb-1cac-98c7b0392e5c@redhat.com>
Date:   Sun, 8 Dec 2019 15:05:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191206175409.335568-1-jason@jlekstrand.net>
Content-Language: en-US
X-MC-Unique: Jlez8AwzPJG4MblyeZEWbg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06-12-2019 18:54, Jason Ekstrand wrote:
> Running evemu-record on the lid switch event shows that the lid reports
> the first close but then never reports an open.  This causes systemd to
> continuously re-suspend the laptop every 30s.  Resetting the _LID to
> open fixes the issue.

Sorry to be a bit nitpicky here, but the LID does work normally right,
so it does signal an event when it gets closed a second time right?

Your current commit message and comment suggest closing the LID only
works once. So perhaps something like this for the comment:

/*
  * Razer Blade Stealth 13 late 2019, _LID always reports closed,
  * even when opened.
  */

And adjust the comment accordingly.

Regards,

Hans



> Signed-off-by: Jason Ekstrand <jason@jlekstrand.net>
> ---
> 
> Re-sending due to a typo in my own e-mail address. :(
> 
>   drivers/acpi/button.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 662e07afe9a1..f7ca94e41c48 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -122,6 +122,17 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
>   		},
>   		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
>   	},
> +	{
> +		/*
> +		 * Razer Blade Stealth 13 late 2019, _LID reports the first
> +		 * close but never resets to open.
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

