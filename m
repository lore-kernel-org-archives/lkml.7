Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AF7C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 00:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CFE2085A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 00:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Pd7l+hcv";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="kZ3gpSiL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731080AbfCAAD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 19:03:26 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55044 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727873AbfCAAD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 19:03:26 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2100uVe024756;
        Thu, 28 Feb 2019 16:03:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=MCWn9st21+H4Wm1qn+nfXI52WnHcROTMb4DEd5uE1Ow=;
 b=Pd7l+hcvu2pm0F9fBCNVMkhl1hxam/Cs9QBsW8cKvJ3mZSWaVxwLEEsg3EnyiAR6hKHk
 3vNEGlZ8lJbiyREU66gVfKGCTBjOjkMxbIat6PQutflwzaioYbJiXaljfUYOezuSlyRL
 gu0lCpjRIC4shPIFzX8XzZFDYS6vPlzrqZA= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qxqw2gd66-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 28 Feb 2019 16:03:20 -0800
Received: from frc-mbx07.TheFacebook.com (2620:10d:c0a1:f82::31) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 28 Feb 2019 16:03:19 -0800
Received: from frc-hub01.TheFacebook.com (2620:10d:c021:18::171) by
 frc-mbx07.TheFacebook.com (2620:10d:c0a1:f82::31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 28 Feb 2019 16:03:19 -0800
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 28 Feb 2019 16:03:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCWn9st21+H4Wm1qn+nfXI52WnHcROTMb4DEd5uE1Ow=;
 b=kZ3gpSiLDm9x0L8/nEJpVIbWp9hyiXQDFOaEzLLX7ADEcn9+NSDlHA42+rd5PtizayxlFrVV62okNalc+oJ5kd+uV/jxorIs4aV05XHk4hESgKqpDiIW5BhRCa3wSgPGzumPZef8qdstcVjgCUzIgtupMqWH/2AD70KBed/b6QY=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2584.namprd15.prod.outlook.com (20.179.155.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Fri, 1 Mar 2019 00:03:06 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ecc7:1a8c:289f:df92]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ecc7:1a8c:289f:df92%3]) with mapi id 15.20.1665.015; Fri, 1 Mar 2019
 00:03:06 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Chris Down <chris@chrisdown.name>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Dennis Zhou <dennis@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH] mm, memcg: Make scan aggression always exclude protection
Thread-Topic: [PATCH] mm, memcg: Make scan aggression always exclude
 protection
Thread-Index: AQHUz6zyEvTIEZLQgk63CbTpyClKSKX15O2A
Date:   Fri, 1 Mar 2019 00:03:06 +0000
Message-ID: <20190301000300.GA16802@tower.DHCP.thefacebook.com>
References: <20190228213050.GA28211@chrisdown.name>
In-Reply-To: <20190228213050.GA28211@chrisdown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR11CA0075.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::16) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:4bc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a37ad00-d6bd-4685-d02e-08d69dd947c5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2584;
x-ms-traffictypediagnostic: BYAPR15MB2584:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2584;20:IFnFIIf9f5wxDWg0OsCRLkWF68pzxwDpe3F1r+rgwX82wAZqyZEr27VXPEt27bMA/j7GrTa2f8m+HHoaLb9+c+j/T0nZO/Z4O/lLWUgzs14fMmueJbvXCB0eN2GO5s/TzuvvzI10WhMm2YSB8AHti2gkDmSdczEODmvyjcvUQ7c=
x-microsoft-antispam-prvs: <BYAPR15MB2584EC94B7D72E584DA5B28BBE760@BYAPR15MB2584.namprd15.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(396003)(366004)(376002)(136003)(189003)(199004)(4326008)(2906002)(86362001)(229853002)(25786009)(6116002)(33656002)(6436002)(71190400001)(71200400001)(6916009)(6246003)(6512007)(9686003)(8936002)(53936002)(386003)(99286004)(97736004)(52116002)(14454004)(81156014)(7736002)(102836004)(6506007)(446003)(81166006)(11346002)(1076003)(76176011)(486006)(8676002)(105586002)(54906003)(186003)(46003)(6486002)(5660300002)(256004)(316002)(106356001)(68736007)(305945005)(476003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2584;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: irCdxR1ppChLlsoV1Mu+PgBjGMEklxkE5727cz8fZJRSSebd9HywFySieTi4N9PDrpyhamSARGsGc7613hmdDoPvMN8fuv6MrfMjW/zvaSgxIn1tnmBYcTN7XkvkFvs3W+p8xwW8KwdFNlUPypopBhhMcb71ylJwA3l8HsMQBaNE4Bg0B41uN/lryIRqEpK8fMg5BnP6zala9hn0xnzxnQtJn80s+6ZxuPNzUBwj28K7kOpiZfdOq7I4uv/d0ipHUEvi4YYONWOTQ3uvhGaHUCbpGllKkDZvWJzWmuQHQNIeEiYao2GPp8fUwSs2LsqS41KZ6H2zAapcQXkY4w414K+lNyLX0JSvPQ4HgL4W1Gekz0u9sMa6YDe6dtTZbW9LMGSaI+EgUwEfA9n0iBv7aVJiIWAKC4pWW4MWCkfqpkA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E321688B1AD6AA47BB869EFB072F8E3F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a37ad00-d6bd-4685-d02e-08d69dd947c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 00:03:06.0476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2584
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_15:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 09:30:50PM +0000, Chris Down wrote:
> This patch is an incremental improvement on the existing
> memory.{low,min} relative reclaim work to base its scan pressure
> calculations on how much protection is available compared to the current
> usage, rather than how much the current usage is over some protection
> threshold.
>=20
> Previously the way that memory.low protection works is that if you are
> 50% over a certain baseline, you get 50% of your normal scan pressure.
> This is certainly better than the previous cliff-edge behaviour, but it
> can be improved even further by always considering memory under the
> currently enforced protection threshold to be out of bounds. This means
> that we can set relatively low memory.low thresholds for variable or
> bursty workloads while still getting a reasonable level of protection,
> whereas with the previous version we may still trivially hit the 100%
> clamp. The previous 100% clamp is also somewhat arbitrary, whereas this
> one is more concretely based on the currently enforced protection
> threshold, which is likely easier to reason about.
>=20
> There is also a subtle issue with the way that proportional reclaim
> worked previously -- it promotes having no memory.low, since it makes
> pressure higher during low reclaim. This happens because we base our
> scan pressure modulation on how far memory.current is between memory.min
> and memory.low, but if memory.low is unset, we only use the overage
> method. In most cromulent configurations, this then means that we end up
> with *more* pressure than with no memory.low at all when we're in low
> reclaim, which is not really very usable or expected.
>=20
> With this patch, memory.low and memory.min affect reclaim pressure in a
> more understandable and composable way. For example, from a user
> standpoint, "protected" memory now remains untouchable from a reclaim
> aggression standpoint, and users can also have more confidence that
> bursty workloads will still receive some amount of guaranteed
> protection.

Looks good to me: the overall logic is fine, and codewise it's so much
cleaner than the previous version.

Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks, Chris!
