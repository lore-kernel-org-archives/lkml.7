Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAA5C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 21:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5E5208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 21:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="QzDVen3w";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="RbYR5Yu6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403924AbfISVkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 17:40:21 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52408 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390087AbfISVkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 17:40:21 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id x8JLcxbS027934;
        Thu, 19 Sep 2019 14:40:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=V2l37AP+YdQliM3h2hv3PUDzo3TYYF8ZGg4AEKk4tRU=;
 b=QzDVen3war7pjax/x5AaOq64Uxvic9/dPg2D67m/m1g6XNQpR4e/CCtAkzEPK57bTiZ0
 qdv6zaS9NQFWP+oi4aJtbv+A8mWrBQhDSzhCc2+K0dbP6ZDWo6bcUrL/seIWHVX7DlDy
 nPyH38bcpJjsiKhV/APX/v9hBQZqMsLrSA0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2v3vdpn8n7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 19 Sep 2019 14:40:11 -0700
Received: from ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 19 Sep 2019 14:40:10 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 19 Sep 2019 14:40:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfoNqz1DYxDeLg9e4z1l9ZgB0L0NzeTjsBnLw/MW5F5stF54lwR+wLH0bJRoxb1hG3eQExCU97Ci+26Snlk9xIoJvjWacqiwjXClPcdoU1MadBqaXyiBDasKcau+6VtEf8wdXTvSHXYVT92kplIJ5v/MRLyuPv+ErRE9DtNbcl8irX6qEO1OfPLHhYt+vixP3obOyvcCcRKCr7DlAvcMFcBAjcYNq/y/Li09daCD710FM2UbPYKCsQqftLUM7atU0Cj9/hfoK+feruCXLo4gGCSmDzUwo6NNn6BZEwSUkUQid363+D4wokZLkkN6W0w742990lrOT7/KBYHLLhbHLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2l37AP+YdQliM3h2hv3PUDzo3TYYF8ZGg4AEKk4tRU=;
 b=FfP7256uSr7zBjeqMr6Wsb2dg9rTvYdpBQD8fjNO8jXFoiH1e0NNg/5yoJtr7vO4JHBf8vl/Woi+4wZ5k10Pfoq+2Ms5j4B4XXCac+xdbTAXJQKPWrmWgZl4HvTFs6J4bz7s/8xiJck5Wr1A2uQRZfy6mVRdp1hzSsMBGMjLJxj3C+BcmmInHenpaNTdL6oe0BOQa+vVSpffPYjOz/XuHXdrbhKH0MGWt82K5aWOd0kXdxo2D+FH740qvYep/CT2KY5Sn1hpHC38G8i8OFsaC0GjC/UnbroOLfT2ksa8m4ofp3sETdYaX41YNHMrtf5Id+qWvWXfIR198Z0cprwBQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2l37AP+YdQliM3h2hv3PUDzo3TYYF8ZGg4AEKk4tRU=;
 b=RbYR5Yu6j/+0ebTbEz8VrkHSWR7dE7HZaskk21yZlYDOtDCboLzrHBr8tXZpf7RUIz8s8P6hx7T77qKC1NbnQUhhY7ajVGLh0IsLjAuKgQBF63Lb/PaiWDTlz7NPZH/prik0VIHeM3aNMFIydK1oq3YFwsl06L6SWzcNzrCFmMg=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB3490.namprd15.prod.outlook.com (20.179.73.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.18; Thu, 19 Sep 2019 21:40:09 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::8174:3438:91db:ec29]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::8174:3438:91db:ec29%5]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 21:40:09 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Suleiman Souhlal <suleiman@google.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Shakeel Butt" <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "Waiman Long" <longman@redhat.com>
Subject: Re: [PATCH RFC 00/14] The new slab memory controller
Thread-Topic: [PATCH RFC 00/14] The new slab memory controller
Thread-Index: AQHVZDNwmo4dH7vFVEWbwj6k0KVokaczFt4AgAAtegCAAFB/gIAACFoA
Date:   Thu, 19 Sep 2019 21:40:09 +0000
Message-ID: <20190919214004.GA24631@castle.dhcp.thefacebook.com>
References: <20190905214553.1643060-1-guro@fb.com>
 <CABCjUKByipk2e1Hh1_PwC+p2Fig=6RMfd0zBeVQtyn5Y48gYXQ@mail.gmail.com>
 <20190919162204.GA20035@castle.dhcp.thefacebook.com>
 <CABCjUKB2BFF9s0RsYj4reUDbPrSkwxDo96Rmqk3tOc0_vo3Xag@mail.gmail.com>
In-Reply-To: <CABCjUKB2BFF9s0RsYj4reUDbPrSkwxDo96Rmqk3tOc0_vo3Xag@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:300:95::16) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::3366]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67ad6ed5-8ce9-4aba-c099-08d73d49f1e1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN8PR15MB3490;
x-ms-traffictypediagnostic: BN8PR15MB3490:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR15MB349052E5AE47D3DDD9DF4439BE890@BN8PR15MB3490.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39860400002)(366004)(396003)(189003)(199004)(1076003)(6436002)(478600001)(446003)(8936002)(11346002)(486006)(476003)(6486002)(53546011)(6506007)(386003)(186003)(6116002)(71200400001)(71190400001)(99286004)(46003)(14454004)(102836004)(33656002)(316002)(6512007)(9686003)(54906003)(4326008)(25786009)(2906002)(52116002)(6916009)(256004)(305945005)(66946007)(7736002)(5660300002)(6246003)(8676002)(76176011)(86362001)(66476007)(64756008)(14444005)(81156014)(66556008)(81166006)(66446008)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB3490;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0CU0TMAaIE7liuNGH73NWUNwvVIsN3rCDMXyc1lU2Db0iNKAh0PMLB3Joh88U567XiLfhWuq9geKkteB9no6C4yBvJGE5e/foned7ap0Zi9vAylBfEYSC8K76GztvPkAjOkyPgaY5TPW7+LE/PPaqoroMoOs1XBUI7JDfvf0sT4+7qX4kmtXZHTm6nFH4bh6s6gBAoiZu6KvM8DiIHytlYsXZ9mVkBpEqV/awZPzBVxjhcYfdnHjuHEwi+oeoOZgS1X39SL4ni7O0gz87YUjJPH4zU1T2RZRKho7ewVU/hjzAkvYNFkkQLoH8rFMyBA0c1DB0ONlv4izL72LrmGC5jzlTY2QcHUtAJx11HpT54DdpwEa3Dfe3rH3CwWyFFnGgaKErVAHc9rDUfV/BvUdX7ZEZQC6K6pfHtcnOxE68zE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4485D7013088EB4A973396070E4C9D19@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ad6ed5-8ce9-4aba-c099-08d73d49f1e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 21:40:09.7404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MHcWgWD+mZIA3fgUpJNopB6MiTTwVLfYuTNzjQBswXHRkAIviMVftZxFfdkyOqbw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3490
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-19_05:2019-09-19,2019-09-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 mlxlogscore=806 adultscore=0 phishscore=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909190179
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 06:10:11AM +0900, Suleiman Souhlal wrote:
> On Fri, Sep 20, 2019 at 1:22 AM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Thu, Sep 19, 2019 at 10:39:18PM +0900, Suleiman Souhlal wrote:
> > > On Fri, Sep 6, 2019 at 6:57 AM Roman Gushchin <guro@fb.com> wrote:
> > > > The patchset has been tested on a number of different workloads in =
our
> > > > production. In all cases, it saved hefty amounts of memory:
> > > > 1) web frontend, 650-700 Mb, ~42% of slab memory
> > > > 2) database cache, 750-800 Mb, ~35% of slab memory
> > > > 3) dns server, 700 Mb, ~36% of slab memory
> > >
> > > Do these workloads cycle through a lot of different memcgs?
> >
> > Not really, those are just plain services managed by systemd.
> > They aren't restarted too often, maybe several times per day at most.
> >
> > Also, there is nothing fb-specific. You can take any new modern
> > distributive (I've tried Fedora 30), boot it up and look at the
> > amount of slab memory. Numbers are roughly the same.
>=20
> Ah, ok.
> These numbers are kind of surprising to me.
> Do you know if the savings are similar if you use CONFIG_SLAB instead
> of CONFIG_SLUB?

I did only a brief testing of the SLAB version: savings were there, numbers=
 were
slightly less impressive, but still in a double digit number of percents.

>=20
> > > For workloads that don't, wouldn't this approach potentially use more
> > > memory? For example, a workload where everything is in one or two
> > > memcgs, and those memcgs last forever.
> > >
> >
> > Yes, it's true, if you have a very small and fixed number of memory cgr=
oups,
> > in theory the new approach can take ~10% more memory.
> >
> > I don't think it's such a big problem though: it seems that the majorit=
y
> > of cgroup users have a lot of them, and they are dynamically created an=
d
> > destroyed by systemd/kubernetes/whatever else.
> >
> > And if somebody has a very special setup with only 1-2 cgroups, arguabl=
y
> > kernel memory accounting isn't such a big thing for them, so it can be =
simple
> > disabled. Am I wrong and do you have a real-life example?
>=20
> No, I don't have any specific examples.
>=20
> -- Suleiman
