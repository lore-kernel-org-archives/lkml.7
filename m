Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB5DC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3314B20850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="GpTScXph";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ANdEk3o1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfDLQOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:14:31 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48042 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726785AbfDLQOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 12:14:30 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x3CGDodm014625;
        Fri, 12 Apr 2019 09:14:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=GVG4lIJ/mePC9SPpb2xVLi+YiyfyJO/k/0X8Kt1eNXc=;
 b=GpTScXph3yy1v1f7lg4RRy5AjAAYkXzH2gAtZdm/BvkBE8XomxBN8Jm+3Lfsgpsubnz7
 efrPoo80Wvb8jegxvRJMslk/YLDLiEEMwDmb68Mkofllkr27wUENIzX0yZ5gDT/4lKJC
 lo40Cr4mnAm4O+165xteUy5oV4uL+l0huvg= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0089730.ppops.net with ESMTP id 2rtrh212h5-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 12 Apr 2019 09:14:03 -0700
Received: from frc-hub04.TheFacebook.com (2620:10d:c021:18::174) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 12 Apr 2019 09:14:01 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 12 Apr 2019 09:14:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVG4lIJ/mePC9SPpb2xVLi+YiyfyJO/k/0X8Kt1eNXc=;
 b=ANdEk3o1mGRBe9yIoQoesZKRKDmNI2+ouI0k1QEMCTbc+y94F7kzK4506eapyO93XItcf62u6ONOIQKmfnGNcJ4G4ohi+pNvllXL1acNMhfaIdb9gY2tAYqOPQrzXXXhrgnaFns7ZYCwxD6KRFPrvvrGJSykq4Kuk/g2Wf2sATk=
Received: from DM5PR15MB1163.namprd15.prod.outlook.com (10.173.208.149) by
 DM5PR15MB1788.namprd15.prod.outlook.com (10.174.246.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.21; Fri, 12 Apr 2019 16:14:01 +0000
Received: from DM5PR15MB1163.namprd15.prod.outlook.com
 ([fe80::290e:d830:9d6c:e8a2]) by DM5PR15MB1163.namprd15.prod.outlook.com
 ([fe80::290e:d830:9d6c:e8a2%11]) with mapi id 15.20.1792.009; Fri, 12 Apr
 2019 16:14:00 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Jiri Olsa" <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 3/7] perf header: Fix lock/unlock imbalances when
 processing BPF/BTF info
Thread-Topic: [PATCH 3/7] perf header: Fix lock/unlock imbalances when
 processing BPF/BTF info
Thread-Index: AQHU8TtUKB0gIkPsXEuGyDfbhWa13qY4swGA
Date:   Fri, 12 Apr 2019 16:14:00 +0000
Message-ID: <FDB4E0DB-9C30-486E-8A6E-407438F163C9@fb.com>
References: <20190412142250.20595-1-acme@kernel.org>
 <20190412142250.20595-4-acme@kernel.org>
In-Reply-To: <20190412142250.20595-4-acme@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:200::1:b0cf]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf306407-eed1-441a-80c0-08d6bf61dff8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:DM5PR15MB1788;
x-ms-traffictypediagnostic: DM5PR15MB1788:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM5PR15MB178847CB5858CDD66E333C3BB3280@DM5PR15MB1788.namprd15.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(346002)(396003)(136003)(366004)(189003)(199004)(4326008)(86362001)(446003)(11346002)(97736004)(6916009)(50226002)(2616005)(316002)(2906002)(476003)(305945005)(54906003)(53936002)(14444005)(8936002)(7416002)(6246003)(5660300002)(7736002)(256004)(99286004)(186003)(14454004)(57306001)(106356001)(36756003)(81166006)(6436002)(8676002)(81156014)(76176011)(6512007)(229853002)(486006)(478600001)(46003)(6116002)(105586002)(6486002)(6506007)(71200400001)(53546011)(71190400001)(82746002)(102836004)(25786009)(33656002)(966005)(83716004)(6306002)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1788;H:DM5PR15MB1163.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0EDdALk7cJF39qloJmzTgfCuxKlR6bUn2jHS/7UE71oT71bEdcCENNepebFzYpycZqlbDsEsDt3XexzeUMajxa1D4RL3+ZjE2wkdWrFqzFuhcE7eytHksczEO4PCo3qKzSmlQzsueOz2pYtOuHvX9E9xZwZM2/4/09bwZWuhfSSdExZh8Ym8n35i3vKvbChUtJnS6vzrOw3/1F2dKkljbPXv+G7Mjwjf4nmMDC9fHUJKLqY+T0PRMGV4Mj5z4y+cI+I0j0woS5pL7gRBG+wBu6gz2Kr8N6ViMHLfuMk/+IM1kvOBR+NAhf6yRP06hKOsyXw0U6N0pRutNAyOvaquVFZONw90/K+AY9NsjAg12Z7OcQU2w8Q83TKheGmIDzSdpmxnHNbLSzhYK2Ckn/neN9144zvpr4HUVSaH22S7ZlU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1F4384D30FEBAC4CBDF006E695174EC4@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bf306407-eed1-441a-80c0-08d6bf61dff8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 16:14:00.7660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1788
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-12_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 12, 2019, at 7:22 AM, Arnaldo Carvalho de Melo <acme@kernel.org> w=
rote:
>=20
> From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
>=20
> Fix lock/unlock imbalances by refactoring the code a bit and adding
> calls to up_write() before return.
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Acked-by: Song Liu <songliubraving@fb.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Addresses-Coverity-ID: 1444315 ("Missing unlock")
> Addresses-Coverity-ID: 1444316 ("Missing unlock")
> Fixes: a70a1123174a ("perf bpf: Save BTF information as headers to perf.d=
ata")
> Fixes: 606f972b1361 ("perf bpf: Save bpf_prog_info information as headers=
 to perf.data")
> Link: http://lkml.kernel.org/r/20190408173355.GA10501@embeddedor
> [ Simplified the exit path to have just one up_write() + return ]
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Song Liu <songliubraving@fb.com>


> ---
> tools/perf/util/header.c | 22 +++++++++++++---------
> 1 file changed, 13 insertions(+), 9 deletions(-)
>=20
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index b9e693825873..2d2af2ac2b1e 100644
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
> +	struct btf_node *node =3D NULL;
> 	u32 count, i;
> +	int err =3D -1;
>=20
> 	if (ff->ph->needs_swap) {
> 		pr_warning("interpreting btf from systems with endianity is not yet sup=
ported\n");
> @@ -2636,31 +2639,32 @@ static int process_bpf_btf(struct feat_fd *ff, vo=
id *data __maybe_unused)
> 	down_write(&env->bpf_progs.lock);
>=20
> 	for (i =3D 0; i < count; ++i) {
> -		struct btf_node *node;
> 		u32 id, data_size;
>=20
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
> +		node =3D NULL;
> 	}
>=20
> +	err =3D 0;
> +out:
> 	up_write(&env->bpf_progs.lock);
> -	return 0;
> +	free(node);
> +	return err;
> }
>=20
> struct feature_ops {
> --=20
> 2.20.1
>=20

