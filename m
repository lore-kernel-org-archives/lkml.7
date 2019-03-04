Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DCBC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D2120823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="fWZlnzzx";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="A298D91U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfCDTpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:45:33 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48496 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726061AbfCDTpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:45:33 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x24JiJrB023060;
        Mon, 4 Mar 2019 11:45:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=guEYo/e/y4h8fFfZlCas8MRzXpTr7FjDr2f6G7JZoe4=;
 b=fWZlnzzx+N+hv/NFfdbfgooJ0M713BIZQTjc5hs3y7Ho2ACpHtiakVc029xpEXkz75uP
 ZNAhtFXSMwbEIYZ7id9TWYQiVkb6jfh3aHpEMyIOVNyHbSDz2yZ28TuaccTJZCxpAzyZ
 CN991dJv8j3jAT1+atbKN+yxVxoJDyYLbJ0= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r17pk0q0m-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 04 Mar 2019 11:45:07 -0800
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 4 Mar 2019 11:45:03 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 4 Mar 2019 11:45:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guEYo/e/y4h8fFfZlCas8MRzXpTr7FjDr2f6G7JZoe4=;
 b=A298D91UWSGQW/xt70c95uo+umpeKVFtWF6/XGgfrlQlpAS1GAapNmYIJ34AcUZzE7r945KNcLlYy8JXAjFc30/9NcFL5w/JHtE64X7+iw3LQdKWVYgwEfo2QmzTJy8t423mgL69HvTCQzXRhsxO2Bq/5zy0+bkHtj4Ouyc7B9M=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1390.namprd15.prod.outlook.com (10.173.234.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Mon, 4 Mar 2019 19:45:00 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065%6]) with mapi id 15.20.1665.020; Mon, 4 Mar 2019
 19:45:00 +0000
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
Thread-Index: AQHUzyOUOP/+neUx80uWHKj8wE0j5aX7hR6AgABiG4A=
Date:   Mon, 4 Mar 2019 19:45:00 +0000
Message-ID: <01714139-9FE5-4DFF-A299-D758D1871BA0@fb.com>
References: <20190228050643.958685-1-songliubraving@fb.com>
 <20190228050643.958685-13-songliubraving@fb.com>
 <20190304135351.GL19809@krava>
In-Reply-To: <20190304135351.GL19809@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::3:1d00]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cab814ba-419a-430b-b82a-08d6a0d9e3a7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1390;
x-ms-traffictypediagnostic: MWHPR15MB1390:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1390;20:2wt0dusP8eAKRcK8xRhGAqzScCX6WUIhTa0nmpzyQgosOgKPuu91AxjqIL7Krs7vgK+yzg0g1nK996lcBDEO+HyXA5aXefBrIzA5ygKXnE0figU2V9NX3aqh8MEQHkDNLHATcWE6QgdddjXRN/otDBfAzcWNjo2Xd56W9UC3gHg=
x-microsoft-antispam-prvs: <MWHPR15MB13907F565E12D8F20D3FF780B3710@MWHPR15MB1390.namprd15.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(39860400002)(396003)(136003)(199004)(189003)(57306001)(82746002)(36756003)(6246003)(71200400001)(71190400001)(256004)(83716004)(6436002)(6512007)(186003)(2906002)(478600001)(14454004)(229853002)(5660300002)(4326008)(46003)(2616005)(316002)(33656002)(53546011)(8936002)(446003)(11346002)(97736004)(305945005)(476003)(486006)(86362001)(6116002)(81156014)(106356001)(102836004)(54906003)(76176011)(6486002)(7736002)(53936002)(8676002)(50226002)(25786009)(99286004)(81166006)(105586002)(68736007)(6916009)(6506007)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1390;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bAJoe9GyYjXT4s6MqyoOJiFcALAs5/fTtRJzpL3EZNBFxZeWAPDj0//KtrH9VkvWcpblgrsAIVmwcbeF+ZkEgYjnlckS/y1y9t5l8xuV+QI3IQxpUixM5qLkYj17pkVoLoQN8/26nF9J5AlbFzj6MQDpWSwx2p64rqJAISw09rl/g+11TXOsqxE7ipCFjNvSn5YaO/6nMvbNNpDmZ6+kag3jWHP1MKr9ep/alwGYeRMxzfp5F8+pIVvi7ZfkzxrfrnRbvfsQkHfYzQEMedN9ukaZ/PT+3jMWHQswI2dmqJpoPPN+FfRfn8MKSAxv/FahiHATiXJWCGgzlYX0klMyE9/pcf63OWAXSheeldT3RIVAMRh2a1uikUtuswRdMsIh1GbfZ4+X9B1yo7S9lJAQdJmndRlBFUm1o7ow92GykPk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E2E7156CCD5B554388F2FD167BAEA08B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cab814ba-419a-430b-b82a-08d6a0d9e3a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 19:45:00.5529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1390
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-04_09:,,
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
>> +	fflush(s);
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
>> +
>> +		if (!opts->hide_src_code && srcline) {
>> +			args->offset =3D -1;
>=20
> why's the offset not needed in here?

This is the source code line. Based on my understanding of annotation
code, we put -1 for source code line. Did I misunderstand something?

Thanks,
Song

>=20
> jirka
>=20
>> +			args->line =3D strdup(srcline);
>> +			args->line_nr =3D 0;
>> +			args->ms.sym  =3D sym;
>> +			dl =3D disasm_line__new(args);
>> +			if (dl) {
>> +				annotation_line__add(&dl->al,
>> +						     &notes->src->source);
>> +			}
>> +		}
>=20
> SNIP

