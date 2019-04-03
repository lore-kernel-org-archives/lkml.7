Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5E5C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED66220657
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="N9aMsrUl";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="T6ndAK23"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfDCVeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 17:34:11 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34848 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726672AbfDCVeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 17:34:09 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x33LN2AG020618;
        Wed, 3 Apr 2019 14:34:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ESH9tHX/O07Zu+mzoGeeTfHBqzmY+Ff5uFRZqdthync=;
 b=N9aMsrUlH6T0t2xfPvMfGKX4tNGDbH+myhld1rzK2OW+j6A7capu2c9x1KXan4LLGWkV
 R9KhJNN18rbSBABrxhpf9uFcfRE7VZqRFbS53Brwy+MX34OEV6+/hfIOUPiYYE3Ssvko
 Hih4Yqu8ZwIYk2DAMVLQ19gT5yf0GTTgu88= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rn1e98vdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Apr 2019 14:34:05 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 3 Apr 2019 14:34:04 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 3 Apr 2019 14:34:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESH9tHX/O07Zu+mzoGeeTfHBqzmY+Ff5uFRZqdthync=;
 b=T6ndAK236D0PK3cQaDxwBI+SE3Q/INF7h8jhW8MtRjzOzi57LNY1P5sLzUIPHt9rbw5hHkHhNfNXr4Fmwfwqur8s7aJkikXkygQ+Zqdqb21o/lczN8V6h4CoFMQtEZs6E5ZpOnTPO2eLUF+f/g80m1ds/Yr/McnCVs47c/aamug=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1295.namprd15.prod.outlook.com (10.175.3.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.16; Wed, 3 Apr 2019 21:34:02 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::5185:8137:2f1d:7171]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::5185:8137:2f1d:7171%2]) with mapi id 15.20.1750.017; Wed, 3 Apr 2019
 21:34:02 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>
Subject: Re: [PATCH] perf annotate: Fix build on 32 bit for BPF annotation
Thread-Topic: [PATCH] perf annotate: Fix build on 32 bit for BPF annotation
Thread-Index: AQHU6lXFqqa7wYSVLECtJxWqgZqKp6Yq9TyA
Date:   Wed, 3 Apr 2019 21:34:02 +0000
Message-ID: <ABAEFCEA-E8C6-4246-B109-6D6A12AAB75B@fb.com>
References: <20190403194452.10845-1-cascardo@canonical.com>
In-Reply-To: <20190403194452.10845-1-cascardo@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:200::2:1b0d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a9d0fd3-02e0-45b6-4935-08d6b87c175a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR15MB1295;
x-ms-traffictypediagnostic: MWHPR15MB1295:
x-microsoft-antispam-prvs: <MWHPR15MB1295A7EF87DD219065E828F6B3570@MWHPR15MB1295.namprd15.prod.outlook.com>
x-forefront-prvs: 0996D1900D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(39860400002)(366004)(136003)(189003)(199004)(51914003)(46003)(76176011)(25786009)(14454004)(229853002)(305945005)(106356001)(82746002)(6486002)(8676002)(8936002)(68736007)(6436002)(50226002)(6512007)(6116002)(6916009)(2616005)(446003)(5660300002)(476003)(81156014)(81166006)(54906003)(316002)(71200400001)(6246003)(33656002)(7736002)(186003)(105586002)(256004)(83716004)(2906002)(11346002)(6506007)(53936002)(53546011)(86362001)(71190400001)(99286004)(486006)(57306001)(478600001)(4326008)(97736004)(36756003)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1295;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ku36PQvIugRDvFJSqRT/zMGZc1lncR3UC3i9AMA92Y9S20/78PERxR+qwKP3JLVUGrdEcDX/NhqSFMwXjbKHsUfoanAELue1uXWSKHlA16ExrFo0/vIlO2w5aBO8hcbCtc/cC6EmrDAve7TQfOjNL0uqTvNyEFRfw1EtZKq0qu4yKZBq1Hto+Kbr9e55BCy1WkxfwwuUVfE5HIErRQrFBEq+56Nwjw56NwRjSjvU1DcgBMlWCQcYna0xCYsdDN54+bPr9rnF/BUjh69u+BlLU9I2IHJULAl/hDx+YgGB7m7zhsUpVUqWAos2pIPkcbCs9OEBzi0A7qOzmiXgRuuTIbt+hRd4b3+RcBIKss9+PSmkYjqZZFeonx+2yCM8tzl6Hc5vU5YWvT1dAqDhS7h4V2MngbbnuHlbx57f51dtpMQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7418A620AFE5894F87ED1220F5D59344@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a9d0fd3-02e0-45b6-4935-08d6b87c175a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2019 21:34:02.4800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1295
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-03_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 3, 2019, at 12:44 PM, Thadeu Lima de Souza Cascardo <cascardo@cano=
nical.com> wrote:
>=20
> Commit 6987561c9e86 ("perf annotate: Enable annotation of BPF programs") =
adds
> support for BPF programs annotations but the new code does not build on 3=
2-bit.
>=20
> Fixes: 6987561c9e86 ("perf annotate: Enable annotation of BPF programs")
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>

Acked-by: Song Liu <songliubraving@fb.com>

Thanks for the fix!
Song

> ---
> tools/perf/util/annotate.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index c8b01176c9e1..09762985c713 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1714,8 +1714,8 @@ static int symbol__disassemble_bpf(struct symbol *s=
ym,
> 	if (dso->binary_type !=3D DSO_BINARY_TYPE__BPF_PROG_INFO)
> 		return -1;
>=20
> -	pr_debug("%s: handling sym %s addr %lx len %lx\n", __func__,
> -		 sym->name, sym->start, sym->end - sym->start);
> +	pr_debug("%s: handling sym %s addr %" PRIx64 " len %" PRIx64 "\n", __fu=
nc__,
> +		  sym->name, sym->start, sym->end - sym->start);
>=20
> 	memset(tpath, 0, sizeof(tpath));
> 	perf_exe(tpath, sizeof(tpath));
> @@ -1740,7 +1740,7 @@ static int symbol__disassemble_bpf(struct symbol *s=
ym,
> 	info_linear =3D info_node->info_linear;
> 	sub_id =3D dso->bpf_prog.sub_id;
>=20
> -	info.buffer =3D (void *)(info_linear->info.jited_prog_insns);
> +	info.buffer =3D (void *)(uintptr_t)(info_linear->info.jited_prog_insns)=
;
> 	info.buffer_length =3D info_linear->info.jited_prog_len;
>=20
> 	if (info_linear->info.nr_line_info)
> @@ -1776,7 +1776,7 @@ static int symbol__disassemble_bpf(struct symbol *s=
ym,
> 		const char *srcline;
> 		u64 addr;
>=20
> -		addr =3D pc + ((u64 *)(info_linear->info.jited_ksyms))[sub_id];
> +		addr =3D pc + ((u64 *)(uintptr_t)(info_linear->info.jited_ksyms))[sub_=
id];
> 		count =3D disassemble(pc, &info);
>=20
> 		if (prog_linfo)
> --=20
> 2.20.1
>=20

