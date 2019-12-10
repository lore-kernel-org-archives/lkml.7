Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9387C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F6520828
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Nkz1AUX3";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="WUg8zSGm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfLJSFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 13:05:33 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53594 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727611AbfLJSFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:05:32 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBAHvV4V005108;
        Tue, 10 Dec 2019 10:05:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=RS4SopCQ9K3oetGmqP/HWkwFKeW3+Okvmbwutm2eSyI=;
 b=Nkz1AUX3ueE9j5bFDOWY0gQyFY90Bs/a/9HaZAF5y0AX+wzNbVI6MeDUHabKfQzBJHUe
 K7eZFFND0+9XOQPTg4C1Rh67ea3HkxQdut+x02j8llY9MFCcZC1lkGydteqn0lscRmlZ
 aBMw9PRzRHUtSGssiTGj3lNN2+BrWcIbtlQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wteq4gkb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 10 Dec 2019 10:05:23 -0800
Received: from ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Dec 2019 10:05:22 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 10 Dec 2019 10:05:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PV/l3sLHtbXSNZQw2AkpWnekgRzVpoykLqzcDUrxlTwfaTNmW3oZuIUjb+ZN9B9Y2ba/nIOlbvHiRfGlvF0h9Wakabj4zBPSvDX39BLEKR3QqgNLIe1M1rJWBHsRUpl8Uu2Grn8N4S1Udjjt9U7e8oIF0EAuui/TmWegbTTpWJyXhiI7xCTnEvLwIO1ZKVgWVxzBcREGPP4GlPJlf6HyDA995p6MpM8kyfI8ubodG7Fmb+NHwp9T2+ER3DzzkYnGK5zDeqgsE3kX7C9EkSqlBq+X0qDI04BLlh6zJQ7jJyC/doiZoYEVSM1KWSklu79cwdA6HfXgcjWyhl7/lGVc1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RS4SopCQ9K3oetGmqP/HWkwFKeW3+Okvmbwutm2eSyI=;
 b=USIQn0rnU+En+H1LVWaIRvAJjZrJWgQwWBjT9jM+yPkUCuF2BXS70lFf7x+kTPnsVe1J0wzKJiuhyk3hzi6XpVAyJcP92rcIm7SNBAnfWlt0YkF0i3eS1NGt8TD03DfdkGYYjOqfP+pdhVuX2U2r535O2HXSBrrf6YjVrosYnXr1QGBqg4/3f0BzS04UkYOVFya3pFiqO0AAAUjDr59JcAu4EY35e8Icx2zV01yw/lRg87hNVcjsIp/NlNhtHXXRHpr17jI6DOmg16NjfzC3YJL2qkGyrixyCUn/EcQvGFSafSkZJVJBhlAEsqf2WqjZdcrXfgeXS1BBVB9EREGmqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RS4SopCQ9K3oetGmqP/HWkwFKeW3+Okvmbwutm2eSyI=;
 b=WUg8zSGmcc2wHXd4A9Ywgs8wT9obgCXqnJzuFsd5h9gtqrQVw/ykSQSyaPiJIKR6iDoU7AzbyXinWP9kyBZ6NroMlW+HtgKPkT+UatxPLtrzxhU8zAfJy4gJM70hp8SnMorECLdAzzSqnW4Hgik6tIBd6Ncn+2PpZ3VVWebhD6c=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB2503.namprd15.prod.outlook.com (52.135.196.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.18; Tue, 10 Dec 2019 18:05:20 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::8cc8:bdb1:a9c7:7f60]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::8cc8:bdb1:a9c7:7f60%3]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 18:05:20 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Bharata B Rao <bharata@linux.ibm.com>
CC:     "mhocko@kernel.org" <mhocko@kernel.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "longman@redhat.com" <longman@redhat.com>
Subject: Re: [PATCH 00/16] The new slab memory controller
Thread-Topic: [PATCH 00/16] The new slab memory controller
Thread-Index: AQHVrnGR5S0BeZVm/Uu7NV5uFsOBDKexspaAgABmrQCAAM5tAIAAxC0A
Date:   Tue, 10 Dec 2019 18:05:20 +0000
Message-ID: <20191210180516.GA23940@localhost.localdomain>
References: <20190905214553.1643060-1-guro@fb.com>
 <20191209091746.GA16989@in.ibm.com> <20191209115649.GA17552@in.ibm.com>
 <20191209180418.GA15797@localhost.localdomain>
 <20191210062308.GC17552@in.ibm.com>
In-Reply-To: <20191210062308.GC17552@in.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR14CA0041.namprd14.prod.outlook.com
 (2603:10b6:300:12b::27) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::af3f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee3e54f1-7859-48a5-bf8a-08d77d9b84f4
x-ms-traffictypediagnostic: BYAPR15MB2503:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB2503B19479A965D2A2880B10BE5B0@BYAPR15MB2503.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02475B2A01
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(346002)(39860400002)(396003)(199004)(189003)(66476007)(66556008)(86362001)(64756008)(1076003)(66946007)(33656002)(478600001)(66446008)(52116002)(316002)(2906002)(6486002)(6916009)(71200400001)(54906003)(81156014)(9686003)(81166006)(6506007)(5660300002)(4326008)(186003)(8936002)(8676002)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2503;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KKuG6hbdc4ef03X2LrwOzjGhL7aZ4O1R9Axu1NGXn9vgt3SEyfMZEwMVJno8zmxpKm/moSJUY9KYDO8TDi4m57iZmXXfxJlqwlFRG6K5sRoZGmFLFka90jBjyOcZ1oYFYKiBdrw3hYIeH1iPOH1U9LKTDFvEsLJHlStMX/NrXXGYAwY0vxy+5z9Rj1BXgg3SuUD+PsJ0931eznKpLQ9zuvzp6m+DeOHJemhtgyaZ6oQkqFVjKs8u8yM8PLl/+KfT7Cci711Qr+Y49PJractg4YIqti4HHsT0GNvJfzg51k0+87B7nXDWs4YwkNe0N0s9QO5shveAw5GrwdTmCovOj4uaiGTrzC1WQL67qca5NrACLqmKWhP9WvZOQXKI8GSDZjHeWrPbXEnPTmD3h0QUbS/u+G1bPoRQS+ZDacv8VbO8TYNV0bcPmg06W6a+3JX4
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A3AAF8326F825A4DAEB041AAC17808A8@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ee3e54f1-7859-48a5-bf8a-08d77d9b84f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 18:05:20.2438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GSxFMgkv0WtAASuu+9YvqlbGZYsixpqBbJM3w2Boi3rryTFUamd/C43gyK9F38+F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2503
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-10_05:2019-12-10,2019-12-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 adultscore=0 mlxscore=0 suspectscore=0
 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912100152
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 11:53:08AM +0530, Bharata B Rao wrote:
> On Mon, Dec 09, 2019 at 06:04:22PM +0000, Roman Gushchin wrote:
> > On Mon, Dec 09, 2019 at 05:26:49PM +0530, Bharata B Rao wrote:
> > > On Mon, Dec 09, 2019 at 02:47:52PM +0530, Bharata B Rao wrote:
> > Hello, Bharata!
> >=20
> > Thank you very much for the report and the patch, it's a good catch,
> > and the code looks good to me. I'll include the fix into the next
> > version of the patchset (I can't keep it as a separate fix due to massi=
ve
> > renamings/rewrites).
>=20
> Sure, but please note that I did post only the core change without
> the associated header includes etc, where I took some short cuts.

Sure, I'll adopt the code to the next version.

>=20
> >=20
> > >=20
> > > But that still doesn't explain why we don't hit this problem on x86.
> >=20
> > On x86 (and arm64) we're using vmap-based stacks, so the underlying mem=
ory is
> > allocated directly by the page allocator, bypassing the slab allocator.
> > It depends on CONFIG_VMAP_STACK.
>=20
> I turned off CONFIG_VMAP_STACK on x86, but still don't hit any
> problems.

If you'll look at kernel/fork.c (~ :184), there are two ORed conditions
to bypass the slab allocator:
1) THREAD_SIZE >=3D PAGE_SIZE
2) CONFIG_VMAP_STACK

I guess the first one is what saves x86 in your case, while on ppc you migh=
t
have 64k pages (hard to say without looking at your config).

>=20
> $ grep VMAP .config
> CONFIG_HAVE_ARCH_HUGE_VMAP=3Dy
> CONFIG_HAVE_ARCH_VMAP_STACK=3Dy
> # CONFIG_VMAP_STACK is not set
>=20
> May be something else prevents this particular crash on x86?

I'm pretty sure it will crash, have stack been allocated using
the slab allocator. I bet everybody are using vmap-based stacks.

>=20
> >=20
> > Btw, thank you for looking into the patchset and trying it on powerpc.
> > Would you mind to share some results?
>=20
> Sure, I will get back with more results, but initial numbers when running
> a small alpine docker image look promising.
>=20
> With slab patches
> # docker stats --no-stream
> CONTAINER ID        NAME                CPU %               MEM USAGE / L=
IMIT   MEM %               NET I/O             BLOCK I/O           PIDS
> 24bc99d94d91        sleek               0.00%               1MiB / 25MiB =
       4.00%               1.81kB / 0B         0B / 0B             0
>=20
> Without slab patches
> # docker stats --no-stream
> CONTAINER ID        NAME                CPU %               MEM USAGE / L=
IMIT   MEM %               NET I/O             BLOCK I/O           PIDS
> 52382f8aaa13        sleek               0.00%               8.688MiB / 25=
MiB    34.75%              1.53kB / 0B         0B / 0B             0
>=20
> So that's an improvement of MEM USAGE from 8.688MiB to 1MiB. Note that th=
is
> docker container isn't doing anything useful and hence the numbers
> aren't representative of any workload.

Cool, that's great!

Small containers is where the relative win is the biggest. Of course, it wi=
ll
decrease with the size of containers, but it's expected.

If you'll get any additional numbers, please, share them. It's really
interesting, especially if you have larger-than-4k pages.

Thank you!

Roman
