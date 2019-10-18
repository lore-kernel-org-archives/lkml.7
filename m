Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A225ECA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6591B20854
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="JBADuJeC";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="fKtR1ld0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437264AbfJRQYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:24:37 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41984 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2395015AbfJRQYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:24:36 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9IGMvBZ001365;
        Fri, 18 Oct 2019 09:24:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=4WeceQo0Cwdd4XUZHecOi+Cj4d+/GPJvHep7vKIQRrA=;
 b=JBADuJeCvS0n7KCV5bW+tw0/rBLuU7bFUwFLAQ9VvcuEDgcjH6SNuORO4X6XXpF7clR+
 iWH1XJG2X+iRzbL0fW2gwq3q3/l/PiWsuavctacdwV7Q3KPa4941hrfLIPGHAMFG9gZM
 FGBbUj5fqfAJCOMdLBw5Uh/8iX/e1IVFbEw= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vpw9rcjfh-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 18 Oct 2019 09:24:22 -0700
Received: from prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 18 Oct 2019 09:23:34 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 18 Oct 2019 09:23:34 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 18 Oct 2019 09:23:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEB2jAo41lHCQ5sziqoBhJcwlHQgMPK/7I5ubXJDmc7wQFos+VL0CylWrrcdtSTIZqeUfEWnVtlF0j4vGNUZ0OKhqh/i+fsebROk5nj3KhmHpmBOpgkbg76U+b3rSq6Vg7kOXfRzP0p8spiVcf/SfqeSDLiSegfDwDCnye4LGKJU/+E402zTTOoA6dl55tv+6OoZMOgvDWvTEvk6hFHCBVm1c7I3pEyVRJvSTAeCDj2fP7dgZtIe5Oih2ZuBnSCMZl9tG+QEAlfdig9f3+wO1dyP0czFAgxZFZHuU9fCd3AZdG9IlU+vfYtxzhcrqzb10Rflmy90kq2NoksSI/pf8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WeceQo0Cwdd4XUZHecOi+Cj4d+/GPJvHep7vKIQRrA=;
 b=Qln3n8ZxZmoVIT9owMPIaTtA1w0Ds7D78nnpfH2PgcpCFe2UlcTuKInWePOVKl0B+/bJvZGbWibNwqKFa9lLOq9kTAFT5r+uET4h8yS8tnrcQiOh/NhukmGuy9aUvKoFstdw3GYRo2C3BogVSocsnmjfjt3lbQtdLbaX5fmPYJLxGDgc12B1c5RYApdMA716yQTuFOHEKhBkk69Xy8Jtu9qIA5Vag8DpRCfXBbkzrOpIHvO/+iBOtzc5PsgNi567L9VSs0i+K1rkjnMuvlyjZwAki3grjjJUnU7VK8OCdgXQtuwh5351Dxtfzu7iqCw5AdL+Oh/EVzbOoWSvN5kbIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WeceQo0Cwdd4XUZHecOi+Cj4d+/GPJvHep7vKIQRrA=;
 b=fKtR1ld057S/VGMXJXcy47Ezfg0dsHsTICHNbonzo7ar4c2MOkWYIXPPuNke9Ea+cjZ6H7NnS2OwWO1K1y61MHwkHEW7HaL0prkOttOVtVpX4aqbt3uRIwAfIPQtlyyJD5+f7WjNbyew3hG2LhNJPkdMO5ZMbeBdFF5phjEnr9Y=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1678.namprd15.prod.outlook.com (10.175.137.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 18 Oct 2019 16:23:32 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5%5]) with mapi id 15.20.2367.019; Fri, 18 Oct 2019
 16:23:32 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Rik van Riel <riel@fb.com>
CC:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        Kernel Team <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm,thp: recheck each page before collapsing file THP
Thread-Topic: [PATCH] mm,thp: recheck each page before collapsing file THP
Thread-Index: AQHVhXIoJLumjYar5UidX9eFoK8EPadgZrYAgAAjhQCAAAujgA==
Date:   Fri, 18 Oct 2019 16:23:32 +0000
Message-ID: <6DA3F25A-925D-45E8-84F9-8353E90375A6@fb.com>
References: <20191018050832.1251306-1-songliubraving@fb.com>
 <20191018133444.iif7b33muxmus6lb@box>
 <137ff527ef842a9f46e32557e911c0f221745d6e.camel@fb.com>
In-Reply-To: <137ff527ef842a9f46e32557e911c0f221745d6e.camel@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3594.4.19)
x-originating-ip: [2620:10d:c090:200::d133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5bef5afe-265b-423c-492c-08d753e784c4
x-ms-traffictypediagnostic: MWHPR15MB1678:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB1678CF29E49DD99AF42F556AB36C0@MWHPR15MB1678.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(346002)(396003)(136003)(199004)(189003)(4326008)(7736002)(11346002)(6116002)(2906002)(86362001)(305945005)(6862004)(37006003)(14444005)(316002)(6486002)(5660300002)(446003)(256004)(478600001)(6636002)(476003)(2616005)(486006)(54906003)(25786009)(6436002)(14454004)(71190400001)(71200400001)(102836004)(64756008)(66446008)(66556008)(66946007)(46003)(66476007)(33656002)(6506007)(53546011)(6246003)(4001150100001)(6512007)(186003)(76116006)(36756003)(76176011)(99286004)(8936002)(81156014)(81166006)(50226002)(8676002)(229853002)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1678;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vWLJ89oUGqOMWoomFZXbJEq+ZwVgQpe7wNEQnjOMZIQkwEMutoI9hhIs6hWklqjU9wXcmgdNKrW/ZpZPMyAX1J12ffEJL5GBCvqdk6263wRlbVSlXKgeRVy6R4Rz71zxpLyg8cp6DKjncZqlJsUTaxlHubRrAQR+lzLBP842r4apIRpN1ZJTno3tF+Wi2IyjWCRLs+3ufz+vKXr+K+ezgIwkiyl/ggxtPKTCyYwKMLNRxMW92YSWHDzmbvLLg/ahMztzhlbYSz/Cdg1krOa4IizyUHmowV39V66W2UkExA/yMgOOvf/oBfSnD2wPP5fcpZfJZ3eiSoYz9X2Mgr8QhhDA14RK3jy7gm4s3dwIx7p48N3/QBbtqCPQMsplVl2dSEYr2TEUWRX3JJBUDU0aVZ5PpijOZFQqA/nmZYqcPAY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E53EDEAC1DDAC843A7F7B7218BF057F5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bef5afe-265b-423c-492c-08d753e784c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 16:23:32.4112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hhs75BHzg5mgqzSW+GYP0N1YdiHkyfF1mOW9jsz+H7eo8u2ViIjUcXCDSMxbo3AZffJY45cqeDBFDduK/svHuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1678
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-18_04:2019-10-18,2019-10-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 suspectscore=0 phishscore=0 clxscore=1015
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910180149
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 18, 2019, at 8:41 AM, Rik van Riel <riel@fb.com> wrote:
>=20
> On Fri, 2019-10-18 at 16:34 +0300, Kirill A. Shutemov wrote:
>> On Thu, Oct 17, 2019 at 10:08:32PM -0700, Song Liu wrote:
>>> In collapse_file(), after locking the page, it is necessary to
>>> recheck
>>> that the page is up-to-date, clean, and pointing to the proper
>>> mapping.
>>> If any check fails, abort the collapse.
>>>=20
>>> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-
>>> shmem) FS")
>>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>>> Cc: Hugh Dickins <hughd@google.com>
>>> Cc: William Kucharski <william.kucharski@oracle.com>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Signed-off-by: Song Liu <songliubraving@fb.com>
>>> ---
>>> mm/khugepaged.c | 8 ++++++++
>>> 1 file changed, 8 insertions(+)
>>>=20
>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>> index 0a1b4b484ac5..7da49b643c4d 100644
>>> --- a/mm/khugepaged.c
>>> +++ b/mm/khugepaged.c
>>> @@ -1619,6 +1619,14 @@ static void collapse_file(struct mm_struct
>>> *mm,
>>> 				result =3D SCAN_PAGE_LOCK;
>>> 				goto xa_locked;
>>> 			}
>>> +
>>> +			/* double check the page is correct and clean
>>> */
>>> +			if (unlikely(!PageUptodate(page)) ||
>>> +			    unlikely(PageDirty(page)) ||
>>> +			    unlikely(page->mapping !=3D mapping)) {
>>> +				result =3D SCAN_FAIL;
>>> +				goto out_unlock;
>>> +			}
>>> 		}
>>>=20
>>> 		/*
>>=20
>> Hm. But why only for !is_shmem? Or I read it wrong?
>=20
> It looks like the shmem code path has its own way of bailing
> out when a page is !PageUptodate. Also, shmem can handle dirty
> pages fine.

Seems the PageUptodate check is still necessary for shmem?=20
shmem_getpage() makes sure the page is uptodate, but these is still
a small window that the page could become !uptodate.=20

>=20
> However, I suppose the shmem code might want to check for truncated
> pages, which it does not curretnly appear to do. I guess doing
> the trylock_page under the xarray lock may protect against truncate,
> but that is subtle enough that at the very least it should be
> documented.

Johannes pointed out in our internal code review that, there is=20
already a page_mapping() check later in the function.=20

PageDirty check is only necessary for !is_shmem. And it should not=20
happen, because we only support read-only text. Adding a warning for
it. Also, move PageDirty check to after page_mapping() check, because
if truncate happens, the PageDirty doesn't violent the read-only
assumption.=20

Overall, I guess we need something like:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D 8< =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git c/mm/khugepaged.c w/mm/khugepaged.c
index 0a1b4b484ac5..40c549302d36 100644
--- c/mm/khugepaged.c
+++ w/mm/khugepaged.c
@@ -1626,7 +1626,12 @@ static void collapse_file(struct mm_struct *mm,
                 * without racing with truncate.
                 */
                VM_BUG_ON_PAGE(!PageLocked(page), page);
-               VM_BUG_ON_PAGE(!PageUptodate(page), page);
+
+               /* double check the page is up to date */
+               if (unlikely(!PageUptodate(page))) {
+                       result =3D SCAN_FAIL;
+                       goto out_unlock;
+               }

                /*
                 * If file was truncated then extended, or hole-punched, be=
fore
@@ -1642,6 +1647,15 @@ static void collapse_file(struct mm_struct *mm,
                        goto out_unlock;
                }

+               /*
+                * khugepaged should not try to collapse dirty pages for
+                * file THP. Show warning if this somehow happens.
+                */
+               if (WARN_ON_ONCE(!is_shmem && PageDirty(page))) {
+                       result =3D SCAN_FAIL;
+                       goto out_unlock;
+               }
+
                if (isolate_lru_page(page)) {
                        result =3D SCAN_DEL_PAGE_LRU;
                        goto out_unlock;

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D 8< =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Thanks,
Song

