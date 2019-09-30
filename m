Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F78C388F3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 08:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B4220679
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 08:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569831300;
	bh=cel9jAqvL3iaHblZk8ZTRrE2O+n7vZEusm2pERmpmC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QEvbwfzDgZJLLrXIV4mwVhcaLLB/OGo9bDNTECiFz7aKoOhFI3LJ0FR0jcjBjoKL5
	 bLGdX3KTvebDk6meu1/XFnJC0NaMOVpflZvoz85svWW2cA8ypaLtyTqhUq3t+omoXh
	 Hr/aVCwttPrzTQH5Mg1Zdl8114wypoGnlKhnbNuQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729970AbfI3IO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 04:14:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39313 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfI3IO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 04:14:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id r3so10120853wrj.6;
        Mon, 30 Sep 2019 01:14:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3CTmC1GsXW7IrK97J31Tmt/kV7wvmrOZDcAwkkYqHXE=;
        b=rKxBO4ANQyjrCebLxTCoUiINFwdhJyfZXJBgm5OYg2r+uPGFcyfOdZRCDRAQUVdEco
         kwdvCdz4DpN7UKSFyEVNJ6Bj9VIPgI4p8HNRLb2NEULOH3W+zW9TRmldDjAtsTBLqbKl
         trTYuv+qEJbG9MwV2nb7GZMcxGEbfY4i/n+EnMoFx5orTsJOyQhMfxhHaEPZACqXD3mq
         qzfm96/CyUKoCW3QTDeIt9iwha3LYV+Ls6j+LqW7YX5MzR8ZRCa6nkC1lVH8oYJ6iHuJ
         X6Uy1y9A/wbcR+8R4OILpWeQWsg0CqS1JHZmK4MVeiOdsqb8PuDgGXoQnmrhF2ZsjojC
         fYWA==
X-Gm-Message-State: APjAAAXXH5e0CUHf2Z/qAmIA6ZfUnKA/jopA5cIS9WjmMqlse8/hGzn4
        mevDmdNeT8VIxfGC4bTioC0=
X-Google-Smtp-Source: APXvYqyf7LPtms1O8Jjd41VwHzPvoRICODDhTRieA6rYEiMiQODMkzZphFr+TqX/l6nwc1iXKYA+Wg==
X-Received: by 2002:adf:ec44:: with SMTP id w4mr11667063wrn.251.1569831295653;
        Mon, 30 Sep 2019 01:14:55 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id x2sm15727586wrn.81.2019.09.30.01.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 01:14:54 -0700 (PDT)
Date:   Mon, 30 Sep 2019 10:14:52 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: Re: [PATCH v4 1/8] dt-bindings: timer: Convert Exynos MCT bindings
 to json-schema
Message-ID: <20190930081452.GB23709@pi3>
References: <20190923161411.9236-1-krzk@kernel.org>
 <20190927170701.GA27397@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190927170701.GA27397@bogus>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 12:07:01PM -0500, Rob Herring wrote:
> On Mon, Sep 23, 2019 at 06:14:04PM +0200, Krzysztof Kozlowski wrote:
> > Convert Samsung Exynos Soc Multi Core Timer bindings to DT schema format
> > using json-schema.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > 
> > ---
> > 
> > Changes since v3:
> > 1. Use interrupts-extended instead of interrupts-map.
> 
> This is a binding change. You should mention it in the commit.

The interrupts-map was never a part of binding. It was only mentioned in
the example to show how to route interrupts to different controllers.

The bindings are not changed. Only example.

> 
> > 
> > Changes since v1:
> > 1. Indent example with four spaces (more readable),
> > 2. Rename nodes in example to timer,
> > 3. Remove mct-map subnode.
> > ---
> >  .../bindings/timer/samsung,exynos4210-mct.txt |  88 ------------
> >  .../timer/samsung,exynos4210-mct.yaml         | 125 ++++++++++++++++++
> >  2 files changed, 125 insertions(+), 88 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.txt
> >  create mode 100644 Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.txt b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.txt
> > deleted file mode 100644
> > index 8f78640ad64c..000000000000
> > --- a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.txt
> > +++ /dev/null
> > @@ -1,88 +0,0 @@
> > -Samsung's Multi Core Timer (MCT)
> > -
> > -The Samsung's Multi Core Timer (MCT) module includes two main blocks, the
> > -global timer and CPU local timers. The global timer is a 64-bit free running
> > -up-counter and can generate 4 interrupts when the counter reaches one of the
> > -four preset counter values. The CPU local timers are 32-bit free running
> > -down-counters and generate an interrupt when the counter expires. There is
> > -one CPU local timer instantiated in MCT for every CPU in the system.
> > -
> > -Required properties:
> > -
> > -- compatible: should be "samsung,exynos4210-mct".
> > -  (a) "samsung,exynos4210-mct", for mct compatible with Exynos4210 mct.
> > -  (b) "samsung,exynos4412-mct", for mct compatible with Exynos4412 mct.
> > -
> > -- reg: base address of the mct controller and length of the address space
> > -  it occupies.
> > -
> > -- interrupts: the list of interrupts generated by the controller. The following
> > -  should be the order of the interrupts specified. The local timer interrupts
> > -  should be specified after the four global timer interrupts have been
> > -  specified.
> > -
> > -	0: Global Timer Interrupt 0
> > -	1: Global Timer Interrupt 1
> > -	2: Global Timer Interrupt 2
> > -	3: Global Timer Interrupt 3
> > -	4: Local Timer Interrupt 0
> > -	5: Local Timer Interrupt 1
> > -	6: ..
> > -	7: ..
> > -	i: Local Timer Interrupt n
> > -
> > -  For MCT block that uses a per-processor interrupt for local timers, such
> > -  as ones compatible with "samsung,exynos4412-mct", only one local timer
> > -  interrupt might be specified, meaning that all local timers use the same
> > -  per processor interrupt.
> > -
> > -Example 1: In this example, the IP contains two local timers, using separate
> > -	   interrupts, so two local timer interrupts have been specified,
> > -	   in addition to four global timer interrupts.
> > -
> > -	mct@10050000 {
> > -		compatible = "samsung,exynos4210-mct";
> > -		reg = <0x10050000 0x800>;
> > -		interrupts = <0 57 0>, <0 69 0>, <0 70 0>, <0 71 0>,
> > -			     <0 42 0>, <0 48 0>;
> > -	};
> > -
> > -Example 2: In this example, the timer interrupts are connected to two separate
> > -	   interrupt controllers. Hence, an interrupt-map is created to map
> > -	   the interrupts to the respective interrupt controllers.
> > -
> > -	mct@101c0000 {
> > -		compatible = "samsung,exynos4210-mct";
> > -		reg = <0x101C0000 0x800>;
> > -		interrupt-parent = <&mct_map>;
> > -		interrupts = <0>, <1>, <2>, <3>, <4>, <5>;
> > -
> > -		mct_map: mct-map {
> > -			#interrupt-cells = <1>;
> > -			#address-cells = <0>;
> > -			#size-cells = <0>;
> > -			interrupt-map = <0 &gic 0 57 0>,
> > -					<1 &gic 0 69 0>,
> > -					<2 &combiner 12 6>,
> > -					<3 &combiner 12 7>,
> > -					<4 &gic 0 42 0>,
> > -					<5 &gic 0 48 0>;
> > -		};
> > -	};
> > -
> > -Example 3: In this example, the IP contains four local timers, but using
> > -	   a per-processor interrupt to handle them. Either all the local
> > -	   timer interrupts can be specified, with the same interrupt specifier
> > -	   value or just the first one.
> > -
> > -	mct@10050000 {
> > -		compatible = "samsung,exynos4412-mct";
> > -		reg = <0x10050000 0x800>;
> > -
> > -		/* Both ways are possible in this case. Either: */
> > -		interrupts = <0 57 0>, <0 69 0>, <0 70 0>, <0 71 0>,
> > -			     <0 42 0>;
> > -		/* or: */
> > -		interrupts = <0 57 0>, <0 69 0>, <0 70 0>, <0 71 0>,
> > -			     <0 42 0>, <0 42 0>, <0 42 0>, <0 42 0>;
> > -	};
> > diff --git a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
> > new file mode 100644
> > index 000000000000..bff3f54a398f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
> > @@ -0,0 +1,125 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/timer/samsung,exynos4210-mct.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Samsung Exynos SoC Multi Core Timer (MCT)
> > +
> > +maintainers:
> > +  - Krzysztof Kozlowski <krzk@kernel.org>
> > +
> > +description: |+
> > +  The Samsung's Multi Core Timer (MCT) module includes two main blocks, the
> > +  global timer and CPU local timers. The global timer is a 64-bit free running
> > +  up-counter and can generate 4 interrupts when the counter reaches one of the
> > +  four preset counter values. The CPU local timers are 32-bit free running
> > +  down-counters and generate an interrupt when the counter expires. There is
> > +  one CPU local timer instantiated in MCT for every CPU in the system.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - samsung,exynos4210-mct
> > +      - samsung,exynos4412-mct
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    description: |
> > +      Interrupts should be put in specific order. This is, the local timer
> > +      interrupts should be specified after the four global timer interrupts
> > +      have been specified:
> > +      0: Global Timer Interrupt 0
> > +      1: Global Timer Interrupt 1
> > +      2: Global Timer Interrupt 2
> > +      3: Global Timer Interrupt 3
> > +      4: Local Timer Interrupt 0
> > +      5: Local Timer Interrupt 1
> > +      6: ..
> > +      7: ..
> > +      i: Local Timer Interrupt n
> > +      For MCT block that uses a per-processor interrupt for local timers, such
> > +      as ones compatible with "samsung,exynos4412-mct", only one local timer
> > +      interrupt might be specified, meaning that all local timers use the same
> > +      per processor interrupt.
> > +    minItems: 5               # 4 Global + 1 local
> > +    maxItems: 20              # 4 Global + 16 local
> > +
> > +  interrupts-extended:
> 
> No need for this. Just document 'interrupts' and the tooling takes care 
> of supporting 'interrupts-extended' too.

OK.

> 
> > +    description: |
> > +      If interrupts are coming from different controllers, this property
> > +      can be used instead of regular "interrupts" property.
> > +      The format is exactly the same as with "interrupts".
> > +      Interrupts should be put in specific order. This is, the local timer
> > +    minItems: 5               # 4 Global + 1 local
> > +    maxItems: 20              # 4 Global + 16 local
> > +
> > +required:
> > +  - compatible
> > +  - interrupts
> > +  - reg
> > +
> > +allOf:
> > +  - if:
> > +      not:
> > +        required:
> > +          - interrupts
> > +    then:
> > +      required:
> > +        - interrupts-extended
> 
> And this is taken care of too.

Sure, thanks!

Best regards,
Krzysztof

