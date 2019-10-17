Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DA7ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE1E21848
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="HKVngKUe";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="amYFjFXA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408497AbfJQQhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 12:37:48 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43472 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729529AbfJQQhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:37:47 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9HGYW0P026409;
        Thu, 17 Oct 2019 09:36:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=8Rrs1IRGwq3s202ySc88aWRth2YdLrFqD3hHUZKdj6c=;
 b=HKVngKUeaHg7Tk8NkP32H6d8H1xpnoYOi0FojVLFTM9tB0AHB4WFqij1pJ1RGQln6DKo
 joFSQL7MLmu8oRBDg9/j24qoYR8U2P685tPfioOw3uGrf28WMnwA2n+6MDpHHdxuHOUL
 AaXMhVx3HeBtym6kmVyAuhJb7e4VVQjOKEk= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vp84ad0q3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 17 Oct 2019 09:36:12 -0700
Received: from prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 17 Oct 2019 09:36:11 -0700
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 17 Oct 2019 09:36:11 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 17 Oct 2019 09:36:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGZFGr6S1223dnigkvAT/0PPIXJb1ofBiE8shaMjWmqQ1xfaC3cbQYL1h822JtTReJ31gGykdE88uiExm+uHa3UbRY6aEDlVA7SeXfMRFwvblvfD3igKnaOuuwllh4ClQJRnVmAT5zDrwr3ie2qkKiqBX/EBsQFfMPXq77DXXQJqRs4RmhY/mMoA/mwzuD9MRHpcNstavkPvFscAKZJPlaRmUeq0u8Oq6azZNeRlq0yuoTPGFT0hn6kcj0UQNkQK4nrqnI96k6CTGi3EhQH2Pecajyc5AwXXZqXihSIpLXNAYHFNkLInd9zcLDGhlkXSKDoDxt+TDzrKg7ea2/PZvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Rrs1IRGwq3s202ySc88aWRth2YdLrFqD3hHUZKdj6c=;
 b=i7YWSW43Y4BG8Suzl9BubCdLZ14o9uE9SxuCG7jKSvyAj7h4nNbjmBpz7c6jgTfHPQPUOg1ZHTAMoV7xqfr0xYHji0l24SCXITrLeiQ4zS3Yo3JXP7MEOk8NaNSmjj+YNjcpd3g5Q1wORusUaAVgciFVrXLRpPntbHot2RgKLE/zcFQmw36DsLjPiz3ocMqO15yr2jDUmmz/Z9qIMFBGqS5XL4LtE3aBQk/yEnnroDvGcRZPcWMIXtBrQsyFkDdrRPc4ClFb1nrAiDYupkFqhjOrOvpHLBJBRQvIUBu6fQ0C1o936I0Kr7pifk0FxbcnHyV00qQw8s3LEu9ALyusCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Rrs1IRGwq3s202ySc88aWRth2YdLrFqD3hHUZKdj6c=;
 b=amYFjFXAk2m4v4IIJVwLP9uvTbnPL1OFhbqhvCf1LJDCvOIBWVA9/GNIS2PLGHq2NdodoD7zd7ThZ6APHrOd319FTqvCezFrTE8H2HDii5oPsp0Z1oOfFNc8KTc5iqJ8umOdh91ahPe1j0pQtec7AKp4v8zHrMzEGo4XgEsddj0=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1677.namprd15.prod.outlook.com (10.175.135.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 17 Oct 2019 16:36:10 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5%5]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 16:36:10 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        Kernel Team <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 3/4] mm/thp: allow drop THP from page cache
Thread-Topic: [PATCH 3/4] mm/thp: allow drop THP from page cache
Thread-Index: AQHVg/S/lxP9PA87AUCNpb/0TXt8KadfA4SAgAAGhgA=
Date:   Thu, 17 Oct 2019 16:36:10 +0000
Message-ID: <86D18025-63EA-4DA8-88C4-11F0E70FBD6E@fb.com>
References: <20191016073731.4076725-1-songliubraving@fb.com>
 <20191016073731.4076725-4-songliubraving@fb.com>
 <20191017161247.GK32665@bombadil.infradead.org>
In-Reply-To: <20191017161247.GK32665@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3594.4.19)
x-originating-ip: [2620:10d:c090:200::1:4c3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd31c608-231b-41df-6063-08d753201dec
x-ms-traffictypediagnostic: MWHPR15MB1677:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB16776C66E1AA5D231C76204FB36D0@MWHPR15MB1677.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(366004)(376002)(346002)(39860400002)(189003)(199004)(6486002)(64756008)(66556008)(6116002)(6916009)(99286004)(6436002)(102836004)(11346002)(5660300002)(14444005)(256004)(6506007)(76176011)(229853002)(66446008)(6512007)(6246003)(66946007)(4326008)(86362001)(2906002)(486006)(2616005)(476003)(76116006)(53546011)(446003)(186003)(46003)(66476007)(36756003)(14454004)(7736002)(478600001)(8936002)(54906003)(50226002)(316002)(305945005)(71200400001)(71190400001)(81156014)(33656002)(8676002)(25786009)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1677;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oODcpkXncsnDK79IRDo4KcSYCwGLrMivqsc4O67vqXMJXQgGdd52tU2AOUbtvmtl5IPTLJ0yCE36zhg+Due/4r6oKBanpeWu6bwBulxeIRYRR+WqMoA4cUc4E2lXdnyIbS5c7pTJL+yfl5l8Yr5qTrLD3WUj2fWCROmfTqO8wmbM8+4Mgi0z8suqKFTwmi7QiPRdBfrT1r8GG0mDsIA/lHcZFa5Zc5QmfaRDtf8r2XKRIQkbXfAf83x1cDoxhcPHw7tJxSM3xp4qLc9EifBi6tlpOQ6KqzToqfqilmV9OUXxPkbNutQcikzoie+8VgQfpOS9/Y9j5yiKjk9sDWfzipcsYdaegaAE9lD5nRj5Bn+YB73rQiX165ViNV3DMhhIf7NVZT53rqeahkTVaC48RrET/JMhRWdNNJ4ghyltN7M=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BAEE84C8238B8340876BF455C8EC3E74@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cd31c608-231b-41df-6063-08d753201dec
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 16:36:10.0194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y0/Q2RAJEOU5Az1NbTDadrP72nHcqx6QkGZRTrgstbLSGywTr3uPkTcug693QDhkFTQhRXwYKlADsXqfi1+89Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1677
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-17_05:2019-10-17,2019-10-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=735 adultscore=0 impostorscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910170149
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 17, 2019, at 9:12 AM, Matthew Wilcox <willy@infradead.org> wrote:
>=20
> On Wed, Oct 16, 2019 at 12:37:30AM -0700, Song Liu wrote:
>> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>=20
>> Once a THP is added to the page cache, it cannot be dropped via
>> /proc/sys/vm/drop_caches. Fix this issue with proper handling in
>> invalidate_mapping_pages() and __remove_mapping().
>>=20
>> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) =
FS")
>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Tested-by: Song Liu <songliubraving@fb.com>
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> ---
>> mm/truncate.c | 12 ++++++++++++
>> mm/vmscan.c   |  3 ++-
>> 2 files changed, 14 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index c6659bb758a4..1d80a188ad4a 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -932,7 +932,8 @@ static int __remove_mapping(struct address_space *ma=
pping, struct page *page,
>> 	 * Note that if SetPageDirty is always performed via set_page_dirty,
>> 	 * and thus under the i_pages lock, then this ordering is not required.
>> 	 */
>> -	if (unlikely(PageTransHuge(page)) && PageSwapCache(page))
>> +	if (unlikely(PageTransHuge(page)) &&
>> +			(PageSwapCache(page) || !PageSwapBacked(page)))
>> 		refcount =3D 1 + HPAGE_PMD_NR;
>> 	else
>> 		refcount =3D 2;
>=20
> Kirill suggests that this patch would be better (for this part of the pat=
ch;
> the part in truncate.c should remain as it is)
>=20
> commit ddcee327f96d57cb9d5310486d21e43892b7a368
> Author: William Kucharski <william.kucharski@oracle.com>
> Date:   Fri Sep 20 16:14:51 2019 -0400
>=20
>    mm: Support removing arbitrary sized pages from mapping
>=20
>    __remove_mapping() assumes that pages can only be either base pages
>    or HPAGE_PMD_SIZE.  Further, it assumes that large pages are
>    swap-backed.  Support all kinds of pages by unconditionally asking how
>    many pages this page references.
>=20
>    Signed-off-by: William Kucharski <william.kucharski@oracle.com>
>    Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>=20
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index c6659bb758a4..f870da1f4bb7 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -932,10 +932,7 @@ static int __remove_mapping(struct address_space *ma=
pping, struct page *page,
> 	 * Note that if SetPageDirty is always performed via set_page_dirty,
> 	 * and thus under the i_pages lock, then this ordering is not required.
> 	 */
> -	if (unlikely(PageTransHuge(page)) && PageSwapCache(page))
> -		refcount =3D 1 + HPAGE_PMD_NR;
> -	else
> -		refcount =3D 2;
> +	refcount =3D 1 + compound_nr(page);
> 	if (!page_ref_freeze(page, refcount))
> 		goto cannot_free;
> 	/* note: atomic_cmpxchg in page_ref_freeze provides the smp_rmb */

This does look cleaner, and works fine in my tests.

Let me include it in v2 set.=20

Thanks,
Song=
