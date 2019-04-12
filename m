Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDCDC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61672077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHSF+9qb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfDLR0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 13:26:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45509 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfDLR0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 13:26:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so12900793wra.12;
        Fri, 12 Apr 2019 10:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IaX4DrQC50xBwGIy19YSAHtht7WFQHr5XGkMNLVbnxw=;
        b=PHSF+9qbuJlG7pQ7n6smF6TKaG7R4OmLBQHjbLkZT78cOmzjSl1gSc3OYl1V15D66T
         LQ6Wph/qdfiVbJdB7+QuYpLvEymFaXJqI62KITSP3TMbRxUsQuv7qWvj5nE69zMfa5Vw
         alH4a+GwHXSqCC+KTcXY9fd3TVoHAlPoqc55DNE5zyBq11Nce8T2Ia0iDjfOdbGB++58
         VLjNHmE6zQQ/uTCCd/6OFzarYEvAAnHGORceopvzn2Pjg3Ip5jk/wNVCGmErcPoohUqJ
         31mIFO8D5FZT4eheY3uuy0s1c2gBF1ZSJxh3+jxM8j6RbOe3/jafVIn4Hz4YZ3Q5jjqx
         5eFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IaX4DrQC50xBwGIy19YSAHtht7WFQHr5XGkMNLVbnxw=;
        b=Jf1QX56vBsxb1lbwsoDrknUIYOdATEVQJrmibojR2QNrm/Xmgr1URqcDVJkBZ2he2c
         uUfUcEjA8efHCua1tZ5x7ZpkBw4LGogvbMDmO2xRuXRyBg6WZUHxk/buHM6WWvt2uvf0
         Kqi/PP1Lkfc/cNRyxRi9463hNUaeR63CY1nsR9K7MAKcVmeiBjtt7EoqZ3BHYAkAlwSg
         WUnXlJx5sw24wQteGrg+wiM+3MLWMbYuBYOkuNB5RSU+1EkF5u7oHH623x/jLuzwVfs5
         UcGOH6AYIFid8RlyTJq5omesOSyoLC1W/YBZspZ7K/rUYM4RM1kEvRKH7SCDJkSG9zkj
         8ioA==
X-Gm-Message-State: APjAAAXti/Dirwt2xrMXJDsK8xqCuI7l6gH7afDrblQ5S/nbkNSbHxUD
        ybvBZaJo11pL8mnDDzG2wXU=
X-Google-Smtp-Source: APXvYqwcP++26W+mXXlHXnaT1m0Y60yIqV2W0RwOBjkdqnSgG4YYCkNsgHHoqsan/ZqGvzLDjgytTA==
X-Received: by 2002:a05:6000:1286:: with SMTP id f6mr3779545wrx.93.1555089997803;
        Fri, 12 Apr 2019 10:26:37 -0700 (PDT)
Received: from macpro-scc.lancs.ac.uk (inc028000049.lancs.ac.uk. [148.88.224.78])
        by smtp.gmail.com with ESMTPSA id d7sm10838959wmf.31.2019.04.12.10.26.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 10:26:37 -0700 (PDT)
Date:   Fri, 12 Apr 2019 18:26:36 +0100
From:   Willy Wolff <willy.mh.wolff.ml@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: about cci400 pmu
Message-ID: <20190412172635.5xkfoz3wkucb2jqo@macpro-scc.lancs.ac.uk>
References: <20190412160153.edbbe7mrwm7xsewa@macpro-scc.lancs.ac.uk>
 <d03136bc-1a05-0df0-f91e-46fbac269d4a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d03136bc-1a05-0df0-f91e-46fbac269d4a@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many thanks, it seems to work.

Regards,
Willy

On Fri, Apr 12, 2019 at 05:12:59PM +0100, Robin Murphy wrote:
> On 12/04/2019 17:01, Willy Wolff wrote:
> > Hi,
> > 
> > I'm trying to add pmu support for CCI400 on an Odroid-XU3/4.
> > Following https://www.kernel.org/doc/Documentation/devicetree/bindings/arm/cci.txt,
> > and other dtsi, I end up with this patch:
> > 
> > diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> > index f4e8c5823bc2..8432f01fb463 100644
> > --- a/arch/arm/boot/dts/exynos5420.dtsi
> > +++ b/arch/arm/boot/dts/exynos5420.dtsi
> > @@ -170,6 +170,16 @@
> >                                  interface-type = "ace";
> >                                  reg = <0x5000 0x1000>;
> >                          };
> > +
> > +                       pmu@9000 {
> > +                               compatible = "arm,cci-400-pmu,r0";
> > +                               reg = <0x9000 0x5000>;
> > +                               interrupts = <0 105 4>,
> > +                                            <0 101 4>,
> > +                                            <0 102 4>,
> > +                                            <0 103 4>,
> > +                                            <0 104 4>;
> > +                       };
> >                  };
> >                  clock: clock-controller@10010000 {
> > 		
> > Saddly, I got:
> > [    5.375913] ARM-CCI PMU 10d20000.cci:pmu@9000: invalid resource
> 
> That message looks to come from devm_ioremap_resource(), which implies that
> platform_get_resource() is returning NULL in cci_pmu_probe(). Looking at the
> DT, you have a thing at offset 0x9000 under a parent "ranges" which is only
> 0x6000 long, so I'd guess the OF platform layer probably gave up on creating
> the resources when it couldn't translate the address.
> 
> Robin.
> 
> > [    5.389595] ARM-CCI PMU: probe of 10d20000.cci:pmu@9000 failed with error -12
> > 
> > By pluging some printk here and there in arm-cci.c in init and probe functions,
> > all return 0. I assume that the driver initialisation is succesful.
> > 
> > I trace a bit more in really_probe function, however, I can't find the real
> > cause of this error.
> > 
> > $ dmesg | grep cci
> > [    0.070299] drivers/bus/arm-cci.c:569:cci_init()
> > [    0.071484] drivers/bus/arm-cci.c:580:cci_init() cci_init_status = 0
> > [    0.071610] drivers/bus/arm-cci.c:595:cci_probed() cci_init_status = 0
> > [    0.113575] drivers/bus/arm-cci.c:569:cci_init()
> > [    0.113684] drivers/bus/arm-cci.c:572:cci_init() cci_init_status = 0
> > [    0.770287] drivers/bus/arm-cci.c:94:cci_platform_init() 0
> > [    0.811655] drivers/base/dd.c:516:really_probe() ARM-CCI 10d20000.cci try probe drv = c1058908, drv->probe = c0593498, dev = e8b2f010
> > [    0.811788] drivers/bus/arm-cci.c:72:cci_platform_probe()
> > [    0.811866] drivers/bus/arm-cci.c:569:cci_init()
> > [    0.811937] drivers/bus/arm-cci.c:572:cci_init() cci_init_status = 0
> > [    0.812023] drivers/bus/arm-cci.c:595:cci_probed() cci_init_status = 0
> > [    0.814718] drivers/bus/arm-cci.c:79:cci_platform_probe() 0
> > [    6.738502] drivers/base/dd.c:516:really_probe() ARM-CCI PMU 10d20000.cci:pmu@9000 try probe drv = c10859f4, drv->probe = c0593498, dev = e8b2fc10
> > [    6.747909] ARM-CCI PMU 10d20000.cci:pmu@9000: invalid resource
> > [    6.753711] drivers/base/dd.c:522:really_probe() ARM-CCI PMU 10d20000.cci:pmu@9000 fail probe
> > [    6.762416] drivers/base/dd.c:561:really_probe() ARM-CCI PMU 10d20000.cci:pmu@9000 probe_failed
> > [    6.770940] ARM-CCI PMU: probe of 10d20000.cci:pmu@9000 failed with error -12
> > 
> > I don't know if the provided values for dtsi is correct either.
> > 
> > I would be very happy to have some help to make these pmu working.
> > Many thanks in advance.
> > 
> > Best Regards,
> > Willy
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 
