Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8620C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC062085A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="s7qYn4Ym";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="kQIzGHjO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfFQUIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 16:08:11 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:8912 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726721AbfFQUIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 16:08:10 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5HK4rm4013750;
        Mon, 17 Jun 2019 13:07:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=lB2ChPV5iZU/6F/eZDYPHUyKbwiTw7SG/AnU3EJxhIo=;
 b=s7qYn4YmeVXDGioMbgkqww7pvz3ZEqHPNWnWicaVbd0HQMSPbDjkIrM0L5K5d4jsw3z0
 iWvn3mkq5Oy+i8ykMmsRqbbdu5/k3jKthMEMEhOe38OMOWsMZOZtylmLOZ8ziABpRaKd
 4Oic2JbAPnr9SD+p5MML30bta60OhufOHqbRo0c7HKnjs6HGJtIQQVcCl93T08n1GZ7N
 axuKQ0Ojfy2m+DXBeAhCvlDTsxJcDPQ6Fw06IiTbhotcPg28SX6E+PX5T99DX8L8akfL
 Zni2RkSHpOEhAPLZurX1lTSqK8hCp6IhWTghRrfpaBf/Hk8sARGh0kZzLtcR1AOstl+w 6Q== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2t68rpabhs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 17 Jun 2019 13:07:58 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 17 Jun
 2019 13:07:57 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.59) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 17 Jun 2019 13:07:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lB2ChPV5iZU/6F/eZDYPHUyKbwiTw7SG/AnU3EJxhIo=;
 b=kQIzGHjOjM3QGqHO+BRiO/5LQ0xNra4ePkAHtn2Tj93787Wj+x7I9wLO3F8VYs0YUwr7ymGFLluPHjG+lunYAH7FEjE7Zp4Mry76emnVCfytV7jvphAjkumHWCBxMwMRQQYv89JAc00dhk4oP2s9BcxdZcEKfGuDGqzbxx2/DGA=
Received: from BN8PR18MB2788.namprd18.prod.outlook.com (20.179.73.220) by
 BN8PR18MB2964.namprd18.prod.outlook.com (20.179.76.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Mon, 17 Jun 2019 20:07:55 +0000
Received: from BN8PR18MB2788.namprd18.prod.outlook.com
 ([fe80::99e5:34a8:2f99:3149]) by BN8PR18MB2788.namprd18.prod.outlook.com
 ([fe80::99e5:34a8:2f99:3149%7]) with mapi id 15.20.1987.014; Mon, 17 Jun 2019
 20:07:55 +0000
From:   Jayachandran Chandrasekharan Nair <jnair@marvell.com>
To:     Will Deacon <will.deacon@arm.com>
CC:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Jan Glauber <jglauber@marvell.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC] Disable lockref on arm64
Thread-Topic: [RFC] Disable lockref on arm64
Thread-Index: AQHVJUhZrbOg/WOpcE2VXDha9giiEQ==
Date:   Mon, 17 Jun 2019 20:07:54 +0000
Message-ID: <20190617200750.GB5565@dc5-eodlnx05.marvell.com>
References: <20190614095846.GC10506@fuggles.cambridge.arm.com>
 <CAKv+Gu_Kdq=UPijjA84FpmO=ZsdEO9EyyF7GeOQ+WmfqtO_hMg@mail.gmail.com>
 <20190614103850.GG10659@fuggles.cambridge.arm.com>
 <201906142026.1BC27EDB1E@keescook>
 <CAKv+Gu_XuhgUCYOeykrbaxJz-wL1HFrc_O+HeZHqaGkMHd2J9Q@mail.gmail.com>
 <201906150654.FF4400F7C8@keescook>
 <CAKv+Gu9-rZ16Nb9t3=knzW0BHu0eNxQoPwWS4c8UMMm=2iqiuw@mail.gmail.com>
 <201906161429.BCE1083@keescook>
 <CAKv+Gu_8ibO4D01DZv6KjL2GnvKuVBVnt=doxkN0w=4utJ7NvQ@mail.gmail.com>
 <20190617172620.GK30800@fuggles.cambridge.arm.com>
In-Reply-To: <20190617172620.GK30800@fuggles.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0038.namprd07.prod.outlook.com
 (2603:10b6:a03:60::15) To BN8PR18MB2788.namprd18.prod.outlook.com
 (2603:10b6:408:77::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.233.59.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d673804-847e-43ee-54ce-08d6f35f7bf7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN8PR18MB2964;
x-ms-traffictypediagnostic: BN8PR18MB2964:
x-microsoft-antispam-prvs: <BN8PR18MB296414DA2FC72AED9A1A2F73A6EB0@BN8PR18MB2964.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0071BFA85B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(346002)(136003)(396003)(199004)(189003)(31014005)(26005)(478600001)(6436002)(4326008)(25786009)(386003)(6506007)(8676002)(54906003)(186003)(5660300002)(76176011)(6916009)(305945005)(102836004)(14454004)(52116002)(66066001)(7736002)(6246003)(81166006)(81156014)(8936002)(71200400001)(2906002)(256004)(99286004)(486006)(6512007)(14444005)(73956011)(229853002)(6486002)(446003)(53936002)(66946007)(476003)(316002)(66476007)(71190400001)(64756008)(66446008)(66556008)(86362001)(6116002)(3846002)(1076003)(33656002)(11346002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR18MB2964;H:BN8PR18MB2788.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KCfO7UM9cVPwJjwnlk3kWCKDvPaMT39AzDBWL+yMWpSjywHaruQkbbm1s9kmV3QX06cnmlDFFfOmvjgM2+4TyIlmwSSQrq2r9firDF8/ZAdpNccgFELfWUbUFHVvDbVcZ1TJ9O/JNQKW7in8XRbAnA92dTXvY+99Z1a0NQ9HBrDKL9VIZgpcyhXeRS2CS8cexhn6QwMouM5E05x+YDjJp6xkec3vWzKv6HdFSMHgxuH6QEwvPQn6icqb7d6/zusMqRWE0I3tLSwkXXPNAi8Y3nryNCTBaEInUBveaYK0neVRzuRYS/JeFD+HkfYelb0c2T8py0Ut5jq7sTCli82PqWFgVsTeK+QFz5O2TlMFwQ6SsHqWvzeXYyMJ1zfutwrc1ja0YrPnWxgQVQaqyFt9JLZcvOpYS2Z+E1QSebslvYI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A5DBFAE6E51B474A8578B81FC61E1FDC@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d673804-847e-43ee-54ce-08d6f35f7bf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2019 20:07:54.9211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jnair@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR18MB2964
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-17_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 06:26:20PM +0100, Will Deacon wrote:
> On Mon, Jun 17, 2019 at 01:33:19PM +0200, Ard Biesheuvel wrote:
> > On Sun, 16 Jun 2019 at 23:31, Kees Cook <keescook@chromium.org> wrote:
> > > On Sat, Jun 15, 2019 at 04:18:21PM +0200, Ard Biesheuvel wrote:
> > > > Yes, I am using the same saturation point as x86. In this example, =
I
> > > > am not entirely sure I understand why it matters, though: the atomi=
cs
> > > > guarantee that the write by CPU2 fails if CPU1 changed the value in
> > > > the mean time, regardless of which value it wrote.
> > > >
> > > > I think the concern is more related to the likelihood of another CP=
U
> > > > doing something nasty between the moment that the refcount overflow=
s
> > > > and the moment that the handler pins it at INT_MIN/2, e.g.,
> > > >
> > > > > CPU 1                   CPU 2
> > > > > inc()
> > > > >   load INT_MAX
> > > > >   about to overflow?
> > > > >   yes
> > > > >
> > > > >   set to 0
> > > > >                          <insert exploit here>
> > > > >   set to INT_MIN/2
> > >
> > > Ah, gotcha, but the "set to 0" is really "set to INT_MAX+1" (not zero=
)
> > > if you're using the same saturation.
> > >
> >=20
> > Of course. So there is no issue here: whatever manipulations are
> > racing with the overflow handler can never result in the counter to
> > unsaturate.
> >=20
> > And actually, moving the checks before the stores is not as trivial as
> > I thought, E.g., for the LSE refcount_add case, we have
> >=20
> >         "       ldadd           %w[i], w30, %[cval]\n"                 =
 \
> >         "       adds            %w[i], %w[i], w30\n"                   =
 \
> >         REFCOUNT_PRE_CHECK_ ## pre (w30))                              =
 \
> >         REFCOUNT_POST_CHECK_ ## post                                   =
 \
> >=20
> > and changing this into load/test/store defeats the purpose of using
> > the LSE atomics in the first place.
> >=20
> > On my single core TX2, the comparative performance is as follows
> >=20
> > Baseline: REFCOUNT_TIMING test using REFCOUNT_FULL (LSE cmpxchg)
> >       191057942484      cycles                    #    2.207 GHz
> >       148447589402      instructions              #    0.78  insn per
> > cycle
> >=20
> >       86.568269904 seconds time elapsed
> >=20
> > Upper bound: ATOMIC_TIMING
> >       116252672661      cycles                    #    2.207 GHz
> >        28089216452      instructions              #    0.24  insn per
> > cycle
> >=20
> >       52.689793525 seconds time elapsed
> >=20
> > REFCOUNT_TIMING test using LSE atomics
> >       127060259162      cycles                    #    2.207 GHz
>=20
> Ok, so assuming JC's complaint is valid, then these numbers are compellin=
g.

Let me try to point out the issues I see again, to make sure that we are
not talking just about micro-benchmarks.

That first issue: on arm64, REFCOUNT_FULL is 'select'-ed. There is
no option to go to the atomics implementation or a x86-like compromise
implementation, without patching the kernel. Currently we are stuck with
a function call for what has to be a single atomic instruction.

The second part is that REFCOUNT_FULL uses a unbounded CAS loop which is
problematic when the core count increases and when there is contention.
Upto to some level of contention, the CAS loop works fine. But when we
go to the order of a hundred CPUs this becomes an issue. The LDADD
series of atomics can be handled fairly well by hardware even with
heavy contention, but in case of CAS(or LDXR/STXR) loops, getting it
correct in hardware is much more difficult. There is nothing in the
arm64 ISA to manage this correctly. As discussed earlier in the thread,
WFE does not work, YIELD is troublesome, and there is no 'wait in low
power for exclusive access' hint instruction. This is not a TX2
specific issue.

The testcase I provided was not really a microbenchmark. That was a
simplified webserver testcase where multiple threads read a small file
in parallel. With Ubuntu configuration (apparmor enabled) and when
other things line up (I had made the file & dir non-writable), you
can see that refcount is the top function. I expect this kind of
situation to be more frequent as more subsystems move to refcount_t.

> In particular, my understanding of this thread is that your optimised
> implementation doesn't actually sacrifice any precision; it just changes
> the saturation behaviour in a way that has no material impact. Kees, is t=
hat
> right?
>=20
> If so, I'm not against having this for arm64, with the premise that we ca=
n
> hide the REFCOUNT_FULL option entirely given that it would only serve to
> confuse if exposed.

Thanks for looking into this! From the discussion it seems likely
that we can get a version of Ard's patch in, which does not have CAS
loop in most cases.

JC
