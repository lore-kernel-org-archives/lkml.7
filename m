Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E00C04AAD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A9920656
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="UjADh3rW";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="cwUki3qo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfEGS12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 14:27:28 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34868 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726476AbfEGS12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 14:27:28 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x47IIMnR000702;
        Tue, 7 May 2019 11:27:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=p6MHZQJCSxzUl8eHCn4JdxmSU/4PpOZgkABuJVSuq+Q=;
 b=UjADh3rWMvfakbPuZz6G3TMKgh/SZR3c1R8Jad810xvTdM8nizz2/hU5HwQzA/S4vcGX
 V+uquC7Z/PPNO8jiFCu268pz3RrYwtoiniJUrSvY7Tl2NE4ExgaQRbXq/Wv9gMz2CUh+
 1HzxwL3eL07pnyPU5gAgg031zcjLja5n57g= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2sbca38u20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 07 May 2019 11:27:19 -0700
Received: from ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) by
 ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 7 May 2019 11:27:18 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 7 May 2019 11:27:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6MHZQJCSxzUl8eHCn4JdxmSU/4PpOZgkABuJVSuq+Q=;
 b=cwUki3qogPecYZ1geGK+mBjttrDgGfmU7I+6hq65zJtcD66rqAdH8BEh1Eg0/XWOsLoLM3czLe4eAkYrBskwUZ2VGmwA8mwFkXA7bU7fDGQtqsiJ+lWvWh2meV0I+SgPt19gxhKa7BX+CzthtCTvLy1t4wwWkDRjyRX4IS3rL9A=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1213.namprd15.prod.outlook.com (10.175.2.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.15; Tue, 7 May 2019 18:27:16 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15%11]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 18:27:16 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 10/12] perf script: Add --show-bpf-events to show eBPF
 related events
Thread-Topic: [PATCH 10/12] perf script: Add --show-bpf-events to show eBPF
 related events
Thread-Index: AQHVAYjsPKaReDoEBUq8afl3BMwJgKZepjOAgACxfwCAAKo5gA==
Date:   Tue, 7 May 2019 18:27:15 +0000
Message-ID: <FD314B39-B909-46B8-B76B-22D6D7ADCA61@fb.com>
References: <20190503081841.1908-1-jolsa@kernel.org>
 <20190503081841.1908-11-jolsa@kernel.org>
 <7A338906-850D-430B-A558-93C409A03842@fb.com> <20190507081759.GB17416@krava>
In-Reply-To: <20190507081759.GB17416@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:200::2:3cfe]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c470e6d9-5615-40ff-819f-08d6d319a1b9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1213;
x-ms-traffictypediagnostic: MWHPR15MB1213:
x-microsoft-antispam-prvs: <MWHPR15MB1213A6D751F0D10790BCF495B3310@MWHPR15MB1213.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(136003)(366004)(396003)(51914003)(199004)(189003)(54906003)(6512007)(33656002)(81166006)(186003)(8676002)(8936002)(6916009)(305945005)(6506007)(82746002)(53546011)(99286004)(81156014)(25786009)(7736002)(76176011)(46003)(229853002)(68736007)(6486002)(486006)(14454004)(6436002)(4326008)(11346002)(446003)(5660300002)(476003)(2616005)(64756008)(57306001)(53936002)(6246003)(316002)(256004)(7416002)(478600001)(66946007)(73956011)(83716004)(76116006)(36756003)(102836004)(71190400001)(6116002)(2906002)(71200400001)(66476007)(86362001)(66446008)(66556008)(50226002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1213;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QlbRKkEsFiPZZ6i2N1QTxViIb3BNiSU7y0MYA3ZySM2959ToQLWL7jc12m+8pLwDdhvgyUO82Do7kdTm+QxwqPDk2TVv885d6MOamELVEj4pNkhAZZxmQmpXJGvLrC2Mcpioq6bKjs7jgm/hDIbnAWgsOqFq0SlO9Go+uHSp5BIDg+j/qK7qakXY1eYWommPzWNIgaOCLLgbjKI3sHKnS38O0EYKA664garFUMXBpxiCa0UpIeG+uCjvx5GyCP+1DPW7fbuWs1X/Fe35XN4jOrHXBhLPdiOvFbDndzilB2M6xjQ9ii6eylPt5YyFp0ROJ5oEqXA8PDRmlqKqp3ZkRpiNf98ZG56HUq1yG7fYr7zYNLyXHxHIvaQpFjJTwmzAomeap4e3nJTck9TaLQ61hQqUmJIqDSbcU2t5WqQeU3A=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C6C60A69A45A0448AD724BC9C7549574@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c470e6d9-5615-40ff-819f-08d6d319a1b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 18:27:15.8874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1213
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-07_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905070118
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 7, 2019, at 1:18 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Mon, May 06, 2019 at 09:42:44PM +0000, Song Liu wrote:
>=20
> SNIP
>=20
>>> +static int
>>> +process_bpf_events(struct perf_tool *tool __maybe_unused,
>>> +		   union perf_event *event,
>>> +		   struct perf_sample *sample,
>>> +		   struct machine *machine)
>>> +{
>>> +	struct thread *thread;
>>> +	struct perf_script *script =3D container_of(tool, struct perf_script,=
 tool);
>>> +	struct perf_session *session =3D script->session;
>>> +	struct perf_evsel *evsel =3D perf_evlist__id2evsel(session->evlist, s=
ample->id);
>>> +
>>> +	if (machine__process_ksymbol(machine, event, sample) < 0)
>>> +		return -1;
>>> +
>>> +	if (!evsel->attr.sample_id_all) {
>>> +		perf_event__fprintf(event, stdout);
>>> +		return 0;
>>> +	}
>>> +
>>> +	thread =3D machine__findnew_thread(machine, sample->pid, sample->tid)=
;
>>> +	if (thread =3D=3D NULL) {
>>> +		pr_debug("problem processing MMAP event, skipping it.\n");
>>> +		return -1;
>>> +	}
>>> +
>>> +	if (!filter_cpu(sample)) {
>>> +		perf_sample__fprintf_start(sample, thread, evsel,
>>> +					   event->header.type, stdout);
>>> +		perf_event__fprintf(event, stdout);
>>> +	}
>>> +
>>> +	thread__put(thread);
>>> +	return 0;
>>> +}
>>> +
>>> static void sig_handler(int sig __maybe_unused)
>>> {
>>> 	session_done =3D 1;
>>> @@ -2420,6 +2456,10 @@ static int __cmd_script(struct perf_script *scri=
pt)
>>> 		script->tool.ordered_events =3D false;
>>> 		script->tool.finished_round =3D process_finished_round_event;
>>> 	}
>>> +	if (script->show_bpf_events) {
>>> +		script->tool.ksymbol   =3D process_bpf_events;
>>> +		script->tool.bpf_event =3D process_bpf_events;
>>=20
>> Why do we need both set to process_bpf_events?
>=20
> --show-*-events option is there to display all the related events for giv=
en '*'
>=20
> we want to display both ksymbol and bpf_event in here,
> process_bpf_events takes care of it for both of them

I see. Thanks for the explanation!

Song

