Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B807C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBCDB20830
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="cla6wm8W";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="fnM3kAGj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbfDHSXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:23:50 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33442 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726369AbfDHSXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 14:23:49 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x38IJ3TT031527;
        Mon, 8 Apr 2019 11:22:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=J9Zl7onW68fxYD/oheNHu46r+Kcu6mejWEQcRWJKZzA=;
 b=cla6wm8WErHTRyr+7h4sFFtEM/7IetJC2BMcDWQXeO/elc0FiGLxstx8Drdzihn17MD4
 VC0HCr7O6/PItFk3JG8sLw1ryXtyqTpDFUrHGEfIpgb3DN6MIC9ufx1ivAdUSKWZ2/8m
 KsUYfdkkGWfQQ9pLSH7KFxxURSu8sqeNQ8w= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rrb7g02mp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 08 Apr 2019 11:22:23 -0700
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-hub01.TheFacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 8 Apr 2019 11:22:22 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 8 Apr 2019 11:22:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9Zl7onW68fxYD/oheNHu46r+Kcu6mejWEQcRWJKZzA=;
 b=fnM3kAGjk1t/AKt8F0Igmad/mvm9M3zyTslNrN/HGHKGQa7D4qmCjwZ+43lJHGh7eulYva71+TW0XIx8mgeY28gFVKduuG61bVjIItsTaDeFNFMhEroJ7l4J62qDVcc00eyDO2IE2u11orZcIZGlSA3s/4HvZdg3LBY1CfrAAZo=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1198.namprd15.prod.outlook.com (10.175.2.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Mon, 8 Apr 2019 18:22:20 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::5185:8137:2f1d:7171]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::5185:8137:2f1d:7171%2]) with mapi id 15.20.1771.019; Mon, 8 Apr 2019
 18:22:20 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf header: Fix lock/unlock imbalances
Thread-Topic: [PATCH] perf header: Fix lock/unlock imbalances
Thread-Index: AQHU7jFMmnodf1WMi0S8lMJ4Jz4khKYyk52A
Date:   Mon, 8 Apr 2019 18:22:19 +0000
Message-ID: <B581617C-53AD-435A-8352-5E5A74B76B34@fb.com>
References: <20190408173355.GA10501@embeddedor>
In-Reply-To: <20190408173355.GA10501@embeddedor>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:200::2:343d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce2041c8-ae9a-4e1c-7804-08d6bc4f2357
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1198;
x-ms-traffictypediagnostic: MWHPR15MB1198:
x-microsoft-antispam-prvs: <MWHPR15MB1198AC220251C99DBC3A5A91B32C0@MWHPR15MB1198.namprd15.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(39860400002)(376002)(396003)(366004)(189003)(199004)(51914003)(68736007)(486006)(4326008)(6486002)(7736002)(53546011)(2616005)(6116002)(305945005)(11346002)(6436002)(186003)(476003)(229853002)(36756003)(82746002)(97736004)(5660300002)(14454004)(102836004)(6506007)(71190400001)(83716004)(478600001)(71200400001)(81166006)(8936002)(57306001)(6246003)(33656002)(316002)(81156014)(8676002)(54906003)(46003)(53936002)(106356001)(99286004)(50226002)(2906002)(86362001)(6512007)(25786009)(446003)(6916009)(14444005)(76176011)(256004)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1198;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8+XbscylbVQV7+8GvzYeIM4CGq7HZwAr2i25DIX5zeQYf+T6PlnXZp1kXLo1i0b0LJR1aXfmAW3knzQa5Ar/s0CpY+Xigj6nUtOx23//bdtx1npB9mtSBAyOAm9Lbw6ShZB+2SjVRbAEJ2VyiEtCnyk3WKGg/x8cX6Wp8wxFZzWR5o9FCmKtUbDG7YgPsqjfHCj0ev/J/X9ubTtJHJJv32gVcTxKmR14p22BaYssjbsj+luj1RbA4hmE1+xgWgvvUD2UcC89MI5Bt8q1b2ciZ+2OVllLUqj1Q6TwywRxdPowSZbTWE2OFDgoFzBUL2HT0WZK7vKSJJ8veBNOyet5ZhyaXucaSaP01N3GRmsBQ1YyKrYa7b3J7tOq3gJ4OlCsBEMiI1rwyi2A1m4+ff10E9jMIoc9J8pWWJ+20hAxAyE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6AABA0F38DA7DE43B1970CAB120615AF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ce2041c8-ae9a-4e1c-7804-08d6bc4f2357
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 18:22:19.9305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1198
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-08_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 8, 2019, at 10:33 AM, Gustavo A. R. Silva <gustavo@embeddedor.com>=
 wrote:
>=20
> Fix lock/unlock imbalances by refactoring the code a bit and adding
> calls to up_write() before return.
>=20
> Addresses-Coverity-ID: 1444315 ("Missing unlock")
> Addresses-Coverity-ID: 1444316 ("Missing unlock")
> Fixes: a70a1123174a ("perf bpf: Save BTF information as headers to perf.d=
ata")
> Fixes: 606f972b1361 ("perf bpf: Save bpf_prog_info information as headers=
 to perf.data")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Song Liu <songliubraving@fb.com>

Thanks for the fix!

> ---
> tools/perf/util/header.c | 21 +++++++++++++--------
> 1 file changed, 13 insertions(+), 8 deletions(-)
>=20
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index b9e693825873..06028e0ee06a 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -2606,6 +2606,7 @@ static int process_bpf_prog_info(struct feat_fd *ff=
, void *data __maybe_unused)
> 		perf_env__insert_bpf_prog_info(env, info_node);
> 	}
>=20
> +	up_write(&env->bpf_progs.lock);
> 	return 0;
> out:
> 	free(info_linear);
> @@ -2623,7 +2624,9 @@ static int process_bpf_prog_info(struct feat_fd *ff=
 __maybe_unused, void *data _
> static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
> {
> 	struct perf_env *env =3D &ff->ph->env;
> +	struct btf_node *node;
> 	u32 count, i;
> +	int err =3D -1;
>=20
> 	if (ff->ph->needs_swap) {
> 		pr_warning("interpreting btf from systems with endianity is not yet sup=
ported\n");
> @@ -2636,31 +2639,33 @@ static int process_bpf_btf(struct feat_fd *ff, vo=
id *data __maybe_unused)
> 	down_write(&env->bpf_progs.lock);
>=20
> 	for (i =3D 0; i < count; ++i) {
> -		struct btf_node *node;
> 		u32 id, data_size;
>=20
> +		node =3D NULL;
> 		if (do_read_u32(ff, &id))
> -			return -1;
> +			goto out;
> 		if (do_read_u32(ff, &data_size))
> -			return -1;
> +			goto out;
>=20
> 		node =3D malloc(sizeof(struct btf_node) + data_size);
> 		if (!node)
> -			return -1;
> +			goto out;
>=20
> 		node->id =3D id;
> 		node->data_size =3D data_size;
>=20
> -		if (__do_read(ff, node->data, data_size)) {
> -			free(node);
> -			return -1;
> -		}
> +		if (__do_read(ff, node->data, data_size))
> +			goto out;
>=20
> 		perf_env__insert_btf(env, node);
> 	}
>=20
> 	up_write(&env->bpf_progs.lock);
> 	return 0;
> +out:
> +	up_write(&env->bpf_progs.lock);
> +	free(node);
> +	return err;
> }
>=20
> struct feature_ops {
> --=20
> 2.21.0
>=20

