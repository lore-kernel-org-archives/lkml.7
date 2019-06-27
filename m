Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24749C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 16:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F772146E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 16:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Cy48uSkl";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="YyqdAftJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfF0QfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 12:35:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54624 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726315AbfF0QfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 12:35:02 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RGSNAn027228;
        Thu, 27 Jun 2019 09:34:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=NF5nA84GNhU0DLmHNWKnIzl7iZL4GOW/+joEMf9TPC0=;
 b=Cy48uSklk319TWENCTNMD7bIuhWH6IUBVqU7Hj3slrR0d6JsI6FUYnweaQ6IfS1S+Y2B
 8NdnoBoi/Ytdrm/GvqYudmoeHplgLrjVNPxdra9ZDohndmbuF3qBELzyF75qaqjWZtNh
 YGh3ocR0gjqmNIRoaugqZG+r3S2ApBCY36U= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2tcyq3rfr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 27 Jun 2019 09:34:33 -0700
Received: from prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 27 Jun 2019 09:34:32 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 27 Jun 2019 09:34:32 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 27 Jun 2019 09:34:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=c8yGOPaEO/dgHbNg/e4WEkZdPhN1fFau0frBMIyepme6kT+cMmczxRZN/sdvnQ2O7VDLmvWLq01qAxXyjlTa/PcweWfIV6PMbEhZ5olJuGuZv2EIujXchgG4WLXf15eKaSZWV7jDQqR9YuRF95LiKM9wWyp/K0v5a0hlSsF5WjA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NF5nA84GNhU0DLmHNWKnIzl7iZL4GOW/+joEMf9TPC0=;
 b=j4YV4EwZT6gwSMiFNySMSlLIQj9nlnSoqX7ufdMKc1I9bwzN54054RrVxtchrkbEm3rDPM0Zr42KNPdkI9NchxBeEeZf2vzfET+R9tv0lxw5yxON/FLZZw/9yG1++Axu18EhquyX64dWcs9wRVPrg1lbEhuFbQLY6QHwrzzFvDg=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NF5nA84GNhU0DLmHNWKnIzl7iZL4GOW/+joEMf9TPC0=;
 b=YyqdAftJJlyeG/hZXlcLXvh7mntXuy8jij8UuKa9gYqb04kgKexdIgD3wot+J0CGdIzcr1/Sh9TmemLsrbhdrYWT3c8z9G9f44pQ6PeaM57SQgupvHhVV9c2XtdaJzmzpc7tpDIHc2feKSAZqriEUQksZFI3CK34eaOtd4OdHfQ=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1341.namprd15.prod.outlook.com (10.175.3.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Thu, 27 Jun 2019 16:34:30 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d%6]) with mapi id 15.20.2008.018; Thu, 27 Jun 2019
 16:34:30 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Allan Zhang <allanzhang@google.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, Martin Lau <kafai@fb.com>,
        Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v7 1/2] bpf: Allow bpf_skb_event_output for a few
 prog types
Thread-Topic: [PATCH bpf-next v7 1/2] bpf: Allow bpf_skb_event_output for a
 few prog types
Thread-Index: AQHVLHsNLL4HKFmtjU6rKbDZjMCInKavs2uA
Date:   Thu, 27 Jun 2019 16:34:30 +0000
Message-ID: <F5F0362C-BAEE-404F-A65A-0CAE95BB0C67@fb.com>
References: <20190626235801.210508-1-allanzhang@google.com>
 <20190626235801.210508-2-allanzhang@google.com>
In-Reply-To: <20190626235801.210508-2-allanzhang@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::3:a913]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c01f768-3f85-4698-7de0-08d6fb1d5477
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1341;
x-ms-traffictypediagnostic: MWHPR15MB1341:
x-microsoft-antispam-prvs: <MWHPR15MB1341DB3AA8242C83B8EC2D58B3FD0@MWHPR15MB1341.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(136003)(346002)(189003)(199004)(5660300002)(8936002)(14444005)(54906003)(6486002)(6916009)(68736007)(99286004)(6116002)(256004)(6506007)(86362001)(2906002)(36756003)(478600001)(81166006)(102836004)(76176011)(81156014)(7736002)(8676002)(305945005)(6436002)(316002)(71190400001)(71200400001)(57306001)(66476007)(33656002)(64756008)(66556008)(66446008)(50226002)(6246003)(46003)(229853002)(2616005)(476003)(446003)(11346002)(186003)(53546011)(486006)(25786009)(14454004)(4326008)(6512007)(73956011)(53936002)(76116006)(66946007)(505234006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1341;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +IS0/RP3acn8ZWLAW2e2DgeH0XBBhiDA/HthJOPE5NVJORIck0wPqnXp0R/F0PJiodzwfT+h+7O770Lx1z1eHF2c6nt5H/ZBMCOvYkHHSEa7Z6R5oIz+cjfHt4Kkhc1iFahCuVustcwqr6sZ3KUxQZetfB2HMMiN9NMAn5eSWTQA07pQoR25bz/hMnoLEcvHewJ6ZsfZAYmYFzdHqc8D3Iak341STony1LNUPBEsxM9Gl34ZjMcRLTTgJdi1qm+tOgNWkLg9zT5V5n0cjXIlWb0N5dq8sxS99CpjsXiaqSnv8lI/sQT9pbCW+pNfIauaJL3WunXFUlyJFw9wIj9np0ubY13Pa+gcu/mic2kKJPKgbgd2ha6Bw1nW7HQ8jT2xtJ/HRLKiEStRA1kKRFx0lUJbwuNXg3+5UXo1akkq/Ow=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F644A744302E454DB346AD09C375A5CE@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c01f768-3f85-4698-7de0-08d6fb1d5477
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 16:34:30.7763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1341
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-27_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906270189
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 26, 2019, at 4:58 PM, Allan Zhang <allanzhang@google.com> wrote:
>=20
> From: allanzhang <allanzhang@google.com>
>=20
> Software event output is only enabled by a few prog types right now (TC,
> LWT out, XDP, sockops). Many other skb based prog types need
> bpf_skb_event_output to produce software event.
>=20
> Added socket_filter, cg_skb, sk_skb prog types to generate sw event.
>=20
> Test bpf code is generated from code snippet:
>=20
> struct TMP {
>    uint64_t tmp;
> } tt;
> tt.tmp =3D 5;
> bpf_perf_event_output(skb, &connection_tracking_event_map, 0,
>                      &tt, sizeof(tt));
> return 1;
>=20
> the bpf assembly from llvm is:
>       0:       b7 02 00 00 05 00 00 00         r2 =3D 5
>       1:       7b 2a f8 ff 00 00 00 00         *(u64 *)(r10 - 8) =3D r2
>       2:       bf a4 00 00 00 00 00 00         r4 =3D r10
>       3:       07 04 00 00 f8 ff ff ff         r4 +=3D -8
>       4:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00    r2 =3D =
0ll
>       6:       b7 03 00 00 00 00 00 00         r3 =3D 0
>       7:       b7 05 00 00 08 00 00 00         r5 =3D 8
>       8:       85 00 00 00 19 00 00 00         call 25
>       9:       b7 00 00 00 01 00 00 00         r0 =3D 1
>      10:       95 00 00 00 00 00 00 00         exit
>=20
> Signed-off-by: Allan Zhang <allanzhang@google.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
> net/core/filter.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>=20
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 2014d76e0d2a..b75fcf412628 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5958,6 +5958,8 @@ sk_filter_func_proto(enum bpf_func_id func_id, cons=
t struct bpf_prog *prog)
> 		return &bpf_get_socket_cookie_proto;
> 	case BPF_FUNC_get_socket_uid:
> 		return &bpf_get_socket_uid_proto;
> +	case BPF_FUNC_perf_event_output:
> +		return &bpf_skb_event_output_proto;
> 	default:
> 		return bpf_base_func_proto(func_id);
> 	}
> @@ -5978,6 +5980,8 @@ cg_skb_func_proto(enum bpf_func_id func_id, const s=
truct bpf_prog *prog)
> 		return &bpf_sk_storage_get_proto;
> 	case BPF_FUNC_sk_storage_delete:
> 		return &bpf_sk_storage_delete_proto;
> +	case BPF_FUNC_perf_event_output:
> +		return &bpf_skb_event_output_proto;
> #ifdef CONFIG_SOCK_CGROUP_DATA
> 	case BPF_FUNC_skb_cgroup_id:
> 		return &bpf_skb_cgroup_id_proto;
> @@ -6226,6 +6230,8 @@ sk_skb_func_proto(enum bpf_func_id func_id, const s=
truct bpf_prog *prog)
> 		return &bpf_sk_redirect_map_proto;
> 	case BPF_FUNC_sk_redirect_hash:
> 		return &bpf_sk_redirect_hash_proto;
> +	case BPF_FUNC_perf_event_output:
> +		return &bpf_skb_event_output_proto;
> #ifdef CONFIG_INET
> 	case BPF_FUNC_sk_lookup_tcp:
> 		return &bpf_sk_lookup_tcp_proto;
> --=20
> 2.22.0.410.gd8fdbe21b5-goog
>=20

