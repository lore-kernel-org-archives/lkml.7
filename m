Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52218C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0606D206DD
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="oUSd3CRZ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="V6SXM1It"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfCDUwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:52:46 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42408 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726111AbfCDUwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:52:46 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x24Knl3Q019987;
        Mon, 4 Mar 2019 12:52:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=vwW4OpLD73YHZwWj5HjbxF/3TsPm6qV78jMFXkkLsAc=;
 b=oUSd3CRZrEMTkR0i8F30pj6LXJ6dD5SjO+Oa77pdVQazwqTzAIoxtiktPRdxwIyWUh7c
 3qnV8BhBLoc/h1nKm8bBf142GFAn+/oGt08I2KOXXdi1I1aTTN52Z9jhv/PIF053DVlW
 VyS+li7mmAk5AHvIT+dMpdep6S9fW8glzSA= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r1b7w01ck-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 04 Mar 2019 12:52:17 -0800
Received: from frc-mbx07.TheFacebook.com (2620:10d:c0a1:f82::31) by
 frc-hub01.TheFacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 4 Mar 2019 12:52:09 -0800
Received: from frc-hub01.TheFacebook.com (2620:10d:c021:18::171) by
 frc-mbx07.TheFacebook.com (2620:10d:c0a1:f82::31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 4 Mar 2019 12:52:08 -0800
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 4 Mar 2019 12:52:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwW4OpLD73YHZwWj5HjbxF/3TsPm6qV78jMFXkkLsAc=;
 b=V6SXM1Itml+5yJVVXH3m92mzjfxqzH7wMQeZBzP6nNTEYKieCYSp9HLaj0lIaiawr6QprAkDUpKdI5uzDHaWxt80cFxT2lfJBUldEjYQdz3xW8Xs82bxBa7nrqWEL+QK2lvmAWPT3G2oerQg4j16/UW6RH3Fk2hpLFHx/3nudmQ=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1822.namprd15.prod.outlook.com (10.174.255.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.17; Mon, 4 Mar 2019 20:52:06 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065%6]) with mapi id 15.20.1665.020; Mon, 4 Mar 2019
 20:52:06 +0000
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
Subject: Re: [PATCH v5 perf,bpf 12/15] perf, bpf: enable annotation of bpf
 program
Thread-Topic: [PATCH v5 perf,bpf 12/15] perf, bpf: enable annotation of bpf
 program
Thread-Index: AQHUzyOUOP/+neUx80uWHKj8wE0j5aX7hPqAgAB0/oA=
Date:   Mon, 4 Mar 2019 20:52:06 +0000
Message-ID: <35B644D2-D4E4-4C97-A06D-8A4479F261C1@fb.com>
References: <20190228050643.958685-1-songliubraving@fb.com>
 <20190228050643.958685-13-songliubraving@fb.com>
 <20190304135321.GJ19809@krava>
In-Reply-To: <20190304135321.GJ19809@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::3:1d00]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38a78763-1312-4fb2-07f4-08d6a0e34363
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1822;
x-ms-traffictypediagnostic: MWHPR15MB1822:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1822;20:/D20fSFEB9t31UKbuHGGtyncTv+Ig1HQVYliiG6HeKTozU0vK3Nrvoa9p23sAA9sbl+bbi48cE0IB8nMFagG3BjsDsFOnw7srCADqUhgKDwpQS1+vTX3rF91lFpp9HT5zl1Auxx3y16DC+wrtTqWv6xkX/uHZ/+yVgV/rrTaquA=
x-microsoft-antispam-prvs: <MWHPR15MB182287CE4CE6E182712BEBD9B3710@MWHPR15MB1822.namprd15.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(136003)(39860400002)(366004)(199004)(189003)(8676002)(82746002)(81166006)(68736007)(81156014)(57306001)(97736004)(50226002)(14454004)(4326008)(71200400001)(33656002)(2616005)(2906002)(476003)(486006)(83716004)(229853002)(25786009)(186003)(53936002)(71190400001)(6512007)(54906003)(6506007)(102836004)(11346002)(105586002)(46003)(106356001)(6116002)(446003)(6486002)(6436002)(478600001)(7736002)(76176011)(86362001)(53546011)(99286004)(5660300002)(6246003)(256004)(316002)(8936002)(6916009)(36756003)(305945005)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1822;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OVeAfWUtxhSGR3XxX+VfPt7mqrWwZWEqdxQdV+Y/RzStaPqaYUaobNUik8rZiDfJWDWy68jBOkS1m/duU1HaZIebtYZjgX6oHmOBhSN4Cq81Nq0MQtcpb1OixjMc0KuXOwpliQiaO2ZrlvvO2cwiCnk+XBC7ZY2d3UYTB3AwvSqb1w+9geY514ti6yEA/f+gJzKYogX1GeC+kAfzS5TVOytJBKk7rRlDJPa1HMuDTcl0dXH2LXrDyZ+rQubwyj7znVdBJC80N46ILZW0UQ6jpUFAdUWTtuA0tYxUPWd4RrO3sL7YwUq01iTw4v6N+SI9MIocVBX5+sT4YN4uIyuULTx53VLMEo+IFvhLuGjyvrtDJuU1jvjA6KqbWtmdwzDURpg48+qugyEf9cUiFk/LRDXyvr/hbnyTsc95IDwwY9g=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E1A47A41F8750648918A1529C2FF9A1A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a78763-1312-4fb2-07f4-08d6a0e34363
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 20:52:06.6226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1822
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-04_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 4, 2019, at 5:53 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Wed, Feb 27, 2019 at 09:06:40PM -0800, Song Liu wrote:
>=20
> SNIP
>=20
>> +
>> +	disassemble_init_for_target(&info);
>> +
>> +#ifdef DISASM_FOUR_ARGS_SIGNATURE
>> +	disassemble =3D disassembler(info.arch,
>> +				   bfd_big_endian(bfdf),
>> +				   info.mach,
>> +				   bfdf);
>> +#else
>> +	disassemble =3D disassembler(bfdf);
>> +#endif
>> +	assert(disassemble);
>> +
>> +	fflush(s);
>=20
> what's the reason for those fflush calls?

fflush() updates buf_size for the stream. This one before the=20
loop make sure we read proper buf_size (prev_buf_size =3D bud_size)
in the first iteration. Then, the fflush() in each iteration=20
makes sure the next iteration reads proper prev_buf_size.=20

Thanks,
Song


>=20
> thanks,
> jirka
>=20
>> +	do {
>> +		const struct bpf_line_info *linfo =3D NULL;
>> +		struct disasm_line *dl;
>> +		size_t prev_buf_size;
>> +		const char *srcline;
>> +		u64 addr;
>> +
>> +		addr =3D pc + ((u64 *)(info_linear->info.jited_ksyms))[sub_id];
>> +		count =3D disassemble(pc, &info);
>> +
>> +		if (prog_linfo)
>> +			linfo =3D bpf_prog_linfo__lfind_addr_func(prog_linfo,
>> +								addr, sub_id,
>> +								nr_skip);
>> +
>> +		if (linfo && btf) {
>> +			srcline =3D btf__name_by_offset(btf, linfo->line_off);
>> +			nr_skip++;
>> +		} else
>> +			srcline =3D NULL;
>> +
>> +		fprintf(s, "\n");
>> +		prev_buf_size =3D buf_size;
>> +		fflush(s);
>=20
> SNIP

