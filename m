Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562A1C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2183921726
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561583598;
	bh=7SVWpkHfE1YSV+N/YHXLrqpwi2xY8ZGPFSN0/F5f1z8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cQcC3qEyj+8xdS6I54cmFPZTh6YRtoOQDN0u7xk0PwzKdEMrRejEv8WWvmEVFMeZF
	 o0Dmsnxz4td88z35WuwRh7iGxJ4O9KI30mMOBZfotbTfNNRAeC62Ops7jG2RHdy3Wk
	 B4JLz8It+1do/o93rXrmSWkTcOHPW4v7iR0O7k74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfFZVNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 17:13:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbfFZVNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 17:13:16 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14D15204EC
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 21:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561583595;
        bh=7SVWpkHfE1YSV+N/YHXLrqpwi2xY8ZGPFSN0/F5f1z8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P6KTBhC+F/EO0xRie2KzrytWpnbthLtNnNcA1O1CHoYOufReynLjrbUKH8tP/IJyf
         YkW2CU0ajlyohcTpRA4LAs/gR5EYFi0dDz3ERe7xEn2XYFO8OcKNGTsbThatT6r7iW
         kTu0yyk/dFkfOHidfUTo/tsM122g0lW4nM1Jrk44=
Received: by mail-qt1-f180.google.com with SMTP id i34so164198qta.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 14:13:15 -0700 (PDT)
X-Gm-Message-State: APjAAAX93oiTG/2faBwYmH8txcsN9fYoiDwNfS93CVLAPsbRhshBGTcy
        T8+NI/N8q+r8AsqcVmtwf8Q/MpX2JVP1q8nsYw==
X-Google-Smtp-Source: APXvYqwnbzOwxsMo5plFFHnNkc3/fBWExNYMCSeiPhxlbzm/rEHvIW7+gT0AVvZYTT1kJJVR0/T5TqwLnDTpuk+biqg=
X-Received: by 2002:ac8:36b9:: with SMTP id a54mr15141qtc.300.1561583594362;
 Wed, 26 Jun 2019 14:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.9999.1906260829030.21507@viisi.sifive.com>
 <CAL_JsqJs6MtvmuyAknsUxQymbmoV=G+=JfS1PQj9kNHV7fjC9g@mail.gmail.com> <alpine.DEB.2.21.9999.1906261325290.23534@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1906261325290.23534@viisi.sifive.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 26 Jun 2019 15:13:03 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+r08p7ZSt=2XMfR5eZna26wKvG6j-7aBa2Cxbbg6hCHw@mail.gmail.com>
Message-ID: <CAL_Jsq+r08p7ZSt=2XMfR5eZna26wKvG6j-7aBa2Cxbbg6hCHw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: riscv: resolve 'make dt_binding_check' warnings
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 2:27 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> On Wed, 26 Jun 2019, Rob Herring wrote:
>
> > On Wed, Jun 26, 2019 at 9:30 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
> > >
> > > Rob pointed out that one of the examples in the RISC-V 'cpus' YAML schema
> > > results in warnings from 'make dt_binding_check'.  Fix these.
> > >
> > > While here, make the whitespace in the second example consistent with the
> > > first example.
> > >
> > > Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> > > Cc: Rob Herring <robh@kernel.org>
> > > ---
> > >  .../devicetree/bindings/riscv/cpus.yaml       | 26 ++++++++++---------
> > >  1 file changed, 14 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > index 27f02ec4bb45..f97a4ecd7b91 100644
> > > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > @@ -152,17 +152,19 @@ examples:
> > >    - |
> > >      // Example 2: Spike ISA Simulator with 1 Hart
> > >      cpus {
> > > -            cpu@0 {
> > > -                    device_type = "cpu";
> > > -                    reg = <0>;
> > > -                    compatible = "riscv";
> > > -                    riscv,isa = "rv64imafdc";
> > > -                    mmu-type = "riscv,sv48";
> > > -                    interrupt-controller {
> > > -                            #interrupt-cells = <1>;
> > > -                            interrupt-controller;
> > > -                            compatible = "riscv,cpu-intc";
> > > -                    };
> > > -            };
> > > +        #address-cells = <1>;
> > > +        #size-cells = <0>;
> > > +        cpu@0 {
> >
> > This only works because you removed 'cpus' and therefore none of this
> > schema is applied.
>
> I'm not following you - could you point out where "cpus" was removed?

Sorry, I guess the indentation change threw me off...

For fixing the dtc warnings:

Reviewed-by: Rob Herring <robh@kernel.org>
