Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256D4C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58F621835
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xAo6znHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391593AbfJPIh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:37:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38906 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfJPIh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:37:57 -0400
Received: by mail-pf1-f194.google.com with SMTP id h195so14263395pfe.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 01:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WWx1FFGKOuJRMtTkmthoLwPW2Kzf5U2CvR5+YTbodjA=;
        b=xAo6znHjl9Ltmw0vFumuJohwKsXKRXzV5r7dKsvyLhx07WH33ymhlFmV5JYx4A6Q/P
         dwNiGyzV4LQPENRdjWLcE+KhysJS+FpDi7o7o1LqTO89hSS/57UbHIwL9OkUrBtm9d9Z
         seJvCEGO6N7Z5WbVVOV4j1xbr+cxt2cddiTtV825tcj+vOPJuzATkOhvRzXgOIOYOkEO
         j2iZyGrgrp5+fE48Ue6kUdwTtf+itGbLbuv1nBwIjSmnDorusk8z1dCLe8vzNLvzqh9A
         yk9JYyZhinPISSSBTv7ZRuQzRp9Oan1cEIyciN76kcIEluvWjdvQo/Lb+u7966xVJ8PC
         oBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WWx1FFGKOuJRMtTkmthoLwPW2Kzf5U2CvR5+YTbodjA=;
        b=YASyM2xOsQGZxTrWfYaUiwip4NcDsV2IecDWsf4dDmp0dN7OkFKAqsK9LDsQCBhYjO
         b/xBhWT2HrnpGhpJX5p7PsTAJ2VQCPQmkQWNg2G64KPFaZuIeYGLThbmArXlJdGyd4X/
         qdkouLjQj04zEfQDez7Z2pGaUZpqVui4kBqbqXm2BFzxwN4ZyCRmsidvAvLLBD6Qx7DT
         oyqe9BKNj/vbUaabbSrZXgUxObUt5TT4mZfHtQ1TrGOOfVOMoUZg0D7Dn9t2+ILesw7H
         /vzI9VwpJuCMcTTsiNCoEY+nyYEJ8dbz2qlF0hv4LZGOzDkVUeivZNLc25mgAyhAZ2gz
         YyZg==
X-Gm-Message-State: APjAAAWh60uSDIapdaTPWr/eFiQH8b9AmJCnNcV7kqfiuGlxEZ4NKFWn
        /9G9NDg020AtdP7hSLtGHgRJJioDyg==
X-Google-Smtp-Source: APXvYqywjX6EG0Vqzgqg0Uy+SXn8Ybru/4U99k3x4yloIPg3KKmXpn26QBKc4s/l+yy1i0k3CZZVSw==
X-Received: by 2002:a17:90a:246e:: with SMTP id h101mr3523435pje.133.1571215076312;
        Wed, 16 Oct 2019 01:37:56 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6099:7d36:58bc:3eb9:a64a:7942])
        by smtp.gmail.com with ESMTPSA id v8sm4594520pje.6.2019.10.16.01.37.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Oct 2019 01:37:55 -0700 (PDT)
Date:   Wed, 16 Oct 2019 14:07:48 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     mchehab@kernel.org, sakari.ailus@iki.fi,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        c.barrett@framos.com, a.brela@framos.com
Subject: Re: [PATCH 1/2] dt-bindings: media: i2c: Add IMX296 CMOS sensor
 binding
Message-ID: <20191016083748.GA2288@Mani-XPS-13-9360>
References: <20191011035613.13598-1-manivannan.sadhasivam@linaro.org>
 <20191011035613.13598-2-manivannan.sadhasivam@linaro.org>
 <20191015224554.GA5634@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015224554.GA5634@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, Oct 15, 2019 at 05:45:54PM -0500, Rob Herring wrote:
> On Fri, Oct 11, 2019 at 09:26:12AM +0530, Manivannan Sadhasivam wrote:
> > Add devicetree binding for IMX296 CMOS image sensor.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  .../devicetree/bindings/media/i2c/imx296.txt  | 55 +++++++++++++++++++
> >  1 file changed, 55 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/i2c/imx296.txt
> 
> You should know by now, use DT schema format please.
> 

I know for other subsystems but by having a vague look at the existing bindings
I thought media subsystem is still using .txt. But I now see few yaml bindings
in linux-next and will switch over this.

Btw, is it mandatory now to use YAML bindings for all subsystems? I don't
see any issue (instead I prefer) but I remember that you defer to the preference
of the subsystem maintainers before!

> > diff --git a/Documentation/devicetree/bindings/media/i2c/imx296.txt b/Documentation/devicetree/bindings/media/i2c/imx296.txt
> > new file mode 100644
> > index 000000000000..25d3b15162c1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/i2c/imx296.txt
> > @@ -0,0 +1,55 @@
> > +* Sony IMX296 1/2.8-Inch CMOS Image Sensor
> > +
> > +The Sony IMX296 is a 1/2.9-Inch active pixel type CMOS Solid-state image
> > +sensor with square pixel array and 1.58 M effective pixels. This chip features
> > +a global shutter with variable charge-integration time. It is programmable
> > +through I2C and 4-wire interfaces. The sensor output is available via CSI-2
> > +serial data output (1 Lane).
> > +
> > +Required Properties:
> > +- compatible: Should be "sony,imx296"
> > +- reg: I2C bus address of the device
> > +- clocks: Reference to the mclk clock.
> > +- clock-names: Should be "mclk".
> > +- clock-frequency: Frequency of the mclk clock in Hz.
> > +- vddo-supply: Interface power supply.
> > +- vdda-supply: Analog power supply.
> > +- vddd-supply: Digital power supply.
> > +
> > +Optional Properties:
> > +- reset-gpios: Sensor reset GPIO
> > +
> > +The imx296 device node should contain one 'port' child node with
> > +an 'endpoint' subnode. For further reading on port node refer to
> > +Documentation/devicetree/bindings/media/video-interfaces.txt.
> > +
> > +Required Properties on endpoint:
> > +- data-lanes: check ../video-interfaces.txt
> 
> This should only be required when not using all the lanes on the device.
> 

This is a bit weird! How will someone know how many lanes the device is using
by looking at the binding? He can anyway refer the datasheet but still...

> > +- remote-endpoint: check ../video-interfaces.txt
> 
> Don't really need to document this.
> 

okay.

Thanks,
Mani

> > +
> > +Example:
> > +	&i2c1 {
> > +		...
> > +		imx296: camera-sensor@1a {
> > +			compatible = "sony,imx296";
> > +			reg = <0x1a>;
> > +
> > +			reset-gpios = <&msmgpio 35 GPIO_ACTIVE_LOW>;
> > +			pinctrl-names = "default";
> > +			pinctrl-0 = <&camera_rear_default>;
> > +
> > +			clocks = <&gcc GCC_CAMSS_MCLK0_CLK>;
> > +			clock-names = "mclk";
> > +			clock-frequency = <37125000>;
> > +
> > +			vddo-supply = <&camera_vddo_1v8>;
> > +			vdda-supply = <&camera_vdda_3v3>;
> > +			vddd-supply = <&camera_vddd_1v2>;
> > +
> > +			port {
> > +				imx296_ep: endpoint {
> > +					data-lanes = <1>;
> > +					remote-endpoint = <&csiphy0_ep>;
> > +				};
> > +			};
> > +		};
> > -- 
> > 2.17.1
> > 
