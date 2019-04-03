Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E3EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486132133D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="EnIyRq++";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ZfcinuEq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfDCSmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:42:46 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35706 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726099AbfDCSmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 14:42:46 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x33IXmKd008705;
        Wed, 3 Apr 2019 11:42:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Rjb3llispwfKjVXMXSX6JILU/ScWO8TCCwCZlyFQtOo=;
 b=EnIyRq++iRHDlGLOxSzawXoYP9/DSq07sd/xXeKHaSYbQ+iiK8fefDpZOfa+ElZrRtAl
 KtvDWmNDNfgqrojELdLqYfh47PGh9vn9SZfZrSr5z0O5+19tCSN8tOUUoEMh9RjXue0Y
 Kz6S77fgUBrsacm4YMbw2jwgIPhz/KzUQEU= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0089730.ppops.net with ESMTP id 2rn0cb8kag-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Apr 2019 11:42:31 -0700
Received: from frc-hub04.TheFacebook.com (2620:10d:c021:18::174) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 3 Apr 2019 11:42:30 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 3 Apr 2019 11:42:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rjb3llispwfKjVXMXSX6JILU/ScWO8TCCwCZlyFQtOo=;
 b=ZfcinuEqq//v8nEMm8pzY6kCP1kfmiaXZu+/+crTwh1XBFLt6OFXYGX3rHbT3mUIU3qc5ljqZ7KEOkIpMRKjeBU9z6SgLUr6ykcZMGqqfx2MBidLMgufNX8JpVNu8EBqlVKMPg9uso26D5s26d12QVu0JMt+KuDpI/xwnu3Kwrw=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3480.namprd15.prod.outlook.com (20.179.60.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.13; Wed, 3 Apr 2019 18:42:27 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded%3]) with mapi id 15.20.1750.017; Wed, 3 Apr 2019
 18:42:27 +0000
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
Subject: Re: [PATCH v5 4/7] slub: Add comments to endif pre-processor macros
Thread-Topic: [PATCH v5 4/7] slub: Add comments to endif pre-processor macros
Thread-Index: AQHU6ajBwVxIgIrx7ESbIcbajaDpPaYqxqMA
Date:   Wed, 3 Apr 2019 18:42:27 +0000
Message-ID: <20190403184223.GD6778@tower.DHCP.thefacebook.com>
References: <20190402230545.2929-1-tobin@kernel.org>
 <20190402230545.2929-5-tobin@kernel.org>
In-Reply-To: <20190402230545.2929-5-tobin@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR15CA0041.namprd15.prod.outlook.com
 (2603:10b6:300:ad::27) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:9220]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a100f5a-df1e-43fa-e835-08d6b8641ecd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB3480;
x-ms-traffictypediagnostic: BYAPR15MB3480:
x-microsoft-antispam-prvs: <BYAPR15MB348011715D3D81339A93C43DBE570@BYAPR15MB3480.namprd15.prod.outlook.com>
x-forefront-prvs: 0996D1900D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39860400002)(376002)(366004)(346002)(199004)(189003)(6486002)(33656002)(46003)(14454004)(478600001)(76176011)(6916009)(97736004)(2906002)(186003)(102836004)(25786009)(256004)(6506007)(386003)(229853002)(105586002)(106356001)(53936002)(305945005)(6246003)(7736002)(6512007)(9686003)(476003)(446003)(68736007)(11346002)(86362001)(486006)(99286004)(5660300002)(8676002)(54906003)(81166006)(316002)(4326008)(81156014)(4744005)(6436002)(52116002)(71190400001)(71200400001)(1076003)(6116002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3480;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +Nc1/yugvQ/RfQ3Wk+HlCrw7Yhm0yP41l1gCFADH+ygKID9uz1HcX3gKdMhod1QDcWH9SZQZjhmRTiBpHu/ajPcPGGb4zTn2pb9SNXZiNg+eRo8U5dCEbgPITFJVIDmSa/38QkuZ/FFvXtjxJSYkW6IOjLKocOrIG0WZMPVQ3NZMUnm/6SRRsnljIATBlF783i7feCQtCTNmJHeNCpvdkc0qdWYxH35jrh59Lqvdof2Q+OROTsaqPr7JTvY6CL4lqH/BE4WoID8sFsqsd635tybIY/inolCIkbRb2q7KLk2Ql/5aFowJywAIyo0M6NSelov8QX/8hyYepQMLN59aPZPLeEscNU53Ebf3vuxXRVlMrH6hL84Y1gDr9UYj8iMo/K4wdeB+HKC5YQ0B9VmqV+XepTywJVwEcQD7bdkj334=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F86A4325CD5BD1448246DE117FA34B55@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a100f5a-df1e-43fa-e835-08d6b8641ecd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2019 18:42:27.5577
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

On Wed, Apr 03, 2019 at 10:05:42AM +1100, Tobin C. Harding wrote:
> SLUB allocator makes heavy use of ifdef/endif pre-processor macros.
> The pairing of these statements is at times hard to follow e.g. if the
> pair are further than a screen apart or if there are nested pairs.  We
> can reduce cognitive load by adding a comment to the endif statement of
> form
>=20
>        #ifdef CONFIG_FOO
>        ...
>        #endif /* CONFIG_FOO */
>=20
> Add comments to endif pre-processor macros if ifdef/endif pair is not
> immediately apparent.
>=20
> Acked-by: Christoph Lameter <cl@linux.com>
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>

Reviewed-by: Roman Gushchin <guro@fb.com>
