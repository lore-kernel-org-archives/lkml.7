Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CD8C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA03521911
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563986064;
	bh=y3wbn5DZyk5ePvAGBeCifCShVGEBIaWPBwKrtZ9mcAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uQREKyrOywfnAANcX3SHZaFmkkOb8AL5RKiap3BBdGpq23BrLSXjzI45UvQK+/w5y
	 J5Vr+aIKX09ZcUr67Qg04q3olBTsjtk+gjBixvGxA+Ius7LUf7vBhsYekXuLX4e+y2
	 k9+Tu5zC2r5GzZZdg2ARi4YFXMBgrUF3loPULsKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387453AbfGXQeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 12:34:23 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42581 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfGXQeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:34:21 -0400
Received: by mail-io1-f66.google.com with SMTP id e20so60547492iob.9;
        Wed, 24 Jul 2019 09:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/PlH4vZ2Uin7/bl42iN+WjnHNv+woMCrYa8NnQ7gWTo=;
        b=aHuZkcNuMGMHD5BigUYhgH0LoZx3tXMinOI0MDXWoUEVQS+3MsFvrST9rSLnUfSZzY
         T15zbPoE0y4Z+DGcmGikEyDxSGiD/dscrBWBm/YgV2unlICq/TRvgjOvO7pqOaovF9Du
         Fbp/rWiQRwz6/cbo/CcFiNfVP3usTNDZZcCvXZQjT5ibFrpW0k2JFqQKlN+wICrlJlWN
         h7eTwcNMzZypO0UPU8jqMQqGu61Cvwj+t1jr3X5rT6cHstZHv2vGRCNRKdpFNn7cR0wx
         TUwpcgMV8zjXcCKVQIP8C722Um3+8xGTlAIw+RT1Hp/nrx2qgbB9qeST/u1MTCMADdWy
         EhXg==
X-Gm-Message-State: APjAAAXzpVc/m6ne/IGjLgg7aw2VTWdapv7x+DqBpgh4P4zXVYCd/7Oy
        QxtMTs6SaApJTSgkEJC7ug==
X-Google-Smtp-Source: APXvYqzjl58aQwxUq65IuKOZ/HpEXrjN4r3zsKMfMya48Uu06RIYqPgzl9UQEH9sk+bryVsjmlT/zg==
X-Received: by 2002:a02:29ce:: with SMTP id p197mr24690823jap.139.1563986060805;
        Wed, 24 Jul 2019 09:34:20 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id l2sm33217795ioh.20.2019.07.24.09.34.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 09:34:19 -0700 (PDT)
Date:   Wed, 24 Jul 2019 10:34:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Tony Lindgren <tony@atomide.com>,
        "Andrew F. Davis" <afd@ti.com>, Roger Quadros <rogerq@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        David Lechner <david@lechnology.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 1/6] dt-bindings: irqchip: Add PRUSS interrupt controller
 bindings
Message-ID: <20190724163419.GA29254@bogus>
References: <20190708035243.12170-1-s-anna@ti.com>
 <20190708035243.12170-2-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708035243.12170-2-s-anna@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jul 2019 22:52:38 -0500, Suman Anna wrote:
> The Programmable Real-Time Unit Subsystem (PRUSS) contains an interrupt
> controller (INTC) that can handle various system input events and post
> interrupts back to the device-level initiators. The INTC can support
> upto 64 input events on most SoCs with individual control configuration
> and hardware prioritization. These events are mapped onto 10 interrupt
> lines through two levels of many-to-one mapping support. Different
> interrupt lines are routed to the individual PRU cores or to the
> host CPU or to other PRUSS instances.
> 
> The K3 AM65x and J721E SoCs have the next generation of the PRU-ICSS IP,
> commonly called ICSSG. The ICSSG interrupt controller on K3 SoCs provide
> a higher number of host interrupts (20 vs 10) and can handle an increased
> number of input events (160 vs 64) from various SoC interrupt sources.
> 
> Add the bindings document for these interrupt controllers on all the
> applicable SoCs. It covers the OMAP architecture SoCs - AM33xx, AM437x
> and AM57xx; the Keystone 2 architecture based 66AK2G SoC; the Davinci
> architecture based OMAPL138 SoCs, and the K3 architecture based AM65x
> and J721E SoCs.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
> Prior version: https://patchwork.kernel.org/patch/10795771/
> 
>  .../interrupt-controller/ti,pruss-intc.txt    | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
