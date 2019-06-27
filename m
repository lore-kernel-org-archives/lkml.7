Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCADC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 16:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2C92147A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 16:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="mwu8oKPj";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="lIXc36iP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfF0Qjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 12:39:46 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:14940 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725770AbfF0Qjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 12:39:45 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RGdDwO004339;
        Thu, 27 Jun 2019 09:39:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Jvn+eMGnxbmlM3FTQbm/zhkf1oxgTH/JtRniNvPTLzw=;
 b=mwu8oKPjP30lGD0drLkI8jTkabeJhOhySbf6TTVj37rDrCYvb/RSXP+/jx42hIzkLXw2
 yvurmoUwlgfbW38psLouJNltkNc+UVcogUkV0g0hIJHqpbUgPRFVOnHm4KIhQpiyr2Ht
 jFPH19VehgRsGpwg4qJ1Gm4bqyuzbkyjgzw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2tcyq3rgcn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 27 Jun 2019 09:39:20 -0700
Received: from ash-exopmbx201.TheFacebook.com (2620:10d:c0a8:83::8) by
 ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 27 Jun 2019 09:39:19 -0700
Received: from ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) by
 ash-exopmbx201.TheFacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 27 Jun 2019 09:39:19 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 27 Jun 2019 09:39:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jvn+eMGnxbmlM3FTQbm/zhkf1oxgTH/JtRniNvPTLzw=;
 b=lIXc36iPD/1VKFBPSb9UMiPzlTdi8zGsauy/kZs5oSduL9qczR80dnjUTqwLYnyjDI7B6Crgs4d21r4g78YCS69BtnmxI9SO/3rE6AKJio1MxqJ5q886LOgezTubxKWHQ4/JE7yAXZc9jAtLiOT8rRdjMykQBPAjjUsVtn3bcP4=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1918.namprd15.prod.outlook.com (10.174.101.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Thu, 27 Jun 2019 16:39:17 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d%6]) with mapi id 15.20.2008.018; Thu, 27 Jun 2019
 16:39:17 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Allan Zhang <allanzhang@google.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, Martin Lau <kafai@fb.com>,
        Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v7 2/2] selftests/bpf: Add selftests for
 bpf_perf_event_output
Thread-Topic: [PATCH bpf-next v7 2/2] selftests/bpf: Add selftests for
 bpf_perf_event_output
Thread-Index: AQHVLHsQTUNlXpJkGkmkKUDmz4+uAaavtMEA
Date:   Thu, 27 Jun 2019 16:39:17 +0000
Message-ID: <7712D61D-C24C-44A3-BE0F-2D2840865900@fb.com>
References: <20190626235801.210508-1-allanzhang@google.com>
 <20190626235801.210508-3-allanzhang@google.com>
In-Reply-To: <20190626235801.210508-3-allanzhang@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::3:a913]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 998cd966-f6ab-4c96-88c8-08d6fb1dff5d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1918;
x-ms-traffictypediagnostic: MWHPR15MB1918:
x-microsoft-antispam-prvs: <MWHPR15MB19186456905BB28A5758E75CB3FD0@MWHPR15MB1918.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(346002)(366004)(136003)(189003)(199004)(102836004)(53936002)(7736002)(14454004)(229853002)(478600001)(53546011)(6506007)(76176011)(6486002)(36756003)(54906003)(33656002)(316002)(6512007)(66476007)(66556008)(305945005)(76116006)(66446008)(64756008)(71190400001)(71200400001)(66946007)(73956011)(50226002)(99286004)(14444005)(8676002)(5660300002)(486006)(81156014)(68736007)(6436002)(8936002)(186003)(46003)(256004)(25786009)(446003)(86362001)(476003)(2616005)(6246003)(11346002)(6116002)(4326008)(81166006)(2906002)(6916009)(57306001)(505234006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1918;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: u5fsKaKDsyQRuL5niCThiXkirp0T6o9dQbwa0YgiGVjYzyZMIskuf+hWQdv1XbJ92TcMDkilLxNSajrvQiG2IbKEsIsQNVo3WDdBSeJgovcKdbMZdsieKFkXXOvpCQqGrSJEHRLLUqVScguuNWZLjvqMNVBmYWHpzhHjNjzWKBp5LF1ZBLiyol0KKHaJ1EF78D0rPMsvyS51ymNalWjvV9VtFUH+6AKOUMi41PNIUMw7lWmwoPz1dIyHdloWeaFOag8KZ6o8/9ulrvcqMEeBJ4w2Ywf0F4g6x/yEyXYG60cIno2SwIJ6RrA+Qp5fK+3zyZfbOuzkhUeW3BqYW+behOqMRjGf2knXsghxsWyJWL393VvW1LmT445vzewuyAsRAJSXlEoJS7Qg7TKU+DucfJCqfNndNNJ7UolHdPFCD5k=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1895774E6FE54944B209D73103FA1340@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 998cd966-f6ab-4c96-88c8-08d6fb1dff5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 16:39:17.4455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1918
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-27_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906270191
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 26, 2019, at 4:58 PM, Allan Zhang <allanzhang@google.com> wrote:
>=20
> From: allanzhang <allanzhang@google.com>
>=20
> Software event output is only enabled by a few prog types.
> This test is to ensure that all supported types are enabled for
> bpf_perf_event_output successfully.
>=20
> Signed-off-by: Allan Zhang <allanzhang@google.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
> tools/testing/selftests/bpf/test_verifier.c   | 12 ++-
> .../selftests/bpf/verifier/event_output.c     | 94 +++++++++++++++++++
> 2 files changed, 105 insertions(+), 1 deletion(-)
> create mode 100644 tools/testing/selftests/bpf/verifier/event_output.c
>=20
> diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/=
selftests/bpf/test_verifier.c
> index c5514daf8865..5e98d7c37eb7 100644
> --- a/tools/testing/selftests/bpf/test_verifier.c
> +++ b/tools/testing/selftests/bpf/test_verifier.c
> @@ -50,7 +50,7 @@
> #define MAX_INSNS	BPF_MAXINSNS
> #define MAX_TEST_INSNS	1000000
> #define MAX_FIXUPS	8
> -#define MAX_NR_MAPS	18
> +#define MAX_NR_MAPS	19
> #define MAX_TEST_RUNS	8
> #define POINTER_VALUE	0xcafe4all
> #define TEST_DATA_LEN	64
> @@ -84,6 +84,7 @@ struct bpf_test {
> 	int fixup_map_array_wo[MAX_FIXUPS];
> 	int fixup_map_array_small[MAX_FIXUPS];
> 	int fixup_sk_storage_map[MAX_FIXUPS];
> +	int fixup_map_event_output[MAX_FIXUPS];
> 	const char *errstr;
> 	const char *errstr_unpriv;
> 	uint32_t retval, retval_unpriv, insn_processed;
> @@ -627,6 +628,7 @@ static void do_test_fixup(struct bpf_test *test, enum=
 bpf_prog_type prog_type,
> 	int *fixup_map_array_wo =3D test->fixup_map_array_wo;
> 	int *fixup_map_array_small =3D test->fixup_map_array_small;
> 	int *fixup_sk_storage_map =3D test->fixup_sk_storage_map;
> +	int *fixup_map_event_output =3D test->fixup_map_event_output;
>=20
> 	if (test->fill_helper) {
> 		test->fill_insns =3D calloc(MAX_TEST_INSNS, sizeof(struct bpf_insn));
> @@ -788,6 +790,14 @@ static void do_test_fixup(struct bpf_test *test, enu=
m bpf_prog_type prog_type,
> 			fixup_sk_storage_map++;
> 		} while (*fixup_sk_storage_map);
> 	}
> +	if (*fixup_map_event_output) {
> +		map_fds[18] =3D __create_map(BPF_MAP_TYPE_PERF_EVENT_ARRAY,
> +					   sizeof(int), sizeof(int), 1, 0);
> +		do {
> +			prog[*fixup_map_event_output].imm =3D map_fds[18];
> +			fixup_map_event_output++;
> +		} while (*fixup_map_event_output);
> +	}
> }
>=20
> static int set_admin(bool admin)
> diff --git a/tools/testing/selftests/bpf/verifier/event_output.c b/tools/=
testing/selftests/bpf/verifier/event_output.c
> new file mode 100644
> index 000000000000..130553e19eca
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/verifier/event_output.c
> @@ -0,0 +1,94 @@
> +/* instructions used to output a skb based software event, produced
> + * from code snippet:
> + * struct TMP {
> + *  uint64_t tmp;
> + * } tt;
> + * tt.tmp =3D 5;
> + * bpf_perf_event_output(skb, &connection_tracking_event_map, 0,
> + *			 &tt, sizeof(tt));
> + * return 1;
> + *
> + * the bpf assembly from llvm is:
> + *        0:       b7 02 00 00 05 00 00 00         r2 =3D 5
> + *        1:       7b 2a f8 ff 00 00 00 00         *(u64 *)(r10 - 8) =3D=
 r2
> + *        2:       bf a4 00 00 00 00 00 00         r4 =3D r10
> + *        3:       07 04 00 00 f8 ff ff ff         r4 +=3D -8
> + *        4:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00    r2=
 =3D 0ll
> + *        6:       b7 03 00 00 00 00 00 00         r3 =3D 0
> + *        7:       b7 05 00 00 08 00 00 00         r5 =3D 8
> + *        8:       85 00 00 00 19 00 00 00         call 25
> + *        9:       b7 00 00 00 01 00 00 00         r0 =3D 1
> + *       10:       95 00 00 00 00 00 00 00         exit
> + *
> + *     The reason I put the code here instead of fill_helpers is that ma=
p fixup
> + *     is against the insns, instead of filled prog.
> + */
> +
> +#define __PERF_EVENT_INSNS__					\
> +	BPF_MOV64_IMM(BPF_REG_2, 5),				\
> +	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_2, -8),		\
> +	BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),			\
> +	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -8),			\
> +	BPF_LD_MAP_FD(BPF_REG_2, 0),				\
> +	BPF_MOV64_IMM(BPF_REG_3, 0),				\
> +	BPF_MOV64_IMM(BPF_REG_5, 8),				\
> +	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,		\
> +		     BPF_FUNC_perf_event_output),		\
> +	BPF_MOV64_IMM(BPF_REG_0, 1),				\
> +	BPF_EXIT_INSN(),
> +{
> +	"perfevent for sockops",
> +	.insns =3D { __PERF_EVENT_INSNS__ },
> +	.prog_type =3D BPF_PROG_TYPE_SOCK_OPS,
> +	.fixup_map_event_output =3D { 4 },
> +	.result =3D ACCEPT,
> +	.retval =3D 1,
> +},
> +{
> +	"perfevent for tc",
> +	.insns =3D  { __PERF_EVENT_INSNS__ },
> +	.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
> +	.fixup_map_event_output =3D { 4 },
> +	.result =3D ACCEPT,
> +	.retval =3D 1,
> +},
> +{
> +	"perfevent for lwt out",
> +	.insns =3D  { __PERF_EVENT_INSNS__ },
> +	.prog_type =3D BPF_PROG_TYPE_LWT_OUT,
> +	.fixup_map_event_output =3D { 4 },
> +	.result =3D ACCEPT,
> +	.retval =3D 1,
> +},
> +{
> +	"perfevent for xdp",
> +	.insns =3D  { __PERF_EVENT_INSNS__ },
> +	.prog_type =3D BPF_PROG_TYPE_XDP,
> +	.fixup_map_event_output =3D { 4 },
> +	.result =3D ACCEPT,
> +	.retval =3D 1,
> +},
> +{
> +	"perfevent for socket filter",
> +	.insns =3D  { __PERF_EVENT_INSNS__ },
> +	.prog_type =3D BPF_PROG_TYPE_SOCKET_FILTER,
> +	.fixup_map_event_output =3D { 4 },
> +	.result =3D ACCEPT,
> +	.retval =3D 1,
> +},
> +{
> +	"perfevent for sk_skb",
> +	.insns =3D  { __PERF_EVENT_INSNS__ },
> +	.prog_type =3D BPF_PROG_TYPE_SK_SKB,
> +	.fixup_map_event_output =3D { 4 },
> +	.result =3D ACCEPT,
> +	.retval =3D 1,
> +},
> +{
> +	"perfevent for cgroup skb",
> +	.insns =3D  { __PERF_EVENT_INSNS__ },
> +	.prog_type =3D BPF_PROG_TYPE_CGROUP_SKB,
> +	.fixup_map_event_output =3D { 4 },
> +	.result =3D ACCEPT,
> +	.retval =3D 1,
> +},
> --=20
> 2.22.0.410.gd8fdbe21b5-goog
>=20

