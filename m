Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E30C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 05:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB52208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 05:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="Tz40RK23"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfFGFu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 01:50:29 -0400
Received: from mail-eopbgr750048.outbound.protection.outlook.com ([40.107.75.48]:16290
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725772AbfFGFu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 01:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCyWFu5PskTTCdxt03zFCREVyntlk08veDBv+UqnX90=;
 b=Tz40RK23/VHohM/7AW5+0Qq+Q91DatXMIznnY+oSDsznsf/CU39wU7BCflek3Dhu7f+7gwuDSv4Qs7xQyHYHYz15rQqVkFMMPcIM+KogZs3cCsBeyFCT12/nv2o289sE3fqrSh0iR46j7wwZYMcm4MKiKghmA4S4i6syZnapqSs=
Received: from BL0PR05MB4772.namprd05.prod.outlook.com (20.177.145.81) by
 BL0PR05MB5570.namprd05.prod.outlook.com (10.167.240.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Fri, 7 Jun 2019 05:50:22 +0000
Received: from BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::ac1f:2cd2:fa9c:a886]) by BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::ac1f:2cd2:fa9c:a886%6]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 05:50:22 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 13/15] x86/static_call: Add inline static call
 implementation for x86-64
Thread-Topic: [PATCH 13/15] x86/static_call: Add inline static call
 implementation for x86-64
Thread-Index: AQHVG6HbUZEsVsjdrUOVxRZQdAn/WKaPsoOA
Date:   Fri, 7 Jun 2019 05:50:22 +0000
Message-ID: <47AED7D2-4727-4EA1-84DB-4B119673A4FA@vmware.com>
References: <20190605130753.327195108@infradead.org>
 <20190605131945.313688119@infradead.org>
In-Reply-To: <20190605131945.313688119@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 741d5cb7-72bc-469f-1e3e-08d6eb0c07da
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BL0PR05MB5570;
x-ms-traffictypediagnostic: BL0PR05MB5570:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BL0PR05MB557002ED374D40D388A1B50CD0100@BL0PR05MB5570.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(396003)(39860400002)(136003)(189003)(199004)(26005)(36756003)(6306002)(5660300002)(2906002)(71190400001)(71200400001)(6916009)(476003)(33656002)(6486002)(83716004)(91956017)(7416002)(6116002)(3846002)(68736007)(305945005)(8936002)(7736002)(8676002)(81166006)(81156014)(99286004)(53546011)(6506007)(102836004)(76176011)(478600001)(86362001)(14444005)(966005)(82746002)(66476007)(66556008)(64756008)(66446008)(256004)(76116006)(66946007)(53936002)(6436002)(2616005)(486006)(11346002)(446003)(229853002)(14454004)(186003)(66066001)(4326008)(54906003)(6246003)(6512007)(316002)(25786009)(73956011)(45080400002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR05MB5570;H:BL0PR05MB4772.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RrAOO5VT+8WGQUxTIqshjkzohmntfnDj7Hj/eatogeQ0wjav4PS1rZVfzYheJTtrhs2qaTPzhrBmqkjDnKsvkafCsMBDq0A6lklZQRoO8SXP1++pmMk4144wevLskRst2zG6N8dmlfYWkxEaZPMlf6tkYrHOKpUpWS0s5J5rE9Uq2YFAsZrnO+XPPJYyxDnmnQeECuxaOev3OTJnq5JR0UeyF9ODqKlVn241qRuLpomIi/MMs4CUOp8k0cxMdTi5RVMpwse9JnuEDymU9RKJ9kCVyOxhkVvXoOCZVReHrr2UCLTT+A7X4ShCjD/e3DXAyCnmtz6jTw+n5+yilZ94owrrtVPzLzXXzL6v4nc/DxZPyJzAwpnkvoTSsEJ7sXTh3sKQhG/+X2SWDDQN1YvhGDNakX/TNICqGpA52ToOo2c=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3293540FC5084F4FA3C147479223B19A@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 741d5cb7-72bc-469f-1e3e-08d6eb0c07da
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 05:50:22.1564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR05MB5570
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jun 5, 2019, at 6:08 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> From: Josh Poimboeuf <jpoimboe@redhat.com>
>=20
> Add the inline static call implementation for x86-64.  For each key, a
> temporary trampoline is created, named __static_call_tramp_<key>.  The
> trampoline has an indirect jump to the destination function.
>=20
> Objtool uses the trampoline naming convention to detect all the call
> sites.  It then annotates those call sites in the .static_call_sites
> section.
>=20
> During boot (and module init), the call sites are patched to call
> directly into the destination function.  The temporary trampoline is
> then no longer used.
>=20
> Cc: x86@kernel.org
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Julia Cartwright <julia@ni.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Jason Baron <jbaron@akamai.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Jiri Kosina <jkosina@suse.cz>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: David Laight <David.Laight@ACULAB.COM>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Flkml.kernel.org%2Fr%2F62188c62f6dda49ca2e20629ee8e5a62a6c0b500.1543200841.=
git.jpoimboe%40redhat.com&amp;data=3D02%7C01%7Cnamit%40vmware.com%7C3a349bb=
2a7e042ef9d9d08d6e9b8fc2d%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C6369=
53378066316039&amp;sdata=3DJ%2BsCYwRi8GpP5GrJaLo8nM5jN2KNZlfwq7RDuKok%2FmE%=
3D&amp;reserved=3D0
> ---
> arch/x86/Kconfig                                |    3=20
> arch/x86/include/asm/static_call.h              |   28 ++++-
> arch/x86/kernel/asm-offsets.c                   |    6 +
> arch/x86/kernel/static_call.c                   |   12 +-
> include/linux/static_call.h                     |    2=20
> tools/objtool/Makefile                          |    3=20
> tools/objtool/check.c                           |  125 ++++++++++++++++++=
+++++-
> tools/objtool/check.h                           |    2=20
> tools/objtool/elf.h                             |    1=20
> tools/objtool/include/linux/static_call_types.h |   19 +++
> tools/objtool/sync-check.sh                     |    1=20
> 11 files changed, 193 insertions(+), 9 deletions(-)
> create mode 100644 tools/objtool/include/linux/static_call_types.h
>=20
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -199,6 +199,7 @@ config X86
> 	select HAVE_STACKPROTECTOR		if CC_HAS_SANE_STACKPROTECTOR
> 	select HAVE_STACK_VALIDATION		if X86_64
> 	select HAVE_STATIC_CALL
> +	select HAVE_STATIC_CALL_INLINE		if HAVE_STACK_VALIDATION
> 	select HAVE_RSEQ
> 	select HAVE_SYSCALL_TRACEPOINTS
> 	select HAVE_UNSTABLE_SCHED_CLOCK
> @@ -213,6 +214,7 @@ config X86
> 	select RTC_MC146818_LIB
> 	select SPARSE_IRQ
> 	select SRCU
> +	select STACK_VALIDATION			if HAVE_STACK_VALIDATION && (HAVE_STATIC_CALL=
_INLINE || RETPOLINE)
> 	select SYSCTL_EXCEPTION_TRACE
> 	select THREAD_INFO_IN_TASK
> 	select USER_STACKTRACE_SUPPORT
> @@ -439,7 +441,6 @@ config GOLDFISH
> config RETPOLINE
> 	bool "Avoid speculative indirect branches in kernel"
> 	default y
> -	select STACK_VALIDATION if HAVE_STACK_VALIDATION
> 	help
> 	  Compile kernel with the retpoline compiler options to guard against
> 	  kernel-to-user data leaks by avoiding speculative indirect
> --- a/arch/x86/include/asm/static_call.h
> +++ b/arch/x86/include/asm/static_call.h
> @@ -2,6 +2,20 @@
> #ifndef _ASM_STATIC_CALL_H
> #define _ASM_STATIC_CALL_H
>=20
> +#include <asm/asm-offsets.h>
> +
> +#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
> +
> +/*
> + * This trampoline is only used during boot / module init, so it's safe =
to use
> + * the indirect branch without a retpoline.
> + */
> +#define __ARCH_STATIC_CALL_TRAMP_JMP(key, func)				\
> +	ANNOTATE_RETPOLINE_SAFE						\
> +	"jmpq *" __stringify(key) "+" __stringify(SC_KEY_func) "(%rip) \n"
> +
> +#else /* !CONFIG_HAVE_STATIC_CALL_INLINE */
> +
> /*
>  * Manually construct a 5-byte direct JMP to prevent the assembler from
>  * optimizing it into a 2-byte JMP.
> @@ -12,9 +26,19 @@
> 	".long " #func " - " __ARCH_STATIC_CALL_JMP_LABEL(key) "\n"	\
> 	__ARCH_STATIC_CALL_JMP_LABEL(key) ":"
>=20
> +#endif /* !CONFIG_HAVE_STATIC_CALL_INLINE */
> +
> /*
> - * This is a permanent trampoline which does a direct jump to the functi=
on.
> - * The direct jump get patched by static_call_update().
> + * For CONFIG_HAVE_STATIC_CALL_INLINE, this is a temporary trampoline wh=
ich
> + * uses the current value of the key->func pointer to do an indirect jum=
p to
> + * the function.  This trampoline is only used during boot, before the c=
all
> + * sites get patched by static_call_update().  The name of this trampoli=
ne has
> + * a magical aspect: objtool uses it to find static call sites so it can=
 create
> + * the .static_call_sites section.
> + *
> + * For CONFIG_HAVE_STATIC_CALL, this is a permanent trampoline which
> + * does a direct jump to the function.  The direct jump gets patched by
> + * static_call_update().
>  */
> #define ARCH_DEFINE_STATIC_CALL_TRAMP(key, func)			\
> 	asm(".pushsection .text, \"ax\"				\n"	\
> --- a/arch/x86/kernel/asm-offsets.c
> +++ b/arch/x86/kernel/asm-offsets.c
> @@ -12,6 +12,7 @@
> #include <linux/hardirq.h>
> #include <linux/suspend.h>
> #include <linux/kbuild.h>
> +#include <linux/static_call.h>
> #include <asm/processor.h>
> #include <asm/thread_info.h>
> #include <asm/sigframe.h>
> @@ -104,4 +105,9 @@ static void __used common(void)
> 	OFFSET(TSS_sp0, tss_struct, x86_tss.sp0);
> 	OFFSET(TSS_sp1, tss_struct, x86_tss.sp1);
> 	OFFSET(TSS_sp2, tss_struct, x86_tss.sp2);
> +
> +#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
> +	BLANK();
> +	OFFSET(SC_KEY_func, static_call_key, func);
> +#endif
> }
> --- a/arch/x86/kernel/static_call.c
> +++ b/arch/x86/kernel/static_call.c
> @@ -10,16 +10,22 @@
> void arch_static_call_transform(void *site, void *tramp, void *func)
> {
> 	unsigned char opcodes[CALL_INSN_SIZE];
> -	unsigned char insn_opcode;
> +	unsigned char insn_opcode, expected;
> 	unsigned long insn;
> 	s32 dest_relative;
>=20
> 	mutex_lock(&text_mutex);
>=20
> -	insn =3D (unsigned long)tramp;
> +	if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE)) {
> +		insn =3D (unsigned long)site;
> +		expected =3D 0xE8; /* CALL */

RELATIVECALL_OPCODE ?

> +	} else {
> +		insn =3D (unsigned long)tramp;
> +		expected =3D 0xE9; /* JMP */

RELATIVEJUMP_OPCODE ?

( I did not review the objtool parts )=
