Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED0CC352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 02:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C0D2086A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 02:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="V7mGQasR";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="NjVPxiOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbfJBCJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 22:09:29 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:19848 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726315AbfJBCJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 22:09:28 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x92296b3001216;
        Tue, 1 Oct 2019 19:09:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=h/3NjOhr4Th3RIR4dYCM9BZ7Bed1bbGjefXNLdeDC+A=;
 b=V7mGQasRM6fg+qMumxBs3SOqumzLtkC5Wezyjqi5ROYdGjwZrh5wMHAxcJP7zUhPSTq5
 jeU70X+vnZ+u3ClX+3dl7NkoPHeS5q0UPfQk+TFSYmrkj1yap8DhzfR9omcXLXmBKI0l
 ljIFDxSON3prv7NS2N0kqgzjAfxA1lDAzFY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vce9314hx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 01 Oct 2019 19:09:15 -0700
Received: from ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 1 Oct 2019 19:09:14 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 1 Oct 2019 19:09:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7R3Epu//fULBYJcD3dPpYzLK3DF7q3kvRwFayPoXlPVms9kTuCBjz3hngk2Nm19wYwvzZ8PkjC+xjYcf9vIhcd6GnhH53PeJswDkXCcPIHGx3IbmZFra2ORTRPdsuA6Dqv81OwJUKRQqrc4TGfgZb7EinDBkDCMkUgSzkzy8YLY8UR0l2PFE24PRbA4Ch0EjTfEE5eC2+Bhodh83qO32QNRWlih5dGbJ7lV5k76AA6GTJbGiZ0WRm/iDe8G2OaIMIQO0J4yREJQdeTWTZ8RKHC7YljlY8dzNqXjffI06rlltNT9il6DpTVrLpY/ut74LA689l8i3BkUTcWc/abKzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/3NjOhr4Th3RIR4dYCM9BZ7Bed1bbGjefXNLdeDC+A=;
 b=IuSE4KrA1C5q+YDUMS6DK4lC1XFReyzaIH8+/icS4ZrCXnHzhPvnzlmo1ONUOuBxb2afFTK70Abn0/HOSCsbHBoTvbavAfLNz4qJv1ISvr1m/hXWv1E3bqlLm136CCIS/D0GusKQlzfiBbq6og5Z/dUPpG9+UigE6TaqOzWK7RWwtkL/ClDmk5i112JE4uFNVlPupLpWU5PEBfM7Zh9O8okJPNX2NX+IdYNDnaC3XaJWJndmnD/Lb5+d9kcJsMlvDU4GrGBfTu/vByHo6eduW633GoOtTlR9BQDEO8vc9011Obw8S+3kWwozOajh9fmlB2/cLIX4Asqg5hC2VX3wLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/3NjOhr4Th3RIR4dYCM9BZ7Bed1bbGjefXNLdeDC+A=;
 b=NjVPxiOhGeL9Gl38B64GntNDmGvQ/qwG9fPxxbEwGt8eqyFY0+q5q3Ny/ENUlMP9k8GeqxP8XCuUT4O+UN5ySckAvc3OJ26x4pmV7YoaIQm5xEEw3WpnxW1QDJoOKK2m9B0iY13HYPg4y46ssWedO125El7jWFZUR459skCWgKU=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB3187.namprd15.prod.outlook.com (20.179.72.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Wed, 2 Oct 2019 02:09:11 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::dde5:821f:4571:dea4]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::dde5:821f:4571:dea4%5]) with mapi id 15.20.2305.022; Wed, 2 Oct 2019
 02:09:11 +0000
From:   Roman Gushchin <guro@fb.com>
To:     =?iso-8859-1?Q?Michal_Koutn=FD?= <mkoutny@suse.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH RFC 00/14] The new slab memory controller
Thread-Topic: [PATCH RFC 00/14] The new slab memory controller
Thread-Index: AQHVZDNwmo4dH7vFVEWbwj6k0KVokadGDMAAgAC3lQA=
Date:   Wed, 2 Oct 2019 02:09:11 +0000
Message-ID: <20191002020906.GB6436@castle.dhcp.thefacebook.com>
References: <20190905214553.1643060-1-guro@fb.com>
 <20191001151202.GA6678@blackbody.suse.cz>
In-Reply-To: <20191001151202.GA6678@blackbody.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0004.namprd19.prod.outlook.com
 (2603:10b6:300:d4::14) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::dca2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19a30c08-5d78-4362-db44-08d746dd8423
x-ms-traffictypediagnostic: BN8PR15MB3187:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR15MB31877982E761B0358E006B0BBE9C0@BN8PR15MB3187.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(366004)(39860400002)(189003)(199004)(8936002)(81166006)(81156014)(186003)(46003)(102836004)(6506007)(386003)(4326008)(8676002)(6916009)(6246003)(478600001)(99286004)(14454004)(25786009)(76176011)(52116002)(66446008)(71190400001)(71200400001)(6116002)(66556008)(66946007)(6436002)(1076003)(64756008)(2906002)(66476007)(86362001)(7736002)(305945005)(256004)(446003)(476003)(486006)(316002)(11346002)(6486002)(9686003)(33656002)(6512007)(229853002)(54906003)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB3187;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PfyTz3TCWsRv12EvF/hw6aDKaHw3J7e/P8RZLtUGmy8/TNwxgsedlO6/KxB4T9CnJchCS36JhqiMgN3hSRofLqPllIwmsznvGM/Sq/PCtJYHaQVAQyUjRE7jrCHmNI9tsiAPjnZgbVo53ETASmIdP2VIDb3RJY77SI1FQr+HOyKgRuo69iaMk7N4a6ngdFMU3yiNI74ozoPAzduMIrZV2hkxoPALPQLS48z9n/bSfoN60YUpGfpPUtzoY/I7lZ9NEQLMHVAC8zLZv3RkQc1PTWJI5xloiCjkOldxYz6KuEWbEBMx30B5DA2Hzsz1M9Qj02DIuZM9WyTeG49urQLF0n/lSj8rUl9nomvX7M5RjmgVtb8CHSBaGKGr6ytf7gzzg2uE7r06xAwo59sIoXcDDoki3bHpK7ueOKCwWwH7GJc=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <3BF5C1432CAE894293127F4977D6735A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a30c08-5d78-4362-db44-08d746dd8423
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 02:09:11.7222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NegXxpLMYUkWiJp1X+qrIlTscUe4GotaMPvQCIz9dHzDsfPh5VL7NP8kzzVIScrO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3187
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-02_01:2019-10-01,2019-10-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=900
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 clxscore=1011 spamscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910020018
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 05:12:02PM +0200, Michal Koutn=FD wrote:
> On Thu, Sep 05, 2019 at 02:45:44PM -0700, Roman Gushchin <guro@fb.com> wr=
ote:
> > Roman Gushchin (14):
> > [...]
> >   mm: memcg/slab: use one set of kmem_caches for all memory cgroups
> From that commit's message:
>=20
> > 6) obsoletes kmem.slabinfo cgroup v1 interface file, as there are
> >   no per-memcg kmem_caches anymore (empty output is printed)
>=20
> The empty file means no allocations took place in the particular cgroup.
> I find this quite a surprising change for consumers of these stats.
>=20
> I understand obtaining the same data efficiently from the proposed
> structures is difficult, however, such a change should be avoided. (In
> my understanding, obsoleted file ~ not available in v2, however, it
> should not disappear from v1.)

Well, my assumption is that nobody is using this file for anything except
debugging purposes (I might be wrong, if somebody has an automation based
on it, please, let me know). A number of allocations of each type per memor=
y
cgroup is definitely a useful debug information, but currently it barely wo=
rks
(displayed numbers show mostly the number of allocated pages, not the numbe=
r
of active objects). We can support it, but it comes with the price, and
most users don't really need it. So I don't think it worth it to make all
allocations slower just to keep some debug interface working for some
cgroup v1 users. Do you have examples when it's really useful and worth
extra cpu cost?

Unfortunately, we can't enable it conditionally, as a user can switch
between cgroup v1 and cgroup v2 memory controllers dynamically.

Thanks!
