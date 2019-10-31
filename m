Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2332CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1AB2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="B4wSRYAW";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="kB9jWepP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbfJaPtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 11:49:40 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:7076 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726664AbfJaPtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 11:49:39 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9VFjB4P024794;
        Thu, 31 Oct 2019 08:49:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ME/H1ACHPe24OMG3vl1RUw07lFiay8ALqV0QNsz8HoE=;
 b=B4wSRYAWQGVLYISENFhwLuTFQSMg8kDBc+cx9/5hCXRViMejxRI4dBfyrEmZDGIgN5Y0
 R+6yLBlZbZwfPqAaZqjxdK9mMfMM+WM9cmMmN7x57xsIYuD6JB05gx7xPD0srwR3dkj0
 j8pcfZyRMP6tukM3vjQqyRxwnwWaCX38NtE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2w01c4re2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 31 Oct 2019 08:49:27 -0700
Received: from ash-exopmbx201.TheFacebook.com (2620:10d:c0a8:83::8) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 31 Oct 2019 08:49:26 -0700
Received: from ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) by
 ash-exopmbx201.TheFacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 31 Oct 2019 08:49:26 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 31 Oct 2019 08:49:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLJUOcqFUnC5sk32KHRuBHmxs2rpY6JKFjB132p0e7cbH94MbtblzUliSryfgxAnFgBQ+XMxgcuyTXDNEXz5K99K4aZF/JDoObdY8iXIF3SpBSDLozeGSXN3k8VcZAiqdXsIGKKv13CP0wC/8V4ceGImdxkVMNc3e7X6h1pe1ClemzirWGf95kJOEdxElV7FGet09s9Q1kFzfQCWvQ/sBwnWScFmK3rmfAqGbMq8B3RmlO3Hrz3Qfo4jGyxEO7LbR7DWML/CGILoPahnbzXnVUhyfiZnFBDH5FcbhAxY6BlSanN6E6YR+btiKVu372i1cYIfA7BmF6ntTpJXiPPWIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ME/H1ACHPe24OMG3vl1RUw07lFiay8ALqV0QNsz8HoE=;
 b=hp7dZo31EdfpS42NGp9lQu+fGUl8qZLmdObZfcB9yhS2UyNnAyTcViOq8JUjGUf9KaOw6h+l6upuAuqrgjB7m5DxBBq3hZZ0bCGanGGoXT4DXpvLcJLbkC3Nwv8x6THjljWz20oU0LU9F0W2eACoqboKcysOWoLX/BP89DudXNmqZ+EXTkpjPhjDVNmoRdcKf1xr9P6p03futyff8TB6zGNyAsU+xajUOA+yOk3D9NMQw1qGAaYhVCJbrJfxmzuVsdoYYOAcPPP23QwqBxjInmSgcTKg9BZHEBGPbBWNbmQyWfWU9RuIKhks/N9yIDcXO/yW5bgcSymQnETkE5dJMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ME/H1ACHPe24OMG3vl1RUw07lFiay8ALqV0QNsz8HoE=;
 b=kB9jWepP2Cb6QNL/59lTb84Xof4u6/kgpjwSm4gRqU6P4eRL0oY0aUZUkL2X0Z50b6ME/5WGxWMhPNg6nAmj4YjbGMLgnUshzxIhXsBHnKtY4qMDG1qUwwBRqyBfXkICszDl+wybchmkaN5DgYZZZ5m2ES9BXKaAKPzZ/+nMBOA=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2836.namprd15.prod.outlook.com (20.178.220.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.23; Thu, 31 Oct 2019 15:49:22 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0%6]) with mapi id 15.20.2387.027; Thu, 31 Oct 2019
 15:49:22 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Vladimir Davydov" <vdavydov.dev@gmail.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH v2] mm: slab: make page_cgroup_ino() to recognize
 non-compound slab pages properly
Thread-Topic: [PATCH v2] mm: slab: make page_cgroup_ino() to recognize
 non-compound slab pages properly
Thread-Index: AQHVj4mh+jLaqEXqpUiu7sTYH2ejead0JMMAgABaHgCAAGeNAA==
Date:   Thu, 31 Oct 2019 15:49:22 +0000
Message-ID: <20191031154918.GB31765@tower.DHCP.thefacebook.com>
References: <20191031012151.2722280-1-guro@fb.com>
 <20191030211608.29f8fc92e07fd2ac2ef4d1d3@linux-foundation.org>
 <20191031093840.GA9178@hori.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20191031093840.GA9178@hori.linux.bs1.fc.nec.co.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR0201CA0070.namprd02.prod.outlook.com
 (2603:10b6:301:73::47) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:b4b3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aaf7965c-3a06-4990-353b-08d75e19e639
x-ms-traffictypediagnostic: BN8PR15MB2836:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR15MB2836FBD72DC5D14B1B988E30BE630@BN8PR15MB2836.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02070414A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(396003)(366004)(136003)(199004)(189003)(66946007)(66556008)(8936002)(86362001)(81156014)(486006)(11346002)(8676002)(6116002)(1076003)(66446008)(52116002)(476003)(66476007)(99286004)(14454004)(64756008)(81166006)(4326008)(6246003)(446003)(316002)(76176011)(386003)(186003)(6436002)(478600001)(71200400001)(6506007)(256004)(54906003)(71190400001)(14444005)(46003)(229853002)(5660300002)(102836004)(25786009)(6512007)(9686003)(7736002)(33656002)(2906002)(6486002)(305945005)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2836;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X3j4kLQw3rVNiYOr+Dhcp6K49goKoeWsAyuGeDFqXAc5Sonaw3qiOyL0bsTnpHVWDFAKgocKAZlkdxGUGV/v1mzKYbjVbeKL6eYjX7KZLAwVfbp1JXffb2Kpp1viJ/PMw84ybtR8LbVlTHfKwSTCnBcHJYF75+CfnQAt/zL7kRDY9nhtdHTApoMrSTHu8f8Voc9mIadhKuP/ii7I0WmeJPEQvzDxx+xVVHli88Ul/RRTHkJBB42X06Erb3Z/Zk1nzCauC4VcozSp+o69E7cVyinc6CIg4ACW5Td2Xap9lB3X+tSX9bCrMFyxpFcsHtKnHsxklm7O9EzUoC8hjE+qn8J/gVSdTPwbFPYHCGxFk9WyaK5C18C1AVQQZMppMyCsOXyJCK2TJai+0QZYVOfrjzfbDkE5qGwULrVXmVnbGBpaXQUqIEITVxf+W4S5QFOT
Content-Type: text/plain; charset="us-ascii"
Content-ID: <93BE932408AEDF4AB353BB35E5BE1331@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf7965c-3a06-4990-353b-08d75e19e639
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2019 15:49:22.8305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XI6BOQWb6RDF11EH01oyKblUifBv87iJ/FafGYPNzp/u0AxvosZQHsLH+ohHlcmy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2836
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-31_06:2019-10-30,2019-10-31 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 impostorscore=0 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1910310159
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 09:38:40AM +0000, Naoya Horiguchi wrote:
> On Wed, Oct 30, 2019 at 09:16:08PM -0700, Andrew Morton wrote:
> > On Wed, 30 Oct 2019 18:21:51 -0700 Roman Gushchin <guro@fb.com> wrote:
> >=20
> > > page_cgroup_ino() doesn't return a valid memcg pointer for non-compou=
nd
> > > slab pages, because it depends on PgHead AND PgSlab flags to be set
> > > to determine the memory cgroup from the kmem_cache.
> > > It's correct for compound pages, but not for generic small pages. Tho=
se
> > > don't have PgHead set, so it ends up returning zero.
> > >=20
> > > Fix this by replacing the condition to PageSlab() && !PageTail().
> > >=20
> > > Before this patch:
> > > [root@localhost ~]# ./page-types -c /sys/fs/cgroup/user.slice/user-0.=
slice/user@0.service/ | grep slab
> > > 0x0000000000000080	        38        0  _______S_____________________=
______________	slab
> > >=20
> > > After this patch:
> > > [root@localhost ~]# ./page-types -c /sys/fs/cgroup/user.slice/user-0.=
slice/user@0.service/ | grep slab
> > > 0x0000000000000080	       147        0  _______S_____________________=
______________	slab
> > >=20
> > > Fixes: 4d96ba353075 ("mm: memcg/slab: stop setting page->mem_cgroup p=
ointer for slab pages")
> > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > Reviewed-by: Shakeel Butt <shakeelb@google.com>
> > > Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> > > Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
> >=20
> > Affects /proc/kpagecgroup, but page_cgroup_ino() is also used in the
> > memory-failure code - I wonder what effect this bug has there?
>=20
> hwpoison_filter_task() uses output of page_cgroup_ino() in order to
> filter error injection events based on memcg.
> So if page_cgroup_ino() fails to return memcg pointer, we just fail
> to inject memory error.  Considering that hwpoison filter is for testing,
> affected users are limited and the impact should be marginal.
>=20
> >=20
> > IOW, should we backport this into -stable?
>=20
> I think yes, because the patch is small enough and clearly fixes a bug.

I agree.

Thanks!
