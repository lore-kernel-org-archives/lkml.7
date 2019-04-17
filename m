Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6F0C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A3F20835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="hRBW4rzj";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Rc9fv7SO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732802AbfDQQtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:49:32 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58278 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730258AbfDQQtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:49:32 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3HGmAfE019028;
        Wed, 17 Apr 2019 09:49:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=tzW+4liugYNQd27SO9Qrztk1AybRD3iiQpfjPy1cua4=;
 b=hRBW4rzjHgX9UfRMuRrHRQP/iIVHDh6Qv719YF8q+y+ZbxVAnGTiMq944Ul882abXtK5
 HlztSGW09pP6wRF1HVRHbI4EzN7GQiwL/CjfdOK9JxjiyMEMWAiLPbeQW4kTrQZFru46
 HtNgN8O41yghaByqmFBk4+FxQRQBzVcsUg8= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rx7smr1q5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 17 Apr 2019 09:49:17 -0700
Received: from frc-hub06.TheFacebook.com (2620:10d:c021:18::176) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 17 Apr 2019 09:49:16 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 17 Apr 2019 09:49:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzW+4liugYNQd27SO9Qrztk1AybRD3iiQpfjPy1cua4=;
 b=Rc9fv7SO9CsN+Ok1DlbOwfaMQVl16kSDPMFDxsk3JYvd1FtypVsYXnC6Ydb3ofFw0Dcugc9tY/aNOTzRpv0pJ3rkop6ey1zoNbeTJUlPl4O5lIwAp/WbQaYRZJ1aKI4T0MDs8r2/0Jw25GfC4VF/YYXZE8arICAP78Ty5WtSzoI=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1182.namprd15.prod.outlook.com (10.175.2.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Wed, 17 Apr 2019 16:49:14 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::5185:8137:2f1d:7171]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::5185:8137:2f1d:7171%2]) with mapi id 15.20.1792.018; Wed, 17 Apr 2019
 16:49:14 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] perf bpf: Return NULL when RB tree lookup fails in
 perf_env__find_btf()
Thread-Topic: [PATCH] perf bpf: Return NULL when RB tree lookup fails in
 perf_env__find_btf()
Thread-Index: AQHU9S2vS8y6yF+LckOHVvV3njYI4KZAkJwA
Date:   Wed, 17 Apr 2019 16:49:13 +0000
Message-ID: <A3C4DDC9-8E20-488C-A273-E3AE163A9774@fb.com>
References: <20190417145539.11669-1-jolsa@kernel.org>
In-Reply-To: <20190417145539.11669-1-jolsa@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:200::2:a410]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c1e2a97-6e37-4a1d-c927-08d6c3549f85
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR15MB1182;
x-ms-traffictypediagnostic: MWHPR15MB1182:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR15MB118295075420B7940481744EB3250@MWHPR15MB1182.namprd15.prod.outlook.com>
x-forefront-prvs: 0010D93EFE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(346002)(396003)(376002)(199004)(189003)(256004)(86362001)(14454004)(14444005)(71200400001)(305945005)(71190400001)(4326008)(6512007)(76176011)(6116002)(83716004)(6306002)(25786009)(36756003)(53546011)(105586002)(53936002)(82746002)(57306001)(6246003)(316002)(6916009)(229853002)(446003)(102836004)(5660300002)(54906003)(11346002)(2906002)(8676002)(6506007)(97736004)(99286004)(186003)(2616005)(7736002)(476003)(33656002)(106356001)(8936002)(50226002)(68736007)(478600001)(486006)(81166006)(81156014)(6436002)(46003)(6486002)(966005)(101420200001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1182;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tiEiCjIBF/I6YEVt6Y7X9VT0EpsvxqVa9UDIUk7RF+1TDSP2R3lL5QbSnyDzEIGg/X/+umwEWAuRsv6uXGO2hm6oZKm382gH5lj3AZq1GWN696bV6AOTzcnBKETUBF8t2mytsg6Q7a7lboj6GGqjL9rDmtqPAWbne5zKjs5s+NeIjNA9k0AqsJ8XYsVY7Qjvu4uVVOMZlEyZCHOBMUUN8oP+NA3ki88EOjFlOP/xZNW8yCNwILHf9Suazceu6p1IhNkSH/jcLFAeuWUZPcrA6bx4aMzxrrGsAVCbDw2a/J2QLGgmXpxOaOhxWYdlA5eOioevO4j5i24LRrVRZrmxdNkboN8B+uiPEHrWyBIaamoaiEkTTXREX2LnD3rwk4g8SLt1xV6MdjxDWMONpxJyUMYi29bj3BiaSsvxXCYaw/I=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1959996208E2C7458173EA1A29C91C92@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1e2a97-6e37-4a1d-c927-08d6c3549f85
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2019 16:49:13.8766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1182
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-17_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 17, 2019, at 7:55 AM, Jiri Olsa <jolsa@kernel.org> wrote:
>=20
> We currently don't return NULL in case we don't find the
> bpf_prog_info_node, fixing that.
>=20
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Song Liu <songliubraving@fb.com>
> Fixes: 3792cb2ff43b ("perf bpf: Save BTF in a rbtree in perf_env")
> Link: http://lkml.kernel.org/n/tip-99g9rg4p20a1o99vr0nkjhq8@git.kernel.or=
g
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Song Liu <songliubraving@fb.com>

Thanks again for the fix!

> ---
> tools/perf/util/env.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index 34a363f2e71b..9494f9dc61ec 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -111,10 +111,12 @@ struct btf_node *perf_env__find_btf(struct perf_env=
 *env, __u32 btf_id)
> 		else if (btf_id > node->id)
> 			n =3D n->rb_right;
> 		else
> -			break;
> +			goto out;
> 	}
> +	node =3D NULL;
>=20
> 	up_read(&env->bpf_progs.lock);
> +out:
> 	return node;
> }
>=20
> --=20
> 2.17.2
>=20

