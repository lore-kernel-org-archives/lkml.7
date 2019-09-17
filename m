Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1ECAC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8895020578
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="eeMb8FOm";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="C1sU5mqN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbfIQStK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 14:49:10 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:17940 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725865AbfIQStI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 14:49:08 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8HIitsZ009793;
        Tue, 17 Sep 2019 11:48:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=+sgtqXbxdJUaoDMgMQef8mwhV3bNRAndgWcUVNXsAL0=;
 b=eeMb8FOmUBINSThplqhBfBd3ZFqAvazGKs/N27zL3Bu6exmZ8/D1zqNdU8dNl7ob02p9
 BNqlJPNqbkvCQmSvpX7s6gHzBc2XLx8GfP5Fc37buTWiCqS9C1lPFqrK9j8M3WYXGqWJ
 xCB1Ph1zkFL0Siiw35A1KkIHA5HRHYieIkM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2v2bum6grb-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 17 Sep 2019 11:48:50 -0700
Received: from ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) by
 ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Sep 2019 11:48:48 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 17 Sep 2019 11:48:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BE9YXxEZpEyaoTHVF6UT/w8fCZ1ezFWU1iWlaS1WNW2KCpA6W5z/J57Y64Acu/k2b/O7neiFxJXMbot5R8LHeIa/FGdx4miSJPQDResmOqsyAAPiML6thdc2X1/G5ywPexh2hPfZE9EvyJ7y3L1y+dYccZmf3vioAkrgm6i5jTKh2zDckoL3TzPfNfgT20hHJsOFywB3mA3Lx1kmT8AgMHw/WvI0nVGuB6eLaJ9sGuxIrAj2ZgOg3dBPa8XrgIq6p9sM0bEMWKrhAVz622m+ZYk/TEWIQV05jmBa7VGSyJWjdWmeuEWn+DS7T2ea4McZZULUdnrTHqiptkD2u9I8dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sgtqXbxdJUaoDMgMQef8mwhV3bNRAndgWcUVNXsAL0=;
 b=j2Jyl9zxwGaL1we9h0KpFxcSzY3SLivcK18dsScNYg+3rtX08Xi4MMH+g3CGEJXDb/NGfT5XW23woaYUMIyQRw9HtqZnWw3X1VSa6KjBrBCs8rAQZNxD3rPgaAhUOlXOO/9yFfEz0I8UR72niLkG24Blob10SZXu/DhQEYmaVD5Gw3y4+aA69dIaqJvKZlpSZ8a80W+72cJh6IgZcetK2Fl8EkL0ukSMS8/RqyD6tVLJaZG1t8nQULWN2XxMX3oC1QxqSSvXZwO/DJr2F+unX30YzE/ob/5WDHv3gOCN+BSJQDootBPmNh638jPcNxmwS9EkD+H9d+FE0LonaM43MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sgtqXbxdJUaoDMgMQef8mwhV3bNRAndgWcUVNXsAL0=;
 b=C1sU5mqNl+K9nZCkHGt8bhEhyevlJr2tvUh/tY05hX2ADgcaBpbtaSNy4BiOZME9B9Z7m9oG4FFA/gfe2LQt++S5FLT9WRWw5GI7qOvw7ollKS0vcyYuAx0yBHWATxpvhwLtCckzsHhfQOl9SXVvM6nkAef8czvj5+1iytNhqFc=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1470.namprd15.prod.outlook.com (10.173.234.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.24; Tue, 17 Sep 2019 18:48:47 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a828:5750:379d:b9a1]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a828:5750:379d:b9a1%8]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 18:48:46 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] x86/pti for 5.4-rc1
Thread-Topic: [GIT pull] x86/pti for 5.4-rc1
Thread-Index: AQHVbYOndIwm8vXaKE+EAjtQudNonacwNgoA
Date:   Tue, 17 Sep 2019 18:48:46 +0000
Message-ID: <CDB07BE3-6491-4159-89E7-FBA1631A01C3@fb.com>
References: <156864062018.3407.16580572772546914005.tglx@nanos.tec.linutronix.de>
 <156864062019.3407.14798418565580024723.tglx@nanos.tec.linutronix.de>
 <CAHk-=wjQJaNbQe3fmFU19_wawkx-WT9Sv=h5mWCA9=LL34g_3Q@mail.gmail.com>
In-Reply-To: <CAHk-=wjQJaNbQe3fmFU19_wawkx-WT9Sv=h5mWCA9=LL34g_3Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::2:a8b4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 109fc226-1104-4e49-be6f-08d73b9fac17
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR15MB1470;
x-ms-traffictypediagnostic: MWHPR15MB1470:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR15MB147097090F74D047D2F1CB82B38F0@MWHPR15MB1470.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(136003)(39860400002)(376002)(199004)(189003)(76116006)(2616005)(6116002)(33656002)(14454004)(305945005)(86362001)(446003)(229853002)(66446008)(476003)(11346002)(46003)(6916009)(64756008)(66946007)(6512007)(186003)(53546011)(102836004)(6506007)(4326008)(14444005)(76176011)(99286004)(6246003)(66476007)(478600001)(25786009)(256004)(966005)(36756003)(7736002)(5660300002)(66556008)(71190400001)(486006)(71200400001)(81166006)(54906003)(81156014)(6306002)(2906002)(6486002)(8676002)(8936002)(50226002)(316002)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1470;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iz0L76GC+3LGC6WRjoOXyohoTBk6Oo5dt+WBClXbiR2e+QfLJ+uREOS6O0nrsGaSsaiWcs+BZ0gY4Tc+iAp7i/AYbtdfGAf/JhUNS0sXaqfn3BSA8S8Pq4+ers3e44AjdMPSiR1cCeQ0Msp6CdPrmnHYvyooxH75Dowo1QP+pls3t5i56KTfFsWHQNPeaSHPr+9lnxnYI37M08GjTWAqUv3LM6aVQeK1zzXWNtsEJmwC2DwQDoMznOQmOt5PfrSq9uWYTQKP+1VlYQkqTkj7gCxJpz5bOPQL6VhyPTPaP0AbrXxCqq/aY664Zsv6xlsOxMc23ae3mhtdNKIoxch39fhp6q0tMzh9sljUohnEzu88dvZK8WSaKrFKlEcjozPf7kjjF5xPVRJr4PE6fu74MXlhUpOYGhPpbBWda2XNZ5o=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F58F98EFCC26DB4482B2C2902AB695DF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 109fc226-1104-4e49-be6f-08d73b9fac17
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 18:48:46.6971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yc8z+c+3Mo/BwPREabBJX5IjSQUzrVR9IjZfmUgidZeZL2aazKSv/2udAFqp6Rqkkal8nEfmfubWGtQqNHcN9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1470
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-17_10:2019-09-17,2019-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011 spamscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909170178
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 17, 2019, at 11:13 AM, Linus Torvalds <torvalds@linux-foundation.o=
rg> wrote:
>=20
> On Mon, Sep 16, 2019 at 6:38 AM Thomas Gleixner <tglx@linutronix.de> wrot=
e:
>>=20
>>  - Handle unaligned addresses gracefully in pti_clone_pagetable(). Not a=
n
>>    issue with current callers, but a correctness problem. Adds a warning
>>    so any caller which hands in an unaligned address gets pointed out
>>    clearly.
>=20
> Hmm. I actually thing this one is incomplete.
>=20
> Yes, it does it correctly now for the "those addresses are missing" cases=
.
>=20
> But if somebody passes in an unaligned address, it still does the
> wrong thing for the
>=20
>                if (pmd_large(*pmd) || level =3D=3D PTI_CLONE_PMD) {
>=20
> case. No?

I guess we need something like the following?

diff --git i/arch/x86/mm/pti.c w/arch/x86/mm/pti.c
index b196524759ec..7846916c3bcd 100644
--- i/arch/x86/mm/pti.c
+++ w/arch/x86/mm/pti.c
@@ -306,6 +306,8 @@ pti_clone_pgtable(unsigned long start, unsigned long en=
d,
 {
        unsigned long addr;

+       if (WARN_ON_ONCE(start & ~PAGE_MASK))
+               return;
        /*
         * Clone the populated PMDs which cover start to end. These PMD are=
as
         * can have holes.
@@ -341,6 +343,8 @@ pti_clone_pgtable(unsigned long start, unsigned long en=
d,
                }

                if (pmd_large(*pmd) || level =3D=3D PTI_CLONE_PMD) {
+                       if (WARN_ON_ONCE(addr & ~PMD_MASK))
+                               return;
                        target_pmd =3D pti_user_pagetable_walk_pmd(addr);
                        if (WARN_ON(!target_pmd))
                                return;

>=20
> I've pulled this, since the change is not _wrong_, but it does look
> incomplete to me. Am I missing something?
>=20
> Also, it would have been lovely to have some background on how this
> was even noticed. The link in the commit message goes to the
> development thread, but that one doesn't have the original report from
> Song either.

I didn't really notice any issue. I was debugging an increase in iTLB=20
miss rate, which was caused by splitting of kernel text page table,=20
and was fixed by Thomas in:

https://lore.kernel.org/lkml/alpine.DEB.2.21.1908282355340.1938@nanos.tec.l=
inutronix.de/

I mistakenly suspected the issue was caused by the pti code, and=20
mistakenly proposed the first patch here. It turned out to be useful,=20
but it is not related to the original issue.=20

Thanks,
Song=
