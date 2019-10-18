Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6201ECA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E95222C5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Oe3vX2NE";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="QkGjm1Ce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502098AbfJRR12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 13:27:28 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42142 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2634465AbfJRR11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 13:27:27 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9IHJKk7025812;
        Fri, 18 Oct 2019 10:27:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Tk2U34DE0PIYArCIK172NEMrbXVLFZYYIjfVWo2skGA=;
 b=Oe3vX2NEJ/R9wJleWUUbOE0E/5aUDdGcZNmuKwJti0/5lDwsEWz9qZ1gHl5ySm/ONjo4
 sw29p50Iq8b5tZ376yDjjQefBHKnCxrhWwmnomFyb9963voV5qMEG0qqn8SUAQFrMW3C
 UGQDDPWEMzXyiJB/UwdnCemKk+xxv+PjfQI= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vqguv89sp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 18 Oct 2019 10:27:15 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 18 Oct 2019 10:27:13 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 18 Oct 2019 10:27:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEHy6z0bSrfnGKLN2ZcZBNEg3NaUFmpxg6TGJdSzLC+Byl88UYzQxDrJbOUe5/jHEHp48cMk8+1AOTW9um/YLAPwenjcNSQGT9XQa296a79qIzRIcHpa3C2ku74v1xl6jb8JTMFHwFBLvoAIsb6qi7WGo6LB1rl//VK6x9hsQ2j2W04i4AhU1Bndzuii8TkMP4WZGw01ErGcQho9DJaU/GffuyR0Tapn6ZVuPj6vhdDwtaP3MEemAZ6XlQlfi7Cd7XVjtyD15h/8prJZgCtIltrdhsWTQsWluYRuJR9xmJFvTMTnFfL10s69aDHg9GOkQw1KJCYjO3YaWuhHCyHhXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tk2U34DE0PIYArCIK172NEMrbXVLFZYYIjfVWo2skGA=;
 b=CyZTfJkepndYCAhEr7Ia8OgrQxSHVwSHAdgRD8DtyUkeWUTSl2uEUg7NhLuwyljI9FeIaeT2VvNx8hIfCpHWqOH1dtcWsLXt4XwRMXSca+6QVkGNvGx2/gD32DWO/HGcasbhrYsdNFT1aURqAUgkvnO37FcETiUppnmzEH+uPbrSPj7F8lUXrHbvkgFAnvqPQV3v/bfaBGFVElPjdSiuG9N5qHSgf6yXK2Yi8fJ6evAK/qijCdHv4qry+eAjXH+bq3jXNC3dE4BxV62Usf4J7o+VY+Qcw7OrNkxOEQ/jGKB9h8ZFUDpCoKzfjZZj55GCAhaGNTWfHgZzpKVKttdl3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tk2U34DE0PIYArCIK172NEMrbXVLFZYYIjfVWo2skGA=;
 b=QkGjm1CewT3G51+J/yFPwWI4aERueCBV3SU0puo25D2Nn1CPYmtx6DRfw0DdTEnWGZk8zrCnNtpRr199KCFOz1FjaY4NzVk92b7e1Oxd7TSMR9VaECB6nIm1z1H5bnr4pJRz3gENZmGGS7VH13o3Ye/HsbgMIuSleVW1ZbCuZhY=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1422.namprd15.prod.outlook.com (10.173.234.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 18 Oct 2019 17:27:12 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5%5]) with mapi id 15.20.2367.019; Fri, 18 Oct 2019
 17:27:12 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        Kernel Team <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Hugh Dickins" <hughd@google.com>
Subject: Re: [PATCH v2] mm,thp: recheck each page before collapsing file THP
Thread-Topic: [PATCH v2] mm,thp: recheck each page before collapsing file THP
Thread-Index: AQHVhdJpENZJXtqpok2fOupB1uQ0i6dgnG+AgAAChQCAAAf0AA==
Date:   Fri, 18 Oct 2019 17:27:12 +0000
Message-ID: <696F8683-9A4B-4CD7-A96A-1E68E6A92E02@fb.com>
References: <20191018163754.3736610-1-songliubraving@fb.com>
 <20191018164943.GA179426@cmpxchg.org> <20191018165844.GB179426@cmpxchg.org>
In-Reply-To: <20191018165844.GB179426@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3594.4.19)
x-originating-ip: [2620:10d:c090:200::d133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77fa8f69-2a35-4ad6-41c7-08d753f069c6
x-ms-traffictypediagnostic: MWHPR15MB1422:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB1422A777B5AE65502F08D9A8B36C0@MWHPR15MB1422.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(376002)(396003)(39860400002)(189003)(199004)(478600001)(476003)(81166006)(316002)(99286004)(66946007)(86362001)(256004)(66476007)(6486002)(2906002)(6436002)(14444005)(36756003)(486006)(8676002)(14454004)(81156014)(33656002)(5660300002)(2616005)(11346002)(76116006)(66556008)(64756008)(66446008)(71200400001)(71190400001)(25786009)(50226002)(6506007)(53546011)(305945005)(4326008)(7736002)(54906003)(446003)(6916009)(46003)(6512007)(186003)(229853002)(6246003)(76176011)(102836004)(8936002)(6116002)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1422;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ayOKAumH0bWePmPxLpYXMkHGxEM3M+gV/qbcb20r7jrplXhoQgDRdfoJVzuH7lUfwRXLJranwzqrNH1JnHXwQx++2GBggt8mUJWqxJbzfwkO34s5oMSr8p0BioLp7XzZ/DJc2tgtHKy6HnvLw790Dq90C+4H2kIcRPQcSfLtw7NRXvu05Rbc/vwQxpiHRjGtPwSqdBBW406pHjP6bX0Z9Wv24rYHff+Gt45/8IqkKGpapYgw8GUzw6cucWCjiVQ91pVzcmgJfPjrel55TRny0/Rt34TPOv9ICRw1WRxoQ3UwWU7wHHxlrAY57ETQV056xxNYWCJ5QeoDgAtGxtXNPGr0nmu5V/imxmyLX1tETOgdUVTZUgpwy+fc/98vE7y3tf07imt2yytzOYm9X6AvM+w7sudH/NnsVSArLJyx6xw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A6B4224FEE174F4BAE484202F096EC25@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 77fa8f69-2a35-4ad6-41c7-08d753f069c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 17:27:12.6792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NBUSQRMkfdrg4AqKiVJ6WqVt07Z8YX9zIyzQ5eVtA7gpk6S8SiXj9ZlZ1HX9c9DaKbzIc1h9VHf6mqz5ECbuag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1422
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-18_04:2019-10-18,2019-10-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910180158
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 18, 2019, at 9:58 AM, Johannes Weiner <hannes@cmpxchg.org> wrote:
>=20
> On Fri, Oct 18, 2019 at 12:49:46PM -0400, Johannes Weiner wrote:
>> On Fri, Oct 18, 2019 at 09:37:54AM -0700, Song Liu wrote:
>>> In collapse_file(), after locking the page, it is necessary to recheck
>>> that the page is up-to-date. Add PageUptodate() check for both shmem TH=
P
>>> and file THP.
>>>=20
>>> Current khugepaged should not try to collapse dirty file THP, because i=
t
>>> is limited to read only text. Add a PageDirty check and warning for fil=
e
>>> THP. This is added after page_mapping() check, because if the page is
>>> truncated, it might be dirty.
>>>=20
>>> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem)=
 FS")
>>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>>> Cc: Hugh Dickins <hughd@google.com>
>>> Cc: William Kucharski <william.kucharski@oracle.com>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Signed-off-by: Song Liu <songliubraving@fb.com>
>>=20
>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>=20
> We should also be able to remove the unlocked tests for those two
> conditions, right?

Yeah, I think we can remove them.=20

Thanks,
Song

>=20
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 0a1b4b484ac5..a3ef6ce86bfa 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1601,17 +1601,6 @@ static void collapse_file(struct mm_struct *mm,
> 					result =3D SCAN_FAIL;
> 					goto xa_unlocked;
> 				}
> -			} else if (!PageUptodate(page)) {
> -				xas_unlock_irq(&xas);
> -				wait_on_page_locked(page);
> -				if (!trylock_page(page)) {
> -					result =3D SCAN_PAGE_LOCK;
> -					goto xa_unlocked;
> -				}
> -				get_page(page);
> -			} else if (PageDirty(page)) {
> -				result =3D SCAN_FAIL;
> -				goto xa_locked;
> 			} else if (trylock_page(page)) {
> 				get_page(page);
> 				xas_unlock_irq(&xas);

