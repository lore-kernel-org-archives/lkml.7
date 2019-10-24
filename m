Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6989AC47E49
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 03:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EFA521655
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 03:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="np4oLXeE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437287AbfJXDpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 23:45:13 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36478 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392947AbfJXDpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 23:45:12 -0400
Received: by mail-io1-f65.google.com with SMTP id c16so7865293ioc.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 20:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mD92XtRViE3fuwX27/t4J88Vliq5/m5DxH+E0QdDcfY=;
        b=np4oLXeE8XD06z6WLNxROOXayg/7ADY4dvhHQRnY2EXH3D4wrZ4uvVBzCLMBAl1YKs
         X3kjp8uzPDq4VFJgPdRFGu+FIl4wDfiqtU7w6PZp+88i4oloYYBmdlOIiElf/8JWsI1Z
         Asi6bKnndFHWV2XnQ7GtzdTCxFqXBosXW6SW7BTP4mM/aa8KaGla/jn36tffYO0Wt5WZ
         v07XyDQEpncMj1ATg9d8591dV5+amUkJ8XZE3wwTs15BAh2IP3CMjZNWG3jRNsPU2znN
         nUG3QgiKea3A6gmmbuQUPKoqxBCEyOdOKc4JWkScnPgEO4NAoOElT2mBNY1hnetWB3TF
         uPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mD92XtRViE3fuwX27/t4J88Vliq5/m5DxH+E0QdDcfY=;
        b=uODv6eqvs1rOozSekyVWCSK6+WZfgiLMyN7n4Fw5Gkk2snjfUE5uVWco+1voYrmmLI
         l7K91Fc6eGUFXekGjCkjzs4ENOyffjC2xGjebaSKIvfZhDqzBwcuv8mzV7YqA8kP9fe2
         lZR8RyPDQ7vt8BKC6nuQRXdTWkoTa1P8wwRuwu3zN9jpAVA1obMgtXyM5z8Kg0F0NuEy
         CMZ/SswrTQXa3TWYykgtbszrZkidDgkSaOOeEmIWhD1bVne5V7uriqq68UHJchGmyZfc
         pEguuWdrDPj2B0OF45OEHJ+pQ0Gkc3XzeSMpT82xbOAhBpd3KfOMxEZEl9/+PSGrfJNj
         n8HA==
X-Gm-Message-State: APjAAAVdnEurQHU56QLKIrBfshI4oojKK2XxHkxhdu+NIBPStoQXFGAR
        uP+qkTBl1kEFc8Z77V1Z9qNjIJBouSXcDJaqL2ur/g==
X-Google-Smtp-Source: APXvYqwrUjk8l2F1yVqbPWkm0wkJV8sufdaMmeDVQTVHJSKP7u8y4ic/BWRmmzodfowZBBFsGH12nFuVxyoZKg2IkUo=
X-Received: by 2002:a5d:87ce:: with SMTP id q14mr985334ios.278.1571888711746;
 Wed, 23 Oct 2019 20:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20191023192205.97024-1-olof@lixom.net> <20191024023704.GA3152@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20191024023704.GA3152@redsun51.ssa.fujisawa.hgst.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Wed, 23 Oct 2019 20:45:00 -0700
Message-ID: <CAOesGMjXc1ezF+sC+Nc+VoXScE8kSzy1ZG_iBUBgs5RS4M0y2g@mail.gmail.com>
Subject: Re: [PATCH] PCI/DPC: Add pcie_ports=dpc-native parameter to bring
 back old behavior
To:     Keith Busch <kbusch@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 7:37 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Wed, Oct 23, 2019 at 12:22:05PM -0700, Olof Johansson wrote:
> > In commit eed85ff4c0da7 ("PCI/DPC: Enable DPC only if AER is available"),
> > the behavior was changed such that native (kernel) handling of DPC
> > got tied to whether the kernel also handled AER. While this is what
> > the standard recommends, there are BIOSes out there that lack the DPC
> > handling since it was never required in the past.
> >
> > To make DPC still work on said platforms the same way they did before,
> > add a "pcie_ports=dpc-native" kernel parameter that can be passed in
> > if needed, while keeping defaults unchanged.
>
> If platform firmware wants to handle AER events, but the kernel enables
> the DPC capability, the ports will be trapping events that firmware is
> expecting to handle. Not that that's a bad thing: firmware is generally
> worse at handling these errors.

Right, and in particular (and what I'm looking for here): It brings
back the older behavior that some platforms rely on. :-/

> > +/*
> > + * If the user specified "pcie_ports=dpc-native", use the PCIe services
> > + * for DPC, but cuse platform defaults for the others.
>
> s/cuse/use

Thanks

> > @@ -1534,9 +1534,11 @@ static inline int pci_irqd_intx_xlate(struct irq_domain *d,
> >  #ifdef CONFIG_PCIEPORTBUS
> >  extern bool pcie_ports_disabled;
> >  extern bool pcie_ports_native;
> > +extern bool pcie_ports_dpc_native;
> >  #else
> >  #define pcie_ports_disabled  true
> >  #define pcie_ports_native    false
> > +#define pcie_ports_dpc_native        false
> >  #endif
>
> You do not have any references to pcie_ports_dpc_native outside of files that
> require CONFIG_PCIEPORTBUS, so no need to define a default.

If these are the only comments, maybe Bjorn can fixup when applying.
Bjorn; let me know if you prefer that or if you want a fresh version.
Either is fine with me.


-Olof
