Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63234C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C8220692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578502697;
	bh=8kstCzcaZmd+YgRdW1aDqr4GzCRDQW1ZYslQh7akxw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=So8BYa8k8UZQM9/ZQgTYHNBG6XQW91obtFGVHsxCZrjChttP2KGN8dp5jjVodRrhZ
	 uZYj+VbpqEnVvA9gVT8jbWSYXNNjVMi1kad0ZEJG0AHQkOCKHdDSJ6C1C1YUk2fu3N
	 TbWMoNXChopgsWTERBEzSSqukM9K6/Eru7PUSktg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbgAHQ6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:58:16 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37700 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbgAHQ6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:58:16 -0500
Received: by mail-ot1-f67.google.com with SMTP id k14so4248573otn.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 08:58:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AWmgSsfRzvwSL0sYtWV5JPk31n0xrdke8dXDCuRYCJA=;
        b=uWlE7gy4CH18x6SCMg6jagFdvbiaXIMkv91FtLpv8u6l4hsrAsxiZLxOxHMzl1Xaz/
         A16vMNyfcn6atphMFbNRiGLgM5UubsIL4AjM8dB9xD0cSLLNWtL5r/HnJ3m1hWhNATjt
         3UKUXNA9U0iib07w2o8miA1tKHglPtzy9KgorcWPSYutzY2xgDWUz36ZMexkUj4BvlDq
         OOMLTx0K8ZoXufKvneDcUgrsWPrH5P7Df+jwoPgyW2jMARILkkZAGFIpMM4lJwgl2bq7
         z04lcEjiL9D5khugxGwf7Tzr3oGEc9uA0+tRIN5uCbQXi5ANr/x8BdyfWIjy5jinKfha
         eQfg==
X-Gm-Message-State: APjAAAUGi/VAVqFr0X73YNELfZYU5egCa8NdNXcZneJfriQwIPvvT386
        2PJ0EhFGR9VwrTKRrj6XvsadU0Y=
X-Google-Smtp-Source: APXvYqx6wMwdoUYu4Ab0xUHiVPoA5kBQ4AH7ZjJaV0Lj2N7SGBjPjE6q+efAPVcMqEtKmtCekQZSlg==
X-Received: by 2002:a9d:7e8c:: with SMTP id m12mr5102251otp.346.1578502695237;
        Wed, 08 Jan 2020 08:58:15 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y6sm1266023oti.44.2020.01.08.08.58.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 08:58:14 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220333
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 08 Jan 2020 10:58:13 -0600
Date:   Wed, 8 Jan 2020 10:58:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     jic23@kernel.org, mark.rutland@arm.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, rpi-receiver@htl-steyr.ac.at,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: devantech-srf04.yaml: add pm feature
Message-ID: <20200108165813.GA4472@bogus>
References: <20200102172749.v7ufupd32ytf7jda@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102172749.v7ufupd32ytf7jda@arbad>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 06:27:51PM +0100, Andreas Klinger wrote:
> Add GPIO line and startup time for usage of power management
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  .../bindings/iio/proximity/devantech-srf04.yaml          | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml b/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
> index 4e80ea7c1475..b3fcb3b79485 100644
> --- a/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
> +++ b/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
> @@ -51,6 +51,22 @@ properties:
>        the time between two interrupts is measured in the driver.
>      maxItems: 1
>  
> +  power-gpios:
> +    description:
> +      Definition of the GPIO for power management of connected peripheral
> +      (output).
> +      This GPIO can be used by the external hardware for power management.
> +      When the device gets suspended it's switched off and when it resumes
> +      it's switched on again. After some period of inactivity the driver
> +      get suspended automatically (autosuspend feature).
> +    maxItems: 1
> +
> +  startup-time-ms:

Why isn't this implied by the compatible string? 

> +    $ref: /schemas/types.yaml#/definitions/uint32

You can drop this for standard units. 

0-2^32 is valid?

> +    description:
> +      This is the startup time the device needs after a resume to be up and
> +      running.
> +
>  required:
>    - compatible
>    - trig-gpios
> -- 
> 2.11.0
