Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DC3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E5C2084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="k5MFHvIs";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="B4ePKuIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfCLAJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 20:09:59 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53266 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725989AbfCLAJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 20:09:58 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2C03GqP017275;
        Mon, 11 Mar 2019 17:09:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=b7Pd1HiFaq8Q8LerO3yocf42b947cTLoE6rdxENJUnM=;
 b=k5MFHvIsXJPRsrUbcb47Agd0Tay/yDPLXojd5SvapSLwa3yGgALweMFalC2BunIqsNmN
 G1JAxxu3C8/Dsmz2IAQlV0kWvJsPx78vTD/A1FtMHViPra6ju8dKAqXVjM+3HVqvsBXp
 bu++xA33s0WE0yWMQ3/stxV0FvcUWvMsv+Y= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2r5yvg0e4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 11 Mar 2019 17:09:35 -0700
Received: from frc-mbx01.TheFacebook.com (2620:10d:c0a1:f82::25) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 11 Mar 2019 17:09:33 -0700
Received: from frc-hub04.TheFacebook.com (2620:10d:c021:18::174) by
 frc-mbx01.TheFacebook.com (2620:10d:c0a1:f82::25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 11 Mar 2019 17:09:33 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 11 Mar 2019 17:09:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7Pd1HiFaq8Q8LerO3yocf42b947cTLoE6rdxENJUnM=;
 b=B4ePKuIKrUBLGS+T8FazeXSRUlrvmp2OKmvaPly2N4CLXHso50gjpZaJyaqYq1iJ26nRyuvr0aAhaYgsqyY7MdplmzsEsBKOaomNJGDKT5YMZb+NalFjzP8heb8n4+JeWTvoYov6Pohl9qLh49NNxSio40c8lnhseU9BeFLfXKM=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2597.namprd15.prod.outlook.com (20.179.155.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Tue, 12 Mar 2019 00:09:31 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded%2]) with mapi id 15.20.1686.021; Tue, 12 Mar 2019
 00:09:31 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "Tobin C. Harding" <tobin@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christopher Lameter <cl@linux.com>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        Matthew Wilcox <willy@infradead.org>,
        Tycho Andersen <tycho@tycho.ws>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 00/15] mm: Implement Slab Movable Objects (SMO)
Thread-Topic: [RFC 00/15] mm: Implement Slab Movable Objects (SMO)
Thread-Index: AQHU1WWWNeCS+/ChkEynjyh1uhCoA6YHJOwA
Date:   Tue, 12 Mar 2019 00:09:31 +0000
Message-ID: <20190312000928.GA25059@tower.DHCP.thefacebook.com>
References: <20190308041426.16654-1-tobin@kernel.org>
In-Reply-To: <20190308041426.16654-1-tobin@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0001.prod.exchangelabs.com (2603:10b6:a02:80::14)
 To BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:b487]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db79a75b-38eb-440b-a824-08d6a67f0000
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2597;
x-ms-traffictypediagnostic: BYAPR15MB2597:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2597;20:V3oCi9y5DXNhGoacojprWGP6D2MN/r/PHMyfQ5UtVBKcPTVODpILIdffqFRIAmEdLtOMf+u8o+uikivTZ5F1MW8ZYcUM85Q8QNsAu5Q7pZYRoVC6ZZgatIoWWjUYcnkRetgmhIGR+xkncYw+xVqJ/g9WsE/vKZ/u58osco54qFA=
x-microsoft-antispam-prvs: <BYAPR15MB2597A5805A6F53D0AF068B1EBE490@BYAPR15MB2597.namprd15.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39860400002)(376002)(396003)(136003)(366004)(346002)(189003)(199004)(6306002)(486006)(6512007)(102836004)(33656002)(476003)(99286004)(966005)(6246003)(186003)(46003)(52116002)(53936002)(386003)(9686003)(76176011)(1076003)(105586002)(11346002)(6436002)(7736002)(81166006)(446003)(5660300002)(106356001)(81156014)(305945005)(68736007)(8676002)(478600001)(8936002)(2906002)(71190400001)(71200400001)(6506007)(14454004)(25786009)(6916009)(14444005)(316002)(256004)(4326008)(6486002)(6116002)(86362001)(54906003)(97736004)(229853002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2597;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Rqv+5v6EqJxOmWC/5Xtzjw5U5Eua9CJpIeOvO6Jqc080IrTELc5vO+O4upD7ZJsVtUlLfDOcta5iJ9cEUJ7UsMK4CnLWbdit7bhn/bWEv8zNyFoRm0DdBw/s2CLs0pw9EYfWeQnsSpB1gpZNweCkSDooizPwdamD0OxYfUHa7JwnPTL6RK1cdZLzqpN8c8kvhP21I61U7gagXOYja6kmzUv3BlO9lwUcpL+I2S7iFW/a2Ztmkts4qneVW8fRarOFWLEGjiO+62ezixpaWmvE/4kEdG6oJZ9taHk2mvjCjAmBMz18c8OKM4aLxFDRXy3nA3bWJFBgwi5+NdGesgoFGizcr8iArYGDYloMI7VbD3kMTz7Gm3Tfl3PO69PuutPFjPKY94rWOr5hMVhWkjBW3XqESUfZAevkGERPGG6taO8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <39E60E583FE06A488ECD823CDDDD8185@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: db79a75b-38eb-440b-a824-08d6a67f0000
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 00:09:31.3326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2597
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-11_17:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 03:14:11PM +1100, Tobin C. Harding wrote:
> Hi,
>=20
> Here is a patch set implementing movable objects within the SLUB
> allocator.  This is work based on Christopher's patch set:
>=20
>  https://lore.kernel.org/patchwork/project/lkml/list/?series=3D377335
>=20
> The original code logic is from that set and implemented by Christopher.
> Clean up, refactoring, documentation, and additional features by myself.
> Blame for any bugs remaining falls solely with myself.  Patches using
> Christopher's code use the Co-developed-by tag.
>=20
> After movable objects are implemented a number of useful features become
> possible.  Some of these are implemented in this series, including:
>=20
>  - Cache defragmentation.	  =20
>=20
>     Currently the SLUB allocator is susceptible to internal
>     fragmentation.  This occurs when a large number of cached objects
>     are allocated and then freed in an arbitrary order.  As the cache
>     fragments the number of pages used by the partial slabs list
>     increases.  This wastes memory.
>=20
>     Patch set implements the machinery to facilitate conditional cache
>     defragmentation (via kmem_cache_defrag()) and unconditional
>     defragmentation (via kmem_cache_shrink()).  Various sysfs knobs are
>     provided to interact with and configure this.
>=20
>     Patch set implements movable objects and cache defragmentation for
>     the XArray.
>=20
>  - Moving objects to and from a specific NUMA node.
>=20
>  - Balancing objects across all NUMA nodes.
>=20
> We add a test module to facilitate playing around with movable objects
> and a python test suite that uses the module.
>=20
> Everything except the NUMA stuff was tested on bare metal, the NUMA
> stuff was tested with Qemu NUMA emulation.
>=20
> Possible further work:
>=20
> 1. Implementing movable objects for the inode and dentry caches.
>=20
> 2. Tying into the page migration and page defragmentation logic so that
>    so far unmovable pages that are in the way of creating a contiguous
>    block of memory will become movable.  This would mean checking for
>    slab pages in the migration logic and calling slab to see if it can
>    move the page by migrating all objects.


Hi Tobin!

Very interesting and promising patchset! Looking forward for inode/dentry
moving support, might be a big deal for allocating huge pages dynamically.

Thanks!
