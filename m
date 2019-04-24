Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7681C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4D0208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="LqEoC4xX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfDXXNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:13:32 -0400
Received: from mail-eopbgr790127.outbound.protection.outlook.com ([40.107.79.127]:21504
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727422AbfDXXNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXKONBKZ87nAvcE66/OhPwFqZgigwu+Kn+Q2awRWUf0=;
 b=LqEoC4xXwV2+pR4ScHgKfmiSBk8X/Mxp6XP/rY8wW5HULZqlnWHxJC+Y00b1Fx0hgnX3M0gID0b2lb6AHrhYtVNk7wqRmtQ78GeffBhyPsIogKvFrha0+BF+ZCJiTFJAmm7vDdNRZQSpC184LyG6iRMq+Nxw6nMhppBJhzGnwF4=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1168.namprd22.prod.outlook.com (10.174.168.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.16; Wed, 24 Apr 2019 23:13:09 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765%7]) with mapi id 15.20.1813.017; Wed, 24 Apr 2019
 23:13:09 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Carlos O'Donell <codonell@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        heiko carstens <heiko.carstens@de.ibm.com>,
        gor <gor@linux.ibm.com>, schwidefsky <schwidefsky@de.ibm.com>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        carlos <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Subject: Re: [PATCH 1/4] glibc: Perform rseq(2) registration at C startup and
 thread creation (v7)
Thread-Topic: [PATCH 1/4] glibc: Perform rseq(2) registration at C startup and
 thread creation (v7)
Thread-Index: 7m11ofhkxzIm+Ccm0xLpdzhlit83GM7rDAkAgAAOc4Dxk0rRpnhaLnMDislr14A=
Date:   Wed, 24 Apr 2019 23:13:08 +0000
Message-ID: <20190424231303.zu2irxd5g3v7yqey@pburton-laptop>
References: <20190212194253.1951-1-mathieu.desnoyers@efficios.com>
 <20190212194253.1951-2-mathieu.desnoyers@efficios.com>
 <5166fbe9-cfe0-8554-abc7-4fc844cf2765@redhat.com>
 <1965431879.7576.1553529272844.JavaMail.zimbra@efficios.com>
 <602718e0-7375-deb7-b6e6-2d17022173c5@redhat.com>
 <20190404214151.6ogrm34dok52az4h@pburton-laptop>
 <1031613720.1496.1555613900993.JavaMail.zimbra@efficios.com>
 <1103046939.521.1556118342613.JavaMail.zimbra@efficios.com>
In-Reply-To: <1103046939.521.1556118342613.JavaMail.zimbra@efficios.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0072.namprd02.prod.outlook.com
 (2603:10b6:a03:54::49) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ccc4024-cb68-4e99-04ab-08d6c90a6a28
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR2201MB1168;
x-ms-traffictypediagnostic: MWHPR2201MB1168:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR2201MB11686734A8338D1470DCF158C13C0@MWHPR2201MB1168.namprd22.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(366004)(346002)(396003)(39850400004)(376002)(189003)(199004)(66556008)(14454004)(11346002)(25786009)(3846002)(486006)(316002)(5660300002)(66446008)(6116002)(44832011)(6246003)(476003)(64756008)(54906003)(386003)(256004)(4326008)(99286004)(52116002)(446003)(76176011)(58126008)(66476007)(73956011)(2906002)(53936002)(68736007)(186003)(26005)(6506007)(66946007)(1076003)(42882007)(102836004)(6306002)(71190400001)(66066001)(33716001)(8936002)(7416002)(8676002)(966005)(93886005)(81156014)(305945005)(6916009)(97736004)(347745004)(7736002)(229853002)(478600001)(81166006)(71200400001)(9686003)(6436002)(6486002)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1168;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GEX1TSbXS+95uEJKcLhMIrevrpHmhG1fRUPGc+E/oZyJ6DtOWsYeMAtji0b77a/Gua+2h4x6IhKJ1gcFP7c8TGKkcYITcfbgrl5Y25JBNxj03D7635+YVD7KipBRcrdYaZkTBej0y7PaDkBHSreLHJEOjl4vK0fSkwHZ7sgw1I4YIKnMWJk0BkzT30e5iHG3vETQ+MpraoN2ojCY95iyDX0ttM1/RxeGaG+MJHVPezbniev0aeRt87RLy9tKiTXKc4HuBah2T02tk+i90MB62/689H8yq47RnT+rrex/4RHsQUG4l0KWnE04H7b5BHWp4EiC/KKkiTu0/LzJzyiLFDFrnS9tMeFCYSP2YTF1B+ILKOxx3H3fUJCHa1ezO/LjFtuPYZbSOcgTu9gzSlg2FaB3eaLr0bWayZvEdjewBhg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0C44D8EEC9D969418C9B37E280694560@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ccc4024-cb68-4e99-04ab-08d6c90a6a28
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 23:13:09.1991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

Just following up on a couple of things here.

On Wed, Apr 24, 2019 at 11:05:42AM -0400, Mathieu Desnoyers wrote:
> >>> 2a. A uncommon TRAP hopefully with some immediate data encoded (maybe=
 uncommon)
> >>=20
> >> Our break instruction has a 19b immediate in nanoMIPS (20b for microMI=
PS
> >> & classic MIPS) so that could be something like:
> >>=20
> >>  break 0x7273       # ASCII 'rs'
> >>=20
> >=20
> > I like this uncommon break instruction as signature choice.
> >=20
> > However, if I try to compile assembler with a break 0x7273 instruction
> > with mips64 and mips32 toolchains (gcc version 8.2.0 (Ubuntu
> > 8.2.0-1ubuntu2~18.04))
> > I get:
> >=20
> > /tmp/ccVh9F7T.s: Assembler messages:
> > /tmp/ccVh9F7T.s:24: Error: operand 1 out of range `break 0x7273'
> >=20
> > It works up to the value 0x3FF, which seems to use the top 10
> > code bits:
> >=20
> >   a:	03ff 0007 	break	0x3ff
> >=20
> > Would a "break 0x350" be a good choice as well ?

The "break 0x350" instruction seems good to me - it's still going to be
rare.

> > Any idea why 0x7273 is not accepted by my assembler ?

I don't know why the assembler wants a smaller immediate than the
instruction encoding allows... There's a comment in the binutils file
include/opcode/mips.h that reads:

> A breakpoint instruction uses OP, CODE and SPEC (10 bits of the
> breakpoint instruction are not defined; Kane says the breakpoint code
> field in BREAK is 20 bits; yet MIPS assemblers and debuggers only use
> ten bits).  An optional two-operand form of break/sdbbp allows the
> lower ten bits to be set too, and MIPS32 and later architectures allow
> 20 bits to be set with a signal operand (using CODE20).

I suspect there's some history here that predates my involvement (or
possibly just predates me).

> > I also tried crafting the assembler with values between 0x3FF and 0x727=
3
> > in the 20 code bits. It seems fine from an objdump perspective:
> >=20
> > ".long 0x03FFFC7\n\t"
> >=20
> > generates:
> >=20
> >  10:	003f ffc7 	break	0x3f,0x3ff
> >=20
> > What I don't understand is why the instruction generated by my
> > toolchain ends with the last 6 bits "000111", whereas the mips32
> > instruction set specifies break as ending with "001101" [1].
> > What am I missing ?

Were you targeting microMIPS by any chance? There the break32
instructions ends with 000111.

> > Also, the nanomips break code [2] has a completely different
> > instruction layout. Should we use a different signature when
> > compiling for nanomips ? What #ifdef should we use ?

Yes, and __nanomips__. I included the encoding in my reply to your RFC
patch.

> > Do I need a special toolchain to generate nanomips binaries ?

Yes, you can find it here:

  https://codescape.mips.com/components/toolchain/nanomips/latest/index.htm=
l

We don't have the nanoMIPS kernel support in mainline yet, I've gotten
various things applied in preparation but also been swamped with other
things so it's taking a while. If you want to see a working downstream
kernel though you can find it here:

  git://git.linux-mips.org/pub/scm/linux-mti.git nanomips-v4.15

> Hi Paul, I'm still waiting for feedback on the MIPS front.
>=20
> Meanwhile, I plan to use #define RSEQ_SIG 0x0350000d which maps to:
>=20
>    0350000d 	break	0x350
>=20
> and use RSEQ_SIG in assembly with:
>=20
>    ".word " __rseq_str(RSEQ_SIG) "\n\t"
>=20
> on big and little endian MIPS, for MIPS32 and MIPS64, based on
> code generated with gcc version 8.2.0 (Ubuntu 8.2.0-1ubuntu2~18.04).
>=20
> Let me know if it needs to be tweaked.

That's fine for the classic MIPS ISA, but won't decode as a break for
microMIPS or nanoMIPS. See my reply to your RFC for valid encodings for
both of those.

Thanks,
    Paul
