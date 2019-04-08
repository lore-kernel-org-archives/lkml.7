Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47882C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 23:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A042206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 23:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="WVOyTNzb";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="SaXxx9DD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfDHXUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 19:20:31 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59620 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726494AbfDHXUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 19:20:30 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x38N9kWH000320;
        Mon, 8 Apr 2019 16:19:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=R5KmHGlX6NVqP1HVdkVvBxurQ3c+PPWd1dCpJKzJMKI=;
 b=WVOyTNzbCAH4RRDrLwAz4AeXF4sJDt80ByXJnV1oMB3e6FvjZZPkjh9knV9GIgIBIJ4U
 4E7MnO1qvp21H7mKUr9op9ECRf9jxYxrOgeIplPTHY6+kbDYZDlJSEipA1KdJ27neI6e
 D9chldNQNUzTsR9QVddIxTp0fGpvEUykRdY= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rrevrg705-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 08 Apr 2019 16:19:22 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 8 Apr 2019 16:19:13 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 8 Apr 2019 16:19:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5KmHGlX6NVqP1HVdkVvBxurQ3c+PPWd1dCpJKzJMKI=;
 b=SaXxx9DDfRi2NffLDj+uAD3Xe7LlE7crecyOpGZVSeHNc1bgpLxlDNT71CP3kNWmzCvTQf3mNghCp8YfiDyMKACeZmwEHiUqyHeIZsRjER6aqN44uKJB84Bw4YXMJKJYC9L0WtbBwRYNQO5XsWMO7VrEYF7zdhV9soZvtTkIOVY=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3397.namprd15.prod.outlook.com (20.179.59.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.13; Mon, 8 Apr 2019 23:19:11 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded%3]) with mapi id 15.20.1771.016; Mon, 8 Apr 2019
 23:19:11 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v4 1/3] mm/vmap: keep track of free blocks for vmap
 allocation
Thread-Topic: [PATCH v4 1/3] mm/vmap: keep track of free blocks for vmap
 allocation
Thread-Index: AQHU7KeAYDXmPyf7LE+XJfMAqtm1ZaYy6Z6A
Date:   Mon, 8 Apr 2019 23:19:11 +0000
Message-ID: <20190408231905.GA31139@tower.DHCP.thefacebook.com>
References: <20190406183508.25273-1-urezki@gmail.com>
 <20190406183508.25273-2-urezki@gmail.com>
In-Reply-To: <20190406183508.25273-2-urezki@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0106.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::47) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:d96]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd234fb2-fde6-4565-8e9d-08d6bc789b5c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB3397;
x-ms-traffictypediagnostic: BYAPR15MB3397:
x-microsoft-antispam-prvs: <BYAPR15MB3397040140913949298BE58CBE2C0@BYAPR15MB3397.namprd15.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(396003)(366004)(136003)(346002)(189003)(199004)(6246003)(81156014)(446003)(5660300002)(6486002)(316002)(86362001)(9686003)(6512007)(8676002)(71190400001)(1411001)(106356001)(14444005)(105586002)(33656002)(8936002)(256004)(478600001)(97736004)(71200400001)(14454004)(53936002)(52116002)(6916009)(6436002)(81166006)(6506007)(476003)(25786009)(1076003)(46003)(6116002)(305945005)(486006)(7736002)(386003)(102836004)(68736007)(54906003)(7416002)(186003)(2906002)(229853002)(4326008)(76176011)(99286004)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3397;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rz7Z00MrtDVwkgtEYDV/EcZaPtj8fx0jBlcdCb+fz13HSHlJFbXPBPxjHyeASjHRu5bWkLSU/sWSezG3hzwOxG8V0OrTrcWbEzkgBxnBHJuVWhXkLHfIu4YDC6GzqeoIujZkDlHqaHynqo2wWz2Ru9COPWY0V1rCqywS4GFZ8wq6QaDp4NQ6/70m4aEpj/I65GNX2dDcLVI9ihgxok1B63AoNLYNdGmFzn+wY+vTwm8zNzdvg3v8bJUvRSkcG/xGU9HgtK3+zlM9aDphzL4YoysWYuCY8gwbbk/2KKRZWPkUTuBYN46XD4cHWC2YrzS/r2f31EjpnkAvw3qWl5Pf/LnGPb/mY68+5/Oy2vS3IXD4N/T3K4rNAg0/cvTnfsBhCLXK95pJI+Sq3Xt+O4bVPOccHMqs52n4MCUPhpGUXmU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C4FA4A1AF8985F409BA7BA14D4B29AB2@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dd234fb2-fde6-4565-8e9d-08d6bc789b5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 23:19:11.1888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3397
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-08_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 06, 2019 at 08:35:06PM +0200, Uladzislau Rezki (Sony) wrote:
> Currently an allocation of the new vmap area is done over busy
> list iteration(complexity O(n)) until a suitable hole is found
> between two busy areas. Therefore each new allocation causes
> the list being grown. Due to over fragmented list and different
> permissive parameters an allocation can take a long time. For
> example on embedded devices it is milliseconds.
>=20
> This patch organizes the KVA memory layout into free areas of the
> 1-ULONG_MAX range. It uses an augment red-black tree that keeps
> blocks sorted by their offsets in pair with linked list keeping
> the free space in order of increasing addresses.
>=20
> Nodes are augmented with the size of the maximum available free
> block in its left or right sub-tree. Thus, that allows to take a
> decision and traversal toward the block that will fit and will
> have the lowest start address, i.e. it is sequential allocation.
>=20
> Allocation: to allocate a new block a search is done over the
> tree until a suitable lowest(left most) block is large enough
> to encompass: the requested size, alignment and vstart point.
> If the block is bigger than requested size - it is split.
>=20
> De-allocation: when a busy vmap area is freed it can either be
> merged or inserted to the tree. Red-black tree allows efficiently
> find a spot whereas a linked list provides a constant-time access
> to previous and next blocks to check if merging can be done. In case
> of merging of de-allocated memory chunk a large coalesced area is
> created.
>=20
> Complexity: ~O(log(N))
>=20
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks!
