Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7AEC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D74F233A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="kgIIwDBi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732309AbfHVJrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 05:47:18 -0400
Received: from mail-eopbgr680040.outbound.protection.outlook.com ([40.107.68.40]:11399
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726262AbfHVJrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 05:47:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRzZsvojYJEzn8t+CEn5CxOkNKZ8LjKVVxHBwRUFf242ZIzRJo/h0XJuzCVkf/1BKaOAz1M7KY1KXA083xChuomhEti2eFvA9tZUC2UtTGBQCekWi97kVIvZfkHdrLpfDEZjaA8zS7oNT+KSXxlg4SDkh61CEwmb7xytwhQUxUlSIPxW5ljI+CehizTgLf0kpz+FwC4Up8W+HakqzELBM4KrBO/qQRvy6vchBE8YyXreACvk5wfSZkDImtvE7SmJ3KGROwgBruZY9WqPJOSg5TzonVJkUX0EenRLeohM14/6hrYiLXlZxoerzfrJHO01tE5IRO5eVBWPMzKAXCOgww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuJB/D9ZAYIC4/U+5sFDlnKf5jFkhlANnyJd94ODdTk=;
 b=QnCdQA2H0PTTXWU6ApcEWCEGndBd5KpfXstX8fGgHyEiEN4ox6jDpK0RLRaDAdEh0X0avG6fLZwVYQ4IQk8IKMYwSv8D7qqTmPTVDEEUlSXWJJgOUXl6TSOKpC2oxJ+XwqZxz5FPcIJZFBUu0NkBcZF1TZs4aVqhZzxRSIYVIzOmmxOrMIjhK0KWDDCQ+rHsl3RWaCzYa/k4lAcri/4xf/hHPwRC9IVBBXMqZz4Tvyp05oOnMpqOVWM76kvy7mfLY79A/dWp4w4p8soCGo1N7f0QMvp/LT8O/4KiKU8r23rl48SmqtDn+zu6MbpUl/iBV+Ak8QDq/gJHRhGsQpN1tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuJB/D9ZAYIC4/U+5sFDlnKf5jFkhlANnyJd94ODdTk=;
 b=kgIIwDBioO3eIZVV20lcuSHjZ8h93L4BmJrRr/2aYrJDOcQudSjhK7OqOVck94GRdFbKLVv5CscINFHgvhiCb5G/NpuAXLfvDctLTwZcX5wVk3bKCXMR+PhlN8oIIWoFqd2UGJbIAggmSeSthSU9OwIv4WSZlkIhrBdxnrilC0Q=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB3606.namprd03.prod.outlook.com (52.135.213.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 22 Aug 2019 09:47:13 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4%7]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 09:47:13 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Will Deacon <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4] arm64: implement KPROBES_ON_FTRACE
Thread-Topic: [PATCH v4] arm64: implement KPROBES_ON_FTRACE
Thread-Index: AQHVWJwGDRorz/HiOUajlPa5ER0qaKcGu4YAgAAtQwA=
Date:   Thu, 22 Aug 2019 09:47:13 +0000
Message-ID: <20190822173558.63de3fc4@xhacker.debian>
References: <20190822113421.52920377@xhacker.debian>
        <1566456155.27ojwy97ss.naveen@linux.ibm.com>
In-Reply-To: <1566456155.27ojwy97ss.naveen@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY1PR01CA0162.jpnprd01.prod.outlook.com (2603:1096:402::14)
 To BYAPR03MB4773.namprd03.prod.outlook.com (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c86dcc4b-a5c5-4285-68ac-08d726e5b5b1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR03MB3606;
x-ms-traffictypediagnostic: BYAPR03MB3606:
x-microsoft-antispam-prvs: <BYAPR03MB36062B8D1A079519B6A4C197EDA50@BYAPR03MB3606.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(346002)(366004)(136003)(396003)(376002)(189003)(199004)(478600001)(14454004)(50226002)(7416002)(3846002)(6116002)(446003)(26005)(4326008)(186003)(25786009)(66446008)(66476007)(64756008)(66556008)(52116002)(66946007)(305945005)(6916009)(6246003)(53936002)(7736002)(102836004)(11346002)(486006)(229853002)(99286004)(386003)(6506007)(476003)(316002)(2906002)(71190400001)(1076003)(5660300002)(14444005)(256004)(86362001)(6436002)(76176011)(8936002)(6486002)(6512007)(81156014)(8676002)(54906003)(9686003)(66066001)(71200400001)(81166006)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3606;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zGFL02ylg/+6vR4i9eNdVgXqglW/BIazKBhUfaMMdOSgWj8qVy9fNpvAGWBoUcpxG8oerVsS9MhPulojauKXtJLBMzGGcvst7p9txzVcBogFm3xXCJT/R0pn3UT9DJLbAh3dMxbogRk8OJdLhIWexi92ljStuBMqvCePZ9OKyfeZfOzbAEQc4YjV9VimaG9hCdcdepjtUODWPOhlxFqaySLPtZ1WMUQ3NOSv7MeeELklbHtaDA1n/gFXqluAAezefWeS03Jbw2+J26YKEuPJxu2BGyMvXKgq/F53tF7fsro2ko93HjTdWA9DHaE9XQEfZcahYrmL0t8c3G9i0zQPQJY2OFyyy+n6iLmp4kTpovrZYGFXI/nOszWt94HAYAbydLuhv85EHCfVyV/6TETPSGzx4WarVsQCK+nrhGEkYh4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D08A975643B7AC41B1D6B870A7F5FB7F@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c86dcc4b-a5c5-4285-68ac-08d726e5b5b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 09:47:13.6052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yp5GDMiuRrrS/I+HNgk5dsoW/+ONKEWylN1dgay/RVs1F1n/azXaBXOWCjVh8s7bGJo/bFl7m9oJsU2Dcnn65A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3606
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 22 Aug 2019 12:23:58 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:


>=20
>=20
> Jisheng Zhang wrote:
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
> > ffffff801009ff54  k  _do_fork+0x4    [DISABLED][FTRACE]
> >
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com> =20
>=20
> This looks good to me. Except for a small confirmation below:
> Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>=20
>=20

<...>

> > +/* Ftrace callback handler for kprobes -- called under preepmt disabed=
 */
> > +void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
> > +                        struct ftrace_ops *ops, struct pt_regs *regs)
> > +{
> > +     struct kprobe *p;
> > +     struct kprobe_ctlblk *kcb;
> > +
> > +     /* Preempt is disabled by ftrace */
> > +     p =3D get_kprobe((kprobe_opcode_t *)ip);
> > +     if (unlikely(!p) || kprobe_disabled(p))
> > +             return;
> > +
> > +     kcb =3D get_kprobe_ctlblk();
> > +     if (kprobe_running()) {
> > +             kprobes_inc_nmissed_count(p);
> > +     } else {
> > +             unsigned long orig_ip =3D instruction_pointer(regs);
> > +             /* Kprobe handler expects regs->pc =3D pc + 4 as breakpoi=
nt hit */
> > +             instruction_pointer_set(regs, ip + sizeof(kprobe_opcode_t=
)); =20
>=20
> Just want to make sure that you've confirmed that this is what happens
> with a regular trap/brk based kprobe on ARM64. The reason for setting
> the instruction pointer here is to ensure that it is set to the same
> value as would be set if there was a trap/brk instruction at the ftrace
> location. This ensures that the kprobe pre handler sees the same value
> regardless.

Due to the arm64's DYNAMIC_FTRACE_WITH_REGS implementation, the code itself
is correct. But this doesn't look like "there was a trap instruction at
the ftrace location".

W/O KPROBE_ON_FTRACE:

foo:
00	insA
04	insB
08	insC

kprobe's pre_handler() will see pc points to 00.

W/ KPROBE_ON_FTRACE:

foo:
00	lr saver
04	nop     // will be modified to ftrace call ins when KPROBE is armed
08	insA
0c	insB

later, kprobe_ftrace_handler() will see pc points to 04, so pc + 4 will
point to 08 the same as the one w/o KPROBE_ON_FTRACE.

It seems I need to fix the comment.

>=20
> Further changes to the instruction pointer are to achieve the same
> effect for kprobe post handlers.
>=20
>=20

