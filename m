Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93456CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 01:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D45A2190F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 01:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="cRR1uI5k";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="NQ5o2pf6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfJUBQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 21:16:13 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41314 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726610AbfJUBQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 21:16:12 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9L18uas016976;
        Sun, 20 Oct 2019 18:16:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=StuEbipVvbTBl9NxP1a8XFMxQ3l22MVdYVffOmqKRL0=;
 b=cRR1uI5kFYVK/a1hJgApqC1hpQzt/SaeUhwWY4ohFrlzdaOYmZ5UPjeKUTmYq1uaP467
 e0H574Sxa1x7nAD/nUTquUpzvoNAj7b7zz71V2ywQFB3738JzptLV5eToZN1pIuIcJ8p
 cS0KtYr/3JzcGUTO+HNBxkzOgxTsGxi+raM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vr00mvkcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 20 Oct 2019 18:16:00 -0700
Received: from ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) by
 ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 20 Oct 2019 18:15:59 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 20 Oct 2019 18:15:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWEUnk/slBD3bhGV2l0lz/01fMMl+epzrQDrNSuOELhQc2t5HSscAYqF0o83ocurBhMfXcRylKmmFgeudosbciVttxFAHPT/WoDBMR6iaS4mNE4vdyvRbyCC4SeG/ZPFTxegZOr0KqTkfFdOJY3P7Olep/Ew15WAYB5Z6fLGdF0E03+0QAjMj8KgqDemScDmFdGrlmm3KPxb6U+3v/7YwwcgnmDknTPM7ssXrnFLjku1eM0uTDG1WliyXWlpTsAjZ3e3wO75vMK5yuDkP+BqM6+OxwVEle21XZ2hwRUMtTJcNnpvR9opbn7W21KS0C0g8d+hw2lagpXk0Jt/Lybrlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=StuEbipVvbTBl9NxP1a8XFMxQ3l22MVdYVffOmqKRL0=;
 b=XEHtD4kieMgbTNIHgJVZazj5+Ouy+mruiTVUl5CrZ9hI7ekeNJCaiPT5sWxhugXAY1tiT60ioqC/k1n0fjFkJWeJgNwvfiELyYDAehUC+DVIww5zmoGu4GTww+szBmSKxTjbL0IQJde+qmKyqRbxjwfV/Q4nRIr0CB6seg4Je14DlL+yA/PjpCKxr+O2hqRDjzkZer4U/bGPPlUZC0/Tq21cVjYTBVGtvKSUIdp4UH9/Ufw07hg6I9CpknvAGp7k4XlXJfH7GsYsUZvQzLbg9/nghe2s8XU/Hei6k766L4+17FmxexBtxdo5v0RDjLN1wokXM18JSbmHXjGxM1eHtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=StuEbipVvbTBl9NxP1a8XFMxQ3l22MVdYVffOmqKRL0=;
 b=NQ5o2pf69KedKpmww3BKsqKCnhc21xj2H3qfmS+YcRouHGFWFurxIOXNpJunBEj4T+Rz2IlGn/50t3PO6uT6yInDRVz/b/OXuFDAIk6wDGpahSUNVM+S19l72bYCEZSzkpcVCd2kMEdOO0eq+KDmLZf9pc5O1XGLO31LkojnICc=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2723.namprd15.prod.outlook.com (20.179.139.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Mon, 21 Oct 2019 01:15:57 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0%6]) with mapi id 15.20.2347.028; Mon, 21 Oct 2019
 01:15:57 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Christopher Lameter <cl@linux.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 02/16] mm: vmstat: use s32 for vm_node_stat_diff in struct
 per_cpu_nodestat
Thread-Topic: [PATCH 02/16] mm: vmstat: use s32 for vm_node_stat_diff in
 struct per_cpu_nodestat
Thread-Index: AQHVhUsFBO4ANGUwi02i8A/g/NqcHqdkJTAAgAAqYAA=
Date:   Mon, 21 Oct 2019 01:15:57 +0000
Message-ID: <20191021011550.GA8869@castle>
References: <20191018002820.307763-1-guro@fb.com>
 <20191018002820.307763-3-guro@fb.com>
 <alpine.DEB.2.21.1910202243220.593@www.lameter.com>
In-Reply-To: <alpine.DEB.2.21.1910202243220.593@www.lameter.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:300:16::28) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::37d5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d374320b-f743-4343-0eb3-08d755c439dd
x-ms-traffictypediagnostic: BN8PR15MB2723:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR15MB27237241C62165F6B25949F2BE690@BN8PR15MB2723.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0197AFBD92
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39860400002)(376002)(366004)(136003)(346002)(396003)(189003)(199004)(7736002)(76176011)(305945005)(6486002)(66446008)(64756008)(66556008)(66476007)(102836004)(66946007)(14444005)(256004)(25786009)(52116002)(1076003)(316002)(229853002)(54906003)(99286004)(6436002)(2906002)(46003)(4326008)(11346002)(5660300002)(386003)(86362001)(446003)(14454004)(6116002)(6506007)(486006)(8676002)(81156014)(81166006)(6246003)(478600001)(33656002)(9686003)(6512007)(71190400001)(71200400001)(33716001)(476003)(186003)(8936002)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2723;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BOiFQpDklfOzGzocBOmL7nGd2Nika447r4r+IO42PHmX2nDzwa6xSW/c5F3pH0NTK0E3qz6qzTRwSxaINC5zRuxrkw2e1jbUGxPShLNf89GFE7P9KBVZS3ef5hGfAK/wYqyGymNZ8AUnG2dDyyHcFAu107xoyNZYQbdo76X0iAfF+gZfzdLoYSd7D5r3A/10e1aPe/QJr8zruwZrv0Xd99kdUSvWhEFvFW/aOllf3j6AaVfK96ECeQNzIB+2WBemnb31tqcCLs0ppasSlVwj0RL/BJKlFi/3WT1YkGotxpr/uwH9xhc6rKEOkcR0ktjXqK2sp7jdUsv0URgzl70DDIDG0U2U5gDjGPROISVcxlJ1DULc+12HX0Q274dTpMNDc5s3n3lw0rsusE7IcMxHuOLjqUs1ziggtAphoECgKIo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F16FEE7A78977F48A197AE9F10D809AB@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d374320b-f743-4343-0eb3-08d755c439dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2019 01:15:57.0932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AJIB15GKPJ7ZfNua0GM/g+uiOCJn3hBy4+o5xe17i1tQyTVTw6c+46q8rrfc1bMG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2723
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-20_06:2019-10-18,2019-10-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 impostorscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910210008
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2019 at 10:44:10PM +0000, Christopher Lameter wrote:
> On Thu, 17 Oct 2019, Roman Gushchin wrote:
>=20
> > But if some counters are in bytes (and the next commit in the series
> > will convert slab counters to bytes), it's not gonna work:
> > value in bytes can easily exceed s8 without exceeding the threshold
> > converted to bytes. So to avoid overfilling per-cpu caches and breaking
> > vmstats correctness, let's use s32 instead.
>=20
> This quardruples the cache footprint of the counters and likely has some
> influence on performance.

But otherwise slab allocation counters will be flushed too often, which
will be likely noticeable. I can do custom s32 buffers only for these count=
ers,
but to me it seems like an unnecessary complication, unless we'll find
a clear regression.

Sp far I haven't noticed any regression on the set of workloads where I did=
 test
the patchset, but if you know any benchmark or realistic test which can aff=
ected
by this check, I'll be happy to try.

Also, less-than-word-sized operations can be slower on some platforms.
