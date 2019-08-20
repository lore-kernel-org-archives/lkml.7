Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6D7C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 07:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615E122CF4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 07:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="Owwe2nWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbfHTHTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 03:19:37 -0400
Received: from mail-eopbgr770040.outbound.protection.outlook.com ([40.107.77.40]:24612
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726049AbfHTHTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 03:19:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9HCbh4nCM3U15oI9PiJA1YBdJI6WUF56MZfZHlz5do9cokpdtDm633aL0TVEwz0uKocyG4I/8iCp0dxnHZpMLw5SBTgA8hTNDrIpgY1YZMA3/fyadEje5aZH7kFHdyT8oD5pD9z3quiLjKBEo99VBUZ6zq4sHx3UAJRmpub1MK7Y5ILUB4UB/m8RGLam4YzfCl1irkti1isb/YrksgBH2OdY84HmhZC2UWbzf08mxUP59K9qc+IJUEAdM1pOKhYcr+mPgy+VI6HEvPtZ6XdgZz42PfGyGU8q6LsZg0kx1s1+GTrEiDI4LRfMbtcMdtpGFm/0+tCn0bo8IJ26FEWVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUIFyNo8RtxWtNODWPrIq8DH/ZNyE7aAtboMiJXAXBc=;
 b=Em2Lqrnj7OQayzFxUsJNLVpqHF98mWZcsJIDJQ8Grnob1xvMqb76UGmNRAnHVPg0oxYTygdh6zJldAEF9uyQvOZPGkias3uegADoVUbztxsK1mS1+vCkhNbTJSAGbX+XvM3DpV6dVzp6Mf4sYs5Qh7YYTMK8apBi1R/GhJlCYMW5OuKmZmOqjYchw8aM6eo/9GtVyHFWS3VV/SXoDj5aHMgHyqugRLekOSMnyygBSn4IxYIOBde+iCvzTOZqVbwJ1bR41QfeRMwZnH7PhZuQekdpsHv2iXgyWbba1HrBZ+NFEfr2l5tnc2EWtS+oI5jFkSzsVy3euooCpjfedqC74A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUIFyNo8RtxWtNODWPrIq8DH/ZNyE7aAtboMiJXAXBc=;
 b=Owwe2nWazd4a/ToPIdCRjRKT7h+2zjM6RlPQyXk4XNdMVBtoc8qosZD+dU9hqfY3X3t+PQaeg37/l5i2Oj67woXgGQtUWgUwP04U9fCpXtJP78Q3MrNQmYWfPG0Dgyb2Yk/5fZPtL+jy2YZnfgl7pT+SMZ/bKDUAyIQ/9sNbmGI=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4840.namprd03.prod.outlook.com (20.179.93.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 20 Aug 2019 07:17:54 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88%7]) with mapi id 15.20.2157.022; Tue, 20 Aug 2019
 07:17:54 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] arm64: implement KPROBES_ON_FTRACE
Thread-Topic: [PATCH v2 3/3] arm64: implement KPROBES_ON_FTRACE
Thread-Index: AQHVVwrs2GkuQiZ2DEOebbYaYVI7i6cDnZIA
Date:   Tue, 20 Aug 2019 07:17:53 +0000
Message-ID: <20190820150646.1e4ae6ba@xhacker.debian>
References: <20190820113928.1971900c@xhacker.debian>
        <20190820114314.685a3239@xhacker.debian>
In-Reply-To: <20190820114314.685a3239@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY1PR01CA0160.jpnprd01.prod.outlook.com (2603:1096:402::12)
 To BYAPR03MB4773.namprd03.prod.outlook.com (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 342785ac-8539-4a21-64c5-08d7253e8473
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB4840;
x-ms-traffictypediagnostic: BYAPR03MB4840:
x-microsoft-antispam-prvs: <BYAPR03MB48401D9BC240FD4042F0C05DEDAB0@BYAPR03MB4840.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(366004)(346002)(136003)(189003)(199004)(446003)(11346002)(66446008)(66476007)(66946007)(66556008)(7416002)(14444005)(256004)(110136005)(71200400001)(71190400001)(186003)(8676002)(229853002)(2906002)(6486002)(25786009)(6116002)(64756008)(476003)(3846002)(2501003)(81166006)(81156014)(6246003)(316002)(8936002)(52116002)(26005)(5660300002)(486006)(6512007)(9686003)(1076003)(76176011)(14454004)(53936002)(54906003)(478600001)(6436002)(305945005)(7736002)(66066001)(4326008)(99286004)(86362001)(386003)(6506007)(50226002)(102836004)(921003)(1121003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4840;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: C+Rp1ztQLbVWqkGi++e/CJz9v5qkj8Zovy/xQPkk9eiXY4fUO26Hidq4cNc78xLgBgNgCZUwAPlKIYHlR18mufwkiqIdg6wgZSNr7AJq8SWbYxBueLMeZ2LLXoykFkKy5yYFKqtJsBnmHvEwmlpuzWvJWhmffxyFNXmdXECVl3BrSwT04s9lb3o2vRSnFzgEUtnDD9ghBH07NnF2OJ0GupEIrhKip4g3uklagPhl0t+0z28G2eNQ70KbMehNa8ln7Sa/BtjV35OYm1iP/OCpwUq9GISqUD9fb6d682yulaguddhchPneeUSnlmqOE+oZtSGxyLdBvghAJsD4fFDxEfFmaBNzaSIL0F2E4FbMgpn8Wo6Udkd/0lWzE1Bu7ORzLOz1CNe6id7Wcz1qYjhwWJWHu2T4BmnNw2YgEDU09h4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5782F46120ED1740A66C12C3DE43243A@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 342785ac-8539-4a21-64c5-08d7253e8473
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 07:17:53.9647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GfJO4CNNkEH99o7OCz1M2uoHla8vkTROrSOu/ZSO7pp/hrPFBt0CGNgWpdW4o6IqMAriZRuq88c17ICAGFALMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4840
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Aug 2019 03:54:20 +0000 Jisheng Zhang wrote:

>=20
>=20
> KPROBES_ON_FTRACE avoids much of the overhead with regular kprobes as it
> eliminates the need for a trap, as well as the need to emulate or
> single-step instructions.
>=20
> This patch implements KPROBES_ON_FTRACE for arm64.
>=20
> Tested on berlin arm64 platform.

some performance numbers may be interesting.

HW: Berlin arm64 platform, cpufreq is forced to 800MHZ
SW: getppid syscall micro-benchmark, source code is put at the end of this =
email.

A. Not probed.=20
B. Probed at __arm64_sys_getppid w/ non-operation probe functions, w/o KPRO=
BES_ON_FTRACE
C. Probed at __arm64_sys_getppid w/ non-operation probe functions, w/ KPROB=
ES_ON_FTRACE

A: 1905 ns/call
B: 5833 ns/call
C: 2169 ns/call

The overhead of kprobes is 5833 - 1905 =3D 3928 ns/call
The overhead of kprobes w/ KPROBES_ON_FTRACE is 2169 - 1905 =3D 264 ns/call

As can be seen, KPROBES_ON_FTRACE significantly reduce the overhead of kpro=
bes.

Thanks

<---8---
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <sys/resource.h>
#include <unistd.h>

int main (int argc, char *argv[])
{
	struct timeval tv;
	unsigned long count;
	struct rusage usage;

	for (count =3D 0; count < 10000000; count++)
		getppid();
	getrusage(RUSAGE_SELF, &usage);
	tv =3D usage.ru_stime;
	tv.tv_sec +=3D usage.ru_utime.tv_sec;
	tv.tv_usec +=3D usage.ru_utime.tv_usec;
	fprintf(stderr, "getppid was called %u times: %d nsec per call\n",
	       count, (tv.tv_sec*1000*1000 + tv.tv_usec)/(count/1000));

	return 0;
}

>=20
> ~ # mount -t debugfs debugfs /sys/kernel/debug/
> ~ # cd /sys/kernel/debug/
> /sys/kernel/debug # echo 'p _do_fork' > tracing/kprobe_events
>=20
> before the patch:
>=20
> /sys/kernel/debug # cat kprobes/list
> ffffff801009fe28  k  _do_fork+0x0    [DISABLED]
>=20
> after the patch:
>=20
> /sys/kernel/debug # cat kprobes/list
> ffffff801009ff54  k  _do_fork+0x4    [DISABLED][FTRACE]
>=20
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  .../debug/kprobes-on-ftrace/arch-support.txt  |  2 +-
>  arch/arm64/Kconfig                            |  1 +
>  arch/arm64/kernel/probes/Makefile             |  1 +
>  arch/arm64/kernel/probes/ftrace.c             | 60 +++++++++++++++++++
>  4 files changed, 63 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/kernel/probes/ftrace.c
>=20
> diff --git a/Documentation/features/debug/kprobes-on-ftrace/arch-support.=
txt b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
> index 68f266944d5f..e8358a38981c 100644
> --- a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
> +++ b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
> @@ -9,7 +9,7 @@
>      |       alpha: | TODO |
>      |         arc: | TODO |
>      |         arm: | TODO |
> -    |       arm64: | TODO |
> +    |       arm64: |  ok  |
>      |         c6x: | TODO |
>      |        csky: | TODO |
>      |       h8300: | TODO |
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 663392d1eae2..928700f15e23 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -167,6 +167,7 @@ config ARM64
>         select HAVE_STACKPROTECTOR
>         select HAVE_SYSCALL_TRACEPOINTS
>         select HAVE_KPROBES
> +       select HAVE_KPROBES_ON_FTRACE
>         select HAVE_KRETPROBES
>         select HAVE_GENERIC_VDSO
>         select IOMMU_DMA if IOMMU_SUPPORT
> diff --git a/arch/arm64/kernel/probes/Makefile b/arch/arm64/kernel/probes=
/Makefile
> index 8e4be92e25b1..4020cfc66564 100644
> --- a/arch/arm64/kernel/probes/Makefile
> +++ b/arch/arm64/kernel/probes/Makefile
> @@ -4,3 +4,4 @@ obj-$(CONFIG_KPROBES)           +=3D kprobes.o decode-ins=
n.o      \
>                                    simulate-insn.o
>  obj-$(CONFIG_UPROBES)          +=3D uprobes.o decode-insn.o      \
>                                    simulate-insn.o
> +obj-$(CONFIG_KPROBES_ON_FTRACE)        +=3D ftrace.o
> diff --git a/arch/arm64/kernel/probes/ftrace.c b/arch/arm64/kernel/probes=
/ftrace.c
> new file mode 100644
> index 000000000000..52901ffff570
> --- /dev/null
> +++ b/arch/arm64/kernel/probes/ftrace.c
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Dynamic Ftrace based Kprobes Optimization
> + *
> + * Copyright (C) Hitachi Ltd., 2012
> + * Copyright (C) 2019 Jisheng Zhang <jszhang@kernel.org>
> + *                   Synaptics Incorporated
> + */
> +
> +#include <linux/kprobes.h>
> +
> +/* Ftrace callback handler for kprobes -- called under preepmt disabed *=
/
> +void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
> +                          struct ftrace_ops *ops, struct pt_regs *regs)
> +{
> +       struct kprobe *p;
> +       struct kprobe_ctlblk *kcb;
> +
> +       /* Preempt is disabled by ftrace */
> +       p =3D get_kprobe((kprobe_opcode_t *)ip);
> +       if (unlikely(!p) || kprobe_disabled(p))
> +               return;
> +
> +       kcb =3D get_kprobe_ctlblk();
> +       if (kprobe_running()) {
> +               kprobes_inc_nmissed_count(p);
> +       } else {
> +               unsigned long orig_ip =3D instruction_pointer(regs);
> +               /* Kprobe handler expects regs->pc =3D pc + 1 as breakpoi=
nt hit */
> +               instruction_pointer_set(regs, ip + sizeof(kprobe_opcode_t=
));
> +
> +               __this_cpu_write(current_kprobe, p);
> +               kcb->kprobe_status =3D KPROBE_HIT_ACTIVE;
> +               if (!p->pre_handler || !p->pre_handler(p, regs)) {
> +                       /*
> +                        * Emulate singlestep (and also recover regs->pc)
> +                        * as if there is a nop
> +                        */
> +                       instruction_pointer_set(regs,
> +                               (unsigned long)p->addr + MCOUNT_INSN_SIZE=
);
> +                       if (unlikely(p->post_handler)) {
> +                               kcb->kprobe_status =3D KPROBE_HIT_SSDONE;
> +                               p->post_handler(p, regs, 0);
> +                       }
> +                       instruction_pointer_set(regs, orig_ip);
> +               }
> +               /*
> +                * If pre_handler returns !0, it changes regs->pc. We hav=
e to
> +                * skip emulating post_handler.
> +                */
> +               __this_cpu_write(current_kprobe, NULL);
> +       }
> +}
> +NOKPROBE_SYMBOL(kprobe_ftrace_handler);
> +
> +int arch_prepare_kprobe_ftrace(struct kprobe *p)
> +{
> +       p->ainsn.api.insn =3D NULL;
> +       return 0;
> +}
> --
> 2.23.0.rc1
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
