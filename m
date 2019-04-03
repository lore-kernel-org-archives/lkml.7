Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F53C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A583F2147C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Ve4Vyrbg";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="BkilDUYV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfDCSp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:45:29 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46278 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726144AbfDCSp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 14:45:28 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x33IiSfE019251;
        Wed, 3 Apr 2019 11:45:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=L7FIHyvcM/tt1s1gSuW9RkbRdE58Qv8n7027w8tuaJc=;
 b=Ve4VyrbgVY16XXZvAxRcxOC18/y50DAHj9MLKANgAEQf40ViQUQtWHoW+LY/aujUQas5
 MU4OANsVFqI7Gd7f6sX21LDh3T0/zzQ7AWxPCbRZMEzm1kLOZw2FzPDUcMu3vv88Vwt2
 IQSRp7Ozf+Dq3+eDHu9MVDnSSDZyxmhJd+I= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rmx9t953b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Apr 2019 11:45:13 -0700
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 3 Apr 2019 11:45:12 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 3 Apr 2019 11:45:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7FIHyvcM/tt1s1gSuW9RkbRdE58Qv8n7027w8tuaJc=;
 b=BkilDUYVdwR7h+0+ikXUbGX08fOq/k2APlz+4p3saYA3XSXbhQZFLDhm1RCHE6kEa8a7Jn574yfVhj9aAU+xt0B5kqpCzGP7HKC6s+BRPpIbqNtDaRyyfcZ7GbftxCtceIReeL75qwykTIBtxwzBZ6/FQXTYQ65aiemUIjlJyG8=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3335.namprd15.prod.outlook.com (20.179.58.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.15; Wed, 3 Apr 2019 18:45:10 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded%3]) with mapi id 15.20.1750.017; Wed, 3 Apr 2019
 18:45:10 +0000
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
Subject: Re: [PATCH v5 7/7] mm: Remove stale comment from page struct
Thread-Topic: [PATCH v5 7/7] mm: Remove stale comment from page struct
Thread-Index: AQHU6ajOU7GynWp6IEue5SP0M2OjLaYqx2QA
Date:   Wed, 3 Apr 2019 18:45:10 +0000
Message-ID: <20190403184506.GG6778@tower.DHCP.thefacebook.com>
References: <20190402230545.2929-1-tobin@kernel.org>
 <20190402230545.2929-8-tobin@kernel.org>
In-Reply-To: <20190402230545.2929-8-tobin@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0112.namprd04.prod.outlook.com
 (2603:10b6:104:7::14) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:9220]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e80ce9b-df6c-4a14-daa7-08d6b864801e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB3335;
x-ms-traffictypediagnostic: BYAPR15MB3335:
x-microsoft-antispam-prvs: <BYAPR15MB3335F3A816AD9739A46E6AF5BE570@BYAPR15MB3335.namprd15.prod.outlook.com>
x-forefront-prvs: 0996D1900D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(136003)(366004)(376002)(199004)(189003)(186003)(6486002)(11346002)(33656002)(6436002)(476003)(6116002)(46003)(6916009)(229853002)(446003)(2906002)(105586002)(68736007)(106356001)(316002)(53936002)(25786009)(54906003)(97736004)(6246003)(7736002)(305945005)(4326008)(99286004)(256004)(486006)(14454004)(478600001)(5660300002)(52116002)(6512007)(9686003)(8676002)(76176011)(102836004)(71190400001)(86362001)(8936002)(6506007)(386003)(4744005)(1076003)(71200400001)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3335;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: denffugvwvATL80wSYqch6/toU3EeOaeuIBZhTA1xj8r5LQ17oLxji+/84HkhHh69u6YOs15bVdSOyF3Rr1Ti/DXuCZ0ukXhd+esmPbfY5l9WKT0yyxNOyiJrJsq4qmZlR/mM5uOcoFsph0gqfnzeK8TuTnWen2Vw3AJJRhSc7KOPdqlMCgbS7aY1MvHdBmPuGLWcEPS/tLuEsQQ4LKYykyOUYuNSpoIC/1dCud1zP2JtGr4nbWhUoKXPQ0CV71B3B8kZM4lL5Jy3bFkzfEcqmI+q3/EvDE6mjRPkmtSZAO0ZGmmBGYuveRcI2XA9+xb1n9RrXQwpUkO3fPBNZuHGNTVxTXZJEcb5CxowmLUfzcULG+YdzGwg3AinWaW24YZUkfIWjs9/xi0p7B+noZYq+KI0sBEqtfuFv4AYLq0MfU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13443334D4FE2B4E80C8D86B49925EBE@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e80ce9b-df6c-4a14-daa7-08d6b864801e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2019 18:45:10.7851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3335
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-03_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 10:05:45AM +1100, Tobin C. Harding wrote:
> We now use the slab_list list_head instead of the lru list_head.  This
> comment has become stale.
>=20
> Remove stale comment from page struct slab_list list_head.
>=20
> Acked-by: Christoph Lameter <cl@linux.com>
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>

Reviewed-by: Roman Gushchin <guro@fb.com>

Thank you!
