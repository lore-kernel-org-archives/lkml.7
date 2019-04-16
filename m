Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A379EC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684D220693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="jTH6BCL5";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="FQL8TA5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbfDPUl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:41:29 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42294 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727136AbfDPUl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:41:28 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3GKZEoo031021;
        Tue, 16 Apr 2019 13:41:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=9nAuAGUrzurPei324KCs+jDkfOHRI3N8cg159MnHCcM=;
 b=jTH6BCL5E2W3vX1ISYW7Q4RZaNJ0/bGjHb/zVsXjgYg6K+j4/88xR4/wDInj9bgydGNh
 sO2Thp/GPDJfvAkB9i03/+s5YUyNdjmbC7Z/570dThb8ctY0/vpsdC98B7yn3tCNXlUV
 NHKR3ARXocK5QGtZryttKKYSQaRGgOzJnn8= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rwp3x81e7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 16 Apr 2019 13:41:05 -0700
Received: from prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 16 Apr 2019 13:41:05 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 16 Apr 2019 13:41:04 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 16 Apr 2019 13:41:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nAuAGUrzurPei324KCs+jDkfOHRI3N8cg159MnHCcM=;
 b=FQL8TA5NfiFHX2ilDQq+4YLxNhxg0AWWfYzHs5kRinCKafSqE1wzEKdh7chcnWhv6Rr6n1nIQV26RCpQEpUsG0A5yLwwactdu/yQ/8pnCvZnHkziOD7+w0vuSm/45ern/PSaooyIDL3GwiXqr5m87fRi9bKvFARFDYfOK4jfRzo=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1918.namprd15.prod.outlook.com (10.174.100.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.19; Tue, 16 Apr 2019 20:41:01 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::5185:8137:2f1d:7171]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::5185:8137:2f1d:7171%2]) with mapi id 15.20.1792.018; Tue, 16 Apr 2019
 20:41:01 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>
Subject: Re: [PATCH 08/12] perf tools: Fix side band thread draining
Thread-Topic: [PATCH 08/12] perf tools: Fix side band thread draining
Thread-Index: AQHU9G3EQFEzrVhNlUqPmTqT9PA0jaY/QIoA
Date:   Tue, 16 Apr 2019 20:41:01 +0000
Message-ID: <B1CEB5A5-9C9F-41B8-A107-46E3CB59B314@fb.com>
References: <20190416160127.30203-1-jolsa@kernel.org>
 <20190416160127.30203-9-jolsa@kernel.org>
In-Reply-To: <20190416160127.30203-9-jolsa@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:200::2:2171]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf3d65f0-e031-4a9e-2c13-08d6c2abd6af
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1918;
x-ms-traffictypediagnostic: MWHPR15MB1918:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR15MB19182F0826C7E5D8DD100320B3240@MWHPR15MB1918.namprd15.prod.outlook.com>
x-forefront-prvs: 000947967F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(136003)(346002)(39860400002)(366004)(376002)(51914003)(199004)(189003)(6916009)(36756003)(446003)(11346002)(6436002)(486006)(186003)(6486002)(99286004)(316002)(7416002)(33656002)(2906002)(68736007)(6246003)(6306002)(229853002)(25786009)(86362001)(6512007)(476003)(2616005)(82746002)(4326008)(46003)(53936002)(6116002)(102836004)(5660300002)(53546011)(6506007)(83716004)(105586002)(966005)(106356001)(256004)(478600001)(71190400001)(71200400001)(14454004)(57306001)(81166006)(76176011)(97736004)(54906003)(8936002)(50226002)(7736002)(305945005)(8676002)(81156014)(14444005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1918;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AZgqmE/6EmNf+VJUWdBIOvpnqMK3JkwtQKr70tpTU57EXDlR5lBKjmNbcHIsdHGKX0uPskTaLDOGgrzF//UENLOPLF4siRTqY8tps8Z2l+DVclTrDT+DnXW/kwENn2Wl+wER3HoQ3Z4W5FOfLg7TM4gpvrii8XrdMQxXis+DBlksXlMT3FAQwfo5Pf7G/MNtbXdBPuVc3CzNTH+SnKCbL/SVUdAO1qsLcQwpj9B1ryylWGhW5I9ovUtnnoC9aKFugInmiOXdFSTxKpQY86aDVObYdvlfu0k2GlyVTEW/psPKhHV+Y2UjL25mOCW/LS4EMC8x/4Rm2hdBf7/Jvza3I00wTbIGI0FJB/oHXGeWiJ1Na9FEBdfl0NgBBCimLJsGaTFqoMlyVg0bHdo4F9bK4bXxoY0NHQuUTNsZHLwmgas=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FDC653436E630040820F60FA75C5ED23@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3d65f0-e031-4a9e-2c13-08d6c2abd6af
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2019 20:41:01.4772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1918
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-16_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 16, 2019, at 9:01 AM, Jiri Olsa <jolsa@kernel.org> wrote:
>=20
> Current perf_evlist__poll_thread code could finish
> without draining the data. Adding the logic that
> makes sure we won't finish before the drain.
>=20
> Fixes: 657ee5531903 ("perf evlist: Introduce side band thread")
> Link: http://lkml.kernel.org/n/tip-41i888xyim9n5ceyr44jb468@git.kernel.or=
g
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Thanks for the fix!

Acked-by: Song Liu <songliubraving@fb.com>

> ---
> tools/perf/util/evlist.c | 14 +++++++++-----
> 1 file changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index f2bbae38278d..4b6783ff5813 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1868,12 +1868,12 @@ static void *perf_evlist__poll_thread(void *arg)
> {
> 	struct perf_evlist *evlist =3D arg;
> 	bool draining =3D false;
> -	int i;
> +	int i, done =3D 0;
> +
> +	while (!done) {
> +		bool got_data =3D false;
>=20
> -	while (draining || !(evlist->thread.done)) {
> -		if (draining)
> -			draining =3D false;
> -		else if (evlist->thread.done)
> +		if (evlist->thread.done)
> 			draining =3D true;
>=20
> 		if (!draining)
> @@ -1894,9 +1894,13 @@ static void *perf_evlist__poll_thread(void *arg)
> 					pr_warning("cannot locate proper evsel for the side band event\n");
>=20
> 				perf_mmap__consume(map);
> +				got_data =3D true;
> 			}
> 			perf_mmap__read_done(map);
> 		}
> +
> +		if (draining && !got_data)
> +			break;
> 	}
> 	return NULL;
> }
> --=20
> 2.17.2
>=20

