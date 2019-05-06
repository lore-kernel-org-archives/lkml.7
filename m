Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9E0C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCAD220C01
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JWm3C8gH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfEFKAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 06:00:00 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41943 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfEFJ77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 05:59:59 -0400
Received: by mail-pg1-f194.google.com with SMTP id z3so2505945pgp.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 02:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eMBEkWY+yoHOv35+4+osAhTZrDmIt7AwEsIPJqdF/3o=;
        b=JWm3C8gHUmsaKnWdHgIGhPMh/OdZYaZQZwQeJOd6DQUH8Gbjik2AaWwJWpbsZ2eTPw
         XQshzRWWqcz5SFWEFbJaozTWLHBtF7VQYwkSL0l+6EG5Lk90/zvLj/WyTC45NDe21H6c
         8JNF2pmDC5CLdVhl+wjvk8oRWyVwSZ2xt31md96O9o6569tOiNNvI5v0w0RQS59ENndp
         9K5/4HnuUqIx14sw3XKE7k6JMpo7lk6i6L0l3j7+vIJzJlzzKQEvPEZYJPMmIGxPlrmq
         HCOdCrd8KniiDBVkCjk7A1gRn7FNDvhO0c7X6Yq5gUOuEYxIq/YrZuZS3ynwenNhvcp8
         v+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eMBEkWY+yoHOv35+4+osAhTZrDmIt7AwEsIPJqdF/3o=;
        b=RXTKqw4y0pf25PtRoJHN5FCSjj9+6SV83bkzcX/lmoNidSvLRlIsERQsbnm4k5DK8Q
         lgmF2IIVeiEFF311NAPZ4f60/70C0Lfttq9DghpIv0dPO9K1eoLGmWa+en8rJSiLZuin
         IShW2JCrL6WlnsuAI6ZLJiU4KZMlAepMT4OSwcS1eWKmiPuxlGAvNcaeS8asr4fTC2A+
         YkamOsBP3M7CA5xrtpCW1e2EO4Xxeu8xDVEgNor2lW/OEG37zvvEIcw4ySZbs9HnuWg3
         42Pd2Qj1ABTanB/uIhlR28Dq/XVr2XVDTgOpMNRbq4CPBmWtKRFkwAYKv4c2+BmsKC3+
         9DYg==
X-Gm-Message-State: APjAAAVKy7qJbK4+Po2yjKNOCKuJ04eWRdg49mkMBPX2MLCnwEcAh3ql
        GNM8Ht9bC9VQucSh6/T1tiqn
X-Google-Smtp-Source: APXvYqzICVCOo980QxHqvj2nEfRkxI54XQPzFRDJGVrhybfA1++ueDo5q6nHCcSILwUj169XUgJEfw==
X-Received: by 2002:a62:3501:: with SMTP id c1mr32740299pfa.184.1557136798385;
        Mon, 06 May 2019 02:59:58 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:611b:55a4:e119:3b84:2d86:5b07])
        by smtp.gmail.com with ESMTPSA id u123sm934037pfu.67.2019.05.06.02.59.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 02:59:57 -0700 (PDT)
Date:   Mon, 6 May 2019 15:29:51 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     mcoquelin.stm32@gmail.com, robh+dt@kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loic.pallardy@st.com
Subject: Re: [PATCH 2/3] ARM: dts: stm32mp157: Add missing pinctrl definitions
Message-ID: <20190506095951.GA23734@Mani-XPS-13-9360>
References: <20190503053123.6828-1-manivannan.sadhasivam@linaro.org>
 <20190503053123.6828-3-manivannan.sadhasivam@linaro.org>
 <369b2593-71b6-0b00-b72c-041967ffba73@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <369b2593-71b6-0b00-b72c-041967ffba73@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Fri, May 03, 2019 at 09:13:27AM +0200, Alexandre Torgue wrote:
> Hi Mani
> 
> On 5/3/19 7:31 AM, Manivannan Sadhasivam wrote:
> > Add missing pinctrl definitions for STM32MP157 MPU.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >   arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 62 +++++++++++++++++++++++
> >   1 file changed, 62 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
> > index 85c417d9983b..0b5bcf6a7c97 100644
> > --- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
> > +++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
> > @@ -241,6 +241,23 @@
> >   				};
> >   			};
> > +			i2c1_pins_b: i2c1-2 {
> > +				pins {
> > +					pinmux = <STM32_PINMUX('F', 14, AF5)>, /* I2C1_SCL */
> > +						 <STM32_PINMUX('F', 15, AF5)>; /* I2C1_SDA */
> > +					bias-disable;
> > +					drive-open-drain;
> > +					slew-rate = <0>;
> > +				};
> > +			};
> > +
> > +			i2c1_pins_sleep_b: i2c1-3 {
> > +				pins {
> > +					pinmux = <STM32_PINMUX('F', 14, ANALOG)>, /* I2C1_SCL */
> > +						 <STM32_PINMUX('F', 15, ANALOG)>; /* I2C1_SDA */
> > +				};
> > +			};
> > +
> >   			i2c2_pins_a: i2c2-0 {
> >   				pins {
> >   					pinmux = <STM32_PINMUX('H', 4, AF4)>, /* I2C2_SCL */
> > @@ -258,6 +275,23 @@
> >   				};
> >   			};
> > +			i2c2_pins_b: i2c2-2 {
> > +				pins {
> > +					pinmux = <STM32_PINMUX('Z', 0, AF3)>, /* I2C2_SCL */
> > +						 <STM32_PINMUX('H', 5, AF4)>; /* I2C2_SDA */
> 
> You can't do that. <STM32_PINMUX('Z', 0, AF3)> has to be declared in
> pincontroller-z. So in your case, you have to define 2 groups for i2C2 for
> your default state (the same for the sleep state).
> 

Ah, yes I failed to note pincontroller z. Will fix it in next revision!

Thanks,
Mani

> regards
> Alex
> 
> 
> 
> 
> > +					bias-disable;
> > +					drive-open-drain;
> > +					slew-rate = <0>;
> > +				};
> > +			};
> > +
> > +			i2c2_pins_sleep_b: i2c2-3 {
> > +				pins {
> > +					pinmux = <STM32_PINMUX('Z', 0, ANALOG)>, /* I2C2_SCL */
> > +						 <STM32_PINMUX('H', 5, ANALOG)>; /* I2C2_SDA */
> > +				};
> > +			};
> > +
> >   			i2c5_pins_a: i2c5-0 {
> >   				pins {
> >   					pinmux = <STM32_PINMUX('A', 11, AF4)>, /* I2C5_SCL */
> > @@ -599,6 +633,34 @@
> >   					bias-disable;
> >   				};
> >   			};
> > +
> > +			uart4_pins_b: uart4-1 {
> > +				pins1 {
> > +					pinmux = <STM32_PINMUX('D', 1, AF8)>; /* UART4_TX */
> > +					bias-disable;
> > +					drive-push-pull;
> > +					slew-rate = <0>;
> > +				};
> > +				pins2 {
> > +					pinmux = <STM32_PINMUX('B', 2, AF8)>; /* UART4_RX */
> > +					bias-disable;
> > +				};
> > +			};
> > +
> > +			uart7_pins_a: uart7-0 {
> > +				pins1 {
> > +					pinmux = <STM32_PINMUX('E', 8, AF7)>; /* UART4_TX */
> > +					bias-disable;
> > +					drive-push-pull;
> > +					slew-rate = <0>;
> > +				};
> > +				pins2 {
> > +					pinmux = <STM32_PINMUX('E', 7, AF7)>, /* UART4_RX */
> > +						 <STM32_PINMUX('E', 10, AF7)>, /* UART4_CTS */
> > +						 <STM32_PINMUX('E', 9, AF7)>; /* UART4_RTS */
> > +					bias-disable;
> > +				};
> > +			};
> >   		};
> >   		pinctrl_z: pin-controller-z@54004000 {
> > 
