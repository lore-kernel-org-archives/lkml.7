Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6E4C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 16:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA0402053B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 16:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="jI0ug3YU";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="lOQpewFm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404273AbfISQWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 12:22:23 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34306 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404259AbfISQWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 12:22:22 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id x8JGIx6c014679;
        Thu, 19 Sep 2019 09:22:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=V9QetieczT/8W2WdLmwrvBJJPniW2MfUA0Ke1pxaI+g=;
 b=jI0ug3YUL2QURlYj6HJ9vanUlwXVn38azeS0RmuJ2BLa580ZsJAVnsFeYU4UU5VbBRwO
 f1hSsyQDfB3CUhSO5SwC9FEJZZjHxR+Ek5n17b5i8DIi/2GVt2a7m9pd4KShqFHP0H6r
 zwx2Yavex9k8H0BpZUpmE6hQsNPNXFjv9u4= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2v3vdpkufn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 19 Sep 2019 09:22:13 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 19 Sep 2019 09:22:11 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 19 Sep 2019 09:22:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1of8/xg0lqWK2As/99i2ejuE5+7MKGXLY0Hr13FAJ6dYKfNzXRiaideSVUJ8os5znyDC9aZ6ioUJCc+tRimBILiapu1MLMz35h60G+vpErt4RG7iJNNgX7xTZ4F673b+0SUEENJHbRqCSiYRtAG58NqDZinjLgZ6Ma+2dNXtfGutzs88P4XPH1LxsX5s5c/LQmkP7r5usdwZaKNx2NIf+fpKqLKtBpxdmSYM9dMyStxpvUfWrx/H4K+yQbSGgxMM+GmZpXXjnmFtEUw599GyqtMOZQThaFpHI2r4QZnG+vhqz1YomsNJIwLP/Xzn/XYhA+9YTDX/KFwkvjNm27PZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9QetieczT/8W2WdLmwrvBJJPniW2MfUA0Ke1pxaI+g=;
 b=nnlVuHfUjvktUKAQN0sU0nutQ51+rE05qp8smMcImeW0oUNM6FvBZnp4c4S+9RCNzMiJS8jfpeTbHnMujXthu+QMhK3ThDT6xCnLzEMXBYyCID+ZFKhc4o1148ouiG+WsepPIIdnwmOPx6ozBgUG/qEGeiJlPK62UV+CkqFYz0sl0G+mlLmbSHVLofn4f2pGnb2ahPqYw1PO1uM7naIu+/N3MbX4dTt/dQdhucSfUg7+40MqyQQllubscIYOdRo2Vv9DPWEkhaYBrxb5E5YFympU5QdYfb+piCyDkXXeUGew/+kUMB/LRfShxAXc+l9kSOnK1DCeD/0u7y5WhW0Obw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9QetieczT/8W2WdLmwrvBJJPniW2MfUA0Ke1pxaI+g=;
 b=lOQpewFmlzlgNLmjljlO2B8TwaaaLZBEz7WHlVEWoNrI4xkBLrDSP8o/wI6wV6nNcA6ifJeI6Dpfu6hZoB1aJjsnyoasY5DCk7on4LU5zUS6RxcqQ2MkzMIj0W+z57919971wPCjVH/C9uXFqY1ZZ1/4ihpppcEg+9NKQCQDxdU=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2785.namprd15.prod.outlook.com (20.179.140.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Thu, 19 Sep 2019 16:22:10 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::8174:3438:91db:ec29]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::8174:3438:91db:ec29%5]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 16:22:09 +0000
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
Thread-Index: AQHVZDNwmo4dH7vFVEWbwj6k0KVokaczFt4AgAAtegA=
Date:   Thu, 19 Sep 2019 16:22:09 +0000
Message-ID: <20190919162204.GA20035@castle.dhcp.thefacebook.com>
References: <20190905214553.1643060-1-guro@fb.com>
 <CABCjUKByipk2e1Hh1_PwC+p2Fig=6RMfd0zBeVQtyn5Y48gYXQ@mail.gmail.com>
In-Reply-To: <CABCjUKByipk2e1Hh1_PwC+p2Fig=6RMfd0zBeVQtyn5Y48gYXQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR20CA0003.namprd20.prod.outlook.com
 (2603:10b6:300:13d::13) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::2154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ae0c3e5-52ac-4181-7783-08d73d1d8529
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN8PR15MB2785;
x-ms-traffictypediagnostic: BN8PR15MB2785:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR15MB27853480DBCB7973719FDBE7BE890@BN8PR15MB2785.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(346002)(396003)(39860400002)(199004)(189003)(229853002)(81156014)(8676002)(81166006)(8936002)(33656002)(25786009)(52116002)(66946007)(66556008)(64756008)(66446008)(66476007)(6512007)(9686003)(6246003)(6486002)(476003)(102836004)(386003)(11346002)(486006)(446003)(305945005)(7736002)(99286004)(2906002)(53546011)(6506007)(76176011)(6436002)(186003)(46003)(478600001)(6916009)(86362001)(14454004)(6116002)(256004)(14444005)(71200400001)(71190400001)(1076003)(316002)(5660300002)(54906003)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2785;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: s3R4daHs6UuPiiA3vXVjRYjOztCej7R1GSbO1CLV2vro+S+k5Q4q0fepYkhxN6NW4dxSNvYve1jBMKs+1SXzmfouBP36+zMzXYA6MENTanefqlgbUDGgT1xnSxew2EXK/eV/SCKnYAXRydMXshwo1bl6s+cC2RN9QlZgximHFS/y8DArJ6lg+il+ZNSRLT/YxTT9qYwBjSmnPl21fT+hjjewUqI4x4+vkLqAT1auhOIQ5oGY60P01UYSzncNx9KsBpsjBIAnNEdjw0TJ4rH+OuARcdhEkjG4kLUPsBcs2DI1Y43Snw6X8j04s+ttiQjfziihQSywi/MjEr/pXCWl21ylQ4oLuh8anTAXcC5xzDgxrGyF81miD0EdBnZNsZo5toIDFeJ1S40xo2M6lwDd7Vd6Bq6fui0SPbZNcSQkFCk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5537AB22E3CBB44585ED0BA0E1094AF5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae0c3e5-52ac-4181-7783-08d73d1d8529
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 16:22:09.8095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jggdSNW8TS5PxzhTLeMNvNZ6+M7mSeqDWB2mS66PQ9J/5eThco2WuMb83eu8RsU6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2785
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-19_05:2019-09-19,2019-09-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 mlxlogscore=611 adultscore=0 phishscore=0
 spamscore=0 clxscore=1011 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909190146
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 10:39:18PM +0900, Suleiman Souhlal wrote:
> On Fri, Sep 6, 2019 at 6:57 AM Roman Gushchin <guro@fb.com> wrote:
> > The patchset has been tested on a number of different workloads in our
> > production. In all cases, it saved hefty amounts of memory:
> > 1) web frontend, 650-700 Mb, ~42% of slab memory
> > 2) database cache, 750-800 Mb, ~35% of slab memory
> > 3) dns server, 700 Mb, ~36% of slab memory
>=20
> Do these workloads cycle through a lot of different memcgs?

Not really, those are just plain services managed by systemd.
They aren't restarted too often, maybe several times per day at most.

Also, there is nothing fb-specific. You can take any new modern
distributive (I've tried Fedora 30), boot it up and look at the
amount of slab memory. Numbers are roughly the same.

>=20
> For workloads that don't, wouldn't this approach potentially use more
> memory? For example, a workload where everything is in one or two
> memcgs, and those memcgs last forever.
>

Yes, it's true, if you have a very small and fixed number of memory cgroups=
,
in theory the new approach can take ~10% more memory.

I don't think it's such a big problem though: it seems that the majority
of cgroup users have a lot of them, and they are dynamically created and
destroyed by systemd/kubernetes/whatever else.

And if somebody has a very special setup with only 1-2 cgroups, arguably
kernel memory accounting isn't such a big thing for them, so it can be simp=
le
disabled. Am I wrong and do you have a real-life example?

Thanks!

Roman
