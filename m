Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2EECA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 19:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFDB2080F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 19:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="nDZqrxx1";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Wpw4aw9K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfJ3Tkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 15:40:49 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:9002 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726269AbfJ3Tkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 15:40:49 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9UJdMtp011833;
        Wed, 30 Oct 2019 12:40:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=zFHjtoNtKmgRXPq8/FOLSvIGtdJKhzAq+uKzvkB8Yyo=;
 b=nDZqrxx1Al9WNb5D3V/y8bWMKFuDxbsYA1n5NQvF7544Dj9lzIwaL704Y8wVbhJeXFsf
 qcFvbK2dDSzmFG3AH+GPKPmGrCNw6j4fAc4LxHDUMdAka1BZTggHsaTV+1vVkYLqDsZk
 asx1YYGVDS8K2PER/x8cwZC3S6jI0P1ri7I= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vxwn7dnef-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 30 Oct 2019 12:40:40 -0700
Received: from prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 30 Oct 2019 12:40:39 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 30 Oct 2019 12:40:39 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 30 Oct 2019 12:40:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Umto/kgRotvTlymp0IPSB0KdnFpGunIVKaMeSO9uWeXRg0GsMC214KX5WGk7kRYnr4hrdNEcqcHgkQyHMiR53Qcr6cQVa8wwswedFrwHodpPGhulpfAlcxEv0H77+FdY3ns5bP1HwIyV6tgvU3eFuBWyP9O7pvuN4AH28aKH2E8hpFCCZKfh7MN5P0/f6Aj+Lc1axR6dwg+wGXa8EMMBUTUyHTAf/c6ZDQM78tvcQQ8K/jVA+htrS0QGdjiV/TDJXzcztvc1Ib6wMj4JsS1cstXMQUUywnoo5+WliRQIBNl3qzyrfD9DpMUjz4g0L4hyVNwT6jfDcGOMQ+L68y7Oiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFHjtoNtKmgRXPq8/FOLSvIGtdJKhzAq+uKzvkB8Yyo=;
 b=Dt9QuLt3NBsSH/W4DBUyHjj1kbh8gFrNkotSDfM9J9Pxm5p9T5V2jTpBbUI5AQ01BFFprVy/6n15BLg8IM+b2Xpa8gQjDK0DHnHAc7cRiUOwaTdPvf085Zfdxb6Y3RMnK6P6eFITMi6ZoGcFd/adqz5R7csVClA4nzBVcbhMphivARC/QIRzU3YPFcQBxinmh7MDFx55+fEyMhXyiOevFG0LFTI0qtvy1kSCBxftzAMrauSQO4v92nw+tVVIC8u1EWE+FA1EqpkNUbVtz3+Ri0gGnVpwDQQM4sJUGeZNgl9BH8Hx2nuq7BHg4M+HTDJYe6t9yytgx4K9DCZTLgBkVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFHjtoNtKmgRXPq8/FOLSvIGtdJKhzAq+uKzvkB8Yyo=;
 b=Wpw4aw9KmwUXxeG0O61Gnv/sS952IVA5jXtVCtJSBwuZV7lqAvSPc7qcSSnWKLq3gXPdE9lwsgM+Itfnt09lKqGmxoHszaHyozOIBzZAOAMS61ghgdUu2EEastvCaRgOHY2nYHKCmLQ4ILwC2+8D0IbPeapeaeU63zwSU7jvxe0=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2593.namprd15.prod.outlook.com (20.179.137.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Wed, 30 Oct 2019 19:40:34 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0%6]) with mapi id 15.20.2387.027; Wed, 30 Oct 2019
 19:40:34 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH] mm: slab: make page_cgroup_ino() to recognize
 non-compound slab pages properly
Thread-Topic: [PATCH] mm: slab: make page_cgroup_ino() to recognize
 non-compound slab pages properly
Thread-Index: AQHVi4v82H5KK2bDBUCYEvoLagPlLadznKqA
Date:   Wed, 30 Oct 2019 19:40:34 +0000
Message-ID: <20191030194027.GA6679@castle.DHCP.thefacebook.com>
References: <20191025232710.4081957-1-guro@fb.com>
In-Reply-To: <20191025232710.4081957-1-guro@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0030.namprd22.prod.outlook.com
 (2603:10b6:300:69::16) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::ddf3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c34441cd-c3ea-4577-c199-08d75d7107cb
x-ms-traffictypediagnostic: BN8PR15MB2593:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR15MB25934A46EBBBEF05DF67AD7FBE600@BN8PR15MB2593.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(136003)(346002)(366004)(396003)(199004)(189003)(54906003)(6436002)(6246003)(486006)(81166006)(46003)(6486002)(9686003)(6116002)(446003)(476003)(5660300002)(11346002)(2501003)(229853002)(6512007)(386003)(66946007)(2906002)(66556008)(64756008)(66446008)(66476007)(6506007)(110136005)(316002)(14454004)(76176011)(25786009)(4326008)(1076003)(8676002)(14444005)(71200400001)(256004)(71190400001)(81156014)(52116002)(478600001)(86362001)(102836004)(99286004)(8936002)(186003)(7736002)(305945005)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2593;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NQYgytzGhljdwTu/3jCQZQVlaCH42OfsUzjMlOZrRxEFH574FSTYyJ0FDF8wWBFmVnbC0Qi63p0eojg28LdAL/ngyzx3mAeWQJZSbdgs8dYaNwOVAOwuh2uEjMjHupWUnxl4f8YsVyZWjAPZDZ50aMk6faVfuFkOsS1wawD/vZfxvteJyRMtiCK/eMvQRtWE0nXC3PXm83OcuwMev4KHxPJqDm28FOP0p2yglcLdYIme5PugxVSljUgM3+/9uIva00sKjEJgfFQYoBBFH6+CElVQKOsgl6YDzSFaCzWQITIR9G0JB3QrJ+RLDkq6CD4bWZ63lJztZ/38yB6YPBqHwTkbhVTKIlUqbp+NwQueDtHSN16AO0Q7IpSaGrxW7c8PqvYLLKcOdAaTC8jx5M+KjU5u58U+xZcgN8jn7vSz6micBYCl11ttVmifmq2YOuxL
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E14B558EFD8D2549B990F1FA3E87F924@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c34441cd-c3ea-4577-c199-08d75d7107cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 19:40:34.2024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9npif/F9CWQqitgU+phaautPTb3ZxsvmTddqV42FDWoeM+QEhy7JDsUDwd/YA/k3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2593
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-30_08:2019-10-30,2019-10-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 adultscore=0 phishscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910300170
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 04:27:10PM -0700, Roman Gushchin wrote:
> page_cgroup_ino() doesn't return a valid memcg pointer for non-compund
> slab pages, because it depends on PgHead AND PgSlab flags to be set
> to determine the memory cgroup from the kmem_cache.
> It's correct for compound pages, but not for generic small pages. Those
> don't have PgHead set, so it ends up returning zero.
>=20
> Fix this by replacing the condition to PageSlab() && !PageTail().
>=20
> Before this patch:
> [root@localhost ~]# ./page-types -c /sys/fs/cgroup/user.slice/user-0.slic=
e/user@0.service/ | grep slab
> 0x0000000000000080	        38        0  _______S_________________________=
__________	slab
>=20
> After this patch:
> [root@localhost ~]# ./page-types -c /sys/fs/cgroup/user.slice/user-0.slic=
e/user@0.service/ | grep slab
> 0x0000000000000080	       147        0  _______S_________________________=
__________	slab
>=20
> Fixes: 4d96ba353075 ("mm: memcg/slab: stop setting page->mem_cgroup point=
er for slab pages")
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Shakeel Butt <shakeelb@google.com>

Ping?

> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index ea085877c548..00b4188b1bed 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -476,7 +476,7 @@ ino_t page_cgroup_ino(struct page *page)
>  	unsigned long ino =3D 0;
> =20
>  	rcu_read_lock();
> -	if (PageHead(page) && PageSlab(page))
> +	if (PageSlab(page) && !PageTail(page))
>  		memcg =3D memcg_from_slab_page(page);
>  	else
>  		memcg =3D READ_ONCE(page->mem_cgroup);
> --=20
> 2.17.1
>=20
