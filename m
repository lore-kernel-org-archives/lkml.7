Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DDBC606A7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 10:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4076C2064A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 10:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tx0P6Ygy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbfGHKuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 06:50:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38452 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfGHKub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 06:50:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id g17so6377702wrr.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 03:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lej7Q+QP3kcSJDvUANx4MpD1co7bVMerIr3ru5n/a4c=;
        b=tx0P6Ygyb6DdA7G9POdLYsY1nwSb8R4k49+VwLBqIM1T9U1q/43us/Hdp8RMCdxoM6
         CxuFx8aefoTs/hCz3yvx7UmSMCQs75fPh2oqTpzSzgEAVtuMo0TiIddSX/MloG/0NaMC
         /OuHfKw1t3wHozbRyinjBNu/uYqpLFdPDxvZTgi28Oj1nGIxdbftq3SUKZrE3RxOOkST
         1JZo4hQM22IsH+9TgOURFthDgZYKAc/w1OfQpWX5hwJ4HsE0k/ydx+szAcuMarDgp4qs
         4If7zr2vnPvh63kFDa+exPDoE6uCHeBsdsee98ujGIC3d2X6vubZP2v1YiFM3agasNf0
         SaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lej7Q+QP3kcSJDvUANx4MpD1co7bVMerIr3ru5n/a4c=;
        b=iTiXQqiFGEVhhTPuBlIp9cKILjEncyMtiesaPXXbWSByPPtP4O8yKSa+Qi0xy5+NDn
         qqq8kdPtZCNhVrLjaEFNTaCUQ9yD02AXSEzCGSCZMQsurB+UhTNsl7lSA/1aqv08wBZO
         MyiX6cNN4fPlEJ7udLEn4Bns64pE622l981VY2VMwXGgIDC6A9rs4KLxpMsQz60+qVU/
         Fb2Iz0dNEOr0KYamqUdeLydHAnyLTkFsYFADHXCi/4iDYzo1lENcXxfweCm0RJY38PR5
         zb/huczoJ1hbZiJSJo8OCk4VMefg2Je++TBLL235BdL2HF7DpEuAufj/jcJvtLOaUI6j
         8F0Q==
X-Gm-Message-State: APjAAAXBHou/twZb00DKEmjTja5q5FXW6gpRb3leN1RqeSD+kepw3OHC
        /As4YmcsinVAnK9J3IZiSlb7zQ==
X-Google-Smtp-Source: APXvYqyu3f1q1SnNB9p5IHgyIAns7STGef0JfhMHOgez/jYHIaz1D/lShD2tvop5KW5jyBLxrvSP+g==
X-Received: by 2002:a5d:5446:: with SMTP id w6mr13496134wrv.164.1562583029398;
        Mon, 08 Jul 2019 03:50:29 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id o11sm16642628wmh.37.2019.07.08.03.50.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 03:50:28 -0700 (PDT)
Date:   Mon, 8 Jul 2019 11:50:26 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jean-Jacques Hiblot <jjhiblot@ti.com>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        mark.rutland@arm.com, lee.jones@linaro.org, jingoohan1@gmail.com,
        dmurphy@ti.com, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        tomi.valkeinen@ti.com
Subject: Re: [PATCH v2 3/4] dt-bindings: backlight: Add led-backlight binding
Message-ID: <20190708105026.jfl4krv2veb7gzow@holly.lan>
References: <20190708102700.23138-1-jjhiblot@ti.com>
 <20190708102700.23138-4-jjhiblot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708102700.23138-4-jjhiblot@ti.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 12:26:59PM +0200, Jean-Jacques Hiblot wrote:
> Add DT binding for led-backlight.
> 
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
> ---
>  .../bindings/leds/backlight/led-backlight.txt | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/led-backlight.txt
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/led-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/led-backlight.txt
> new file mode 100644
> index 000000000000..4f545316b288
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/led-backlight.txt
> @@ -0,0 +1,29 @@
> +led-backlight bindings
> +
> +This binding is used to describe a basic backlight device made of LEDs.
> +It can also be used to describe a backlight device controlled by the output of
> +a LED driver.
> +
> +Required properties:
> +  - compatible: "led-backlight"
> +  - leds: a list of LEDs
> +
> +Optional properties:
> +  - brightness-levels: Array of distinct brightness levels. These
> +                       are in the range from 0 to 255. The actual brightness
> +                       level programmed in each LED will be adjusted based on
> +                       its maximum brightness:
> +                       led brightness = (level * maximum brightness) / 255

8-bits is a narrow range and likely to make animated backlight effects
impossible because the stepping artefacts would be too obvious.

I'd rather see the brightness-levels table expressed in the native
steps of the LEDs in the leds list.

I know this means that the LEDs must have identical ranges but I think
it is OK. A backlight design whose LEDs are connected to non-identical
drivers is either badly broken or sufficiently exotic to need to special
purpose driver. The driver can therefore fail to probe if the LEDs are
mismatched.

> +
> +  - default-brightness-level: The default brightness level (index into the
> +                              array defined by the "brightness-levels" property).

The brightness-levels property is optional... this text needs to be
updated.


Daniel.
