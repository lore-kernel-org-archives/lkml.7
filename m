Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F199DC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9716E20700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="exfQARpU";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="CXQgTuhd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfDCQ2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:28:17 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53724 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726151AbfDCQ2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:28:17 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x33GJOoI031458;
        Wed, 3 Apr 2019 09:28:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=eNEE2ghkKTyP2GxLrTqrDAFQO3UuakxkwSrEHSzKEaE=;
 b=exfQARpUA2Y5i2/FWp90xKGG1EsInQv+j5ebf8+fA36mHfUcG0EsdPK7XE+rvWizqAMM
 3PGbpxVg9QkEJU9SPoVsmLA/5p5aj1+lPCHmmj7H/dq3wvlrR1BafZBe+1Y6br+cDweS
 Gwcuo5tavW3hUjBcEw5oQ9oGfS8saowaiNs= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rmw7srsfd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Apr 2019 09:28:00 -0700
Received: from prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 3 Apr 2019 09:27:58 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 3 Apr 2019 09:27:58 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 3 Apr 2019 09:27:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNEE2ghkKTyP2GxLrTqrDAFQO3UuakxkwSrEHSzKEaE=;
 b=CXQgTuhdwwq9q+0Mad9+9RCXKgCA5kz5tBMBMV/7jCdbyRVqi3V3+Qwjm2XlstlgDuX2Ps25/MgxLqa2Om4Z6QSp0bkigzAgWgdz4+6rCI/VUgddyC9Oz0a92CgxYo28a4x5rGLnejMrj5tlgMjiai89GTmR2ldbKUay0odFve4=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1598.namprd15.prod.outlook.com (10.173.235.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.13; Wed, 3 Apr 2019 16:27:56 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::5185:8137:2f1d:7171]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::5185:8137:2f1d:7171%2]) with mapi id 15.20.1750.017; Wed, 3 Apr 2019
 16:27:56 +0000
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
Thread-Index: AQHU6irWpD85AOHzLkautxj0S1Vk3aYqhcaAgAAGHwCAABQngA==
Date:   Wed, 3 Apr 2019 16:27:56 +0000
Message-ID: <B07CAAC3-D085-443D-BB0C-05E9A8F3AFB2@fb.com>
References: <20190403143738.GB32001@krava> <20190403145353.GE32553@kernel.org>
 <20190403151548.GF32553@kernel.org>
In-Reply-To: <20190403151548.GF32553@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:200::2:1b0d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4deb44d0-06e3-4300-08bc-08d6b8515434
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1598;
x-ms-traffictypediagnostic: MWHPR15MB1598:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <MWHPR15MB15985AD7C70634C8EE09BDC4B3570@MWHPR15MB1598.namprd15.prod.outlook.com>
x-forefront-prvs: 0996D1900D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(136003)(346002)(39860400002)(396003)(199004)(189003)(36756003)(25786009)(53936002)(6306002)(6512007)(71200400001)(71190400001)(5660300002)(83716004)(6246003)(97736004)(86362001)(6436002)(2906002)(68736007)(99286004)(4326008)(6486002)(50226002)(446003)(11346002)(229853002)(81166006)(8676002)(186003)(81156014)(256004)(14444005)(2616005)(316002)(6116002)(57306001)(8936002)(478600001)(305945005)(486006)(476003)(6506007)(54906003)(14454004)(966005)(102836004)(33656002)(53546011)(106356001)(7736002)(105586002)(82746002)(46003)(6916009)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1598;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SjZEK27DTYN4Qv4MOGty38Np0054iF4p9H+5tHv9rxvGsqPTB2xnvVWcWmUBK/7XfuKMwaXxoo4Qvau9Ldt+kZfGSbkvv9aZ/f780fr7E1N4cOviKZiavV5tbipDaH7ebQKghrbef+RKb1S8QRrYt+ww1Y6d33fKLxrlxNjFIhHHSDrzyd7W46ztPqSmW+y7Va0dNXEwaliE3j62AlLNMmRCzZ+md1p1gnwyurPfLkz51mJt9l/o3x/43S6Wxe3OxttePFRkqO8Hi580AhBM8TtXrgcHuC8FHkX8cCXe3IGJs36Fj+2glupjDkDq2Doy3FGGY61y+2Xb8xZnVg15CVpqLsnpMe4AiOauZr2fxPNXzLm/FbaQHXLPZIonK9GfFYsQfr3aRlDSs5XE5fdYGVgb6BdqXVsEoIfJYc5gjuY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5C828CCD417FFE419DAE72D30EFFB99D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4deb44d0-06e3-4300-08bc-08d6b8515434
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2019 16:27:56.1980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1598
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-03_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 3, 2019, at 8:15 AM, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.=
com> wrote:
>=20
> Em Wed, Apr 03, 2019 at 11:53:53AM -0300, Arnaldo Carvalho de Melo escrev=
eu:
>> Em Wed, Apr 03, 2019 at 04:37:38PM +0200, Jiri Olsa escreveu:
>>> hi,
>>> perf script --call-trace stop working for me recently,
>>> and displays only user space functions
>>>=20
>>> I bisected that to:
>>>  7b612e291a5a perf tools: Synthesize PERF_RECORD_* for loaded BPF progr=
ams
>>>=20
>>> data from following comands will display user space functions only:
>>>  # perf-with-kcore record pt -e intel_pt// -- ls
>>>  # perf-with-kcore script pt --call-trace
>>>=20
>>> when I disable the bpf synthesizing (patch below), kernel functions are=
 back
>>>=20
>>> I guess the new events mess up with intel_pt decoder somehow
>>=20
>> I.e. I'm adding the patch below to my perf/urgent branch.
>=20
> Song, that is what I have, can I have your Acked-by and please consider
> taking a look at the bug Jiri reported,
>=20
> Thanks,
>=20
> - Arnaldo

Current logic with --no-bpf-event is to generate PERF_RECORD_KSYMBOL, but n=
ot
PERF_RECORD_BPF_EVENT:

https://elixir.bootlin.com/linux/v5.1-rc3/source/tools/perf/util/bpf-event.=
c#L254

I will look into the intel_pt problem.=20

In the meanwhile, let's fix it for now.=20

Acked-by: Song Liu <songliubraving@fb.com>

Thanks,=20
Song


> commit 011318ccc2024ba03e96c32a06f74ca5d6ab5503
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Wed Apr 3 12:05:15 2019 -0300
>=20
>    perf record: Do not synthesize BPF records when --no-bpf-event is used
>=20
>    By default we synthesize and ask the kernel for BPF events, having a
>    --no-bpf-event option to disable that, which can be useful, for
>    instance, if there are still bugs in that code, which seems to be the
>    case as reported by Jiri Olsa in:
>=20
>      "[BUG] perf: intel_pt won't display kernel function"
>      https://lore.kernel.org/lkml/20190403143738.GB32001@krava
>=20
>    So add the check for record_opts.no_bpf_event when considering
>    synthesizing BPF events for pre-existing BPF programs in 'perf record'=
.
>=20
>    The reported bug needs further analysis and is a separate matter.
>=20
>    Cc: Adrian Hunter <adrian.hunter@intel.com>
>    Cc: Alexei Starovoitov <ast@kernel.org>
>    Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
>    Cc: Daniel Borkmann <daniel@iogearbox.net>
>    Cc: Jiri Olsa <jolsa@kernel.org>
>    Cc: Martin KaFai Lau <kafai@fb.com>
>    Cc: Namhyung Kim <namhyung@kernel.org>
>    Cc: Peter Zijlstra <peterz@infradead.org>
>    Cc: Song Liu <songliubraving@fb.com>
>    Cc: Yonghong Song <yhs@fb.com>
>    Fixes: 7b612e291a5a ("perf tools: Synthesize PERF_RECORD_* for loaded =
BPF programs")
>    Link: https://lore.kernel.org/lkml/20190403145353.GE32553@kernel.org
>    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 4e2d953d4bc5..17d772f192ad 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1114,10 +1114,11 @@ static int record__synthesize(struct record *rec,=
 bool tail)
> 		return err;
> 	}
>=20
> -	err =3D perf_event__synthesize_bpf_events(session, process_synthesized_=
event,
> -						machine, opts);
> -	if (err < 0)
> -		pr_warning("Couldn't synthesize bpf events.\n");
> +	if (!opts->no_bpf_event) {
> +		err =3D perf_event__synthesize_bpf_events(session, process_synthesized=
_event, machine, opts);
> +		if (err < 0)
> +			pr_warning("Couldn't synthesize bpf events.\n");
> +	}
>=20
> 	err =3D __machine__synthesize_threads(machine, tool, &opts->target, rec-=
>evlist->threads,
> 					    process_synthesized_event, opts->sample_address,

