Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D1BC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 20:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EBF22085A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 20:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OXD8lcND"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfFZU1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 16:27:54 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45560 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFZU1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 16:27:54 -0400
Received: by mail-io1-f68.google.com with SMTP id e3so7918513ioc.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 13:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=LgZeRxC6RQ5LdUYNQeMc+ciFdAiQ/Cfk+AzdfLEuWwo=;
        b=OXD8lcNDuVCQF0Os+37dJnhbEhLTPkAGYKnH2K/rTQrBwx0dYPUkpleQC7RAMj5qH6
         6Dvz4/TPGz9pp5LOtdWnDvwImdz3fv9wNsqK+8NfJ+K1Okp0MVweKvPjncv+11qG35Dm
         BXRbMdJxBUt/hIHhj1grg3+gaw7k29crfND37pkXQU0IPETEtomREiM2IA+VVYv4VWFY
         APcbKHDu2R72a9mxEZbn/0tUBP2BL9dZ2R0eHgDCK6tO7Ib6/eHON231w1wYainB/xg9
         xE/LV3MMhKT7qxgfmFSLdVrbWz6A98kF5ZXDqnlZdKlO7+iVTJh3VnjWjnr9hGWe39Fd
         8YNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=LgZeRxC6RQ5LdUYNQeMc+ciFdAiQ/Cfk+AzdfLEuWwo=;
        b=aISd5M+z7di2le7RV09Z+GvJsPFyrF8nBWsTm6BrgcG6vE/12pRxQC4F3uQ3U2644/
         wQU2oUXOdxm/tmgxsJTnQ8ZV44rwO5DbXCdCGrJ0L0ma8jNQPPOBzIFh9l2mndGMil8L
         sSwdWkZ5A9Ipt8z2vAzjeJvR4JUZCuvuB3k9aTSDpBrIPq0Hje7uxs1WILH7qo6vJgH9
         QeVQEgIV3P+6jAayB0llYB3Qisyfx+UIQ6tZSw6eUj8SHtHjaBgljffMsHjOuBFHlKnp
         6qlu3wht9iio/2ZharA16j3iqr2IHb3piNbaeRCWcTxiAox1tbYEx0+7UbAugSy1Kd9b
         dcaw==
X-Gm-Message-State: APjAAAU/9rL6z7ZszyCoGIo1274i1f/DXgy3N+SY7cjoFRpP/Vdiyndu
        srjbl53mweGg3H78JCY49apdEibh4jM=
X-Google-Smtp-Source: APXvYqwBABOk5P1lcHFrctT0fUSSr2Hv6vbQhbqcJSD5Q+1tQOnna356evEV+6djyREOBX4lf3JYkg==
X-Received: by 2002:a02:ce92:: with SMTP id y18mr7192147jaq.40.1561580873575;
        Wed, 26 Jun 2019 13:27:53 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id h19sm16188iol.65.2019.06.26.13.27.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 13:27:52 -0700 (PDT)
Date:   Wed, 26 Jun 2019 13:27:51 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Rob Herring <robh@kernel.org>
cc:     linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: riscv: resolve 'make dt_binding_check'
 warnings
In-Reply-To: <CAL_JsqJs6MtvmuyAknsUxQymbmoV=G+=JfS1PQj9kNHV7fjC9g@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1906261325290.23534@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1906260829030.21507@viisi.sifive.com> <CAL_JsqJs6MtvmuyAknsUxQymbmoV=G+=JfS1PQj9kNHV7fjC9g@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jun 2019, Rob Herring wrote:

> On Wed, Jun 26, 2019 at 9:30 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
> >
> > Rob pointed out that one of the examples in the RISC-V 'cpus' YAML schema
> > results in warnings from 'make dt_binding_check'.  Fix these.
> >
> > While here, make the whitespace in the second example consistent with the
> > first example.
> >
> > Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> > Cc: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/riscv/cpus.yaml       | 26 ++++++++++---------
> >  1 file changed, 14 insertions(+), 12 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > index 27f02ec4bb45..f97a4ecd7b91 100644
> > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > @@ -152,17 +152,19 @@ examples:
> >    - |
> >      // Example 2: Spike ISA Simulator with 1 Hart
> >      cpus {
> > -            cpu@0 {
> > -                    device_type = "cpu";
> > -                    reg = <0>;
> > -                    compatible = "riscv";
> > -                    riscv,isa = "rv64imafdc";
> > -                    mmu-type = "riscv,sv48";
> > -                    interrupt-controller {
> > -                            #interrupt-cells = <1>;
> > -                            interrupt-controller;
> > -                            compatible = "riscv,cpu-intc";
> > -                    };
> > -            };
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        cpu@0 {
> 
> This only works because you removed 'cpus' and therefore none of this
> schema is applied.

I'm not following you - could you point out where "cpus" was removed?

> > +                device_type = "cpu";
> > +                reg = <0>;
> > +                compatible = "riscv";
> 
> According to the schema, this is wrong. It should have 2 strings. Or
> the schema needs to allow this case, but 'riscv' is too vague to be
> very useful.

OK, I'll come up with something for Spike.

> Also, I noticed that there's still a riscv/cpus.txt. That should be
> removed and replaced with this file. Looks like the hart description
> at least should be copied over (into top-level 'description').

OK, will do that when I hear back from you.  


- Paul
