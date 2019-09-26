Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9782C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A43217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569489664;
	bh=Y+SD64wkghYn0I0R/39NddGVoN1hJwFHnuCmOeAxM/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EhZHiD0I8oe0EvB3lI+zN8FsZ1AE65RewhLNmH0WSNCFjVWF/PFm4XfQROIY4tIVV
	 D6Geuxwi+beCPXR9j8dY2J6amkwFHOiHjQzLtA0jF+ydQ3xi+RAOjVU2iWN0/ENCZ4
	 W1h6tPJi+LKZVnQC2KzvI+vTnMnn45fHgqCMs8C8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbfIZJVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 05:21:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44387 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbfIZJVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:21:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id i18so1535880wru.11;
        Thu, 26 Sep 2019 02:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0yFgoWaDFqXC6Q4Iw65F2epQQ4rqVPkyo8j0S3UI0fw=;
        b=iZKq2gtg9D6Ng1+95TUUzwfh38flkeUM3gq0EmFmIwd8a54Nb7oKSOhUkV1ZNzUut1
         XmSOMrtZFynQw8yg4bSZQoLTks0BAoCP2B6yMCase1Wh4/7vvpbS6j8N5Gkx2tOyELi/
         779QPE2A14nPwhFWHh/5YAIF4lPeNwAOCk1M1v42QoSCbCFXSMjQBytPpPNSl+kjBbpg
         DucxXs9CR1G4YoVuKT0kIBJOrNy2jouaY0Hz9eYYatkSXCnPTKftcOMhSShEfdxJp8nZ
         HeYIW8ECXB0Y+qLLiiyYbpQI5OnCSxvg94KhutgWX3d6SIZvYrUVnpabZRzARFGauz0z
         FTaQ==
X-Gm-Message-State: APjAAAXd9/3gsvDRe8Cxjo+NJe9MeynJaP2dXTIm18qrBAbULnwAB+EN
        8llMOf6eiieuRZPU3He0Hq8=
X-Google-Smtp-Source: APXvYqxXI3Jvln6ixBkRS1hL3oyOLtrK3tUaJhrXOIGErzBhakNRh0Xi682urKxf2Nm4Kl/qlmBfYQ==
X-Received: by 2002:a5d:4646:: with SMTP id j6mr1975308wrs.173.1569489658421;
        Thu, 26 Sep 2019 02:20:58 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id d28sm2678651wrb.95.2019.09.26.02.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 02:20:57 -0700 (PDT)
Date:   Thu, 26 Sep 2019 11:20:55 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: Re: [PATCH v4 1/8] dt-bindings: timer: Convert Exynos MCT bindings
 to json-schema
Message-ID: <20190926092055.GA15552@pi3>
References: <CGME20190923161449epcas3p4bf25ddc76d4893a93b9472c3a286f410@epcas3p4.samsung.com>
 <20190923161411.9236-1-krzk@kernel.org>
 <aa4acd33-eff3-175f-b86a-459ba8c1d17c@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aa4acd33-eff3-175f-b86a-459ba8c1d17c@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 03:40:52PM +0200, Marek Szyprowski wrote:
> Hi Krzysztof,
> 
> On 23.09.2019 18:14, Krzysztof Kozlowski wrote:
> > Convert Samsung Exynos Soc Multi Core Timer bindings to DT schema format
> > using json-schema.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > ---
> >
> > Changes since v3:
> > 1. Use interrupts-extended instead of interrupts-map.
> >
> > Changes since v1:
> > 1. Indent example with four spaces (more readable),
> > 2. Rename nodes in example to timer,
> > 3. Remove mct-map subnode.
> > ---
> >   .../bindings/timer/samsung,exynos4210-mct.txt |  88 ------------
> >   .../timer/samsung,exynos4210-mct.yaml         | 125 ++++++++++++++++++
> >   2 files changed, 125 insertions(+), 88 deletions(-)
> >   delete mode 100644 Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.txt
> >   create mode 100644 Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
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
> > +
> > +examples:
> > +  - |
> > +    // In this example, the IP contains two local timers, using separate
> > +    // interrupts, so two local timer interrupts have been specified,
> > +    // in addition to four global timer interrupts.
> > +
> > +    timer@10050000 {
> > +        compatible = "samsung,exynos4210-mct";
> > +        reg = <0x10050000 0x800>;
> > +        interrupts = <0 57 0>, <0 69 0>, <0 70 0>, <0 71 0>,
> > +                     <0 42 0>, <0 48 0>;
> > +    };
> > +
> > +  - |
> > +    // In this example, the timer interrupts are connected to two separate
> > +    // interrupt controllers. Hence, an interrupts-extended is needed.
> > +
> > +    timer@101c0000 {
> > +        compatible = "samsung,exynos4210-mct";
> > +        reg = <0x101C0000 0x800>;
> > +        interrupts-extended = <&gic 0 57 0>,
> > +                              <&gic 0 69 0>,
> > +                              <&combiner 12 6>,
> > +                              <&combiner 12 7>,
> > +                              <&gic 0 42 0>,
> > +                              <&gic 0 48 0>;
> > +    };
> > +
> > +  - |
> > +    // In this example, the IP contains four local timers, but using
> > +    // a per-processor interrupt to handle them. Only one first local
> > +    // interrupt is specified.
> > +
> > +    timer@10050000 {
> > +        compatible = "samsung,exynos4412-mct";
> > +        reg = <0x10050000 0x800>;
> > +
> > +        interrupts = <0 57 0>, <0 69 0>, <0 70 0>, <0 71 0>,
> > +                     <0 42 0>;
> > +    };
> > +
> > +  - |
> > +    // In this example, the IP contains four local timers, but using
> > +    // a per-processor interrupt to handle them. All the local timer
> > +    // interrupts are specified.
> > +
> > +    timer@10050000 {
> > +        compatible = "samsung,exynos4412-mct";
> > +        reg = <0x10050000 0x800>;
> > +
> > +        interrupts = <0 57 0>, <0 69 0>, <0 70 0>, <0 71 0>,
> > +                     <0 42 0>, <0 42 0>, <0 42 0>, <0 42 0>;
> > +    };
> I would add "#include <dt-bindings/interrupt-controller/arm-gic.h>" and
> replace zeros with proper defines like GIC_SPI and GIC_PPI. The last two
> examples describes per-processor-interrupts, but have 0 in the specifier
> cell 0. I would also use proper IRQ_TYPE_LEVEL_HIGH at cell 3 instead
> of 0. I would also consider adding artificial 'interrupt-parent = &git'
> property to the 1st, 3rd and 4th examples to make it clear that they
> refer to ARM GIC bindings.

Makes sense, but how about doing this in separate patch? The example code
was like this amd this just converts the bindings so I think it is better
to reduce the amount of feature-like improvements.

Best regards,
Krzysztof

