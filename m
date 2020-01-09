Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9C9C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3B020882
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="LPntQaPS";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="hoBQ6Ori"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732876AbgAIT4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 14:56:24 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:32146 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732624AbgAIT4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 14:56:24 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 009Jr1OJ030801;
        Thu, 9 Jan 2020 11:56:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=9xXQCq0WNobGal8MQ2BuyB5wSU+ljkwNBjUvA2dLFcw=;
 b=LPntQaPSVkWTIZqS3VkllBd4s3ayKxndMD3c+PRuXFVqBkjLcOkcnjSs8djlQZ1yzSnS
 9K5vuVVGTWMSe9lADA5GokFIq/zUU7qFZeB0MUWx5RmOnamvdhVQScqZbIKdOSwJEUvp
 JhBNUYzFt6C72H0r1OLrhy2qpJ3ujdIS3E4= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2xd3epbgq0-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 09 Jan 2020 11:56:16 -0800
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 9 Jan 2020 11:56:06 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 9 Jan 2020 11:56:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PL2G6vFQD1UyaUuJ1X88L8qlCY3Ayt4TI4PT2GPCUrgXzIELUCCg9yWQCpzYGcIunuOy4l4V95WDvAhCwo5GULzi3H3xXtDiU7wFPXcFg8QxOfC6IXAk+/jG2JLvEChj/VBHhnqMWJhVolAF5ZbOn80tdyi/9TyZaUpGAflXL5BXHmg1846XjXbOo+/+jqzzW1O3cZdu1Y2vPDoKEiCV3TOUDSrlGZPbWgAO7dvYO4FE0e02nDnTxFuPx+WPfjtQYJ3d/+In69D5VrlxE57nYqhSX+C4OI1DFkgViDnzdC46I+9ziSuUOE7dCeaqqubq67fKI8WeA2m4Ab3Pv/DAyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xXQCq0WNobGal8MQ2BuyB5wSU+ljkwNBjUvA2dLFcw=;
 b=SHf5uOjW2k7caPOlCbXrVg3FmJvHUZVHsolgnCY5PaTewQYYxmoLjYAECP3ZZTfyc+RafZx7VVVnqTshwM6R565ZsflhJvDQdC3pannY8fIcfNIKn7tRP+SC1adSOeWtcLYLwYwLd/n7Xq+SY8svppZOd00GernB2tVLqzSBemjpa3Zlg1tYSPA3Y6IKcKPfS1n4ueZ6zJvM+5VxByOsJY3X8SiTg/qbVLHH1skLe/kT5OdOwJRtjGk6/qvP4UbbFi1TmDdiAdlqMgVDqo3C26g4OOLcsPS7mUjRHx9BpsUHRcY/ySGdZxmaYGUeFHa3c5n85mBaatk+zvkmBMpB8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xXQCq0WNobGal8MQ2BuyB5wSU+ljkwNBjUvA2dLFcw=;
 b=hoBQ6OriltzUOcEx/0xVBO7qN6Krlo00dbn8BOR5XgGMCTKubaOYo69CdXreTjgnpqQZ7F2Rsl9N5/U3E2zJfkJ1ge2bTlrLUF0djrDYrK1JIqKkJMmYbhIhwK6TOMDTQbfiBRNWYGMVl0PSvzrsgNppa+ECEzxCSnjBHmlxj6k=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB2197.namprd15.prod.outlook.com (52.135.199.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.15; Thu, 9 Jan 2020 19:56:05 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308%7]) with mapi id 15.20.2623.008; Thu, 9 Jan 2020
 19:56:05 +0000
Received: from tower.DHCP.thefacebook.com (2620:10d:c090:200::2:73c3) by CO2PR18CA0061.namprd18.prod.outlook.com (2603:10b6:104:2::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.8 via Frontend Transport; Thu, 9 Jan 2020 19:56:04 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 1/7] mm: kmem: remove duplicate definitions of
 __memcg_kmem_(un)charge()
Thread-Topic: [PATCH 1/7] mm: kmem: remove duplicate definitions of
 __memcg_kmem_(un)charge()
Thread-Index: AQHVxxIzuWDiGhRsl0GfN8+3jhJSoKfiu0WAgAAENwA=
Date:   Thu, 9 Jan 2020 19:56:04 +0000
Message-ID: <20200109195600.GA14884@tower.DHCP.thefacebook.com>
References: <20200109172745.285585-1-guro@fb.com>
 <20200109172745.285585-2-guro@fb.com>
 <20200109114055.67bda2b70d92b07ef13e3047@linux-foundation.org>
In-Reply-To: <20200109114055.67bda2b70d92b07ef13e3047@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR18CA0061.namprd18.prod.outlook.com
 (2603:10b6:104:2::29) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:73c3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9450c77e-54ef-48a2-7eb8-08d7953df5fc
x-ms-traffictypediagnostic: BYAPR15MB2197:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB2197BA901272085BB4B4E122BE390@BYAPR15MB2197.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:459;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(396003)(366004)(376002)(199004)(189003)(4326008)(1076003)(316002)(7696005)(52116002)(8936002)(66446008)(66946007)(66556008)(8676002)(64756008)(81156014)(66476007)(4744005)(81166006)(478600001)(6916009)(16526019)(186003)(71200400001)(54906003)(86362001)(6506007)(33656002)(5660300002)(9686003)(55016002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2197;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TuO/z6nWv66heFeHkorJS6+CHj3cG2wyntznOnRVKeKc/P6XM1YLFZOF4WRb43wnaCzSjYPXUGRvu3tRCmRJ7TvUZBSFggoW0DO7E3pDY1oLefj71sCL9MFIuuW8MTLsZR4mSMdmI1IsDhO8jt8fDHUePlvZkkFdqog0L4Y45WPk3oFTX31Ec8SNNVodpp8lFXK3qLYaaNO2oOcBt1WrcB77SIl9K8LI/qyCtigB7SP0s0nA5wIWcpsyE5UBPDcL0GYu30lUG4//J/m5A2sOffjpcwyE99otbNZOlbejZ3XEXzPfN7Ghq7Bh6/8E+ZjcO/xkd/sou3bWVq7GBmT3afz4FmBNkV0/6kUsTbwr3KoZqMHmDHFF9ss2YUnyIYAGh+0racua6c18i1KVRP62kHw9/Xym357hnCXid3ZrdazVJzI2Cxz57QSZqHyImEIo
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E9901715D6E19A44AD039511FEBA6AFB@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9450c77e-54ef-48a2-7eb8-08d7953df5fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 19:56:04.9942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3YHgI27l3StxgzaC7xqQ12nf445VxwqBbz0J4xq4tSfa2kzosCHwuyAv8CGzoJrW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2197
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_04:2020-01-09,2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 mlxlogscore=688 phishscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001090163
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 11:40:55AM -0800, Andrew Morton wrote:
> On Thu, 9 Jan 2020 09:27:39 -0800 Roman Gushchin <guro@fb.com> wrote:
>=20
> > For some reason these inline functions are defined twice. Remove
> > the second identical copy.
>=20
> Don't think so - that wouldn't have compiled.
>=20
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -1438,15 +1438,6 @@ static inline void memcg_kmem_uncharge(struct pa=
ge *page, int order)
> >  {
> >  }
> > =20
> > -static inline int __memcg_kmem_charge(struct page *page, gfp_t gfp, in=
t order)
> > -{
> > -	return 0;
> > -}
> > -
> > -static inline void __memcg_kmem_uncharge(struct page *page, int order)
> > -{
> > -}
> > -
> >  #define for_each_memcg_cache_index(_idx)	\
> >  	for (; NULL; )
> > =20
>=20
> Maybe you confused these with memcg_kmem_charge() and
> memcg_kmem_uncharge()?

You're right, I'm blind. Let me drop this patch and resend the series.

Thanks!
