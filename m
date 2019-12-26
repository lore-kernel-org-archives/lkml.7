Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C896FC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 03:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99CC92082E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 03:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="Mv43Q3iB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfLZDSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 22:18:17 -0500
Received: from mail-bn8nam11on2044.outbound.protection.outlook.com ([40.107.236.44]:29281
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726885AbfLZDSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 22:18:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQPNTIIcwrjUaOPdrE2BfxtAuZzKXdhzPqn77NGBBtgBkPN2e4ymLK/GVlYv5YBphng/ugtC3JCFY9OdIp3WSjPGCXxQGSjXP3wnXfyl8uONy5pbdbsQ5kzgPknJr55sDIpaO66pjgUXgjzZ6eB/6VbuevbhdUgMLwatDtv3bfTs0w8JnzWPAjN6JouQsKcUui2IAqF398GZQC4NJhvLreO1p2CYbSipcvtf/G7e8OyzSaRp3Gu0LY3FLEjd4mN59ADKasPPRzcBjz0tGjiss0bl5KOLQJpLx92U/JaFevfN98a8SAEi8yiE6upawNFjeyz+DvnLoJ+/J3xg3UDTKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41GzMveCbnJN4pBTNEyOCJEhHABKAuhSI2NB3yEBtuc=;
 b=FYBzPyxhYP/06ezfv/suOCbdytZ90BK4hb9GzCc7LEW/NlFTbwVOplq0ftgFllb5NJzFotTKdS/3Y+HmNWgo0UxSsCHoPP4BIS6gmWOOCxA1m29F2Y077nQZMW44z2C13CB1B0POLnh4qpp8mf45vm1YejCX4p1NCrRIl3jrXyq/mdlpNt4s466gqqaW3ZCBn+yY1ei489ZeB3BzGiKfYSpG+O2x98gNw0K/2tLSHphyfK/JGGesvg47Z9jqwoZ3nnZbiHeYZncxMYCKPRCSt0+iDYHTL8dKre2rXmpkBa1OxFtMSzxi0zwvxrxzQG0kZlRG4fl++jXP+ad7HCtvUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41GzMveCbnJN4pBTNEyOCJEhHABKAuhSI2NB3yEBtuc=;
 b=Mv43Q3iByiZFy/GwX29twDfZUWqLaDAeaBMQdQENjGTvFqHiiwJkXYvG/6iQFRXFDK22zl9+PNuGNgBhzcs4oNSo/Sv1xmX46+QpEvFWVA/103muZmUGaBhYNjeTk7JIjy3gKSYq95BSPLcWH/EG4UTg3YYsTL9zj+OeElvvEM0=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.93.213) by
 BYAPR03MB4758.namprd03.prod.outlook.com (20.179.92.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Thu, 26 Dec 2019 03:18:08 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::708d:91cc:79a7:9b9a]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::708d:91cc:79a7:9b9a%6]) with mapi id 15.20.2559.017; Thu, 26 Dec 2019
 03:18:07 +0000
Received: from xhacker.debian (124.74.246.114) by TYCPR01CA0089.jpnprd01.prod.outlook.com (2603:1096:405:3::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend Transport; Thu, 26 Dec 2019 03:18:04 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v7 3/3] arm64: implement KPROBES_ON_FTRACE
Thread-Topic: [PATCH v7 3/3] arm64: implement KPROBES_ON_FTRACE
Thread-Index: AQHVuwfioeAAP6kOPkCZLC/0/SnpxKfLukGAgAAB3gA=
Date:   Thu, 26 Dec 2019 03:18:07 +0000
Message-ID: <20191226110348.146bb80b@xhacker.debian>
References: <20191225172625.69811b3e@xhacker.debian>
        <20191225173001.6c0e3fb2@xhacker.debian>
        <20191226115707.902545688aa90b34e2e550b3@kernel.org>
In-Reply-To: <20191226115707.902545688aa90b34e2e550b3@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYCPR01CA0089.jpnprd01.prod.outlook.com
 (2603:1096:405:3::29) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:139::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8ec9b3e-3c38-4f78-6bdb-08d789b23a69
x-ms-traffictypediagnostic: BYAPR03MB4758:
x-microsoft-antispam-prvs: <BYAPR03MB47584281F32F1509DAFF8BC4ED2B0@BYAPR03MB4758.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02638D901B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(366004)(396003)(39850400004)(51874003)(199004)(189003)(8936002)(5660300002)(966005)(55016002)(9686003)(1076003)(81156014)(81166006)(8676002)(4326008)(956004)(52116002)(7696005)(7416002)(316002)(6506007)(71200400001)(2906002)(66446008)(478600001)(16526019)(6916009)(186003)(26005)(86362001)(64756008)(66556008)(66946007)(54906003)(66476007)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4758;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fuZkC8JfghRseQxhoIJLG3EVa4em0h30W2gK7bE6nkZlP4VfXMY+Cpxx9RmobRry9OaVECpxpIOBhjknh86ce0C+O2kOPWIfJOybrHkTZjXgak9plU2WeZfYNNHjeOaWFSypq/o/xNBpi3B2/vZ/vk9UFkYtkhllJVBZUqU6o5W0jGiSVh2TZ72mq4BAPaeuV7CYbP9Ibinm565RJeA5eh731UMisQFZaVyprFlVIICBYu/tRnTwfEAssjRl1STpf5ci8EVAjACYa8rExo8NJrq4BH25g+7X1m1M5JIPY/fd9YAb05NYs0mrprjou7ZCicWIkw7DBJCUWwzupcFE8LiowfC42usJrx8lHZOkFKWhK0pI2MVdlhpjo+PjsBXxqeZDnDTrskDqYoRiYM2hXm/xMbcgu4rzZ4oTBHrHrjlS7YWhbHe1kJHG37ReYHaDoG9piKdhYEWOQP+921kEuyNxZFLw44JwFLVK7n6DNo5xbgnVgLYy17wV6+bTuap2lAu0/o2lQCUZiJM4OLro663aCXqO24TZe1KgWuYAcK0Mq2Khlymc001Yoh3dkwAb
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D6F215F2B7A82B4D8E64C459CF7F3381@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ec9b3e-3c38-4f78-6bdb-08d789b23a69
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2019 03:18:07.5934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ifc9/7e66cPt4UW4JQWcgk4fSaHWHNcXDlsp/91SOEn1QbDZQXW30kLCmDlYGGpUctNt5FIxW4vbbqZwUfd3tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4758
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Thu, 26 Dec 2019 11:57:07 +0900 Masami Hiramatsu wrote:

>=20
> Hi Jisheng,
>=20
> On Wed, 25 Dec 2019 09:44:21 +0000
> Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
>=20
> > KPROBES_ON_FTRACE avoids much of the overhead with regular kprobes as i=
t
> > eliminates the need for a trap, as well as the need to emulate or
> > single-step instructions.
> >
> > Tested on berlin arm64 platform.
> >
> > ~ # mount -t debugfs debugfs /sys/kernel/debug/
> > ~ # cd /sys/kernel/debug/
> > /sys/kernel/debug # echo 'p _do_fork' > tracing/kprobe_events
> >
> > before the patch:
> >
> > /sys/kernel/debug # cat kprobes/list
> > ffffff801009fe28  k  _do_fork+0x0    [DISABLED]
> >
> > after the patch:
> >
> > /sys/kernel/debug # cat kprobes/list
> > ffffff801009ff54  k  _do_fork+0x0    [DISABLED][FTRACE] =20
>=20
> What happens if user puts a probe on _do_fork+4?
> Is that return -EILSEQ correctly?

_do_fork+4 can be probed successfully.

>=20
> >
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >  .../debug/kprobes-on-ftrace/arch-support.txt  |  2 +-
> >  arch/arm64/Kconfig                            |  1 +
> >  arch/arm64/include/asm/ftrace.h               |  1 +
> >  arch/arm64/kernel/probes/Makefile             |  1 +
> >  arch/arm64/kernel/probes/ftrace.c             | 78 +++++++++++++++++++
> >  5 files changed, 82 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm64/kernel/probes/ftrace.c
> >
> > diff --git a/Documentation/features/debug/kprobes-on-ftrace/arch-suppor=
t.txt b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
> > index 4fae0464ddff..f9dd9dd91e0c 100644
> > --- a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
> > +++ b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
> > @@ -9,7 +9,7 @@
> >      |       alpha: | TODO |
> >      |         arc: | TODO |
> >      |         arm: | TODO |
> > -    |       arm64: | TODO |
> > +    |       arm64: |  ok  |
> >      |         c6x: | TODO |
> >      |        csky: | TODO |
> >      |       h8300: | TODO |
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index b1b4476ddb83..92b9882889ac 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -166,6 +166,7 @@ config ARM64
> >       select HAVE_STACKPROTECTOR
> >       select HAVE_SYSCALL_TRACEPOINTS
> >       select HAVE_KPROBES
> > +     select HAVE_KPROBES_ON_FTRACE
> >       select HAVE_KRETPROBES
> >       select HAVE_GENERIC_VDSO
> >       select IOMMU_DMA if IOMMU_SUPPORT
> > diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/f=
trace.h
> > index 91fa4baa1a93..875aeb839654 100644
> > --- a/arch/arm64/include/asm/ftrace.h
> > +++ b/arch/arm64/include/asm/ftrace.h
> > @@ -20,6 +20,7 @@
> >
> >  /* The BL at the callsite's adjusted rec->ip */
> >  #define MCOUNT_INSN_SIZE     AARCH64_INSN_SIZE
> > +#define FTRACE_IP_EXTENSION  MCOUNT_INSN_SIZE
> >
> >  #define FTRACE_PLT_IDX               0
> >  #define FTRACE_REGS_PLT_IDX  1
> > diff --git a/arch/arm64/kernel/probes/Makefile b/arch/arm64/kernel/prob=
es/Makefile
> > index 8e4be92e25b1..4020cfc66564 100644
> > --- a/arch/arm64/kernel/probes/Makefile
> > +++ b/arch/arm64/kernel/probes/Makefile
> > @@ -4,3 +4,4 @@ obj-$(CONFIG_KPROBES)         +=3D kprobes.o decode-ins=
n.o      \
> >                                  simulate-insn.o
> >  obj-$(CONFIG_UPROBES)                +=3D uprobes.o decode-insn.o     =
 \
> >                                  simulate-insn.o
> > +obj-$(CONFIG_KPROBES_ON_FTRACE)      +=3D ftrace.o
> > diff --git a/arch/arm64/kernel/probes/ftrace.c b/arch/arm64/kernel/prob=
es/ftrace.c
> > new file mode 100644
> > index 000000000000..0643aa2dacdb
> > --- /dev/null
> > +++ b/arch/arm64/kernel/probes/ftrace.c
> > @@ -0,0 +1,78 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Dynamic Ftrace based Kprobes Optimization
> > + *
> > + * Copyright (C) Hitachi Ltd., 2012
> > + * Copyright (C) 2019 Jisheng Zhang <jszhang@kernel.org>
> > + *                 Synaptics Incorporated
> > + */
> > +
> > +#include <linux/kprobes.h>
> > +
> > +/*
> > + * In arm64 FTRACE_WITH_REGS implementation, we patch two nop instruct=
ions:
> > + * the lr saver and bl ftrace-entry. Both these instructions are claim=
ed
> > + * by ftrace and we should allow probing on either instruction. =20
>=20
> No, the 2nd bl ftrace-entry must not be probed.
> The pair of lr-saver and bl ftrace-entry is tightly coupled. You can not
> decouple it.

This is the key. different viewing of this results in different implementat=
ion.
I'm just wondering why are the two instructions considered as coupled. I th=
ink
here we met similar situation as powerpc: https://lkml.org/lkml/2019/6/18/6=
46
the "mflr r0" equals to lr-saver here, branch to _mcount equals to bl ftrac=
e-entry
could you please kindly comment more?

Thanks in advance



>=20
> > + */
> > +int arch_check_ftrace_location(struct kprobe *p)
> > +{
> > +     if (ftrace_location((unsigned long)p->addr))
> > +             p->flags |=3D KPROBE_FLAG_FTRACE;
> > +     return 0;
> > +} =20
>=20
> Thus, this must return -EILSEQ if user puts a probe on the bl.
>=20
> > +
> > +/* Ftrace callback handler for kprobes -- called under preepmt disabed=
 */
> > +void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
> > +                        struct ftrace_ops *ops, struct pt_regs *regs)
> > +{
> > +     bool lr_saver =3D false;
> > +     struct kprobe *p;
> > +     struct kprobe_ctlblk *kcb;
> > +
> > +     /* Preempt is disabled by ftrace */
> > +     p =3D get_kprobe((kprobe_opcode_t *)ip);
> > +     if (!p) {
> > +             p =3D get_kprobe((kprobe_opcode_t *)(ip - MCOUNT_INSN_SIZ=
E));
> > +             if (unlikely(!p) || kprobe_disabled(p))
> > +                     return;
> > +             lr_saver =3D true; =20
>=20
> Then, this can be removed.
>=20
> > +     }
> > +
> > +     kcb =3D get_kprobe_ctlblk();
> > +     if (kprobe_running()) {
> > +             kprobes_inc_nmissed_count(p);
> > +     } else {
> > +             unsigned long orig_ip =3D instruction_pointer(regs);
> > +
> > +             if (lr_saver)
> > +                     ip -=3D MCOUNT_INSN_SIZE; =20
>=20
> Ditto.
>=20
> Thank you,
>=20
> > +             instruction_pointer_set(regs, ip);
> > +             __this_cpu_write(current_kprobe, p);
> > +             kcb->kprobe_status =3D KPROBE_HIT_ACTIVE;
> > +             if (!p->pre_handler || !p->pre_handler(p, regs)) {
> > +                     /*
> > +                      * Emulate singlestep (and also recover regs->pc)
> > +                      * as if there is a nop
> > +                      */
> > +                     instruction_pointer_set(regs,
> > +                             (unsigned long)p->addr + MCOUNT_INSN_SIZE=
);
> > +                     if (unlikely(p->post_handler)) {
> > +                             kcb->kprobe_status =3D KPROBE_HIT_SSDONE;
> > +                             p->post_handler(p, regs, 0);
> > +                     }
> > +                     instruction_pointer_set(regs, orig_ip);
> > +             }
> > +             /*
> > +              * If pre_handler returns !0, it changes regs->pc. We hav=
e to
> > +              * skip emulating post_handler.
> > +              */
> > +             __this_cpu_write(current_kprobe, NULL);
> > +     }
> > +}
> > +NOKPROBE_SYMBOL(kprobe_ftrace_handler);
> > +
> > +int arch_prepare_kprobe_ftrace(struct kprobe *p)
> > +{
> > +     p->ainsn.api.insn =3D NULL;
> > +     return 0;
> > +}
> > --
> > 2.24.1
> > =20
>=20
>=20
> --
> Masami Hiramatsu <mhiramat@kernel.org>

