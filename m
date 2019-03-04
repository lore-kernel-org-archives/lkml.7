Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17B3C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863122070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Z0y/wa5j";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="K1qOc3TG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfCDTgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:36:53 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56928 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726054AbfCDTgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:36:52 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x24JSm8t028340;
        Mon, 4 Mar 2019 11:36:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=1LJtSo+twMQID73y5JN4w1TRtK7H7IggHRkeS3CYweo=;
 b=Z0y/wa5jR8hreAbSfSFxeUqH3cZTEmJdVm1XRzmu00WWn31hHAwGf5hqIIvaXgPEHP18
 EgI3PNXMdfy9fQh2h/n77SyogqhQVTSmV7YisXrD0Vawswx/opy8dniNbZ4Vl8Amug24
 d9CV/qTDRG9xmUcjgSW/JvxNNh4Qzwl7FQo= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r19ad88fr-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 04 Mar 2019 11:36:20 -0800
Received: from frc-hub01.TheFacebook.com (2620:10d:c021:18::171) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 4 Mar 2019 11:36:17 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 4 Mar 2019 11:36:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LJtSo+twMQID73y5JN4w1TRtK7H7IggHRkeS3CYweo=;
 b=K1qOc3TG/VqkrAW7MTgAZ9+yV/3HgYhHLR9TSXC7Ef2nt2hL+OqtcwFf9K+QGJ0nMEr3Ee3VS+f3yGJeDk6LVpv1AfSC+93irgIzFtQxDFJklRAMACQ0qa2Gur4kXnX+awBvzHcks/WYHKtT29r8ESSQJJ4D8E5ve5V+GSC6oEg=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1197.namprd15.prod.outlook.com (10.175.2.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.15; Mon, 4 Mar 2019 19:36:15 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065%6]) with mapi id 15.20.1665.020; Mon, 4 Mar 2019
 19:36:14 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Networking <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v5 perf,bpf 07/15] perf, bpf: save bpf_prog_info
 information as headers to perf.data
Thread-Topic: [PATCH v5 perf,bpf 07/15] perf, bpf: save bpf_prog_info
 information as headers to perf.data
Thread-Index: AQHUzyOP1AVZWxR1lEa6YX4LDOvnT6X7hKUAgABgIYA=
Date:   Mon, 4 Mar 2019 19:36:14 +0000
Message-ID: <CE031049-FB10-4BB5-BCA1-EA48C5BF882B@fb.com>
References: <20190228050643.958685-1-songliubraving@fb.com>
 <20190228050643.958685-8-songliubraving@fb.com>
 <20190304135210.GB19809@krava>
In-Reply-To: <20190304135210.GB19809@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::3:1d00]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11e00f3f-1e50-44db-fd95-08d6a0d8aa44
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1197;
x-ms-traffictypediagnostic: MWHPR15MB1197:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1197;20:PYhHqqa3aqVPwFzMQJXLM/KbjEZkJpUPnM62kWnZuJvxSiTEHy3WTtMmzKdWDJQZJ4XFQK+LTv+Xwf7EORk9lz1KwIearPHPSUb7Afg/zi/sElyWX8t4PHsK00G/KCyhKzt3wkKeNfIwUaqUNu2uFvK1UMGez9bkyG80Em2MGOg=
x-microsoft-antispam-prvs: <MWHPR15MB11979704E89302B970BB68B8B3710@MWHPR15MB1197.namprd15.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(346002)(39860400002)(136003)(199004)(189003)(2906002)(478600001)(476003)(50226002)(256004)(14444005)(53936002)(8936002)(6916009)(486006)(106356001)(8676002)(105586002)(81166006)(7736002)(316002)(81156014)(99286004)(25786009)(97736004)(2616005)(14454004)(6486002)(6512007)(102836004)(186003)(82746002)(446003)(11346002)(36756003)(33656002)(53546011)(4326008)(305945005)(6246003)(54906003)(57306001)(5660300002)(46003)(6436002)(83716004)(76176011)(71200400001)(6116002)(68736007)(86362001)(71190400001)(229853002)(6506007)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1197;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VZGF7gI30RaEJ/+tdJwfhsEybehsvqYgILCOCmo/vi09eqsWaQxfw25/mP0X/0AHfUSuqC65eqEkF9ZGQCPQ6IPuG2cXr7rqL+/Bts0xpYRdlA66enSDgUe4H3IH1GI8ZgiK1HIXgE291/9zspkOGS5dBPB5p4Ct+kG6rN73JnfpnjPWgeSrvPHlQlXL8TB2nxaGTVje7x5VT4XFQtact2U++Gmf0gKmLtreyiqpKKNXTC4nany+QHKpgXCRT5hhgFizqHpZqWBNVL2XRpoWWH5OuQxvk/Md7zl05qOXhaT5JcFpendgW5FF6DQ+/rDlzK5HLch5cyVufBxF/G3BgztCc5J8R1Tt2Ng79hcX242EorNwxava07bWfB8Oy3jQo/DrtegClVPipI390ic0jUWa8wagqPardyiwiyihWCY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17EB9EB6B1CF244793546F0C6BF86115@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e00f3f-1e50-44db-fd95-08d6a0d8aa44
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 19:36:14.6879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1197
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-04_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 4, 2019, at 5:52 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Wed, Feb 27, 2019 at 09:06:35PM -0800, Song Liu wrote:
>=20
> SNIP
>=20
>> +static int process_bpf_prog_info(struct feat_fd *ff,
>> +				 void *data __maybe_unused)
>> +{
>> +	struct bpf_prog_info_linear *info_linear;
>> +	struct bpf_prog_info_node *info_node;
>> +	struct perf_env *env =3D &ff->ph->env;
>> +	u32 count, i;
>> +	int err =3D -1;
>> +
>> +	if (do_read_u32(ff, &count))
>> +		return -1;
>> +
>> +	down_write(&env->bpf_progs.lock);
>> +
>> +	for (i =3D 0; i < count; ++i) {
>> +		u32 info_len, data_len;
>> +
>> +		info_linear =3D NULL;
>> +		info_node =3D NULL;
>> +		if (do_read_u32(ff, &info_len))
>> +			goto out;
>> +		if (do_read_u32(ff, &data_len))
>> +			goto out;
>> +
>> +		if (info_len > sizeof(struct bpf_prog_info)) {
>> +			pr_warning("detected invalid bpf_prog_info\n");
>> +			goto out;
>> +		}
>> +
>> +		info_linear =3D malloc(sizeof(struct bpf_prog_info_linear) +
>> +				     data_len);
>> +		if (!info_linear)
>> +			goto out;
>> +		info_linear->info_len =3D sizeof(struct bpf_prog_info);
>> +		info_linear->data_len =3D data_len;
>> +		if (do_read_u64(ff, (u64 *)(&info_linear->arrays)))
>> +			goto out;
>> +		if (__do_read(ff, &info_linear->info, info_len))
>> +			goto out;
>> +		if (info_len < sizeof(struct bpf_prog_info))
>> +			memset(((void *)(&info_linear->info)) + info_len, 0,
>> +			       sizeof(struct bpf_prog_info) - info_len);
>> +
>> +		if (__do_read(ff, info_linear->data, data_len))
>> +			goto out;
>> +
>> +		/* endian mismatch, drop the info, continue */
>> +		if (ff->ph->needs_swap) {
>> +			free(info_linear);
>> +			continue;
>> +		}
>=20
> so in this case we can check for needs_swap in the begining
> of the function and bail out without reading all the data

If we bail out, perf-record will fail. If we read all the data=20
but ignore them, perf-record will continue without bpf annotation=20
support. I think the latter is a better experience with little=20
effort here.=20

>=20
> also please display soem error message saying we don't support
> ebpf progs data report over the different endianity

I will add a warning in the next version.=20

Thanks,
Song

