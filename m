Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83E2C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9566E20693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552405730;
	bh=rvJynhYlX2tizCOlh3wi7Musb3KpzCuBmsJoC7SROEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DNx3QR3K1FNoM1qvLAvFycHmgrJwAq+N9tijb4ZP+1cZfqeux5gxQg+0kt/Hv1eWu
	 obI8e9+aTvWBNoXcuWsWGrf/x6VVhaX4JGNXXGnXfsrF9Pton0wfuI19NGF92Pr1Ee
	 zHyrXfy3sT8aNdO/dHs1dCPCdfTxVjOXov3ncg6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfCLPst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:48:49 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46799 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbfCLPss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:48:48 -0400
Received: by mail-oi1-f196.google.com with SMTP id j10so2426940oij.13;
        Tue, 12 Mar 2019 08:48:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Swil8d26nbBRuIeERFxj3CEgC6UaIXsOtAc/yNrkCTg=;
        b=jmV1VVgP+zk8wDEpJLgpYZ0IPyrTwPzW2jOjUZ2HuNFjKSB4hchb80cQbPkV4z4xxv
         PGnIPWJHMoXaeGNo/zHSTG2Y2C5qoaRyd3HrwTCkVHw5RcHzAkudFjeLj+l/VE8sAl++
         VVNGId4EJiH+aF6YnrTm1u3MmpjDjWsA4JG9dOBLekKB8Mbl/5IEnp2prOEB+py/HX3Y
         mSKptsz/YZCJ2C7NSjLnli3Rsgngff0kizVu2MqLjIwreF0b7E0EJr4O26a3T2K6Gb95
         GvsGLemTDd5pXVKbqIZoUwexeErfJum0dTQlWdBX2AfVJEomQETrq6Vuvr9yGC5rVwaF
         3uTw==
X-Gm-Message-State: APjAAAWz/JCzUPlE6QEZAhdC1HMFJBKuzspmDG+9g/bX42ri0EjwtUy3
        FjywQgcIJtQ25hRnZJnIhA==
X-Google-Smtp-Source: APXvYqwltG9DNQesPzcC0Iub1FKXSuhut5dcBFyyqmOOtWQC5u8K9EOxiqR8No1qy5fVZQV1ijw1Wg==
X-Received: by 2002:aca:42c6:: with SMTP id p189mr2119669oia.163.1552405727445;
        Tue, 12 Mar 2019 08:48:47 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e138sm4131014oih.27.2019.03.12.08.48.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 08:48:46 -0700 (PDT)
Date:   Tue, 12 Mar 2019 10:48:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC V2 1/3] dt-bindings: hwmon: Add tachometer interrupt
 to pwm-fan
Message-ID: <20190312154846.GA11788@bogus>
References: <1551110359-19860-1-git-send-email-stefan.wahren@i2se.com>
 <1551110359-19860-2-git-send-email-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551110359-19860-2-git-send-email-stefan.wahren@i2se.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 04:59:17PM +0100, Stefan Wahren wrote:
> This adds the tachometer interrupt to the pwm-fan binding, which is
> necessary for RPM support.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  Documentation/devicetree/bindings/hwmon/pwm-fan.txt | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
> index 49ca5d8..7d09623 100644
> --- a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
> +++ b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
> @@ -8,6 +8,14 @@ Required properties:
>  
>  Optional properties:
>  - fan-supply    : phandle to the regulator that provides power to the fan
> +- interrupts      : This contains a single interrupt specifier which
> +		    describes the tachometer output of the fan as an
> +		    interrupt source. The output signal must generate a
> +		    defined number of interrupts per fan revolution, which
> +		    require that it must be self resetting edge interrupts.
> +		    See interrupt-controller/interrupts.txt for the format.
> +- interrupt-ratio : defines the ratio interrupts per fan revolution as an
> +		    integer (default is 2 interrupts per revolution)

Name this for what it is, not how it is used. Using 'interrupt' is 
misleading that it is related to the interrupt binding.
'tach-pulse-per-rev' or something similar.

>  
>  Example:
>  	fan0: pwm-fan {
> @@ -38,3 +46,14 @@ Example:
>  					};
>  			     };
>  		};
> +
> +Example 2:
> +	fan0: pwm-fan {
> +		fan0: pwm-fan {
> +		compatible = "pwm-fan";
> +		pwms = <&pwm 0 40000 0>;
> +		fan-supply = <&reg_fan>;
> +		interrupt-parent = <&gpio5>;
> +		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-ratio = <2>;
> +	};
> -- 
> 2.7.4
> 
