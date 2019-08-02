Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C4EC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02BBB2054F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="qsRNUSIb";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="IdLMvyf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403803AbfHBQ4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 12:56:23 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34886 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728856AbfHBQ4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 12:56:23 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x72Go0jP018090;
        Fri, 2 Aug 2019 09:55:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=iUhUuzw3YIfxtI+SNqzxf6KCLahYA51v0Iob5/+AsdQ=;
 b=qsRNUSIbQ9lZAQLdyGXw80x0aeqKVP9L2TIl64vqqd6thzW6zPxO9Y/awxoxYNmN8Mmh
 Pa+2es02tdyPklWvdMbrP+6U6vRLaHrgeF8W/FBwGkK51b0BrYR7CAw+JYDznbluU/XI
 bKGeTlBQm2WwShL647sHmjPvw5q90u2PTak= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2u4hgdskx6-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 02 Aug 2019 09:55:29 -0700
Received: from prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 2 Aug 2019 09:55:27 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 2 Aug 2019 09:55:27 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 2 Aug 2019 09:55:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y226r5CWR5rzsXo4t0Jv/9ObW+sC1Zqj82HuV5uXj854iSvEi2ueBl7gJXqQyhzhoJ/+1udPEHWul6VlVdo5D2f3fbW2Sv46rbTwS87KftrAK9b9MnMaSaD4GkMWlmUep839gAgfmzfKY8/+jmcT6Dqw/DgIspBYtXnxBfppaKwisC+uPspV67UkOOWe3OxJcqas2XWhI3borNl/EImnlz+3UzRCxikdsJP3tCvMGzE3haIyFAynoi3eCNI2Uu1rjT2BbJaOeSUprNYYtBFU94bGoiQjlYJ9dLxwnU6JpW01A2mXA7CJi/6TrbfpXhSgbKDpdq3wbYXsMo2d6L7qDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUhUuzw3YIfxtI+SNqzxf6KCLahYA51v0Iob5/+AsdQ=;
 b=Z/ByxJQKr0LO0nSv3kY/HTWK9QzHG/rHknwG2Lzp7bCix8ZsFJQmfvQT0mXl7tSH6IuKQvw8AixrCa6CO8Oz5c9TL2/p1Abu0B1nKfeAuZgAp6Wco743AXsXuHt6ODOkhUKB5eqaoj66jbCUR+uNcSCLphrRBaZBwEZQalmd8RpeYD8gCN0jFOZvTahupDcNE4rmoDqr54qLy6uafl3mztdV9ZHT8pD1kW/bV+ZN1bXd9uoYyNjhfAofMjh/kI8/hG2MlQLe+QHjPK7iw6MkXsbs1EA0j5pVrAy5CjIxu82lFCChj56wCmiwzwDz8jX4R8yUKsUxMwTzwQbf8mXUng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=fb.com;dmarc=pass action=none header.from=fb.com;dkim=pass
 header.d=fb.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUhUuzw3YIfxtI+SNqzxf6KCLahYA51v0Iob5/+AsdQ=;
 b=IdLMvyf4HO3cLt7Ad46S1HJfffELBOCorhv9ii+4UzhovTq0Rr2nTcpG7giVdAEPC3pIBUnYLYhT1toLtQGp7tsnJsSec7+efZCgOwBoWblBIbscypW0582Bfq4G7HKPxidak9aW31Mm7Koj0aCUm3x9myLW8yTgdHVBjUkj6o8=
Received: from DM6PR15MB2635.namprd15.prod.outlook.com (20.179.161.152) by
 DM6PR15MB2873.namprd15.prod.outlook.com (20.178.230.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.13; Fri, 2 Aug 2019 16:55:25 +0000
Received: from DM6PR15MB2635.namprd15.prod.outlook.com
 ([fe80::fc39:8b78:f4df:a053]) by DM6PR15MB2635.namprd15.prod.outlook.com
 ([fe80::fc39:8b78:f4df:a053%3]) with mapi id 15.20.2136.010; Fri, 2 Aug 2019
 16:55:25 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Hillf Danton <hdanton@sina.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Michal Hocko" <mhocko@suse.com>
Subject: Re: [PATCH] mm: memcontrol: switch to rcu protection in
 drain_all_stock()
Thread-Topic: [PATCH] mm: memcontrol: switch to rcu protection in
 drain_all_stock()
Thread-Index: AQHVSMHRid8xy6v2VESi4846kGYnRKboFKCA
Date:   Fri, 2 Aug 2019 16:55:24 +0000
Message-ID: <20190802165521.GA28431@tower.DHCP.thefacebook.com>
References: <20190801233513.137917-1-guro@fb.com>
In-Reply-To: <20190801233513.137917-1-guro@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:300:16::26) To DM6PR15MB2635.namprd15.prod.outlook.com
 (2603:10b6:5:1a6::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::a1bd]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76f52506-952d-4c0c-bfa5-08d7176a36ad
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM6PR15MB2873;
x-ms-traffictypediagnostic: DM6PR15MB2873:
x-microsoft-antispam-prvs: <DM6PR15MB287325E514D88DD28691E1F7BED90@DM6PR15MB2873.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 011787B9DD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(136003)(39860400002)(199004)(189003)(6506007)(53936002)(86362001)(4326008)(6246003)(8936002)(81166006)(81156014)(76176011)(5660300002)(6916009)(6116002)(25786009)(229853002)(316002)(6486002)(14454004)(99286004)(52116002)(2906002)(256004)(478600001)(14444005)(6436002)(186003)(66446008)(1076003)(8676002)(7736002)(66946007)(66476007)(54906003)(476003)(71200400001)(486006)(102836004)(305945005)(6512007)(9686003)(64756008)(71190400001)(446003)(386003)(11346002)(66556008)(46003)(68736007)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB2873;H:DM6PR15MB2635.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8eGy4UsWnVebsY4S4RfDU5sQcf/kySJuCHu+mgxbOd2ICzE03ExrZgEIdgGgOH3bbVo495Gp9UtjKTpjw31GJDs9ufpvuXqgAPwzbWqEokfLM48m1ErlzFxcWIKKAcTvZzu3A7f5nPtvaw1Nmw4DA4PJpMkaWpb0PtepKIJ8xxapzWbkRnk0bd4Z8krmDSj++s37bMjOW/sZPe6lYrGUvsICmzH7d/MseVJPv60p6DMr3JnllPm5ILnouu3fmG78+Vq6FT+VI+NaC0kAm0gzMQTBqWoG1uJRSuns9ge/ldFrAo2LMaVl+S6jXcmW6NDItffJ6GGTBXkVs5jPjyAAg4hPElvSF19xBDT/OrmameJI7ZDrxQjcsfq1CrW3dWtAgPz2YQwsoEiKsN/DjKRsC1PtDmPlzLUyJlYv8E7MjmU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A40747C58454C54BA33B646AF4E0F7FA@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f52506-952d-4c0c-bfa5-08d7176a36ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2019 16:55:25.0841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guro@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2873
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908020174
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 11:33:33AM +0800, Hillf Danton wrote:
>=20
> On Thu, 1 Aug 2019 16:35:13 -0700 Roman Gushchin wrote:
> >=20
> > Commit 72f0184c8a00 ("mm, memcg: remove hotplug locking from try_charge=
")
> > introduced css_tryget()/css_put() calls in drain_all_stock(),
> > which are supposed to protect the target memory cgroup from being
> > released during the mem_cgroup_is_descendant() call.
> >=20
> > However, it's not completely safe. In theory, memcg can go away
> > between reading stock->cached pointer and calling css_tryget().
>=20
> Good catch!
> >=20
> > So, let's read the stock->cached pointer and evaluate the memory
> > cgroup inside a rcu read section, and get rid of
> > css_tryget()/css_put() calls.
>=20
> You need to either adjust the boundry of the rcu-protected section, or
> retain the call pairs, as the memcg cache is dereferenced again in
> drain_stock().

Not really. drain_stock() is always accessing the local percpu stock, and
stock->cached memcg pointer is protected by references of stocked pages.
Pages are stocked and drained only locally, so they can't go away.
So if (stock->nr_pages > 0), the memcg has at least stock->nr_pages referen=
ces.

Also, because stocks on other cpus are drained via scheduled work,
neither rcu_read_lock(), not css_tryget()/css_put() protects it.

That's exactly the reason why I think this code is worth changing: it
looks confusing. It looks like css_tryget()/css_put() protect stock
draining, however it's not true.

Thanks!

> >=20
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Cc: Michal Hocko <mhocko@suse.com>
> > ---
> >  mm/memcontrol.c | 17 +++++++++--------
> >  1 file changed, 9 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 5c7b9facb0eb..d856b64426b7 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -2235,21 +2235,22 @@ static void drain_all_stock(struct mem_cgroup *=
root_memcg)
> >  	for_each_online_cpu(cpu) {
> >  		struct memcg_stock_pcp *stock =3D &per_cpu(memcg_stock, cpu);
> >  		struct mem_cgroup *memcg;
> > +		bool flush =3D false;
> > =20
> > +		rcu_read_lock();
> >  		memcg =3D stock->cached;
> > -		if (!memcg || !stock->nr_pages || !css_tryget(&memcg->css))
> > -			continue;
> > -		if (!mem_cgroup_is_descendant(memcg, root_memcg)) {
> > -			css_put(&memcg->css);
> > -			continue;
> > -		}
> > -		if (!test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags)) {
> > +		if (memcg && stock->nr_pages &&
> > +		    mem_cgroup_is_descendant(memcg, root_memcg))
> > +			flush =3D true;
> > +		rcu_read_unlock();
> > +
> > +		if (flush &&
> > +		    !test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags)) {
> >  			if (cpu =3D=3D curcpu)
> >  				drain_local_stock(&stock->work);
> >  			else
> >  				schedule_work_on(cpu, &stock->work);
> >  		}
> > -		css_put(&memcg->css);
> >  	}
> >  	put_cpu();
> >  	mutex_unlock(&percpu_charge_mutex);
> > --=20
> > 2.21.0
> >=20
>=20
>=20
