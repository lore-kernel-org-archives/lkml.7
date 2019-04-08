Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012FDC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC2C2147A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BHQbkeBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbfDHQav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:30:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41375 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbfDHQav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:30:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id r4so17160683wrq.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 09:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yEKXcITmtldfqCzJc6t+ZKTv2phF27b4OjLELxjjuik=;
        b=BHQbkeBrc1olUJ/fEOrk5kJJhvIDLerla24Kkxgg2O5EEf9C972QWOl1txaCLdk1/X
         6o+A8pICGlFX5JJ87rLZRcHNVHOM4fqI9Y7xqkI21He9lKRNDj31fqBcf+zQ/XZhBLOI
         +pdK4Lt+wJ1QuAQtsFAusVU4KrGmnP/fjynvU+6lK9tzyy3pLxYXX39y1KZse5VQpVgL
         1sqEXiVEatxVOn469FyTcGLSnwaByvX2+ezhBSZmpRpYo0uGt2JEiNvgW0bBUXIh5naC
         2cSLieOkWiHs4ivhg6TD05X10OuUXxxVzNxwsF6xezDXlVUborYVPxrE98n3uvpCUPat
         cffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yEKXcITmtldfqCzJc6t+ZKTv2phF27b4OjLELxjjuik=;
        b=olxfqcQrnEEW4f6DTJUV9s77LtWKKKZQdRhD+iJkFWyA21r6JtArJm2zeTZf/O6SH6
         sbtCpPqcQI1jdKp2CTbhCFCvYS5PTl7TYI/PkymOzaSz2r/F4cIl/XmlrQljFC7BbHkQ
         8DlReN0eeCi96Y4NXh7k/RnRyCe1hFI3WKpNCOBQlC+Je9/B3H7pjlkhXWHt51fPzy2m
         ZUnddhnWG4C+3RhzkYqnAs0zPKaDP5UP0MB7ho4A6xBTsnCTV7k87LLCJM4XsSn7yPks
         fWsMgCIFzG+obSj68wainde+8jruLe8dkdDKKixOmZFuvthic0+twPAhBvfcuzmWvN04
         Z/pg==
X-Gm-Message-State: APjAAAWd6bcTGJBemcfv3w40phdknfQspu7tKkZ+ApXEeHjYRaSYB6mN
        zyhGSwKbJp51OCVKm+FB9jpvUYCCHjQ=
X-Google-Smtp-Source: APXvYqy/MtIXl8O0YXmpwgUO1kZXuh3zD2Wwb7p4RpSlRImi1S6tHCOWPEU9esefiDCU+60VF878gA==
X-Received: by 2002:adf:dc83:: with SMTP id r3mr18954288wrj.179.1554741048937;
        Mon, 08 Apr 2019 09:30:48 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id b134sm23819931wmd.26.2019.04.08.09.30.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 09:30:48 -0700 (PDT)
Subject: Re: [PATCH] ARM: dts: at91sam9261ek: remove unused chosen nodes
To:     Rob Herring <rob.herring@linaro.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190408151155.20279-1-alexandre.belloni@bootlin.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <2f831f1b-c87d-48bd-cf02-2ebb334b964c@linaro.org>
Date:   Mon, 8 Apr 2019 18:30:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408151155.20279-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rob,

the following patch has been pushed in 2016 by commit 51f0aeb2d21f1.

Being able to specify which timer should act as a clocksource or a
clockevent is often requested. Doing this from the driver itself forces
to do some assumption in the timer definition ordering in the DT.

That impacts badly the resulting code and its self-encapsulation.

 - There is one node and the driver hardcodes the value and initializes
a clocksource and a clockevent

 - There are several nodes, one for the clocksource and one for the
clockevent, and the driver assumes the order of the node in the DT

 - There are several nodes and multiple channels and those are used for
PWM. It is impossible to know which one are used for PWM or for the
clocksource or for the clockevent

For example with STM32, we should be able to specify which timer to use.
There are 16 timers IIRC, they can be used for PWM, clocksource or
clockevent. Half is 16 bits, other half is 32 bits, depending on the
destination of the platform we can be interested to use one or another
without recompiling a kernel but just the DT.

We need a way to specify which timer to be used from the DT. The patch
below sounded like a good way to characterize the nodes as they belong
to the 'chosen' node and we stay to a 'linux' thing.

What do you think ?


On 08/04/2019 17:11, Alexandre Belloni wrote:
> The chosen clocksource and clockevent bindings have never been accepted and
> parsed, remove them.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  arch/arm/boot/dts/at91sam9261ek.dts | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91sam9261ek.dts b/arch/arm/boot/dts/at91sam9261ek.dts
> index a57f2d435dca..11ed55d8a87d 100644
> --- a/arch/arm/boot/dts/at91sam9261ek.dts
> +++ b/arch/arm/boot/dts/at91sam9261ek.dts
> @@ -15,14 +15,6 @@
>  	chosen {
>  		bootargs = "rootfstype=ubifs ubi.mtd=5 root=ubi0:rootfs rw";
>  		stdout-path = "serial0:115200n8";
> -
> -		clocksource {
> -			timer = <&timer0>;
> -		};
> -
> -		clockevent {
> -			timer = <&timer1>;
> -		};
>  	};
>  
>  	memory {
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

