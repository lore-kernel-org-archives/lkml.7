Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEBEC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A76D2184E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="lVfcYy2I";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="JSZQFZjj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404234AbfHHRLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 13:11:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58786 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728289AbfHHRLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 13:11:20 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x78H2x8Q000928;
        Thu, 8 Aug 2019 10:06:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Wk8DU59dm9njoHPjuB0K8lw9FgtFR/w1I+eDfr4Er6M=;
 b=lVfcYy2IKSqiOYuk62K+t9KMEvhiDnwh0LgMdb2CsC1eqe40j4DtK6oofWY5aNyg2bk0
 IFMGdpb+VWTRJcaoveZvlbk11BP25a9wY05f+XLcBz8ma42zL87X+ZrkpPXBWelL9Wdc
 WPEfaPhx95vL+sHQZ2HWwXnlOQ2xI+7POzI= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2u8md7gws4-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 08 Aug 2019 10:06:11 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 8 Aug 2019 10:05:58 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 8 Aug 2019 10:05:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ya5tMWOTkkSBm3IoNvqr4+BCalptqjvRUFTUjKivUhOEd55wQqotNIeKg7/k8pd3nK/buY+uc4u9KvPQb47owFpQ2Dmn+dMWv3LLnL7vdsKZ8g6SXrSp7WHmZqVRdWH6pVTgeiolXjX0gYcEiuqNZPqwXdnOkfMlVUWYr6KAdLabFWyOHTTLqrCqi5sGydMFhzZhYTyXsxytgjglGyxQWM1B4XHUQQ5AD4cQez7BUeSTLVvkQfiQs+91epY07bT2GnQ7w8CYYwdA5k3Lhrmhy7NFWiEbk76ySJ2k5rwXZtSLYfJ/T0VkjoSNSru7OLyZLx7xe51G9rziy71/x6tuKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wk8DU59dm9njoHPjuB0K8lw9FgtFR/w1I+eDfr4Er6M=;
 b=nFXwaZLPY+3SCk7ol9V81TdyupElEj91uas2EJ8BgwBAy6prIqtlkNBRXpNFRVlmkt51vP4wZKkjlYHHReJ0dweoMle2r0elLl7fPwMTpcoy6q8/DdgbQygtJOegKsezCMcZeYH7iGztRGcSg0GJCqdtqJHtU5voMASlUhzAQCn0rWY7sKN60eG3pLO4ZhLxF5x+FHQL4eA9oLBHbD1CQ8qfVLiUY68bEt8F6zX4eKNVdYZmd3h0BEcsuyPa5oTQMuMOg1dGm/LJDmTrXIvbBLF+IrlVMNuwqA/dhp/p1O/quVISzlzvBQgZBJRIwOxQJL5Xmt7daLqrj6wT5V90jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=fb.com;dmarc=pass action=none header.from=fb.com;dkim=pass
 header.d=fb.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wk8DU59dm9njoHPjuB0K8lw9FgtFR/w1I+eDfr4Er6M=;
 b=JSZQFZjj84TsYy/XEHO66ttxqLC3bD4XLGpSPQDp3xJFZwWrPm4S7N6OTT6NY0t3exHQbipJu8JdldJvHL62gkg6rDzUTsDRmQ5vSdxLEudTRatFJjYu9hL7uVeRGNZDY9dGoaKiplI9gk3k4xLnbWTJdTIP4wOTA07O+Gxh1bU=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1375.namprd15.prod.outlook.com (10.173.233.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Thu, 8 Aug 2019 17:05:57 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::79c8:442d:b528:802d]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::79c8:442d:b528:802d%9]) with mapi id 15.20.2157.015; Thu, 8 Aug 2019
 17:05:57 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox" <matthew.wilcox@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kernel Team <Kernel-team@fb.com>,
        "William Kucharski" <william.kucharski@oracle.com>,
        "srikar@linux.vnet.ibm.com" <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v12 5/6] khugepaged: enable collapse pmd for pte-mapped
 THP
Thread-Topic: [PATCH v12 5/6] khugepaged: enable collapse pmd for pte-mapped
 THP
Thread-Index: AQHVTXlDuUiBx4u3AUqTmiQ0C68ad6bxcvOAgAAJMAA=
Date:   Thu, 8 Aug 2019 17:05:57 +0000
Message-ID: <770B3C29-CE8F-4228-8992-3C6E2B5487B6@fb.com>
References: <20190807233729.3899352-1-songliubraving@fb.com>
 <20190807233729.3899352-6-songliubraving@fb.com>
 <20190808163303.GB7934@redhat.com>
In-Reply-To: <20190808163303.GB7934@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::3099]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64da6c24-d59b-4289-fa3f-08d71c22ae62
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1375;
x-ms-traffictypediagnostic: MWHPR15MB1375:
x-microsoft-antispam-prvs: <MWHPR15MB137561271C2E103EF354B35BB3D70@MWHPR15MB1375.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 012349AD1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(136003)(39860400002)(366004)(376002)(199004)(189003)(316002)(102836004)(76176011)(6436002)(6486002)(54906003)(8936002)(53936002)(46003)(446003)(2616005)(476003)(11346002)(6116002)(256004)(6512007)(81156014)(66446008)(99286004)(8676002)(7736002)(305945005)(14454004)(5660300002)(81166006)(66556008)(64756008)(229853002)(6246003)(66946007)(66476007)(53546011)(50226002)(6506007)(76116006)(2906002)(6916009)(25786009)(4326008)(86362001)(36756003)(57306001)(186003)(486006)(33656002)(71190400001)(71200400001)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1375;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iuzGOKhDbyWSMp1E8YNtrU60S8AfLnMSCNR1tsfBLC70VFv9eOqIhWI7PtFGTUNUMANB1AkRnueHZafsPAYvT7kqBLOqnyUYIIRm195GQuk3AmiU1VLVsnfAgNP00KNJ0qeC2r1rFXM3UpN0tTg+DBu8+qkmJlKpXL5UHIgzlcpPXEq4Oy1xVyan61kdFlLNykhvb50uRBCxB3PuTA93D0AoomzB8maeK0+UGMR5ELCFkXX8nFR9ABmekcwY6EpgG6HpMarHoyowPZiawbEEK48Lf0zIauJquWunRYX4PljWbc5wn3PDRmIp7kpS5VhZ+eTOg9qk8VtWnqmbxNnE2i2H1gFdY3jdP1w6KBiu8l8NHcSSjNfaQ7TZ68VZjqn4QNdFbqPOF1BVdvJ5JkApzCdGtvanDRlYhsOpblnMK6A=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <198E67CBD55CAC4D8369860F42CD39C7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 64da6c24-d59b-4289-fa3f-08d71c22ae62
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2019 17:05:57.4193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lYK91ACmAArvjnyBNkWtA2Y0Mqw2FbbMR187gzUMD/DsZO1yir0vpfE02wpTtoPXHXAKtLpISrW7LuyAJ4dg2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1375
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-08_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=683 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908080154
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 8, 2019, at 9:33 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>=20
> On 08/07, Song Liu wrote:
>>=20
>> +void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
>> +{
>> +	unsigned long haddr =3D addr & HPAGE_PMD_MASK;
>> +	struct vm_area_struct *vma =3D find_vma(mm, haddr);
>> +	struct page *hpage =3D NULL;
>> +	pmd_t *pmd, _pmd;
>> +	spinlock_t *ptl;
>> +	int count =3D 0;
>> +	int i;
>> +
>> +	if (!vma || !vma->vm_file ||
>> +	    vma->vm_start > haddr || vma->vm_end < haddr + HPAGE_PMD_SIZE)
>> +		return;
>> +
>> +	/*
>> +	 * This vm_flags may not have VM_HUGEPAGE if the page was not
>> +	 * collapsed by this mm. But we can still collapse if the page is
>> +	 * the valid THP. Add extra VM_HUGEPAGE so hugepage_vma_check()
>> +	 * will not fail the vma for missing VM_HUGEPAGE
>> +	 */
>> +	if (!hugepage_vma_check(vma, vma->vm_flags | VM_HUGEPAGE))
>> +		return;
>> +
>> +	pmd =3D mm_find_pmd(mm, haddr);
>=20
> OK, I do not see anything really wrong...
>=20
> a couple of questions below.
>=20
>> +	for (i =3D 0, addr =3D haddr; i < HPAGE_PMD_NR; i++, addr +=3D PAGE_SI=
ZE) {
>> +		pte_t *pte =3D pte_offset_map(pmd, addr);
>> +		struct page *page;
>> +
>> +		if (pte_none(*pte))
>> +			continue;
>> +
>> +		page =3D vm_normal_page(vma, addr, *pte);
>> +
>> +		if (!page || !PageCompound(page))
>> +			return;
>> +
>> +		if (!hpage) {
>> +			hpage =3D compound_head(page);
>=20
> OK,
>=20
>> +			if (hpage->mapping !=3D vma->vm_file->f_mapping)
>> +				return;
>=20
> is it really possible? May be WARN_ON(hpage->mapping !=3D vm_file->f_mapp=
ing)
> makes more sense ?

I haven't found code paths lead to this, but this is technically possible.=
=20
This pmd could contain subpages from different THPs. The __replace_page()=20
function in uprobes.c creates similar pmd.=20

Current uprobe code won't really create this problem, because=20
!PageCompound() check above is sufficient. But it won't be difficult to=20
modify uprobe code to break this. For this code to be accurate and safe,=20
I think both this check and the one below are necessary. Also, this code=20
is not on any critical path, so the overhead should be negligible.=20

Does this make sense?

Thanks,
Song
