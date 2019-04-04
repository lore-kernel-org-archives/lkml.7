Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5120BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CAC520882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="WzZQTOW6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbfDDVmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 17:42:45 -0400
Received: from mail-eopbgr740135.outbound.protection.outlook.com ([40.107.74.135]:60160
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726418AbfDDVmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 17:42:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmNNhZuGAUUZLg2DU1iPMdeHavsVPjSH4P6ezLGsaJs=;
 b=WzZQTOW62d7GA9iqkIN3e+1B+7OhUphd3OoXW+FpEvtLzcPfxgPMcoK/1TMiACXnjPr5kMl/CjuYUCTEIeaV+Kn0+kgHfHJW70V1s+U37xFj5fdc8aOiNL1HiM+R+babhF79cgPvtcsZH+VGQrJEHtjzkBWleFl62mSO1tTNs9s=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1200.namprd22.prod.outlook.com (10.174.169.163) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.15; Thu, 4 Apr 2019 21:41:58 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765%6]) with mapi id 15.20.1750.017; Thu, 4 Apr 2019
 21:41:58 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Carlos O'Donell <codonell@redhat.com>
CC:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
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
Thread-Index: 7m11ofhkxzIm+Ccm0xLpdzhlit83GM7rDAkAgAAOc4A=
Date:   Thu, 4 Apr 2019 21:41:57 +0000
Message-ID: <20190404214151.6ogrm34dok52az4h@pburton-laptop>
References: <20190212194253.1951-1-mathieu.desnoyers@efficios.com>
 <20190212194253.1951-2-mathieu.desnoyers@efficios.com>
 <5166fbe9-cfe0-8554-abc7-4fc844cf2765@redhat.com>
 <1965431879.7576.1553529272844.JavaMail.zimbra@efficios.com>
 <602718e0-7375-deb7-b6e6-2d17022173c5@redhat.com>
In-Reply-To: <602718e0-7375-deb7-b6e6-2d17022173c5@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::49) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccda7691-28be-4850-9cc5-08d6b9465cb7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR2201MB1200;
x-ms-traffictypediagnostic: MWHPR2201MB1200:
x-microsoft-antispam-prvs: <MWHPR2201MB120064D9B50F66B60F392441C1500@MWHPR2201MB1200.namprd22.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(366004)(39840400004)(396003)(346002)(136003)(199004)(189003)(97736004)(66066001)(486006)(26005)(44832011)(11346002)(446003)(102836004)(7736002)(476003)(42882007)(4326008)(5660300002)(33716001)(14454004)(186003)(478600001)(305945005)(25786009)(2906002)(68736007)(229853002)(52116002)(6116002)(3846002)(58126008)(81166006)(8676002)(8936002)(7416002)(76176011)(316002)(71200400001)(99286004)(54906003)(6916009)(1076003)(71190400001)(106356001)(53936002)(256004)(14444005)(6506007)(386003)(6512007)(9686003)(6486002)(93886005)(105586002)(6246003)(81156014)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1200;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: a1tRiCIysq2KMgWNNZXpXMUkohSIZAKq5g/GHPaqgCcb1Ka1x2lDb5vVw8nIK0mmQlYr25Um54KIofBL/ao1E/XdepfBXeL0bis5iKvFQo7HkjMGLNHvaLwvWQj7wf0aeAa4Eo4HijBR3u0z/2WFMhnwft3p0FfApBiyhRBhu6e2eqvl2kS5RPeyAvU0FSePgIUQ36Om+cEBjCahuFeSZNlNQ8mZWmsnoSki0qIwBxQQzliZXJzkOp3C+dKQWlF7kNcoa+ak4EvY8WjJ3LNUxyJRL3YJc3a/lJEOyH54dd5dHttrhXrIcaDp5zsPtJRUxoPUsLb6dOXWkwki/XUW15E3gw+TSHGSh0RVbcoWihQrx8JJld4+d57p4EX7pDCJmH8XVh6+8ut5gZ6hm7LvoczgIx/LWUFOm6oFWqIrGAw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <47586F22A0E5294EB6EF62269E5C9848@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccda7691-28be-4850-9cc5-08d6b9465cb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 21:41:57.8804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Carlos / all,

On Thu, Apr 04, 2019 at 04:50:08PM -0400, Carlos O'Donell wrote:
> > > > +/* Signature required before each abort handler code.  */
> > > > +#define RSEQ_SIG 0x53053053
> > >=20
> > > Why isn't this a mips-specific op code?
> >=20
> > MIPS also has a literal pool just before the abort handler, and it
> > jumps over it. My understanding is that we can use any signature value
> > we want, and it does not need to be a valid instruction, similarly to A=
RM:
> >=20
> > #define __RSEQ_ASM_DEFINE_ABORT(table_label, label, teardown, \
> >                                  abort_label, version, flags, \
> >                                  start_ip, post_commit_offset, abort_ip=
) \
> >                  ".balign 32\n\t" \
> >                  __rseq_str(table_label) ":\n\t" \
> >                  ".word " __rseq_str(version) ", " __rseq_str(flags) "\=
n\t" \
> >                  LONG " " U32_U64_PAD(__rseq_str(start_ip)) "\n\t" \
> >                  LONG " " U32_U64_PAD(__rseq_str(post_commit_offset)) "=
\n\t" \
> >                  LONG " " U32_U64_PAD(__rseq_str(abort_ip)) "\n\t" \
> >                  ".word " __rseq_str(RSEQ_SIG) "\n\t" \
> >                  __rseq_str(label) ":\n\t" \
> >                  teardown \
> >                  "b %l[" __rseq_str(abort_label) "]\n\t"
> >=20
> > Perhaps Paul Burton can confirm this ?
>=20
> Yes please.
>=20
> You also want to avoid the value being a valid MIPS insn that's common.
>=20
> Did you check that?

This does not decode as a standard MIPS instruction, though it does
decode for both the microMIPS (ori) & nanoMIPS (lwxs; sll) ISAs.

I imagine I copied the value from another architecture when porting, and
since it doesn't get executed it seemed fine.

One maybe nicer option along the same lines would be 0x72736571 or
0x71657372 (ASCII 'rseq') neither of which decode as a MIPS instruction.

> I think the order of preference is:
>=20
> 1.  An uncommon insn (with random immediate values), in a literal pool, t=
hat is
>     not a useful ROP/JOP sequence (very uncommon)

For that option on MIPS we could do something like:

  sll $0, $0, 31     # effectively a nop, but looks weird

> 2a. A uncommon TRAP hopefully with some immediate data encoded (maybe unc=
ommon)

Our break instruction has a 19b immediate in nanoMIPS (20b for microMIPS
& classic MIPS) so that could be something like:

  break 0x7273       # ASCII 'rs'

That's pretty unlikely to be seen in normal code, or the teq instruction
has a rarely used code field (4b in microMIPS, 5b in nanoMIPS, 10b in
classic MIPS) that's meaningless to hardware so something like this
would be possible:

  teq $0, $0, 0x8    # ASCII backspace

> 2b. A NOP to avoid affecting speculative execution (maybe uncommon)
>=20
> With 2a/2b being roughly equivalent depending on speculative execution po=
licy.

There are a bunch of potential odd looking nops possible, one of which
would be the sll I mentioned above.

Another option would be to use a priveleged instruction which userland
code can't execute & should normally never contain. That would decode as
a valid instruction & effectively behave like a trap instruction but
look very odd to anyone reading disassembled code. eg:

  mfc0 $0, 13        # Try to read the cause register; take SIGILL

In order to handle MIPS vs microMIPS vs nanoMIPS differences I'm
thinking it may be best to switch to one of these real instructions that
looks strange. The ugly part would be the nest of #ifdef's to deal with
endianness & ISA when defining it as a number...

Thanks,
    Paul
