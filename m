Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F038C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 09:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4547320730
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 09:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="DD4rNfM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfLYJBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 04:01:11 -0500
Received: from mail-dm6nam10on2070.outbound.protection.outlook.com ([40.107.93.70]:37985
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726025AbfLYJBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 04:01:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3zxawMjH5WUMAWk4rOK77/AgMzNVY3UtomXXL6kHRFCe2HMADr4aj2oJUzuKW9pZvZj0xqPyIOYpQ6kbJy0bcKUYL+DJ7GdwOLSUYYBttmHvnTtZ5t7ZoGoH+DxXp4Zntox2W5gPkGJS8cK3g0KYkBP2UahLa4Hgh8nG4fYdw2FsYMukmavPvYgj7z1SbtgsgV5HVZPekxi/4mxGR7ea5wgmsvxOMnnvOmeogxWgq35IxdAYtYwybmV3FXYqw+rntFe2KlNsia7HvF7iZdAnBx/hhtmwIHIIffDOJ44F4xfD61qPamzODlcuN5lFGOmpnuVCwkmZspKk73e/Rin/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIecDeN/1pWOYcMjD0Ti9hcdfLByd5i2Vb3hLaDsifM=;
 b=Qa14SQyxchx0Sr/UnksOPm67gb69hYBqZGDmzpm3YvdQcvGcHW8sxY9qZogbzrXthJGsjvrrL11Z96ghQd/ZVsXUsHMi6TVIaAyt9zg7d/6CDhSojIsMbeeT2/1ZD/7RJ+w0sDjFxuGIEYzMdQZCTcF272dJUF8oWEO6MHL6p8BEO1FTS0BxBfKZ9UlOJRJFR7WCVsY3fwa7o3wMG2oWJhxSAntUSsDJCeXDFHatFKzV59Pah4o8T+BgrwFGlBkNFV4W3wrRuEBM1/yIl5pPx0RHEE0/ehYuWti1RYS/1JB++dhW7BfsiG01Abv+ds0rYJXOxoHSP1GkVH3jCMYLjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIecDeN/1pWOYcMjD0Ti9hcdfLByd5i2Vb3hLaDsifM=;
 b=DD4rNfM4uMyJEfF4S+yx6coigPu42cB9/LdWq6eUxVLCCovPhvJQv+/j+21G0oMg/0RRS9bcXN4HD4NRwlZZrs0s8uUNpBYHG63VkVDBPxUt41EAkyMI4Ksc1616C6C4EkmPq3kMeGM0IqKX3hwWdbsOjK6r7MkjuoiHGJvgV4g=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.93.213) by
 BYAPR03MB4278.namprd03.prod.outlook.com (20.177.127.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.17; Wed, 25 Dec 2019 09:01:06 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::708d:91cc:79a7:9b9a]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::708d:91cc:79a7:9b9a%6]) with mapi id 15.20.2559.017; Wed, 25 Dec 2019
 09:01:06 +0000
Received: from xhacker.debian (124.74.246.114) by TY2PR01CA0028.jpnprd01.prod.outlook.com (2603:1096:404:ce::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend Transport; Wed, 25 Dec 2019 09:01:03 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6] arm64: implement KPROBES_ON_FTRACE
Thread-Topic: [PATCH v6] arm64: implement KPROBES_ON_FTRACE
Thread-Index: AQHVtWtmR90OKS0v9Um1jpVbBvlnOKe/4n0AgAd5EwCAAb3+AIABe0eA
Date:   Wed, 25 Dec 2019 09:01:06 +0000
Message-ID: <20191225164605.559f4dbb@xhacker.debian>
References: <20191218140622.57bbaca5@xhacker.debian>
        <20191218222550.51f0b681de7bbab7e49b09a9@kernel.org>
        <20191223153300.30281a93@xhacker.debian>
        <20191224190916.2e47478445fb179e88f60cc3@kernel.org>
In-Reply-To: <20191224190916.2e47478445fb179e88f60cc3@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY2PR01CA0028.jpnprd01.prod.outlook.com
 (2603:1096:404:ce::16) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:139::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3190c22f-5e51-4595-9ff9-08d78918f9bf
x-ms-traffictypediagnostic: BYAPR03MB4278:
x-microsoft-antispam-prvs: <BYAPR03MB42786C688987A901EC0F7F25ED280@BYAPR03MB4278.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02622CEF0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(396003)(39850400004)(136003)(189003)(199004)(16526019)(316002)(7696005)(8936002)(6916009)(8676002)(81166006)(81156014)(4326008)(2906002)(52116002)(966005)(26005)(478600001)(186003)(6506007)(1076003)(71200400001)(86362001)(7416002)(66476007)(54906003)(66556008)(64756008)(66946007)(66446008)(956004)(5660300002)(55016002)(9686003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4278;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MCw5fNyw2XrMJdMFiNRXKqbOSyU2XQDo31OaBjTD9R8lRMHirl3mWJeeyXshvImx+bOXiRNhwwb05xLpAZFM0fxYh7zBB49yN1YMwmgSDlHtV9i9g1SDmADgZnIsHd8t7EZD6rUVWCoSt5B0oAqUKZPJNRwacytmNJXghbyT3KVzcH8phqmKD0/P+P+pXYy8YluXJ5Maw0HymXL4L6XFZwudpdAeTpddRXpcQ7FXxrkXhRL4ETfS/5Jec6hn7/eIoOu1hpi+yWD8om2OsOznqTEb4yp0WYXIcrF30THFM5QbY2upwr9z4OukFrkn7OdYFs4LdM77efFIY0226JQ28ptWsqRoTB5XREWiQKTsALVuon7CO0LbWTjS4vWFhhjXmUyE2zOd29gUH4bqKu/JP/PLsCZp48vsnIWBK0IlHt5OXx5I5deyxW5CBtETzkTB/A9echxXlFbxmO2DQYceQi2Vq0ZCSXzxP6KDJH0R7pYG4xL6QUuA77Qs0uTSpLm96IXX2DgVCyYjDoQ7qSVV7n+dfLLSEqLSDyRROtwT5Kg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <61DF09A3DC40AB469F1A241979E79A4C@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3190c22f-5e51-4595-9ff9-08d78918f9bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2019 09:01:06.1678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rAxMDH+oyLe/tLmWQhFMva7yIrmANLaEpD0c9qjsYDqyk6pJEQf+mdj9t7PNnZtO9hAv7UDlV7Gh7SpYyTHNtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4278
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 24 Dec 2019 19:09:16 +0900 Masami Hiramatsu wrote:

>=20
> Hi Jisheng,
>=20
> On Mon, 23 Dec 2019 07:47:24 +0000
> Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
>=20
> > Hi Masami,
> >
> > On Wed, 18 Dec 2019 22:25:50 +0900 Masami Hiramatsu wrote:
> >
> > =20
> > >
> > >
> > > On Wed, 18 Dec 2019 06:21:35 +0000
> > > Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
> > > =20
> > > > KPROBES_ON_FTRACE avoids much of the overhead with regular kprobes =
as it
> > > > eliminates the need for a trap, as well as the need to emulate or
> > > > single-step instructions.
> > > >
> > > > Tested on berlin arm64 platform.
> > > >
> > > > ~ # mount -t debugfs debugfs /sys/kernel/debug/
> > > > ~ # cd /sys/kernel/debug/
> > > > /sys/kernel/debug # echo 'p _do_fork' > tracing/kprobe_events
> > > >
> > > > before the patch:
> > > >
> > > > /sys/kernel/debug # cat kprobes/list
> > > > ffffff801009fe28  k  _do_fork+0x0    [DISABLED]
> > > >
> > > > after the patch:
> > > >
> > > > /sys/kernel/debug # cat kprobes/list
> > > > ffffff801009ff54  k  _do_fork+0x4    [DISABLED][FTRACE] =20
> > >
> > > BTW, it seems this automatically changes the offset without
> > > user's intention or any warnings. How would you manage if the user
> > > pass a new probe on _do_fork+0x4? =20
> >
> > In current implementation, two probes at the same address _do_fork+0x4 =
=20
>=20
> OK, that is my point.
>=20
> > > IOW, it is still the question who really wants to probe on
> > > the _do_fork+"0", if kprobes modifies it automatically,
> > > no one can do that anymore.
> > > This can be happen if the user want to record LR or SP value
> > > at the function call for debug. If kprobe always modifies it,
> > > we will lose the way to do it. =20
> >
> > arm64's DYNAMIC_FTRACE_WITH_REGS implementation makes use of GCC
> > -fpatchable-function-entry=3D2 option to insert two nops. When the func=
tion
> > is traced, the first nop will be modified to the LR saver, then the
> > second nop to "bl <ftrace-entry>", commit 3b23e4991fb6("
> > arm64: implement ftrace with regs") explains the mechanism. =20
>=20
> So both of the instruction at func+0 and func+4 are replaced.
>=20
> > So on arm64(in fact any arch makes use of -fpatchable-function-entry wi=
ll
> > behave similarly), when DYNAMIC_FTRACE_WITH_REGS is enabled, the ftrace=
 location
> > is always on the first 4 bytes offset.
> >
> > I think when users want to register a kprobe on _do_fork+0, what he rea=
lly want
> > is to kprobe on the patched(by -fpatchable-function-entry)_do_fork+4 =20
>=20
> OK, in this case, kprobe should treat the first 2 instructions as a
> single virtual instruction. This means,
>=20
>  - kprobes can probe func+0, but not func+4 if the function is ftraced.
>     (-EILSEQ must be returned)
>  - both debugfs/kprobes/list and tracefs/kprobe_events should show the
>    probed address as func+0. Not func+4.
>=20
> Then, user can use kprobes as if there is one big (8-byte) instruction
> at the entry of the function. Since probing on func+4 is rejected and
> the call-site LR/SP is restored in ftrace, there should be no
> contradiction. It should work as if we put a breakpoint on the func + 0.

From https://lkml.org/lkml/2019/6/18/648, Naveen tried to allow probing on
any ftrace address, is it acceptable on arm64 as well? I will post patches
for this purpose.

Thanks for your review
