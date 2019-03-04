Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F66C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB9C20835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="c8VKBm7P";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="HlB/OWKB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfCDTls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:41:48 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53296 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726056AbfCDTls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:41:48 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x24JYoO3018692;
        Mon, 4 Mar 2019 11:41:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=zoNi8Cegt6xMXj8TaX7U7GuncRF6NPrnrW60sFegSU4=;
 b=c8VKBm7Pl6+rcqDadbw+aiNW9yGiHJ+uHD/VDYLrvWrVLjw1jq+rmeX3G63G7bWrlphI
 as7za36XjXC09gfj2Nk1UV5R2v3ZbWS0E62V/W9J0Ygjv6A25Xl0yVaEhsvGZ+MLnIVP
 /hiy8LYrFotetlgkVNS/bnUjxAQoLONlMTA= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r17uq0p50-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 04 Mar 2019 11:41:16 -0800
Received: from frc-mbx01.TheFacebook.com (2620:10d:c0a1:f82::25) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 4 Mar 2019 11:41:13 -0800
Received: from frc-hub04.TheFacebook.com (2620:10d:c021:18::174) by
 frc-mbx01.TheFacebook.com (2620:10d:c0a1:f82::25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 4 Mar 2019 11:41:12 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 4 Mar 2019 11:41:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoNi8Cegt6xMXj8TaX7U7GuncRF6NPrnrW60sFegSU4=;
 b=HlB/OWKB2l88k2VjWjRD23Ir2yTfMCZY5cL3nADyynEwQyXhI/B/zTK+jzykgVN7Ys2VEJWBzj6CI11PtSGCn/Gr0LHMQBYgQYGlc6h8bdk73/NAR2LyVZQCwHpHuh0XpO6LzPc34rXYcIcNPJIsIbZ1Veo1ehevIpabeKDxvB4=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1616.namprd15.prod.outlook.com (10.175.135.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.18; Mon, 4 Mar 2019 19:41:10 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065%6]) with mapi id 15.20.1665.020; Mon, 4 Mar 2019
 19:41:10 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Networking <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v5 perf,bpf 07/15] perf, bpf: save bpf_prog_info
 information as headers to perf.data
Thread-Topic: [PATCH v5 perf,bpf 07/15] perf, bpf: save bpf_prog_info
 information as headers to perf.data
Thread-Index: AQHUzyOP1AVZWxR1lEa6YX4LDOvnT6X7hNaAgABhUYA=
Date:   Mon, 4 Mar 2019 19:41:10 +0000
Message-ID: <8EE733B5-439C-4203-AD39-5DCA22E6ACC1@fb.com>
References: <20190228050643.958685-1-songliubraving@fb.com>
 <20190228050643.958685-8-songliubraving@fb.com>
 <20190304135251.GG19809@krava>
In-Reply-To: <20190304135251.GG19809@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::3:1d00]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e4e0faf-2cf0-48bf-b0b1-08d6a0d95a51
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1616;
x-ms-traffictypediagnostic: MWHPR15MB1616:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1616;20:kA7ugWwEOHGilSsJbTtK10xL9iEnsXLfktAhgDdqRm4PU0xM3jTsow9YuUZD7FJy9QjXKi5JSaMblFYiRHKI3q8JqoL7eHZKl/cq/T/7Wt9DFS8bu4L+VhNbG4jSfuHEzrQPfgaA6OZEA/fh7ehIq3+HIt064mdoWIKtjnVG+GY=
x-microsoft-antispam-prvs: <MWHPR15MB1616A43938DFAD8072333E9BB3710@MWHPR15MB1616.namprd15.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39860400002)(136003)(189003)(199004)(478600001)(316002)(186003)(14454004)(53936002)(6512007)(6436002)(6486002)(229853002)(6246003)(57306001)(8676002)(81156014)(81166006)(33656002)(25786009)(6116002)(4326008)(86362001)(36756003)(99286004)(53546011)(6506007)(102836004)(82746002)(76176011)(305945005)(8936002)(46003)(50226002)(7736002)(2616005)(106356001)(97736004)(476003)(105586002)(446003)(11346002)(14444005)(256004)(486006)(83716004)(54906003)(71190400001)(68736007)(2906002)(6916009)(5660300002)(71200400001)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1616;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +kjdSViMHVA0ocXYVGeZfrR1WMKt+Ex2v9i+c4DVvnvWqp8nZITjJRvR+REi+jKHVu/xcOlP8F+9Wkfn4a/cy39ndNSpYVh3gHh4hP/ZIb4qKCbZBnODLJvButA5il0UIXDsp4SqVMQmFjNBVQFObW+CyyxJiGUCly1qg9a8tqWFMQ8FrKlRaj9JBS4SAW91qb2CCGkIp8ATr06410ZEUlMvdKU6mPxBwXTFeoZtMWMid2XgifjKRIDYDhnufuci31xbg5pmHnEuQHaZN+YCokdqubEwMa0AjkNfxpSknmBtTE7TM8EyAbLlSDfaVuBIK2SmgMUvWgHVQToOg0MtLhqIIJD04r8eTFWLFwnOUSnuoYnbQOD4l30oA72b8j0AhFpscP68n7GC1fbHVYxUGiodRse7gw3Z47QgjjPPLgA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9C05C229DC03444A829184F5D287FD71@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4e0faf-2cf0-48bf-b0b1-08d6a0d95a51
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 19:41:10.1132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1616
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-04_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 4, 2019, at 5:52 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Wed, Feb 27, 2019 at 09:06:35PM -0800, Song Liu wrote:
>> This patch enables perf-record to save bpf_prog_info information as
>> headers to perf.data. A new header type HEADER_BPF_PROG_INFO is
>> introduced for this data.
>>=20
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> ---
>> tools/perf/util/header.c | 143 ++++++++++++++++++++++++++++++++++++++-
>> tools/perf/util/header.h |   1 +
>> 2 files changed, 143 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
>> index 4b88de5e9192..16f5bedb0b7d 100644
>> --- a/tools/perf/util/header.c
>> +++ b/tools/perf/util/header.c
>> @@ -18,6 +18,7 @@
>> #include <sys/utsname.h>
>> #include <linux/time64.h>
>> #include <dirent.h>
>> +#include <bpf/libbpf.h>
>>=20
>> #include "evlist.h"
>> #include "evsel.h"
>> @@ -39,6 +40,7 @@
>> #include "tool.h"
>> #include "time-utils.h"
>> #include "units.h"
>> +#include "bpf-event.h"
>>=20
>> #include "sane_ctype.h"
>>=20
>> @@ -1074,6 +1076,51 @@ static int write_clockid(struct feat_fd *ff,
>> 			sizeof(ff->ph->env.clockid_res_ns));
>> }
>>=20
>> +static int write_bpf_prog_info(struct feat_fd *ff,
>> +			       struct perf_evlist *evlist __maybe_unused)
>> +{
>> +	struct perf_env *env =3D &ff->ph->env;
>> +	struct rb_root *root;
>> +	struct rb_node *next;
>> +	u32 count =3D 0;
>> +	int ret;
>> +
>> +	down_read(&env->bpf_progs.lock);
>> +
>> +	root =3D &env->bpf_progs.infos;
>> +	next =3D rb_first(root);
>> +	while (next) {
>> +		++count;
>> +		next =3D rb_next(next);
>> +	}
>> +
>> +	ret =3D do_write(ff, &count, sizeof(count));
>> +
>> +	if (ret < 0)
>> +		goto out;
>> +
>> +	next =3D rb_first(root);
>> +	while (next) {
>> +		struct bpf_prog_info_node *node;
>> +		size_t len;
>> +
>> +		node =3D rb_entry(next, struct bpf_prog_info_node, rb_node);
>> +		next =3D rb_next(&node->rb_node);
>> +		len =3D sizeof(struct bpf_prog_info_linear) +
>> +			node->info_linear->data_len;
>> +
>> +		/* before writing to file, translate address to offset */
>> +		bpf_program__bpil_addr_to_offs(node->info_linear);
>> +		ret =3D do_write(ff, node->info_linear, len);
>> +		bpf_program__bpil_offs_to_addr(node->info_linear);
>=20
> what's the reason to call this before the error check?

This will translate the all the pointers to the right address=20
(instead of offsets). We only need the offsets when writing to=20
files. With this approach, the data is not changed whether the
function succeeds or not. It is probably not necessary right=20
now. But I think this may save us some debugging efforts in=20
the future.=20

Thanks,
Song

>=20
> thanks,
> jirka
>=20
>> +		if (ret < 0)
>> +			goto out;
>> +	}
>> +out:
>> +	up_read(&env->bpf_progs.lock);
>> +	return ret;
>> +}
>=20
> SNIP

