Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BE2C04AAD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80781206BF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="UUMKtV5P";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="OuvE92r8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfEFVj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 17:39:27 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38404 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726046AbfEFVj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 17:39:26 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x46LMcvW030572;
        Mon, 6 May 2019 14:39:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=wCGwyONsuLpSnz5AgCakeXaeo8I033+OMSsNNBXhFG4=;
 b=UUMKtV5PDGF/B6Tc826Ab6bICCLbKYca6gRHyKi+IKUcjzvO3MUDsQOI9MZvtrYaLLqy
 bksvoyd72A/sI/eWQeIr+jkorwcqNBUzemFxD2ZUfeRRLNHSTEf53Lrbhdpd2jJ45XZ1
 2xqQDfwbH9ZSJqRf3vdHPbgOmc4Bcz127zw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2s96d9xksc-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 06 May 2019 14:39:08 -0700
Received: from ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) by
 ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 6 May 2019 14:38:58 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 6 May 2019 14:38:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCGwyONsuLpSnz5AgCakeXaeo8I033+OMSsNNBXhFG4=;
 b=OuvE92r8QA9wvUbw7URg7jQ6F0jzvTk1Lj7f1RUXypSpdMDjoS/eB4Sv6kvpT3JjpC5A33IgeYZRw+PIXtC9lL9v0lQGZM/odbmcGv8wonWOh7Xrd6872avikzLpPF7O+J5Dc96rJy/2g6bVqyCn2VSoDovF35fLXAxjh1A3/0Q=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1437.namprd15.prod.outlook.com (10.173.234.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Mon, 6 May 2019 21:38:56 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15%11]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 21:38:56 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 07/12] perf script: Pad dso name for --call-trace
Thread-Topic: [PATCH 07/12] perf script: Pad dso name for --call-trace
Thread-Index: AQHVAYjr0qNMvZQyn0Whx89yRppmGaZepSIA
Date:   Mon, 6 May 2019 21:38:55 +0000
Message-ID: <8385E7AF-756B-4113-9388-BD81D0F58374@fb.com>
References: <20190503081841.1908-1-jolsa@kernel.org>
 <20190503081841.1908-8-jolsa@kernel.org>
In-Reply-To: <20190503081841.1908-8-jolsa@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:200::1:f96e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3f9e4f7-6752-4b90-7fe0-08d6d26b3dd9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1437;
x-ms-traffictypediagnostic: MWHPR15MB1437:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR15MB1437E98F321C60AD016B8F88B3300@MWHPR15MB1437.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:243;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(376002)(346002)(396003)(366004)(189003)(199004)(99286004)(6916009)(6436002)(5660300002)(486006)(68736007)(229853002)(102836004)(6486002)(4326008)(86362001)(76176011)(6246003)(316002)(256004)(7736002)(54906003)(53936002)(53546011)(305945005)(82746002)(8936002)(81156014)(6506007)(478600001)(476003)(2906002)(14454004)(2616005)(6512007)(81166006)(57306001)(6306002)(11346002)(66446008)(64756008)(25786009)(71200400001)(71190400001)(966005)(66556008)(446003)(46003)(6116002)(36756003)(66476007)(73956011)(66946007)(8676002)(76116006)(33656002)(83716004)(186003)(7416002)(50226002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1437;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ImB5P1TACHkjk/h8sSJdC7ye2CS3ZlvM3FLa6CscII9aErIqjPZ2nerAWZMhrPATFEHIvB9A+TAslnbC0fjCmMro53LU87piCT4uY9LbIblgzan6El/LvK6rQUIu3+1Ws+SsK5ktSQesWsJZEt/4ey8GVlnbAwFLbCtjtQk2bcQ7XJY58CCMNyw2LRCxr0It8+dZeS9jdcc8XbNiNe9uF1OKucBVdvmJAY532v7Wk4a/fcC/4WCWHxo1laMrjxtJnQPMnA3YgzEbUUPDnvs8Bygl+was+f0AW+Po5snm1B+5XyFBachIZGAATlLz6cQDjJwEdpJ+Ax55Q/s8MIpAbgzZISguGYIlkMarLofcC/ZPjMVHB6m3lBardHOFqMud5rWlt+Mzn/el2xQVB2J/YbePUCpiXq4EYd77oTnraho=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <005008AB34FA934395AA0AF6B0D15FDF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f9e4f7-6752-4b90-7fe0-08d6d26b3dd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 21:38:55.8450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1437
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-06_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905060168
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 3, 2019, at 1:18 AM, Jiri Olsa <jolsa@kernel.org> wrote:
>=20
> Padding dso name for --call-trace so we don't have the
> indent screwed by different dso name lengths, as now
> for kernel there's also bpf code displayed.
>=20
>  # perf-with-kcore record pt -e intel_pt//ku -- sleep 1
>  # perf-core/perf-with-kcore script pt --call-trace
>=20
> Before:
>           sleep 36660 [016] 1057036.806464404: ([kernel.kallsyms])       =
                           kretprobe_perf_func
>           sleep 36660 [016] 1057036.806464404: ([kernel.kallsyms])       =
                               trace_call_bpf
>           sleep 36660 [016] 1057036.806464404: ([kernel.kallsyms])       =
                                   __x86_indirect_thunk_rax
>           sleep 36660 [016] 1057036.806464404: ([kernel.kallsyms])       =
                                       __x86_indirect_thunk_rax
>           sleep 36660 [016] 1057036.806464725: (bpf_prog_da4fe6b3d2c29b25=
_trace_return)                                                     bpf_get_=
current_pid_tgid
>           sleep 36660 [016] 1057036.806464725: (bpf_prog_da4fe6b3d2c29b25=
_trace_return)                                                     bpf_ktim=
e_get_ns
>           sleep 36660 [016] 1057036.806464725: ([kernel.kallsyms])       =
                                               __x86_indirect_thunk_rax
>           sleep 36660 [016] 1057036.806464725: ([kernel.kallsyms])       =
                                                   __x86_indirect_thunk_rax
>           sleep 36660 [016] 1057036.806465045: (bpf_prog_da4fe6b3d2c29b25=
_trace_return)                                                     __htab_m=
ap_lookup_elem
>           sleep 36660 [016] 1057036.806465366: ([kernel.kallsyms])       =
                                               memcmp
>           sleep 36660 [016] 1057036.806465687: (bpf_prog_da4fe6b3d2c29b25=
_trace_return)                                                     bpf_prob=
e_read
>           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms])       =
                                               probe_kernel_read
>           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms])       =
                                                   __check_object_size
>           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms])       =
                                                       check_stack_object
>           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms])       =
                                                   copy_user_enhanced_fast_=
string
>           sleep 36660 [016] 1057036.806465687: (bpf_prog_da4fe6b3d2c29b25=
_trace_return)                                                     bpf_prob=
e_read
>           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms])       =
                                               probe_kernel_read
>           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms])       =
                                                   __check_object_size
>           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms])       =
                                                       check_stack_object
>           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms])       =
                                                   copy_user_enhanced_fast_=
string
>           sleep 36660 [016] 1057036.806466008: (bpf_prog_da4fe6b3d2c29b25=
_trace_return)                                                     bpf_get_=
current_uid_gid
>           sleep 36660 [016] 1057036.806466008: ([kernel.kallsyms])       =
                                               from_kgid
>           sleep 36660 [016] 1057036.806466008: ([kernel.kallsyms])       =
                                               from_kuid
>           sleep 36660 [016] 1057036.806466008: (bpf_prog_da4fe6b3d2c29b25=
_trace_return)                                                     bpf_perf=
_event_output
>           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms])       =
                                               perf_event_output
>           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms])       =
                                                   perf_prepare_sample
>           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms])       =
                                                       perf_misc_flags
>           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms])       =
                                                           __x86_indirect_t=
hunk_rax
>           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms])       =
                                                               __x86_indire=
ct_thunk_rax
>           sleep 36660 [016] 1057036.806466328: ([kvm])                   =
                                               kvm_is_in_guest
>           sleep 36660 [016] 1057036.806466649: ([kernel.kallsyms])       =
                                                       __perf_event_header_=
_init_id.isra.0
>           sleep 36660 [016] 1057036.806466649: ([kernel.kallsyms])       =
                                                   perf_output_begin
>=20
> After:
>           sleep 36660 [016] 1057036.806464404: ([kernel.kallsyms]        =
               )                kretprobe_perf_func
>           sleep 36660 [016] 1057036.806464404: ([kernel.kallsyms]        =
               )                    trace_call_bpf
>           sleep 36660 [016] 1057036.806464404: ([kernel.kallsyms]        =
               )                        __x86_indirect_thunk_rax
>           sleep 36660 [016] 1057036.806464404: ([kernel.kallsyms]        =
               )                            __x86_indirect_thunk_rax
>           sleep 36660 [016] 1057036.806464725: (bpf_prog_da4fe6b3d2c29b25=
_trace_return  )                                bpf_get_current_pid_tgid
>           sleep 36660 [016] 1057036.806464725: (bpf_prog_da4fe6b3d2c29b25=
_trace_return  )                                bpf_ktime_get_ns
>           sleep 36660 [016] 1057036.806464725: ([kernel.kallsyms]        =
               )                                    __x86_indirect_thunk_ra=
x
>           sleep 36660 [016] 1057036.806464725: ([kernel.kallsyms]        =
               )                                        __x86_indirect_thun=
k_rax
>           sleep 36660 [016] 1057036.806465045: (bpf_prog_da4fe6b3d2c29b25=
_trace_return  )                                __htab_map_lookup_elem
>           sleep 36660 [016] 1057036.806465366: ([kernel.kallsyms]        =
               )                                    memcmp
>           sleep 36660 [016] 1057036.806465687: (bpf_prog_da4fe6b3d2c29b25=
_trace_return  )                                bpf_probe_read
>           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]        =
               )                                    probe_kernel_read
>           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]        =
               )                                        __check_object_size
>           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]        =
               )                                            check_stack_obj=
ect
>           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]        =
               )                                        copy_user_enhanced_=
fast_string
>           sleep 36660 [016] 1057036.806465687: (bpf_prog_da4fe6b3d2c29b25=
_trace_return  )                                bpf_probe_read
>           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]        =
               )                                    probe_kernel_read
>           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]        =
               )                                        __check_object_size
>           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]        =
               )                                            check_stack_obj=
ect
>           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]        =
               )                                        copy_user_enhanced_=
fast_string
>           sleep 36660 [016] 1057036.806466008: (bpf_prog_da4fe6b3d2c29b25=
_trace_return  )                                bpf_get_current_uid_gid
>           sleep 36660 [016] 1057036.806466008: ([kernel.kallsyms]        =
               )                                    from_kgid
>           sleep 36660 [016] 1057036.806466008: ([kernel.kallsyms]        =
               )                                    from_kuid
>           sleep 36660 [016] 1057036.806466008: (bpf_prog_da4fe6b3d2c29b25=
_trace_return  )                                bpf_perf_event_output
>           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms]        =
               )                                    perf_event_output
>           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms]        =
               )                                        perf_prepare_sample
>           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms]        =
               )                                            perf_misc_flags
>           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms]        =
               )                                                __x86_indir=
ect_thunk_rax
>           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms]        =
               )                                                    __x86_i=
ndirect_thunk_rax
>=20
> Link: http://lkml.kernel.org/n/tip-99g9rg4p20a1o99vr0nkjhq8@git.kernel.or=
g
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
> tools/include/linux/kernel.h  |  1 +
> tools/lib/vsprintf.c          | 19 +++++++++++++++++++
> tools/perf/builtin-script.c   |  1 +
> tools/perf/util/map.c         |  6 ++++++
> tools/perf/util/symbol_conf.h |  1 +
> 5 files changed, 28 insertions(+)
>=20
> diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
> index 857d9e22826e..cba226948a0c 100644
> --- a/tools/include/linux/kernel.h
> +++ b/tools/include/linux/kernel.h
> @@ -102,6 +102,7 @@
>=20
> int vscnprintf(char *buf, size_t size, const char *fmt, va_list args);
> int scnprintf(char * buf, size_t size, const char * fmt, ...);
> +int scnprintf_pad(char * buf, size_t size, const char * fmt, ...);
>=20
> #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array=
(arr))
>=20
> diff --git a/tools/lib/vsprintf.c b/tools/lib/vsprintf.c
> index e08ee147eab4..149a15013b23 100644
> --- a/tools/lib/vsprintf.c
> +++ b/tools/lib/vsprintf.c
> @@ -23,3 +23,22 @@ int scnprintf(char * buf, size_t size, const char * fm=
t, ...)
>=20
>        return (i >=3D ssize) ? (ssize - 1) : i;
> }
> +
> +int scnprintf_pad(char * buf, size_t size, const char * fmt, ...)
> +{
> +	ssize_t ssize =3D size;
> +	va_list args;
> +	int i;

nit: I guess we can avoid mixing int, ssize_t and size_t here?


> +
> +	va_start(args, fmt);
> +	i =3D vsnprintf(buf, size, fmt, args);
> +	va_end(args);
> +
> +	if (i < (int) size) {
> +		for (; i < (int) size; i++)
> +			buf[i] =3D ' ';
> +		buf[i] =3D 0x0;
> +	}
> +
> +	return (i >=3D ssize) ? (ssize - 1) : i;
> +}
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 61cfd8f70989..7adaa6c63a0b 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -3297,6 +3297,7 @@ static int parse_call_trace(const struct option *op=
t __maybe_unused,
> 	parse_output_fields(NULL, "-ip,-addr,-event,-period,+callindent", 0);
> 	itrace_parse_synth_opts(opt, "cewp", 0);
> 	symbol_conf.nanosecs =3D true;
> +	symbol_conf.pad_output_len_dso =3D 50;
> 	return 0;
> }
>=20
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index ee71efb9db62..c3fbd6e556b0 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -405,6 +405,7 @@ size_t map__fprintf(struct map *map, FILE *fp)
>=20
> size_t map__fprintf_dsoname(struct map *map, FILE *fp)
> {
> +	char buf[PATH_MAX];

nit: PATH_MAX vs. 50 is a little weird.=20

> 	const char *dsoname =3D "[unknown]";
>=20
> 	if (map && map->dso) {
> @@ -414,6 +415,11 @@ size_t map__fprintf_dsoname(struct map *map, FILE *f=
p)
> 			dsoname =3D map->dso->name;
> 	}
>=20
> +	if (symbol_conf.pad_output_len_dso) {
> +		scnprintf_pad(buf, symbol_conf.pad_output_len_dso, "%s", dsoname);
> +		dsoname =3D buf;
> +	}
> +
> 	return fprintf(fp, "%s", dsoname);
> }
>=20
> diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.=
h
> index 6c55fa6fccec..382ba63fc554 100644
> --- a/tools/perf/util/symbol_conf.h
> +++ b/tools/perf/util/symbol_conf.h
> @@ -69,6 +69,7 @@ struct symbol_conf {
> 			*tid_list;
> 	const char	*symfs;
> 	int		res_sample;
> +	int		pad_output_len_dso;
> };
>=20
> extern struct symbol_conf symbol_conf;
> --=20
> 2.20.1
>=20

