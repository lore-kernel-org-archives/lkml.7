Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6B8C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA46E21907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hardenedlinux.org header.i=@hardenedlinux.org header.b="h9Meoilm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731984AbfISKa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 06:30:27 -0400
Received: from mail4.protonmail.ch ([185.70.40.27]:44985 "EHLO
        mail4.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbfISKa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 06:30:26 -0400
Date:   Thu, 19 Sep 2019 10:30:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hardenedlinux.org;
        s=protonmail; t=1568889022;
        bh=hiwcVYVyjA8rIAfDxqCw5jAP15PD6IpvcY7gJcQeLRw=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=h9MeoilmyiThRpXXIznQvZEu05WaaRsTkYkmbaIdTzRfg6CPLp0LSSTgss8sfSrBa
         5JWkj7nP9SSQ/glRfXBu05XhnIf2bXK0RZSLFwPw6FlAHdKEOzuroZqhsZ6RzeQGnB
         Scy381WsKNTdZ18VxQT57InOO0JU2PdCrt5wOq3M=
To:     Paul Walmsley <paul.walmsley@sifive.com>
From:   Xiang Wang <merle@hardenedlinux.org>
Cc:     "palmer@sifive.com" <palmer@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "citypw@hardenedlinux.org" <citypw@hardenedlinux.org>
Reply-To: Xiang Wang <merle@hardenedlinux.org>
Subject: Re: [PATCH] arch/riscv: disable too many harts before pick main boot hart
Message-ID: <oZnw_aigjzhp0LNTjqSVEPWA6nBsFhV4z0KJXsCw9oPg3pGRju1n3kzDin_GH06vl8Jn5MU5keS2LE1FLrPfR3V66b9hkoqKQJ7CZ_tMqUk=@hardenedlinux.org>
In-Reply-To: <alpine.DEB.2.21.9999.1909190324250.10826@viisi.sifive.com>
References: <AMJe39pHTcb4gsI-_Dv-wmR8_x9EbCCN9LKI47j34_8vBKRqzFxPrjmZvBtwV5OU_HcOiRkKUG66xVaNQ8VAXw7Ws0CCK74gpA8pKaYN5wM=@hardenedlinux.org>
 <alpine.DEB.2.21.9999.1909190324250.10826@viisi.sifive.com>
Feedback-ID: BRRa7Rf7LqOlikZR00e5gSr_IsihWq0drDTak4NnawY-ONQTW87vpTHz90bkJTl_rn8r4L6gc-nP1pm37CQtxw==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org






=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On 2019=E5=B9=B49=E6=9C=8819=E6=97=A5ThursdayPM6=E7=82=B925=E5=88=86, Paul =
Walmsley <paul.walmsley@sifive.com> wrote:

> On Fri, 6 Sep 2019, Xiang Wang wrote:
>
> > From 12300865d1103618c9d4c375f7d7fbe601b6618c Mon Sep 17 00:00:00 2001
> > From: Xiang Wang merle@hardenedlinux.org
> > Date: Fri, 6 Sep 2019 11:56:09 +0800
> > Subject: [PATCH] arch/riscv: disable too many harts before pick main bo=
ot hart
> > These harts with id greater than or equal to CONFIG_NR_CPUS need to be =
disabled.
> > But pick the main Hart can choose any one. So, before pick the main har=
t, you
> > need to disable the hart with id greater than or equal to CONFIG_NR_CPU=
S.
> > Signed-off-by: Xiang Wang merle@hardenedlinux.org
>
> Thanks, here's what I'm planning to queue for v5.4-rc1. Please let me
> know ASAP if you want to change the patch description.
>
> -   Paul

Not need to change

>
>     From: Xiang Wang merle@hardenedlinux.org
>
>
> Date: Fri, 6 Sep 2019 11:56:09 +0800
> Subject: [PATCH] arch/riscv: disable excess harts before picking main boo=
t hart
>
> Harts with id greater than or equal to CONFIG_NR_CPUS need to be
> disabled. But the kernel can pick any hart as the main hart. So,
> before picking the main hart, the kernel must disable harts with ids
> greater than or equal to CONFIG_NR_CPUS.
>
> Signed-off-by: Xiang Wang merle@hardenedlinux.org
> Reviewed-by: Palmer Dabbelt palmer@sifive.com
> [paul.walmsley@sifive.com: updated to apply; cleaned up patch
> description]
> Signed-off-by: Paul Walmsley paul.walmsley@sifive.com
>
> arch/riscv/kernel/head.S | 8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 15a9189f91ad..72f89b7590dd 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -63,6 +63,11 @@ _start_kernel:
> li t0, SR_FS
> csrc CSR_SSTATUS, t0
>
> +#ifdef CONFIG_SMP
>
> -   li t0, CONFIG_NR_CPUS
> -   bgeu a0, t0, .Lsecondary_park
>     +#endif
>
> -   /* Pick one hart to run the main boot sequence */
>     la a3, hart_lottery
>     li a2, 1
>     @@ -154,9 +159,6 @@ relocate:
>
>     .Lsecondary_start:
>     #ifdef CONFIG_SMP
>
>
> -   li a1, CONFIG_NR_CPUS
> -   bgeu a0, a1, .Lsecondary_park
> -   /* Set trap vector to spin forever to help debug */
>     la a3, .Lsecondary_park
>     csrw CSR_STVEC, a3
>     --
>     2.23.0
>


