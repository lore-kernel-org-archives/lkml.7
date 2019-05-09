Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B1FC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 13:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F296C205C9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 13:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="jumJcAck";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="OuRyXcdP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfEINrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 09:47:37 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51592 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726087AbfEINrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 09:47:37 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x49DhibE006545;
        Thu, 9 May 2019 06:47:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ohBojUMaUhvn01/pKXZleZDJ6DsKSzIYXAyGvc2CfLY=;
 b=jumJcAckPPjoupJ6yp+p1s4hvzsGCkXCuPFHkeoltwE5dtiSbsLc1OyGtEEJBbnSo1JF
 Gn4abMEGsVHcLtOtZAURYrko43Di9njwkhmTfn9w9UzTrDIx9XKfFOXTn8OP68Gqcv2k
 pjfievoCWiRsfLQJdlV3v8PxpkBwlcr4jlY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2sca9w9us8-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 09 May 2019 06:47:25 -0700
Received: from ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 9 May 2019 06:47:23 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 9 May 2019 06:47:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohBojUMaUhvn01/pKXZleZDJ6DsKSzIYXAyGvc2CfLY=;
 b=OuRyXcdPTwF+j1sB3cdYK+DiAiwDdYR2+p0JvkcxcOzNlh60EBm7rH57OLPcPtNOo2SZ4/WgkHH3O8l2LxiiHRdwWutXuXl1ZNtMb63dy5xCrLfnSC529objHWIpYyup68tXD33fuqkn9CLy8GWE7EiP+QUzbVmeJp1dpLJODpM=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1839.namprd15.prod.outlook.com (10.174.255.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Thu, 9 May 2019 13:47:22 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15%11]) with mapi id 15.20.1856.012; Thu, 9 May 2019
 13:47:22 +0000
From:   Song Liu <songliubraving@fb.com>
To:     lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v2] perf: allow non-privileged uprobe for user processes
Thread-Topic: [PATCH v2] perf: allow non-privileged uprobe for user processes
Thread-Index: AQHVBPAjOV4IrrhQe0KNd0XfOUkTh6Zi0ZEA
Date:   Thu, 9 May 2019 13:47:21 +0000
Message-ID: <00FF6475-45B9-49B6-B434-A5F7BD884A87@fb.com>
References: <20190507161545.788381-1-songliubraving@fb.com>
In-Reply-To: <20190507161545.788381-1-songliubraving@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:180::fb1a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3150842-acd7-471c-d2d4-08d6d484dc8a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1839;
x-ms-traffictypediagnostic: MWHPR15MB1839:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR15MB1839C6CAD87D49B2CC2FB6B4B3330@MWHPR15MB1839.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 003245E729
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(8676002)(6506007)(53546011)(14454004)(81166006)(81156014)(6436002)(6116002)(102836004)(2616005)(305945005)(11346002)(478600001)(68736007)(99286004)(82746002)(8936002)(71190400001)(71200400001)(486006)(966005)(476003)(83716004)(50226002)(76176011)(446003)(33656002)(25786009)(36756003)(6512007)(53936002)(86362001)(229853002)(5024004)(54906003)(6306002)(7736002)(6246003)(5660300002)(316002)(110136005)(76116006)(66476007)(66556008)(64756008)(66446008)(73956011)(66946007)(186003)(4326008)(256004)(6486002)(57306001)(6636002)(46003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1839;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: j2XAzzPPa7pnNEelvvUDTQUhkuCpdOMa/tx9BksKAHA4PI/XkM1KuTmdhJG2Fclr6oXcWiKplUFoHqtQS8da1wfipj+tJBDOjzdiznk1EbdkIXi/E1jJFRp16Iqi2eQELh+v1eUc9Eqe2uDa/ES1oRGpm/8aypEZhkP6DMQIJ8PCFtpcuC00cUPoMTMUm1BXhZCefJMQZGzqsw3JaxRkU7nDYh8lDyvjqp13K8dczAnyw8acpb+cn8zP22Blw6+MWHreZVVxLajv0puGAthdtIOOfUWHNMCSzkJoe3mF7J226QIo+TU83nm5IVDyAEKv4A2c5nFkyQzRgNKZaRe3dJPZIKyGw1xxcWZVk7rhA1ex6vtVHCmk+HESd/4EouYfoAfYtC4bunINjx+dot1qpwsTxfgWo9+uyam8CTfSiTo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B09B18B2F2CBB746BAB7E492316B2459@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a3150842-acd7-471c-d2d4-08d6d484dc8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2019 13:47:21.8099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1839
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-09_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905090083
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,=20

> On May 7, 2019, at 9:15 AM, Song Liu <songliubraving@fb.com> wrote:
>=20
> Currently, non-privileged user could only use uprobe with
>=20
>    kernel.perf_event_paranoid =3D -1
>=20
> However, setting perf_event_paranoid to -1 leaks other users' processes t=
o
> non-privileged uprobes.
>=20
> To introduce proper permission control of uprobes, we are building the
> following system:
>  A daemon with CAP_SYS_ADMIN is in charge to create uprobes via tracefs;
>  Users asks the daemon to create uprobes;
>  Then user can attach uprobe only to processes owned by the user.
>=20
> This patch allows non-privileged user to attach uprobe to processes owned
> by the user.
>=20
> The following example shows how to use uprobe with non-privileged user.
> This is based on Brendan's blog post [1]
>=20
> 1. Create uprobe with root:
>  sudo perf probe -x 'readline%return +0($retval):string'
>=20
> 2. Then non-root user can use the uprobe as:
>  perf record -vvv -e probe_bash:readline__return -p <pid> sleep 20
>  perf script
>=20
> [1] http://www.brendangregg.com/blog/2015-06-28/linux-ftrace-uprobe.html
>=20
> Signed-off-by: Song Liu <songliubraving@fb.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Jiri Olsa <jolsa@redhat.com>
> ---
> kernel/events/core.c        | 4 ++--
> kernel/trace/trace_uprobe.c | 2 +-
> 2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index abbd4b3b96c2..3005c80f621d 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -8532,9 +8532,9 @@ static int perf_tp_event_match(struct perf_event *e=
vent,
> 	if (event->hw.state & PERF_HES_STOPPED)
> 		return 0;
> 	/*
> -	 * All tracepoints are from kernel-space.
> +	 * If exclude_kernel, only trace user-space tracepoints (uprobes)
> 	 */
> -	if (event->attr.exclude_kernel)
> +	if (event->attr.exclude_kernel && !user_mode(regs))
> 		return 0;
>=20
> 	if (!perf_tp_filter_match(event, data))
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index be78d99ee6bc..bfd3040b4cfb 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -1304,7 +1304,7 @@ static inline void init_trace_event_call(struct tra=
ce_uprobe *tu,
> 	call->event.funcs =3D &uprobe_funcs;
> 	call->class->define_fields =3D uprobe_event_define_fields;
>=20
> -	call->flags =3D TRACE_EVENT_FL_UPROBE;
> +	call->flags =3D TRACE_EVENT_FL_UPROBE | TRACE_EVENT_FL_CAP_ANY;
> 	call->class->reg =3D trace_uprobe_register;
> 	call->data =3D tu;
> }
> --=20
> 2.17.1
>=20

Could you please share your feedback on this version?

Thanks,
Song

