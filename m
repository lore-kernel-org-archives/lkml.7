Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA95FC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 20:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F2F21835
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 20:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="EuCNcLZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731003AbfJHUgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 16:36:24 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36633 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730832AbfJHUgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 16:36:24 -0400
Received: by mail-io1-f68.google.com with SMTP id b136so39546415iof.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 13:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=8OWcoGS3BEEoyWgrBo7bn7YYjPQqdrXR3vAw8gPm390=;
        b=EuCNcLZVNf49hDvCPEgJMlmxJKp6smESQklkNVCOknnb3tENPXH9DS2w2K6gUPaD9p
         mxOpyyAZ5mCYKmDxd6VdYLB4IFs962l+pZaSzoDSReYOXxT4vGkjjYvR5d/dfOdCrbcA
         PISeEiH+FfU7yJSOO9NgNqCV3rdSNXCW9aBXyGLAwfb/gHS+LfHDwOxxA4Dvw7ELV58L
         PIBBH+NOOSwq0FQ6LVfO+QdFvli5+QaXowwSSBNxCwrUJ3ssW7u9Tx++WWogJ0noAeeG
         d6E5GsIWbfSA/ALTqgEOdvj+RG0a/5q5RQdR0mn3/l6sLMYPIyWoYoBjVGsierSY4FYs
         jibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=8OWcoGS3BEEoyWgrBo7bn7YYjPQqdrXR3vAw8gPm390=;
        b=YZnFZPo8YtylsMa1ZpQlUBHdm6pFoV3pXVSy3XA1PjQGD/pn9H9x7Q8zwuGbMK4Y4Q
         KAw+mWzW3ASyqIknCgAOlZaGCdlta3H1lik8NgbeQtB2alQ9CihskqiN6yMfJ2v2YSyr
         iwh33BWSJ1wg1keKrEBDsDm4gCkPnY1Yjpq870qVHXNpvf1HDWBZcU9iiDYShAFYySKI
         zz9R6Z58ykX9g0rzc1qLqhviOGRNIufrr038z3iDYbJ2zRkbSwzFN0gY0/CGqe8AW4dl
         lST1hJssXhx30ngQO8nhf8sC8Vm+Evo7W0/Yi5TJVCwaRrcGofZW5kXqTPx7Kux0L2lT
         caaw==
X-Gm-Message-State: APjAAAUVK0WETPVNZ63AWGx9TbPwUqeELkTUYN+bHzKgpQzkpupH8smp
        Y56ZCEDGtR9+EjWtMVBZT8RBlA==
X-Google-Smtp-Source: APXvYqwBqjyeU3Cg2keKhMlMOaj+hMyVHG3lx22lajI0kyUD1bGOC51pzjYdIC3h69pazyBEnAbR2Q==
X-Received: by 2002:a92:d7ce:: with SMTP id g14mr23019363ilq.269.1570566982399;
        Tue, 08 Oct 2019 13:36:22 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id m9sm39438ion.65.2019.10.08.13.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 13:36:21 -0700 (PDT)
Date:   Tue, 8 Oct 2019 13:36:20 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Rob Herring <robh@kernel.org>
cc:     Palmer Dabbelt <palmer@sifive.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: riscv: Fix CPU schema errors
In-Reply-To: <CAL_JsqJH59Hh6SkQyyAGkK21dR5DJxzja8GPYd3mg+kEVQ-0EQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1910081329160.11044@viisi.sifive.com>
References: <20190925131252.19359-1-robh@kernel.org> <mhng-c69fa4ff-9752-4ded-8a4f-ae86113bd9ae@palmer-si-x1e> <CAL_JsqJH59Hh6SkQyyAGkK21dR5DJxzja8GPYd3mg+kEVQ-0EQ@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2019, Rob Herring wrote:

> On Wed, Sep 25, 2019 at 4:24 PM Palmer Dabbelt <palmer@sifive.com> wrote:
> >
> > On Wed, 25 Sep 2019 06:12:52 PDT (-0700), robh@kernel.org wrote:
> > > Fix the errors in the RiscV CPU DT schema:
> > >
> > > Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml: cpu@0: 'timebase-frequency' is a required property
> > > Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml: cpu@1: 'timebase-frequency' is a required property
> > > Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml: cpu@0: compatible:0: 'riscv' is not one of ['sifive,rocket0', 'sifive,e5', 'sifive,e51', 'sifive,u54-mc', 'sifive,u54', 'sifive,u5']
> > > Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml: cpu@0: compatible: ['riscv'] is too short
> > > Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml: cpu@0: 'timebase-frequency' is a required property
> > >
> > > Fixes: 4fd669a8c487 ("dt-bindings: riscv: convert cpu binding to json-schema")
> > > Cc: Paul Walmsley <paul.walmsley@sifive.com>
> > > Cc: Palmer Dabbelt <palmer@sifive.com>
> > > Cc: Albert Ou <aou@eecs.berkeley.edu>
> > > Cc: linux-riscv@lists.infradead.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > > v2:
> > >  - Add timebase-frequency to simulator example.
> > >
> > >  .../devicetree/bindings/riscv/cpus.yaml       | 26 ++++++++++---------
> > >  1 file changed, 14 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > index b261a3015f84..eb0ef19829b6 100644
> > > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > @@ -24,15 +24,17 @@ description: |
> > >
> > >  properties:
> > >    compatible:
> > > -    items:
> > > -      - enum:
> > > -          - sifive,rocket0
> > > -          - sifive,e5
> > > -          - sifive,e51
> > > -          - sifive,u54-mc
> > > -          - sifive,u54
> > > -          - sifive,u5
> > > -      - const: riscv
> > > +    oneOf:
> > > +      - items:
> > > +          - enum:
> > > +              - sifive,rocket0
> > > +              - sifive,e5
> > > +              - sifive,e51
> > > +              - sifive,u54-mc
> > > +              - sifive,u54
> > > +              - sifive,u5
> > > +          - const: riscv
> > > +      - const: riscv    # Simulator only
> > >      description:
> > >        Identifies that the hart uses the RISC-V instruction set
> > >        and identifies the type of the hart.

The above part of this patch looks fine to me, and please consider that 
portion of this patch acked.

> > > @@ -67,8 +69,6 @@ properties:
> > >        lowercase to simplify parsing.
> > >
> > >    timebase-frequency:
> > > -    type: integer
> > > -    minimum: 1
> > >      description:
> > >        Specifies the clock frequency of the system timer in Hz.
> > >        This value is common to all harts on a single system image.
> > > @@ -102,9 +102,9 @@ examples:
> > >      cpus {
> > >          #address-cells = <1>;
> > >          #size-cells = <0>;
> > > -        timebase-frequency = <1000000>;
> > >          cpu@0 {
> > >                  clock-frequency = <0>;
> > > +                timebase-frequency = <1000000>;
> > >                  compatible = "sifive,rocket0", "riscv";
> > >                  device_type = "cpu";
> > >                  i-cache-block-size = <64>;
> > > @@ -120,6 +120,7 @@ examples:
> > >          };
> > >          cpu@1 {
> > >                  clock-frequency = <0>;
> > > +                timebase-frequency = <1000000>;
> > >                  compatible = "sifive,rocket0", "riscv";
> > >                  d-cache-block-size = <64>;
> > >                  d-cache-sets = <64>;
> > > @@ -153,6 +154,7 @@ examples:
> > >                  device_type = "cpu";
> > >                  reg = <0>;
> > >                  compatible = "riscv";
> > > +                timebase-frequency = <1000000>;
> > >                  riscv,isa = "rv64imafdc";
> > >                  mmu-type = "riscv,sv48";
> > >                  interrupt-controller {
> >
> > Looking at this spec
> >
> >     https://github.com/devicetree-org/devicetree-specification/releases/download/v0.2/devicetree-specification-v0.2.pdf
> >
> > section 3.7 says
> >
> >     Properties that have identical values across cpu nodes may be placed in the
> >     /cpus node instead. A client program must
> >     first examine a specific cpu node, but if an expected property is not found
> >     then it should look at the parent /cpus node.
> >     This results in a less verbose representation of properties which are
> >     identical across all CPUs.
> 
> The cpu sections of the spec are certainly not perfect. They are
> largely from PPC with only the most obviously things wrong fixed...

[ ... ]

> > I just bring this up because we've got an outstanding
> > bug in our port where we're not respecting what section 3.7 says and are only
> > looking at /cpus/timebase-frequency instead of /cpus/cpu@*/timebase-frequency,
> > and I'm wondering if the fix should allow for looking at
> > /cpus/timebase-frequency or just not bother.
> 
> It's perfectly fine for some deviation for each arch or being more
> restrictive. For Arm, we've generally gone the direction of everything
> goes into the cpu nodes. So tell me what you want, I just need the
> warnings gone.

We probably should keep the timebase-frequency at the /cpus level, since 
that's how the current public silicon behaves, and that's how our kernel 
code currently works.  Do you want to patch the schemas for that, or would 
you like us to?


- Paul
