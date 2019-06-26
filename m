Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E7DC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A128C2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XYNuR30T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfFZVB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 17:01:27 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38042 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFZVB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 17:01:27 -0400
Received: by mail-io1-f68.google.com with SMTP id j6so6519355ioa.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 14:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=PtByYI9t5DpYVWm2H7GeEhPtk58KGByxBL002Rq++Nc=;
        b=XYNuR30T2ykXXMBZUWk7+kaY55TQJBy/Rx9mq1LrtlauSuY+nyJZ26jGoCSpbkfuur
         nNIdMfn9ibJViTMYN5LUqvvZUJglVXOYUUDXonx8WoDIeudxDCHhzH5tyQ/hdxQ5pQNF
         PzPWNQwzkIZktsTcU2hxcG8Biu/fJiki6ZfsHcPy6ogs9EdGZzjWHKBPJmKXjcOTa3OM
         LoA8Lby6vONaglUTGTL77UUWdyI5+7+6Gb1fhg68jwo0Dkbqn3CeIMsIa8TKAp3qwlIj
         CWMYJ31J5Jda9fDtjvzcn5JFUyHgQpfWLf0xjinGpC5aRTw0W6tzIZ7CXiZI8Wx85Xm+
         jcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=PtByYI9t5DpYVWm2H7GeEhPtk58KGByxBL002Rq++Nc=;
        b=eLmJMNi1AtEteCHSj7+rCyWCYvKaUDAGV0jJhZ7iHyTWjsCq7AzaOMo050YeZzh+ug
         +JDcQKGYN3H2cNMOQFgI+EzVustXj7b8KsKLM60o4RLDZmdjvALnMOL2N4AuCF7l12sW
         WbWCsoDkxuY11deLMFKZfNxHxsolkWx8S5f4ZGPVLdzS0r7XKLwz/ffDmu3ep/YwnXKX
         g5teyjN4rJul8bRHbHUe/5TrbnP8LHhCKTMT+d3LsqWqwkNAoSG1nL13TzsI/B0dRIVo
         eLqfQUXCjJn4o21AuP7AwBSv3sSBT5MpckNXpzn9uoA142vfMairtEsqOLe0q8slovh9
         VEng==
X-Gm-Message-State: APjAAAUGCCXcpf26S4LlCPxdEAmn95bsejFAwShjApKTAQxuDHbhgEja
        6nlQeGovaNS5kCQj2ErHnZEw7w==
X-Google-Smtp-Source: APXvYqyaC/Rknevvr0RNsSk494GNIwNMoZEzEKFydW08aOjnIS+l9ESG3JKcMXLHukEsIAy5/kV9Ng==
X-Received: by 2002:a5d:87c6:: with SMTP id q6mr223932ios.115.1561582886347;
        Wed, 26 Jun 2019 14:01:26 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id d17sm206248iom.28.2019.06.26.14.01.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 14:01:25 -0700 (PDT)
Date:   Wed, 26 Jun 2019 14:01:23 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Rob Herring <robh@kernel.org>
cc:     linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: riscv: resolve 'make dt_binding_check'
 warnings
In-Reply-To: <alpine.DEB.2.21.9999.1906261325290.23534@viisi.sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1906261358440.23534@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1906260829030.21507@viisi.sifive.com> <CAL_JsqJs6MtvmuyAknsUxQymbmoV=G+=JfS1PQj9kNHV7fjC9g@mail.gmail.com> <alpine.DEB.2.21.9999.1906261325290.23534@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jun 2019, Paul Walmsley wrote:

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

If it helps, this patch is simply to fix the dtc warnings that you 
mentioned in your post on devicetree-spec@.  Without this patch, with 
"make dtbs_check", the following warnings are generated:

  DTC     Documentation/devicetree/bindings/riscv/cpus.example.dtb
Documentation/devicetree/bindings/riscv/cpus.example.dts:75.25-35: Warning (reg_format): /example-1/cpus/cpu@0:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/riscv/cpus.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/riscv/cpus.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/riscv/cpus.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/riscv/cpus.example.dts:73.23-84.19: Warning (avoid_default_addr_size): /example-1/cpus/cpu@0: Relying on default #address-cells value
Documentation/devicetree/bindings/riscv/cpus.example.dts:73.23-84.19: Warning (avoid_default_addr_size): /example-1/cpus/cpu@0: Relying on default #size-cells value

When the patch is applied, dtc doesn't report any of these warnings.

Let me know if I'm missing something obvious.


- Paul
