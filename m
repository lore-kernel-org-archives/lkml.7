Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF83DC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 10:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4499214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 10:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="fyfy2qRw";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="JdL/LaOY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbfIRKlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 06:41:01 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:61600 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727697AbfIRKlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 06:41:00 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id x8IAdCYX004236;
        Wed, 18 Sep 2019 03:40:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=JYsRpnux6xKCfJ64Rv5tykvQJW8Z4a1It7legsrue5M=;
 b=fyfy2qRw+dv+sT8PdPH6rp4E23qMdtD7z6bKT0nLHWWO2RXll9d6UnWUuO/ckaDNt8kQ
 Mkn96z1TTiAD8R43REIwaoKuKWC5KfdHFZrOGAhyi1MOLQpWSsPra5+3+Wo2c5Phr4nT
 Fc784dVpCfw+civEqp1pMPTOlHwp4RDMVBY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2v37kh29be-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 18 Sep 2019 03:40:45 -0700
Received: from ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Sep 2019 03:40:44 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 18 Sep 2019 03:40:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPQ76zxj1gu65etulv2NibaAV7HiBcTl+v7azmrpAIHyAYhWIIGy/3H9ZRXm8oSLR1+cmBrQL9fsE/2aEGLHfn2XZaOlCm2BqPEEl/5YJhmuMhTrflbXrxE1Eg2g4JGjh40DE+wUC+cJ9cy0ipv2xW2C/C7wVVRQaVo1JXIkkuJ7beZqemphI9E0dp9ltG0SKasb5sbW5GQh38J3sItVCl7qzUx0X9HGSya34onaDRKnv1JGrHPCEZ2Ki1Tm8UISl3VlCKcC0rsIOe3nJOBNcDnUgRPTSWQKK8vMHQoNkbxd9PB47U6JtvLv3pkfm58F6vipWSsX0pPL4sBUAHsPIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYsRpnux6xKCfJ64Rv5tykvQJW8Z4a1It7legsrue5M=;
 b=QA3NUSI3Gq0xAZSmyxJo83AIpdxybkMYsO8NEi9Sfm2dttFip3qMJGWi4M3WPAnyl0UoFCXGQgXP9anALuZXhN9ycOS8oeROunFJdBM3RIvoGb5NPgYiakCBxIjy3XRWUlkZmIPMHVrmhMEOUEDbyCRTOKy8ufRFURV3VLnzi5mKm22wW8Yrp2DqHoskUR+5FFHQAUsyRZLNy74ETxjaAdmUIQZpCKJ3DgPsfhK8P/DoFyJPXNpw+nXX0xe1kmak7zGfzIjCD/ysTYJn9dYf8ayy2/6oY+fgZnjQYxf12hPcbbQhl/wvjsynieeuIymlcxDCc2ep7/od00AEOUg52Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYsRpnux6xKCfJ64Rv5tykvQJW8Z4a1It7legsrue5M=;
 b=JdL/LaOY7917TtwXi7k7HY33o19nyJ4K3ZemwI817pTxxmK48FqVfaMu4hODPF+C8FJ51gKwNOAx6wNa2x6M1uQ9Y6b3d5eFnMQBtv2BmihfqNXLxzpUIP8FYVoTINuMmCWAfadpzxpZwDHRLW+xcIxw9M+MXY7M1+OuDm1yukE=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1661.namprd15.prod.outlook.com (10.175.140.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.23; Wed, 18 Sep 2019 10:40:43 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a828:5750:379d:b9a1]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a828:5750:379d:b9a1%8]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 10:40:43 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] x86/pti for 5.4-rc1
Thread-Topic: [GIT pull] x86/pti for 5.4-rc1
Thread-Index: AQHVbYOndIwm8vXaKE+EAjtQudNonacwNgoAgAADq4CAAEqGgIAAAf8AgAC5yAA=
Date:   Wed, 18 Sep 2019 10:40:43 +0000
Message-ID: <C6FC577A-A589-46FD-92FE-5C441BDB922D@fb.com>
References: <156864062018.3407.16580572772546914005.tglx@nanos.tec.linutronix.de>
 <156864062019.3407.14798418565580024723.tglx@nanos.tec.linutronix.de>
 <CAHk-=wjQJaNbQe3fmFU19_wawkx-WT9Sv=h5mWCA9=LL34g_3Q@mail.gmail.com>
 <CDB07BE3-6491-4159-89E7-FBA1631A01C3@fb.com>
 <CAHk-=whbOhAmc3FEhnEkdM9AXFuKM+964r+uzzm_Q9qFaxTC7g@mail.gmail.com>
 <E4AF8E4C-A307-4AE7-85AA-F579D5BFDBDD@fb.com>
 <CAHk-=wisZfwwJo57BRigT5X_uWs6Jw4K3ezPSwCSMBHSeJTHzg@mail.gmail.com>
In-Reply-To: <CAHk-=wisZfwwJo57BRigT5X_uWs6Jw4K3ezPSwCSMBHSeJTHzg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::7f90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eff79469-21f2-4d56-ccb5-08d73c24a83e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR15MB1661;
x-ms-traffictypediagnostic: MWHPR15MB1661:
x-microsoft-antispam-prvs: <MWHPR15MB166191771D39E55A21342EAEB38E0@MWHPR15MB1661.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(366004)(376002)(346002)(39860400002)(189003)(199004)(446003)(6916009)(478600001)(50226002)(46003)(71200400001)(2906002)(5660300002)(4326008)(25786009)(256004)(14454004)(305945005)(64756008)(66476007)(36756003)(76116006)(7736002)(66446008)(6512007)(66946007)(66556008)(99286004)(6436002)(6246003)(6116002)(71190400001)(102836004)(476003)(86362001)(6506007)(6486002)(11346002)(2616005)(186003)(8936002)(33656002)(486006)(54906003)(229853002)(76176011)(8676002)(81156014)(81166006)(316002)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1661;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rbkDg4Vd/y8lWoZvxSQ144Glg9ok1ZkaDUqVnl/jYa/zOf0hmKOzXylGf31c9tlvQkrAFRJlO/Wws1FNaBipQD8V6TIxwuSLVXR+6yEtIdCzyZ19mtmUI+CIXmcbdQkfATYnN6CaQ9Vd7U+Q85DgV3y0V224DXfGPJl90OE0UYw5oDLHtsRuX90oahN2DNXAwmN48jjmsxk0/FYBdsS7DwGjPvsmR01OECH/qXP9YQsZIc3da6/B7WBMXYmKGFd/8BI2OD3NaoqNKwRwu6FYm8MVxLTBwLSkpHp1pn/JVzLcROCe5wftc8Zh7d7HJuW8pS4MW8rf1Yld2aw4VPxZrkybGc0JBqSXwHZE3kApse1YzI8ui3BzSg7E+VaWq1uhzUDGkbdisu9xw2YGozKYMrkGEsYBpXtChAnxTWybcII=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28B7B460F012B148B53A1DC3F4CE644E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: eff79469-21f2-4d56-ccb5-08d73c24a83e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 10:40:43.3472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BgnDy/GRyBctIXbRJ9uWS+wDg4w8/TP/AYvr52tv722u7K930wl0ztJfgeYfK6rdiy9QX0r8cWeQL4rhCp5I2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1661
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-18_06:2019-09-17,2019-09-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909180107
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 17, 2019, at 4:35 PM, Linus Torvalds <torvalds@linux-foundation.or=
g> wrote:
>=20
> On Tue, Sep 17, 2019 at 4:29 PM Song Liu <songliubraving@fb.com> wrote:
>>=20
>> How about we just do:
>>=20
>> diff --git i/arch/x86/mm/pti.c w/arch/x86/mm/pti.c
>> index b196524759ec..0437f65250db 100644
>> --- i/arch/x86/mm/pti.c
>> +++ w/arch/x86/mm/pti.c
>> @@ -341,6 +341,7 @@ pti_clone_pgtable(unsigned long start, unsigned long=
 end,
>>                }
>>=20
>>                if (pmd_large(*pmd) || level =3D=3D PTI_CLONE_PMD) {
>> +                       WARN_ON_ONCE(addr & ~PMD_MASK);
>>                        target_pmd =3D pti_user_pagetable_walk_pmd(addr);
>>                        if (WARN_ON(!target_pmd))
>>                                return;
>>=20
>> So it is a "warn and continue" check just for unaligned PMD address.
>=20
> The problem there is that the "continue" part can be wrong.
>=20
> Admittedly it requires a pretty crazy setup: you first hit a
> pmd_large() entry, but the *next* pmd is regular, so you start doing
> the per-page cloning.
>=20
> And that per-page cloning will be wrong, because it will start in the
> middle of the next pmd, because addr wasn't aligned, and the previous
> pmd-only clone did
>=20
>                        addr +=3D PMD_SIZE;
>=20
> to go to the next case.
>=20
> See?

I see. This is tricky.=20

Maybe we should skip clone of the first unaligned large pmd?

diff --git i/arch/x86/mm/pti.c w/arch/x86/mm/pti.c
index 7f2140414440..1dfa69f8196b 100644
--- i/arch/x86/mm/pti.c
+++ w/arch/x86/mm/pti.c
@@ -343,6 +343,11 @@ pti_clone_pgtable(unsigned long start, unsigned long e=
nd,
                }

                if (pmd_large(*pmd) || level =3D=3D PTI_CLONE_PMD) {
+                       if (WARN_ON_ONCE(addr & ~PMD_MASK)) {
+                               addr =3D round_up(addr, PMD_SIZE);
+                               continue;
+                       }
+
                        target_pmd =3D pti_user_pagetable_walk_pmd(addr);
                        if (WARN_ON(!target_pmd))
                                return;

Or we can round_down the addr and copy the whole PMD properly:

diff --git i/arch/x86/mm/pti.c w/arch/x86/mm/pti.c
index 7f2140414440..bee9881f2e85 100644
--- i/arch/x86/mm/pti.c
+++ w/arch/x86/mm/pti.c
@@ -343,6 +343,9 @@ pti_clone_pgtable(unsigned long start, unsigned long en=
d,
                }

                if (pmd_large(*pmd) || level =3D=3D PTI_CLONE_PMD) {
+                       if (WARN_ON_ONCE(addr & ~PMD_MASK))
+                               addr &=3D PMD_MASK;
+
                        target_pmd =3D pti_user_pagetable_walk_pmd(addr);
                        if (WARN_ON(!target_pmd))
                                return;

I think the latter is better, but I am not sure.=20

Thanks,
Song

