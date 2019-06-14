Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A07CC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 06:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E3182082C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 06:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boJDsl74"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfFNGEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 02:04:22 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43834 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfFNGEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 02:04:22 -0400
Received: by mail-lj1-f195.google.com with SMTP id 16so1082977ljv.10;
        Thu, 13 Jun 2019 23:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BZ1+jjQyuM9ShLXx7wdchyxtgoPMca+BwMd1ODPeWJw=;
        b=boJDsl74qhnzKQU7lodkIpfkmBeDLR9jlMI+EKnhWaa2u0DciQpBbAL2XU7A8UAIyZ
         HWCUUhxSQNWObJbDN3bnJq+t50QJUAC9MSjvMev8EVUkyIS7HceBmJ+Xrwb+zKzKvdVA
         ng1G+0os+fFygvoju5D5ddkecsi6pgN/Yn46Uu+4l15aVyJpTTu6dCzExpLjHlR50XkH
         ZjC5PwaAsvlk7L+st3SSE0LkQ7cqxfMKmISUcdwfVY9gWO014G11k07Brnc9oahg+GJt
         bTWsKNjb6N7QNNX4DgExvbYN854mOvlBv88N1hbb92ENSMGrM4hWHpcyXvP3jtoGDqYx
         hKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BZ1+jjQyuM9ShLXx7wdchyxtgoPMca+BwMd1ODPeWJw=;
        b=YlSOpX/23binQWE+LWgdlEGejlnRC4Ofl2M42gO/fzOFDBj/i63PSNlR2p7GSiE9Vq
         guJTc7GDtUZLpB15Ze2IeWpdKtjFR9IhibZXEIDMLIoro6unZTC8B85BrngbfgYzgN5Q
         pQGVGfu9tHfxG6CUHclrBlBza/2jU04SXcB0CdyY3rRm04FxY4gTtHn4T5vodtA1Llaj
         E2qTapZF7lhHH6goMzyYHXuToro8y0+4P2B8mK2Ne6Xs1dYXB33x14FMfXqJNvRt4Urt
         fLDXS1R7nxVavhbvsIBIDeC3Gm3FiVb10RWCnToBIHXr14krS/l4yTeDR8caPZ6q8XGy
         9Wcw==
X-Gm-Message-State: APjAAAXEd72ytUadorzamKbZYUFwW9e/04MTC33m9znb7Lb1Qm97aDYC
        j+Hx6oQledIMAfdSqEJh/ck=
X-Google-Smtp-Source: APXvYqz5KYsvUg8CXHUwOmAeFy6BUQ03B1Jx+LzDIwBi8rinS2aLv/YVW8yp8npO9hpcUsxtoY7aIg==
X-Received: by 2002:a2e:8892:: with SMTP id k18mr3065292lji.239.1560492258750;
        Thu, 13 Jun 2019 23:04:18 -0700 (PDT)
Received: from mobilestation ([5.164.217.122])
        by smtp.gmail.com with ESMTPSA id k15sm385288lji.89.2019.06.13.23.04.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 23:04:18 -0700 (PDT)
Date:   Fri, 14 Jun 2019 09:04:16 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Add DT bindings for TI
 ads1000/ads1100 ADCs
Message-ID: <20190614060414.52t7ahfkw44a4eqp@mobilestation>
References: <20190514225810.12591-1-fancer.lancer@gmail.com>
 <20190514225810.12591-2-fancer.lancer@gmail.com>
 <20190613203313.GA23102@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613203313.GA23102@bogus>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob

On Thu, Jun 13, 2019 at 02:33:13PM -0600, Rob Herring wrote:
> On Wed, May 15, 2019 at 01:58:08AM +0300, Serge Semin wrote:
> > Add dt-binding documentation for the Texas Instruments ads1000/ads1100 ADCs
> > driver.
> > 
> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > ---
> >  .../devicetree/bindings/hwmon/ads1000.txt     | 61 ++++++++++++++++
> 
> Bindings should be separate patch.
> 
> >  Documentation/hwmon/ads1000.rst               | 72 +++++++++++++++++++
> >  2 files changed, 133 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/hwmon/ads1000.txt
> >  create mode 100644 Documentation/hwmon/ads1000.rst
> > 
> > diff --git a/Documentation/devicetree/bindings/hwmon/ads1000.txt b/Documentation/devicetree/bindings/hwmon/ads1000.txt
> > new file mode 100644
> > index 000000000000..3907b7da9b33
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwmon/ads1000.txt
> > @@ -0,0 +1,61 @@
> > +ADS1000/ADS1100 (I2C)
> > +
> > +This device is a 12-16 bit A-D converter with 1 input.
> 
> ADC's should be in bindings/iio/adc/
> 
> > +
> > +The inputs can be used either as a differential pair of Vin+ Vin- or as a single
> > +ended sensor for Vin+ GND. The inputs mode is platform-dependent and isn't
> > +configured by software in any case.
> > +
> > +Device A-D converter sensitivity can be configured using two parameters:
> > + - pga is the programmable gain amplifier
> > +    0: x1 (default) 
> > +    1: x2
> > +    2: x4
> > +    3: x8
> > + - data_rate in samples per second also affecting the output code accuracy
> > +    0: 128SPS - +/- Vdd*0.488mV (default, ads1000 accepts this rate only)
> > +    1: 32SPS  - +/- Vdd*0.122mV
> > +    2: 16SPS  - +/- Vdd*0.061mV
> > +    3: 8SPS   - +/- Vdd*0.030mV
> > +   Since this parameter also affects the output accuracy, be aware the greater
> > +   SPS the worse accuracy.
> > +
> > +As a result the output value is calculated by the next formulae:
> > +dVin = Cod * Vdd / (PGA * max(|Cod|)), where
> > +max(|Cod|) - maximum possible value of the output code, which depends on the SPS
> > +setting from the table above.
> > +
> > +The ADS1000/ADS1100 dts-node:
> > +
> > +  Required properties:
> > +   - compatible : must be "ti,ads1000" or "ti,ads1100"
> > +   - reg : I2C bus address of the device
> > +   - #address-cells : must be <1>
> > +   - #size-cells : must be <0>
> > +   - vdd-supply : regulator for reference supply voltage (usually fixed)
> > +
> > +  Optional properties:
> > +   - ti,gain : the programmable gain amplifier setting
> > +   - ti,datarate : the converter data rate
> 
> IIRC, we have standard properties for these.
> 
> > +   - ti,voltage-divider : <R1 R2> Ohms inbound voltage dividers,
> > +     so dVin = (R1 + R2)/R2 * dVin
> > +
> > +Example:
> > +
> > +vdd_5v0: fixedregulator@0 {
> > +	compatible = "regulator-fixed";
> > +	regulator-name = "vdd-ref";
> > +	regulator-min-microvolt = <5000000>;
> > +	regulator-max-microvolt = <5000000>;
> > +	regulator-always-on;
> > +};
> > +
> > +tiadc: ads1000@48 {
> 
> adc@48
> 
> > +	compatible = "ti,ads1000";
> > +	reg = <0x48>;
> > +
> > +	vdd-supply = <&vdd_5v0>;
> > +	ti,gain = <0>;
> > +	ti,voltage-divider = <31600 3600>;
> > +};
> > +

Thanks for this patch review. We had a conversation with Guenter Roeck
and Jonathan Cameron regarding the Linux subsystem to place this patchset
to, and decided to port the driver into the iio subsystem. So if this code
is ported as a separate driver I'll certainly take your comments into
account, while if I manage to integrate it into the existing ads1015 driver,
then this patch will be dropped since ads1015 already have the dedicated
bindings. In the last case sorry for wasting your time in advance.

Regards,
-Sergey
