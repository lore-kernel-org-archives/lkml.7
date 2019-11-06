Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D70C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 05:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D9E2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 05:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="PGL0YPXA";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="kHjmp3Ly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbfKFFp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 00:45:59 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36786 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725810AbfKFFp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 00:45:59 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA65iE3M017987;
        Tue, 5 Nov 2019 21:45:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=pFUJvKnuMfuYVvDKNgqSZEWE5BCNwPkK3KEraXo9A+U=;
 b=PGL0YPXA1d65c7ee2kowmkSIA+XVBv1rebmJnvvu2FoognHZqOqaEb/tziiQyUCbGtPS
 shJmZhRrLiOEKLeprRe6+Jg8AHaP8ts/kpGzRaYXafGDzeSkUwYIv/SWJEjMVVSawOAN
 waetEP2bSSCERt81ZX+S3onkB5hCQTlu6Y4= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2w3mqb0pwc-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 05 Nov 2019 21:45:45 -0800
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 5 Nov 2019 21:45:43 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 5 Nov 2019 21:45:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irhL4NpyJ8GFYTXP37BoGE0fDmRH3EBd/EYUSDG/Fl4H1u63tYOdRejt1xT88nBOaTrUwvf1mP0hVWuoDVWLwF4xKw+T6c+W6GwnXe2OsNjNOmxmGYPvT/Dkzt+uPL+akDRmby04fv+8Jy4w9WX6iXlrXK4QVItz6Jl3V0RiMSGNbuGNlvLERdj+FdX+GpJ7RTN43eN5ShrKh/1EN3RCn5nhV53IUoCUm/SBwVpO+ZdbYOSHwsQgismWseCEBLvmZ7vMXJylPc6h9Ogxe4Hh/X5YQImjrmXBA8kp+jCEGP5cYXF5gUzeU9olrkI/kvIT8fDTO6aP0LWwZpuTnMyUFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFUJvKnuMfuYVvDKNgqSZEWE5BCNwPkK3KEraXo9A+U=;
 b=iExgQQycxa21Coi4emIeTKM5LkUR07QNY3JifUX83S5mH7WTvYRljgydLeIt/itR7CzQ+1CAp0JKp7oTWOMeYtBvFcyk2xxKAfDDUIot/cNAb1aLXL2PUyb44TneKJ1ceNrEoeIAu6Mi6kCsJMdL7DdLYT0GjcIxebzxVabYXiO/kpxn9nKRqkFC/F1yUAib0Mv5Kaod6fSKYAt2RLCyOUr/4HmKQ1l4ZRqchrHa+5IMJf9utB6T0qaIcx4PHHWRv6IFBhDzNvrvqA8TxPVWKuvDwFLLclZAQroO1eJMz2hvx+LA9DXZWCOPb+WTK2NVuGra92YfxAuFVEts1c2MdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFUJvKnuMfuYVvDKNgqSZEWE5BCNwPkK3KEraXo9A+U=;
 b=kHjmp3LytAIKFqv3FlBTSXV34MM24Hygx+S0+3QFDVDDHYk5zLHpUOUFhjERexVykgMQEOaJndEFZ4XT2n45jWhqKNlZQYHkay9dHLZrYEaS70qI9t/rE54XMWpeiLFHzaX8zM6KSoPW3bscIwOyL9773UgR2xqOHkBNYdeEYR4=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1280.namprd15.prod.outlook.com (10.175.3.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 05:45:41 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5%5]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 05:45:41 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        Kernel Team <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v3] mm,thp: recheck each page before collapsing file THP
Thread-Topic: [PATCH v3] mm,thp: recheck each page before collapsing file THP
Thread-Index: AQHVhd5xLYpzi8cJoUynxajagY1vhadhKiEAgABE9QCAHELcAIAADSqA
Date:   Wed, 6 Nov 2019 05:45:41 +0000
Message-ID: <1C277765-F16E-4818-855C-FB0D1EC23772@fb.com>
References: <20191018180345.4188310-1-songliubraving@fb.com>
 <20191018181712.91dd9e9f9941642300e1b8d9@linux-foundation.org>
 <9DC29F5B-1DF5-408F-BEDF-FD1FBAAB1361@fb.com>
 <20191105205834.aaebbbfead54637d17a84775@linux-foundation.org>
In-Reply-To: <20191105205834.aaebbbfead54637d17a84775@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3601.0.10)
x-originating-ip: [2620:10d:c090:180::b78e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1b0dbb0-bf0d-4f0d-caa7-08d7627c8f34
x-ms-traffictypediagnostic: MWHPR15MB1280:
x-ms-exchange-purlcount: 3
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB1280C3DBFFF1254185C38108B3790@MWHPR15MB1280.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(136003)(376002)(366004)(39860400002)(199004)(189003)(305945005)(66476007)(33656002)(66446008)(66556008)(966005)(64756008)(76116006)(4326008)(316002)(6246003)(2906002)(6486002)(36756003)(229853002)(6506007)(66946007)(102836004)(53546011)(76176011)(8676002)(6512007)(6306002)(5660300002)(6436002)(6116002)(14454004)(186003)(25786009)(71200400001)(14444005)(256004)(6916009)(478600001)(2616005)(446003)(11346002)(486006)(86362001)(81156014)(81166006)(54906003)(7736002)(50226002)(71190400001)(99286004)(8936002)(46003)(476003)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1280;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l9g7qJnjsajy8F4gWqfvAL869EhtLKa5baS3cV+g9VrzBKBxp2oCGDnmKLPr903fSp1nIa/b+mVAjzhmTxXSrHyIQ/O0SlOfx7vweBvKyzIMnRWFQhp+JFEFPBsn9S5ZOoe0X6kWBGfYOtRMXDbhQjlt0AlS5gy5yPacTAupS0Y3cP2gYS1TqpjQy2UMWLrgXWjIv3r3Pehb0N7zUhG0KVuxvXJyXpuBvBHzRlPmb8HzR3RWdQTIkOhB9Ak58e65K6zHws3c+8aeIRheOTALh768xsMNvIiIsRySsSHSjNuER8YbQ3la+YDhDc+vVu3qBrFykpT03Sm4kDrIlRnP0TitOdSEr4ZVU6cbVWLDDT3g4iLUCuLsYbz1sHUa02w1w0QMhlXceT8PpxTQ6hAKhsYHA7Q/3dtuz9TfIpLaVuTyi3pFfUmsGu61iltTGGW/x/gmkSeThIMIDZkDmCUSEW+dvgpHTFLkm63VJW+yvcU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32F903B0D4D2EA4FB32FFA392B373E1D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b0dbb0-bf0d-4f0d-caa7-08d7627c8f34
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 05:45:41.1584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H+J+oNbMT/J+UBLQisKYGUAbM3oeaxhB00GogppC0DAxgjB1cRf0OSEG623+sM8KBTgx65vbs+2IFXXDFjbkpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1280
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_01:2019-11-05,2019-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911060059
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 5, 2019, at 8:58 PM, Andrew Morton <akpm@linux-foundation.org> wro=
te:
>=20
> On Sat, 19 Oct 2019 05:24:00 +0000 Song Liu <songliubraving@fb.com> wrote=
:
>=20
>>> We don't have a ref on that page.  After we've released the xarray lock
>>> we have no business playing with *page at all, correct?
>>=20
>> Yeah, this piece is not just redundant, but also buggy. I am also=20
>> including some information about it.=20
>>=20
>> Updated commit log:
>>=20
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D 8< =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> In collapse_file(), for !is_shmem case, current check cannot guarantee=20
>> the locked page is up-to-date. Specifically, xas_unlock_irq() should not
>> be called before lock_page() and get_page(); and it is necessary to=20
>> recheck PageUptodate() after locking the page.=20
>>=20
>> With this bug and CONFIG_READ_ONLY_THP_FOR_FS=3Dy, madvise(HUGE)'ed .tex=
t=20
>> may contain corrupted data. This is because khugepaged mistakenly=20
>> collapses some not up-to-date sub pages into a huge page, and assumes th=
e=20
>> huge page is up-to-date. This will NOT corrupt data in the disk, because=
=20
>> the page is read-only and never written back. Fix this by properly=20
>> checking PageUptodate() after locking the page. This check replaces=20
>> "VM_BUG_ON_PAGE(!PageUptodate(page), page);".=20
>>=20
>> Also, move PageDirty() check after locking the page. Current khugepaged=
=20
>> should not try to collapse dirty file THP, because it is limited to=20
>> read-only .text. Add a warning with the PageDirty() check as it should=20
>> not happen. This warning is added after page_mapping() check, because=20
>> if the page is truncated, it might be dirty.
>=20
> I've lost the plot on this patch.  I have the v3 patch plus these fixes:
>=20
> http://lkml.kernel.org/r/20191028221414.3685035-1-songliubraving@fb.com
> http://lkml.kernel.org/r/20191022191006.411277-1-songliubraving@fb.com
> http://lkml.kernel.org/r/20191030200736.3455046-1-songliubraving@fb.com
>=20
> and there's a v4 which I can't correlate with the above.  And there has
> been discussion about deferring some of the filemap_flush() changes
> until later.
>=20
> So I think it's best if we just start again.  Can you please prepare
> and send out a v5 (which might be a 2-patch series)?

Sounds good. Sending v5 soon.=20

Thanks,
Song

