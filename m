Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA898CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 15:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2C6214B2
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 15:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Qu/5EpGy";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="G/kRnFYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732576AbfJVP7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 11:59:24 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59512 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731671AbfJVP7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 11:59:23 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9MFhY18023096;
        Tue, 22 Oct 2019 08:59:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Bv2ihuOKJxEssArPeRmXEl1Im4yqa5MtKKWVsvMaxFE=;
 b=Qu/5EpGyonu+KAc0jnqJsAyeeHUw9qHYJXiYlHHIE+h41ESD/MTuTjEpr9INbrn6iqrq
 CuoLeOJdfXVbW8g5f2nVcg/g0UPiMn/5lyY+i/XZ1BR0erSkXHqYmKO5Ns9hd4hvz+gO
 0jOy7UnKnQOpu7UHncRGC7Me2/OyustyqhM= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vrj6stu1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 22 Oct 2019 08:59:08 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 22 Oct 2019 08:59:07 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 22 Oct 2019 08:59:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfIt8AOUDx2kP8egNxW3CvjErrIMNgjTbb76q84JW2kCcQHgnlGtnGpGzmIidx4F8ZCe5n8FQ68sv0npXnuRoTGxbjeaHw+Y2RuP3K4DkTaatQr4Yq1kuZNds9uE9jQq8Gj6YBtyVksl2SGxzEIJx+mWk1Fb+b8bZWFBR4RDjvZ2o47S/GJZWXiBEhOSIWp9rZCk1czWuQTV/J+r0vMny3U7iNmBEf1LQsCwiW9L1ENKnEcOJ9i/eoG8+bKbP3S0AuaVRyXk5RgZ5MOncyarMJIGbSd1Yp/qGHAacprHnj8pNsk13J9XdOS0Dl75W7E1cNV6JbuqC9MMQ/ruTTCbPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bv2ihuOKJxEssArPeRmXEl1Im4yqa5MtKKWVsvMaxFE=;
 b=jDKvA0bM5wj+6AQK/m/kYyLCI4hWqOkuwZAfGSq+04S1FYhB1smuCQIiAfTDEMKYLnpjubZgeY2LlHKgkbTlJsV1iB+qP9evXV+QgVMNb1Vnc2IL1cXsylJkqlD9ewR91oQrr8yzXmR2U65jqc/QzWBrvO53rEp0yKFHySOez54MDG8N6kQ/3XrynbJOJPx7ldx2EJafB8kD661oWxgTV6FnVUa0vMnWK3jDhi8ev18Xq+j503CZlBZfg31wsiAIfss8XLYZ2IipGKahHrvrIVBmu9sDS8LhbFZwmlJWtrFvcywY6m+FV0NYedz1xznWE8+YWLnNhvAHixsWe53q9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bv2ihuOKJxEssArPeRmXEl1Im4yqa5MtKKWVsvMaxFE=;
 b=G/kRnFYyRKKcM7kQrkV1lc99patsOZhjyxslmKewh8wkcYZi1p/9zvJTSry9y9znIqjiRey/p1/x0K5gSijNktzUvQuKTbp92r9MtaNgmiG67Sj3c54h4KOpu3CMRdiFpogY3bA51C108RquvdEYPjLDmL0Mpg537iZF2qroAmM=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB3058.namprd15.prod.outlook.com (20.178.221.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Tue, 22 Oct 2019 15:59:06 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0%6]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 15:59:06 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Shakeel Butt" <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "Waiman Long" <longman@redhat.com>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH 00/16] The new slab memory controller
Thread-Topic: [PATCH 00/16] The new slab memory controller
Thread-Index: AQHVhUsDHbAZ56EwPkekUglLv37/GKdmr4UAgAApIoA=
Date:   Tue, 22 Oct 2019 15:59:06 +0000
Message-ID: <20191022155901.GB21381@tower.DHCP.thefacebook.com>
References: <20191018002820.307763-1-guro@fb.com>
 <20191022133148.GP9379@dhcp22.suse.cz>
In-Reply-To: <20191022133148.GP9379@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0027.namprd21.prod.outlook.com
 (2603:10b6:300:129::13) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::7e8a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8df29f7-c882-47a5-e066-08d75708c46c
x-ms-traffictypediagnostic: BN8PR15MB3058:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR15MB3058780A1C6B690AD0996FEFBE680@BN8PR15MB3058.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(366004)(376002)(136003)(189003)(199004)(476003)(6486002)(8676002)(5660300002)(478600001)(229853002)(81156014)(9686003)(1076003)(256004)(6246003)(81166006)(11346002)(4326008)(6512007)(46003)(71190400001)(8936002)(25786009)(14454004)(71200400001)(6436002)(54906003)(446003)(305945005)(66446008)(64756008)(66556008)(6116002)(386003)(7736002)(66946007)(99286004)(6506007)(86362001)(76176011)(6916009)(102836004)(33656002)(486006)(2906002)(316002)(66476007)(186003)(52116002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB3058;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eS7TdyvcSTuyGxfX47BKRCe0ghUg55MK8XVDqKxZZ6YRGs53OCnP9AjiuNdcJ247alXcVDPrjVuUhKHKOV/hyenUQPztBsVE380cPU0RGXBcZyTVDYYNMvEAi356kbQ3cUJDRruqsj9nDmWyovK/DE43mQq2IkNSr+MKmQY/IYpchJZB1pks6e7sCeJC+aqWg/m2tAUBqAaJuqJ5TIkg1HOym5NLrKyaP9x4P91TiIG1y/E2QtUO+jeUiNoTTj0WCWHr2BmKToSOAD9aNRDwWAZmtVG8hPFMGrVbm+osZX7HquJBmMtqt2nFTgVtPcH+xAipLq3omL4mV2XlUs2HDHWUb/u4xKlN+HBMHwQAGkHj2pREqoo2c2/Ntg8Js4AdpNBM6vhpq8h3iNxkc0Sp1w1i9Zp5mHIIkKa+xVZfxHST6dhgY/SUemRD03VbDLJP
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DBB0ED485F47A04F804F6E4BCB9CEE19@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c8df29f7-c882-47a5-e066-08d75708c46c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 15:59:06.5397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DbKIE8iMkZJeJBX71mVtMS+ogUx9jCTFwArk16Rhd917DPpGqrBclLe/Eb5gktW7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3058
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-22_03:2019-10-22,2019-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 adultscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910220136
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 03:31:48PM +0200, Michal Hocko wrote:
> On Thu 17-10-19 17:28:04, Roman Gushchin wrote:
> > This patchset provides a new implementation of the slab memory controll=
er,
> > which aims to reach a much better slab utilization by sharing slab page=
s
> > between multiple memory cgroups. Below is the short description of the =
new
> > design (more details in commit messages).
> >=20
> > Accounting is performed per-object instead of per-page. Slab-related
> > vmstat counters are converted to bytes. Charging is performed on page-b=
asis,
> > with rounding up and remembering leftovers.
> >=20
> > Memcg ownership data is stored in a per-slab-page vector: for each slab=
 page
> > a vector of corresponding size is allocated. To keep slab memory repare=
nting
> > working, instead of saving a pointer to the memory cgroup directly an
> > intermediate object is used. It's simply a pointer to a memcg (which ca=
n be
> > easily changed to the parent) with a built-in reference counter. This s=
cheme
> > allows to reparent all allocated objects without walking them over and =
changing
> > memcg pointer to the parent.
> >=20
> > Instead of creating an individual set of kmem_caches for each memory cg=
roup,
> > two global sets are used: the root set for non-accounted and root-cgrou=
p
> > allocations and the second set for all other allocations. This allows t=
o
> > simplify the lifetime management of individual kmem_caches: they are de=
stroyed
> > with root counterparts. It allows to remove a good amount of code and m=
ake
> > things generally simpler.
>=20
> What is the performance impact?

As I wrote, so far we haven't found any regression on any real world worklo=
ad.
Of course, it's pretty easy to come up with a synthetic test which will sho=
w
some performance hit: e.g. allocate and free a large number of objects from=
 a
single cache from a single cgroup. The reason is simple: stats and accounti=
ng
are more precise, so it requires more work. But I don't think it's a real
problem.

On the other hand I expect to see some positive effects from the significan=
tly
reduced number of unmovable pages: memory fragmentation should become lower=
.
And all kernel objects will reside on a smaller number of pages, so we can
expect a better cache utilization.

> Also what is the effect on the memory
> reclaim side and the isolation. I would expect that mixing objects from
> different cgroups would have a negative/unpredictable impact on the
> memcg slab shrinking.

Slab shrinking is already working on per-object basis, so no changes here.

Quite opposite: now the freed space can be reused by other cgroups, where
previously it was often a useless operation, as nobody can reuse the space
unless all objects will be freed and the page can be returned to the page
allocator.

Thanks!
