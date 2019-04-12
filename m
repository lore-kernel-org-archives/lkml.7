Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C43C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 22:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA05D20818
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 22:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ohPxwfuh";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="H2YMOi9C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfDLWEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 18:04:16 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38642 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726912AbfDLWEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 18:04:16 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3CLwbTu026404;
        Fri, 12 Apr 2019 15:04:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=cqL+pJ71EKbv/SUv97RjkmOLlG58/qsHRdVt9C9X53w=;
 b=ohPxwfuhNzun4WRdiBIgrledoQNF8uFSklb+JHWUPDLIfWrrrHeQyy51eOKQw0rzfNPq
 Uv3UAFvisDKjQ0Ucltollc2ipfSk+weZC0j7UDPlmkn+JF5isO862jQRXjKvadyIYi0e
 CoPVZ0HLnDhGFnc/37UDKnfY5Wenl6e8JZs= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rtw0ws91h-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 12 Apr 2019 15:04:05 -0700
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 12 Apr 2019 15:04:04 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 12 Apr 2019 15:04:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqL+pJ71EKbv/SUv97RjkmOLlG58/qsHRdVt9C9X53w=;
 b=H2YMOi9C5K3HKrHcYUVEsTNQncAmKIKe9qv6C2wcbnmVa0Qm4GHBQbE73WZEyNGEUTuW8skgVx4GLsYEsm9Jx2zDv+wkxET7Wkpr9nmeHRpwm31fsKixfqHYoyG57DrSykHOknNdeXFY3OPh94PQ8e7WlNqk0rT9USySdFQsiRg=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2679.namprd15.prod.outlook.com (20.179.156.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.18; Fri, 12 Apr 2019 22:04:02 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d1a1:d74:852:a21e]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d1a1:d74:852:a21e%5]) with mapi id 15.20.1792.016; Fri, 12 Apr 2019
 22:04:02 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 0/4] mm: memcontrol: memory.stat cost & correctness
Thread-Topic: [PATCH 0/4] mm: memcontrol: memory.stat cost & correctness
Thread-Index: AQHU8UKSRitH7aU5pEyAQQGRGu7VMKY5FLwA
Date:   Fri, 12 Apr 2019 22:04:02 +0000
Message-ID: <20190412220357.GA18999@tower.DHCP.thefacebook.com>
References: <20190412151507.2769-1-hannes@cmpxchg.org>
In-Reply-To: <20190412151507.2769-1-hannes@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2201CA0050.namprd22.prod.outlook.com
 (2603:10b6:301:16::24) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:2586]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2834e93-225c-4f32-794d-08d6bf92c5b3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2679;
x-ms-traffictypediagnostic: BYAPR15MB2679:
x-microsoft-antispam-prvs: <BYAPR15MB2679F7B13A86BB2E8B6A1E2EBE280@BYAPR15MB2679.namprd15.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(396003)(39860400002)(366004)(199004)(189003)(106356001)(6246003)(105586002)(71190400001)(8936002)(229853002)(71200400001)(6506007)(386003)(7736002)(6486002)(33656002)(476003)(186003)(86362001)(486006)(446003)(68736007)(2906002)(1076003)(5660300002)(14454004)(11346002)(46003)(102836004)(99286004)(478600001)(81156014)(6916009)(52116002)(76176011)(81166006)(305945005)(8676002)(4326008)(316002)(25786009)(256004)(9686003)(6512007)(54906003)(6436002)(6116002)(53936002)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2679;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Kvoj+NfNBjDXlBETeDzWIqqgsH8KbEFAt2j71KDTMrbXCNjriKjWOGd+oegkTTPjXh8TvZjJDTncvfdXcQZSpnSm8DRB2U5k/skdhSzzOHcFqw0wTZ/tu2hcZtyPPtdx0KxSzTVL5w3ykL0ZBZ5qeBDCQcUrvgsp6giHkoDOqYdeEbGlCeOKrhVtqq0ReMyruq+rxaYUboygr+N6mn6H/1IN95i8Vecb0PiznZTz5ca415RXMAVRVdMr7Gj9aIp8trW4f/xDSTzs5X7CQ8KIbzfMheWl1zLmFmV1QzWcTn7c4xGt68pwQupBz2SdDrhlGYkFZX6oXZw5ibY6z7NnYfkrrXV/7v+ieeojGfQ9boyzwNp0SIvLrI5R/xS4B1acgf4UVtCPzb8kulHNZJZ4azxI8sJPN0GxNaPc+p+8/uk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <25150709FC40BE4791F4051712207847@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d2834e93-225c-4f32-794d-08d6bf92c5b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 22:04:02.5229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2679
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-12_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 11:15:03AM -0400, Johannes Weiner wrote:
> The cgroup memory.stat file holds recursive statistics for the entire
> subtree. The current implementation does this tree walk on-demand
> whenever the file is read. This is giving us problems in production.
>=20
> 1. The cost of aggregating the statistics on-demand is high. A lot of
> system service cgroups are mostly idle and their stats don't change
> between reads, yet we always have to check them. There are also always
> some lazily-dying cgroups sitting around that are pinned by a handful
> of remaining page cache; the same applies to them.
>=20
> In an application that periodically monitors memory.stat in our fleet,
> we have seen the aggregation consume up to 5% CPU time.
>=20
> 2. When cgroups die and disappear from the cgroup tree, so do their
> accumulated vm events. The result is that the event counters at
> higher-level cgroups can go backwards and confuse some of our
> automation, let alone people looking at the graphs over time.
>=20
> To address both issues, this patch series changes the stat
> implementation to spill counts upwards when the counters change.
>=20
> The upward spilling is batched using the existing per-cpu cache. In a
> sparse file stress test with 5 level cgroup nesting, the additional
> cost of the flushing was negligible (a little under 1% of CPU at 100%
> CPU utilization, compared to the 5% of reading memory.stat during
> regular operation).
>=20
>  include/linux/memcontrol.h |  96 +++++++-------
>  mm/memcontrol.c            | 290 +++++++++++++++++++++++++++------------=
----
>  mm/vmscan.c                |   4 +-
>  mm/workingset.c            |   7 +-
>  4 files changed, 234 insertions(+), 163 deletions(-)
>=20
>=20

For the series:
Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks!
