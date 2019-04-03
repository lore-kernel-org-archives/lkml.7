Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAF8C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F622084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="XzPrmHM3";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="eqUBdEdZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfDCSzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:55:41 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33140 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726064AbfDCSzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 14:55:40 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x33It3Ul028647;
        Wed, 3 Apr 2019 11:55:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=66KeyoeJ1IUnJqXrfCcrT8gFBfjgN6uJZd0EHEPaEuw=;
 b=XzPrmHM3Fv7Qyh/r4NMAHFoH6km2t62Y4U8wKLNp99drzPiGxct461e1lsg8HHUt6oCY
 i3vKn8+IVP/LN9xkuh58rkWPxjx5zVTZABnHMejLhpO7WVttfyvyVUIkZUC3RNvP+Tmg
 aBRWxI3lGZxg+VzDEPbxTisuuKvVbM8eUYY= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rn1ejra7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Apr 2019 11:55:20 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 3 Apr 2019 11:55:20 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 3 Apr 2019 11:55:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66KeyoeJ1IUnJqXrfCcrT8gFBfjgN6uJZd0EHEPaEuw=;
 b=eqUBdEdZXpQrpdwm40vj1Cyjs5V8jEEI3jCimkOi31iVEL1n46ZZO/Syy+ZfhDpJ2U0K2pYnfaVhp725zfk3aGqBuVNuZPhOVxS2cWlcRN97qa7YXbd/y7nLuXoGXybHVf+Xdis04wFXUwjM3jeds+Zu3jli0cRmeY89zLbW2hU=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1824.namprd15.prod.outlook.com (10.174.255.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.16; Wed, 3 Apr 2019 18:55:17 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::5185:8137:2f1d:7171]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::5185:8137:2f1d:7171%2]) with mapi id 15.20.1750.017; Wed, 3 Apr 2019
 18:55:17 +0000
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
Thread-Index: AQHU6irWpD85AOHzLkautxj0S1Vk3aYqhcaAgAAGHwCAABQngIAAJ/GAgAABOgA=
Date:   Wed, 3 Apr 2019 18:55:17 +0000
Message-ID: <124332A9-146A-446F-A82A-910C8319170E@fb.com>
References: <20190403143738.GB32001@krava> <20190403145353.GE32553@kernel.org>
 <20190403151548.GF32553@kernel.org>
 <B07CAAC3-D085-443D-BB0C-05E9A8F3AFB2@fb.com>
 <20190403185053.GH32553@kernel.org>
In-Reply-To: <20190403185053.GH32553@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:200::2:1b0d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7daaf19-6254-4ee9-bbae-08d6b865ea13
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR15MB1824;
x-ms-traffictypediagnostic: MWHPR15MB1824:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <MWHPR15MB18241CD6A47A387BE44F0E8EB3570@MWHPR15MB1824.namprd15.prod.outlook.com>
x-forefront-prvs: 0996D1900D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(346002)(136003)(376002)(366004)(199004)(189003)(93886005)(476003)(256004)(316002)(83716004)(54906003)(2616005)(81166006)(71200400001)(478600001)(11346002)(71190400001)(68736007)(186003)(6916009)(6116002)(99286004)(46003)(14444005)(97736004)(8676002)(81156014)(8936002)(6486002)(57306001)(6436002)(486006)(50226002)(53936002)(102836004)(14454004)(305945005)(33656002)(25786009)(86362001)(7736002)(82746002)(229853002)(6246003)(6506007)(446003)(53546011)(106356001)(2906002)(5660300002)(36756003)(966005)(6306002)(6512007)(105586002)(4326008)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1824;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2O5XitZu83Dxxa44FtBlrEIRaDdKW6mdZRPVn38f5CKH+QSL6Zmqz3iUrfqClH6wpwKWYc60Zkj6XYtEDdx1Sz/EAbFrX76Is9kUDX1C0surlkni7zXsZU7tZrHJrHV1PLT5JXXGQ2xggxSOGTrrHQQdCZsC34WtVeRt4gQM09yCyf34n52TUeJvosRj0LKh7a1v8rB79Z6tWN+qhM6TAcvvX87fJI+nSJLUWnL25Ezn8k1CJKtTbVd/ivN3G6WkR7RJdSpd7MGg1h1SOwyEy5lKC065EXfwdccBqoQLRLC/dyK+Ws4eMpjOL2xVP4UU6SYfSJVCpCz5NzrwWhMOEOlzf9NUrks8HDLiOYdu9efYKH/wG1iyVhw3TKoopQe9SmuWUf0Ink2u3+g9FlBGnkrSlnrPwoSardDMZedek+0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8962A326788B914CBBA285216262A009@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c7daaf19-6254-4ee9-bbae-08d6b865ea13
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2019 18:55:17.5951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1824
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-03_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 3, 2019, at 11:50 AM, Arnaldo Carvalho de Melo <arnaldo.melo@gmail=
.com> wrote:
>=20
> Em Wed, Apr 03, 2019 at 04:27:56PM +0000, Song Liu escreveu:
>>=20
>>=20
>>> On Apr 3, 2019, at 8:15 AM, Arnaldo Carvalho de Melo <arnaldo.melo@gmai=
l.com> wrote:
>>>=20
>>> Em Wed, Apr 03, 2019 at 11:53:53AM -0300, Arnaldo Carvalho de Melo escr=
eveu:
>>>> Em Wed, Apr 03, 2019 at 04:37:38PM +0200, Jiri Olsa escreveu:
>>>>> hi,
>>>>> perf script --call-trace stop working for me recently,
>>>>> and displays only user space functions
>>>>>=20
>>>>> I bisected that to:
>>>>> 7b612e291a5a perf tools: Synthesize PERF_RECORD_* for loaded BPF prog=
rams
>>>>>=20
>>>>> data from following comands will display user space functions only:
>>>>> # perf-with-kcore record pt -e intel_pt// -- ls
>>>>> # perf-with-kcore script pt --call-trace
>>>>>=20
>>>>> when I disable the bpf synthesizing (patch below), kernel functions a=
re back
>>>>>=20
>>>>> I guess the new events mess up with intel_pt decoder somehow
>>>>=20
>>>> I.e. I'm adding the patch below to my perf/urgent branch.
>>>=20
>>> Song, that is what I have, can I have your Acked-by and please consider
>>> taking a look at the bug Jiri reported,
>>>=20
>>> Thanks,
>>>=20
>>> - Arnaldo
>>=20
>> Current logic with --no-bpf-event is to generate PERF_RECORD_KSYMBOL, bu=
t not
>> PERF_RECORD_BPF_EVENT:
>=20
> I see... The opts is done later, after querying the kernel for existing
> BPF programs so that at least the KSYMBOL ones can be generated. So I'll
> keep it as is, no need for this patch.
>=20
>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__elixir.bootlin.co=
m_linux_v5.1-2Drc3_source_tools_perf_util_bpf-2Devent.c-23L254&d=3DDwIBAg&c=
=3D5VD0RTtNlTh3ycd41b3MUw&r=3DdR8692q0_uaizy0jkrBJQM5k2hfm4CiFxYT8KaysFrg&m=
=3D8ITYgIrqFBIy1uQFQPHrsX5kBX5RlmhwcknKYJa2eGs&s=3DMdB2zA9JstwC93qKEonsfTQe=
QYiw-yeOLbPxm3QMRo8&e=3D
>>=20
>> I will look into the intel_pt problem.=20
>=20
> Ok.
>=20
>> In the meanwhile, let's fix it for now.=20
>=20
> I'll wait a bit.

I guess something like this might be a better fix? (Sorry for missing=20
commit message):

diff --git i/tools/perf/util/map.c w/tools/perf/util/map.c
index e32628cd20a7..741430a35dca 100644
--- i/tools/perf/util/map.c
+++ w/tools/perf/util/map.c
@@ -261,6 +261,12 @@ bool __map__is_extra_kernel_map(const struct map *map)
        return kmap && kmap->name[0];
 }

+bool __map__is_bpf_prog(const struct map *map)
+{
+       const char *name =3D map->dso->short_name;
+       return name && (strstr(name, "bpf_prog_") =3D=3D name);
+}
+
 bool map__has_symbols(const struct map *map)
 {
        return dso__has_symbols(map->dso);
diff --git i/tools/perf/util/map.h w/tools/perf/util/map.h
index 0e20749f2c55..01079f1f4375 100644
--- i/tools/perf/util/map.h
+++ w/tools/perf/util/map.h
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

Thanks,
Song

>=20
>> Acked-by: Song Liu <songliubraving@fb.com>
>>=20
>> Thanks,=20
>> Song
>>=20
>>=20
>>> commit 011318ccc2024ba03e96c32a06f74ca5d6ab5503
>>> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
>>> Date:   Wed Apr 3 12:05:15 2019 -0300
>>>=20
>>>   perf record: Do not synthesize BPF records when --no-bpf-event is use=
d
>>>=20
>>>   By default we synthesize and ask the kernel for BPF events, having a
>>>   --no-bpf-event option to disable that, which can be useful, for
>>>   instance, if there are still bugs in that code, which seems to be the
>>>   case as reported by Jiri Olsa in:
>>>=20
>>>     "[BUG] perf: intel_pt won't display kernel function"
>>>     https://lore.kernel.org/lkml/20190403143738.GB32001@krava
>>>=20
>>>   So add the check for record_opts.no_bpf_event when considering
>>>   synthesizing BPF events for pre-existing BPF programs in 'perf record=
'.
>>>=20
>>>   The reported bug needs further analysis and is a separate matter.
>>>=20
>>>   Cc: Adrian Hunter <adrian.hunter@intel.com>
>>>   Cc: Alexei Starovoitov <ast@kernel.org>
>>>   Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
>>>   Cc: Daniel Borkmann <daniel@iogearbox.net>
>>>   Cc: Jiri Olsa <jolsa@kernel.org>
>>>   Cc: Martin KaFai Lau <kafai@fb.com>
>>>   Cc: Namhyung Kim <namhyung@kernel.org>
>>>   Cc: Peter Zijlstra <peterz@infradead.org>
>>>   Cc: Song Liu <songliubraving@fb.com>
>>>   Cc: Yonghong Song <yhs@fb.com>
>>>   Fixes: 7b612e291a5a ("perf tools: Synthesize PERF_RECORD_* for loaded=
 BPF programs")
>>>   Link: https://lore.kernel.org/lkml/20190403145353.GE32553@kernel.org
>>>   Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>>>=20
>>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>>> index 4e2d953d4bc5..17d772f192ad 100644
>>> --- a/tools/perf/builtin-record.c
>>> +++ b/tools/perf/builtin-record.c
>>> @@ -1114,10 +1114,11 @@ static int record__synthesize(struct record *re=
c, bool tail)
>>> 		return err;
>>> 	}
>>>=20
>>> -	err =3D perf_event__synthesize_bpf_events(session, process_synthesize=
d_event,
>>> -						machine, opts);
>>> -	if (err < 0)
>>> -		pr_warning("Couldn't synthesize bpf events.\n");
>>> +	if (!opts->no_bpf_event) {
>>> +		err =3D perf_event__synthesize_bpf_events(session, process_synthesiz=
ed_event, machine, opts);
>>> +		if (err < 0)
>>> +			pr_warning("Couldn't synthesize bpf events.\n");
>>> +	}
>>>=20
>>> 	err =3D __machine__synthesize_threads(machine, tool, &opts->target, re=
c->evlist->threads,
>>> 					    process_synthesized_event, opts->sample_address,
>=20
> --=20
>=20
> - Arnaldo

