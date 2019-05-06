Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F04DC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43BFA206BF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="DX2yqpaP";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="O6BNz4MK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfEFVmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 17:42:55 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37016 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726046AbfEFVmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 17:42:54 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x46LcwX7001836;
        Mon, 6 May 2019 14:42:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=RyI0X0SC5fVgdMTB+C1DmXTCHKAkDNqMUW96cyWTESM=;
 b=DX2yqpaPD1B2EauQ0KMCwWzG3PpnaCOsnTkAcJUpivt4QDEvIWdbQ1qlEZrAo3SyuWr9
 cNRRxw8rfQ0fahEC/iMScurWRRrfPUOa+7W/OyKcQQMdUxVN2Cu2jh21st2SonimBDgd
 DTkWRmg7QUTKHbxtohKr4erPRtYdD6t1uio= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2sapwj9d6j-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 06 May 2019 14:42:47 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 6 May 2019 14:42:46 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 6 May 2019 14:42:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyI0X0SC5fVgdMTB+C1DmXTCHKAkDNqMUW96cyWTESM=;
 b=O6BNz4MKkpJIrDdAFsHNW9fmiuJ9hLPzffCWuXPc3c5/JXQuMnw1hpNzv1RtDOiopOTaBuLmIbeAeacbZJzQgLgP2vL1IEarHih0rg8bt5rwOphRTnXalg/QbMcsKltrF6v4N41SwLsudmJcxtNsUEKdwyh152r+TICiGHxIFPo=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1168.namprd15.prod.outlook.com (10.175.2.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Mon, 6 May 2019 21:42:44 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15%11]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 21:42:44 +0000
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
Subject: Re: [PATCH 10/12] perf script: Add --show-bpf-events to show eBPF
 related events
Thread-Topic: [PATCH 10/12] perf script: Add --show-bpf-events to show eBPF
 related events
Thread-Index: AQHVAYjsPKaReDoEBUq8afl3BMwJgKZepjOA
Date:   Mon, 6 May 2019 21:42:44 +0000
Message-ID: <7A338906-850D-430B-A558-93C409A03842@fb.com>
References: <20190503081841.1908-1-jolsa@kernel.org>
 <20190503081841.1908-11-jolsa@kernel.org>
In-Reply-To: <20190503081841.1908-11-jolsa@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:200::1:f96e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4104a36-fe40-42af-300c-08d6d26bc616
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1168;
x-ms-traffictypediagnostic: MWHPR15MB1168:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR15MB1168BD51D9549C74711C3BA3B3300@MWHPR15MB1168.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39860400002)(346002)(376002)(396003)(199004)(189003)(82746002)(99286004)(33656002)(76116006)(66946007)(486006)(5660300002)(54906003)(316002)(66476007)(66556008)(83716004)(71200400001)(71190400001)(64756008)(66446008)(4326008)(57306001)(53936002)(14454004)(6306002)(36756003)(6512007)(25786009)(6246003)(256004)(478600001)(68736007)(966005)(46003)(6436002)(73956011)(11346002)(6486002)(8676002)(81166006)(476003)(446003)(2616005)(50226002)(8936002)(81156014)(102836004)(86362001)(6916009)(305945005)(7736002)(53546011)(6506007)(229853002)(2906002)(186003)(7416002)(6116002)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1168;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xkyFdhjbZvSkgcOz6jB5/WAqPv0Ut4uCIemcP5QNBU/1Ev2+Aj0iqIfDP8246VnLFt0SVis0RJo0sNCyR3KSkcI/IuyVvHkKuwyMpDgQM84sNOPYiWjfd3yzsSW8zWJS3RNB1vCeVYg2Mohb1ygIhoELJ8kppfUyP8t6oAfMj+KTfy/r4mL5dP+Iswr0L7pOuDlzEAq4KvahSGZ3YQ1u5msJE2T+EFMZEpz85jjwdQ4SiJpZaJXMkmRLRXB4zVqjZCHU1aLXcRMgTron3HlxSFggpFbE6w8/LZNZpqXT4RzeJpekNdgAitXf394DAzCt2bJMzRIgKqOI9VAhgwaRifCWNumyVKesSdhxqqb3hpPeIfP+LRm5xLN5s2KndtqKJfr8C1fp2oTmpV2iICmlqAjSM8E6Hzz18jFMi2f9s6Y=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E2DB586638FD8B4C9E7041E14BA9D3EB@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e4104a36-fe40-42af-300c-08d6d26bc616
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 21:42:44.4118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1168
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-06_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 3, 2019, at 1:18 AM, Jiri Olsa <jolsa@kernel.org> wrote:
>=20
> Adding --show-bpf-events to show eBPF related events:
>  PERF_RECORD_KSYMBOL
>  PERF_RECORD_BPF_EVENT
>=20
> Usage:
>  # perf record -a
>  ...
>  # perf script --show-bpf-events
>  ...
>  swapper     0 [000]     0.000000: PERF_RECORD_KSYMBOL ksymbol event with=
 addr ffffffffc0ef971d len 229 type 1 flags 0x0 name bpf_prog_2a142ef67aaad=
174
>  swapper     0 [000]     0.000000: PERF_RECORD_BPF_EVENT bpf event with t=
ype 1, flags 0, id 36
>  ...
>=20
> Link: http://lkml.kernel.org/n/tip-9kvkcw7z4i1464jb7gasv4lb@git.kernel.or=
g
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
> tools/perf/Documentation/perf-script.txt |  3 ++
> tools/perf/builtin-script.c              | 42 ++++++++++++++++++++++++
> 2 files changed, 45 insertions(+)
>=20
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Docume=
ntation/perf-script.txt
> index 9b0d04dd2a61..af8282782911 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -313,6 +313,9 @@ OPTIONS
> --show-round-events
> 	Display finished round events i.e. events of type PERF_RECORD_FINISHED_R=
OUND.
>=20
> +--show-bpf-events
> +	Display bpf events i.e. events of type PERF_RECORD_KSYMBOL and PERF_REC=
ORD_BPF_EVENT.
> +
> --demangle::
> 	Demangle symbol names to human readable form. It's enabled by default,
> 	disable with --no-demangle.
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 7adaa6c63a0b..3a48a2627670 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -1606,6 +1606,7 @@ struct perf_script {
> 	bool			show_namespace_events;
> 	bool			show_lost_events;
> 	bool			show_round_events;
> +	bool			show_bpf_events;
> 	bool			allocated;
> 	bool			per_event_dump;
> 	struct cpu_map		*cpus;
> @@ -2318,6 +2319,41 @@ process_finished_round_event(struct perf_tool *too=
l __maybe_unused,
> 	return 0;
> }
>=20
> +static int
> +process_bpf_events(struct perf_tool *tool __maybe_unused,
> +		   union perf_event *event,
> +		   struct perf_sample *sample,
> +		   struct machine *machine)
> +{
> +	struct thread *thread;
> +	struct perf_script *script =3D container_of(tool, struct perf_script, t=
ool);
> +	struct perf_session *session =3D script->session;
> +	struct perf_evsel *evsel =3D perf_evlist__id2evsel(session->evlist, sam=
ple->id);
> +
> +	if (machine__process_ksymbol(machine, event, sample) < 0)
> +		return -1;
> +
> +	if (!evsel->attr.sample_id_all) {
> +		perf_event__fprintf(event, stdout);
> +		return 0;
> +	}
> +
> +	thread =3D machine__findnew_thread(machine, sample->pid, sample->tid);
> +	if (thread =3D=3D NULL) {
> +		pr_debug("problem processing MMAP event, skipping it.\n");
> +		return -1;
> +	}
> +
> +	if (!filter_cpu(sample)) {
> +		perf_sample__fprintf_start(sample, thread, evsel,
> +					   event->header.type, stdout);
> +		perf_event__fprintf(event, stdout);
> +	}
> +
> +	thread__put(thread);
> +	return 0;
> +}
> +
> static void sig_handler(int sig __maybe_unused)
> {
> 	session_done =3D 1;
> @@ -2420,6 +2456,10 @@ static int __cmd_script(struct perf_script *script=
)
> 		script->tool.ordered_events =3D false;
> 		script->tool.finished_round =3D process_finished_round_event;
> 	}
> +	if (script->show_bpf_events) {
> +		script->tool.ksymbol   =3D process_bpf_events;
> +		script->tool.bpf_event =3D process_bpf_events;

Why do we need both set to process_bpf_events?

Thanks,
Song

> +	}
>=20
> 	if (perf_script__setup_per_event_dump(script)) {
> 		pr_err("Couldn't create the per event dump files\n");
> @@ -3439,6 +3479,8 @@ int cmd_script(int argc, const char **argv)
> 		    "Show lost events (if recorded)"),
> 	OPT_BOOLEAN('\0', "show-round-events", &script.show_round_events,
> 		    "Show round events (if recorded)"),
> +	OPT_BOOLEAN('\0', "show-bpf-events", &script.show_bpf_events,
> +		    "Show bpf related events (if recorded)"),
> 	OPT_BOOLEAN('\0', "per-event-dump", &script.per_event_dump,
> 		    "Dump trace output to files named by the monitored events"),
> 	OPT_BOOLEAN('f', "force", &symbol_conf.force, "don't complain, do it"),
> --=20
> 2.20.1
>=20

