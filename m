Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C261DC3A5A5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 14:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC702087E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 14:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567435861;
	bh=71pLWk8MdR2BOEmIJHJ2tEkCtIxRrDQMnHh6cQ1w+II=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dyaTRmxyJsgpQo3UkyaUy7bwsT5iW9EHnR6HLLrkylduoebSu5OruSx6Z7EZWIljZ
	 /ek1lyxhkUUMIHI+lPnuICefDJltnFZCjb4mpk+/Vqn14F+b2+7SO2BxFmCkIqhJSa
	 7QKYXSaJ8bIo5Ismp5FmhxGdAMzNvfYbfWXe7gUQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731698AbfIBOvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 10:51:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbfIBOvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 10:51:00 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B09021897;
        Mon,  2 Sep 2019 14:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567435859;
        bh=71pLWk8MdR2BOEmIJHJ2tEkCtIxRrDQMnHh6cQ1w+II=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IgOfV4zJAO/gl7avGfHCcrRz75Z2bQ1g9P9ui20ZUBezasAoKLWDdlsReZA7CMq/w
         JKIIGcOPRcKEYYq/ICfGNHIZPsixxf1hEekeWvtMzGzUemhrvZ1K0XpBhzVE426Q+d
         X8H4Zfu+NGjbrqNPqJY8dlFGlZGlmLWjoqoH6xpc=
Received: by mail-qk1-f171.google.com with SMTP id 4so12705744qki.6;
        Mon, 02 Sep 2019 07:50:59 -0700 (PDT)
X-Gm-Message-State: APjAAAUc/mdsB9gLx+F8ByRjesmkL+KhXHXOa0nJUFpCxCdaWXBRyj8F
        kWMa0vFCHDpQiWqlOT8nY28RYo0//RznoO8S2g==
X-Google-Smtp-Source: APXvYqyh28Ow2UJPekS8IlWnjRcGuFquE4h1Btq6Udon+B5ixZMsP3odA9iep7SfJTniUSqfAkbwkbi3IhdjZEq0KtU=
X-Received: by 2002:a37:8905:: with SMTP id l5mr29175066qkd.152.1567435858286;
 Mon, 02 Sep 2019 07:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190827085302.5197-1-jiaxun.yang@flygoat.com>
 <20190827085302.5197-12-jiaxun.yang@flygoat.com> <CAL_JsqL6htVye-LSBWw1WwRy9xH=zwuH6gurscwoCWj9Te_hAg@mail.gmail.com>
 <d94eff2b-76ec-5cd2-512d-5ee0406a1bb9@flygoat.com> <20190827204105.7nyt4pi7lvxse5ij@pburton-laptop>
In-Reply-To: <20190827204105.7nyt4pi7lvxse5ij@pburton-laptop>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 2 Sep 2019 15:50:47 +0100
X-Gmail-Original-Message-ID: <CAL_Jsq+VmFi6r1-WOa9RJ4vfqsZLqcn5HMbv1oyQjhtJ8Qd8Lw@mail.gmail.com>
Message-ID: <CAL_Jsq+VmFi6r1-WOa9RJ4vfqsZLqcn5HMbv1oyQjhtJ8Qd8Lw@mail.gmail.com>
Subject: Re: [PATCH 11/13] dt-bindings: mips: Add loongson cpus & boards
To:     Paul Burton <paul.burton@mips.com>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.co>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 9:41 PM Paul Burton <paul.burton@mips.com> wrote:
>
> Hi guys,
>
> On Tue, Aug 27, 2019 at 10:18:46PM +0800, Jiaxun Yang wrote:
> > On 2019/8/27 =E4=B8=8B=E5=8D=888:45, Rob Herring wrote:
> > > On Tue, Aug 27, 2019 at 3:55 AM Jiaxun Yang <jiaxun.yang@flygoat.com>=
 wrote:
> > > > diff --git a/Documentation/devicetree/bindings/mips/loongson/cpus.y=
aml b/Documentation/devicetree/bindings/mips/loongson/cpus.yaml
> > > > new file mode 100644
> > > > index 000000000000..410d896a0078
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/mips/loongson/cpus.yaml
> > > > @@ -0,0 +1,38 @@
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > Dual license for new bindings please:
> > >
> > > (GPL-2.0-only OR BSD-2-Clause)
> > >
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/mips/loongson/cpus.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Loongson CPUs bindings
> > > > +
> > > > +maintainers:
> > > > +  - Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > > +
> > > > +description: |+
> > > > +  The device tree allows to describe the layout of CPUs in a syste=
m through
> > > > +  the "cpus" node, which in turn contains a number of subnodes (ie=
 "cpu")
> > > > +  defining properties for every cpu.
> > > > +
> > > > +  Bindings for CPU nodes follow the Devicetree Specification, avai=
lable from:
> > > > +
> > > > +  https://www.devicetree.org/specifications/
> > > > +
> > > > +properties:
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +    description: |
> > > > +      Physical ID of a CPU, Can be read from CP0 EBase.CPUNum.
> > > Is this definition specific to Loongson CPUs or all MIPS?
> >
> > Currently it's specific to Loongson CPU only, as other processors may u=
sing
> > different method to express CPU map.
> >
> > Different from Arm, MIPS family of processors seems less uniform and ha=
ve
> > their own designs.
> >
> > For this point, we'd better ask Paul's opinion.
>
> In general on MIPS we detect CPU properties at runtime from coprocessor
> 0 registers & similar sources of information, so there's not really a
> need to specify anything about the CPU in devicetree.

We thought the same thing initially for Arm... Mostly what is in DT is
not what is discoverable. Are clock speeds, power domains, low power
states, etc. all discoverable?

> For example here
> you say yourself that the value for this property can be read from
> EBase.CPUNum - so why specify it in DT?

To map DT nodes to cores?

Rob
