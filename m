Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CB9C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DFE1205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="jd5+8VjU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387769AbfHVKoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 06:44:09 -0400
Received: from mail-eopbgr740070.outbound.protection.outlook.com ([40.107.74.70]:26432
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387710AbfHVKoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 06:44:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLX62PrtxtT6PaGTRH423mSSR9AhtSsmqvvId8xaKFOd8UDrjD0k+8uIUxuaqlNtkWz9f7yOMqILM/hm6/fFJ0aWhX/e2JtJN5KTr6Cw2fYcEmgBCe5JF+pQ3PYAPxB2Y0AS+D/rcP/hY6Y0UjKtaU3t7yzmi0WGWgPGjVYYQCU0UgpZPbL4LhrVFkTQfIFQx/fGuiYqvqhi8PZDcL4lMd/NlspugZuyKR9ZisuSWPJV/XByKFzlV8Sa6bgvZgA5po8M8zhTvOKddhB7Ie246bEYgAmCe1kr3IxPzlIBv/+Dxy+aD4bjcHsECurKPDAY4Je3O4leva/Rr+wRgSJx8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBxmssn2OKSXWcr+k/5rrNQfoK8KXpoqd1TaaRKg0PA=;
 b=Tq9TDgMap/Y1tCDzLLDM/VsNd1k/AkN2+xwa8LMLwpDQIoMAzPkJnvDwK0HZKIBxIMxD4fcj4jt1YYUE1OMTGe3zN53YtQrxcdzTHyhiIJCscyRW3gMZgbmpitvtHJKi/2npd0J0klJFmkkaMlIS2FImhgOUj/YpcNqpT34bGfh1vr+dwBcnfXG/388mOMRAAAZCYzRo54qUtWIkclQHMgSYpQySBNwbotsEbnIhanWEYzvNYpmT4zMLt93GOnl1twfeZH04FfQoDA07TW5vqQWgoGQubaJ2ELkiSBQUYqg5+zyiQDk6iUMnSUhnpB1xGaSaK/o9BTwkE6ScIqqDXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBxmssn2OKSXWcr+k/5rrNQfoK8KXpoqd1TaaRKg0PA=;
 b=jd5+8VjUQvDFydKxtvsHvcgdE/4+g7ad97JMx0tlcPt8TFDNVmgCKiKHWDJqOjiTTAI1rvzRbZ72Y3W/tqaY6eG8CjZ9BwAFzM9FygViMP1HBfvibWDAgThKAuddKrKRGJf6aFFXAyzxobwjHaVCir92IkbNwzRoThZs3QcJpkY=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB3624.namprd03.prod.outlook.com (52.135.213.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Thu, 22 Aug 2019 10:44:04 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4%7]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 10:44:04 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4] arm64: implement KPROBES_ON_FTRACE
Thread-Topic: [PATCH v4] arm64: implement KPROBES_ON_FTRACE
Thread-Index: AQHVWJwGDRorz/HiOUajlPa5ER0qaKcGu4YAgACzXwD//4bGgIAAAwYA
Date:   Thu, 22 Aug 2019 10:44:03 +0000
Message-ID: <20190822183254.1bb5576d@xhacker.debian>
References: <20190822113421.52920377@xhacker.debian>
        <1566456155.27ojwy97ss.naveen@linux.ibm.com>
        <20190822173558.63de3fc4@xhacker.debian>
        <1566468150.x8u1577wgh.naveen@linux.ibm.com>
In-Reply-To: <1566468150.x8u1577wgh.naveen@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY2PR06CA0041.apcprd06.prod.outlook.com
 (2603:1096:404:2e::29) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3e8b1e9-091b-4078-a527-08d726eda66e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR03MB3624;
x-ms-traffictypediagnostic: BYAPR03MB3624:
x-microsoft-antispam-prvs: <BYAPR03MB3624A58FE647EDC761C42A9BEDA50@BYAPR03MB3624.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(39850400004)(136003)(376002)(189003)(199004)(7736002)(26005)(386003)(6506007)(5660300002)(6916009)(86362001)(6436002)(6486002)(478600001)(53936002)(229853002)(4326008)(50226002)(54906003)(8936002)(52116002)(81166006)(8676002)(76176011)(2906002)(99286004)(81156014)(305945005)(25786009)(7416002)(102836004)(316002)(6246003)(476003)(14444005)(6116002)(11346002)(446003)(64756008)(66946007)(66476007)(486006)(256004)(66556008)(186003)(3846002)(66446008)(66066001)(1076003)(14454004)(6512007)(9686003)(71190400001)(71200400001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3624;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cCdIEPXcWL/I/RaCRgBfDcedl/gErQmE8cgbu3UlsSLqd44O2YJAClmSzs6iksqjrw4hjo0LQHg+N1Lc/p8WjGlf2WILgLMqCIP67ggeGAKG57HngLD0PIKiXGpbWUWkHg0jzkM68iE6p09+HUf9Ss3w+FaNS3qp1CyWaM1vYUR8C2OOb0yA7ZCKqsukj5T8Q6xTk1LYvg5WLYXRvlf0g5jKqy2MEH7p9trbOldD6hkgmbJ7q5hwg13M+kwL3CLWlIvbOVatZDHRpZSKaNimtUjyllQVjr7qZFMBPNpQY3m/yEOqaIDaghnCfhFAifQT2VZ7v/Qr0QiE9VjVwYds98+CU/GKN8tSOgkiAlAj0x3JSNzDi4dla69pEyplcXiPjRoVZr3vi2b+sZDz42u5EpM2tjARDgymebfiDCSVOm0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <52D37053CF07584DA4A594C3BC219B1F@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e8b1e9-091b-4078-a527-08d726eda66e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 10:44:03.9547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zQ6hrPj454XE+NovC32VY3InAbwBh1VtPPr9pterPmeuhKdmgLWhpDDFOyPsld4BJITjjUNEDW3xJio9SBpcPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3624
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Aug 2019 15:52:05 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

>=20
>=20
> Jisheng Zhang wrote:
> > Hi,
> >
> > On Thu, 22 Aug 2019 12:23:58 +0530
> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote: =20
> >> Jisheng Zhang wrote: =20
> ...
> >> > +/* Ftrace callback handler for kprobes -- called under preepmt
> >> > disabed */
> >> > +void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_i=
p,
> >> > +                        struct ftrace_ops *ops, struct pt_regs *reg=
s)
> >> > +{
> >> > +     struct kprobe *p;
> >> > +     struct kprobe_ctlblk *kcb;
> >> > +
> >> > +     /* Preempt is disabled by ftrace */
> >> > +     p =3D get_kprobe((kprobe_opcode_t *)ip);
> >> > +     if (unlikely(!p) || kprobe_disabled(p))
> >> > +             return;
> >> > +
> >> > +     kcb =3D get_kprobe_ctlblk();
> >> > +     if (kprobe_running()) {
> >> > +             kprobes_inc_nmissed_count(p);
> >> > +     } else {
> >> > +             unsigned long orig_ip =3D instruction_pointer(regs);
> >> > +             /* Kprobe handler expects regs->pc =3D pc + 4 as break=
point hit */
> >> > +             instruction_pointer_set(regs, ip + sizeof(kprobe_opcod=
e_t)); =20
> >>
> >> Just want to make sure that you've confirmed that this is what happens
> >> with a regular trap/brk based kprobe on ARM64. The reason for setting
> >> the instruction pointer here is to ensure that it is set to the same
> >> value as would be set if there was a trap/brk instruction at the ftrac=
e
> >> location. This ensures that the kprobe pre handler sees the same value
> >> regardless. =20
> >
> > Due to the arm64's DYNAMIC_FTRACE_WITH_REGS implementation, the code it=
self
> > is correct. But this doesn't look like "there was a trap instruction at
> > the ftrace location".
> >
> > W/O KPROBE_ON_FTRACE:
> >
> > foo:
> > 00    insA
> > 04    insB
> > 08    insC
> >
> > kprobe's pre_handler() will see pc points to 00. =20
>=20
> In this case, the probe will be placed at foo+0x00, so pre_handler()
> seeing that address in pt_regs is correct behavior - as long as arm64
> 'brk' instruction causes an exception with the instruction pointer set

Yep, confirmed with regular trap/brk based kprobes, I do see PC set to
the "brk" instruction.

> *to* the 'brk' instruction. This is similar to how powerpc 'trap' works.
> However, x86 'int3' causes an exception *after* execution of the
> instruction.

Got it. I understand where's the comment "expects regs->pc =3D pc + 1" from=
.

>=20
> >
> > W/ KPROBE_ON_FTRACE:
> >
> > foo:
> > 00    lr saver
> > 04    nop     // will be modified to ftrace call ins when KPROBE is arm=
ed
> > 08    insA
> > 0c    insB =20
>=20
> In this case, if user asks for a probe to be placed at 'foo', we will
> choose foo+0x04 and from that point on, the behavior should reflect that
> a kprobe was placed at foo+0x04. In particular, the pre_handler() should
> see foo+0x04 in pt_regs. The post_handler() would then see foo+0x08.
>=20
> >
> > later, kprobe_ftrace_handler() will see pc points to 04, so pc + 4 will
> > point to 08 the same as the one w/o KPROBE_ON_FTRACE. =20
>=20
> I didn't mean to compare regular trap/brk based kprobes with
> KPROBES_ON_FTRACE. The only important aspect is that the handlers see
> consistent pt_regs in both cases, depending on where the kprobe was
> placed. Choosing a different address/offset to place a kprobe during its
> registration is an orthogonal aspect.

Indeed, previously, I want to let the PC point to the same instruction, it
seems I misunderstood the "consistent" meaning.

>=20
> >
> > It seems I need to fix the comment. =20
>=20
> Given your explanation above, I think you can simply drop the first
> adjustment to the instruction pointer before the pre handler invocation.
> The rest of the code looks fine.
>=20
>=20

Yep, thanks a lot. Will send out a new version soon.
