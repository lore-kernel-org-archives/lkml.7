Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E63CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3223D2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Z8sLdFFE";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="VF7Cax93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408333AbfJRNHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 09:07:04 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:11348 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729109AbfJRNHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 09:07:03 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9ID5JSB009786;
        Fri, 18 Oct 2019 06:06:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=uA4NIjhggiPPBd3TSwDKxfgZWSE7TsTaolXRjOpsA7M=;
 b=Z8sLdFFEQRybBx6Je8U3nH+16KeQlq6khk3eYICdZmVnSWeH3kSDFZnErU6vnkYy5Ek9
 9KB/dOUaFiSpvNJ/bMPQnTXlBSf0yPre2jNsOYvX6qrcHJUVWbiTTLdbcaOxPbT0TSY+
 268ye+LuUqhnbDVDzQnEiyNyD20CgpgDQaI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vpcs180g4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Oct 2019 06:06:53 -0700
Received: from ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) by
 ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 18 Oct 2019 06:06:51 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 18 Oct 2019 06:06:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnkMRsnqqh/eHIQL9HhrmyKiei+/Dzpp0yo2c83P4Yf18tugCIART18D67rEuR77IU/ahcr6R1hZ10Ik9AUsv6Th1qZrC+UWJ2i1dK/uKQ1GJYt6vjCWNWEiKRAGPVMqFM6c3uInbxvcov+Q2Byu5yQHCyuSthJoujgsxesS5beNkHgdGEP9TGg9RxmbVD7zB0G+mkVbDpzJFX9hldYlT9xnH7xkhD8O8qzTrawHCwXjUwr2EEC8DsuEr5oLRx/YB2sndZXLDjOV8uu9OWUnAPU2j20XmSy20qK8IE75muZGvrxLWTaAfsjF+F04UEePM9+4V0u5lTjo+9OaR3W7Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uA4NIjhggiPPBd3TSwDKxfgZWSE7TsTaolXRjOpsA7M=;
 b=QGhERp5TF76HJn0q9pnq+ddOynGkn4aBCUoXjGIByHqnbUO3UD4xaRiYsFA/JaInenrV8u3ZSg7wIP0q6dNi76z9Fmm1+McB35BHTx7nuQelz2oiFLFmpfoY46osEPrv2ohjA8Ss4s3rll+6c+LjUwCn6HG+/N72zqQb+7sO7WhXwt9LHnZ4cX4v4blpZyxgfpjOzLVHgpWTkNfvnhiLZHmKd69Ts+z8NbKX3Q89KlIkzL85W5G0ck5L81XIkVAu61CDvYJLgJiYDGjeD7sx8SX68nMu4++vmAstSpXtJdI1BTlnxMnHi2V1njHFg5mJWBWukNQLFiUEYKZVOpGjeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uA4NIjhggiPPBd3TSwDKxfgZWSE7TsTaolXRjOpsA7M=;
 b=VF7Cax93YLF2fi+D9YsLiTzkhvaJ08cuRi3hi7OLpQxH837pKd97+AT64WJES54f4U+sIG9nOZYz9Huq1YPnWYm6dtvgj4R5gbS4pVjSmjcdjftQKy5XYiywdsd/EgJG+BPJyYoGdMtBLz962Yl/3L1G3UwmYtCIrYGuWdOSJ8A=
Received: from BYAPR15MB3479.namprd15.prod.outlook.com (20.179.57.24) by
 BYAPR15MB3464.namprd15.prod.outlook.com (20.179.58.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 18 Oct 2019 13:06:50 +0000
Received: from BYAPR15MB3479.namprd15.prod.outlook.com
 ([fe80::d51c:c256:7d42:ee23]) by BYAPR15MB3479.namprd15.prod.outlook.com
 ([fe80::d51c:c256:7d42:ee23%3]) with mapi id 15.20.2367.019; Fri, 18 Oct 2019
 13:06:50 +0000
From:   Rik van Riel <riel@fb.com>
To:     Song Liu <songliubraving@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        Kernel Team <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Hugh Dickins" <hughd@google.com>
Subject: Re: [PATCH] mm,thp: recheck each page before collapsing file THP
Thread-Topic: [PATCH] mm,thp: recheck each page before collapsing file THP
Thread-Index: AQHVhXJENhkhstl0P0GXabgc+7SHqadgXuMA
Date:   Fri, 18 Oct 2019 13:06:49 +0000
Message-ID: <f4c5c920961732fe855748cd5304f77b0c556b29.camel@fb.com>
References: <20191018050832.1251306-1-songliubraving@fb.com>
In-Reply-To: <20191018050832.1251306-1-songliubraving@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:208:160::28) To BYAPR15MB3479.namprd15.prod.outlook.com
 (2603:10b6:a03:106::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:480::f10d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ac085cf-7cec-44c1-5608-08d753cc097b
x-ms-traffictypediagnostic: BYAPR15MB3464:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB34646C270F77B245130460F5A36C0@BYAPR15MB3464.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(396003)(366004)(136003)(376002)(189003)(199004)(71190400001)(71200400001)(76176011)(486006)(478600001)(316002)(110136005)(86362001)(99286004)(6506007)(4326008)(446003)(6246003)(102836004)(118296001)(2616005)(186003)(11346002)(52116002)(54906003)(66946007)(4744005)(5660300002)(386003)(476003)(2501003)(64756008)(66476007)(66446008)(36756003)(2201001)(14454004)(66556008)(46003)(81156014)(6116002)(25786009)(81166006)(229853002)(7736002)(8936002)(4001150100001)(6512007)(8676002)(305945005)(256004)(6436002)(6486002)(2906002)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3464;H:BYAPR15MB3479.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pYaesQZPnkQZUhUPbmGyMqvQZktP8p03zUdWPApVfVOSN1lYVJ8DnPO68wBit6rtO2d2R/gldbB5ckaQw6YYoHn0OqVh5CLBvAtyAL307y8xN5JScpJNaQa/7lJwuAHGB4YqZfInvRemlY7LWlcA+xzzQF/mqSnT2ZtXC6cWcPO8pGY+5w5QKS/+1Qg0w9HEFP5fE7KJnN9wNwHM5ud5ItQBunLKH5OZ67IMfrXKpTe1Hwe7QgX0Of4qL4chWNcfQQ+qecptQZ6PhTOGUQX6e4iC4xES3nAPgICVZhGASzmBQDkYok0Rkmhf7fd3gH0+zoWiWbtZ18fSq4XQnbW7dNyLhpNMODsRKOhN7l6N1xMjUsm9LACwya9JizIBBCn7LE7yoczoOgVFKEyMVM2qT5AbXUtT9b77kCeURe4DfOk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E938C7201677654CB6D561985A42EE6B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac085cf-7cec-44c1-5608-08d753cc097b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 13:06:49.9602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eQB5cZb/dbR05c8wWsE0Wy2gpYbc0fNyUfE/LUjGaYdSIc0UoBDeB2VFQbAgK7GV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3464
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-18_03:2019-10-18,2019-10-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 clxscore=1011 impostorscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=623 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910180124
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTEwLTE3IGF0IDIyOjA4IC0wNzAwLCBTb25nIExpdSB3cm90ZToNCj4gSW4g
Y29sbGFwc2VfZmlsZSgpLCBhZnRlciBsb2NraW5nIHRoZSBwYWdlLCBpdCBpcyBuZWNlc3Nhcnkg
dG8NCj4gcmVjaGVjaw0KPiB0aGF0IHRoZSBwYWdlIGlzIHVwLXRvLWRhdGUsIGNsZWFuLCBhbmQg
cG9pbnRpbmcgdG8gdGhlIHByb3Blcg0KPiBtYXBwaW5nLg0KPiBJZiBhbnkgY2hlY2sgZmFpbHMs
IGFib3J0IHRoZSBjb2xsYXBzZS4NCj4gDQo+IEZpeGVzOiA5OWNiMGRiZDQ3YTEgKCJtbSx0aHA6
IGFkZCByZWFkLW9ubHkgVEhQIHN1cHBvcnQgZm9yIChub24tDQo+IHNobWVtKSBGUyIpDQo+IENj
OiBLaXJpbGwgQS4gU2h1dGVtb3YgPGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5jb20+DQo+
IENjOiBKb2hhbm5lcyBXZWluZXIgPGhhbm5lc0BjbXB4Y2hnLm9yZz4NCj4gQ2M6IEh1Z2ggRGlj
a2lucyA8aHVnaGRAZ29vZ2xlLmNvbT4NCj4gQ2M6IFdpbGxpYW0gS3VjaGFyc2tpIDx3aWxsaWFt
Lmt1Y2hhcnNraUBvcmFjbGUuY29tPg0KPiBDYzogQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1m
b3VuZGF0aW9uLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogU29uZyBMaXUgPHNvbmdsaXVicmF2aW5n
QGZiLmNvbT4NCg0KQWNrZWQtYnk6IFJpayB2YW4gUmllbCA8cmllbEBzdXJyaWVsLmNvbT4NCg0K
