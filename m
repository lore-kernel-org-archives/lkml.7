Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8E8C282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDAC621855
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554530839;
	bh=HovPAW/0sgmEibhiCsPOBHtw9jkitpEIaTOL831TlXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Y0emrsM4RdeEQr3GlWc2e6/Lu5hz22EA48wo6Yqt8gKO2HYkn4LflspsRWlX/ZQUG
	 YqWWSdQUoy5U1FLNsFW2yljWbvSyWfF/2ktCrFMSZj1WohRwcojWiIQbBm1yil5v5H
	 4CasDQXBje2rDGVe1FuFfHeSfiPdx07Ao0GUmvW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfDFGHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 02:07:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42785 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfDFGHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 02:07:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id p6so4190789pgh.9;
        Fri, 05 Apr 2019 23:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=TJGyTmZcvGj3SJQPEQ9UUAlClEcIPymtak6Vu4TKLX8=;
        b=E9gdXYhPGvID6uslAwNHQP1n6CAeSGE4pqxtNLRjBm2h5erk+7uHjfVbcLrvGWsygi
         +JbgfEjpyzghxUWOHADTNpa+sGyOAKG6mnlfrF3BSQpc+WmJjVzDlk8ywyOCke6FgFJa
         34Bo8JKCjdSZshdE1SLaz1NmBnwBNK/A/GxyUav5W4MYmIUqkAG+uubxtJLEZjee9xUm
         OLaH11t9PYGf5ISgBrlkAeJQI20ti/qEXgXaA6tjM6IYrWss/UeYOIwhbADAWfhYCJXj
         cnOEPA1Q9ItOVMr4IQ0SGQhZP6U69dGNfR24QiEVFpZQS+q0EK2FjKp6mJplDZ/vT5rU
         rcUw==
X-Gm-Message-State: APjAAAVAleDeSiFro8RCGrHW5AzeLTYF6JeEKd6lDZOX5hThnjJr5eXo
        YyQVyrrm1Me4hJHZbiuak6a1Avkwtg==
X-Google-Smtp-Source: APXvYqy05XRQoTkZEqLEpVfMw9xG6U1UwV9mCt+vAnOij7ceAW6Ks1scvsB6+J0oE/JXa32udi4ecA==
X-Received: by 2002:a63:3fc2:: with SMTP id m185mr15706512pga.145.1554530836562;
        Fri, 05 Apr 2019 23:07:16 -0700 (PDT)
Received: from localhost ([210.160.217.71])
        by smtp.gmail.com with ESMTPSA id a72sm6708888pge.0.2019.04.05.23.07.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 23:07:16 -0700 (PDT)
Message-ID: <5ca84214.1c69fb81.e3ace.21e5@mx.google.com>
Date:   Sat, 06 Apr 2019 01:07:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: rtc: add battery-low-hw-alarm property
References: <1554303165-24813-1-git-send-email-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554303165-24813-1-git-send-email-f.suligoi@asem.it>
X-Mutt-References: <1554303165-24813-1-git-send-email-f.suligoi@asem.it>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 04:52:44PM +0200, Flavio Suligoi wrote:
> Some RTC devices have a battery-low automatic detection circuit.
> The battery-low event is usually reported with:
> 
> - a bit change in a RTC status register
> - a hw signaling (generally using an interrupt generation), changing
>   the hw level of a specific pin;
> 
> The new property "battery-low-hw-alarm" enable the RTC to generate the
> hw signaling in case of battery-low event.
> 
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> ---
>  Documentation/devicetree/bindings/rtc/rtc.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/rtc.txt b/Documentation/devicetree/bindings/rtc/rtc.txt
> index a97fc6a..f93a44d 100644
> --- a/Documentation/devicetree/bindings/rtc/rtc.txt
> +++ b/Documentation/devicetree/bindings/rtc/rtc.txt
> @@ -31,6 +31,9 @@ below.
>                              expressed in femto Farad (fF).
>                              The default value shall be listed (if optional),
>                              and likewise all valid values.
> +- battery-low-hw-alarm :    Enable the "battery-low" output pin. This function
> +                            is available on the following devices:
> +                            - pcf2127 - pin used for alarm: INTn

Boolean? If there's cases where which pin is selectable, then we'd need 
this to take a value. Not sure how likely that is?

Rob

