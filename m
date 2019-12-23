Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28351C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 07:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DD520715
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 07:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="mbnu5DNJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfLWHra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 02:47:30 -0500
Received: from mail-co1nam11on2077.outbound.protection.outlook.com ([40.107.220.77]:30298
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725810AbfLWHr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 02:47:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLY0YR9dDmBzinVrJgOkn9h0KeHS8LADtEktrguxaSlYh2Sq5U+8SH7z+i1Jf6YKOdnzYFolgWz7+fMKiiG4OhqbdSxFC+qDkAsffJg4fMlKw5NnHZ3xcMuqEav7I6+ZCRvGrVa+mlszRhgTOhytQsUUyuSpqUnewcs70DnqbzSZKEEtGpSCbQaL5PEufEFelMUHuVNRO7kHvjoZi42IgUo7hfr99SCWhCJpWxlJjmXvkNah1PGDBNoykrUIueKjVPdNNIyLUXzHMTZuEkzn7UU4Ci+PqgNMLdGYwf/OIucvZiu4GKJorH964iMIbT37kXp0QfRmMKHhiGkf6l9RXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFZ+yHTzxUP8mj/+IL2h+KJ4b9puH8VFYCGaiyGVFIM=;
 b=gFNG7q1SIob7xto8piFAzwmqnmBKfgiDaosIzxs01hLaaGcwNko05f07KrKmQoeXwL25hPuoUjig/oSGgoFWYBrdw/at6+2g7o5B4eXT7Hw5ichLqB46gaM3mx4spO+XFgP4Nhk5667P/T0JgcHYcgQqsC1u4+UJcsONdZKd7FEWJH2ZHCzoaLwOzgkkKuJPOlSw3lYrFCYE1iUvDW7YcG36PjuPbWkMBhj2+Ic5mJXzrlqNNCviWEDYsxEAt8o7oeOcx19/Zy8CVj5kz/hsNKa0SnRFoCQ/4n55QdeJHMLBPKASCyuelL99VXzCCoj5dc69SwR9qpB5tGkXnYQskQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFZ+yHTzxUP8mj/+IL2h+KJ4b9puH8VFYCGaiyGVFIM=;
 b=mbnu5DNJiXczcQ/AuV0g5/36sqWxpBpX+ghT7DpWaZyTsESU8X333JWeiSZvvUX6qVEkBPk3PoirtVy8TGAz66QzUt/r3d4/HMqR7WjBdk5zxcrX9gdCydBys6gwK+12Ipds+iqbN55/je6wI1t8MIdmHk3N+DO0bSQjCFJLrQc=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.93.213) by
 BYAPR03MB4584.namprd03.prod.outlook.com (20.178.52.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Mon, 23 Dec 2019 07:47:24 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::708d:91cc:79a7:9b9a]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::708d:91cc:79a7:9b9a%6]) with mapi id 15.20.2559.017; Mon, 23 Dec 2019
 07:47:24 +0000
Received: from xhacker.debian (124.74.246.114) by TYAPR01CA0220.jpnprd01.prod.outlook.com (2603:1096:404:11e::16) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Mon, 23 Dec 2019 07:47:21 +0000
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
Thread-Index: AQHVtWtmR90OKS0v9Um1jpVbBvlnOKe/4n0AgAd5EwA=
Date:   Mon, 23 Dec 2019 07:47:24 +0000
Message-ID: <20191223153300.30281a93@xhacker.debian>
References: <20191218140622.57bbaca5@xhacker.debian>
        <20191218222550.51f0b681de7bbab7e49b09a9@kernel.org>
In-Reply-To: <20191218222550.51f0b681de7bbab7e49b09a9@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR01CA0220.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::16) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:139::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f446b039-bbc4-4ca6-12f0-08d7877c5936
x-ms-traffictypediagnostic: BYAPR03MB4584:
x-microsoft-antispam-prvs: <BYAPR03MB45844924DD7ACA1513C7862FED2E0@BYAPR03MB4584.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0260457E99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(396003)(366004)(136003)(376002)(346002)(189003)(199004)(5660300002)(54906003)(86362001)(9686003)(2906002)(1076003)(55016002)(6916009)(52116002)(7696005)(316002)(66476007)(66556008)(66946007)(64756008)(26005)(7416002)(186003)(16526019)(66446008)(8676002)(81156014)(6506007)(956004)(81166006)(4326008)(71200400001)(8936002)(478600001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4584;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hrBZmR7sP67IUr0bsc+LhAKPTjD7woPxbafQ9ce6F3EU3tgndPGXtZBwwb96qMmdkR4d++/EQ6hasJNdLC+Qhb3ZkvgtEoPxrJVzj6q+6LJ7HtBG/S0VTrJGYcMa8nQSRJmmU50CzFCxZ+NES4t/jw9cuF2udFK6+q60ibn+ujgpOAC7MjlRukjd4Lv53Br2KsVS5qvKWNkEaJNZILIxu/G7FCMFXVFNGQF6fcszGjApyq35wQv2npFejnKqmALWTtJvbrm+VSZLbOxLlXIc2lRXNclSJV4FdNn4Y1v5tvMKqM8PjYqnyendlHvMhQjKCrT7i+8vXz95zX/zpe5vP/pukjdx9xCY8itg2NT1mfLKaEbpac1ldnfo0xNpz+niLaepmDHCCJ8eFwhY2kGvAD4T79U5thPzFNHs+QdRJsHY3mIC/NVZEh1qY3zmqKPO4SSQQ7zKMwTBfQWIsO0SnddyHrMUjRcgqaasbqb4i/xTWU6g1uRYjoQ3VO+HvwZg
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3A361DDF74E5F848BA8CA005812464A1@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f446b039-bbc4-4ca6-12f0-08d7877c5936
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2019 07:47:24.1743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EPI63Rh0MhmDGfTtYWz9i8oIGWabR1NHsL6Ro4AiSLeIKhjMJ3YCBZpWdKIZNkKXnMePbJK8Nr9RXXM5AbucMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4584
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Wed, 18 Dec 2019 22:25:50 +0900 Masami Hiramatsu wrote:


>=20
>=20
> On Wed, 18 Dec 2019 06:21:35 +0000
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
> > ffffff801009ff54  k  _do_fork+0x4    [DISABLED][FTRACE] =20
>=20
> BTW, it seems this automatically changes the offset without
> user's intention or any warnings. How would you manage if the user
> pass a new probe on _do_fork+0x4?

In current implementation, two probes at the same address _do_fork+0x4

>=20
> IOW, it is still the question who really wants to probe on
> the _do_fork+"0", if kprobes modifies it automatically,
> no one can do that anymore.
> This can be happen if the user want to record LR or SP value
> at the function call for debug. If kprobe always modifies it,
> we will lose the way to do it.

arm64's DYNAMIC_FTRACE_WITH_REGS implementation makes use of GCC
-fpatchable-function-entry=3D2 option to insert two nops. When the function
is traced, the first nop will be modified to the LR saver, then the
second nop to "bl <ftrace-entry>", commit 3b23e4991fb6("
arm64: implement ftrace with regs") explains the mechanism.

So on arm64(in fact any arch makes use of -fpatchable-function-entry will
behave similarly), when DYNAMIC_FTRACE_WITH_REGS is enabled, the ftrace loc=
ation
is always on the first 4 bytes offset.

I think when users want to register a kprobe on _do_fork+0, what he really =
want
is to kprobe on the patched(by -fpatchable-function-entry)_do_fork+4

PS: per my understanding, powerpc's kprobes_on_ftrace also introduces an
extra automatic offset due to its implementation.

>=20
> Could you remove below function at this moment?
>=20
> > +kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int off=
set)
> > +{
> > +     unsigned long addr =3D kallsyms_lookup_name(name);
> > +
> > +     if (addr && !offset) {
> > +             unsigned long faddr;
> > +             /*
> > +              * with -fpatchable-function-entry=3D2, the first 4 bytes=
 is the
> > +              * LR saver, then the actual call insn. So ftrace locatio=
n is
> > +              * always on the first 4 bytes offset.
> > +              */
> > +             faddr =3D ftrace_location_range(addr,
> > +                                           addr + AARCH64_INSN_SIZE);
> > +             if (faddr)
> > +                     return (kprobe_opcode_t *)faddr;
> > +     }
> > +     return (kprobe_opcode_t *)addr;
> > +}
> > +
> > +bool arch_kprobe_on_func_entry(unsigned long offset)
> > +{
> > +     return offset <=3D AARCH64_INSN_SIZE;
> > +} =20
>=20
>=20
> Without this automatic change, we still can change the offset
> in upper layer.

If remove the two functions, kprobe on  _do_fork can't ride on
ftrace infrastructure, but kprobe on _do_fork+4 can. I'm not sure
whether this is reasonable. Every kprobe users on arm64 will need to
remember to pass an extra offset +4 to make use of kprobe_on_ftrace, could
we hide the "+4"?

Thanks
