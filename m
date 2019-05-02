Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818DFC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B072075E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="aGzLo+3v";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="gOnhXDMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfEBIjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 04:39:00 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:56656 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725951AbfEBIjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 04:39:00 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x428b6mZ025655;
        Thu, 2 May 2019 01:38:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=v9ur+npx6FMF0rJCLY8QFry516fHZkwqI1ShYjmdl4w=;
 b=aGzLo+3vPzj1M0utXaLd5FhVy6pwaTg4d42ivSXu3DLkUPMNGRRZOtmI3rJH3TDSH0G6
 ZiKEnmRkQfD4AyFKBceoNIHkoY9TBfpUBjENQ7iqfJ64x+973LhfwcF28FII9PH9TnJc
 8O28/ZzjSkqkFaQcKKluKjRPBrSbgyDA3vkl5nCJpASqZ8zZz4m0ECndCLjOugUgelJb
 BvR4+s9tUfM/gSIAGt1Wh+Ub3RyklkIYanwSfgtdL8ErS0CCOH7av7cs/bBv7BE2jyOE
 VCof0rSpSi56N4vFL6hBPjuz7uc0pmHEdmf/sUo98Blu79VSS3JeluPgWqGyiA7zilLj 3A== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2s7k3b9v1r-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 02 May 2019 01:38:44 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 2 May
 2019 01:38:43 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.56) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 2 May 2019 01:38:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9ur+npx6FMF0rJCLY8QFry516fHZkwqI1ShYjmdl4w=;
 b=gOnhXDMn3WCQ+VgS9gCqyJ2o5UYSHEk8XWxDA9KBTeQ2x2J0p5Y0I7VM5w4rQUr6/5pveMRURO9CLf0fkQQgSa6CVZx19uHrLWL47D/oP69ZHK5HHC6ugoWXdGL9zlbBtUn87j9DiV9VDQFiMATP17bUfQpaPKxo6nzcOwH9KlA=
Received: from DM5PR18MB1578.namprd18.prod.outlook.com (10.175.224.136) by
 DM5PR18MB2325.namprd18.prod.outlook.com (52.132.208.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Thu, 2 May 2019 08:38:42 +0000
Received: from DM5PR18MB1578.namprd18.prod.outlook.com
 ([fe80::28da:f8bb:4901:b0aa]) by DM5PR18MB1578.namprd18.prod.outlook.com
 ([fe80::28da:f8bb:4901:b0aa%10]) with mapi id 15.20.1835.018; Thu, 2 May 2019
 08:38:41 +0000
From:   Jan Glauber <jglauber@marvell.com>
To:     Will Deacon <will.deacon@arm.com>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Subject: Re: [RFC] Disable lockref on arm64
Thread-Topic: [RFC] Disable lockref on arm64
Thread-Index: AQHVAMJyX/jERFJO0EaZn9HXlo62yQ==
Date:   Thu, 2 May 2019 08:38:41 +0000
Message-ID: <20190502083834.GG13955@hc>
References: <20190429145159.GA29076@hc>
 <20190501160140.GC28109@fuggles.cambridge.arm.com>
In-Reply-To: <20190501160140.GC28109@fuggles.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0701CA0014.eurprd07.prod.outlook.com
 (2603:10a6:203:51::24) To DM5PR18MB1578.namprd18.prod.outlook.com
 (2603:10b6:3:14d::8)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [78.43.208.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e65ca083-92bb-4e52-7292-08d6ced994a5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:DM5PR18MB2325;
x-ms-traffictypediagnostic: DM5PR18MB2325:
x-microsoft-antispam-prvs: <DM5PR18MB2325D03E71804B7797FEDD16D8340@DM5PR18MB2325.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(7736002)(66066001)(316002)(486006)(446003)(8676002)(305945005)(6486002)(2906002)(102836004)(6512007)(6916009)(99286004)(9686003)(71190400001)(53936002)(186003)(14444005)(256004)(1076003)(68736007)(6246003)(33716001)(26005)(76176011)(4326008)(54906003)(229853002)(81166006)(81156014)(71200400001)(8936002)(478600001)(86362001)(11346002)(6436002)(66556008)(66946007)(73956011)(66476007)(476003)(64756008)(66446008)(6116002)(3846002)(52116002)(25786009)(6506007)(386003)(33656002)(14454004)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR18MB2325;H:DM5PR18MB1578.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eAaFqx7iwTp3eMJFpAOCKRjzoqyOwbePAT7GxgPSZ50uRC1M6M+mIaGV/N03EGocGlcoZQNSob0bTcGytup4qmNs/q7yWneDNpZbGEO1c2s9WoprkRrJxwdQ13nqkOyp/nxWYabDAdOiFVdObWRnIryBngz78OoVhl+lvjM/uVrayKOArPtNWMyldTCQwmwiNNpKmvF54RoBL59usQ7XDfc8djyfmmOl6+wZp0ENoW9pUxzV9iYLpA08/o60Rad96bPaksJqIRSu7FnDKe69+ixxaqu/a6QF3UB6QafuqTljjR12W1+DoifiqQIxAWKLeGZCC3qFxpjIuq+NzevRQ6YYY13jJLEfLaObNrEzfCCW0Ua0C0SmPB39OYC0HIzcNIB8cQZIo9n41Zr4kr9S4ZR8G/HBLEIEFXPpsK8rpqo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3D280D6F2517CD4F98E2699985E02545@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e65ca083-92bb-4e52-7292-08d6ced994a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 08:38:41.9121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB2325
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-02_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 05:01:40PM +0100, Will Deacon wrote:
> Hi Jan,
>=20
> [+Peter and Linus, since they enjoy this stuff]
>=20
> On Mon, Apr 29, 2019 at 02:52:11PM +0000, Jan Glauber wrote:
> > I've been looking into performance issues that were reported for severa=
l
> > test-cases, for instance an nginx benchmark.
>=20
> Could you share enough specifics here so that we can reproduce the issue
> locally, please? That would help us in our attempts to develop a fix with=
out
> simply disabling the option for everybody else.

I can send my test-case which is a trivial open-read-close loop with one
thread per CPU and increasing read sizes.

> > It turned out the issue we have on ThunderX2 is the file open-close seq=
uence
> > with small read sizes. If the used files are opened read-only the
> > lockref code (enabled by ARCH_USE_CMPXCHG_LOCKREF) is used.
> >=20
> > The lockref CMPXCHG_LOOP uses an unbound (as long as the associated
> > spinlock isn't taken) while loop to change the lock count. This behaves
> > badly under heavy contention (~25x retries for one cmpxchg to succeed
> > with 28 threads operating on the same file). In case of a NUMA system
> > it also behaves badly as the access from the other socket is much slowe=
r.
>=20
> It's surprising that this hasn't been reported on x86. I suspect their
> implementation of cmpxchg is a little more forgiving under contention.
>=20
> > The fact that on ThunderX2 cpu_relax() turns only into one NOP
> > instruction doesn't help either. On Intel pause seems to block the thre=
ad
> > much longer, avoiding the heavy contention thereby.
>=20
> NOPing out the yield instruction seems like a poor choice for an SMT CPU
> such as TX2. That said, the yield was originally added to cpu_relax() as
> a scheduling hint for QEMU.

The issue is not limited to SMT, it also shows without SMT.

> > With the queued spinlocks implementation I can see a major improvement
> > when I disable lockref. A trivial open-close test-case improves by
> > factor 2 while system time is decreasing also 2x. Looking at kernel com=
pile
> > and dbench numbers didn't show any regression with lockref disabled.
> >=20
> > Can we simply disable lockref? Is anyone else seeing this issue? Is the=
re
> > an arm64 platform that actually implements yield?
>=20
> There are two issues with disabling lockref like this:
>=20
>   1. It's a compile-time thing, so systems that would benefit from the co=
de
>      are unfairly penalised.
>=20
>   2. You're optimising for the contended case at the cost of the
>      uncontended case, which should actually be the common case as well.

I completely agree with 2). Nevertheless limiting the retry attempts
like Linus suggested looks like a fair change that should not penalize
anyone and would still help the contented case.

--Jan

> Now, nobody expects contended CAS to scale well, so the middle ground
> probably involves backing off to the lock under contention, a bit like
> an optimistic trylock(). Unfortunately, that will need some tuning, hence
> my initial request for a reproducer.
>=20
> Cheers,
>=20
> Will
