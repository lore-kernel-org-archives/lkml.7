Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBED9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E5F2133D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="GxhWB8QC";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="GeD+7Jug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfCSGGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 02:06:10 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38694 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725996AbfCSGGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 02:06:09 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2J5wVj0011623;
        Mon, 18 Mar 2019 23:05:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=GMR4Fo+kowkveGPs/JpxlbcBbZNM/IRGyLDuHwM8Ffc=;
 b=GxhWB8QCk8PL1UnLxHlwekzzD+VAF4Oc/pNTA5P6uLw9/m2xIV6G60Z9LnkWJG8OSheM
 T/Z4leFvI7Em1DbmLuZBKblbKlzl4HMfn6jphoXYlv17uPrwtyHiTeAVRG4P63phnc2x
 kJu/VnxbHiHuO1nZklefhRkdYz7S32nUSho= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rarprg9y4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 18 Mar 2019 23:05:33 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 18 Mar 2019 23:05:32 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 18 Mar 2019 23:05:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMR4Fo+kowkveGPs/JpxlbcBbZNM/IRGyLDuHwM8Ffc=;
 b=GeD+7Jug9DubEuCd6jeD/0pnZXklseOAlal81limiSg3pobX+orVlSnZuXM9Ig3TzVtT2I8mhNhrREFJNrKe3BfRfUFPdJEtao8iyjqHdaZ/ZxZe1J0rmDyo3Ng3Cp60NeD+9i+LuCMtL55CrA1qtOZS+A40WCRFni/fvBVO8oU=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1839.namprd15.prod.outlook.com (10.174.255.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 19 Mar 2019 06:05:30 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065%6]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 06:05:30 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Kernel Team" <Kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH v9 perf,bpf 12/15] perf, bpf: enable annotation of bpf
 program
Thread-Topic: [PATCH v9 perf,bpf 12/15] perf, bpf: enable annotation of bpf
 program
Thread-Index: AQHU2JTfEr1JAJv4B06G53/ZBJ39cqYRoPUAgADhYoA=
Date:   Tue, 19 Mar 2019 06:05:30 +0000
Message-ID: <9BC22A6D-B0A7-47B6-9526-E32924EF409D@fb.com>
References: <20190312053051.2690567-1-songliubraving@fb.com>
 <20190312053051.2690567-13-songliubraving@fb.com>
 <20190318163848.GE22548@kernel.org>
In-Reply-To: <20190318163848.GE22548@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:180::38e7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 439dc26f-231e-49c9-1022-08d6ac30e406
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1839;
x-ms-traffictypediagnostic: MWHPR15MB1839:
x-microsoft-antispam-prvs: <MWHPR15MB1839A32CFBDC1156D4F19ACAB3400@MWHPR15MB1839.namprd15.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(39860400002)(396003)(376002)(366004)(189003)(199004)(105586002)(106356001)(5660300002)(4326008)(53936002)(57306001)(99286004)(7736002)(30864003)(6486002)(6436002)(305945005)(6512007)(33656002)(97736004)(66574012)(14454004)(2906002)(14444005)(6116002)(256004)(446003)(76176011)(476003)(11346002)(82746002)(46003)(50226002)(102836004)(8936002)(8676002)(83716004)(6506007)(53546011)(71200400001)(486006)(7416002)(186003)(316002)(68736007)(54906003)(71190400001)(86362001)(81166006)(25786009)(81156014)(229853002)(2616005)(6246003)(6916009)(36756003)(478600001)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1839;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2OjA9cb8NvfZHTOj6JQeYCIZ0zgnPpnQf18jP6SnB+ZLiq82oMlgbsHIGfcoho+wS64ulAc4ntTI9DAUnFrFvYxfIwORV4+OfbiFX3bH1yiINJGcCK/a4uoJKJt7IkqV3ct9Q+uqsFeFKITCVJGA/fvKcniIvPhXrRR7i2bT6p8S5zXFISyMGGrqKEKbVSQ6c57Ls8RJfvJvra2ZQBs74hxztpCjAlG7rmm+f2MslNY6V4VQZ4UyVHk54sIfurfrx651SiqZNWhdFXdSRWPyLJ1jUj9kb54DDdyDC/ytPj+KqCOjDFBxee08Jt8vF33fR9KiFX0wZf3SeX3pF/yU0mujntEMTwld2Bh94EWqK1W8xIYz0zEdJI45rliPwzoOZGgjkNW0M1OOm7uZVQW55tq8WZ0ORhtZW2FimUABTt0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F49207EDF73851469EC31B93C8A6ADEA@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 439dc26f-231e-49c9-1022-08d6ac30e406
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 06:05:30.0511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1839
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-19_02:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the late response.=20

> On Mar 18, 2019, at 9:38 AM, Arnaldo Carvalho de Melo <arnaldo.melo@gmail=
.com> wrote:
>=20
> Em Mon, Mar 11, 2019 at 10:30:48PM -0700, Song Liu escreveu:
>> This patch enables the annotation of bpf program.
>>=20
>> A new dso type DSO_BINARY_TYPE__BPF_PROG_INFO is introduced to for BPF
>> programs. In symbol__disassemble(), DSO_BINARY_TYPE__BPF_PROG_INFO dso
>> calls into a new function symbol__disassemble_bpf(), where annotation
>> line information is filled based bpf_prog_info and btf saved in given
>> perf_env.
>>=20
>> symbol__disassemble_bpf() uses libbfd to disassemble bpf programs.
>>=20
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> ---
>> tools/build/Makefile.feature |   6 +-
>> tools/perf/Makefile.config   |   4 +
>=20
> I see the changes to these two files, but I can't see the feature test
> that it triggers, forgot to do a git-add? Or is it in an upcoming patch
> in this series?

test-disassembler-four-args.c is an existing test used by bpftool.
It was added in fb982666e380c1632a74495b68b3c33a66e76430 . =20

>=20
> After applying this test it "works":
>=20
>  make: Entering directory '/home/acme/git/perf/tools/perf'
>    BUILD:   Doing 'make -j8' parallel build
>=20
>  Auto-detecting system features:
>  ...                         dwarf: [ on  ]
>  ...            dwarf_getlocations: [ on  ]
>  <SNIP>
>  ...                           bpf: [ on  ]
>  ...                        libaio: [ on  ]
>  ...        disassembler-four-args: [ on  ]
>=20
> Because you added it to FEATURE_TESTS_BASIC, and this means that if
> tools/build/feature/test-all.c builds, then what is in
> FEATURE_TESTS_BASIC is set to 'on', but you didn't add anything to
> tools/build/feature/test-all.c, so it works because all the other
> features are present.
>=20
> Take a look at:
>=20
>  2a07d814747b ("tools build feature: Check if libaio is available")
>=20
> To see what needs to be done.

I used different versions of gcc to verify that current version of the=20
patch works for both test-succeed and test-fail cases. I guess something=20
like the following is needed? But the test does work without it.=20

Thanks,
Song


diff --git i/tools/build/feature/test-all.c w/tools/build/feature/test-all.=
c
index e903b86b742f..7853e6d91090 100644
--- i/tools/build/feature/test-all.c
+++ w/tools/build/feature/test-all.c
@@ -178,6 +178,10 @@
 # include "test-reallocarray.c"
 #undef main

+#define main main_test_disassembler_four_args
+# include "test-disassembler-four-args.c"
+#undef main
+
 int main(int argc, char *argv[])
 {
        main_test_libpython();
@@ -219,6 +223,7 @@ int main(int argc, char *argv[])
        main_test_setns();
        main_test_libaio();
        main_test_reallocarray();
+       main_test_disassembler_four_args();

        return 0;
 }


>=20
> Either way, its interesting to break this patch in two, one adding the
> feature test and another to use it, i.e. the second patch out of this
> should have the commit log message in this patch.
>=20
> I've applied the patches up to before this one and will continue
> processing other patches while you address this.
>=20
> Thanks,
>=20
> - Arnaldo
>=20
>> tools/perf/util/annotate.c   | 150 ++++++++++++++++++++++++++++++++++-
>> tools/perf/util/dso.c        |   1 +
>> tools/perf/util/dso.h        |  32 +++++---
>> tools/perf/util/symbol.c     |   1 +
>> 6 files changed, 180 insertions(+), 14 deletions(-)
>>=20
>> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
>> index 61e46d54a67c..8d3864b061f3 100644
>> --- a/tools/build/Makefile.feature
>> +++ b/tools/build/Makefile.feature
>> @@ -66,7 +66,8 @@ FEATURE_TESTS_BASIC :=3D                  \
>>         sched_getcpu			\
>>         sdt				\
>>         setns				\
>> -        libaio
>> +        libaio				\
>> +        disassembler-four-args
>>=20
>> # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
>> # of all feature tests
>> @@ -118,7 +119,8 @@ FEATURE_DISPLAY ?=3D              \
>>          lzma                   \
>>          get_cpuid              \
>>          bpf			\
>> -         libaio
>> +         libaio			\
>> +         disassembler-four-args
>>=20
>> # Set FEATURE_CHECK_(C|LD)FLAGS-all for all FEATURE_TESTS features.
>> # If in the future we need per-feature checks/flags for features not
>> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
>> index df4ad45599ca..c51b59e43dcc 100644
>> --- a/tools/perf/Makefile.config
>> +++ b/tools/perf/Makefile.config
>> @@ -808,6 +808,10 @@ ifdef HAVE_KVM_STAT_SUPPORT
>>     CFLAGS +=3D -DHAVE_KVM_STAT_SUPPORT
>> endif
>>=20
>> +ifeq ($(feature-disassembler-four-args), 1)
>> +    CFLAGS +=3D -DDISASM_FOUR_ARGS_SIGNATURE
>> +endif
>> +
>> ifeq (${IS_64_BIT}, 1)
>>   ifndef NO_PERF_READ_VDSO32
>>     $(call feature_check,compile-32)
>> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
>> index 5f6dbbf5d749..e492b19a157c 100644
>> --- a/tools/perf/util/annotate.c
>> +++ b/tools/perf/util/annotate.c
>> @@ -10,6 +10,10 @@
>> #include <errno.h>
>> #include <inttypes.h>
>> #include <libgen.h>
>> +#include <bpf/bpf.h>
>> +#include <bpf/btf.h>
>> +#include <bpf/libbpf.h>
>> +#include <linux/btf.h>
>> #include "util.h"
>> #include "ui/ui.h"
>> #include "sort.h"
>> @@ -24,6 +28,7 @@
>> #include "annotate.h"
>> #include "evsel.h"
>> #include "evlist.h"
>> +#include "bpf-event.h"
>> #include "block-range.h"
>> #include "string2.h"
>> #include "arch/common.h"
>> @@ -31,6 +36,9 @@
>> #include <pthread.h>
>> #include <linux/bitops.h>
>> #include <linux/kernel.h>
>> +#include <bfd.h>
>> +#include <dis-asm.h>
>> +#include <bpf/libbpf.h>
>>=20
>> /* FIXME: For the HE_COLORSET */
>> #include "ui/browser.h"
>> @@ -1674,6 +1682,144 @@ static int dso__disassemble_filename(struct dso =
*dso, char *filename, size_t fil
>> 	return 0;
>> }
>>=20
>> +static int symbol__disassemble_bpf(struct symbol *sym,
>> +				   struct annotate_args *args)
>> +{
>> +	struct annotation *notes =3D symbol__annotation(sym);
>> +	struct annotation_options *opts =3D args->options;
>> +	struct bpf_prog_info_linear *info_linear;
>> +	struct bpf_prog_linfo *prog_linfo =3D NULL;
>> +	struct bpf_prog_info_node *info_node;
>> +	int len =3D sym->end - sym->start;
>> +	disassembler_ftype disassemble;
>> +	struct map *map =3D args->ms.map;
>> +	struct disassemble_info info;
>> +	struct dso *dso =3D map->dso;
>> +	int pc =3D 0, count, sub_id;
>> +	struct btf *btf =3D NULL;
>> +	char tpath[PATH_MAX];
>> +	size_t buf_size;
>> +	int nr_skip =3D 0;
>> +	int ret =3D -1;
>> +	char *buf;
>> +	bfd *bfdf;
>> +	FILE *s;
>> +
>> +	if (dso->binary_type !=3D DSO_BINARY_TYPE__BPF_PROG_INFO)
>> +		return -1;
>> +
>> +	pr_debug("%s: handling sym %s addr %lx len %lx\n", __func__,
>> +		 sym->name, sym->start, sym->end - sym->start);
>> +
>> +	memset(tpath, 0, sizeof(tpath));
>> +	perf_exe(tpath, sizeof(tpath));
>> +
>> +	bfdf =3D bfd_openr(tpath, NULL);
>> +	assert(bfdf);
>> +	assert(bfd_check_format(bfdf, bfd_object));
>> +
>> +	s =3D open_memstream(&buf, &buf_size);
>> +	if (!s)
>> +		goto out;
>> +	init_disassemble_info(&info, s,
>> +			      (fprintf_ftype) fprintf);
>> +
>> +	info.arch =3D bfd_get_arch(bfdf);
>> +	info.mach =3D bfd_get_mach(bfdf);
>> +
>> +	info_node =3D perf_env__find_bpf_prog_info(dso->bpf_prog.env,
>> +						 dso->bpf_prog.id);
>> +	if (!info_node)
>> +		goto out;
>> +	info_linear =3D info_node->info_linear;
>> +	sub_id =3D dso->bpf_prog.sub_id;
>> +
>> +	info.buffer =3D (void *)(info_linear->info.jited_prog_insns);
>> +	info.buffer_length =3D info_linear->info.jited_prog_len;
>> +
>> +	if (info_linear->info.nr_line_info)
>> +		prog_linfo =3D bpf_prog_linfo__new(&info_linear->info);
>> +
>> +	if (info_linear->info.btf_id) {
>> +		struct btf_node *node;
>> +
>> +		node =3D perf_env__find_btf(dso->bpf_prog.env,
>> +					  info_linear->info.btf_id);
>> +		if (node)
>> +			btf =3D btf__new((__u8 *)(node->data),
>> +				       node->data_size);
>> +	}
>> +
>> +	disassemble_init_for_target(&info);
>> +
>> +#ifdef DISASM_FOUR_ARGS_SIGNATURE
>> +	disassemble =3D disassembler(info.arch,
>> +				   bfd_big_endian(bfdf),
>> +				   info.mach,
>> +				   bfdf);
>> +#else
>> +	disassemble =3D disassembler(bfdf);
>> +#endif
>> +	assert(disassemble);
>> +
>> +	fflush(s);
>> +	do {
>> +		const struct bpf_line_info *linfo =3D NULL;
>> +		struct disasm_line *dl;
>> +		size_t prev_buf_size;
>> +		const char *srcline;
>> +		u64 addr;
>> +
>> +		addr =3D pc + ((u64 *)(info_linear->info.jited_ksyms))[sub_id];
>> +		count =3D disassemble(pc, &info);
>> +
>> +		if (prog_linfo)
>> +			linfo =3D bpf_prog_linfo__lfind_addr_func(prog_linfo,
>> +								addr, sub_id,
>> +								nr_skip);
>> +
>> +		if (linfo && btf) {
>> +			srcline =3D btf__name_by_offset(btf, linfo->line_off);
>> +			nr_skip++;
>> +		} else
>> +			srcline =3D NULL;
>> +
>> +		fprintf(s, "\n");
>> +		prev_buf_size =3D buf_size;
>> +		fflush(s);
>> +
>> +		if (!opts->hide_src_code && srcline) {
>> +			args->offset =3D -1;
>> +			args->line =3D strdup(srcline);
>> +			args->line_nr =3D 0;
>> +			args->ms.sym  =3D sym;
>> +			dl =3D disasm_line__new(args);
>> +			if (dl) {
>> +				annotation_line__add(&dl->al,
>> +						     &notes->src->source);
>> +			}
>> +		}
>> +
>> +		args->offset =3D pc;
>> +		args->line =3D buf + prev_buf_size;
>> +		args->line_nr =3D 0;
>> +		args->ms.sym  =3D sym;
>> +		dl =3D disasm_line__new(args);
>> +		if (dl)
>> +			annotation_line__add(&dl->al, &notes->src->source);
>> +
>> +		pc +=3D count;
>> +	} while (count > 0 && pc < len);
>> +
>> +	ret =3D 0;
>> +out:
>> +	free(prog_linfo);
>> +	free(btf);
>> +	fclose(s);
>> +	bfd_close(bfdf);
>> +	return ret;
>> +}
>> +
>> static int symbol__disassemble(struct symbol *sym, struct annotate_args =
*args)
>> {
>> 	struct annotation_options *opts =3D args->options;
>> @@ -1701,7 +1847,9 @@ static int symbol__disassemble(struct symbol *sym,=
 struct annotate_args *args)
>> 	pr_debug("annotating [%p] %30s : [%p] %30s\n",
>> 		 dso, dso->long_name, sym, sym->name);
>>=20
>> -	if (dso__is_kcore(dso)) {
>> +	if (dso->binary_type =3D=3D DSO_BINARY_TYPE__BPF_PROG_INFO) {
>> +		return symbol__disassemble_bpf(sym, args);
>> +	} else if (dso__is_kcore(dso)) {
>> 		kce.kcore_filename =3D symfs_filename;
>> 		kce.addr =3D map__rip_2objdump(map, sym->start);
>> 		kce.offs =3D sym->start;
>> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
>> index ba58ba603b69..58547c468c65 100644
>> --- a/tools/perf/util/dso.c
>> +++ b/tools/perf/util/dso.c
>> @@ -184,6 +184,7 @@ int dso__read_binary_type_filename(const struct dso =
*dso,
>> 	case DSO_BINARY_TYPE__KALLSYMS:
>> 	case DSO_BINARY_TYPE__GUEST_KALLSYMS:
>> 	case DSO_BINARY_TYPE__JAVA_JIT:
>> +	case DSO_BINARY_TYPE__BPF_PROG_INFO:
>> 	case DSO_BINARY_TYPE__NOT_FOUND:
>> 		ret =3D -1;
>> 		break;
>> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
>> index bb417c54c25a..c274b5aa839d 100644
>> --- a/tools/perf/util/dso.h
>> +++ b/tools/perf/util/dso.h
>> @@ -14,6 +14,7 @@
>>=20
>> struct machine;
>> struct map;
>> +struct perf_env;
>>=20
>> enum dso_binary_type {
>> 	DSO_BINARY_TYPE__KALLSYMS =3D 0,
>> @@ -35,6 +36,7 @@ enum dso_binary_type {
>> 	DSO_BINARY_TYPE__KCORE,
>> 	DSO_BINARY_TYPE__GUEST_KCORE,
>> 	DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
>> +	DSO_BINARY_TYPE__BPF_PROG_INFO,
>> 	DSO_BINARY_TYPE__NOT_FOUND,
>> };
>>=20
>> @@ -178,17 +180,25 @@ struct dso {
>> 	struct auxtrace_cache *auxtrace_cache;
>> 	int		 comp;
>>=20
>> -	/* dso data file */
>> -	struct {
>> -		struct rb_root	 cache;
>> -		int		 fd;
>> -		int		 status;
>> -		u32		 status_seen;
>> -		size_t		 file_size;
>> -		struct list_head open_entry;
>> -		u64		 debug_frame_offset;
>> -		u64		 eh_frame_hdr_offset;
>> -	} data;
>> +	union {
>> +		/* dso data file */
>> +		struct {
>> +			struct rb_root	 cache;
>> +			int		 fd;
>> +			int		 status;
>> +			u32		 status_seen;
>> +			size_t		 file_size;
>> +			struct list_head open_entry;
>> +			u64		 debug_frame_offset;
>> +			u64		 eh_frame_hdr_offset;
>> +		} data;
>> +		/* bpf prog information */
>> +		struct {
>> +			u32		id;
>> +			u32		sub_id;
>> +			struct perf_env	*env;
>> +		} bpf_prog;
>> +	};
>>=20
>> 	union { /* Tool specific area */
>> 		void	 *priv;
>> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
>> index 758bf5f74e6e..4e2e304d4037 100644
>> --- a/tools/perf/util/symbol.c
>> +++ b/tools/perf/util/symbol.c
>> @@ -1451,6 +1451,7 @@ static bool dso__is_compatible_symtab_type(struct =
dso *dso, bool kmod,
>> 	case DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO:
>> 		return true;
>>=20
>> +	case DSO_BINARY_TYPE__BPF_PROG_INFO:
>> 	case DSO_BINARY_TYPE__NOT_FOUND:
>> 	default:
>> 		return false;
>> --=20
>> 2.17.1
>=20
> --=20
>=20
> - Arnaldo

