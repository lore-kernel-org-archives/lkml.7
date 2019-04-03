Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FD3C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F512084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="aLYNkfV0";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="PK87nXx9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfDCSp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:45:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49478 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726064AbfDCSp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 14:45:27 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x33IX2mh012647;
        Wed, 3 Apr 2019 11:45:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=i+GnCgx99leNZnPXeDWo95hjH3kzCBuware3EhkuWLU=;
 b=aLYNkfV0EPUBTxqxe9GsXY9HmIxjPa0Y6oxG36KlxTN92og/OI3AWHvGtIkeosB2+aoD
 EAoTfJJyumPrsGl8ZPZdlX0IJeKmLcyFjHPN4qR8o3ZUSuGRXTBHMXAleQCDg8Eod7T+
 LqI6zzwG6M31qigssqdXDGtcYz3DFT8CJ7M= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rn1tf05en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Apr 2019 11:45:16 -0700
Received: from prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 3 Apr 2019 11:44:36 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 3 Apr 2019 11:44:35 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 3 Apr 2019 11:44:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+GnCgx99leNZnPXeDWo95hjH3kzCBuware3EhkuWLU=;
 b=PK87nXx9K+O8ySEcndsmccGSopBtvQaPvYluU03ZbBtkRKGlFNKCwK6AeOGv79I7M1MDxgZURlLJfEr6l7dCj860VdDbAuNQllLlr667tew6A/ZW0W5u+yuUpIcC6v6TLAXGUaZR2Og0MESigBeZMJpBXutpqoBX5SqXBgOgQTc=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3335.namprd15.prod.outlook.com (20.179.58.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.15; Wed, 3 Apr 2019 18:44:18 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded%3]) with mapi id 15.20.1750.017; Wed, 3 Apr 2019
 18:44:19 +0000
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
Subject: Re: [PATCH v5 6/7] slab: Use slab_list instead of lru
Thread-Topic: [PATCH v5 6/7] slab: Use slab_list instead of lru
Thread-Index: AQHU6ajFJNY85SdJxkGxd4eRBwv3baYqxyeA
Date:   Wed, 3 Apr 2019 18:44:18 +0000
Message-ID: <20190403184415.GF6778@tower.DHCP.thefacebook.com>
References: <20190402230545.2929-1-tobin@kernel.org>
 <20190402230545.2929-7-tobin@kernel.org>
In-Reply-To: <20190402230545.2929-7-tobin@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR07CA0061.namprd07.prod.outlook.com (2603:10b6:100::29)
 To BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:9220]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 462f810e-2fbb-4e58-44f2-08d6b864612b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB3335;
x-ms-traffictypediagnostic: BYAPR15MB3335:
x-microsoft-antispam-prvs: <BYAPR15MB3335C1478F9942D79F831CCDBE570@BYAPR15MB3335.namprd15.prod.outlook.com>
x-forefront-prvs: 0996D1900D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(136003)(366004)(376002)(199004)(189003)(186003)(6486002)(11346002)(33656002)(6436002)(476003)(6116002)(46003)(6916009)(229853002)(446003)(2906002)(105586002)(68736007)(106356001)(316002)(53936002)(25786009)(54906003)(97736004)(6246003)(7736002)(305945005)(4326008)(99286004)(256004)(486006)(14454004)(478600001)(5660300002)(52116002)(6512007)(9686003)(8676002)(76176011)(102836004)(71190400001)(86362001)(8936002)(6506007)(386003)(4744005)(1076003)(71200400001)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3335;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jAItvlvsVbDQPM83ZEYSr1sw7qNTeAYZifS0G1iIaZWcszt9VgEIthIkPabR4oMHsI/LUXPEsRbJ1vzSAjCPYlyiplxA8yE7l9elyaGy6amN8Xtub/Ug4TrbPqQpVkdOfpote+1gaCITw9+othIUfNHOLyivxWmY9hwgGY9JYIOdxO0OOLCtlB50yadpwjFVeZOajoS6qnP8vmUApktVKymLZcog27/XQqmjXf2ZXrLl3ILjtI34SNsMbMNx5pGljZJUsoPhHZlBMh/mzRhbCDPYEe+GzzrJalkCl00rCmUXqRcnHU7jgVVBhWyJvHlgP3yWYlZX4ao8MLHsv37Lhax5BX4dsqW5mY1aTFr2LGROcPjjxgi763RTTWGGXL/mbwCXNyXHy3JPKHL+5pdNBqAMzeKQjGU7G2wJLR+hQ5E=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <149C5B8A63DAAD4F8CD636AD438EC86F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 462f810e-2fbb-4e58-44f2-08d6b864612b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2019 18:44:18.8551
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

On Wed, Apr 03, 2019 at 10:05:44AM +1100, Tobin C. Harding wrote:
> Currently we use the page->lru list for maintaining lists of slabs.  We
> have a list in the page structure (slab_list) that can be used for this
> purpose.  Doing so makes the code cleaner since we are not overloading
> the lru list.
>=20
> Use the slab_list instead of the lru list for maintaining lists of
> slabs.
>=20
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>

Reviewed-by: Roman Gushchin <guro@fb.com>
