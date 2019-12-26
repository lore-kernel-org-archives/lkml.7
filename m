Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AC5C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 04:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D0C20838
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 04:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="B9ulO3LB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfLZE1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 23:27:09 -0500
Received: from mail-dm6nam10on2079.outbound.protection.outlook.com ([40.107.93.79]:6053
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726741AbfLZE1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 23:27:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7H5dMudoeixHGK689Ya2XBztZoBWpt+coqtNdGAxvLdN6D/9DOvRpQHTd3gPJZ6NkkOqP0Pnkt70h3caDqKCr/BX98o+3Bry8XzYD39e7Yzu3iyD1V1iKSlE7pOS7Ftl26o2IjoSzVZgiT7ZSNmqJFEEY07T1ohUS7W7fMSnQX0JU5BwUDfm9Hdobute5/qmpPDb+Top7+28tFS8yDTfMNjwr/q3dSZEUMbKF6NruHxPDNLEbes8pk2Fy4JlFBKnjvv2U1K6TGpcz5jBYef1YlrEgtuLRZ+zNbCF3b4D2diwfrT97XcSFirIWh8F2xulfTdvvIwD4u5+POhs5ERiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAgbDF9AJ2h03/GQU9pULQlEwf7xwhhBYFmIjy6MgoY=;
 b=IzXARiy9yKz5IU+dQ9SiHWNEpL19wJNN9RGq/yZI17Qt77/eOeceaKlz0PHbPBiuLvjU9eYvC9GLKedMQbB2N6IoLd92pL3REbe93TmsSHgHE6X4gQtTX6fQLXCAuKkIBLQz6gsxXpFD/Xb3HocfYVjTEipXtqRa9WH8/LccAjpVZa4248/l4naIBPcBw0JkjSpl23wXIAG4NiDUdIO2w0ULFiCyp1//sGnzauTRPQYIzTp8Yse8kdvUaQS45Q6frkd1ZcvTnYNfT3RCxiI1+r/9qcTJTfUSodVpWgYK8pNSSs+jHOFbdT/knE+k+vueGT0Qa2R/8/sxwFo5oHlaBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAgbDF9AJ2h03/GQU9pULQlEwf7xwhhBYFmIjy6MgoY=;
 b=B9ulO3LB9lvJ+yKo5lED3F3JsLvN+SCoKbfN6C7rJsFTptoU9QJCRfKz95BLcL8hlWN+4FzPl/2rB5Q8GYNwf/FTKCN3nmlinNpgJFncnE1vRCRJdmRbF9MtttdNboxRWLKDvPUn+wmx6cSzdBJ9EpwdgVH9tUR/4rqE60xtb0c=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.93.213) by
 BYAPR03MB4582.namprd03.prod.outlook.com (20.178.48.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Thu, 26 Dec 2019 04:25:24 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::708d:91cc:79a7:9b9a]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::708d:91cc:79a7:9b9a%6]) with mapi id 15.20.2559.017; Thu, 26 Dec 2019
 04:25:24 +0000
Received: from xhacker.debian (124.74.246.114) by TYAPR01CA0015.jpnprd01.prod.outlook.com (2603:1096:404::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend Transport; Thu, 26 Dec 2019 04:25:20 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 3/3] arm64: implement KPROBES_ON_FTRACE
Thread-Topic: [PATCH v7 3/3] arm64: implement KPROBES_ON_FTRACE
Thread-Index: AQHVuwfioeAAP6kOPkCZLC/0/SnpxKfLukGAgAAB3gCAABLQAA==
Date:   Thu, 26 Dec 2019 04:25:24 +0000
Message-ID: <20191226121108.0cd1b078@xhacker.debian>
References: <20191225172625.69811b3e@xhacker.debian>
        <20191225173001.6c0e3fb2@xhacker.debian>
        <20191226115707.902545688aa90b34e2e550b3@kernel.org>
        <20191226110348.146bb80b@xhacker.debian>
In-Reply-To: <20191226110348.146bb80b@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR01CA0015.jpnprd01.prod.outlook.com (2603:1096:404::27)
 To BYAPR03MB4773.namprd03.prod.outlook.com (2603:10b6:a03:139::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13b2c609-2e66-465b-6a56-08d789bba078
x-ms-traffictypediagnostic: BYAPR03MB4582:
x-microsoft-antispam-prvs: <BYAPR03MB4582848D15BA4C5B0B1103ABED2B0@BYAPR03MB4582.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02638D901B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(366004)(396003)(346002)(199004)(189003)(51874003)(7416002)(6506007)(55016002)(9686003)(86362001)(71200400001)(956004)(8936002)(66946007)(478600001)(8676002)(64756008)(1076003)(66476007)(66556008)(81166006)(66446008)(81156014)(2906002)(52116002)(7696005)(4326008)(5660300002)(6916009)(54906003)(16526019)(966005)(316002)(26005)(186003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4582;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WtnBAPsHWvntSMzwwdUOzpz8ZrJ73+hpzEUigRJXF9hh+DyxSIrgDMdXlaBLVEQom4Rqe6NpaxpbPw+zffXGfDxc2tDbS9svRyGgCEQO2NdXr+BixebboUzJMZZLaby9mMcb5PagoCYYvDloBm/miHoJoA3DAlb8kQC184EjlbapFOGLAF3dVgTaNz2INH2AhVrN/KGxk9ShYJ68/aDscVl7l1ZuuQ0dryEycxlV96d0ZMXsQDsfB+skE4QpfK2TGuElhkz4OyfyKT3AB5tPQ9v9Z3pNDKxEscOoJIh7R04mpdZ64o8UackN5vpgYWgdCURhyMJbNhCz4CcpMjNY4W7eBvflq6Y6hNENzl4Q0B39dpUb1ATAed8oJtOQocvZUsl4SbNiKk7ui7KkueFq6Kzr+rRt/tAEvM8NnePbJbegyRcv8XcshAh+m+jb/MyhMUH31ZXVEAhzjdzyl4UER8tg2kSv5ivJDvp4SXyhh3I2P2+0ZDeIsyL6CVDmsJ/GkPmiPIlnGK/pFajS1/aLz88N4M/y/uA2eeBDCcmERd71DnvV+XrPTJe7Z7XJ6XMP
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B9F9877E7A46154197F25A57D30FF377@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b2c609-2e66-465b-6a56-08d789bba078
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2019 04:25:24.3278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PLeu9uEDv0WZyzhbuAxBFyvmhQIa1o78hUcORNMVsF7ryOpqZ7omI3/6/XMc/oFkT3VxRNhtSxCBW8soWffvCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4582
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Dec 2019 03:18:07 +0000 Jisheng Zhang wrote:


>=20
>=20
> Hi
>=20
> On Thu, 26 Dec 2019 11:57:07 +0900 Masami Hiramatsu wrote:
>=20
> >
> > Hi Jisheng,
> >
> > On Wed, 25 Dec 2019 09:44:21 +0000
> > Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
> > =20
> > > KPROBES_ON_FTRACE avoids much of the overhead with regular kprobes as=
 it
> > > eliminates the need for a trap, as well as the need to emulate or
> > > single-step instructions.
> > >
> > > Tested on berlin arm64 platform.
> > >
> > > ~ # mount -t debugfs debugfs /sys/kernel/debug/
> > > ~ # cd /sys/kernel/debug/
> > > /sys/kernel/debug # echo 'p _do_fork' > tracing/kprobe_events
> > >
> > > before the patch:
> > >
> > > /sys/kernel/debug # cat kprobes/list
> > > ffffff801009fe28  k  _do_fork+0x0    [DISABLED]
> > >
> > > after the patch:
> > >
> > > /sys/kernel/debug # cat kprobes/list
> > > ffffff801009ff54  k  _do_fork+0x0    [DISABLED][FTRACE] =20
> >
> > What happens if user puts a probe on _do_fork+4?
> > Is that return -EILSEQ correctly? =20
>=20
> _do_fork+4 can be probed successfully.
>=20
> > =20
> > >
> > > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > > ---
> > >  .../debug/kprobes-on-ftrace/arch-support.txt  |  2 +-
> > >  arch/arm64/Kconfig                            |  1 +
> > >  arch/arm64/include/asm/ftrace.h               |  1 +
> > >  arch/arm64/kernel/probes/Makefile             |  1 +
> > >  arch/arm64/kernel/probes/ftrace.c             | 78 +++++++++++++++++=
++
> > >  5 files changed, 82 insertions(+), 1 deletion(-)
> > >  create mode 100644 arch/arm64/kernel/probes/ftrace.c
> > >
> > > diff --git a/Documentation/features/debug/kprobes-on-ftrace/arch-supp=
ort.txt b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
> > > index 4fae0464ddff..f9dd9dd91e0c 100644
> > > --- a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
> > > +++ b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
> > > @@ -9,7 +9,7 @@
> > >      |       alpha: | TODO |
> > >      |         arc: | TODO |
> > >      |         arm: | TODO |
> > > -    |       arm64: | TODO |
> > > +    |       arm64: |  ok  |
> > >      |         c6x: | TODO |
> > >      |        csky: | TODO |
> > >      |       h8300: | TODO |
> > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > index b1b4476ddb83..92b9882889ac 100644
> > > --- a/arch/arm64/Kconfig
> > > +++ b/arch/arm64/Kconfig
> > > @@ -166,6 +166,7 @@ config ARM64
> > >       select HAVE_STACKPROTECTOR
> > >       select HAVE_SYSCALL_TRACEPOINTS
> > >       select HAVE_KPROBES
> > > +     select HAVE_KPROBES_ON_FTRACE
> > >       select HAVE_KRETPROBES
> > >       select HAVE_GENERIC_VDSO
> > >       select IOMMU_DMA if IOMMU_SUPPORT
> > > diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm=
/ftrace.h
> > > index 91fa4baa1a93..875aeb839654 100644
> > > --- a/arch/arm64/include/asm/ftrace.h
> > > +++ b/arch/arm64/include/asm/ftrace.h
> > > @@ -20,6 +20,7 @@
> > >
> > >  /* The BL at the callsite's adjusted rec->ip */
> > >  #define MCOUNT_INSN_SIZE     AARCH64_INSN_SIZE
> > > +#define FTRACE_IP_EXTENSION  MCOUNT_INSN_SIZE
> > >
> > >  #define FTRACE_PLT_IDX               0
> > >  #define FTRACE_REGS_PLT_IDX  1
> > > diff --git a/arch/arm64/kernel/probes/Makefile b/arch/arm64/kernel/pr=
obes/Makefile
> > > index 8e4be92e25b1..4020cfc66564 100644
> > > --- a/arch/arm64/kernel/probes/Makefile
> > > +++ b/arch/arm64/kernel/probes/Makefile
> > > @@ -4,3 +4,4 @@ obj-$(CONFIG_KPROBES)         +=3D kprobes.o decode-i=
nsn.o      \
> > >                                  simulate-insn.o
> > >  obj-$(CONFIG_UPROBES)                +=3D uprobes.o decode-insn.o   =
   \
> > >                                  simulate-insn.o
> > > +obj-$(CONFIG_KPROBES_ON_FTRACE)      +=3D ftrace.o
> > > diff --git a/arch/arm64/kernel/probes/ftrace.c b/arch/arm64/kernel/pr=
obes/ftrace.c
> > > new file mode 100644
> > > index 000000000000..0643aa2dacdb
> > > --- /dev/null
> > > +++ b/arch/arm64/kernel/probes/ftrace.c
> > > @@ -0,0 +1,78 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +/*
> > > + * Dynamic Ftrace based Kprobes Optimization
> > > + *
> > > + * Copyright (C) Hitachi Ltd., 2012
> > > + * Copyright (C) 2019 Jisheng Zhang <jszhang@kernel.org>
> > > + *                 Synaptics Incorporated
> > > + */
> > > +
> > > +#include <linux/kprobes.h>
> > > +
> > > +/*
> > > + * In arm64 FTRACE_WITH_REGS implementation, we patch two nop instru=
ctions:
> > > + * the lr saver and bl ftrace-entry. Both these instructions are cla=
imed
> > > + * by ftrace and we should allow probing on either instruction. =20
> >
> > No, the 2nd bl ftrace-entry must not be probed.
> > The pair of lr-saver and bl ftrace-entry is tightly coupled. You can no=
t
> > decouple it. =20
>=20
> This is the key. different viewing of this results in different implement=
ation.
> I'm just wondering why are the two instructions considered as coupled. I =
think
> here we met similar situation as powerpc: https://lkml.org/lkml/2019/6/18=
/646
> the "mflr r0" equals to lr-saver here, branch to _mcount equals to bl ftr=
ace-entry
> could you please kindly comment more?
>=20
> Thanks in advance
>=20

hmm, I think I may get some part of your opinion. In v7 implementation:

if probe on func+4, that's bl ftrace-entry, similar as mcount call on
other architectures, we allow this probe as normal.

if probe on func+0, the first param ip in kprobe_ftrace_handler() points
to func+4(this is adjusted by ftrace), regs->ip points to func+8, so in
kprobe_ftrace_handler() we modify regs->ip to func+0 to call kprobe
pre handler, then modify regs->ip to func+8 to call kprobe post handler.
As can be seen, the first two instructions are considered as a virtual
mcount call. From this point of view, lr saver and the bl <ftrace-entry>
is coupled.

If we split patch3 into two:
one to support kprobes func+4
the second to support kprobe on func+0
it would be much clearer.

Then the key here is whether we could allow both kprobes on func+0 and func=
+4

Thanks
