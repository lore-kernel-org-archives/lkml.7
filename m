Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA50AC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990B8206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="LDHV9l/S";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ZWs/nwXM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbfDCVsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 17:48:40 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37570 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726245AbfDCVsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 17:48:40 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x33LfxVl018301;
        Wed, 3 Apr 2019 14:48:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=iNgWG+6CS6fYV1AURhgxZPP6rfJad7frnN2THDs3Dik=;
 b=LDHV9l/S++BOQ2+CYc0L+gYHYzDCubxKX9ELoqn8slUWrEbTlsZYd6YI56nUDVYE4qfe
 8HsQox5mvoXEJL6VyeJLcqA0g2XVPBqEBe2SClEsRJLwPi3IHedTQuWpMomAO5ZQ1SWo
 L+C2qolQjMdGwc46u7NwgDaxwJWACt9y0Uk= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2rn2rjrh2a-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Apr 2019 14:48:27 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 3 Apr 2019 14:48:25 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 3 Apr 2019 14:48:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNgWG+6CS6fYV1AURhgxZPP6rfJad7frnN2THDs3Dik=;
 b=ZWs/nwXMAsleOFycFRCXwSIvCzDMzGxhIxtjtbJptOo/pjXUpo/LLs9P97QFw/6YUs4iDx0TLzaMeJYh94EwZgxEIGnH8smJrS15BJkr5L56UESAYpZSRvxfRB8vvF6+vYGA1RwmOjTstUu72uncIoSdYVtdNeUpz5emhn8Kl2w=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1629.namprd15.prod.outlook.com (10.175.135.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.16; Wed, 3 Apr 2019 21:48:24 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::5185:8137:2f1d:7171]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::5185:8137:2f1d:7171%2]) with mapi id 15.20.1750.017; Wed, 3 Apr 2019
 21:48:24 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [BUG] perf: intel_pt won't display kernel function
Thread-Topic: [BUG] perf: intel_pt won't display kernel function
Thread-Index: AQHU6irWpD85AOHzLkautxj0S1Vk3aYqhcaAgAAGHwCAABQngIAAJ/GAgAABOgCAAAFHAIAALxYA
Date:   Wed, 3 Apr 2019 21:48:23 +0000
Message-ID: <A476B82A-4550-45F1-9A31-B1AA63C07489@fb.com>
References: <20190403143738.GB32001@krava> <20190403145353.GE32553@kernel.org>
 <20190403151548.GF32553@kernel.org>
 <B07CAAC3-D085-443D-BB0C-05E9A8F3AFB2@fb.com>
 <20190403185053.GH32553@kernel.org>
 <124332A9-146A-446F-A82A-910C8319170E@fb.com>
 <425141B8-8908-4D48-90FD-8806BA9E9E12@fb.com>
In-Reply-To: <425141B8-8908-4D48-90FD-8806BA9E9E12@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:200::2:1b0d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd9efdf0-984f-4ceb-e804-08d6b87e18cb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR15MB1629;
x-ms-traffictypediagnostic: MWHPR15MB1629:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <MWHPR15MB1629F4A17E114BA438A0901BB3570@MWHPR15MB1629.namprd15.prod.outlook.com>
x-forefront-prvs: 0996D1900D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(366004)(396003)(136003)(199004)(189003)(71190400001)(71200400001)(6306002)(76176011)(8676002)(446003)(186003)(83716004)(4326008)(6506007)(7736002)(93886005)(53936002)(2616005)(6916009)(33656002)(86362001)(81166006)(6246003)(105586002)(966005)(54906003)(6436002)(316002)(2906002)(6512007)(68736007)(102836004)(229853002)(6486002)(50226002)(99286004)(14454004)(106356001)(25786009)(11346002)(53546011)(8936002)(478600001)(97736004)(6116002)(36756003)(476003)(57306001)(46003)(81156014)(5660300002)(82746002)(486006)(305945005)(256004)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1629;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tc/w4P2QmiHegb6evQ2e6pEO4fP2OxLGIC41rPZqrG5lRCGuxfE+we/cHedUf3LLFl8pgEdn80eGO1LWB0w3mHGrnK5PslqHNwFYLSSLEp74162aZbgAL7HIuvfrPggH4wF08kXa3h1wf7E42uC3kGw/HMJJhHPKkQ8AquqFnqqixxnb8hhaJSZ/djuA8/eSJGV/i2CTOEfSnHG2zcMgZ3haXV/83wxRnzP7bcte8UhU2cmtdtSYO6DXGoGIpxl635U5go4UoCtJXGIg/SIW6BERjERu60aMrIQVSdD1P2Ku/7zUpGjeemhquxlvoVCXDd9blCTNpeSdAUPKcdbx/TgQuC95cvJSvYyuT0aqGs1x09u4aDUSx9FTzcVCHDf3IBmc75L1YwasWKCq6mBgFWV5YW5zzfRi9DbActPS4tQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <607D4D0A113FD04184CF8887DE4327C0@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9efdf0-984f-4ceb-e804-08d6b87e18cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2019 21:48:23.8468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1629
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-03_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 3, 2019, at 11:59 AM, Song Liu <songliubraving@fb.com> wrote:
>=20
>=20
>=20
>> On Apr 3, 2019, at 11:55 AM, Song Liu <songliubraving@fb.com> wrote:
>>=20
>>=20
>>=20
>>> On Apr 3, 2019, at 11:50 AM, Arnaldo Carvalho de Melo <arnaldo.melo@gma=
il.com> wrote:
>>>=20
>>> Em Wed, Apr 03, 2019 at 04:27:56PM +0000, Song Liu escreveu:
>>>>=20
>>>>=20
>>>>> On Apr 3, 2019, at 8:15 AM, Arnaldo Carvalho de Melo <arnaldo.melo@gm=
ail.com> wrote:
>>>>>=20
>>>>> Em Wed, Apr 03, 2019 at 11:53:53AM -0300, Arnaldo Carvalho de Melo es=
creveu:
>>>>>> Em Wed, Apr 03, 2019 at 04:37:38PM +0200, Jiri Olsa escreveu:
>>>>>>> hi,
>>>>>>> perf script --call-trace stop working for me recently,
>>>>>>> and displays only user space functions
>>>>>>>=20
>>>>>>> I bisected that to:
>>>>>>> 7b612e291a5a perf tools: Synthesize PERF_RECORD_* for loaded BPF pr=
ograms
>>>>>>>=20
>>>>>>> data from following comands will display user space functions only:
>>>>>>> # perf-with-kcore record pt -e intel_pt// -- ls
>>>>>>> # perf-with-kcore script pt --call-trace
>>>>>>>=20
>>>>>>> when I disable the bpf synthesizing (patch below), kernel functions=
 are back
>>>>>>>=20
>>>>>>> I guess the new events mess up with intel_pt decoder somehow
>>>>>>=20
>>>>>> I.e. I'm adding the patch below to my perf/urgent branch.
>>>>>=20
>>>>> Song, that is what I have, can I have your Acked-by and please consid=
er
>>>>> taking a look at the bug Jiri reported,
>>>>>=20
>>>>> Thanks,
>>>>>=20
>>>>> - Arnaldo
>>>>=20
>>>> Current logic with --no-bpf-event is to generate PERF_RECORD_KSYMBOL, =
but not
>>>> PERF_RECORD_BPF_EVENT:
>>>=20
>>> I see... The opts is done later, after querying the kernel for existing
>>> BPF programs so that at least the KSYMBOL ones can be generated. So I'l=
l
>>> keep it as is, no need for this patch.
>>>=20
>>>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__elixir.bootlin.=
com_linux_v5.1-2Drc3_source_tools_perf_util_bpf-2Devent.c-23L254&d=3DDwIBAg=
&c=3D5VD0RTtNlTh3ycd41b3MUw&r=3DdR8692q0_uaizy0jkrBJQM5k2hfm4CiFxYT8KaysFrg=
&m=3D8ITYgIrqFBIy1uQFQPHrsX5kBX5RlmhwcknKYJa2eGs&s=3DMdB2zA9JstwC93qKEonsfT=
QeQYiw-yeOLbPxm3QMRo8&e=3D
>>>>=20
>>>> I will look into the intel_pt problem.=20
>>>=20
>>> Ok.
>>>=20
>>>> In the meanwhile, let's fix it for now.=20
>>>=20
>>> I'll wait a bit.
>>=20
>> I guess something like this might be a better fix? (Sorry for missing=20
>> commit message):
>>=20
>> diff --git i/tools/perf/util/map.c w/tools/perf/util/map.c
>> index e32628cd20a7..741430a35dca 100644
>> --- i/tools/perf/util/map.c
>> +++ w/tools/perf/util/map.c
>> @@ -261,6 +261,12 @@ bool __map__is_extra_kernel_map(const struct map *m=
ap)
>>       return kmap && kmap->name[0];
>> }
>>=20
>> +bool __map__is_bpf_prog(const struct map *map)
>> +{
>> +       const char *name =3D map->dso->short_name;
>> +       return name && (strstr(name, "bpf_prog_") =3D=3D name);
>> +}
>> +
>> bool map__has_symbols(const struct map *map)
>> {
>>       return dso__has_symbols(map->dso);
>> diff --git i/tools/perf/util/map.h w/tools/perf/util/map.h
>> index 0e20749f2c55..01079f1f4375 100644
>> --- i/tools/perf/util/map.h
>> +++ w/tools/perf/util/map.h
>> @@ -159,10 +159,12 @@ int map__set_kallsyms_ref_reloc_sym(struct map *ma=
p, const char *symbol_name,
>>=20
>> bool __map__is_kernel(const struct map *map);
>> bool __map__is_extra_kernel_map(const struct map *map);
>> +bool __map__is_bpf_prog(const struct map *map);
>>=20
>> static inline bool __map__is_kmodule(const struct map *map)
>> {
>> -       return !__map__is_kernel(map) && !__map__is_extra_kernel_map(map=
);
>> +       return !__map__is_kernel(map) && !__map__is_extra_kernel_map(map=
) &&
>> +               !__map__is_bpf_prog(map);
>> }
>>=20
>> bool map__has_symbols(const struct map *map);
>>=20
>> Thanks,
>> Song
>=20
> Actually, it should be something like this:
>=20
> diff --git i/tools/perf/util/map.c w/tools/perf/util/map.c
> index e32628cd20a7..31cd23612529 100644
> --- i/tools/perf/util/map.c
> +++ w/tools/perf/util/map.c
> @@ -261,6 +261,11 @@ bool __map__is_extra_kernel_map(const struct map *ma=
p)
>        return kmap && kmap->name[0];
> }
>=20
> +bool __map__is_bpf_prog(const struct map *map)
> +{
> +       return map->dso->binary_type =3D=3D DSO_BINARY_TYPE__BPF_PROG_INF=
O;
> +}
> +
> bool map__has_symbols(const struct map *map)
> {
>        return dso__has_symbols(map->dso);
> diff --git i/tools/perf/util/map.h w/tools/perf/util/map.h
> index 0e20749f2c55..01079f1f4375 100644
> --- i/tools/perf/util/map.h
> +++ w/tools/perf/util/map.h
> @@ -159,10 +159,12 @@ int map__set_kallsyms_ref_reloc_sym(struct map *map=
, const char *symbol_name,
>=20
> bool __map__is_kernel(const struct map *map);
> bool __map__is_extra_kernel_map(const struct map *map);
> +bool __map__is_bpf_prog(const struct map *map);
>=20
> static inline bool __map__is_kmodule(const struct map *map)
> {
> -       return !__map__is_kernel(map) && !__map__is_extra_kernel_map(map)=
;
> +       return !__map__is_kernel(map) && !__map__is_extra_kernel_map(map)=
 &&
> +               !__map__is_bpf_prog(map);
> }
>=20
> bool map__has_symbols(const struct map *map);
>=20
>=20
>>=20
>>>=20
>>>> Acked-by: Song Liu <songliubraving@fb.com>
>>>>=20
>>>> Thanks,=20
>>>> Song
>>>>=20
>>>>=20
>>>>> commit 011318ccc2024ba03e96c32a06f74ca5d6ab5503
>>>>> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
>>>>> Date:   Wed Apr 3 12:05:15 2019 -0300
>>>>>=20
>>>>> perf record: Do not synthesize BPF records when --no-bpf-event is use=
d
>>>>>=20
>>>>> By default we synthesize and ask the kernel for BPF events, having a
>>>>> --no-bpf-event option to disable that, which can be useful, for
>>>>> instance, if there are still bugs in that code, which seems to be the
>>>>> case as reported by Jiri Olsa in:
>>>>>=20
>>>>>   "[BUG] perf: intel_pt won't display kernel function"
>>>>>   https://lore.kernel.org/lkml/20190403143738.GB32001@krava
>>>>>=20
>>>>> So add the check for record_opts.no_bpf_event when considering
>>>>> synthesizing BPF events for pre-existing BPF programs in 'perf record=
'.
>>>>>=20
>>>>> The reported bug needs further analysis and is a separate matter.
>>>>>=20
>>>>> Cc: Adrian Hunter <adrian.hunter@intel.com>
>>>>> Cc: Alexei Starovoitov <ast@kernel.org>
>>>>> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
>>>>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>>>>> Cc: Jiri Olsa <jolsa@kernel.org>
>>>>> Cc: Martin KaFai Lau <kafai@fb.com>
>>>>> Cc: Namhyung Kim <namhyung@kernel.org>
>>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>>> Cc: Song Liu <songliubraving@fb.com>
>>>>> Cc: Yonghong Song <yhs@fb.com>
>>>>> Fixes: 7b612e291a5a ("perf tools: Synthesize PERF_RECORD_* for loaded=
 BPF programs")
>>>>> Link: https://lore.kernel.org/lkml/20190403145353.GE32553@kernel.org
>>>>> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>>>>>=20
>>>>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.=
c
>>>>> index 4e2d953d4bc5..17d772f192ad 100644
>>>>> --- a/tools/perf/builtin-record.c
>>>>> +++ b/tools/perf/builtin-record.c
>>>>> @@ -1114,10 +1114,11 @@ static int record__synthesize(struct record *=
rec, bool tail)
>>>>> 		return err;
>>>>> 	}
>>>>>=20
>>>>> -	err =3D perf_event__synthesize_bpf_events(session, process_synthesi=
zed_event,
>>>>> -						machine, opts);
>>>>> -	if (err < 0)
>>>>> -		pr_warning("Couldn't synthesize bpf events.\n");
>>>>> +	if (!opts->no_bpf_event) {
>>>>> +		err =3D perf_event__synthesize_bpf_events(session, process_synthes=
ized_event, machine, opts);
>>>>> +		if (err < 0)
>>>>> +			pr_warning("Couldn't synthesize bpf events.\n");
>>>>> +	}
>>>>>=20
>>>>> 	err =3D __machine__synthesize_threads(machine, tool, &opts->target, =
rec->evlist->threads,
>>>>> 					    process_synthesized_event, opts->sample_address,
>>>=20
>>> --=20
>>>=20
>>> - Arnaldo

Yet another version, with commit message and a little more logic:


From 8c842b52905e747487447a014cef8c98d0db94ef Mon Sep 17 00:00:00 2001
From: Song Liu <songliubraving@fb.com>
Date: Wed, 3 Apr 2019 14:24:02 -0700
Subject: [PATCH] perf util: check maps for bpf programs

As reported by Jiri Olsa in:

  "[BUG] perf: intel_pt won't display kernel function"
  https://lore.kernel.org/lkml/20190403143738.GB32001@krava

Recent changes to support PERF_RECORD_KSYMBOL and PERF_RECORD_BPF_EVENT
broke --kallsyms option. This is because it broke test __map__is_kmodule.

This patch fixes this by adding check for bpf program, so that these maps
are not mistaken as kernel modules.

Reported-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Fixes: 76193a94522f ("perf, bpf: Introduce PERF_RECORD_KSYMBOL")
Link: https://lore.kernel.org/lkml/20190403145353.GE32553@kernel.org

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/perf/util/map.c | 16 ++++++++++++++++
 tools/perf/util/map.h |  4 +++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index e32628cd20a7..28d484ef74ae 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -261,6 +261,22 @@ bool __map__is_extra_kernel_map(const struct map *map)
        return kmap && kmap->name[0];
 }

+bool __map__is_bpf_prog(const struct map *map)
+{
+       const char *name;
+
+       if (map->dso->binary_type =3D=3D DSO_BINARY_TYPE__BPF_PROG_INFO)
+               return true;
+
+       /*
+        * If PERF_RECORD_BPF_EVENT is not included, the dso will not have
+        * type of DSO_BINARY_TYPE__BPF_PROG_INFO. In such cases, we can
+        * guess the type based on name.
+        */
+       name =3D map->dso->short_name;
+       return name && (strstr(name, "bpf_prog_") =3D=3D name);
+}
+
 bool map__has_symbols(const struct map *map)
 {
        return dso__has_symbols(map->dso);
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 0e20749f2c55..01079f1f4375 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -159,10 +159,12 @@ int map__set_kallsyms_ref_reloc_sym(struct map *map, =
const char *symbol_name,

 bool __map__is_kernel(const struct map *map);
 bool __map__is_extra_kernel_map(const struct map *map);
+bool __map__is_bpf_prog(const struct map *map);

 static inline bool __map__is_kmodule(const struct map *map)
 {
-       return !__map__is_kernel(map) && !__map__is_extra_kernel_map(map);
+       return !__map__is_kernel(map) && !__map__is_extra_kernel_map(map) &=
&
+               !__map__is_bpf_prog(map);
 }

 bool map__has_symbols(const struct map *map);
--
2.17.1





