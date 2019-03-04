Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EE6C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1641420830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="l4pMxqfw";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="YRQqyn9J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfCDUoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:44:02 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34588 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726101AbfCDUoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:44:01 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x24KbUqV013165;
        Mon, 4 Mar 2019 12:43:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=+T/CytUylXn8J95BhkDnqBVHXsS7djgNhdyFlQLEl1M=;
 b=l4pMxqfwDhzG1rN+fX0thOVIfAMyBcb+pgQ2Jbq8jkvL+x8ajnoFCmiGxP5YY92BKuJU
 okB1GdISJQRhjfNaowK/uaHzi3p0H09TgM02COpvTJr7iOxc2/nomGeboQ27tbGV8WQi
 mqzCFmGOe8wNJJm6AcpkbQxl5dDMZgZBaN0= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r19xkgadd-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 04 Mar 2019 12:43:30 -0800
Received: from frc-hub05.TheFacebook.com (2620:10d:c021:18::175) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 4 Mar 2019 12:43:28 -0800
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 4 Mar 2019 12:43:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+T/CytUylXn8J95BhkDnqBVHXsS7djgNhdyFlQLEl1M=;
 b=YRQqyn9Jk10ZAJLaajQAskxF+bzk687/eBEDPjherXn9u4Zoh6AtOwsYOkqss4KwKOGpxPlJKfEZPmTebHkZnqwLafh5Mmq6zCPIOl/tG0KEC60F/3ZQtXmTx+8ytpCsODvmX74gP1o5Fu9Lq2VFj3/2+5lM5jkhJwx8fIJ6Zi0=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1824.namprd15.prod.outlook.com (10.174.255.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.16; Mon, 4 Mar 2019 20:43:25 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065%6]) with mapi id 15.20.1665.020; Mon, 4 Mar 2019
 20:43:25 +0000
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
Thread-Index: AQHUzyOUOP/+neUx80uWHKj8wE0j5aX7hR6AgABiG4CAAA6YgIAAAboA
Date:   Mon, 4 Mar 2019 20:43:25 +0000
Message-ID: <F363AFC6-A048-44C7-80DE-22C20ADE7CD8@fb.com>
References: <20190228050643.958685-1-songliubraving@fb.com>
 <20190228050643.958685-13-songliubraving@fb.com>
 <20190304135351.GL19809@krava> <01714139-9FE5-4DFF-A299-D758D1871BA0@fb.com>
 <20190304203713.GC2563@krava>
In-Reply-To: <20190304203713.GC2563@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::3:1d00]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c71566a5-0a16-4b6d-6503-08d6a0e20c7f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1824;
x-ms-traffictypediagnostic: MWHPR15MB1824:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1824;20:ZQOpY7F4b1OIrKNZpfvRmswyFEle1CP4iUfJF8xVRTn7mf2uYx8lwpM3vadqoC0ROxBKaviNcjwjKyIPo5sdXc+opsVZLSNT7G5/HYve78UWZ900kh1OtxKrYhMw8akeJnThkk1wg9pHulGXBZq+h5CzWBQXo8A03URaRU6xkKs=
x-microsoft-antispam-prvs: <MWHPR15MB182493B133EE3EEA24A295C5B3710@MWHPR15MB1824.namprd15.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(136003)(396003)(376002)(189003)(199004)(54906003)(6486002)(71190400001)(6512007)(53936002)(7736002)(6116002)(229853002)(71200400001)(478600001)(93886005)(86362001)(256004)(33656002)(316002)(36756003)(83716004)(4326008)(14454004)(5660300002)(76176011)(81166006)(82746002)(81156014)(99286004)(25786009)(6506007)(53546011)(2906002)(8676002)(57306001)(102836004)(6246003)(106356001)(105586002)(97736004)(6436002)(305945005)(486006)(68736007)(186003)(6916009)(50226002)(8936002)(446003)(11346002)(476003)(46003)(2616005)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1824;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: u/zHJsGWyMv75kDatoJU3sxmV6Z/gJXTe/4VwxINcRibWZkUotFf6NYonDQIiOwtFsrMRorG6L7P93hUh3yZude9kFrrrxRzqJXbAKv/3aOdvKR4xm8bC9eyMQbMGV1m887DrXYVt7EKY+cQqHX/QZVmgwGSQmLzt2AU5m8Ka7k3010k5Wmh0pXZNRjAZ0vai1TmaDnYPx2+/21QUXBHtmZwE648kViopGLv/p+VYxjNr3wd7HrGCwssSJ2zaw8tFoiLA0I/7kvenokZanrW9mcpgAc/ZxpiocXptjGu31Mdph+ZScwCjXMU8W1CR6wfSQCyAJY3up9PQz+j8yxpqaKnCIW5E1bUnpVyC4zpRwr/sqd+tWznFAY1JLkLNvGVR3d0o4OgnrI6/FCdFvEIV5sAUinaIOcWsFhIIZjOMAo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8F371E6DBAF64C4F9C896E492A9C8172@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c71566a5-0a16-4b6d-6503-08d6a0e20c7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 20:43:25.0320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1824
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-04_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 4, 2019, at 12:37 PM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Mon, Mar 04, 2019 at 07:45:00PM +0000, Song Liu wrote:
>>=20
>>=20
>>> On Mar 4, 2019, at 5:53 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>>>=20
>>> On Wed, Feb 27, 2019 at 09:06:40PM -0800, Song Liu wrote:
>>>=20
>>> SNIP
>>>=20
>>>> +	fflush(s);
>>>> +	do {
>>>> +		const struct bpf_line_info *linfo =3D NULL;
>>>> +		struct disasm_line *dl;
>>>> +		size_t prev_buf_size;
>>>> +		const char *srcline;
>>>> +		u64 addr;
>>>> +
>>>> +		addr =3D pc + ((u64 *)(info_linear->info.jited_ksyms))[sub_id];
>>>> +		count =3D disassemble(pc, &info);
>>>> +
>>>> +		if (prog_linfo)
>>>> +			linfo =3D bpf_prog_linfo__lfind_addr_func(prog_linfo,
>>>> +								addr, sub_id,
>>>> +								nr_skip);
>>>> +
>>>> +		if (linfo && btf) {
>>>> +			srcline =3D btf__name_by_offset(btf, linfo->line_off);
>>>> +			nr_skip++;
>>>> +		} else
>>>> +			srcline =3D NULL;
>>>> +
>>>> +		fprintf(s, "\n");
>>>> +		prev_buf_size =3D buf_size;
>>>> +		fflush(s);
>>>> +
>>>> +		if (!opts->hide_src_code && srcline) {
>>>> +			args->offset =3D -1;
>>>=20
>>> why's the offset not needed in here?
>>=20
>> This is the source code line. Based on my understanding of annotation
>> code, we put -1 for source code line. Did I misunderstand something?
>=20
> please double check, IIRC annotation_line__print will print
> just more info if offset is present, together with the source,
> but I haven't checked that code for some time, so I might be wrong
>=20
> jirka

In symbol__parse_objdump_line(), default offset is -1. And it is only=20
updated if line_ip is not -1. And line_ip for src code line is -1, so=20
offset for the source line is -1.=20

It works fine in the tests when I toggle source code on/off with key
's'.=20

Thanks
Song

