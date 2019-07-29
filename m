Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE71C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 17:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE12F2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 17:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="IYYnNI8h";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="gsprDmeG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbfG2RGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 13:06:00 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43512 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726358AbfG2RF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 13:05:57 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6TH2IcS018934;
        Mon, 29 Jul 2019 10:04:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=0Bv36EwhZgrbmD2RvhTdaFiMb5eNKnduWZYG5zqUew4=;
 b=IYYnNI8hQRr7ysQwShaw4qlOO9p/lSdBwWyGX7B94pcoXISQoPNlofLTWTjxpIyhvrgR
 Uthkgnq9OHn3UqmzuP9czzr8aSC6OxZdJX6WvPo6TN+HYc2XYDjs+XqVUXEHHy7ATJnS
 2NmPfcm2/0Sfvu0xGNw+ZucAU89mibU76oA= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2u1yvdh9d9-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 29 Jul 2019 10:04:11 -0700
Received: from prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 29 Jul 2019 10:04:07 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 29 Jul 2019 10:04:07 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 29 Jul 2019 10:04:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MR87DNHVqs2lJD1Sh2gwy/EaJdhejkyOC7cCU4ahksSJj9j6IlIVmMFGjC8Br0iTl5rSZ2/K0i60CLbujvXRZwXGnjSU9XsfzFXlAUC71FSZdmqtCXxRjBIAUo25pal7NEwN3vWfbQ9RislKj6BHzIvdXaTUkxCr+21rFA41/l0DGMcjy3W82vAtK9xCb/VBIumLowdWI1TioBk054cBPBbRXjr8aLB96WBCIPeEmMWSZSgUoWQpdkTiQyAWLWYf9MPbtggAZLCME2wByz091dS4W0ouEKN9C9EkiJ64JRMhEsE8FRPxGaP1XQ198UkBkMMNhIOpwSvGZwq/vGv0NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Bv36EwhZgrbmD2RvhTdaFiMb5eNKnduWZYG5zqUew4=;
 b=LR4rzNT/V7YDV38kKKDnoMzQo9fB6ZsLdW54vywkaIipTUsTLWl8VoDEWXIYjA01kE5kODuJ1DU5NaP1DKHTn1Q9lIbErSJ/kOoQtIfy9JsUQOAuQiKNTdTlLwmLYMgcEwVc+2qNrn74k0gOxDMvSsx7OCxuHha+40c8Y5r93DOmCcgltJRzpHL9xVWM67pXnZpQzC017B2T7f8IZ/MxPP2UnOrzfUgblsjjfbHkiZsXoVkDWUZbCCruWwqje4KmOqKL1Q2ETM2QYyUTiOr6+BXCbiNFZg3kV/aT0kAW2C5+rB0o5A0S3SGCtlf9pHO+oCDdXDKQb277S3Yn2cw6qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=fb.com;dmarc=pass action=none header.from=fb.com;dkim=pass
 header.d=fb.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Bv36EwhZgrbmD2RvhTdaFiMb5eNKnduWZYG5zqUew4=;
 b=gsprDmeGBH7o1GTdXtJS21NltW9z9s0/ASaYtlbaIbIW3mD+3/JRmybNK0UvSl3Ue3oD4yP/kzo44RSiJaYcZCTygv5Mud5W36W771en0WfGiBu/joJeVvcJW9DJGyHJRkcSM1aEhW2vC8XDai6EtRFWmkG+yzuGwOyvSSelaR8=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1437.namprd15.prod.outlook.com (10.173.234.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Mon, 29 Jul 2019 17:04:05 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::d4fc:70c0:79a5:f41b]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::d4fc:70c0:79a5:f41b%2]) with mapi id 15.20.2115.005; Mon, 29 Jul 2019
 17:04:05 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        William Kucharski <william.kucharski@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: + uprobe-use-original-page-when-all-uprobes-are-removed.patch
 added to -mm tree
Thread-Topic: + uprobe-use-original-page-when-all-uprobes-are-removed.patch
 added to -mm tree
Thread-Index: AQHVRAZeDd93yJdBykiPoGv83wMqwKbhth4AgAAhFoA=
Date:   Mon, 29 Jul 2019 17:04:05 +0000
Message-ID: <40C3ABEE-B1D1-445B-9637-A2BD5ED9C316@fb.com>
References: <20190726230333.drvM6x-wz%akpm@linux-foundation.org>
 <20190729150539.GB11349@redhat.com>
In-Reply-To: <20190729150539.GB11349@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::2:d148]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9159fbf7-54ee-4bf0-0c5b-08d71446c3a4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1437;
x-ms-traffictypediagnostic: MWHPR15MB1437:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR15MB1437D9E0A02F09BA35F68A38B3DD0@MWHPR15MB1437.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 01136D2D90
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(39860400002)(136003)(366004)(189003)(199004)(11346002)(8936002)(54906003)(53936002)(99286004)(6246003)(8676002)(6306002)(50226002)(6512007)(6116002)(71200400001)(71190400001)(6436002)(305945005)(7736002)(229853002)(33656002)(4326008)(81156014)(6916009)(81166006)(486006)(316002)(966005)(256004)(6486002)(57306001)(36756003)(76176011)(46003)(25786009)(86362001)(186003)(102836004)(76116006)(66556008)(64756008)(66446008)(66476007)(66946007)(14454004)(2906002)(2616005)(476003)(5660300002)(446003)(478600001)(68736007)(6506007)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1437;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ybQVq+a4aytbVU1H4R9BA3G+jtXd2D8PIzuA6eHwQcKoba0cqWSImMTZ+wact26ZstCXFGe3c5VNv2pLOuB4ZXWTfwoxgRVNsscRY6phGZ1Xf9NqBz3Twh0WR6FFyZ8jJCoHTEEPc092gG967EbTndIRboIs6uK12gotx5hm0Pzv9XsRUjNxbxzh5MXHWC5UVpkRW8r+uQWIoyfJNfb2KiWl44wBLr4YdBeclKEhpOKq1HnQBJkjziaMt6du9QFegJLeY9j9obqG6oKdlPNEfbGy/DMYLReWz6tt9pGEYq39mbP5vlRhXZ487byKRLbipes2QEYe4DeEMk25MHJqipT909xA33Am0lc5nERlA4fsajXkgjoFBmkCPmTmAcXeiD3e4MU4J5JdYxogcwbaIJwVTrwqW4TibIzzSA/DeBs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6FA930A341F76D4EBDC5AE1B1EB645B9@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9159fbf7-54ee-4bf0-0c5b-08d71446c3a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2019 17:04:05.7467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1437
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-29_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907290187
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 29, 2019, at 8:05 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>=20
> I didn't see this version, so let me reply here.
>=20
> On 07/26, Andrew Morton wrote:
>>=20
>> +	/* try orig_page only for unregister and anonymous old_page */
>> +	if (!is_register && PageAnon(old_page)) {
>=20
> Well, this is confusing... nothing really wrong, but we certainly do not
> want to install the new anonymous page if !is_register && !PageAnon(old).
> And in this case we do not even want to call __replace page().
>=20
> OK, I won't insist, this should almost never happen, but again, please
> see https://lore.kernel.org/lkml/20190726084423.GA16112@redhat.com/

I see. Do you want me fold this patch with 2/4?=20

>=20
>> +		struct page *orig_page;
>> +		pgoff_t index;
>> +
>> +		index =3D vaddr_to_offset(vma, vaddr & PAGE_MASK) >> PAGE_SHIFT;
>> +		orig_page =3D find_get_page(vma->vm_file->f_inode->i_mapping,
>> +					  index);
>> +
>> +		if (orig_page) {
>> +			if (PageUptodate(orig_page) &&
>> +			    pages_identical(new_page, orig_page)) {
>> +				/* let go new_page */
>> +				put_page(new_page);
>> +				new_page =3D NULL;
>> +
>> +				/* dec_mm_counter for old_page */
>> +				dec_mm_counter(mm, MM_ANONPAGES);
>=20
> this assumes that __replace_page() can't fail, but it can. I think you
> should move this into into __replace_page().

Good catch! Let me fix it.=20

Hi Andrew,

Do you prefer a whole v10 (1/4 to 4/4) or just newer version of this=20
one (2/4)?

Thanks,
Song=20
