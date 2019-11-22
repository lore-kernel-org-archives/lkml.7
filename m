Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C44CC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E612064B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574467068;
	bh=MpLjFUoVtyelVVDiJZBxklDh+WVhZauvPngcioECS2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mmGkgUSLF13JsyTzaXUvijdZCE9+X6Wz8fqSIWu7Bi7Pq2DbXNM6/IZC2gVW6acYx
	 JPpx8Tex9lWUqOhWQacvQj/oJhiYaJTKmSjoun16TRXw3PiwvWvBppGjDCM4uwJhhx
	 0eoWk0kZMTJlmIw2/lYqsW9uVj1Z4gAVu/nDQ73c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKVX5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 18:57:47 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33695 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfKVX5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 18:57:46 -0500
Received: by mail-ot1-f68.google.com with SMTP id q23so1884008otn.0;
        Fri, 22 Nov 2019 15:57:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=frUbXg9HVcTRfaaxELwHERf+lloS19EI1WW6S+yHA38=;
        b=Mtgn6Hp0Wb8ozbW6eCvPfqphsPvVvTYy1Fq3/CYe6r+0mw/UOpReaIPi4ZJQSvv+W/
         W767UhB/9K7qM2sWHST2WAu5AxnYA4SU1LZyG30qI9xvUxZSMmZNr3ABuwx0z9Z6tqUe
         elgQ9ANq2IHXvOVFQO/PaqPgK7aJXCuxUviVF/wlzqme0zvoA3gwKnG9kUuQe2y4Nn3t
         rirF0qKbJtAKhaRQIr6zuygFdb9+IK5Gs2rK4LMbqU/jNJKw3FQpNWhxrELHMvhPWDc1
         fgAwoZVBO4/sXNEC+pONenSDOMIyw5KqrTmTcd1xZo9f7LOHrR0VkDWSha1qaEQtTFOn
         VfQg==
X-Gm-Message-State: APjAAAV1Uo1u7HVhxEx9ClsVj3AUrr+Z5kvVzozFuBqok5SwEvzP6Y9O
        yRQuiurrOA3xg4lwHYqYmh7Iw7k=
X-Google-Smtp-Source: APXvYqwHRHTMvmyvayb6oZ7vqTCt5okUxjvzyr/SweEAZ3HXsEH7Y8guZbnlyFulghfXVoQpjJozjw==
X-Received: by 2002:a9d:12d2:: with SMTP id g76mr13180792otg.232.1574467066059;
        Fri, 22 Nov 2019 15:57:46 -0800 (PST)
Received: from localhost ([2607:fb90:bd7:3743:c9ec:246b:67b7:9768])
        by smtp.gmail.com with ESMTPSA id b135sm2608451oii.1.2019.11.22.15.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 15:57:45 -0800 (PST)
Date:   Fri, 22 Nov 2019 17:57:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     allen <allen.chen@ite.com.tw>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Pi-Hsun Shih <pihsun@chromium.org>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 3/4] dt-bindings: Add binding for IT6505.
Message-ID: <20191122235731.GB7738@bogus>
References: <1573811564-320-1-git-send-email-allen.chen@ite.com.tw>
 <1573811564-320-4-git-send-email-allen.chen@ite.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573811564-320-4-git-send-email-allen.chen@ite.com.tw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 05:52:19PM +0800, allen wrote:
> From: Allen Chen <allen.chen@ite.com.tw>
> 
> Add a DT binding documentation for IT6505.
> 
> Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> ---
>  .../bindings/display/bridge/ite,it6505.txt         | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/ite,it6505.txt

Please make this a DT schema. See 
Documentation/devicetree/writing-schema.rst.
 
> diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it6505.txt b/Documentation/devicetree/bindings/display/bridge/ite,it6505.txt
> new file mode 100644
> index 00000000..72da0c4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/ite,it6505.txt
> @@ -0,0 +1,28 @@
> +iTE it6505 DP bridge bindings
> +
> +Required properties:
> +        - compatible: "ite,it6505"
> +        - reg: i2c address of the bridge
> +        - ovdd-supply: I/O voltage
> +        - pwr18-supply: Core voltage
> +        - interrupts: interrupt specifier of INT pin
> +        - reset-gpios: gpio specifier of RESET pin
> +	- hpd-gpios:
> +		Hotplug detect GPIO.
> +		Indicates which GPIO should be used for hotplug detection

Indentation is not consistent.

> +	- port@[x]: SoC specific port nodes with endpoint definitions as defined
> +		in Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt

You need to define what each port is. With the schema, that will be 
'port@0' and 'port@1' properties.

> +
> +Example:
> +	dp-bridge@5c {
> +                compatible = "ite,it6505";
> +                interrupts = <152 IRQ_TYPE_EDGE_RISING 152 0>;
> +                reg = <0x5c>;
> +                pinctrl-names = "default";
> +                pinctrl-0 = <&it6505_pins>;
> +                ovdd-supply = <&mt6358_vsim1_reg>;
> +                pwr18-supply = <&it6505_pp18_reg>;
> +                reset-gpios = <&pio 179 1>;
> +                hpd-gpios = <&pio 9 0>;
> +                extcon = <&usbc_extcon>;

Not documented plus it's deprecated.

You're missing ports here and they are required.

Rob
