Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FDBC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 06:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B06E3206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 06:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="sKUMmvUn";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="Cf1P8u+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbfEFGN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 02:13:28 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:34786 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725710AbfEFGN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 02:13:27 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x466A5wl003587;
        Sun, 5 May 2019 23:13:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=e5RVnoOEsp7czHIKg1MnsJ4wrrdIdwEN2VjdflKFeh4=;
 b=sKUMmvUnEYVUYlEfgBqZ4Wc4NF31HP/LDugU4F5Zs5tVcMF545nD/VHqygJRNZKiENX3
 1HEVq54KopIvrov8zW/9GooPMPlLm9ACV6wgDuZ11GHdsH5DLzaZI6ltY9Fl9GrSPtVK
 Q0Z5fxGEyGEaONAeNNjnbYDfZHvWqYQt9AZoUQhZd1q1tZJqT3Amk1uZ2ZAu268jbSw1
 iVGWBTJWglElErC+LiOQLF+WNwasp7a/ZSVbf1wrwhUTdfySqYhaKqxJ6W3t+e1z7wPm
 8hP3d3cRc3WzH5CJ5OIh2zfZqoa3h5yhsOnvQ/SQcmLPpNnuBAdMHjaaA0/gCweWdvDf aA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2s9a8k5myg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 05 May 2019 23:13:14 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Sun, 5 May
 2019 23:13:13 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.50) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sun, 5 May 2019 23:13:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5RVnoOEsp7czHIKg1MnsJ4wrrdIdwEN2VjdflKFeh4=;
 b=Cf1P8u+ZibRV7Vo0paKm1/CFa8vmco2TFBpLZxIb86EgCD8vMHgcf9Ebz/guzc6P6jZ2sTdqZTj7gLy2d7Mw23uInwrd0/Bwx3o/Ybdz+QSTXQEXG63vJmyV5YAQ+sDbY4G4SoI6gc7IlHLnXlWvinDLYpYABZlEuN7VMknxLFk=
Received: from CY4PR1801MB1942.namprd18.prod.outlook.com (10.171.255.33) by
 CY4PR1801MB1862.namprd18.prod.outlook.com (10.171.255.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Mon, 6 May 2019 06:13:12 +0000
Received: from CY4PR1801MB1942.namprd18.prod.outlook.com
 ([fe80::5c52:431f:5056:bcc1]) by CY4PR1801MB1942.namprd18.prod.outlook.com
 ([fe80::5c52:431f:5056:bcc1%3]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 06:13:12 +0000
From:   Jayachandran Chandrasekharan Nair <jnair@marvell.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Jan Glauber <jglauber@marvell.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [RFC] Disable lockref on arm64
Thread-Topic: [EXT] Re: [RFC] Disable lockref on arm64
Thread-Index: AQHVAT1riFRx2+dQL0aEg31wk8yRAaZZzasAgAPVXwA=
Date:   Mon, 6 May 2019 06:13:12 +0000
Message-ID: <20190506061100.GA8465@dc5-eodlnx05.marvell.com>
References: <20190429145159.GA29076@hc>
 <CAHk-=wjPqcPYkiWKFc=R3+18DXqEhV+Nfbo=JWa32Xp8Nze67g@mail.gmail.com>
 <20190502082741.GE13955@hc>
 <CAHk-=wjmtMrxC1nSEHarBn8bW+hNXGv=2YeAWmTw1o54V8GKWA@mail.gmail.com>
 <20190502231858.GB13168@dc5-eodlnx05.marvell.com>
 <CAHk-=wiEahkwDXpoy=-SzJHNMRXKVSjPa870+eKKenufhO_Hgw@mail.gmail.com>
In-Reply-To: <CAHk-=wiEahkwDXpoy=-SzJHNMRXKVSjPa870+eKKenufhO_Hgw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM6PR08CA0002.namprd08.prod.outlook.com
 (2603:10b6:5:80::15) To CY4PR1801MB1942.namprd18.prod.outlook.com
 (2603:10b6:910:7a::33)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.233.59.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca49a4da-2309-4a2f-2488-08d6d1e9eb0d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:CY4PR1801MB1862;
x-ms-traffictypediagnostic: CY4PR1801MB1862:
x-microsoft-antispam-prvs: <CY4PR1801MB186202E4F132B2F8D59EDBBDA6300@CY4PR1801MB1862.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(376002)(346002)(366004)(136003)(396003)(52314003)(199004)(189003)(33656002)(6512007)(102836004)(229853002)(26005)(81166006)(81156014)(8936002)(6436002)(8676002)(7736002)(99286004)(14454004)(305945005)(52116002)(478600001)(76176011)(53546011)(6506007)(386003)(54906003)(316002)(1076003)(6116002)(53936002)(3846002)(25786009)(86362001)(71190400001)(71200400001)(14444005)(256004)(186003)(6916009)(2906002)(4326008)(11346002)(446003)(68736007)(66066001)(476003)(5660300002)(6246003)(64756008)(66556008)(66476007)(66946007)(73956011)(66446008)(6486002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR1801MB1862;H:CY4PR1801MB1942.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: id+4lW4+Jh4Lf5PqviJT4qVzloClazKBicVZq2FVJLc9BFqfdGEovx6lGjQKi6xrMCp7BYCqjgJgMgo06aQYdRLfR9Hv8jyAFDDqacJpjVsqTeXbWwLQoSbNSYo6sl8a7lydHtO1mmQrTqYmoqdhtuQP6Rx0tVqd899sWEYLyZDiCcM/rfvrlUb686xbqE6UwU/xprfyf2fJC1gsNpF1GOTZEPuiRZ59yciwXZA87jrZ5ayx8HTFOvCHSkA4WPF2UF+4E7tLpnkmBFFhUz6GppG6N4dP7pdq28YCzvZAKIynBE9Uf7xsTlvK9JYBVtSwG3kEiFz35XqsIS0Qj1+uOeaOvABuQ5xk4TwYw2Vhra4E1hVRs9W+jSpprx6VWsDi17fvCVltvKEUxTGZOn3nKQUU97bA5YVcAGsHRzUKB+4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <442090E5E400C743991A8A5C6C679265@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ca49a4da-2309-4a2f-2488-08d6d1e9eb0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 06:13:12.4208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1801MB1862
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-06_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 12:40:34PM -0700, Linus Torvalds wrote:
> On Thu, May 2, 2019 at 4:19 PM Jayachandran Chandrasekharan Nair
> <jnair@marvell.com> wrote:
> >>
> > I don't really see the point your are making about hardware. If you
> > look at the test case, you have about 64 cores doing CAS to the same
> > location. At any point one of them will succeed and the other 63 will
> > fail - and in our case since cpu_relax is a nop, they sit in a tight
> > loop mostly failing.
>=20
> No.
>=20
> My point is that the others will *not* fail, if your cache coherency acts=
 sane.
>=20
> Here's the deal: with a cmpxchg loop, no cacheline should *ever* be in
> shared mode as part of the loop. Agreed? Even if the cmpxchg is done
> with ldx/stx, the ldx should do a read-for-write cycle, so at no
> single time will you ever have a shared cacheline.
>=20
> And once one CPU gets ownership of the line, it doesn't lose it
> immediately, so the next cmpxchg will *succeed*.
>=20
> So at most, the *first* cmpxchg will fail (because that's the one that
> was fed not by a previous cmpxchg, but by a regular load (which we'd
> *like* to do as a "load-for-ownership" load, but we don't have the
> interfaces to do that). But the second cmpxchg should basically always
> succeed, unless something exceptional happened (maybe an interrupt,
> maybe something big like that).
>=20
> Ergo: if you have a case of failing cmpxchg a lot, your cache
> coherency is simply bad. Your hardware people should be ashamed of
> themselves for letting go of the cacheline without just letting the
> next cmpxchg succeed.
>=20
> Notice how there is *NO* ping-pong. Sure, the cacheline moves around,
> but every time it moves around just once, a thread makes progress.
> None of this "for every progrress, there are 63 threads that fail"
> garbage that you're claiming is normal.
>=20
> It's not normal, and it's not inevitable.

If you look at the code, the CAS failure is followed by a yield
before retrying the CAS. Yield on arm64 is expected to be a hint
to release resources so that other threads/cores can make progress.
Under heavy contention, I expect the current code to behave the way
I noted in my last mail, with the issue with fairness as well.

Perhaps someone from ARM can chime in here how the cas/yield combo
is expected to work when there is contention. ThunderX2 does not
do much with the yield, but I don't expect any ARM implementation
to treat YIELD as a hint not to yield, but to get/keep exclusive
access to the last failed CAS location.
=20
> If it really happens, it's a sign of bad hardware. Just own it, and
> talk to the hw people, and make sure it gets fixed in ThunderX3. Ok?

Also, I tested a the lockref code on a fairly high core count x86
system with SMT. The worst case number of loops taken is higher than
your guaranteed random number of 15, but the average number of loops
is to be fairly low (about 3-4, and double that for SMT).  On x86,
I suppose there has been some coevolution between the software and
hardware on locking with cmpxchg and pause, so by now both are
optimized for each other.

Your larger point seems to be that the hardware has smarter to
scale standard locking implementations when adding cores, and
be graceful even in extremely high contention cases. Yes, this
is something we should be looking at for ThunderX3.

This whole discussion has been difficult since this has nothing to
do with the core capability which you originally talked about. There
are quite a few low-powered ARM64 cores (some of them in server space
too), but ThunderX2 is certainly not one. I say this from first hand
experience from using a ThunderX2 workstation as my primary system
for a while now. Kernel builds, git operations and running multiple
VMs work extremely well and are pretty fast compared to my earlier
x86 based system.

Anyway, I will talk to hardware folks on locking patterns and see
what can be done about cas & yield in ThunderX3. Thanks for your
suggestions.

JC
