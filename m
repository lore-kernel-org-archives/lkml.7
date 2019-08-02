Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AFAC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 20:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 435FC206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 20:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="n7l9h1kf";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="AyJ1DPUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394548AbfHBUgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 16:36:03 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:4794 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726268AbfHBUgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 16:36:02 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x72KXhlr014777;
        Fri, 2 Aug 2019 13:34:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=gJ5pdp5J5yq16/Jzy51hwzJwWMCpsTQRVzo9hpL4LW0=;
 b=n7l9h1kfFKHA9hD3Zp6psz2u/KsYPuSOQVKLWW4xtOSMZJkjpVD3N9Hx8KYMAn1RhQ7/
 m+b+bxCqDXrg+mSeH8tHLO8a4YGr73NvGwmMLWAsFq4MIhOVJZVvZD1KL2i2qibCV2T1
 HKvo35FPfkRNEozrTFVmo3SAxv0f9nEKsT4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2u4g2vapfx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 02 Aug 2019 13:34:55 -0700
Received: from ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 2 Aug 2019 13:34:54 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 2 Aug 2019 13:34:54 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 2 Aug 2019 13:34:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkIQrESId9JVaE2Mk0HCa41WjnE93efhK7GwghN/K9dpWjj2zLDsH/wGhr1QX+TceZYTeC90nr6qC9prFssd7F93uxFDcMULf+5+0p/VO3skGjtbuvdWMkcApRWFrz3UhNEqHwKE9tKv/+DSjuoDI9+ZXtLElMaa9CIjC40d24an40ORw6gSaWnL/HyctSPoS+PjBQKh0GB9dC8Cmre1/dQnLrQSrFHKnM3Zm59fRAH9uO0GIjThmNRdGVCdgm9RO/p3ORbQASvfvs0OUrAU0P9YgWnl8bhCLg0/bv0hXyDygf2Nko9e2+iHDu62UUuZNJtZ1EqDo+1rJPBP6ZHpoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJ5pdp5J5yq16/Jzy51hwzJwWMCpsTQRVzo9hpL4LW0=;
 b=JaVIsA9SBK/7EVy8XDN1v9Iv8IzzPmLena5MBa4dBfO5IaYyCDEttm17L7NvHta9xYHJPg4bYWu1rABqfj4swkY8QTeErABJeKErTeepMOtpuK6wXbTXWb1L1kzZf2bDXkrOPAN4UAMyIxnTHjJLAjJo8oB2wyWmIwU1jqBklBQJkga78DyfkVSr+qs6RPSlGThkcPTVQnk7HTOJ6oRwxlsA5jF944z/scLklVDtLw+ckLB6lPgm1MkL7BydJmJee0AWq0AfeRkhqWeLXk7eUSoiV1kv5GktvDbCPS18zEVFAr0st77/hMqjY4MJIoMgHSi9RzrSz37GjwhFYSk62g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=fb.com;dmarc=pass action=none header.from=fb.com;dkim=pass
 header.d=fb.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJ5pdp5J5yq16/Jzy51hwzJwWMCpsTQRVzo9hpL4LW0=;
 b=AyJ1DPUqLGogYcECsAbG7KeHJK6mjBYF3OkVkwQD9gif+8LH4NlSXzzqZVIhlKrtjcpbxCfE+B/fVH5FKz3X83kXiGOmMyP22PB7iE6uoWKVcQinjzTQIOWR7xEMXFt0W0bsqpXVIVr3wC3BMPefrWsd0YG1av2Ojx3omFhSc2s=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1710.namprd15.prod.outlook.com (10.174.96.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Fri, 2 Aug 2019 20:34:53 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::d4fc:70c0:79a5:f41b]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::d4fc:70c0:79a5:f41b%2]) with mapi id 15.20.2115.005; Fri, 2 Aug 2019
 20:34:52 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     lkml <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kernel Team <Kernel-team@fb.com>,
        "William Kucharski" <william.kucharski@oracle.com>,
        "srikar@linux.vnet.ibm.com" <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/2] khugepaged: enable collapse pmd for pte-mapped THP
Thread-Topic: [PATCH v3 1/2] khugepaged: enable collapse pmd for pte-mapped
 THP
Thread-Index: AQHVSJnBcC4K72VM4ESRnUeFDmyc+aboC4IAgABGwoA=
Date:   Fri, 2 Aug 2019 20:34:52 +0000
Message-ID: <BCCFF8C4-6A47-4E13-B1A6-9353D7E10AAD@fb.com>
References: <20190801184823.3184410-1-songliubraving@fb.com>
 <20190801184823.3184410-2-songliubraving@fb.com>
 <20190802162136.GA2539@redhat.com>
In-Reply-To: <20190802162136.GA2539@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c091:480::5569]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7c0e2d4-9c71-46bd-4a12-08d71788df83
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1710;
x-ms-traffictypediagnostic: MWHPR15MB1710:
x-microsoft-antispam-prvs: <MWHPR15MB17102CA68B547BCDF831ACA8B3D90@MWHPR15MB1710.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 011787B9DD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(366004)(39860400002)(396003)(189003)(199004)(71200400001)(81156014)(81166006)(71190400001)(14454004)(99286004)(57306001)(5660300002)(186003)(8676002)(66556008)(50226002)(6246003)(102836004)(64756008)(66946007)(76116006)(8936002)(6512007)(91956017)(305945005)(4326008)(66446008)(76176011)(54906003)(68736007)(229853002)(6916009)(2616005)(476003)(25786009)(2906002)(33656002)(66476007)(53936002)(11346002)(46003)(446003)(7736002)(6116002)(6486002)(478600001)(6506007)(486006)(36756003)(6436002)(316002)(86362001)(53546011)(256004)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1710;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2tXKcJS0loXXvvHZu3eNXTx55AihpGi9y1W10tTXr8bYxCbPGNLQkHqIxN8uO2TjwYbW/R/FatIiiDivlMhOdS2+zAdb9eyqW8nxCJx7VORtMxO/1GJAm1BFBdmDuhCViVNU1VPNAK+9notijmq/c30UhfL0xa6DH3LtsWyw/X8S6MVo0PT+ltUarGoTEHKYcCXOfWr+w8yafnn3REjko1TqpaZFonzUPeWXQ1vEmqvVfMAR8OleoJ1XZi8jG8gxv/m7uciRiW4s3gVuLMxfJAJmC0CbP9CzbXVCJsszbPSnuY0fgTktlFCLSb0HVM3VlhfnpJQ8uja7JaZGs7DWJzBbEGPfbXXSHinwVHP7+4A3ykF8jhlEncH0Lq4SOsA6g/P8SJkF4Jz959KzoozHFqbhYN1foVv9G1qXluMCeRI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4B97E34F69EA784386431931B1CAC4C9@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c0e2d4-9c71-46bd-4a12-08d71788df83
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2019 20:34:52.7127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1710
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-02_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=705 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908020219
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 2, 2019, at 9:21 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>=20
> On 08/01, Song Liu wrote:
>>=20
>> +static int khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
>> +					 unsigned long addr)
>> +{
>> +	struct mm_slot *mm_slot;
>> +	int ret =3D 0;
>> +
>> +	/* hold mmap_sem for khugepaged_test_exit() */
>> +	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_sem), mm);
>> +	VM_BUG_ON(addr & ~HPAGE_PMD_MASK);
>> +
>> +	if (unlikely(khugepaged_test_exit(mm)))
>> +		return 0;
>> +
>> +	if (!test_bit(MMF_VM_HUGEPAGE, &mm->flags) &&
>> +	    !test_bit(MMF_DISABLE_THP, &mm->flags)) {
>> +		ret =3D __khugepaged_enter(mm);
>> +		if (ret)
>> +			return ret;
>> +	}
>=20
> see my reply to v2
>=20
>> +void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long haddr)
>> +{
>> +	struct vm_area_struct *vma =3D find_vma(mm, haddr);
>> +	pmd_t *pmd =3D mm_find_pmd(mm, haddr);
>> +	struct page *hpage =3D NULL;
>> +	unsigned long addr;
>> +	spinlock_t *ptl;
>> +	int count =3D 0;
>> +	pmd_t _pmd;
>> +	int i;
>> +
>> +	VM_BUG_ON(haddr & ~HPAGE_PMD_MASK);
>> +
>> +	if (!vma || !vma->vm_file || !pmd)
>                    ^^^^^^^^^^^^^
>=20
> I am not sure this is enough,
>=20
>> +		return;
>> +
>> +	/* step 1: check all mapped PTEs are to the right huge page */
>> +	for (i =3D 0, addr =3D haddr; i < HPAGE_PMD_NR; i++, addr +=3D PAGE_SI=
ZE) {
>> +		pte_t *pte =3D pte_offset_map(pmd, addr);
>> +		struct page *page;
>> +
>> +		if (pte_none(*pte))
>> +			continue;
>> +
>> +		page =3D vm_normal_page(vma, addr, *pte);
>=20
> Why can't vm_normal_page() return NULL? Again, we do not if this vm_file
> is the same shmem_file() or something else.

Hmm.. I guess we also need to check page !=3D NULL.=20

For vm_file, I guess it is OK for it to be another file. As long as all
pages in the pmd map to the same THP, we should be fine.=20

>=20
> And in fact I don't think it is safe to use vm_normal_page(vma, addr)
> unless you know that vma includes this addr.

Yeah, we need to check vma includes this address.=20

>=20
> to be honest, I am not even sure that unconditional mm_find_pmd() is safe
> if this "something else" is really special.

I cannot imagine why mm_find_pmd() could be unsafe.=20

Thanks,
Song

