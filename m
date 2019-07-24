Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF1BC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 07:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B1B2190F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 07:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="qqtH1upj";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="fG//cHZu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfGXHnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 03:43:52 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:31446 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725776AbfGXHnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 03:43:52 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x6O7gR72017385;
        Wed, 24 Jul 2019 00:42:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=e8wllviU9zMlgfRppGKysLrOEbGJ3CXkR1emWDIdBEQ=;
 b=qqtH1upjZA1ZLYf1+SolHROmp1McvPaNAsGHqkrbdamg97oWsxlO6IKn1rq+9QDNiIjR
 qLJiGcCsf/Vj7meyQ8ydR+N3lTKmfqNqA5trpOrVboe9+O0Jiy83IWfrjv7CwIi/8ry/
 CbsCsTb7KtiKisoGXxy2JGB3FE+0YZwgfCg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2tx613jrkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 24 Jul 2019 00:42:58 -0700
Received: from ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 24 Jul 2019 00:42:51 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 24 Jul 2019 00:42:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYRMdQZ3nV5OOtvHYdOafQ8kgtNFh9OmIziaoH9QINVnxJgnnducEWXUvS3dp8FX9NbGoZeWSVptApRT3NmrUVHI5nI24gzgDVmhOcGPrXcRN9btEApuZH5XK0GUWbnXpd77GmrrHWTnQLl/HBoYSdcjC1Xi265OwiVqDfeK05dvAZXW90/Sn0+z6j31SI0AgrbUnEAZUBypldBaZSWQ06d+Vq2mK+VHVWrjAiE54tc7XiqMlDKGba+XvQ07cF07W7GB+EL/Qwh5wychw9GP/tZm2f41dv1WWeQsw82wnAwtjPhAMSnCyoASBjr/KnoFKEghJnxS5iyowGn9g2MsZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8wllviU9zMlgfRppGKysLrOEbGJ3CXkR1emWDIdBEQ=;
 b=F4YcRpbIvSlepN8JSzVM1F9x7TgzuNxiaWPMyrNr+4Kr85bloCH7X4SaLvY7WFKohO6+sTB0xUQQ/UdULY+DutIDFS4HeDNpbXvUHpEAqQ1SiHGbVzAyKikzvIlFhL6mwtwVqdOuxv+pyXNyJHR5NLpkd5Mvgs7uplyOHkGnBA94PgeQcfnDRXRal1QAMNP0DpGFfiKS2PXmOkh0HI4OF2dTWj0qhF63xxvnZU2j7Kd+4F8sJa6dIDgu4jDZGmD2bFgrbl9mG6MQDRJuEx57qE0r6PAXo9E5mmDDFmBtl6irM6etuI2NidvxQJwByoBTfK4LnBNtCDGOMZdAyewdnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=fb.com;dmarc=pass action=none header.from=fb.com;dkim=pass
 header.d=fb.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8wllviU9zMlgfRppGKysLrOEbGJ3CXkR1emWDIdBEQ=;
 b=fG//cHZu03FAS9Hsi5NTHQ1/QmymGFyB9f4VXNJjxGa1uXmuOBRbJEWv6KkX/xbG6BHTzXW7Xb17N87nOwqMSpFRHempq+g7+dEF2+Nu94nYDwcficEPNg38B0bPhuahhHU2vrar0mhUX+ZRVZpqZJhNGOzNSH80WRWFbywALzE=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1552.namprd15.prod.outlook.com (10.173.229.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Wed, 24 Jul 2019 07:42:50 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::4066:b41c:4397:27b7]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::4066:b41c:4397:27b7%7]) with mapi id 15.20.2094.013; Wed, 24 Jul 2019
 07:42:50 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Stephane Eranian <eranian@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [RFC 00/79] perf tools: Initial libperf separation
Thread-Topic: [RFC 00/79] perf tools: Initial libperf separation
Thread-Index: AQHVP7b8omKid2yF70mY04HbAJ4cv6bZZ1qA
Date:   Wed, 24 Jul 2019 07:42:50 +0000
Message-ID: <327EF79F-4573-4387-8DA5-24FFD9EDBBB1@fb.com>
References: <20190721112506.12306-1-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::1:87bf]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e2dc6c7-7038-4b20-c693-08d7100a874a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1552;
x-ms-traffictypediagnostic: MWHPR15MB1552:
x-microsoft-antispam-prvs: <MWHPR15MB15521FDF286F1C7D0723A076B3C60@MWHPR15MB1552.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0108A997B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(366004)(396003)(39860400002)(376002)(189003)(199004)(99286004)(54906003)(6512007)(7416002)(6486002)(86362001)(14454004)(2906002)(81156014)(6436002)(33656002)(6116002)(6246003)(81166006)(50226002)(68736007)(4326008)(36756003)(8936002)(53936002)(71200400001)(71190400001)(5660300002)(14444005)(229853002)(256004)(2616005)(76176011)(316002)(66446008)(66556008)(66946007)(76116006)(46003)(25786009)(57306001)(11346002)(305945005)(102836004)(478600001)(7736002)(66476007)(6916009)(53546011)(64756008)(8676002)(6506007)(186003)(476003)(486006)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1552;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +YecAUg1jZ0x2zcoYkRuc4pvmZNPAsZoBGr1cJhdrUgkJvqsgj3gjMfygs1z6TcbkpzAocVm/rXbjaGgVbNvTy6c/kaWKoWSd5ICdkUZaPEidcuYX22EArb5lIxnEgWH1SIS6s3l7m4uzFGYGuQajhnhot5+ZFxEgtUJIuEACOPl9ayTzqIaf6up2E94jgFhfK4+8Z/zqQRUpMDH8C1lQRJxm7Q6IULNEGvQyw0JufcFCWCoykk9vYfnXgYxbLrhXdZoA6el8hDh6n07leQpJ8riSXgJqy4o7wFWTbJTSL34Qd+0oAn+oWyBHHd7bjWSV/XjbDbIbQPEhFpw/+48HuyGfSScIoH1IdJ3poHZw4sa8vUit/8g5idStqryM9QvfVarWhP2+loDIT3KVuYNbmbkyzpWa7ZF6azNYLYhONs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BA6E51CA3E3D304CB9DF5BBADCC0A106@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2dc6c7-7038-4b20-c693-08d7100a874a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2019 07:42:50.0415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1552
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-24_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=977 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907240086
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

> On Jul 21, 2019, at 4:23 AM, Jiri Olsa <jolsa@kernel.org> wrote:
>=20
> hi,
> we have long term goal to separate some of the perf functionality
> into library. This patchset is initial effort on separating some
> of the interface.
>=20
> Currently only the basic counting interface is exported, it allows
> to:
>  - create cpu/threads maps
>  - create evlist/evsel objects
>  - add evsel objects into evlist
>  - open/close evlist/evsel objects
>  - enable/disable events
>  - read evsel counts

Based on my understanding, evsel and evlist are abstractions in
perf utilities. I think most other tools that use perf UAPIs are=20
not built based on these abstractions. I looked at a few internal
tools. Most of them just uses sys_perf_event_open() and struct=20
perf_event_attr. I am not sure whether these tools would adopt
libperf, as libperf changes their existing concepts/abstractions.

>=20
> The initial effort was to have total separation of the objects
> from perf code, but it showed not to be a good way. The amount
> of changed code was too big with high chance for regressions,
> mainly because of the code embedding one of the above objects
> statically.
>=20
> We took the other approach of sharing the objects/struct details
> within the perf and libperf code. This way we can keep perf
> functionality without any major changes and the libperf users
> are still separated from the object/struct details. We can move
> to total libperf's objects separation gradually in future.

I found some duplicated logic between libperf and perf, for=20
example, perf_evlist__open() and evlist__open(). Do we plan to=20
merge them in the future?=20

Thanks,
Song
