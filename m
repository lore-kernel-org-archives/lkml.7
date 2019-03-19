Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924FCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4256E20989
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="q3bpNWhy";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="XImxcNg9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfCSGLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 02:11:17 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43114 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725996AbfCSGLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 02:11:17 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2J6831T025322;
        Mon, 18 Mar 2019 23:10:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=GssuWhGMTgrFaPz5SW8aoQLRbljG8ycJJhl8h9wiaTc=;
 b=q3bpNWhyHaB65r9yf1cbUbVauuQuAIMWuRpX0pwyt2qhZGRFJ17SqBjhQNFjdzQDLju2
 n6XbIA9YqEFwGqtKUlwFJZi6piyYJBpMGcjIBJ4cx6bimDeLXwc/2DtRncs9fnE22Ytv
 HvovB+rp+o3eL30DZ3GtHz6bKzgfQ00ojs0= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rap0d0r0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 18 Mar 2019 23:10:46 -0700
Received: from frc-hub01.TheFacebook.com (2620:10d:c021:18::171) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 18 Mar 2019 23:10:44 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 18 Mar 2019 23:10:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GssuWhGMTgrFaPz5SW8aoQLRbljG8ycJJhl8h9wiaTc=;
 b=XImxcNg9R8nzxMHoABg53Mc15IuUURnG7r2WNMxaeFlwAU9JVVT671IraZM3yzkj6XgLwBZS+CC2ETQnLHsQwLWsglFzi0G20L6lgw41wN28vZ+3jQKAtjqfQUywRYOf9pq49WXcg5C3SG6d3jkp6RvQMyWpA6agPSMI7hMSAuc=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1296.namprd15.prod.outlook.com (10.175.3.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 19 Mar 2019 06:10:43 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065%6]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 06:10:43 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "sdf@fomichev.me" <sdf@fomichev.me>
Subject: Re: [PATCH v9 perf,bpf 12/15] perf, bpf: enable annotation of bpf
 program
Thread-Topic: [PATCH v9 perf,bpf 12/15] perf, bpf: enable annotation of bpf
 program
Thread-Index: AQHU2JTfEr1JAJv4B06G53/ZBJ39cqYRoPUAgAABcQCAAOFlgA==
Date:   Tue, 19 Mar 2019 06:10:42 +0000
Message-ID: <0EBEB3A4-8C54-4486-AFE5-A058EBDC2117@fb.com>
References: <20190312053051.2690567-1-songliubraving@fb.com>
 <20190312053051.2690567-13-songliubraving@fb.com>
 <20190318163848.GE22548@kernel.org> <20190318164358.GF22548@kernel.org>
In-Reply-To: <20190318164358.GF22548@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:180::38e7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92cf5652-b424-4be0-8adc-08d6ac319e6c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1296;
x-ms-traffictypediagnostic: MWHPR15MB1296:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR15MB1296986CACDA19423811FA98B3400@MWHPR15MB1296.namprd15.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(346002)(396003)(376002)(39860400002)(189003)(199004)(966005)(46003)(2906002)(7736002)(25786009)(102836004)(14454004)(6246003)(6306002)(2616005)(53936002)(11346002)(6116002)(82746002)(5660300002)(476003)(446003)(478600001)(6512007)(76176011)(305945005)(7416002)(4326008)(53546011)(6506007)(186003)(105586002)(8936002)(97736004)(6486002)(50226002)(93886005)(81156014)(81166006)(6916009)(229853002)(486006)(36756003)(86362001)(68736007)(57306001)(8676002)(106356001)(71200400001)(54906003)(316002)(99286004)(256004)(33656002)(83716004)(71190400001)(6436002)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1296;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xwBjk2hBwbXgdCh4nRlIEM6voSwe20XKQj78ci/azL0KMamUhTOv/QmL6riCxLmD8h0HAuFOMNumgK73w4p2szrrE3Ek/Rz5qS60E1/vUftU/rPMEeKhaSscoX7+c4IADtmjrbetjKH01lHpMYSHNBt58N05GfvSzKzHFxG3vupredMH9WZbXO0f4aPu8CVal68DjC1PuP/vR9fjSXm/CFyMspDl4er0zYTvhqFe/u3I0Fw51RhGkzvRdN7gGkwtyzBUcnqpMfBNBeksIIwzYffr0E651ky7n42wwmWkCEk7oi0682WTdsxUItKhHxUxZNWSWQ6YRkXUJ4JKJWGsuovNY266rHyPIv+xQ+dgcziQAam6bspE2zOzF1rGeP/P/ZBBY89bxrGlhoh9NtCqi/wwW56xbgsZOlYr7pLpVmg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3FD03B0501F35A4FB7ED6C69A3CC41B6@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 92cf5652-b424-4be0-8adc-08d6ac319e6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 06:10:42.8370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1296
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-19_02:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 18, 2019, at 9:43 AM, Arnaldo Carvalho de Melo <arnaldo.melo@gmail=
.com> wrote:
>=20
> Em Mon, Mar 18, 2019 at 01:38:48PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
>> Em Mon, Mar 11, 2019 at 10:30:48PM -0700, Song Liu escreveu:
>>> This patch enables the annotation of bpf program.
>>>=20
>>> A new dso type DSO_BINARY_TYPE__BPF_PROG_INFO is introduced to for BPF
>>> programs. In symbol__disassemble(), DSO_BINARY_TYPE__BPF_PROG_INFO dso
>>> calls into a new function symbol__disassemble_bpf(), where annotation
>>> line information is filled based bpf_prog_info and btf saved in given
>>> perf_env.
>>>=20
>>> symbol__disassemble_bpf() uses libbfd to disassemble bpf programs.
>>>=20
>>> Signed-off-by: Song Liu <songliubraving@fb.com>
>>> ---
>>> tools/build/Makefile.feature |   6 +-
>>> tools/perf/Makefile.config   |   4 +
>>=20
>> I see the changes to these two files, but I can't see the feature test
>> that it triggers, forgot to do a git-add? Or is it in an upcoming patch
>> in this series?
>>=20
>> After applying this test it "works":
>>=20
>>  make: Entering directory '/home/acme/git/perf/tools/perf'
>>    BUILD:   Doing 'make -j8' parallel build
>>=20
>>  Auto-detecting system features:
>>  ...                         dwarf: [ on  ]
>>  ...            dwarf_getlocations: [ on  ]
>>  <SNIP>
>>  ...                           bpf: [ on  ]
>>  ...                        libaio: [ on  ]
>>  ...        disassembler-four-args: [ on  ]
>>=20
>> Because you added it to FEATURE_TESTS_BASIC, and this means that if
>> tools/build/feature/test-all.c builds, then what is in
>> FEATURE_TESTS_BASIC is set to 'on', but you didn't add anything to
>> tools/build/feature/test-all.c, so it works because all the other
>> features are present.
>>=20
>> Take a look at:
>>=20
>>  2a07d814747b ("tools build feature: Check if libaio is available")
>>=20
>> To see what needs to be done.
>>=20
>> Either way, its interesting to break this patch in two, one adding the
>> feature test and another to use it, i.e. the second patch out of this
>> should have the commit log message in this patch.
>>=20
>> I've applied the patches up to before this one and will continue
>> processing other patches while you address this.
>=20
> Ok, to continue processing the other patches I chunked out the part
> below into a 3rd patch from the above one and have it applied already.

Could you please push applied patches to the tmp.perf/bpf-annotation=20
branch?=20

Thanks,
Song

>=20
> commit f326de312abc3657b0397817c66cd7e1540655f7
> Author: Song Liu <songliubraving@fb.com>
> Date:   Mon Mar 11 22:30:48 2019 -0700
>=20
>    perf symbols: Introduce DSO_BINARY_TYPE__BPF_PROG_INFO
>=20
>    Introduce a new dso type DSO_BINARY_TYPE__BPF_PROG_INFO for BPF progra=
ms. In
>    symbol__disassemble(), DSO_BINARY_TYPE__BPF_PROG_INFO dso will call in=
to a new
>    function symbol__disassemble_bpf() in an upcoming patch, where annotat=
ion line
>    information is filled based bpf_prog_info and btf saved in given perf_=
env.
>=20
>    Signed-off-by: Song Liu <songliubraving@fb.com>
>    Reviewed-by: Jiri Olsa <jolsa@kernel.org>
>    Cc: Alexei Starovoitov <ast@kernel.org>
>    Cc: Daniel Borkmann <daniel@iogearbox.net>
>    Cc: Namhyung Kim <namhyung@kernel.org>
>    Cc: Peter Zijlstra <peterz@infradead.org>
>    Cc: Stanislav Fomichev <sdf@google.com>
>    Cc: kernel-team@fb.com
>    Link: http://lkml.kernel.org/r/20190312053051.2690567-13-songliubravin=
g@fb.com
>    [ split from a larger patch ]
>    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index ba58ba603b69..58547c468c65 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -184,6 +184,7 @@ int dso__read_binary_type_filename(const struct dso *=
dso,
> 	case DSO_BINARY_TYPE__KALLSYMS:
> 	case DSO_BINARY_TYPE__GUEST_KALLSYMS:
> 	case DSO_BINARY_TYPE__JAVA_JIT:
> +	case DSO_BINARY_TYPE__BPF_PROG_INFO:
> 	case DSO_BINARY_TYPE__NOT_FOUND:
> 		ret =3D -1;
> 		break;
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index bb417c54c25a..c274b5aa839d 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -14,6 +14,7 @@
>=20
> struct machine;
> struct map;
> +struct perf_env;
>=20
> enum dso_binary_type {
> 	DSO_BINARY_TYPE__KALLSYMS =3D 0,
> @@ -35,6 +36,7 @@ enum dso_binary_type {
> 	DSO_BINARY_TYPE__KCORE,
> 	DSO_BINARY_TYPE__GUEST_KCORE,
> 	DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
> +	DSO_BINARY_TYPE__BPF_PROG_INFO,
> 	DSO_BINARY_TYPE__NOT_FOUND,
> };
>=20
> @@ -178,17 +180,25 @@ struct dso {
> 	struct auxtrace_cache *auxtrace_cache;
> 	int		 comp;
>=20
> -	/* dso data file */
> -	struct {
> -		struct rb_root	 cache;
> -		int		 fd;
> -		int		 status;
> -		u32		 status_seen;
> -		size_t		 file_size;
> -		struct list_head open_entry;
> -		u64		 debug_frame_offset;
> -		u64		 eh_frame_hdr_offset;
> -	} data;
> +	union {
> +		/* dso data file */
> +		struct {
> +			struct rb_root	 cache;
> +			int		 fd;
> +			int		 status;
> +			u32		 status_seen;
> +			size_t		 file_size;
> +			struct list_head open_entry;
> +			u64		 debug_frame_offset;
> +			u64		 eh_frame_hdr_offset;
> +		} data;
> +		/* bpf prog information */
> +		struct {
> +			u32		id;
> +			u32		sub_id;
> +			struct perf_env	*env;
> +		} bpf_prog;
> +	};
>=20
> 	union { /* Tool specific area */
> 		void	 *priv;
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 58442ca5e3c4..5cbad55cd99d 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1455,6 +1455,7 @@ static bool dso__is_compatible_symtab_type(struct d=
so *dso, bool kmod,
> 	case DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO:
> 		return true;
>=20
> +	case DSO_BINARY_TYPE__BPF_PROG_INFO:
> 	case DSO_BINARY_TYPE__NOT_FOUND:
> 	default:
> 		return false;

