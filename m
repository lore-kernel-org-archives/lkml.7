Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B1DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 15:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A22D214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 15:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="G/8xALZZ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="jgLqAnC2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388295AbfJVPse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 11:48:34 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49824 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387922AbfJVPsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 11:48:33 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id x9MFlOA2019653;
        Tue, 22 Oct 2019 08:48:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=W3FRUSvJdPg4RmBNgLE23pCAPgl78LTovXWLu0uIamM=;
 b=G/8xALZZBxco+MvIaj9X0zdK9dBIexGK03Ac2LiE4wT74zdd1oB9mREFp/ckYsy422IS
 c4fgiUtA79+LCWyapbmdk5bAGi9WYPUX7vsjZkdiEB0rLwI8YxZ+uROiJUm1K1jZrZSF
 RiwzxzJ5JT6XbKZhhxfujd2n8Hu9mA2Fpr0= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2vsw36t98y-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 22 Oct 2019 08:48:22 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 22 Oct 2019 08:48:20 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 22 Oct 2019 08:48:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Svawu/e22X607xRfS7nCIMIMBXcZpktZzUwCDbnrJTYLLuJtyKVsI05OYdc+dKIgGXbTMNjtkhzGYd+Ygo4AcLxg+I/kRlviDwfcpyt++yEfT7r8ApJcIO3jYwepsCSP9c26UOWHR/p/baQP2xNE3OuyAC3faYcqI/0phJn6MnUmSrQHQOSw6ODAsc9ENlJPXNt6drqLrJ6R0es+Tr5mjXAm1RQrJcYUC++Gp+st+mU9zM3LkPV6UUFHkzEM8pOLP22pPruFec4Kt5ISWuVEcPUxVllQu0vmWQ8ZRqSQ47SrtABSm0CWM6EIHfO0jAUANTOYIhH3WYcFm7Z8nwq8Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3FRUSvJdPg4RmBNgLE23pCAPgl78LTovXWLu0uIamM=;
 b=guHlE5fpgrE9V0aJ7FyaXYOIfhnIdjWpLaS6TkiFHz7ToVRe3NYl3wGTmXtQa4Lt2j8+E3tvLycXuDelmxH/J9HFUjqc2sRKdjRhGek/yKYKl8iZGGIuotYhuqTzMqygrBV1k9qtWvSAVZCN2e7C4RCzdKE88hs0M8my8wHVkhv1WJIKG+3SkUdRjsANqSAN8XgApAyg+1r3GHyEQF8pKvmWHQs3QGqYeQkIxqO7p9dyhxy8f9bk+traTInUlZFwJAN9nPp2LK/2cAJVkkxYc4pYeeMdep2yg75IaFPRbY/pPpKCg89WhKuvYOohN3tOHQ9LXPaZhyPgaDjZCKireQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3FRUSvJdPg4RmBNgLE23pCAPgl78LTovXWLu0uIamM=;
 b=jgLqAnC2kGhD06S0l5KsTkBJbfRmu90chtSYquqh2iARmRW2mjScKKc2mi9w7m8+3/h4KVQi0R2QHQs18iNOTrd3vivhX4h+CkB10xbwB72/3f0C09dgcD5HLqK+euBHRazrtQoMKokPD9cljQC2MmNXfgGBpHzaPRecxSDBzSg=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2868.namprd15.prod.outlook.com (20.178.220.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Tue, 22 Oct 2019 15:48:18 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0%6]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 15:48:17 +0000
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
Thread-Index: AQHVhUsDHbAZ56EwPkekUglLv37/GKdmrNAAgAABpgCAACcrAA==
Date:   Tue, 22 Oct 2019 15:48:17 +0000
Message-ID: <20191022154812.GA21381@tower.DHCP.thefacebook.com>
References: <20191018002820.307763-1-guro@fb.com>
 <20191022132206.GN9379@dhcp22.suse.cz> <20191022132800.GO9379@dhcp22.suse.cz>
In-Reply-To: <20191022132800.GO9379@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR17CA0063.namprd17.prod.outlook.com
 (2603:10b6:300:93::25) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::7e8a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38416c61-2724-4efd-06fb-08d757074162
x-ms-traffictypediagnostic: BN8PR15MB2868:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR15MB28681E7CB436D5B601C157FABE680@BN8PR15MB2868.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(136003)(39860400002)(396003)(376002)(199004)(189003)(8936002)(64756008)(33656002)(6916009)(6512007)(86362001)(6116002)(71190400001)(66446008)(8676002)(305945005)(1076003)(4326008)(9686003)(316002)(81156014)(81166006)(7736002)(71200400001)(66556008)(66476007)(2906002)(256004)(66946007)(6506007)(6486002)(102836004)(76176011)(386003)(14454004)(476003)(5660300002)(25786009)(186003)(6436002)(54906003)(6246003)(229853002)(99286004)(11346002)(52116002)(486006)(46003)(446003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2868;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lvxSq54KAwwtz62eCDtmASEcZvPol5PB1D9INR2L06/rCQ5t5o0CBEXxqPehRMhJ5PW/pVmA34quDs4lyEdsMkLsHOJkYIFRStMcVO2t5DJ388ZpdYbTDRMBS9D97PWCQju7bq2kupE41a4jR8TRxo4bPYhFd5glqRK+t5wxkpXi6+J6x+DarFybnR9ly8z9rj9mnP+bt+vVhPG/8laoggzb+cpicuBGfJbW3ESMkgzut7iwhvGSFYzsoJWayb5C40x3Eu1F5LUYO1qMFJ1E3IKS/f7Ropm+MO3KgwYdS3VWGkvISpqQRMxRC4nZk3Bk7pSO+QiL8rFIHJcFPuaSRFgtVj5IUo9LYnvNOiBv/p1iGqB3EBcMDTSNkkglvxpK4AlSwrLGoHItyhQ6dPanJ/QviJd09GXbfEEKdrUSHjpB/Crv5z7wspVl/RQSjrvd
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A81A170FE2A3884ABB1536F4B3F0C25A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 38416c61-2724-4efd-06fb-08d757074162
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 15:48:17.2483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l2W+u/oc5XT8fAG+xMvEvL6hmMdvShZULOX4Oaca1wN9VzHmDfSfpKBSnlADGTLV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2868
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-22_03:2019-10-22,2019-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0
 mlxscore=0 adultscore=0 mlxlogscore=587 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910220136
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 03:28:00PM +0200, Michal Hocko wrote:
> On Tue 22-10-19 15:22:06, Michal Hocko wrote:
> > On Thu 17-10-19 17:28:04, Roman Gushchin wrote:
> > [...]
> > > Using a drgn* script I've got an estimation of slab utilization on
> > > a number of machines running different production workloads. In most
> > > cases it was between 45% and 65%, and the best number I've seen was
> > > around 85%. Turning kmem accounting off brings it to high 90s. Also
> > > it brings back 30-50% of slab memory. It means that the real price
> > > of the existing slab memory controller is way bigger than a pointer
> > > per page.
> >=20
> > How much of the memory are we talking about here?
>=20
> Just to be more specific. Your cover mentions several hundreds of MBs
> but there is no scale to the overal charged memory. How much of that is
> the actual kmem accounted memory.

As I wrote, on average it saves 30-45% of slab memory.
The smallest number I've seen was about 15%, the largest over 60%.

The amount of slab memory isn't a very stable metrics in general: it heavil=
y
depends on workload pattern, memory pressure, uptime etc.
In absolute numbers I've seen savings from ~60 Mb for an empty vm to
more than 2 Gb for some production workloads.

Btw, please note that after a recent change from Vlastimil
6a486c0ad4dc ("mm, sl[ou]b: improve memory accounting")
slab counters are including large allocations which are passed
directly to the page allocator. It will makes memory savings
smaller in percents, but of course not in absolute numbers.

>=20
> > Also is there any pattern for specific caches that tend to utilize
> > much worse than others?

Caches which usually have many objects (e.g. inodes) initially
have a better utilization, but as some of them are getting reclaimed
the utilization drops. And if the cgroup is already dead, no one can
reuse these mostly slab empty pages, so it's pretty wasteful.

So I don't think the problem is specific to any cache, it's pretty general.
