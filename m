Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7D6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D027214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsBrGmS6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfCLQ4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:56:43 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34129 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfCLQ4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:56:40 -0400
Received: by mail-lf1-f65.google.com with SMTP id y18so2654126lfe.1;
        Tue, 12 Mar 2019 09:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n6hvBt8V2HS4iHS72DbnTSxaIPfyW+7QkX3UsMVK3XA=;
        b=MsBrGmS6t6Pbb4d2lNUxmsjXxBW73glUQWFYvTi+/NbVqwJXXmVd5Rtk4fSutIK9cz
         +Bfe3HRrZSwtG3kYNEs1FT0Ykjfrjd3GYPhIfvMGnNXwqZUy1Pwt3qXggKqRJf6c19W2
         8Ad+MAHwUwAmu3HltFsuFrxQciWhsJc3O3hQ52vB/l/d70bLSLWn5WW9U2ymuVJQCzwb
         zdlugaXoFRBHlb4wk8iWpVhDi286wwVuwmOwWqiz6poqgMtrE1U5SbWdYrdW99z0frfh
         TIQW1A1NnzBIc5AP9quyt/s8LKg6iHnedVd0zDfPVtwr4QIIfz8m7xLRktYmtx/WAHqC
         +yxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n6hvBt8V2HS4iHS72DbnTSxaIPfyW+7QkX3UsMVK3XA=;
        b=dVdK3e26vAagp9KDLx3BNcQmYCHYZbUPnPTtzNGckgt+vQLcccE8Ev1bSm5qhE7nTG
         jlr2ZCcDlzn/238l0LourAD8Fw09JmspLyYvemdySolsqIoWBVtMr8pYEj3Zxt3LCP//
         NQ2foNXaTqMpOuaExYMCxYPMOL+5YJWGIOFrZ2Yg7K+dt7ql2tR+3STD4GSZYdXyWzMZ
         sBsZS8GeYSovYc27sw7SbwnSAgoR6fwpPh0NDFQX7q/tkwhg77ojVZITNyBqz0Lo0GR7
         o6AqxZoIMAt+TdOvWAYuuctFov+kmi34Z8CFU7apOjQKsx5UVXnfJEbmb8vblF9ZU+i9
         OyiQ==
X-Gm-Message-State: APjAAAWKJtKAk28xLpse0ppL7jddcDC1fCPk5ON+sO99qlh5EoYznrR8
        1j1HEJqX3yFj0Uv7dFxJ3N8=
X-Google-Smtp-Source: APXvYqzx1FUdUS0hSQCPSlfOYBamtG7vReInCfBTX32RmjSC7RuYVo7iyZh1iar8G//rpexkZcCKXg==
X-Received: by 2002:a19:81c9:: with SMTP id c192mr3960677lfd.108.1552409797229;
        Tue, 12 Mar 2019 09:56:37 -0700 (PDT)
Received: from [192.168.1.18] (chp67.neoplus.adsl.tpnet.pl. [83.31.13.67])
        by smtp.gmail.com with ESMTPSA id n7sm1448260ljj.71.2019.03.12.09.56.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 09:56:36 -0700 (PDT)
Subject: Re: [PATCH 02/25] leds: core: Add support for composing LED class
 device names
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
 <20190310182836.20841-3-jacek.anaszewski@gmail.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <26d94535-cd45-9826-da24-113b8128f4e9@gmail.com>
Date:   Tue, 12 Mar 2019 17:56:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190310182836.20841-3-jacek.anaszewski@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two auto corrections:

On 3/10/19 7:28 PM, Jacek Anaszewski wrote:
> Add public led_compose_name() API for composing LED class device
> name basing on fwnode_handle data. The function composes device name
> according to either a new <color:function> pattern or the legacy
> <devicename:color:function> pattern. The decision on using the
> particular pattern is made basing on whether fwnode contains new
> "function" and "color" properties, or the legacy "label" proeprty.
> 
> Backwards compatibility with in-driver hard-coded LED class device
> names is assured thanks to the default_desc argument.
> 
> In case none of the aforementioned properties was found, then, for OF
> nodes, the node name is adopted for LED class device name.
> 
> Alongside these changes added is a new tool - tools/leds/get_led_device_info.sh.
> The tool allows retrieving details of a LED class device's parent device,
> which proves that getting rid of a devicename section from LED name pattern
> is justified since this information is already available in sysfs.
> 
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Baolin Wang <baolin.wang@linaro.org>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Dan Murphy <dmurphy@ti.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>   Documentation/leds/leds-class.txt | 20 +++++++++-
>   drivers/leds/led-core.c           | 82 +++++++++++++++++++++++++++++++++++++++
>   include/linux/leds.h              | 31 +++++++++++++++
>   tools/leds/get_led_device_info.sh | 81 ++++++++++++++++++++++++++++++++++++++
>   4 files changed, 213 insertions(+), 1 deletion(-)
>   create mode 100755 tools/leds/get_led_device_info.sh
> 
> diff --git a/Documentation/leds/leds-class.txt b/Documentation/leds/leds-class.txt
> index 8b39cc6b03ee..866fe87063d4 100644
> --- a/Documentation/leds/leds-class.txt
> +++ b/Documentation/leds/leds-class.txt
> @@ -43,7 +43,22 @@ LED Device Naming
>   
>   Is currently of the form:
>   
> -"devicename:colour:function"
> +"colour:function"
> +
> +There might be still LED class drivers around using "devicename:colour:function"
> +naming pattern, but the "devicename" section is now deprecated since it used
> +to convey information that was already available in the sysfs, like product
> +name. There is a tool (tools/leds/get_led_device_info.sh) available for
> +retrieving that information per a LED class device.
> +
> +Associations with other devices, like network ones, should be defined
> +via LED triggr mechanism. This approach is applied by some of wireless

s/triggr/trigger/

> +network drivers that create triggers dynamically and incorporate phy
> +name into its name. On the other hand input subsystem offers LED - input

s/its name/the trigger name/

> +bridge (drivers/input/input-leds.c) for exposing keyboard LEDs as LED class
> +devices. The get_led_device_info.sh script has support for retrieving related
> +input device node name. Should it support discovery of associations between
> +LEDs and other subsystems, please don't hesitate to submit a relevant patch.
>   
>   There have been calls for LED properties such as colour to be exported as
>   individual led class attributes. As a solution which doesn't incur as much
> @@ -51,6 +66,9 @@ overhead, I suggest these become part of the device name. The naming scheme
>   above leaves scope for further attributes should they be needed. If sections
>   of the name don't apply, just leave that section blank.
>   
> +Please also keep in mind that LED subsystem has a protection against LED name
> +conflict. It adds numerical suffix (e.g. "_1", "_2", "_3" etc.) to the requested
> +LED class device name in case it is already in use.


-- 
Best regards,
Jacek Anaszewski
