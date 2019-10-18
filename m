Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F39CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E6DD21835
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="RVgFinZY";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="PS6s7oy3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505340AbfJRRNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 13:13:10 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40792 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388893AbfJRRNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 13:13:10 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9IHCs76011760;
        Fri, 18 Oct 2019 10:13:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Y3rH6h/j2hPEoOagwoPnzPoeUUo5ZUvVyYOORAmzyOo=;
 b=RVgFinZYKpPSOCPoIQcdTxRt9EC/VYh3EUIxhIJ535e/t2/Oa0QAT4a6SkpfYJ07JXE0
 lmnmqKTfCaSaLe8fthw5rXDIVA0uuWU+KLlfO8//O0huxfafBbpQ9TFTKt6FD4rFa7d0
 M7WJxrVetj1iF/tDnOpx37l5s0qWnhNoedk= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vqhgjr0u9-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 18 Oct 2019 10:13:00 -0700
Received: from prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 18 Oct 2019 10:12:47 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 18 Oct 2019 10:12:47 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 18 Oct 2019 10:12:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0R1P1sBDpJMXYOObOjVr4wVizCuw+nNCEL0mJiaBXbzlZo+LRRULFdYLWh/R22j1KI3ZcjB08gepYGuiDtTrSsUQ0M8rHmYP9ZGZFxt9jjrwrAGi7I4OF/Sbh8iv8THCzwPCNTy34HeL+0O1pvAnfgzxRxyJdmjh7puQLD9r2IVVaNolQawLVEc5zS335rpLB5xYFokT5wXjOKb+ErYvqVO98HBJSr8Ui9MtXAdi8uXeYPFPJMGsTXRAxcW61bdg7r1KI1yhem/xVF+pJ3B+57UQAKaAug0ggEsDV/g0KZt1SkuRdpJkN5P5fHaTS8GcTHidiyvq1TqThWvaPsJZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3rH6h/j2hPEoOagwoPnzPoeUUo5ZUvVyYOORAmzyOo=;
 b=b+y1gVkKGd+hfTOpsw5VZSeJX+fL9sx6ZJ6+T7B8FABtRIV1vnYdmd+t/q3AF+c3SiYFGZypeVuiyzRNRNBkaBS4L0sYLN5Pfe5/lYuVGsh+nv2SLXCW1qbVPdzKk9vzFvylUB3EV0FzSvNH6o3bSrJVmRJITpcUvjT0LBjaYigQpdKnuEehA9DnSCZbJpSIRkcvc0ssm49csvrdo/1in2Q8PhiA28C62v0aKXH2C1p9rQyz17gN+XSGvyg0Ya9Le9wQp0Pv9lJKCHtkC9LHsZEVvDjmoyt/4hL35TXhrF0zxHry9PfAGbEQCEj+OfCnUQ6c805iaLAfgLLDyw7BEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3rH6h/j2hPEoOagwoPnzPoeUUo5ZUvVyYOORAmzyOo=;
 b=PS6s7oy3SeNT0+h1vc21Ff/ebhG60hIspB0yMePEj62xwA+YHB5j6MBZjul56tbtsfdl7DPk/KmTIkQoa7rRuzT7Plp/ujjCCE4sphZy1KT2pKZzrFWKZ+/zAY6doG2I/AL7M3/2xVEVSnTNFP0ppyKK0xCOVrqQ+aXpHmO7lJ0=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB3234.namprd15.prod.outlook.com (20.179.75.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Fri, 18 Oct 2019 17:12:45 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0%6]) with mapi id 15.20.2347.023; Fri, 18 Oct 2019
 17:12:45 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Waiman Long <longman@redhat.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH 00/16] The new slab memory controller
Thread-Topic: [PATCH 00/16] The new slab memory controller
Thread-Index: AQHVhUsDHbAZ56EwPkekUglLv37/GKdgoXUAgAACcYA=
Date:   Fri, 18 Oct 2019 17:12:45 +0000
Message-ID: <20191018171239.GB6117@tower.DHCP.thefacebook.com>
References: <20191018002820.307763-1-guro@fb.com>
 <f3eb1843-8f10-1e7e-9cc7-9e0209c837ce@redhat.com>
In-Reply-To: <f3eb1843-8f10-1e7e-9cc7-9e0209c837ce@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR10CA0023.namprd10.prod.outlook.com (2603:10b6:301::33)
 To BN8PR15MB2626.namprd15.prod.outlook.com (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::4581]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98bf28cb-e1b1-447e-6d60-08d753ee6494
x-ms-traffictypediagnostic: BN8PR15MB3234:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR15MB32349FD0A1DE3B4F280891CCBE6C0@BN8PR15MB3234.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39850400004)(366004)(136003)(376002)(199004)(189003)(4326008)(305945005)(7736002)(5660300002)(478600001)(33656002)(52116002)(71200400001)(71190400001)(8936002)(76176011)(81166006)(81156014)(256004)(8676002)(14444005)(46003)(99286004)(6436002)(9686003)(6512007)(6486002)(6116002)(25786009)(229853002)(2906002)(86362001)(14454004)(6916009)(6246003)(486006)(186003)(476003)(54906003)(66946007)(66476007)(66556008)(64756008)(102836004)(66446008)(316002)(446003)(1076003)(386003)(53546011)(11346002)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB3234;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Equxe+hKySJ+hRMsy6XS7VcupBbXe6QWRHB1Si8SdQNEbOv8Q3/811LYi0LIutjm9NGic8csot/a3fG3Yg7mA3n3nw1OsNOpazujPzDzEi0ZbqwpExTScoXIU+PGrP1cG+i9/QV26fZyyw8CsKqlye8BnQO0b7uy6XhWXsZCbiJ4IapsWPBYeOKwhYP6vwxmRl7mo6VqxYdZgEitAdqWAFhBDk1S2RWl/BSr0IAlZZV9eEoCkyjlXng4vI6ffhqlr/IDVr8lNVr0MDr1B4ZvmTFLLB4YtLxB0Nc9lPvF9BLhid4MMF6t4SVvqE7LanQyYdXeRhBUje+N23JPrDlZUbxk2i8lIXyaORjJ2hgKj6SLLsjs9pqC5iV6m6PWd87G/01N1Ns9P5cflqBq6EEfDlqcF5WLJFxvKVzx1368C7w=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <FFE72374D9D78944B4B3FAFD8FBF20B2@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 98bf28cb-e1b1-447e-6d60-08d753ee6494
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 17:12:45.2964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5gQl0doSAhLD0utqVAKpxpV1K+/IiAhNwBZZmLcPQdaJ16zuXxB+WocU8KgDxFNR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3234
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-18_04:2019-10-18,2019-10-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=641 adultscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910180157
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 01:03:54PM -0400, Waiman Long wrote:
> On 10/17/19 8:28 PM, Roman Gushchin wrote:
> > The existing slab memory controller is based on the idea of replicating
> > slab allocator internals for each memory cgroup. This approach promises
> > a low memory overhead (one pointer per page), and isn't adding too much
> > code on hot allocation and release paths. But is has a very serious fla=
w:
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ^it^
> > it leads to a low slab utilization.
> >
> > Using a drgn* script I've got an estimation of slab utilization on
> > a number of machines running different production workloads. In most
> > cases it was between 45% and 65%, and the best number I've seen was
> > around 85%. Turning kmem accounting off brings it to high 90s. Also
> > it brings back 30-50% of slab memory. It means that the real price
> > of the existing slab memory controller is way bigger than a pointer
> > per page.
> >
> > The real reason why the existing design leads to a low slab utilization
> > is simple: slab pages are used exclusively by one memory cgroup.
> > If there are only few allocations of certain size made by a cgroup,
> > or if some active objects (e.g. dentries) are left after the cgroup is
> > deleted, or the cgroup contains a single-threaded application which is
> > barely allocating any kernel objects, but does it every time on a new C=
PU:
> > in all these cases the resulting slab utilization is very low.
> > If kmem accounting is off, the kernel is able to use free space
> > on slab pages for other allocations.
>=20
> In the case of slub memory allocator, it is not just unused space within
> a slab. It is also the use of per-cpu slabs that can hold up a lot of
> memory, especially if the tasks jump around to different cpus. The
> problem is compounded if a lot of memcgs are being used. Memory
> utilization can improve quite significantly if per-cpu slabs are
> disabled. Of course, it comes with a performance cost.

Right, but it's basically the same problem: if slabs can be used exclusivel=
y
by a single memory cgroup, slab utilization is low. Per-cpu slabs are just
making the problem worse by increasing the number of mostly empty slabs
proportionally to the number of CPUs.

With the disabled memory cgroup accounting slab utilization is quite high
even with per-slabs. So the problem isn't in per-cpu slabs by themselves,
they just were not designed to exist in so many copies.

Thanks!
