Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DE4C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 23:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF14214B2
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 23:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="dwtuIqir";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="RuvazoZo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbfKEXwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 18:52:55 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49848 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729583AbfKEXwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 18:52:55 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA5NhkRm006364;
        Tue, 5 Nov 2019 15:51:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=l0kuosIO2Pzlcp9CWU9EBRIg3imVKBKGPqcnGzQAuvY=;
 b=dwtuIqirfu2+SR8MbQ5ltWuCX51+PAebqtXJugP7lw0x8s2V9GE6akgtWxTle2FpdS3F
 RmYsj7pS1NiyrQx3PUDoHotd/cf2bk977lRFYy22eI4ajZCFLawKp+CwKDt6edde3hN6
 Y5ISBanFDY9fIi/uPUz1XovdNjql/say0BA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2w3awcu94p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 05 Nov 2019 15:51:45 -0800
Received: from ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) by
 ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 5 Nov 2019 15:51:44 -0800
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 5 Nov 2019 15:51:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzbjdYm7PmhRKRTH7nrYa+CBQtrE3MIc+VwedbM9nINALLweRzOXL9kVrIgVKb01qh1qbaUD0QtE5TtEU/hPHqIQHRR6fmLucSrza8fD66YWkYdg5M2vYPTKblJLLACSHpkdEugQpJj3O+Ou9qfA7K2TCCyXRSq1WNe8eWborQqgf18gCJEKITAhMecvrGtnhwrSTX2K0kGm4vnAfgtIFev3VKsMJVC+5uHS7y8rpV5J10aDbOtP1YihAdQbUQ6PUh0GXT/Z2TVYhCj272k4r01178UZ8ND4s6ok9ZJElx7FlEQo1Q43Qc4FO2NlqotZsp8ft89uNEsSYtm5O8Xpew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0kuosIO2Pzlcp9CWU9EBRIg3imVKBKGPqcnGzQAuvY=;
 b=VVbWZMCfsP25pl6zkffySTvv2Nb/Z44qMSnVSp2S7q9I6d54Rg4J6QfwrHyCS+MXSLRMR2A9V6xtbl0mzK55lyEC9Ff23+DNKpVy11R7vN95a2LcNNcC7ctfEtoe8IRYoVdezhhhPvYD7cPz3M82XrCHihum2Fjz9NtitmDErsqfyI/Qj4p9q51sWCkEVEFbU4l3X4gR0kVsxPXB08DPLjHT711Xw53YtKAa2k5dDAEEStNXVeu1ATaW3wfbX0Je/fifs9bjlb9Lbp0FU+/d6JPhxBAkQi4iXULwfgfa1O2MsjG7RcmednvxZ7ZLqHAWV7jTIiq3H88+8+kczfCwrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0kuosIO2Pzlcp9CWU9EBRIg3imVKBKGPqcnGzQAuvY=;
 b=RuvazoZoajNhZHl8Xs6mV4TsPqKufdKhraAXN4yosc8xrUklMocexLeqtDk/x5hvLE3QyNWF6fpnEjvcu4uISRpe9rGrVMA+fInooGhOsmGo1NniJOEBX0mwc3XZ4xS4drldwraxy84a3PfuZc7CmxAmd+KS0o5PT8R3lV54U+E=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1437.namprd15.prod.outlook.com (10.173.234.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 23:51:42 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5%5]) with mapi id 15.20.2430.020; Tue, 5 Nov 2019
 23:51:42 +0000
From:   Song Liu <songliubraving@fb.com>
To:     open list <linux-kernel@vger.kernel.org>
CC:     Kernel Team <Kernel-team@fb.com>,
        "acme@kernel.org" <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, "Tejun Heo" <tj@kernel.org>
Subject: Re: [PATCH v6] perf: Sharing PMU counters across compatible events
Thread-Topic: [PATCH v6] perf: Sharing PMU counters across compatible events
Thread-Index: AQHVbqpjjWjaDbp/ikSYoLFTNk8qM6d9ipyA
Date:   Tue, 5 Nov 2019 23:51:42 +0000
Message-ID: <FAD07921-FB10-4FDD-9A81-48300EE24F20@fb.com>
References: <20190919052314.2925604-1-songliubraving@fb.com>
In-Reply-To: <20190919052314.2925604-1-songliubraving@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3601.0.10)
x-originating-ip: [2620:10d:c090:200::de21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f911bc7e-1069-4350-ca51-08d7624b1bde
x-ms-traffictypediagnostic: MWHPR15MB1437:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB1437B1501381067226541851B37E0@MWHPR15MB1437.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(376002)(366004)(39860400002)(189003)(199004)(81156014)(64756008)(99286004)(486006)(66556008)(25786009)(4326008)(5024004)(5660300002)(256004)(81166006)(8936002)(50226002)(6916009)(14444005)(71200400001)(229853002)(6436002)(305945005)(7736002)(478600001)(2906002)(6512007)(2616005)(6486002)(14454004)(476003)(186003)(33656002)(71190400001)(6246003)(66946007)(8676002)(11346002)(446003)(54906003)(102836004)(53546011)(6506007)(76176011)(6116002)(36756003)(86362001)(66476007)(46003)(66446008)(76116006)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1437;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zwmIV6JTQahoWOwx+/tR8saRsSTylVQGI8cQcw540VUuUFmQF8QGsbqstSxp04qJnsU9Bx6fcylEzB16BwwEXvUKafEnN4970H3C7pHn2Vw8xoPtYBVKCgqRrQ4xHg8l6Myc6/LSF+4Z3Dlmy9aFkJr+mWt1vaD+NIPAj13ANoea4sLswBPcrrIadTjU7t2ew/DJbE33ms91jh5wDNYVWM/TLP5fL4nNcOIOCOOoHt+JNE6iYLQ8GjtPCWBJRYUQL6IKN2myZT56O/qSUVtUPOEQ4xw0X6EHYPrsiDwxF4HRfi7znFF5F4knMnTxe5ZMB+rOBb7FasvzVCo3XgQ9huymNE7w9VYJ6LLMYQ2NUo1JCGcoInAP86ZTdc7Ve/evRz1BQVSjuraD9sVm1KhkqWs2SvscQJ8SBGWabeBYZt5MPi5oMsiaSIC2EK8sSSlk
Content-Type: text/plain; charset="us-ascii"
Content-ID: <61ED1D3EDF299042A3918311585BEFAF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f911bc7e-1069-4350-ca51-08d7624b1bde
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 23:51:42.3890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c2p91dm49xhXASV0aAQ7hDGEHLOVyyoHJ10H3OOnC5bKhQalHADAGflaLN0yEjS0X5gO6kk6+scgZd0xQ3xZhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1437
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-05_09:2019-11-05,2019-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=974 phishscore=0 spamscore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1911050193
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

More details on where I am heading...

> On Sep 18, 2019, at 10:23 PM, Song Liu <songliubraving@fb.com> wrote:
>=20
> This patch tries to enable PMU sharing. To make perf event scheduling
> fast, we use special data structures.
>=20
> An array of "struct perf_event_dup" is added to the perf_event_context,
> to remember all the duplicated events under this ctx. All the events
> under this ctx has a "dup_id" pointing to its perf_event_dup. Compatible
> events under the same ctx share the same perf_event_dup. The following
> figure shows a simplified version of the data structure.
>=20
>      ctx ->  perf_event_dup -> master
>                     ^
>                     |
>         perf_event /|
>                     |
>         perf_event /
>=20
> Connection among perf_event and perf_event_dup are built when events are
> added or removed from the ctx. So these are not on the critical path of
> schedule or perf_rotate_context().
>=20
> On the critical paths (add, del read), sharing PMU counters doesn't
> increase the complexity. Helper functions event_pmu_[add|del|read]() are
> introduced to cover these cases. All these functions have O(1) time
> complexity.
>=20
> We allocate a separate perf_event for perf_event_dup->master. This needs
> extra attention, because perf_event_alloc() may sleep. To allocate the
> master event properly, a new pointer, tmp_master, is added to perf_event.
> tmp_master carries a separate perf_event into list_[add|del]_event().
> The master event has valid ->ctx and holds ctx->refcount.

If we do GFP_ATOMIC in perf_event_alloc(), maybe with an extra option, we
don't need the tmp_master hack. So we only allocate master when we will=20
use it.=20

>=20
> Details about the handling of the master event is added to
> include/linux/perf_event.h, before struct perf_event_dup.
>=20
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
> include/linux/perf_event.h |  61 ++++++++
> kernel/events/core.c       | 294 ++++++++++++++++++++++++++++++++++---
> 2 files changed, 332 insertions(+), 23 deletions(-)
>=20
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 61448c19a132..a694e5eee80a 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -722,6 +722,12 @@ struct perf_event {
> #endif
>=20
> 	struct list_head		sb_list;
> +
> +	/* for PMU sharing */
> +	struct perf_event		*tmp_master;
> +	int				dup_id;

I guess we can get rid of dup_id here, and just have=20
struct perf_event *dup_master.=20

> +	u64				dup_base_count;
> +	u64				dup_base_child_count;
> #endif /* CONFIG_PERF_EVENTS */
> };
>=20
> @@ -731,6 +737,58 @@ struct perf_event_groups {
> 	u64		index;
> };
>=20
> +/*
> + * Sharing PMU across compatible events
> + *
> + * If two perf_events in the same perf_event_context are counting same
> + * hardware events (instructions, cycles, etc.), they could share the
> + * hardware PMU counter.
> + *
> + * When a perf_event is added to the ctx (list_add_event), it is compare=
d
> + * against other events in the ctx. If they can share the PMU counter,
> + * a perf_event_dup is allocated to represent the sharing.
> + *
> + * Each perf_event_dup has a virtual master event, which is called by
> + * pmu->add() and pmu->del(). We cannot call perf_event_alloc() in
> + * list_add_event(), so it is allocated and carried by event->tmp_master
> + * into list_add_event().
> + *
> + * Virtual master in different cases/paths:
> + *
> + * < I > perf_event_open() -> close() path:
> + *
> + * 1. Allocated by perf_event_alloc() in sys_perf_event_open();
> + * 2. event->tmp_master->ctx assigned in perf_install_in_context();
> + * 3.a. if used by ctx->dup_events, freed in perf_event_release_kernel()=
;
> + * 3.b. if not used by ctx->dup_events, freed in perf_event_open().
> + *
> + * < II > inherit_event() path:
> + *
> + * 1. Allocated by perf_event_alloc() in inherit_event();
> + * 2. tmp_master->ctx assigned in inherit_event();
> + * 3.a. if used by ctx->dup_events, freed in perf_event_release_kernel()=
;
> + * 3.b. if not used by ctx->dup_events, freed in inherit_event().
> + *
> + * < III > perf_pmu_migrate_context() path:
> + * all dup_events removed during migration (no sharing after the move).
> + *
> + * < IV > perf_event_create_kernel_counter() path:
> + * not supported yet.
> + */
> +struct perf_event_dup {
> +	/*
> +	 * master event being called by pmu->add() and pmu->del().
> +	 * This event is allocated with perf_event_alloc(). When
> +	 * attached to a ctx, this event should hold ctx->refcount.
> +	 */
> +	struct perf_event       *master;
> +	/* number of events in the ctx that shares the master */
> +	int			total_event_count;
> +	/* number of active events of the master */
> +	int			active_event_count;
> +};

And hopefully get rid of this.=20

Please let me know if this doesn't work.=20

Thanks,
Song


