Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EB1C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 17:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D1A204EC
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 17:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="cB+7/PVp";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="HsL+Uni7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733273AbfHARMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 13:12:49 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:18244 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727498AbfHARMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 13:12:48 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71H5Gk8018978;
        Thu, 1 Aug 2019 10:11:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=QbOJI0wUojkW1x4XCnDc45yYOalVj21+9ESdamFUjgc=;
 b=cB+7/PVp8kHsJn5fdGnY9cF3GezWIOSww1IQfPuG4a9ZOiz7clm/oCQFxd94TPiyY6aw
 CTEp8yOswZlNGJpxsy5Nuv1O/6hhufSPgZAM5Zxxi7Y6+kmW1Cr6AY7yVzaCJSlu0bPr
 lWpT8ZGsEqTyd6yBebYqPt0OkhgsDCVCYAs= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2u3xmt9pu9-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 10:11:31 -0700
Received: from prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 1 Aug 2019 10:11:30 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 1 Aug 2019 10:11:29 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 1 Aug 2019 10:11:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUsRWEkoccoM//ON3qiP7iT8ujghuNUTYjHQvl68inKcXo36puYQAyD1EDyYYsikRUs0VUdW2l6X0Hl2ouXRM8mhsZjN6fWjg6aGQESsMltDmqD3g57J3pYQbL++1GyrlBd9yh1IdSZrcmU32EbQlVz8MXyJ9xfqEjsdgE5lAV9L0938fSKqvRak/jhe6sWWpmGWPzrch37XkNWtLDEGnrHHQNeVYCqKb+k6rwMeAyXafDVYIfkESB09AMgsSM6ZUxtEfin+dEfHBgdGPiuj+BrD/OBxqqKpIyVB+WpP2qjtFRbCk3k4N1Td8N/6io0MPb61NEnZmKl3JS9dYtd7wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbOJI0wUojkW1x4XCnDc45yYOalVj21+9ESdamFUjgc=;
 b=YsXBUBdUv1FVEotQVbto4HmnXIVXCRwc6YrmGXKzxBluR36mBLYy86pNOz6RxKcjW39kmt+dlLqt1aS0JHxZNA4cpzCqgDvkrPlT8bAZKcy9NDzS6nR7j1ezQnhWRG7NCMoZ6fSt3E8ZqDjAM3FXXeFvKgNI0Rq/9c9oSKBSIGUGun9qoOC0Kj9a6IQyKDUQtQsfksrDu1P6+cgdtyi73O+3jAUW8G0SrzLLKrqkIprWIS1j/2pRJ0qTWgMeV3BwzboUhkFtiBtA91ycs7pCTR6q5cDPzSrZ/Sn0aT5erfDS7f7VY2tElaAyMngD7FZiipqcliSCpmRvk/nSk6+OEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=fb.com;dmarc=pass action=none header.from=fb.com;dkim=pass
 header.d=fb.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbOJI0wUojkW1x4XCnDc45yYOalVj21+9ESdamFUjgc=;
 b=HsL+Uni7C1p8zMqLi/vQ0vMfA4rPS5mTc/RxGLFqB3k1F/w2CH0RRK+iNGRD/wCjmrwUCNxFoX8e1/6rRWbSulNxDapiF7GMDquNz0RFhyIOjRx7p5qxqoF2kqiuWQu7CmO9EEjT8grIcPWMXpwxVcRFv6wNxXUQsAKg7OW1zRk=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1904.namprd15.prod.outlook.com (10.174.98.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Thu, 1 Aug 2019 17:11:28 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::d4fc:70c0:79a5:f41b]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::d4fc:70c0:79a5:f41b%2]) with mapi id 15.20.2115.005; Thu, 1 Aug 2019
 17:11:28 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     lkml <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kernel Team <Kernel-team@fb.com>,
        "William Kucharski" <william.kucharski@oracle.com>,
        "srikar@linux.vnet.ibm.com" <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/2] khugepaged: enable collapse pmd for pte-mapped THP
Thread-Topic: [PATCH v2 1/2] khugepaged: enable collapse pmd for pte-mapped
 THP
Thread-Index: AQHVR86KvCEU4VHLnkGVG5f001755abmPe4AgABKxAA=
Date:   Thu, 1 Aug 2019 17:11:28 +0000
Message-ID: <619E9EC6-0B6A-4C30-8BA7-D2CA83FFC4E7@fb.com>
References: <20190731183331.2565608-1-songliubraving@fb.com>
 <20190731183331.2565608-2-songliubraving@fb.com>
 <20190801124351.GA31538@redhat.com>
In-Reply-To: <20190801124351.GA31538@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::2:33d7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2655aed1-83bd-4f83-21be-08d716a34ad8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1904;
x-ms-traffictypediagnostic: MWHPR15MB1904:
x-microsoft-antispam-prvs: <MWHPR15MB1904AABF93FB0FCB10009D9BB3DE0@MWHPR15MB1904.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(376002)(396003)(366004)(199004)(189003)(14454004)(7736002)(86362001)(76176011)(99286004)(6916009)(186003)(6436002)(71200400001)(6506007)(66476007)(68736007)(316002)(53936002)(66946007)(53546011)(76116006)(66556008)(6512007)(305945005)(14444005)(64756008)(486006)(256004)(102836004)(476003)(229853002)(5660300002)(11346002)(36756003)(446003)(2616005)(6486002)(54906003)(71190400001)(46003)(6246003)(8936002)(81166006)(8676002)(33656002)(66446008)(6116002)(4326008)(25786009)(2906002)(50226002)(57306001)(478600001)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1904;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XNHVRJUxyTa4DAesDGRL/nYDMME3cJk0vLkmWPlK+Q3WskdobNHgq0/ThLcsc8Hs6f1YE7In75eeaYFYw6ZkIUBSJJ5xqrvbKQ5qF38wr4OkZAkIz0rn7OaSq4FDe1enHCaMfssRq8tSqPy47WaFCqovR3AYKYaEF7c6wzZme+fKjPDL+Efp2mrhr5N4xoD4eI3WA4SHiSBPp+RxvnYINMDRrAscJ7kQVaaHnRupGTV2z+vRNwx6/KFQ9tz12MuifjIJXbD16xRlnjkYKGom7q9O/Dt71EQZoFZpJniIEmVp0uHWn4+dtvTILbl4QmhwzSIZfewDcJh28o+f7bQhCSAJ5xnsK44j/SB/1ZzCDPEctBnbyjrcjy7DmI8utv7Dr/cp+sm1a4Mx9+hDT3+u0mn7c2VtpX2GRZrZFHyrOUM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EB954BAF84DA264B9D83A2A59D36276A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2655aed1-83bd-4f83-21be-08d716a34ad8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 17:11:28.5541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1904
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=998 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010179
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 1, 2019, at 5:43 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>=20
> On 07/31, Song Liu wrote:
>>=20
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
>> +	if (!vma || !pmd || pmd_trans_huge(*pmd))
>                            ^^^^^^^^^^^^^^^^^^^^
>=20
> mm_find_pmd() returns NULL if pmd_trans_huge()

Good catch! I will simplify this one in v3.=20

>=20
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
>> +
>> +		if (!PageCompound(page))
>> +			return;
>> +
>> +		if (!hpage) {
>> +			hpage =3D compound_head(page);
>> +			if (hpage->mapping !=3D vma->vm_file->f_mapping)
>=20
> Hmm. But how can we know this is still the same vma ?
>=20
> If nothing else, why vma->vm_file can't be NULL?

Good point. We should confirm vma->vm_file is not NULL.=20

Thanks,
Song

