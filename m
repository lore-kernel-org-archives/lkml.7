Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA5FC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92722084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="M+r7TUT7";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="gBmRNMh/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfEORS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 13:18:26 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57904 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725974AbfEORS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 13:18:26 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4FHHqFe013433;
        Wed, 15 May 2019 10:18:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=M+HeQUN9gzaGB+aAqkdYsyx1NRhGEPa8nOV7GMToD1w=;
 b=M+r7TUT7f6CMSSlhHCLXLIYiF6S5zql9i9h1fA/wYXXKzi2qYmFJvokLjslyIpFWRiQ8
 DNvpN689BXiCTKvgQB94axyfJWzoiQtO56FdD3v0Dg6DPQZsFiLiu+wcuG5WaLF621yG
 KhpBj8M/Ix+Wx+2KUDKcwoQLrr1baNV0rL8= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2sgggysgak-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 15 May 2019 10:18:11 -0700
Received: from prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 15 May 2019 10:18:08 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 15 May 2019 10:18:08 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 15 May 2019 10:18:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+HeQUN9gzaGB+aAqkdYsyx1NRhGEPa8nOV7GMToD1w=;
 b=gBmRNMh/WSRLwfG0wSN98xYDBNTXLTC7avyveg5dCFD4nBdASpvdZJegmBViBXlk4NTCEmgi8xTE0YKlAYC3dl5K6ZrqwDdRPWIMuvAZlYh/KidUcC200KmUmawNzx9oCCgZhCSjGREmPVsx5ZwpKPSJpfG/hE4cTBl3BovSiuQ=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3272.namprd15.prod.outlook.com (20.179.57.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Wed, 15 May 2019 17:18:06 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1878.024; Wed, 15 May 2019
 17:18:06 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: refactor __vunmap() to avoid duplicated call to
 find_vm_area()
Thread-Topic: [PATCH] mm: refactor __vunmap() to avoid duplicated call to
 find_vm_area()
Thread-Index: AQHVCq//khAEDBlALkSFD6zmmU+RfaZrl42AgADXXoA=
Date:   Wed, 15 May 2019 17:18:05 +0000
Message-ID: <20190515171800.GD9307@castle>
References: <20190514235111.2817276-1-guro@fb.com>
 <78d9b650-4b47-60c5-4212-601c1719dba5@arm.com>
In-Reply-To: <78d9b650-4b47-60c5-4212-601c1719dba5@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2201CA0072.namprd22.prod.outlook.com
 (2603:10b6:301:5e::25) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::779]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd2df18a-eaa7-4aa6-3f2f-08d6d9594b39
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB3272;
x-ms-traffictypediagnostic: BYAPR15MB3272:
x-microsoft-antispam-prvs: <BYAPR15MB327240EA0D25885C4DA7AFFABE090@BYAPR15MB3272.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(136003)(39860400002)(366004)(376002)(346002)(189003)(199004)(71190400001)(71200400001)(6116002)(86362001)(1076003)(2906002)(33716001)(256004)(14444005)(5660300002)(6916009)(53936002)(305945005)(7736002)(4326008)(25786009)(66476007)(64756008)(52116002)(102836004)(386003)(6246003)(68736007)(316002)(8936002)(81156014)(81166006)(486006)(54906003)(46003)(11346002)(446003)(476003)(14454004)(478600001)(99286004)(186003)(6506007)(76176011)(53546011)(229853002)(6436002)(8676002)(6486002)(66556008)(73956011)(66446008)(66946007)(6512007)(9686003)(33656002)(37363001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3272;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ODA2eCa21J2+8xgnqORW5yH5C00xk9pJf18gs+NkAgx+UXTqGJMPlhhpvBK9CFxMZTVRCaPywhcve1AQ3/7infdBDeFYeBP/AUL+KlPX5LE0LuMNGeywb8744SrYo5Dk9CSLMvxyIwMT/ofFpn02Jt0JYvGJI0fW0qyTH6Z07Ulb18rfwAmJJT97S71K3PY8iensnp7VehoWnO3OZlPYoCChcvRibaUecrUW9l5/XGltax+2n3+tMt9bOJrYSKPd0KUqfVA2r9KmT9OxKwXR67YFJC4jcIfD9d4VcTQO5GeFRFECW7atNsmCbuWyMxFFBpCkgvZYwFUZFgX36RbeFbSNuzZtWzRTT9h3I6xQfFA0bQQQszSupYZb76u8J0U0eF9m2TWcW2jgaJAQt+OfHmCUGqbyq9KVNVrXzCr7b70=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DF268288B0655949A369470EAFAF1E27@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2df18a-eaa7-4aa6-3f2f-08d6d9594b39
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 17:18:05.9592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3272
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-15_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 09:57:11AM +0530, Anshuman Khandual wrote:
>=20
>=20
> On 05/15/2019 05:21 AM, Roman Gushchin wrote:
> > __vunmap() calls find_vm_area() twice without an obvious reason:
> > first directly to get the area pointer, second indirectly by calling
> > vm_remove_mappings()->remove_vm_area(), which is again searching
> > for the area.
> >=20
> > To remove this redundancy, let's split remove_vm_area() into
> > __remove_vm_area(struct vmap_area *), which performs the actual area
> > removal, and remove_vm_area(const void *addr) wrapper, which can
> > be used everywhere, where it has been used before. Let's pass
> > a pointer to the vm_area instead of vm_struct to vm_remove_mappings(),
> > so it can pass it to __remove_vm_area() and avoid the redundant area
> > lookup.
> >=20
> > On my test setup, I've got 5-10% speed up on vfree()'ing 1000000
> > of 4-pages vmalloc blocks.
>=20
> Though results from  1000000 single page vmalloc blocks remain inconclusi=
ve,
> 4-page based vmalloc block's result shows improvement in the range of 5-1=
0%.

So you can confirm my numbers? Great, thank you!
