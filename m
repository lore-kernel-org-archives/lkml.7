Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE98FC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 23:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203C0206EC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 23:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ZwpNdlXw";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="bcdap1Sx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfKMXsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 18:48:31 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:16948 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726251AbfKMXsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 18:48:31 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id xADNlHMg007897;
        Wed, 13 Nov 2019 15:47:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=mBmSraaEaF9DUeaJ3Etn9zpj9Rv9ta3zkR2HE/a1Av8=;
 b=ZwpNdlXwLKa75KzT4yrLHlmpzLqZvtahBmGO18VAsSu0g849kYaFl7dF3/1p3mFSE21Y
 oTUQssXc+wxSlaDlsra2noLPKHXVUu9aBEbXdfg3qbITNoO22ngqb7jFg6CLJH4pbGZj
 ZWuLpA/g0zr6C1bcEaoU9Fp8sYNGQ5EAGlA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2w8jxpjyrt-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 Nov 2019 15:47:18 -0800
Received: from ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 Nov 2019 15:47:07 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 13 Nov 2019 15:47:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Izffefkf83YDb7z6sEjPYXWAIFIDs/zMaNExA8xij0wsuF2cIwQluYQqNKLvQ2yDOeZheIANfOcDOZ5ZB2wKiSv+/3jAk7lB4rUjpp/HrlPuZee+YoPs/7E+L449Ig+Ll2UiROVYCImQAqV/Gf4JAdKBZMpIl+10zzJ00/jNT8U+dUK1TmRnAvogo/mccOXwI8e+ZLn9J7OrKtZaiA/AuOCysG+J83WyQsUa0RKaxDCITTVNlP6xPnRKl8AYD+W+4oXjteBWmlbqZVw77oxl2LjSTHAaodtADa0GmnAvzUrFOua2yf54BtuAQiKtQR5OrAWdqXTECW62CztbLFLtCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBmSraaEaF9DUeaJ3Etn9zpj9Rv9ta3zkR2HE/a1Av8=;
 b=TL99EKAhp07Cfv+2jWRmxUcD6IKb7KfxFT2kRUWOcej4hMMkEag70ZXS8cBeNMtzrQhajw12HWWciI9z08hq+rWw7IfvI40w39KT1/I8FX2pFDl58sUvYBsz9z0ZzrrQZ5ba7CmGqdpvLLl+E7FBDMFIOiMaXjN9pd08OkpDt5xE3zeFjTJOPoBPUx5L2Pm4O6965qelh8abqvBWI2kzOEmYAkQSSSwtq/ZTPc4CBfsOJxZWSxj7Xk/tYLDQQnUnyN1Z21NXENniYAYq/vTyoSp96HaAZsUOwKJmk0O+n+Iob8+S5WTm1TENZD87pWzy1htEbMyZc9PobLjd6Nfjng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBmSraaEaF9DUeaJ3Etn9zpj9Rv9ta3zkR2HE/a1Av8=;
 b=bcdap1Sx10VgQ3MCDxZBtJ7WCi0GWDb8dfS/a/Zc2DANogrV3Rk3wiZ8a7hp+Ves0rdawR+40ZROXEiOTJylhgmPYS2zQK2WPqXfJZDjKpwPHFv231tKIKBg3PveLZXXdZwWNqBn7WYZMQeLe5pxPCYFwTwO3QLwiSs6u4fqRCM=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1534.namprd15.prod.outlook.com (10.173.235.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Wed, 13 Nov 2019 23:47:07 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f831:d112:6187:90d9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f831:d112:6187:90d9%4]) with mapi id 15.20.2451.024; Wed, 13 Nov 2019
 23:47:07 +0000
From:   Song Liu <songliubraving@fb.com>
To:     open list <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        Kernel Team <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Hugh Dickins" <hughd@google.com>
Subject: Re: [PATCH v5 1/2] mm,thp: recheck each page before collapsing file
 THP
Thread-Topic: [PATCH v5 1/2] mm,thp: recheck each page before collapsing file
 THP
Thread-Index: AQHVlGjXjTBN2suIgEyiHRjQ3h6QAaeJ0HOA
Date:   Wed, 13 Nov 2019 23:47:06 +0000
Message-ID: <60961DFB-32CB-4E56-8921-B2945E8BCB88@fb.com>
References: <20191106060930.2571389-1-songliubraving@fb.com>
 <20191106060930.2571389-2-songliubraving@fb.com>
In-Reply-To: <20191106060930.2571389-2-songliubraving@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3601.0.10)
x-originating-ip: [2620:10d:c090:180::fe39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e59ff46-a858-47d5-b622-08d76893caec
x-ms-traffictypediagnostic: MWHPR15MB1534:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB1534693ADB5822BF205D26B8B3760@MWHPR15MB1534.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(366004)(39860400002)(396003)(199004)(189003)(25786009)(4326008)(5660300002)(6486002)(64756008)(66476007)(66556008)(66446008)(66946007)(6116002)(6246003)(478600001)(76116006)(7736002)(86362001)(316002)(305945005)(76176011)(110136005)(99286004)(102836004)(46003)(50226002)(2906002)(486006)(476003)(8936002)(11346002)(54906003)(71190400001)(446003)(6512007)(71200400001)(14454004)(6436002)(33656002)(256004)(14444005)(229853002)(186003)(2616005)(8676002)(81156014)(36756003)(81166006)(6506007)(53546011)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1534;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PQREvANHeMQD3O8Pk3IVyg9U5MWzqlWsF//LSdtOEBmJLjS8Lcmv6uJliZ7a+ucVMv72XsyAmsB5uGKRMqL3ULb75EUm2UGjuh14se6ytFcZPdlSgBzW7QK8YOj7DSvBA51pWR3UqgqraaQ3H3syYBMxOMLKGRVQ+LI0ahOjTP9g3BhiqX6f/Khr95cXyj2ECDc0fykd1aPkKjA7WPhF9T1B7MALb5VhfXlxck6hqwa1Jgf+HUXNeDZI8yX3m4UWFoIfP7hTa/R4UjvPq/YZQnl90Rmuk1QWrZgJMgMZ8BvLosljZtYBOVfVpdtVn7GijeAzsAgIBuUiSaUORxJpxw/T9pIgcbp67wgdlpNAdcb56U4qnLGkl2U+qOBRHXq8egMIejFK3qhl75C7GhNENFK2FxW4H9G9C2xaBXgM57ktLnfdZ+HV9z5XjzmTxR8o
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9C4F0833F591BF4DAC401102AE13917A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e59ff46-a858-47d5-b622-08d76893caec
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 23:47:06.7857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wP8sd8v73a7AVEepptlMPR5ceTOFoNOOnQWf1sk2ffp/y6LYfLmUpp/Ce7YV6SXvbHno2FHkKhQ7N4CFvx/m4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1534
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-13_06:2019-11-13,2019-11-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 impostorscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911130200
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Nov 5, 2019, at 10:09 PM, Song Liu <songliubraving@fb.com> wrote:
>=20
> In collapse_file(), for !is_shmem case, current check cannot guarantee
> the locked page is up-to-date.  Specifically, xas_unlock_irq() should
> not be called before lock_page() and get_page(); and it is necessary to
> recheck PageUptodate() after locking the page.
>=20
> With this bug and CONFIG_READ_ONLY_THP_FOR_FS=3Dy, madvise(HUGE)'ed .text
> may contain corrupted data.  This is because khugepaged mistakenly
> collapses some not up-to-date sub pages into a huge page, and assumes
> the huge page is up-to-date.  This will NOT corrupt data in the disk,
> because the page is read-only and never written back.  Fix this by
> properly checking PageUptodate() after locking the page.  This check
> replaces "VM_BUG_ON_PAGE(!PageUptodate(page), page);".
>=20
> Also, move PageDirty() check after locking the page.  Current
> khugepaged should not try to collapse dirty file THP, because it is
> limited to read-only .text. The only case we hit a dirty page here is
> when the page hasn't been written since write. Bail out and retry when
> this happens.
>=20
> syzbot reported bug on previous version of this patch.
>=20
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) F=
S")
> Reported-by: syzbot+efb9e48b9fbdc49bb34a@syzkaller.appspotmail.com
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: William Kucharski <william.kucharski@oracle.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Song Liu <songliubraving@fb.com>

I think we need this in 5.4 official, but I haven't seen it in Linus'=20
master branch.=20

Hi Andrew,

Could you please send patch/pull-request for it?=20

Thanks,
Song=
