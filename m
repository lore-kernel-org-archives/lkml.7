Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EDBC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12992073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="aIO4jOg/";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Wqbxv25g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733280AbfDQTQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 15:16:00 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57950 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729291AbfDQTQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 15:16:00 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3HJD46U025462;
        Wed, 17 Apr 2019 12:15:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=o6NTzqE9GXtMEqiRcU33hNcS7lBA7ANxuiMMUVC8F+8=;
 b=aIO4jOg/LrhZxFrYyxWQDSXv2F0JJxHXHhvHR2FGNXvL6IvJRT5r/erZMYSW4j0Nw6R+
 fJLy9Y3vxgDigPtb4WopgSJ7DQvRWKSqhISStTBj1apkqs663mQWagfkzN2MjLtVA++r
 iJGDWut3uwKCNayirWDt4Es8WgchnixVJu8= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rx7w1gj35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 17 Apr 2019 12:15:44 -0700
Received: from frc-hub05.TheFacebook.com (2620:10d:c021:18::175) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 17 Apr 2019 12:15:43 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 17 Apr 2019 12:15:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6NTzqE9GXtMEqiRcU33hNcS7lBA7ANxuiMMUVC8F+8=;
 b=Wqbxv25gXdes6Ju45aufZJOR9wZe9e2LTdusHfghxg5aSvRwWnvyzRMK+nrMrH0sN3pKj07yOCcKZTBixl4a7DYEgakSV+1plptbpng55yqydR01m4+n4zTFUY3UtswRbSgsI6/ZKNhEAhk1nB2K6YwYxO8eVus/2wDkmRnj4kw=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3510.namprd15.prod.outlook.com (20.179.60.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Wed, 17 Apr 2019 19:15:41 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d1a1:d74:852:a21e]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d1a1:d74:852:a21e%5]) with mapi id 15.20.1792.021; Wed, 17 Apr 2019
 19:15:41 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Roman Gushchin <guroan@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 2/3] mm: separate memory allocation and actual work in
 alloc_vmap_area()
Thread-Topic: [PATCH 2/3] mm: separate memory allocation and actual work in
 alloc_vmap_area()
Thread-Index: AQHUzUkHvmEZiK9g+UuhGR24XSYfTqX236aA//+c5QCASiueAIAAYSWA
Date:   Wed, 17 Apr 2019 19:15:41 +0000
Message-ID: <20190417191535.GA16663@tower.DHCP.thefacebook.com>
References: <20190225203037.1317-1-guro@fb.com>
 <20190225203037.1317-3-guro@fb.com>
 <db6b9745-7e64-6eb9-6b2b-da9d157a779b@suse.cz>
 <20190301164834.GA3154@tower.DHCP.thefacebook.com>
 <ed835e2c-9357-c7ea-f458-0cd9b8f6e966@suse.cz>
In-Reply-To: <ed835e2c-9357-c7ea-f458-0cd9b8f6e966@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR12CA0047.namprd12.prod.outlook.com
 (2603:10b6:301:2::33) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:856]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c66eff2-ce3d-4827-6217-08d6c36914e5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR15MB3510;
x-ms-traffictypediagnostic: BYAPR15MB3510:
x-microsoft-antispam-prvs: <BYAPR15MB3510AE76931D0CB681CE1094BE250@BYAPR15MB3510.namprd15.prod.outlook.com>
x-forefront-prvs: 0010D93EFE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(376002)(346002)(39860400002)(199004)(189003)(478600001)(476003)(46003)(11346002)(446003)(6436002)(71200400001)(6116002)(54906003)(186003)(71190400001)(14454004)(1076003)(486006)(6512007)(33656002)(316002)(53936002)(2906002)(305945005)(6916009)(6246003)(6486002)(4326008)(25786009)(68736007)(53546011)(386003)(5660300002)(7736002)(229853002)(9686003)(6506007)(14444005)(8936002)(256004)(8676002)(81166006)(52116002)(81156014)(99286004)(76176011)(106356001)(86362001)(97736004)(105586002)(102836004)(93886005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3510;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: u5AC+a5Vz+MMnt3NWdzfnAlZW4w1U+GfW00UMx27X76ezXhGx9kBu3MBa96lWoTQm/GQhv3oF6T2hieyXOaj5W4m4O4d+I7puN0/7yLphumvyeiE4aIVf4CqaIJ0VJnzZ2yzF6ygi0VHZuVEwF9k7urTA95R4r1NPHNO25w4MgEz3PBcUu3h0+Fy0I9j6+jiDDGHG4XLXY2WkvqEvO5ra6NXB21CLKtJAjUd++L3gic2oDvppIsbCsQMk7JIK4VCn/gYjojiMmO+NwFkfiVl4t6kEPQPx8XAsgXidfQHh7cHleA+JbuaYZ4gY6LjBZmISitXkSLNJAJLnC1KQrG0ZOw03YAt9vUTIvf8WmM2MnB9vhZSRbYnySV2SdMzrCB8FPfaZP3IMipqaAzAhUigOx87jblNMVR1T4jqATyslIQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <212D8DE2A7DDF946B1E64CEB54733AEC@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c66eff2-ce3d-4827-6217-08d6c36914e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2019 19:15:41.2986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3510
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-17_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 03:27:56PM +0200, Vlastimil Babka wrote:
> On 3/1/19 5:48 PM, Roman Gushchin wrote:
> > On Fri, Mar 01, 2019 at 03:43:19PM +0100, Vlastimil Babka wrote:
> >> On 2/25/19 9:30 PM, Roman Gushchin wrote:
> >>> alloc_vmap_area() is allocating memory for the vmap_area, and
> >>> performing the actual lookup of the vm area and vmap_area
> >>> initialization.
> >>>
> >>> This prevents us from using a pre-allocated memory for the map_area
> >>> structure, which can be used in some cases to minimize the number
> >>> of required memory allocations.
> >>
> >> Hmm, but that doesn't happen here or in the later patch, right? The on=
ly
> >> caller of init_vmap_area() is alloc_vmap_area(). What am I missing?
> >=20
> > So initially the patch was a part of a bigger patchset, which
> > tried to minimize the number of separate allocations during vmalloc(),
> > e.g. by inlining vm_struct->pages into vm_struct for small areas.
> >=20
> > I temporarily dropped the rest of the patchset for some rework,
> > but decided to leave this patch, because it looks like a nice refactori=
ng
> > in any case, and also it has been already reviewed and acked by Matthew
> > and Johannes.
>=20
> OK then,
>=20
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thank you for looking into this and other patches from the series!

Btw, it looks like that recent changes in vmalloc code are in a conflict
with this patch, so I'll drop it for now, and will resend two other as v4.

Thanks!
