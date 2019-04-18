Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9CCC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8153F2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="cjFy83iZ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="XRR+MgJf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391174AbfDRS1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:27:42 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34312 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390834AbfDRS1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:27:39 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3IIHEoO011918;
        Thu, 18 Apr 2019 11:27:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=IXulJh/FgqYyotf43koBiEZBD43j5St1HHGGcJU+mZA=;
 b=cjFy83iZQfoz7LPg9XQLT2DOK6pE5xBhKAZeuMf66WNhnWezaagIWY/nd7D6JS1JXlNE
 vSElNrg8sHXOHO2knrW0C4nO7sq6JSpW2zkoSsBnwsFgxQeZcG2/nqtwco+VWymre/2E
 ireOk3AYr9BgtBWIOyg20Sg+toM0GNuq3/I= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rxj0btgtp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 18 Apr 2019 11:27:23 -0700
Received: from frc-mbx04.TheFacebook.com (192.168.155.19) by
 frc-hub06.TheFacebook.com (192.168.177.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 18 Apr 2019 11:27:21 -0700
Received: from frc-hub03.TheFacebook.com (192.168.177.73) by
 frc-mbx04.TheFacebook.com (192.168.155.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 18 Apr 2019 11:27:21 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 18 Apr 2019 11:27:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXulJh/FgqYyotf43koBiEZBD43j5St1HHGGcJU+mZA=;
 b=XRR+MgJfvfbDJKlT1x0eiy/mzB0NHswLQq5j93ov8qwxgsk2G2TRQvPiL67enqRFWOlsmpR8JEVeStgAzo9DWUH1gaAKiua07ZqkO0HhnlEMKGw2s5Hz5yXQE9CoMo3K0ipFL2GoGIpBvk/YEaf2gtFZZSqIIiZUL2vz6Iyp4N8=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3109.namprd15.prod.outlook.com (20.178.239.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Thu, 18 Apr 2019 18:27:17 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d1a1:d74:852:a21e]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d1a1:d74:852:a21e%5]) with mapi id 15.20.1792.021; Thu, 18 Apr 2019
 18:27:17 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Vladimir Davydov <vdavydov.dev@gmail.com>
CC:     Roman Gushchin <guroan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: [PATCH 0/5] mm: reparent slab memory on cgroup removal
Thread-Topic: [PATCH 0/5] mm: reparent slab memory on cgroup removal
Thread-Index: AQHU9Wg69blQ7CDdk0OXGcJgZSFPq6ZBkv4AgACq4QA=
Date:   Thu, 18 Apr 2019 18:27:17 +0000
Message-ID: <20190418182714.GD11008@tower.DHCP.thefacebook.com>
References: <20190417215434.25897-1-guro@fb.com>
 <20190418081538.prspe27lqudvvu3u@esperanza>
In-Reply-To: <20190418081538.prspe27lqudvvu3u@esperanza>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::23) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:497d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02d7e6a5-e02a-4a25-3efd-08d6c42b7c85
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR15MB3109;
x-ms-traffictypediagnostic: BYAPR15MB3109:
x-microsoft-antispam-prvs: <BYAPR15MB310945206782EDF8B7BC3550BE260@BYAPR15MB3109.namprd15.prod.outlook.com>
x-forefront-prvs: 0011612A55
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(39860400002)(396003)(366004)(52314003)(199004)(189003)(2906002)(8676002)(8936002)(9686003)(7416002)(486006)(5660300002)(68736007)(6246003)(305945005)(11346002)(446003)(81166006)(476003)(7736002)(81156014)(4326008)(71200400001)(6506007)(186003)(25786009)(66446008)(76176011)(52116002)(6512007)(386003)(71190400001)(14444005)(99286004)(53936002)(102836004)(64756008)(33656002)(6486002)(478600001)(97736004)(316002)(46003)(256004)(86362001)(1076003)(6916009)(6436002)(6116002)(229853002)(14454004)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3109;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +QtMHIIxu0MnqdaUI9fWX0CMjFGe0LEBDswgYAFRqYQVdJv62eTzAiUQ5FJVn6JorJJMP3bgn5UpmO5QxiNZZAqjsr0CeASvYySO2no+J3wcyW6g0/uEVI2mPBU8P4xrh44oOVt/45HxH7IxfVIPahSeh+4kwd/srzntWb6TAI4iC3MGuIiv3G4T8AiFXxCafb7OKooC9tpCdlGVHH0aCmLFbhUkhERS206fbl93fZ6J/5oL12kd07fgcO86oMFtxt/ZhfrtTDEOBDhzsPeOvc3D1eV00dH9U4ayegede/1OJOP27gxq9gGLbG2npaXnhGK2BVXH5nXypEZyKIZGRmsmXxCBJG0YHGmJ0Lbfu77ex4LjouwKOlHixRL8JnQB/KFo3JESltBI+08SXuZkYisiSCE63z1ilmMj9yNbDV0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6199B9832BACEB4A82B2F0815266A507@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d7e6a5-e02a-4a25-3efd-08d6c42b7c85
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2019 18:27:17.4190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3109
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-18_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 11:15:38AM +0300, Vladimir Davydov wrote:
> Hello Roman,
>=20
> On Wed, Apr 17, 2019 at 02:54:29PM -0700, Roman Gushchin wrote:
> > There is however a significant problem with reparenting of slab memory:
> > there is no list of charged pages. Some of them are in shrinker lists,
> > but not all. Introducing of a new list is really not an option.
>=20
> True, introducing a list of charged pages would negatively affect
> SL[AU]B performance since we would need to protect it with some kind
> of lock.
>=20
> >=20
> > But fortunately there is a way forward: every slab page has a stable po=
inter
> > to the corresponding kmem_cache. So the idea is to reparent kmem_caches
> > instead of slab pages.
> >=20
> > It's actually simpler and cheaper, but requires some underlying changes=
:
> > 1) Make kmem_caches to hold a single reference to the memory cgroup,
> >    instead of a separate reference per every slab page.
> > 2) Stop setting page->mem_cgroup pointer for memcg slab pages and use
> >    page->kmem_cache->memcg indirection instead. It's used only on
> >    slab page release, so it shouldn't be a big issue.
> > 3) Introduce a refcounter for non-root slab caches. It's required to
> >    be able to destroy kmem_caches when they become empty and release
> >    the associated memory cgroup.
>=20
> Which means an unconditional atomic inc/dec on charge/uncharge paths
> AFAIU. Note, we have per cpu batching so charging a kmem page in cgroup
> v2 doesn't require an atomic variable modification. I guess you could
> use some sort of per cpu ref counting though.

Yes, looks like I have to switch to the percpu counter (see the thread
with Shakeel).

>=20
> Anyway, releasing mem_cgroup objects, but leaving kmem_cache objects
> dangling looks kinda awkward to me. It would be great if we could
> release both, but I assume it's hardly possible due to SL[AU]B
> complexity.

Kmem_caches are *much* smaller than memcgs. If the size of kmem_cache
is smaller than the size of objects which are pinning it, I think it's
acceptable. I hope to release all associated percpu memory early to make
it even smaller.

On the other hand memcgs are much larger than typical object which
are pinning it (dentries and inodes). And it rends to grow with new feature=
s
being added.

I agree that releasing both would be cool, but I doubt it's possible.

>=20
> What about reusing dead cgroups instead? Yeah, it would be kinda unfair,
> because a fresh cgroup would get a legacy of objects left from previous
> owners, but still, if we delete a cgroup, the workload must be dead and
> so apart from a few long-lived objects, there should mostly be cached
> objects charged to it, which should be easily released on memory
> pressure. Sorry if somebody's asked this question before - I must have
> missed that.

It's an interesting idea. The problem is that the dying cgroup can be
an almost fully functional cgroup for a long time: it can have associated
sockets, pagecache, kernel objects, etc. It's a part of cgroup tree,
all constraints and limits are still applied, it might have some background
activity.

Thanks!
