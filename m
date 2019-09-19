Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CC1C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 03:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B205820815
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 03:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hardenedlinux.org header.i=@hardenedlinux.org header.b="eQupdZtb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731435AbfISDZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 23:25:01 -0400
Received: from mail1.protonmail.ch ([185.70.40.18]:33052 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbfISDZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 23:25:01 -0400
Date:   Thu, 19 Sep 2019 03:24:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hardenedlinux.org;
        s=protonmail; t=1568863498;
        bh=UGPlxdw/GA0C+GgCymCvb83hIycn10vrVkMuVgnbqls=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=eQupdZtbt6KaoPyu7zLqHFSOw/5smDSldJpuvRo2+051rY8TyCtLzGQrY7FNutC4e
         u6xjnBS5v9xDo5d3SbxvElYg5bQa4oeqMV3ohqbhezE/tYTCAgdl+XZN5tuZV8OUNo
         VZqe/467zvs8aT6lKehkXnyBSJHXO6Ia+aJPv4Pg=
To:     Palmer Dabbelt <palmer@sifive.com>
From:   Xiang Wang <merle@hardenedlinux.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "citypw@hardenedlinux.org" <citypw@hardenedlinux.org>
Reply-To: Xiang Wang <merle@hardenedlinux.org>
Subject: Re: arch/riscv: disable too many harts before pick main boot hart
Message-ID: <LQ8iC9RFpYZKFM9BGCpoHtnE3mzT-DqRwTKwJ_ngjvojyMAVvsVGaLscmiSopwR14QkhFejc7r9Qc8orGLN_H7lqo3yxAmcrYc5sZh9ZqXI=@hardenedlinux.org>
In-Reply-To: <mhng-0a85b4e9-be39-469c-9a50-4ee1310f6e8e@palmer-si-x1e>
References: <mhng-0a85b4e9-be39-469c-9a50-4ee1310f6e8e@palmer-si-x1e>
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
On 2019=E5=B9=B49=E6=9C=8814=E6=97=A5SaturdayAM3=E7=82=B904=E5=88=86, Palme=
r Dabbelt <palmer@sifive.com> wrote:

> On Thu, 05 Sep 2019 23:51:15 PDT (-0700), merle@hardenedlinux.org wrote:
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
> >
> > Signed-off-by: Xiang Wang merle@hardenedlinux.org
> >
> > --------------------------------------------------
> >
> > arch/riscv/kernel/head.S | 8 +++++---
> > 1 file changed, 5 insertions(+), 3 deletions(-)
> > diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> > index 0f1ba17e476f..cfffea38eb17 100644
> > --- a/arch/riscv/kernel/head.S
> > +++ b/arch/riscv/kernel/head.S
> > @@ -63,6 +63,11 @@ _start_kernel:
> > li t0, SR_FS
> > csrc sstatus, t0
> > +#ifdef CONFIG_SMP
> >
> > -   li t0, CONFIG_NR_CPUS
> > -   bgeu a0, t0, .Lsecondary_park
> >     +#endif
> >
> > -
> >
> > /* Pick one hart to run the main boot sequence */
> > la a3, hart_lottery
> > li a2, 1
> > @@ -154,9 +159,6 @@ relocate:
> > .Lsecondary_start:
> > #ifdef CONFIG_SMP
> >
> > -   li a1, CONFIG_NR_CPUS
> > -   bgeu a0, a1, .Lsecondary_park
> > -
> >
> > /* Set trap vector to spin forever to help debug */
> > la a3, .Lsecondary_park
> > csrw CSR_STVEC, a3
>
> It would be better to decouple the hart masks from NR_CPUS, as there's re=
ally
> no reason for these to be the same.

This may be new feature. Need to define new macros such as disabled_hart_ma=
sk,
this patch is used to fix bug and not add new feature.

>
> Reviewed-by: Palmer Dabbelt palmer@sifive.com


