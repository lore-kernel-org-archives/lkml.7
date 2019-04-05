Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A98C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D15B21871
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XaU832AD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfDELpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:45:53 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36594 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfDELpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:45:52 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x35Bje1U126236;
        Fri, 5 Apr 2019 06:45:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554464740;
        bh=vWhPjS/v+zJ5TQy0s/PE5t11Q3hoZt15N0sTGRs+uxA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=XaU832AD/QSL0JKZ9xMKhl6WhRhcOaUupd099kyeZBebawaygsghqf+4Mxmlp1G8t
         HmnTAeRJ6FOcHrlTEWKI/EDN0mBbaX4/oygmF/er1K4jbaeXEuTOY8GLbF0gmJYojI
         JwA75A71MfdamoWZ7+FQ96kG/plJjj6TFKZ+4aPU=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x35Bjeqn065345
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Apr 2019 06:45:40 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 5 Apr
 2019 06:45:40 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 5 Apr 2019 06:45:40 -0500
Received: from [172.22.78.91] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x35Bjd5u024418;
        Fri, 5 Apr 2019 06:45:40 -0500
Subject: Re: [PATCH v3 05/25] leds: core: Add support for composing LED class
 device names
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <linux-leds@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pavel@ucw.cz>, <robh@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>
References: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
 <20190331175501.23471-6-jacek.anaszewski@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <eda766d7-3974-0e1f-3025-59c0aa840b14@ti.com>
Date:   Fri, 5 Apr 2019 06:45:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190331175501.23471-6-jacek.anaszewski@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek

On 3/31/19 12:54 PM, Jacek Anaszewski wrote:
> Add generic support for composing LED class device name basing on
> fwnode_handle data. The function composes device name according to
> either a new <color:function> pattern or the legacy
> <devicename:color:function> pattern. The decision on using the
> particular pattern is made basing on whether fwnode contains new
> "function" and "color" properties, or the legacy "label" proeprty.
> 
> Backward compatibility with in-driver hard-coded LED class device
> names is assured thanks to the default_label and led_hw_name properties
> of newly introduced struct led_init_data.
> 
> In case none of the aforementioned properties was found, then, for OF
> nodes, the node name is adopted for LED class device name.
> 
> At the occassion of amending the Documentation/leds/leds-class.txt
> unify spelling: colour -> color.
> 
> Alongside these changes added is a new tool - tools/leds/get_led_device_info.sh.
> The tool allows retrieving details of a LED class device's parent device,
> which proves that getting rid of a devicename section from LED name pattern
> is justified since this information is already available in sysfs.
> 
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Baolin Wang <baolin.wang@linaro.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Dan Murphy <dmurphy@ti.com>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Simon Shields <simon@lineageos.org>
> ---
>  Documentation/leds/leds-class.txt | 27 +++++++++--
>  drivers/leds/led-class.c          | 29 ++++++++++--
>  drivers/leds/led-core.c           | 96 +++++++++++++++++++++++++++++++++++++++
>  include/linux/leds.h              | 43 ++++++++++++++++++
>  tools/leds/get_led_device_info.sh | 81 +++++++++++++++++++++++++++++++++
>  5 files changed, 270 insertions(+), 6 deletions(-)
>  create mode 100755 tools/leds/get_led_device_info.sh
> 
> diff --git a/Documentation/leds/leds-class.txt b/Documentation/leds/leds-class.txt
> index 8b39cc6b03ee..11e19c3c2e4d 100644
> --- a/Documentation/leds/leds-class.txt
> +++ b/Documentation/leds/leds-class.txt
> @@ -43,14 +43,35 @@ LED Device Naming
>  
>  Is currently of the form:
>  
> -"devicename:colour:function"
> -
> -There have been calls for LED properties such as colour to be exported as
> +"color:function"
> +
> +There might be still LED class drivers around using "devicename:color:function"
> +naming pattern, but the "devicename" section is now deprecated since it used
> +to convey information that was already available in the sysfs, like product
> +name. There is a tool (tools/leds/get_led_device_info.sh) available for
> +retrieving that information per a LED class device.
> +
> +Associations with other devices, like network ones, should be defined
> +via LED trigger mechanism. This approach is applied by some of wireless
> +network drivers that create triggers dynamically and incorporate phy
> +name into the trigger name. On the other hand input subsystem offers LED - input
> +bridge (drivers/input/input-leds.c) for exposing keyboard LEDs as LED class
> +devices. The get_led_device_info.sh script has support for retrieving related
> +input device node name. Should it support discovery of associations between
> +LEDs and other subsystems, please don't hesitate to submit a relevant patch.
> +
> +There have been calls for LED properties such as color to be exported as
>  individual led class attributes. As a solution which doesn't incur as much
>  overhead, I suggest these become part of the device name. The naming scheme
>  above leaves scope for further attributes should they be needed. If sections
>  of the name don't apply, just leave that section blank.
>  
> +Please also keep in mind that LED subsystem has a protection against LED name
> +conflict. It adds numerical suffix (e.g. "_1", "_2", "_3" etc.) to the requested
> +LED class device name in case it is already in use. In order to prevent LED core
> +from assigning these suffixes in an arbitrary order the led-enumerator fwnode
> +property can be used for differentiation of LEDs that share common function
> +and/or color. In this case enumerators will be prepended with "-" character.
>  
>  Brightness setting API
>  ======================
> diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
> index 2f09156b0c63..bfd46a9bba63 100644
> --- a/drivers/leds/led-class.c
> +++ b/drivers/leds/led-class.c
> @@ -26,6 +26,18 @@
>  
>  static struct class *leds_class;
>  
> +const char *led_colors[LED_COLOR_ID_COUNT] = {
> +	[LED_COLOR_ID_WHITE] = "white",
> +	[LED_COLOR_ID_RED] = "red",
> +	[LED_COLOR_ID_GREEN] = "green",
> +	[LED_COLOR_ID_BLUE] = "blue",
> +	[LED_COLOR_ID_AMBER] = "amber",
> +	[LED_COLOR_ID_VIOLET] = "violet",
> +	[LED_COLOR_ID_YELLOW] = "yellow",
> +	[LED_COLOR_ID_IR] = "ir",
> +};
> +EXPORT_SYMBOL_GPL(led_colors);
> +

Why is this exported when it is only used here?

I can re-use this array for the multi color framework so I don't oppose it being exported.

Reviewed-by: Dan Murphy <dmurphy@ti.com>

Dan

<snip>-- 
------------------
Dan Murphy
