Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F58C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 17:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9EC021655
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 17:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="B0P2kt8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfLTRBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 12:01:23 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:40318 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbfLTRBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 12:01:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1576861280; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IyTUY4pfT+BIS+zxQOA53iQ3MvcXiNswuStlkl4h5ms=;
        b=B0P2kt8vK1OU7YP1ouJLUalZXVDRfFJJWEcw6L9ygaXSbNy5uHGDYbonK+kAK1IZoqhC1z
        kRM5BghsdIZR4banHIy2CEioEcMR19QArlLiQhN2Of/80P8RQbHpqGsauoXX+3cszpKlxH
        NZ1uB7vQkhxKYfj+7tbHUmbcTt4pTkg=
Date:   Fri, 20 Dec 2019 18:01:16 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [BUG] CI20: interrupt-controller@10001000 didn't like hwirq-0x0
 to VIRQ8 mapping (rc=-19)
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        MIPS Creator CI20 Development 
        <mips-creator-ci20-dev@googlegroups.com>,
        Marc Zyngier <maz@kernel.org>,
        Zhou Yanjie <zhouyanjie@zoho.com>
Message-Id: <1576861276.3.1@crapouillou.net>
In-Reply-To: <8BA39E30-53CB-47DB-8890-465ACB760402@goldelico.com>
References: <8BA39E30-53CB-47DB-8890-465ACB760402@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikolaus,

Try with this: https://lkml.org/lkml/2019/11/22/1831

And don't hesitate to add your Tested-by :)

Cheers,
-Paul


Le ven., d=E9c. 20, 2019 at 17:49, H. Nikolaus Schaller=20
<hns@goldelico.com> a =E9crit :
> Hi Paul,
> since v5.5-rc1 the boot log is flooded by a sequence of messages like:
>=20
> [    0.000000] NR_IRQS: 222
> [    0.000000] irq: :interrupt-controller@10001000 didn't like=20
> hwirq-0x0 to VIRQ8 mapping (rc=3D-19)
> [    0.000000] irq: :interrupt-controller@10001000 didn't like=20
> hwirq-0x1 to VIRQ9 mapping (rc=3D-19)
> [    0.000000] irq: :interrupt-controller@10001000 didn't like=20
> hwirq-0x2 to VIRQ10 mapping (rc=3D-19)
> [    0.000000] irq: :interrupt-controller@10001000 didn't like=20
> hwirq-0x3 to VIRQ11 mapping (rc=3D-19)
> [    0.000000] irq: :interrupt-controller@10001000 didn't like=20
> hwirq-0x4 to VIRQ12 mapping (rc=3D-19)
> ...
> [    0.000000] irq: :interrupt-controller@10001000 didn't like=20
> hwirq-0x3e to VIRQ70 mapping (rc=3D-19)
> [    0.000000] irq: :interrupt-controller@10001000 didn't like=20
> hwirq-0x3f to VIRQ71 mapping (rc=3D-19)
>=20
> A handful of /proc/interrupts are nevertheless working.
>=20
> I have now analyzed the situation a little:
>=20
> * the message is printed by irq_domain_associate()
> * call sequence is ingenic_intc_of_init() -> irq_domain_add_legacy()=20
> -> irq_domain_associate_many() -> irq_domain_associate()
> * the reason for the message is that
>   domain->ops->map()
>   called in irq_domain_associate() returns an error
> * domain->ops is initialized to &irq_generic_chip_ops
> * domain->ops->map is initialized to irq_map_generic_chip()
> * irq_map_generic_chip() calls __irq_get_domain_generic_chip()
> * which returns -ENODEV (-19) if d->gc =3D=3D NULL
>=20
> So the location, where the -19 comes from, is found.
>=20
> Now why is d->gc =3D=3D NULL in __irq_get_domain_generic_chip() ?
>=20
> This IMHO seems to be a bad initialization sequence:
>=20
> * ingenic_intc_of_init() calls firstly irq_domain_add_legacy()
> * which does *not* initialize domain->gc but expects it to be !NULL=20
> through irq_map_generic_chip()
> * and would only irq_alloc_domain_generic_chips() which initializes=20
> domain->gc if irq_domain_add_legacy() is successful
> * irq_alloc_domain_generic_chips() would initialize domain->gc by=20
> calling __irq_alloc_domain_generic_chips()
>=20
> There are indeed significant changes in drivers/irqchip/irq-ingenic.c
> from v5.4to v5.5-rc1 which have introduced the use of=20
> irq_domain_add_legacy()
> and irq_alloc_domain_generic_chips() by
>=20
> 52ecc87642f2 irqchip: ingenic: Error out if IRQ domain creation failed
> 208caadce5d4 irqchip: ingenic: Get virq number from IRQ domain
> 8bc7464b5140 irqchip: ingenic: Alloc generic chips from IRQ domain
> b8b0145f7d0e irqchip: Ingenic: Add process for more than one irq at=20
> the same time.
>=20
> Most likely 52ecc87642f2 has changed the call sequence and therefore=20
> always fails.
>=20
> Is there some essential patch missing to be upstreamed?
> I have looked but not found anything related in linux-next.
>=20
> I have also tried reverting 52ecc87642f2 alone but it has conflicts.
>=20
> But I can revert all 4 commits with an otherwise unchanged setup and
> the messages are gone for me.
>=20
> How would a fix look like?
>=20
> BR and thanks,
> Nikolaus
>=20

=

