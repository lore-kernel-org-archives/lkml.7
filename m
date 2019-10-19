Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9524BCA9EAC
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 05:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531FF20854
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 05:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="h+7narE1";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="UKaWYaZ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfJSFYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 01:24:16 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55508 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727540AbfJSFYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 01:24:16 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9J5Ki0D029812;
        Fri, 18 Oct 2019 22:24:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=hhKUR9Nnvz9d1T6jabtzf0VBPeBRMcBD3JUxZTD7MkA=;
 b=h+7narE1P74yD/k6sACORJk5/sSRcgPWxdTTDbjtaaQOFa6DAv+0G1qtSRgxfKo/6AfW
 9oljmLkvbh0l5YA5IXode8K2Ffi4icrdYSGTkYi7zRp4RWBaq2e+elBuVXwKtYbD1P/t
 M2DDI4i8tkvufBQ5g9mnoJeP4/E2dxGLILg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vq5d8dbp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Oct 2019 22:24:04 -0700
Received: from ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 18 Oct 2019 22:24:02 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 18 Oct 2019 22:24:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcsmCwW4wDECA3h7W9Jl7BC+MaMFjIY8HLAKBkZUUg/MWAL/QwdncU5fVjEllCaG6PpcJlLqOYQtomqSWdy+lyHyohol76AOARcna1Xf28L8sqTOjyJEodCqCHUxg6XvOKI1yZCnSIN2t7X/JDD5cJj9P6GsHMiy1ZF79jmgPyotL/eCRkwz80o2Rr5h5ReoD00xZspGMOkKVQIoqe0AU7Wwy8O5C01RHHm8wIzTHSxVkZS5LpUf30gStIT2MjbAzkQe8TEpdMIng+wq4KZp1uyZ8NXDHxKxH3Hp7zhfHuiHSzalliBFXaR1YQMOLaJLaFFiNIDpjQYthSB4R/tmCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhKUR9Nnvz9d1T6jabtzf0VBPeBRMcBD3JUxZTD7MkA=;
 b=XdrR6B0t9A4Tu4ySZ/q93eJY8JyZg3GjtMX844Q2J/DesRDDpLnIRHLLA43ckWkH3QaEGo/OhEYtN1OmB4GTNAFqItgGOxlGQNGMfiHgnedxzwjw5+dYhk0PKrHZFssNafcSh2aQmlMyXdA+VyhGI161vRVPqHXhNVvxL2GhSPHUriHzlfp7Mnwtu02asefGwsh0B69NdFM60xzVdwX8suWbDNL0XDCyvgCOoW5zkm6ivYOLXjxU7dNY9zw3OCJ+49SzZrM554Y5Um1FZ9Bxb9l3mWKY9bEfFgEGZTOO/ghQg5GdwPGzE4yRooyZ/GNNs72KEbUyL3QZy6pm67u7DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhKUR9Nnvz9d1T6jabtzf0VBPeBRMcBD3JUxZTD7MkA=;
 b=UKaWYaZ3mQInVdENgswOYLB31YZmtxJRPCXctEkCFtPc6oWLLouC6jbR1FUJvXu4HNEN4HyCfc+6EZTMpH/Q3iGyDvpOlSLsGpF0/OY4FI60iLrfl8mJdEXD/+/oHAov0FMHu1y4ibJyJNQPxvbdqVtcorhn2s7FpRDj2l7Iz5Y=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1584.namprd15.prod.outlook.com (10.173.234.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.21; Sat, 19 Oct 2019 05:24:01 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5%5]) with mapi id 15.20.2367.019; Sat, 19 Oct 2019
 05:24:01 +0000
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
Thread-Index: AQHVhd5xLYpzi8cJoUynxajagY1vhadhKiEAgABE9QA=
Date:   Sat, 19 Oct 2019 05:24:00 +0000
Message-ID: <9DC29F5B-1DF5-408F-BEDF-FD1FBAAB1361@fb.com>
References: <20191018180345.4188310-1-songliubraving@fb.com>
 <20191018181712.91dd9e9f9941642300e1b8d9@linux-foundation.org>
In-Reply-To: <20191018181712.91dd9e9f9941642300e1b8d9@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3594.4.19)
x-originating-ip: [2620:10d:c090:180::b337]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31a989e3-2e79-4b08-c8ab-08d754548cb6
x-ms-traffictypediagnostic: MWHPR15MB1584:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB15844B4B1B0E00D13E8A4271B36F0@MWHPR15MB1584.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 01952C6E96
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(346002)(39850400004)(376002)(396003)(189003)(199004)(102836004)(99286004)(486006)(66946007)(476003)(76116006)(66446008)(66476007)(64756008)(66556008)(71190400001)(2906002)(71200400001)(5660300002)(6116002)(11346002)(446003)(14444005)(186003)(76176011)(2616005)(46003)(256004)(53546011)(5024004)(6506007)(33656002)(54906003)(316002)(305945005)(8676002)(50226002)(81166006)(81156014)(14454004)(8936002)(6916009)(7736002)(25786009)(478600001)(86362001)(36756003)(4326008)(229853002)(6436002)(6486002)(6246003)(6512007)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1584;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kwa1WNLrPa+rUjQlXaxNDeiDkvXgOzQFoTlYucD2dkv3WOPdsmbK8FT2aK3aqt/pSO7Njw1n1p3UIHUGE88kypLsCm7DqGZ4AfW5S6ps0RB58oRKpTRleCZrMNAQOq5QBr9v6U94HWN5/W+gyHdAvjrZF/xs/THFf8YcjfCCA0NYyvaYmX2NfInF/i7reexMcPsbdtzFdwKc2oZB3Fa/bqBB0edwTbIu/zIewNAlcgEKNGyybfsBFjLY5PcgH6SbXWYj782cg53i56LTAvGa7LPa2NoLF05TFLkQMU0KVIXYTOXnw2HkAnDUFy3/BzIcZtywotHs0covQxz2SlraM2RwApBgg0N1x+lHc+FFUtDtiylHPpiTs3Rajj+VIUvgz7ppW6DLvTMtT0Y+oTF4Wd7U3R/t8TKYrXKntIk+ZjohmpMSradr6y2TrKN06pPT
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1BC2B7C527BB184C8A960CE6306B5F95@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a989e3-2e79-4b08-c8ab-08d754548cb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2019 05:24:00.9230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kd3nGSiLxO1Mzh9QqU1L5wz6T4d2Vnpt99znTkZp01hyThkrk0ARQWz66P9XTYKAWn/oqtQP46owLhWZBRp5zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1584
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-19_01:2019-10-18,2019-10-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 clxscore=1015 mlxscore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1910190051
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 18, 2019, at 6:17 PM, Andrew Morton <akpm@linux-foundation.org> wr=
ote:
>=20
> On Fri, 18 Oct 2019 11:03:45 -0700 Song Liu <songliubraving@fb.com> wrote=
:
>=20
>> In collapse_file(), after locking the page, it is necessary to recheck
>> that the page is up-to-date. Add PageUptodate() check for both shmem THP
>> and file THP.
>>=20
>> Current khugepaged should not try to collapse dirty file THP, because it
>> is limited to read only text. Add a PageDirty check and warning for file
>> THP. This is added after page_mapping() check, because if the page is
>> truncated, it might be dirty.
>=20
> When fixing a bug, please always fully describe the end-user visible
> effects of that bug.  This is vital information for people who are
> considering the fix for backporting.

The end user effect is, corruption in page cache. While grouping pages=20
into a huge page, the page cache mistakenly includes some pages that=20
are not uptodate, and considers the huge page is uptodate.=20

I am attaching updated commit log to the end.=20

>=20
> I'm suspecting that you've found a race condition which can trigger a
> VM_BUG_ON_PAGE(), which is rather serious.  But that was just a wild
> guess.  Please don't make us wildly guess :(
>=20
> The old code looked rather alarming:
>=20
> 			} else if (!PageUptodate(page)) {
> 				xas_unlock_irq(&xas);
> 				wait_on_page_locked(page);
> 				if (!trylock_page(page)) {
> 					result =3D SCAN_PAGE_LOCK;
> 					goto xa_unlocked;
> 				}
> 				get_page(page);
>=20
> We don't have a ref on that page.  After we've released the xarray lock
> we have no business playing with *page at all, correct?

Yeah, this piece is not just redundant, but also buggy. I am also=20
including some information about it.=20

Updated commit log:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D 8< =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

In collapse_file(), for !is_shmem case, current check cannot guarantee=20
the locked page is up-to-date. Specifically, xas_unlock_irq() should not
be called before lock_page() and get_page(); and it is necessary to=20
recheck PageUptodate() after locking the page.=20

With this bug and CONFIG_READ_ONLY_THP_FOR_FS=3Dy, madvise(HUGE)'ed .text=20
may contain corrupted data. This is because khugepaged mistakenly=20
collapses some not up-to-date sub pages into a huge page, and assumes the=20
huge page is up-to-date. This will NOT corrupt data in the disk, because=20
the page is read-only and never written back. Fix this by properly=20
checking PageUptodate() after locking the page. This check replaces=20
"VM_BUG_ON_PAGE(!PageUptodate(page), page);".=20

Also, move PageDirty() check after locking the page. Current khugepaged=20
should not try to collapse dirty file THP, because it is limited to=20
read-only .text. Add a warning with the PageDirty() check as it should=20
not happen. This warning is added after page_mapping() check, because=20
if the page is truncated, it might be dirty.

Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS"=
)
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: William Kucharski <william.kucharski@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Song Liu <songliubraving@fb.com>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D 8< =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Thanks,
Song


