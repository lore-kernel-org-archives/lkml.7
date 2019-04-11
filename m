Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D80EC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 228682070D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikJy+G8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfDKTs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 15:48:26 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38081 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbfDKTsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 15:48:25 -0400
Received: by mail-lf1-f66.google.com with SMTP id u24so5637908lfg.5;
        Thu, 11 Apr 2019 12:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a3b/ahe3qHATS0gYq+xBesVDHXDkWMjESQ2l8WL1FN4=;
        b=ikJy+G8xdJT4ibu74W7ifHib6r4OVxDLUM7me3ehvkHlYp4obZZzSrPKkfs/5iZFB1
         I8ZohqTUjcls13xLRscAyMLBsNKUNCbPNZ2GVxat+YTGlaYszXE7J8jv8dERi5OSYEOF
         OlUQsiB5TMB46pvGF2NjLkiol18xX118gK4z+NFODnSB1Pnd55HHbS3d23ZMOyZsmGg7
         W41TQ0bRCVng/fexJYU/OimbJDTNVD8WPY9M9TPSLBBorsS7PTlGviszT7VmhJNHDx/x
         Cu2wzpNNRXrL8twkR0mfwTBG+j6iHGkNDSFEktBzYc+QyzMN7sTzQkq55uqhQfk1KT4o
         3LVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a3b/ahe3qHATS0gYq+xBesVDHXDkWMjESQ2l8WL1FN4=;
        b=CFc0XeKlHCMtRYVcOctOCB01BWKbBW4rrDwYjV3fcCJkDwvahOhtSkVszxg+Nk0yAA
         HAucnbAoQLjXO8pr+devql9exRklfXSRDnKPevO13vusr0HL79BYb5ODlxeNmDTFxytM
         QRg1Wv0zTnSoIGXz4nsOo2JQyvB+z8LUnqUb6jWfY63e25sCr5Lk03sLKXe7F3+TceQK
         vOaf9DEHm7/KXnmOs+57e2RlnnxKi8jechD8/hRKyqcUr48rs4W2zHBwrmZoHY7vmGEs
         FQt475DxphEwfdDe/daACNTgdg+jL9hg5hGS1/mAcfbapAut7JULqQzbqjhVK8Lv76E+
         TBAg==
X-Gm-Message-State: APjAAAUo/Ij7/NLWyr9SVOPfG6AK2khkdY9vIQW/hnm9LX25jKnaIxIG
        KW4EarcyT/ccpS0SFJyBNEDqmEg9
X-Google-Smtp-Source: APXvYqzDuVZ9liCpTzi3qURELPsHv3wb7LCWetd90OERKzI3t/Qesn1tvVge4NN3+HSEHAJcvaprGA==
X-Received: by 2002:ac2:4246:: with SMTP id m6mr28288348lfl.131.1555012102326;
        Thu, 11 Apr 2019 12:48:22 -0700 (PDT)
Received: from [192.168.1.19] (dns147.neoplus.adsl.tpnet.pl. [83.24.100.147])
        by smtp.gmail.com with ESMTPSA id f15sm7947070ljm.47.2019.04.11.12.48.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 12:48:21 -0700 (PDT)
Subject: Re: [PATCH v2 4/6] dt-bindings: ti-lmu: Modify dt bindings for the
 LM3697
To:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org, pavel@ucw.cz,
        lee.jones@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20190405142855.3969-1-dmurphy@ti.com>
 <20190405142855.3969-4-dmurphy@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <04e160da-a73e-d330-3df4-8f420b3612b4@gmail.com>
Date:   Thu, 11 Apr 2019 21:48:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405142855.3969-4-dmurphy@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

I've collected references to the DT patches we're waiting
to be reviewed. This is just to make sure that none of them
will be missed - recent traffic on the linux-leds list
is a bit heavier.

[0] - draft of LED multi color class - we would especially like
       to get a feedback on the proposed brightness-model DT design
[1][2] - LM3697 backlight driver rework
[3][4] - LM36274 backlight driver with regulator support

On 4/5/19 4:28 PM, Dan Murphy wrote:
> The LM3697 is a single function LED driver. The single function LED
> driver needs to reside in the LED directory as a dedicated LED driver
> and not as a MFD device.  The device does have common brightness and ramp
> features and those can be accomodated by a TI LMU framework.
> 
> The LM3697 dt binding needs to be moved from the ti-lmu.txt and a dedicated
> LED dt binding needs to be added.  The new LM3697 LED dt binding will then
> reside in the Documentation/devicetree/bindings/leds directory and follow the
> current LED and general bindings guidelines.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v2 - Made changes to reference ti,brightness-resolution to the ti-lmu.txt -
> https://lore.kernel.org/patchwork/patch/1054501/
> 
>   .../devicetree/bindings/leds/leds-lm3697.txt  | 73 +++++++++++++++++++
>   .../devicetree/bindings/mfd/ti-lmu.txt        | 27 +------
>   2 files changed, 74 insertions(+), 26 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3697.txt
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-lm3697.txt b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
> new file mode 100644
> index 000000000000..02378f33c9ab
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
> @@ -0,0 +1,73 @@
> +* Texas Instruments - LM3697 Highly Efficient White LED Driver
> +
> +The LM3697 11-bit LED driver provides high-
> +performance backlight dimming for 1, 2, or 3 series
> +LED strings while delivering up to 90% efficiency.
> +
> +This device is suitable for display and keypad Lighting
> +
> +Required properties:
> +	- compatible:
> +		"ti,lm3697"
> +	- reg :  I2C slave address
> +	- #address-cells : 1
> +	- #size-cells : 0
> +
> +Optional properties:
> +	- enable-gpios : GPIO pin to enable/disable the device
> +	- vled-supply : LED supply
> +
> +Required child properties:
> +	- reg : 0 - LED is Controlled by bank A
> +		1 - LED is Controlled by bank B
> +	- led-sources : Indicates which HVLED string is associated to which
> +			control bank.  This is a zero based property so
> +			HVLED1 = 0, HVLED2 = 1, HVLED3 = 2.
> +			Additional information is contained
> +			in Documentation/devicetree/bindings/leds/common.txt
> +
> +Optional child properties:
> +	- ti,brightness-resolution - see Documentation/devicetree/bindings/mfd/ti-lmu.txt
> +	- ramp-up-ms: see Documentation/devicetree/bindings/mfd/ti-lmu.txt
> +	- ramp-down-ms: see Documentation/devicetree/bindings/mfd/ti-lmu.txt
> +	- label : see Documentation/devicetree/bindings/leds/common.txt
> +	- linux,default-trigger :
> +	   see Documentation/devicetree/bindings/leds/common.txt
> +
> +Example:
> +
> +HVLED string 1 and 3 are controlled by control bank A and HVLED 2 string is
> +controlled by control bank B.
> +
> +led-controller@36 {
> +	compatible = "ti,lm3697";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	reg = <0x36>;
> +
> +	enable-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
> +	vled-supply = <&vbatt>;
> +
> +	led@0 {
> +		reg = <0>;
> +		led-sources = <0 2>;
> +		ti,brightness-resolution = <2047>;
> +		ramp-up-ms = <5000>;
> +		ramp-down-ms = <1000>;
> +		label = "white:first_backlight_cluster";
> +		linux,default-trigger = "backlight";
> +	};
> +
> +	led@1 {
> +		reg = <1>;
> +		led-sources = <1>;
> +		ti,brightness-resolution = <255>;
> +		ramp-up-ms = <500>;
> +		ramp-down-ms = <1000>;
> +		label = "white:second_backlight_cluster";
> +		linux,default-trigger = "backlight";
> +	};
> +}
> +
> +For more product information please see the link below:
> +http://www.ti.com/lit/ds/symlink/lm3697.pdf
> diff --git a/Documentation/devicetree/bindings/mfd/ti-lmu.txt b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
> index 5881929d5f7a..a948a8f41b2c 100644
> --- a/Documentation/devicetree/bindings/mfd/ti-lmu.txt
> +++ b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
> @@ -8,7 +8,6 @@ TI LMU driver supports lighting devices below.
>     LM3632       Backlight and regulator
>     LM3633       Backlight, LED and fault monitor
>     LM3695       Backlight
> -  LM3697       Backlight and fault monitor
>   
>   Required properties:
>     - compatible: Should be one of:
> @@ -16,11 +15,10 @@ Required properties:
>                   "ti,lm3632"
>                   "ti,lm3633"
>                   "ti,lm3695"
> -                "ti,lm3697"
>     - reg: I2C slave address.
>            0x11 for LM3632
>            0x29 for LM3631
> -         0x36 for LM3633, LM3697
> +         0x36 for LM3633
>            0x63 for LM3695
>   
>   Optional property:
> @@ -51,7 +49,6 @@ Optional nodes:
>       Required properties:
>         - compatible: Should be one of:
>                       "ti,lm3633-fault-monitor"
> -                    "ti,lm3697-fault-monitor"
>     - leds: LED properties for LM3633. Please refer to [2].
>     - regulators: Regulator properties for LM3631 and LM3632.
>                   Please refer to [3].
> @@ -216,25 +213,3 @@ lm3695@63 {
>   		};
>   	};
>   };
> -
> -lm3697@36 {
> -	compatible = "ti,lm3697";
> -	reg = <0x36>;
> -
> -	enable-gpios = <&pioC 2 GPIO_ACTIVE_HIGH>;
> -
> -	backlight {
> -		compatible = "ti,lm3697-backlight";
> -
> -		lcd {
> -			ti,brightness-resolution = <255>;
> -			led-sources = <0 1 2>;
> -			ramp-up-ms = <200>;
> -			ramp-down-ms = <200>;
> -		};
> -	};
> -
> -	fault-monitor {
> -		compatible = "ti,lm3697-fault-monitor";
> -	};
> -};
> 

[0] https://marc.info/?l=linux-kernel&m=155414072611538&w=2
[1] https://marc.info/?l=devicetree&m=155447454524411&w=2
[2] https://lore.kernel.org/patchwork/patch/1058762/
[3] https://marc.info/?l=devicetree&m=155447624324995&w=2
[4] https://lore.kernel.org/patchwork/patch/1058779/

-- 
Best regards,
Jacek Anaszewski
