Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F18C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 23:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB57206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 23:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Pc/RtQJN";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="EVYOrv8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbfIQX3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 19:29:31 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57030 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726317AbfIQX3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 19:29:31 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8HNTDML032143;
        Tue, 17 Sep 2019 16:29:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=b3tyHfDq1wbLJcNJykVPuCuckwz/fATRcvRiUDNOXhA=;
 b=Pc/RtQJNyCdMwlZj74ZwtSphZiM8xngpkm0pUKRj0wBx+Tm2Fwitaf5k54nrhhOcu9CF
 PNq/08hk30xPMqoFLx9aOnrROgK1GGeqkyak7HSNmntIZ3VnuajxhJePZ0CKAJmMmMmQ
 aT2HRp5blnxdIzYgC2kfJ+iFhoqXWj48BT0= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2v37kr0c5r-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 17 Sep 2019 16:29:15 -0700
Received: from prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 17 Sep 2019 16:28:40 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 17 Sep 2019 16:28:39 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 17 Sep 2019 16:28:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CH4NKoT797Pbn6kxr4Ixik+J+spklh9DC81js9TghtLvcVrpZH5lAPYDjBREJ7za4YLeM9HgKnhb9GVaRq9uKGfsAxMuna4LumqxpJuKanVFbhffzZYtdJG73y3EfSXwLyfhwcgCBs1rlr4NN7eSHTJySYTJkAI9K0esIMPvUBaLYGzjyNGzppxtSyhvTL1sT6ats/SC0dgC0KSTbCLMRvw43kwx41QDJ5tjIGod82DYRcpm3IYYx5n+7LD/xh3HOcjdkdhAaYw8dh8JnIGUz3fBc2vH9Sx5+KhRGP46qEfWZKec1cieaYoG8e8jaMXriiX5Xe3mq5ZmL/LzVGhgIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3tyHfDq1wbLJcNJykVPuCuckwz/fATRcvRiUDNOXhA=;
 b=kiOxn72qMeF7L77ZwYsSb8tWr51ZqJudZI+IPD6Ho1yJYws0xLQZ6CTXkeyzJyoCl2mlRIbiuxsePIV9f2JZlBag7ejt+jobGSMeD99LiQ1D1moc3nljYf1LeL6+tA7GE0O3Kw0ksab+6viSiSSl8VHkc9tfLxlP+4PqJ1yA1iYFvh05mNppqMWTSTqSXPrIqZZsMApZUL4aR23ih2eRGRwe8KiqXYkc7M9rtF13s0PZ/s9AnLKCuoZMyATLSiLaruMEFvtmvxXhzcyNlelD4vfrVrpBHlI+jWArMB1Ou+RcBfNMwLP7jDHLSHKOVaPRTKQshd+MNUMbO0ZYjcqd3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3tyHfDq1wbLJcNJykVPuCuckwz/fATRcvRiUDNOXhA=;
 b=EVYOrv8JFI5u+7Uio1Jw+i5Y9ff7RoNl4xHsjkEu2z+a46OW25agSQuhQhVVdw/yzeO/LW6H+CvlnCLQOrvmNZ/0PX2h3LxDq7WVFd6tiessoq+fXNsWK/bRkAsMikFu+A5faYPbD5+oTkK7KcnawdGl0VydXUzPsjM47hnAZ5s=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1200.namprd15.prod.outlook.com (10.175.3.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Tue, 17 Sep 2019 23:28:38 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a828:5750:379d:b9a1]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a828:5750:379d:b9a1%8]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 23:28:38 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] x86/pti for 5.4-rc1
Thread-Topic: [GIT pull] x86/pti for 5.4-rc1
Thread-Index: AQHVbYOndIwm8vXaKE+EAjtQudNonacwNgoAgAADq4CAAEqGgA==
Date:   Tue, 17 Sep 2019 23:28:38 +0000
Message-ID: <E4AF8E4C-A307-4AE7-85AA-F579D5BFDBDD@fb.com>
References: <156864062018.3407.16580572772546914005.tglx@nanos.tec.linutronix.de>
 <156864062019.3407.14798418565580024723.tglx@nanos.tec.linutronix.de>
 <CAHk-=wjQJaNbQe3fmFU19_wawkx-WT9Sv=h5mWCA9=LL34g_3Q@mail.gmail.com>
 <CDB07BE3-6491-4159-89E7-FBA1631A01C3@fb.com>
 <CAHk-=whbOhAmc3FEhnEkdM9AXFuKM+964r+uzzm_Q9qFaxTC7g@mail.gmail.com>
In-Reply-To: <CAHk-=whbOhAmc3FEhnEkdM9AXFuKM+964r+uzzm_Q9qFaxTC7g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::2:a8b4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b7026c2-effe-4a84-c4e7-08d73bc6c4d5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR15MB1200;
x-ms-traffictypediagnostic: MWHPR15MB1200:
x-microsoft-antispam-prvs: <MWHPR15MB1200A6737BFCCF0E87C6878DB38F0@MWHPR15MB1200.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:785;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(376002)(136003)(199004)(189003)(66476007)(478600001)(81156014)(316002)(5660300002)(2616005)(446003)(6436002)(36756003)(99286004)(486006)(2906002)(6916009)(6512007)(8936002)(6246003)(8676002)(81166006)(46003)(229853002)(86362001)(186003)(6116002)(76116006)(50226002)(64756008)(33656002)(71190400001)(76176011)(66446008)(66946007)(54906003)(11346002)(14444005)(7736002)(256004)(6486002)(25786009)(305945005)(66556008)(71200400001)(4326008)(6506007)(14454004)(102836004)(476003)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1200;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ihoMIbKtNYPGNYvYQCBsxUavba4Edy2fbQI3vhd9lqZHnSJyOfco2JwExAQO3aCVpzSTYq1SBN8tmBG3JDV1NOnUvJvbfg0BfGcbeSqPhRQdEm5WKEJcTNXV8GEG/gL03iYd01z2EZHfplcxqZX8HBv0F0bqrerYyV10M8MSCUEEsbZiey67u7mojjN8EX/57zWrs+kc/Imy2kwEx08mLNuQ/VF/0aXZd7viKcHYqj0AkMpcHpSu8pctNZkORMffxUxgRSY38kQgVdF3LMwLclkNJQTaGFQyRLyfb0setMOHKjT2Chl2ce5N3+2+pKetO4CQd6xzfinx8sxXp8JK9GsxntHxzV8QHy1Efo21CI5f2l/4Y8Cbw8NocX1h/LYgg2Z2YF6cjx0B6IPMb57Rh3zdsB3ZwkTVB6tdFYZryVk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <77B2C79886C4DE439549E0C21CFA965E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b7026c2-effe-4a84-c4e7-08d73bc6c4d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 23:28:38.7012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5cxkJeGp+M0QApx4x6LJ4+qk/0mRU4e6XQU8211LWLAgSEsVeFWtebN67FBnwUIhlkdXJOfKX3+Dt06+b3Z+sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1200
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-17_13:2019-09-17,2019-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 mlxlogscore=969 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909170219
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 17, 2019, at 12:01 PM, Linus Torvalds <torvalds@linux-foundation.o=
rg> wrote:
>=20
> On Tue, Sep 17, 2019 at 11:49 AM Song Liu <songliubraving@fb.com> wrote:
>>=20
>> I guess we need something like the following?
>>=20
>> diff --git i/arch/x86/mm/pti.c w/arch/x86/mm/pti.c
>> index b196524759ec..7846916c3bcd 100644
>> --- i/arch/x86/mm/pti.c
>> +++ w/arch/x86/mm/pti.c
>> @@ -306,6 +306,8 @@ pti_clone_pgtable(unsigned long start, unsigned long=
 end,
>> {
>>        unsigned long addr;
>>=20
>> +       if (WARN_ON_ONCE(start & ~PAGE_MASK))
>> +               return;
>=20
> I don't think we ever care about the low bits of the address below the
> page mask, so this one probably wouldn't make any difference.
>=20
> To match the other cases, I'd make it just a plain
>=20
>        WARN_ON_ONCE(start & ~PAGE_MASK));
>=20
> and leave it at that. The existing commit added the warning, but then
> just made the code work despite it all.  I'd continue that same logic.
>=20
>>                if (pmd_large(*pmd) || level =3D=3D PTI_CLONE_PMD) {
>> +                       if (WARN_ON_ONCE(addr & ~PMD_MASK))
>> +                               return;
>>                        target_pmd =3D pti_user_pagetable_walk_pmd(addr);
>>                        if (WARN_ON(!target_pmd))
>>                                return;
>=20
> Again, I think to match the other cases, I'd just do
>=20
> -                       addr +=3D PMD_SIZE;
> +                       WARN_ON_ONCE(addr & ~PMD_MASK);
> +                       addr =3D round_up(addr + 1, PMD_SIZE);
>=20
> which now admittedly clones too much, but _does_ clone the requested rang=
e.
>=20
> But maybe it really doesn't matter, since this condition just
> shouldn't happen in the first place.
>=20
> And arguably, the "clone more than requested" issue is true, and maybe
> your "warn and refuse to clone by returning" is the right thing to do.
>=20
> So I have very few strong opinions in this area, I just reacted to
> looking at the patch that it didn't seem to cover all the cases.

How about we just do:

diff --git i/arch/x86/mm/pti.c w/arch/x86/mm/pti.c
index b196524759ec..0437f65250db 100644
--- i/arch/x86/mm/pti.c
+++ w/arch/x86/mm/pti.c
@@ -341,6 +341,7 @@ pti_clone_pgtable(unsigned long start, unsigned long en=
d,
                }

                if (pmd_large(*pmd) || level =3D=3D PTI_CLONE_PMD) {
+                       WARN_ON_ONCE(addr & ~PMD_MASK);
                        target_pmd =3D pti_user_pagetable_walk_pmd(addr);
                        if (WARN_ON(!target_pmd))
                                return;

So it is a "warn and continue" check just for unaligned PMD address.=20

Thanks,
Song

