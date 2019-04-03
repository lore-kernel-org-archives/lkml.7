Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C761C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C842B2133D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Yl/xPNan";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="gfkVG0XO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfDCSn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:43:26 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41844 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726151AbfDCSnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 14:43:25 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x33Ih8w2014641;
        Wed, 3 Apr 2019 11:43:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=xakx3XOAalKXuenJk7d0hryS8+ZvFx48h2UyI+RZdwk=;
 b=Yl/xPNan9ifQnaFSRbHS6liDVt9rS0jkcXdkzb6vZeJb2IAiowehyScG7+jVnr/hORyl
 THs3mrOKJ5vcpOZ044e23vLWY5L3DrEtHv9tPENExZ/z5PiNrgx77g/Z1okg3495oQoF
 STEJrFQ1mqwoOahOeRqpqTe4v8lYTSogN0U= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rn1hvg7na-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Apr 2019 11:43:09 -0700
Received: from frc-hub06.TheFacebook.com (2620:10d:c021:18::176) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 3 Apr 2019 11:43:09 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 3 Apr 2019 11:43:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xakx3XOAalKXuenJk7d0hryS8+ZvFx48h2UyI+RZdwk=;
 b=gfkVG0XOtuz148wpdiYFT9jWKV/hQ5DC0LBgOOvadbs/GuyWuOJs9BK+tV18TKZ/xVmu86+4coLQ+8wXGmRKFcbbP83m328alu9BfNAkj7wadsbvq9Ge3gKS8nC02H1g60W7Lj0MihTK3vETyiU83VVRirOCfQ+vg+xNp3HnfKs=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3480.namprd15.prod.outlook.com (20.179.60.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.13; Wed, 3 Apr 2019 18:43:07 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded%3]) with mapi id 15.20.1750.017; Wed, 3 Apr 2019
 18:43:07 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "Tobin C. Harding" <tobin@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 5/7] slub: Use slab_list instead of lru
Thread-Topic: [PATCH v5 5/7] slub: Use slab_list instead of lru
Thread-Index: AQHU6ajGtW+41y5S4EKW3fNq6YALbqYqxtIA
Date:   Wed, 3 Apr 2019 18:43:07 +0000
Message-ID: <20190403184303.GE6778@tower.DHCP.thefacebook.com>
References: <20190402230545.2929-1-tobin@kernel.org>
 <20190402230545.2929-6-tobin@kernel.org>
In-Reply-To: <20190402230545.2929-6-tobin@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO1PR15CA0078.namprd15.prod.outlook.com
 (2603:10b6:101:20::22) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:9220]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 944a08f4-bf65-4004-6c10-08d6b86436be
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB3480;
x-ms-traffictypediagnostic: BYAPR15MB3480:
x-microsoft-antispam-prvs: <BYAPR15MB348029F2F584370F69FA26E3BE570@BYAPR15MB3480.namprd15.prod.outlook.com>
x-forefront-prvs: 0996D1900D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39860400002)(376002)(366004)(346002)(199004)(189003)(6486002)(33656002)(46003)(14454004)(478600001)(76176011)(6916009)(97736004)(2906002)(186003)(102836004)(25786009)(256004)(6506007)(386003)(229853002)(105586002)(106356001)(53936002)(305945005)(6246003)(7736002)(6512007)(9686003)(476003)(446003)(68736007)(11346002)(86362001)(486006)(99286004)(5660300002)(8676002)(54906003)(81166006)(316002)(4326008)(81156014)(4744005)(6436002)(52116002)(71190400001)(71200400001)(1076003)(6116002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3480;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GrGjB722PV83xmFxXkL1w7Id3SHchCDRt9uHHDhiW9pS6aWU2j/EZMdQ4TyHnVwFlP5wtOs4vVZSZAYBQL9bUm2C4iVXs11xORyBurPrKriEcXL1Qfaaoqo4r5aM+DslVHqmpPXQuznzD2gK7yU691xGCjcXo7BIkss3onyR0/fhzfWFKXKu5BikQ34cs2b5Qzk6duTgPugFJUk4wCySDDk7UHJDqlkxbYEWU4mUXG++vwLxVfcbIqXpMHK/PD+bt0tPMulef/e3hbgqZObq1R1EwuojjC9uiamYoZIaDeoyFVllS0hWK+MHJe4Y/nkKNV3gzuemsJa+DidDbdZj8Vu4cn1oqiImjpVTO+N894XaLEyTS3kChhcoFUjabX21c+2frpYF7ByNUP9v6PgceV8E2hbES9Ltp0TqzdbQklE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2FB2145B5F59E742BBA0F8C5ABF950EB@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 944a08f4-bf65-4004-6c10-08d6b86436be
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2019 18:43:07.6605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3480
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-03_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 10:05:43AM +1100, Tobin C. Harding wrote:
> Currently we use the page->lru list for maintaining lists of slabs.  We
> have a list in the page structure (slab_list) that can be used for this
> purpose.  Doing so makes the code cleaner since we are not overloading
> the lru list.
>=20
> Use the slab_list instead of the lru list for maintaining lists of
> slabs.
>=20
> Acked-by: Christoph Lameter <cl@linux.com>
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>

Reviewed-by: Roman Gushchin <guro@fb.com>
