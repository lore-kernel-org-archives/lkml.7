Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A55C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 11:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8846233A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 11:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="VHLAcuJG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388166AbfHVLU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 07:20:28 -0400
Received: from mail-eopbgr790079.outbound.protection.outlook.com ([40.107.79.79]:55840
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728042AbfHVLU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 07:20:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSie2yFhrKxsQBS82un72NyjFtjsfTXQLDw7BJCUOxB53AbuXPtG6XJVmMGdieiZHLlLgF5RsHkhcX0hLsjmWsP0Mgow7RaXZn1N3yVSnftpGJ9WUVL0TI1rD9W/v4XYef5+UAAYfKr8o4qfwa8couVhSTRqg5lHbqfqwOr03IdrAlCd2taV//+m0pO6pL8IQRrLeVNMc9zVZpwYRtiTqGitQEYTzguNRR6Mx42CTLQqX61RS1Sh89HPsc2REb0T2UqrOi8bkRU9eSbD4668+YpNWUQOGf3CvD2W0LCPBZILUXaMlCYQan5s8aSRGB1ljujxZcHG3zPd+vb+TM0VwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbThQbwCwAYLzzSN79xzBe2aE4WPn9IHTeZqK5S7LpY=;
 b=D4WFA7q3SM6Wryip8GLcvr6yq/XvgjyHbuQP44OFYNHDnRgZWGm6hunvsl50nEmMfrn82yrIakEeVAR3YSVY+GDT0vnpAxPxQgl182qiyopD6QXLV0yjy85zbfmG8soY3Obnno592DNXb8RzI3nlVKKKb8vgxyAT3vbCue/sXWNYWO2xRPutip2hONbjIfY1S4kkp+yKaDw0X6xLgkBgfYNNreJZs2So7yCaYNopuPP9CldyBKByBiHxZSlhcwktY5oV4CjUj75UGXsnJrqyaD+IQPdTSiS3WYQ/wpR5hpOhKQ51ifcVArtSCXlsKlvoF4UyECgljSUnjTMwjawZ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbThQbwCwAYLzzSN79xzBe2aE4WPn9IHTeZqK5S7LpY=;
 b=VHLAcuJGPqloTFeGnBz0ZhkpPlgO1C8NbS7YoMNUXNeUy4srl/+58lmOMd/rCpHOR2Egu562xFcIkd4/yKE1Wazuu9w4OdnuNO8UeusBxcOb/S7xy81ZXhqmyKIUwZCUmczujCSmmFVHwPYVwnQ4BJG1tsiCpezjZmtq3S2tiyY=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4055.namprd03.prod.outlook.com (20.177.127.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Thu, 22 Aug 2019 11:20:23 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4%7]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 11:20:23 +0000
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
Thread-Index: AQHVWJwGDRorz/HiOUajlPa5ER0qaKcGu4YAgACzXwD//4bGgIAAiSIA//+EBAA=
Date:   Thu, 22 Aug 2019 11:20:23 +0000
Message-ID: <20190822190908.4077b309@xhacker.debian>
References: <20190822113421.52920377@xhacker.debian>
        <1566456155.27ojwy97ss.naveen@linux.ibm.com>
        <20190822173558.63de3fc4@xhacker.debian>
        <1566468150.x8u1577wgh.naveen@linux.ibm.com>
        <20190822183254.1bb5576d@xhacker.debian>
In-Reply-To: <20190822183254.1bb5576d@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY1PR01CA0175.jpnprd01.prod.outlook.com (2603:1096:402::27)
 To BYAPR03MB4773.namprd03.prod.outlook.com (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a4dc030-9e59-4524-276e-08d726f2b9c1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR03MB4055;
x-ms-traffictypediagnostic: BYAPR03MB4055:
x-microsoft-antispam-prvs: <BYAPR03MB4055001EE3149AC684AD1BAFEDA50@BYAPR03MB4055.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(136003)(396003)(39850400004)(199004)(189003)(66446008)(1076003)(6506007)(25786009)(476003)(8676002)(71200400001)(71190400001)(486006)(81156014)(2906002)(229853002)(66066001)(11346002)(6246003)(66946007)(4326008)(66556008)(3846002)(6116002)(5660300002)(446003)(256004)(6916009)(50226002)(7416002)(86362001)(316002)(6436002)(186003)(66476007)(54906003)(6486002)(14454004)(478600001)(99286004)(76176011)(386003)(8936002)(64756008)(26005)(9686003)(7736002)(102836004)(14444005)(81166006)(6512007)(52116002)(53936002)(305945005)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4055;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 01MPfUdq0be+0+VtMu1OnxL7wFuTBsKMhKxU7OFwQ02p630kS1k4u73SDh83TIsVsV/xGwcqRYbf6Gm4ap8lfQIH5WFmyrwYuG9cL8pql/04rKFqp3v0Kauyx1Td4apbGRTb9jWobbbRVcbY3nCZUI9eK46zrOa79fyXI8FtRISvKehy3f897D9AlkSm8+usIF6bxCVFmVNniU0uh40aXtA1ul6jG28zgYJBTKB0IN/U1mEK30wuJ1rIrR94IgzgKBqcvwRKIOnmqldf1t30E7Hj97Jffo++5AVZJtuIoFVtmTCB1Py2GeSbNYmqP8s0KKcSFi+LweMjcI4K8z3LgQ6ZuRlA7RfcSDkVE1N2vCc0ZW+mmsTu5xJy98omE/dSIoLFrVy8eviSljVX7j7SqN6AUO76pw2NSnsWCGQ//eg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <43A80990B83F7F4A8A9E3E713F4FE368@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4dc030-9e59-4524-276e-08d726f2b9c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 11:20:23.9107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xwLbMzQYeOyNBUzUf+HNif5KGaWFvbRfRCTEnIiiPC2k2fPwiJH3g+ZOCZVhQr1HzSXv6tbP2VbrDne/70jBEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 22 Aug 2019 18:32:54 +0800
Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> On Thu, 22 Aug 2019 15:52:05 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>=20
> >=20
> >=20
> > Jisheng Zhang wrote: =20
> > > Hi,
> > >
> > > On Thu, 22 Aug 2019 12:23:58 +0530
> > > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:   =20
> > >> Jisheng Zhang wrote:   =20
> > ... =20
> > >> > +/* Ftrace callback handler for kprobes -- called under preepmt
> > >> > disabed */
> > >> > +void kprobe_ftrace_handler(unsigned long ip, unsigned long parent=
_ip,
> > >> > +                        struct ftrace_ops *ops, struct pt_regs *r=
egs)
> > >> > +{
> > >> > +     struct kprobe *p;
> > >> > +     struct kprobe_ctlblk *kcb;
> > >> > +
> > >> > +     /* Preempt is disabled by ftrace */
> > >> > +     p =3D get_kprobe((kprobe_opcode_t *)ip);
> > >> > +     if (unlikely(!p) || kprobe_disabled(p))
> > >> > +             return;
> > >> > +
> > >> > +     kcb =3D get_kprobe_ctlblk();
> > >> > +     if (kprobe_running()) {
> > >> > +             kprobes_inc_nmissed_count(p);
> > >> > +     } else {
> > >> > +             unsigned long orig_ip =3D instruction_pointer(regs);
> > >> > +             /* Kprobe handler expects regs->pc =3D pc + 4 as bre=
akpoint hit */
> > >> > +             instruction_pointer_set(regs, ip + sizeof(kprobe_opc=
ode_t));   =20
> > >>
> > >> Just want to make sure that you've confirmed that this is what happe=
ns
> > >> with a regular trap/brk based kprobe on ARM64. The reason for settin=
g
> > >> the instruction pointer here is to ensure that it is set to the same
> > >> value as would be set if there was a trap/brk instruction at the ftr=
ace
> > >> location. This ensures that the kprobe pre handler sees the same val=
ue
> > >> regardless.   =20
> > >
> > > Due to the arm64's DYNAMIC_FTRACE_WITH_REGS implementation, the code =
itself
> > > is correct. But this doesn't look like "there was a trap instruction =
at
> > > the ftrace location".
> > >
> > > W/O KPROBE_ON_FTRACE:
> > >
> > > foo:
> > > 00    insA
> > > 04    insB
> > > 08    insC
> > >
> > > kprobe's pre_handler() will see pc points to 00.   =20
> >=20
> > In this case, the probe will be placed at foo+0x00, so pre_handler()
> > seeing that address in pt_regs is correct behavior - as long as arm64
> > 'brk' instruction causes an exception with the instruction pointer set =
=20
>=20
> Yep, confirmed with regular trap/brk based kprobes, I do see PC set to
> the "brk" instruction.
>=20
> > *to* the 'brk' instruction. This is similar to how powerpc 'trap' works=
.
> > However, x86 'int3' causes an exception *after* execution of the
> > instruction. =20
>=20
> Got it. I understand where's the comment "expects regs->pc =3D pc + 1" fr=
om.
>=20
> >  =20
> > >
> > > W/ KPROBE_ON_FTRACE:
> > >
> > > foo:
> > > 00    lr saver
> > > 04    nop     // will be modified to ftrace call ins when KPROBE is a=
rmed
> > > 08    insA
> > > 0c    insB   =20
> >=20
> > In this case, if user asks for a probe to be placed at 'foo', we will
> > choose foo+0x04 and from that point on, the behavior should reflect tha=
t
> > a kprobe was placed at foo+0x04. In particular, the pre_handler() shoul=
d
> > see foo+0x04 in pt_regs. The post_handler() would then see foo+0x08.
> >  =20
> > >
> > > later, kprobe_ftrace_handler() will see pc points to 04, so pc + 4 wi=
ll
> > > point to 08 the same as the one w/o KPROBE_ON_FTRACE.   =20
> >=20
> > I didn't mean to compare regular trap/brk based kprobes with
> > KPROBES_ON_FTRACE. The only important aspect is that the handlers see
> > consistent pt_regs in both cases, depending on where the kprobe was
> > placed. Choosing a different address/offset to place a kprobe during it=
s
> > registration is an orthogonal aspect. =20
>=20
> Indeed, previously, I want to let the PC point to the same instruction, i=
t
> seems I misunderstood the "consistent" meaning.
>=20
> >  =20
> > >
> > > It seems I need to fix the comment.   =20
> >=20
> > Given your explanation above, I think you can simply drop the first
> > adjustment to the instruction pointer before the pre handler invocation=
.

Just send out v5. But the first adjustment is modified as
instruction_pointer_set(regs, ip);

Because in entry of kprobe_ftrace_handler() pc/ip(the first parameter) poin=
ts
to foo+0x4, while regs->pc points to foo+0x8. Based on your previous
explanation, I think we should instruction_pointer_set(regs, ip) to let the
pre_handler see foo+0x4

Thanks a lot for your help
