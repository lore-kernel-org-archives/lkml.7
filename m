Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2524CC10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5162184D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="FguTB1IH";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="kgntrn3k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbfC2WIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 18:08:15 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58550 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730117AbfC2WIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 18:08:15 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2TM7ZCO029544;
        Fri, 29 Mar 2019 15:08:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=/fvefkGu7if2TEZANnKcz48z0AGuDMhmvnrtdvpl4uk=;
 b=FguTB1IHbc1gfJ2Ra6ix9M2Dupq2J2OZf/vbj/Mr3FIM9lhHFtewcmLippRsBZXOXzLa
 MckuvX6NagsXCvbtVioUGsHFS2wRZHxUIfbbqLBM2CS3slQDXdlRicfGHGhiQJALwQRU
 2cCOBobP6qtTphWAvfrPTCsnX300qStCY5s= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rhpvwsagj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 29 Mar 2019 15:08:04 -0700
Received: from frc-mbx05.TheFacebook.com (2620:10d:c0a1:f82::29) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 29 Mar 2019 15:08:03 -0700
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-mbx05.TheFacebook.com (2620:10d:c0a1:f82::29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 29 Mar 2019 15:08:03 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 29 Mar 2019 15:08:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fvefkGu7if2TEZANnKcz48z0AGuDMhmvnrtdvpl4uk=;
 b=kgntrn3kUvp75bYPdssLePeHyv7/i2yGpiZfuKN0Igae64pLDeLl4FDC+oLE/Z3faTdU88OU2CvjO/MowAFaZrKkh8cwaSTMkBChIn959GSmF9/kRM5tZmvq/7tIrI8vEh8FJAFOWmFdlNa3yMyauVRtTmnxFfa8T1W1xxDo2mk=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2293.namprd15.prod.outlook.com (52.135.197.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.19; Fri, 29 Mar 2019 22:07:48 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded%3]) with mapi id 15.20.1750.017; Fri, 29 Mar 2019
 22:07:48 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 0/3] vmalloc enhancements
Thread-Topic: [PATCH 0/3] vmalloc enhancements
Thread-Index: AQHUzUkDsg3nidi7+kWpLay4D4KtlqYjXRqA
Date:   Fri, 29 Mar 2019 22:07:47 +0000
Message-ID: <20190329220742.GA5804@tower.DHCP.thefacebook.com>
References: <20190225203037.1317-1-guro@fb.com>
In-Reply-To: <20190225203037.1317-1-guro@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::31) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:8655]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f667cef1-1b49-444b-690a-08d6b492fa51
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2293;
x-ms-traffictypediagnostic: BYAPR15MB2293:
x-microsoft-antispam-prvs: <BYAPR15MB2293C933FD119A9FB9B38211BE5A0@BYAPR15MB2293.namprd15.prod.outlook.com>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(376002)(366004)(396003)(199004)(189003)(2906002)(14454004)(5660300002)(478600001)(105586002)(106356001)(316002)(6916009)(54906003)(2351001)(25786009)(46003)(305945005)(446003)(7736002)(5640700003)(1076003)(9686003)(4326008)(6512007)(71200400001)(86362001)(71190400001)(53936002)(256004)(6246003)(11346002)(476003)(229853002)(76176011)(102836004)(33656002)(6486002)(6506007)(386003)(97736004)(486006)(6436002)(186003)(8936002)(52116002)(6116002)(68736007)(99286004)(81156014)(81166006)(8676002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2293;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: W5FU7W/JiPUrK4lejOvnbwWB+y3pfS69ZTobTf6Vjyg7VAv1hpSR1f8Z7JRTlIClxNmDj8x8KpSW4d9dgEO1Fmik9CkBpj3QG5M180AODfbzhNAGJTkq22lXtoh23tZ9PK3wyB8YaozpAnnJbeDxfwreCkMcLqxGYyJCSTzgi849CDBxZGE6Vl8NE+KjgwBKS9G1EwDFYHm4dXhr/KjJz9tun7Gvy3PNOQcdGgXIEzA7pE3n0alEqZDEaPmzampMmX9bijQ+GAY5erJnGriacPi3YXU7R6zt76zex8+rTSZL8TizX5+jBMJBeQsXeM3YVGpt46H0Y6XC19aB27irrPo1dOgJt0iziwItM9EgcGRI4ui76mMngU2EsML4Kw0Tx2BMEC5FWH+2PIF5EYM83uQE4nATKeEg4VzgdpQ07fo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9E26A1FD2CD4644A901615B7C770360C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f667cef1-1b49-444b-690a-08d6b492fa51
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 22:07:47.9879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2293
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-29_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 12:30:34PM -0800, Roman Gushchin wrote:
> The patchset contains few changes to the vmalloc code, which are
> leading to some performance gains and code simplification.
>=20
> Also, it exports a number of pages, used by vmalloc(),
> in /proc/meminfo.
>=20
> Patch (1) removes some redundancy on __vunmap().
> Patch (2) separates memory allocation and data initialization
>   in alloc_vmap_area()
> Patch (3) adds vmalloc counter to /proc/meminfo.
>=20
> v3->v2:
>   - switched back to atomic after more accurate perf measurements:
>   no visible perf difference
>   - added perf stacktraces in commmit message of (1)
>=20
> v2->v1:
>   - rebased on top of current mm tree
>   - switch from atomic to percpu vmalloc page counter
>=20
> RFC->v1:
>   - removed bogus empty lines (suggested by Matthew Wilcox)
>   - made nr_vmalloc_pages static (suggested by Matthew Wilcox)
>   - dropped patch 3 from RFC patchset, will post later with
>   some other changes
>   - dropped RFC
>=20
> Roman Gushchin (3):
>   mm: refactor __vunmap() to avoid duplicated call to find_vm_area()
>   mm: separate memory allocation and actual work in alloc_vmap_area()
>   mm: show number of vmalloc pages in /proc/meminfo
>=20
>  fs/proc/meminfo.c       |   2 +-
>  include/linux/vmalloc.h |   2 +
>  mm/vmalloc.c            | 107 ++++++++++++++++++++++++++--------------
>  3 files changed, 73 insertions(+), 38 deletions(-)
>=20
> --=20
> 2.20.1
>=20

Ping. Any comments/suggestions/objections?

Thanks!
