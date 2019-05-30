Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75EAC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 17:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B944425E5D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 17:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="IIt0PtrH";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="FMiOBCG6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfE3RZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 13:25:35 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36744 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726735AbfE3RZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 13:25:34 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UHJeVi031730;
        Thu, 30 May 2019 10:23:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=p/Ukfbxd3jQZ8Ife0hv45+W30kQmJn7dbk2U+rff9fY=;
 b=IIt0PtrHITx553H2RKghWXYX3nFZW4lKRIUuEpTkrpqNQHFFxhh3RK5iZ1aBz7TfQfv7
 LF2azEdh4J1KTm74RgXnSLBCVkd1RS6+gOZ4mm6goElxfiRi8KxHQefwCGeKfrlVHJUV
 yhORulLNPq4COlKCHHMa6NkhB8bJfNlkE1s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2stf3x8ymu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 30 May 2019 10:23:22 -0700
Received: from ash-exopmbx201.TheFacebook.com (2620:10d:c0a8:83::8) by
 ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 30 May 2019 10:23:17 -0700
Received: from ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) by
 ash-exopmbx201.TheFacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 30 May 2019 10:23:17 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 30 May 2019 10:23:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/Ukfbxd3jQZ8Ife0hv45+W30kQmJn7dbk2U+rff9fY=;
 b=FMiOBCG6TWm/uLxLhqhWBXEOe2NpCo/+RgJzT8xkPmWIb6fvvHRW6xcvA9z8ifG9vyuc3L12RusbvS8Jjag8hzF2tzi4DcVtfrfm+WDcbtGmguFyvBWMGok08TYXdF4aQsPBDz4kNFoDWCtQGXMfQ5Uxaho3EIZIOnjtMiqLg0M=
Received: from BN6PR15MB1154.namprd15.prod.outlook.com (10.172.208.137) by
 BN6PR15MB1539.namprd15.prod.outlook.com (10.172.151.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.16; Thu, 30 May 2019 17:23:15 +0000
Received: from BN6PR15MB1154.namprd15.prod.outlook.com
 ([fe80::adc0:9bbf:9292:27bd]) by BN6PR15MB1154.namprd15.prod.outlook.com
 ([fe80::adc0:9bbf:9292:27bd%2]) with mapi id 15.20.1922.021; Thu, 30 May 2019
 17:23:15 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "namit@vmware.com" <namit@vmware.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Kernel Team <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "chad.mynhier@oracle.com" <chad.mynhier@oracle.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>
Subject: Re: [PATCH uprobe, thp 1/4] mm, thp: allow preallocate pgtable for
 split_huge_pmd_address()
Thread-Topic: [PATCH uprobe, thp 1/4] mm, thp: allow preallocate pgtable for
 split_huge_pmd_address()
Thread-Index: AQHVFma9gbzZ2z2z40KErGQDdtT9DaaDg7aAgAABHwCAAGcWAA==
Date:   Thu, 30 May 2019 17:23:15 +0000
Message-ID: <DCC3D689-2E11-44CE-A74E-0ACC4E5067C9@fb.com>
References: <20190529212049.2413886-1-songliubraving@fb.com>
 <20190529212049.2413886-2-songliubraving@fb.com>
 <20190530111015.bz2om5aelsmwphwa@box> <20190530111416.ph6xqd4anjlm54i6@box>
In-Reply-To: <20190530111416.ph6xqd4anjlm54i6@box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::3:bc80]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c81fb8be-ffc4-4034-1ee9-08d6e5238005
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN6PR15MB1539;
x-ms-traffictypediagnostic: BN6PR15MB1539:
x-microsoft-antispam-prvs: <BN6PR15MB15394A3351EF975C4641EF1BB3180@BN6PR15MB1539.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(366004)(376002)(39860400002)(346002)(199004)(189003)(51914003)(476003)(256004)(71200400001)(71190400001)(2906002)(25786009)(54906003)(2616005)(57306001)(76176011)(66556008)(50226002)(7736002)(76116006)(486006)(46003)(91956017)(6506007)(99286004)(102836004)(73956011)(316002)(53546011)(33656002)(66476007)(66946007)(6116002)(7416002)(186003)(14444005)(305945005)(11346002)(6916009)(6246003)(66446008)(81166006)(83716004)(81156014)(478600001)(36756003)(8676002)(82746002)(68736007)(6436002)(6512007)(53936002)(86362001)(4326008)(14454004)(229853002)(6486002)(8936002)(5660300002)(64756008)(446003)(14583001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR15MB1539;H:BN6PR15MB1154.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6976WPZ4NMq/RLvEQNBXsJG5dgGt/lKAsMXQWoZw45AvGM6JlkVOjkyCIpbH7hDN4hX5eIbAkD1SmnwBYKjeI3ArbAta2rgIffAZ5WqHL9tF2q54UxFcJqFwtPmWKVzgCTY90BRevumN+Mhf+yuAax0wyOc42ec4zBJPJIMH92e5P8xzvbj9WBjhyadPdBVSibs0nhwWNvWPwSFO0DccB+tOQtf4oXnX5nkuJuW80ffd70bTmv5QYc9Zua/uHs0i0DlviksuVSoeGIZZ/MTyadIuadFeCPoYEwEpX8rWbIIza5KV4bb6ZcDIWVy0/QMbl07DnqLUxmwAhy4KZ5/uTjHwYoGg7nwSeF6zQr79w51ecDW4PIoDqUp+kUy6q1BGb7JSYYyIkc+IohcM9tEjHL55Hn1JOxNpI8J9wAOzxpQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DBFB0013CC21944CA6D386A2D1C35A2B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c81fb8be-ffc4-4034-1ee9-08d6e5238005
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 17:23:15.2457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1539
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300122
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 30, 2019, at 4:14 AM, Kirill A. Shutemov <kirill@shutemov.name> wr=
ote:
>=20
> On Thu, May 30, 2019 at 02:10:15PM +0300, Kirill A. Shutemov wrote:
>> On Wed, May 29, 2019 at 02:20:46PM -0700, Song Liu wrote:
>>> @@ -2133,10 +2133,15 @@ static void __split_huge_pmd_locked(struct vm_a=
rea_struct *vma, pmd_t *pmd,
>>> 	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PMD_SIZE, vma);
>>> 	VM_BUG_ON(!is_pmd_migration_entry(*pmd) && !pmd_trans_huge(*pmd)
>>> 				&& !pmd_devmap(*pmd));
>>> +	/* only file backed vma need preallocate pgtable*/
>>> +	VM_BUG_ON(vma_is_anonymous(vma) && prealloc_pgtable);
>>>=20
>>> 	count_vm_event(THP_SPLIT_PMD);
>>>=20
>>> -	if (!vma_is_anonymous(vma)) {
>>> +	if (prealloc_pgtable) {
>>> +		pgtable_trans_huge_deposit(mm, pmd, prealloc_pgtable);
>>> +		mm_inc_nr_pmds(mm);
>>> +	} else if (!vma_is_anonymous(vma)) {
>>> 		_pmd =3D pmdp_huge_clear_flush_notify(vma, haddr, pmd);
>>> 		/*
>>> 		 * We are going to unmap this huge page. So
>>=20
>> Nope. This going to leak a page table for architectures where
>> arch_needs_pgtable_deposit() is true.
>=20
> And I don't there's correct handling of dirty bit.
>=20
> And what about DAX? Will it blow up? I think so.
>=20

Let me look into these cases. Thanks for the feedback!

Song

> --=20
> Kirill A. Shutemov

