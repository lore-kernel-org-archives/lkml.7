Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2520C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0B02077B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="bOzudPSc";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="gVO49keQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfCNS3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 14:29:46 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42120 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726531AbfCNS3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 14:29:46 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2EIS0vu001779;
        Thu, 14 Mar 2019 11:29:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=S9nnpaw3aWPCn0WyB88VQYvXZb6hslFStTzz5alM99g=;
 b=bOzudPScJm7NW6gvBmdiXZgmcZU/7717FONmgfd3pA3IroEMpUxpDn/K2e7RKNx0a4SX
 yarpxPzNlV9BhAO+UqIpXvdPoi75yLcQJTuCd+7ygITc6I9ZtfyrVHf3A4kEUCzsqUp0
 bnhZyYWefuwt9f4061PJGRmJ6VO68PlSsaE= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r7h8ba8v5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 14 Mar 2019 11:29:19 -0700
Received: from frc-mbx03.TheFacebook.com (2620:10d:c0a1:f82::27) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 14 Mar 2019 11:29:17 -0700
Received: from frc-hub06.TheFacebook.com (2620:10d:c021:18::176) by
 frc-mbx03.TheFacebook.com (2620:10d:c0a1:f82::27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 14 Mar 2019 11:29:17 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 14 Mar 2019 11:29:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9nnpaw3aWPCn0WyB88VQYvXZb6hslFStTzz5alM99g=;
 b=gVO49keQTZCIPUuReO7qvu86ztsApHaU49/4mj1n9pQVG90VHmkBP/qnfnfsoRHqv610w35kVICndSlJt0lk0iN0tkPINtoOPo4Oq6WXyeG/szrplULbvhLk6mlO0XneMWi3RbJ7+ZB0UVYpRRI+p31wbswctngctqvfaHiRL9M=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1341.namprd15.prod.outlook.com (10.175.3.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Thu, 14 Mar 2019 18:29:14 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065%6]) with mapi id 15.20.1709.011; Thu, 14 Mar 2019
 18:29:14 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH perf,bpf 2/2] perf, bpf: show BPF program name in
 print_bpf_prog_info()
Thread-Topic: [PATCH perf,bpf 2/2] perf, bpf: show BPF program name in
 print_bpf_prog_info()
Thread-Index: AQHU2pNpXjd6YEgq/02uKWhIrYsl3KYLcn6A
Date:   Thu, 14 Mar 2019 18:29:14 +0000
Message-ID: <852EEAFE-328D-491F-A907-58B18EE02265@fb.com>
References: <20190314182538.1294526-1-songliubraving@fb.com>
 <20190314182538.1294526-3-songliubraving@fb.com>
In-Reply-To: <20190314182538.1294526-3-songliubraving@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::1e38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f111b5e8-f600-4e4d-b42b-08d6a8aaf61d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1341;
x-ms-traffictypediagnostic: MWHPR15MB1341:
x-microsoft-antispam-prvs: <MWHPR15MB1341BC3F8FAFF59723C6687CB34B0@MWHPR15MB1341.namprd15.prod.outlook.com>
x-forefront-prvs: 09760A0505
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(136003)(376002)(39860400002)(199004)(189003)(2501003)(7416002)(186003)(5660300002)(46003)(99286004)(478600001)(7736002)(36756003)(305945005)(6512007)(6246003)(8936002)(33656002)(256004)(81156014)(14444005)(8676002)(81166006)(83716004)(53546011)(71190400001)(71200400001)(105586002)(6436002)(102836004)(97736004)(50226002)(106356001)(14454004)(446003)(229853002)(6506007)(82746002)(86362001)(11346002)(57306001)(4326008)(2616005)(486006)(6116002)(25786009)(6486002)(110136005)(316002)(476003)(76176011)(2906002)(54906003)(68736007)(53936002)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1341;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6yyF+36UnVC9IC+S306ybg2jtXM/70Le5UluXGutw/Yg13nDaR8Rq3NxoxVPjxneIEFKKmlElnjptZNQM/Lm1pbvG76P3JzOgYWy/95h3F1xow1VU0lXilHtEYRjtc9wCjbXHgNniyZTFIRjCR6pCK6cOaKALIgef7nrgXVrNml1GfKYM6a1rdRwEtIX4UfX0KaM5O6yseLrJwu9fUjbih0Lizq6ehwihf4jvxu7SioTpMv3YHYnpS788ALcQxwurZyBhx4GZobxF+8InklladQgDB4/kHbAjE4QMBnWgAsDszud0xaiH6RfEvnyBCG8i8bk0+GnBXStAawe6wm2mrSDrFrhnRiChZbVq1eeJz2wAT+cS56hSgqrqBlPiskH76lPpdhwvJKlE00NSNbTBmzPIsYaGI6v67TInyFUk6I=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3A4AF206CB8E3A4FB146B875573758F5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f111b5e8-f600-4e4d-b42b-08d6a8aaf61d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2019 18:29:14.4590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1341
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-14_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 14, 2019, at 11:25 AM, Song Liu <songliubraving@fb.com> wrote:
>=20
> This patch enables showing bpf program name in the header.
>=20
> Before the patch:
>=20
>  perf report --header-only
>  ...
>  # bpf_prog_info of id 9
>  # bpf_prog_info of id 10
>  # bpf_prog_info of id 13
>=20
> After the patch:
>=20
>  # bpf_prog_info 9: bpf_prog_7be49e3934a125ba
>  # bpf_prog_info 10: bpf_prog_2a142ef67aaad174
>  # bpf_prog_info 13: bpf_prog_47368425825d7384_task__task_newt
>=20
> Signed-off-by: Song Liu <songliubraving@fb.com>

Please ignore this patch, and use the other PATCH 2/2 with address and=20
size information instead.=20

Thanks,
Song

> ---
> tools/perf/util/bpf-event.c | 36 ++++++++++++++++++++++++++++++++++++
> tools/perf/util/bpf-event.h | 10 +++++++++-
> tools/perf/util/header.c    |  5 +++--
> 3 files changed, 48 insertions(+), 3 deletions(-)
>=20
> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index 6e035e08aa2d..dde35a36e2de 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -433,3 +433,39 @@ int bpf_event__add_sb_event(struct perf_evlist **evl=
ist,
>=20
> 	return perf_evlist__add_sb_event(evlist, &attr, bpf_event__sb_cb, env);
> }
> +
> +void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
> +				    struct perf_env *env,
> +				    FILE *fp)
> +{
> +	char name[KSYM_NAME_LEN];
> +	struct btf *btf =3D NULL;
> +	u32 sub_prog_cnt, i;
> +
> +	sub_prog_cnt =3D info->nr_jited_ksyms;
> +	if (sub_prog_cnt !=3D info->nr_prog_tags ||
> +	    sub_prog_cnt !=3D info->nr_jited_func_lens)
> +		return;
> +
> +	if (info->btf_id) {
> +		struct btf_node *node;
> +
> +		node =3D perf_env__find_btf(env, info->btf_id);
> +		if (node)
> +			btf =3D btf__new((__u8 *)(node->data),
> +				       node->data_size);
> +	}
> +
> +	if (sub_prog_cnt =3D=3D 1) {
> +		synthesize_bpf_prog_name(name, KSYM_NAME_LEN, info, btf, 0);
> +		fprintf(fp, "# bpf_prog_info %u: %s\n", info->id, name);
> +		return;
> +	}
> +
> +	fprintf(fp, "# bpf_prog_info %u:\n", info->id);
> +	for (i =3D 0; i < sub_prog_cnt; i++) {
> +		synthesize_bpf_prog_name(name, KSYM_NAME_LEN, info, btf, i);
> +
> +		fprintf(fp, "# \tsub_prog %u: %s\n", i, name);
> +	}
> +}
> diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
> index 249909c826e7..4270dfd9cde9 100644
> --- a/tools/perf/util/bpf-event.h
> +++ b/tools/perf/util/bpf-event.h
> @@ -38,7 +38,9 @@ int perf_event__synthesize_bpf_events(struct perf_sessi=
on *session,
> 				      struct record_opts *opts);
> int bpf_event__add_sb_event(struct perf_evlist **evlist,
> 				 struct perf_env *env);
> -
> +void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
> +				    struct perf_env *env,
> +				    FILE *fp);
> #else
> static inline int machine__process_bpf_event(struct machine *machine __ma=
ybe_unused,
> 					     union perf_event *event __maybe_unused,
> @@ -61,5 +63,11 @@ static int bpf_event__add_sb_event(struct perf_evlist =
**evlist __maybe_unused,
> 	return 0;
> }
>=20
> +void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
> +				    struct perf_env *env,
> +				    FILE *fp)
> +{
> +
> +}
> #endif // HAVE_LIBBPF_SUPPORT
> #endif
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 7decd2d1dbda..588a80bdd500 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1434,8 +1434,9 @@ static void print_bpf_prog_info(struct feat_fd *ff,=
 FILE *fp)
>=20
> 		node =3D rb_entry(next, struct bpf_prog_info_node, rb_node);
> 		next =3D rb_next(&node->rb_node);
> -		fprintf(fp, "# bpf_prog_info of id %u\n",
> -			node->info_linear->info.id);
> +
> +		bpf_event__print_bpf_prog_info(&node->info_linear->info,
> +					       env, fp);
> 	}
>=20
> 	up_read(&env->bpf_progs.lock);
> --=20
> 2.17.1
>=20

