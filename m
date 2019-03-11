Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BD5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C70D206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="WeV1Qb6x";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="XKHFQbEJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfCKSGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:06:36 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35510 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727336AbfCKSGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:06:35 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2BI5a4X004669;
        Mon, 11 Mar 2019 11:06:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=wfbFl0hW6lzsLTjgdmII4G0ioHA+SjEcgQ+y+WFGrQ0=;
 b=WeV1Qb6xVgx9K4Gxbimbn//DK0nRRSuDKhieF794jB3/OrAwmUKr/uXQtymWTfaTzkmC
 IQBurbBVPq8OGj5HZ+p0VcebWm/jV9wfGj/U0z/Fbm4TUl7cyRq/1oHeZFa4yqVtWgzP
 0JaRzLZauFPIIid9qvrQSyz1UhinLxqmptM= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r5scbrrxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 11 Mar 2019 11:06:07 -0700
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 11 Mar 2019 11:05:46 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 11 Mar 2019 11:05:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfbFl0hW6lzsLTjgdmII4G0ioHA+SjEcgQ+y+WFGrQ0=;
 b=XKHFQbEJNmygmWB4bPgsw+OHNiwfcZdEjG7XQCGH/qFBZwf+7kqKpwkJJBCQHOB7reg1Y2OdBWG5BwdUwYPDiOJnwD9g+TCksa6292yi4hHSZoSXVhBWGpCpMAiuahVO56yhX3ewokiOas5XfUCa+H+s1SiS/6l6LP8KbxPhHp4=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1117.namprd15.prod.outlook.com (10.175.2.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.20; Mon, 11 Mar 2019 18:05:44 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065%6]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 18:05:44 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v7 perf,bpf 07/15] perf, bpf: save bpf_prog_info
 information as headers to perf.data
Thread-Topic: [PATCH v7 perf,bpf 07/15] perf, bpf: save bpf_prog_info
 information as headers to perf.data
Thread-Index: AQHU1Q+IdqOtD5rk8UK5f+N4Cx2YQqYGvYAAgAACdoA=
Date:   Mon, 11 Mar 2019 18:05:44 +0000
Message-ID: <62C63F5B-AEE9-4215-949D-7A5B8F409431@fb.com>
References: <20190307175810.249857-1-songliubraving@fb.com>
 <20190307175810.249857-8-songliubraving@fb.com>
 <20190311175654.GC19721@krava>
In-Reply-To: <20190311175654.GC19721@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::2:e2c1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85921791-2a0b-452a-3ea8-08d6a64c2e86
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1117;
x-ms-traffictypediagnostic: MWHPR15MB1117:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1117;20:g3xkvWwDQmXpVcQXySzT9ZXKB/bfqFDiBDPwi7A0Qc0uVd2oAzG+uzc7WwMlunfp9ifPc9NbiNvP/uI9Dze6D5O6A9ek0zDQtwLMcuEzrANiWN+2AB9ikcfoQbeuLeRcb8NVulfohPY7sC1LOfirLysrys0olzY2eWBRQI5pMh8=
x-microsoft-antispam-prvs: <MWHPR15MB1117E2B9401B914247C01CA3B3480@MWHPR15MB1117.namprd15.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(346002)(396003)(376002)(189003)(199004)(6116002)(71190400001)(71200400001)(2616005)(54906003)(83716004)(486006)(36756003)(6512007)(476003)(478600001)(316002)(11346002)(68736007)(76176011)(2906002)(7416002)(46003)(82746002)(25786009)(6916009)(6246003)(86362001)(99286004)(7736002)(81166006)(81156014)(14454004)(8936002)(57306001)(4326008)(97736004)(6506007)(53546011)(14444005)(50226002)(256004)(186003)(33656002)(8676002)(53936002)(229853002)(446003)(5660300002)(102836004)(305945005)(6436002)(106356001)(105586002)(6486002)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1117;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DjqHAaAFnkdmI1nfIMqO8R+YEyacdaIqFZwAPFG2lWJpRMhfyIJg9d7DSPcQxKzj2Jvx+ULMwIyQ1cD2433IZk3SV+6xThXiKMBzU42MQjnJZeY99Gd57CmHMrTObRqyDgdw+d+R0JDNwOJFERXpnAeoFLfQj5XeHld9EslDoDjV/I9+SMtYS3VLGlalHo6BPGIvpSuq/Dl9CqNhJ3KHcJkNMIoe84iIkdnFcd9vcKzkBvjMGW+yK2cP+MgsGXPznkZUhb5/8SJuUpAuR4L2hPdGzN2QMh8rIMhMvWCbtn+wWpbBvy5ftc+MYKfB99eoYkdSjVhkqWN0uGbWicFcFQsmxfQINNwdNXipXze5/0wpZpOVcFVuiFahjWR8JbT5bqaSIt8O7J0SA8kFgBHbJ5gyRzJg/KZ75FE5sGBuxsI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <65175BE7694CA2449C05DD9C9F7A307F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 85921791-2a0b-452a-3ea8-08d6a64c2e86
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 18:05:44.5777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1117
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-11_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 11, 2019, at 10:56 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Thu, Mar 07, 2019 at 09:58:02AM -0800, Song Liu wrote:
>> This patch enables perf-record to save bpf_prog_info information as
>> headers to perf.data. A new header type HEADER_BPF_PROG_INFO is
>> introduced for this data.
>>=20
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> ---
>> tools/perf/util/header.c | 145 ++++++++++++++++++++++++++++++++++++++-
>> tools/perf/util/header.h |   1 +
>> 2 files changed, 145 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
>> index 4b88de5e9192..f0708188211e 100644
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
>> @@ -1074,6 +1076,54 @@ static int write_clockid(struct feat_fd *ff,
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
>=20
> sry I did not se this before, but why you don't keep program count
> in perf_env::bpf_progs::infos_cnt ?
>=20
> jirka

Good idea... I didn't think about this carefully. Will fix in next=20
version.=20

Thanks,
Song

