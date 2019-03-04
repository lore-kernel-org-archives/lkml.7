Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5D1C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D8A20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ouUO7uKY";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="LVlcBZRT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfCDUcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:32:16 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:32968 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726268AbfCDUcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:32:16 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x24KQNsK013617;
        Mon, 4 Mar 2019 12:31:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=hOBckuNn7km8xRqkM75ojwVDBdMKqN8UFU9niFKjBds=;
 b=ouUO7uKYpwfXWe3zQbZ4obB4w1AuyyM4vJWBzqZUOOcSzGlCDuP5vE/hS12MOuSQqGcH
 yKEYA5m3oPbmn0msQ/xnxI0lhtofE5cfwzd9NisrP3+xkpEV2gJmsImSqjb89XTYbdTw
 n9jIGcb/OCZfUFQQLeMA8ZcZWvBC2gs/B6A= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r19wg88v7-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 04 Mar 2019 12:31:48 -0800
Received: from frc-mbx08.TheFacebook.com (192.168.155.29) by
 frc-hub04.TheFacebook.com (192.168.177.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 4 Mar 2019 12:31:47 -0800
Received: from frc-hub06.TheFacebook.com (192.168.177.76) by
 frc-mbx08.TheFacebook.com (192.168.155.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 4 Mar 2019 12:31:47 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 4 Mar 2019 12:31:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOBckuNn7km8xRqkM75ojwVDBdMKqN8UFU9niFKjBds=;
 b=LVlcBZRT4ohFqInkMPrYaYsN6BQOT5ZosAMtz5jW2JFIdV938irsTC/b9ouxORxBffX5he20tJTyjNcB5k0dIarvPyu4/crtiEAzMMiCrfp4Q07awv2Lz6JycWoGGTnes582fhXyyFc6ro9YXW0HQoa6+7fZIpNLig0heNHY+2g=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1373.namprd15.prod.outlook.com (10.173.233.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.16; Mon, 4 Mar 2019 20:31:45 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065%6]) with mapi id 15.20.1665.020; Mon, 4 Mar 2019
 20:31:45 +0000
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
Thread-Index: AQHUzyOP1AVZWxR1lEa6YX4LDOvnT6X7hKUAgABgIYCAAA0tgIAAAlYA
Date:   Mon, 4 Mar 2019 20:31:45 +0000
Message-ID: <9E1C731F-3AA9-4109-8696-A61730902312@fb.com>
References: <20190228050643.958685-1-songliubraving@fb.com>
 <20190228050643.958685-8-songliubraving@fb.com>
 <20190304135210.GB19809@krava> <CE031049-FB10-4BB5-BCA1-EA48C5BF882B@fb.com>
 <20190304202323.GA2563@krava>
In-Reply-To: <20190304202323.GA2563@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [199.201.64.136]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7c331a7-34b0-4eae-ea09-08d6a0e06b67
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1373;
x-ms-traffictypediagnostic: MWHPR15MB1373:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1373;20:Hc1vYxQFslHSQ6Kw5wPomb///YwNkAk6fFbCeL79G7vixqzEgjCATlo9U+fD0V6cxEkdy1++DWEOsMro1Vht7mo5NoVJq/MOXOeFpJ41AZVHEgT3Qwi39ahKlnNUqtyoW1qM+qcTH6zD765LFBbXvpucbT0r+OjBqFQ+PpbQdzI=
x-microsoft-antispam-prvs: <MWHPR15MB137368B825710E0732EA8C52B3710@MWHPR15MB1373.namprd15.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(376002)(39860400002)(136003)(199004)(189003)(53936002)(14444005)(256004)(68736007)(6436002)(76176011)(105586002)(102836004)(99286004)(8676002)(3846002)(83716004)(71190400001)(71200400001)(186003)(26005)(6116002)(81156014)(81166006)(86362001)(106356001)(229853002)(93886005)(66066001)(8936002)(36756003)(54906003)(2906002)(14454004)(6916009)(316002)(25786009)(50226002)(5660300002)(486006)(2616005)(305945005)(476003)(57306001)(6486002)(6512007)(97736004)(6506007)(33656002)(6246003)(53546011)(7736002)(82746002)(11346002)(478600001)(446003)(4326008)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1373;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eJ8SEQplZeqsvqaTQj0JW/9NnqS1j9cImFf3NwijFAUBcxcWt/Ju26Wy68rvuPb30OMBK3X6G5oXUrvqfUddYbnJXR7OUMbI7ea7r027esU5kaW8nvypWPIHXCzLOXcM/BT5YaTJ0BRAodzZwxa5VD/9NhxycFHb/z6+Tkw+9fqimGw9EfoVqQfAGtqob+dtOfOnd9FonfPaBvGk34HSFaU7B8VmuLCeJbcVdhDR7jdd06RDUfcSYYt/eyFGRMsS4GXVYpORBvTzDjXPF1O0vUK5xXMHfsIwGOmrXBqIEabVVeKzbUQRyg8+jRxgJ2NT7JpV2nADG7tXzn7Lgg9D49yXFBAtv52sdUMBbXaT1HGCjwLIkEYumqOplxWK+XNi5gF/vLSihAV2KQkutwWAnJme6AXmEuAa0h+cCcWObaM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F6EF547AD240DD4A944B2E280948A930@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c331a7-34b0-4eae-ea09-08d6a0e06b67
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 20:31:45.3373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1373
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-04_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 4, 2019, at 12:23 PM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Mon, Mar 04, 2019 at 07:36:14PM +0000, Song Liu wrote:
>>=20
>>=20
>>> On Mar 4, 2019, at 5:52 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>>>=20
>>> On Wed, Feb 27, 2019 at 09:06:35PM -0800, Song Liu wrote:
>>>=20
>>> SNIP
>>>=20
>>>> +static int process_bpf_prog_info(struct feat_fd *ff,
>>>> +				 void *data __maybe_unused)
>>>> +{
>>>> +	struct bpf_prog_info_linear *info_linear;
>>>> +	struct bpf_prog_info_node *info_node;
>>>> +	struct perf_env *env =3D &ff->ph->env;
>>>> +	u32 count, i;
>>>> +	int err =3D -1;
>>>> +
>>>> +	if (do_read_u32(ff, &count))
>>>> +		return -1;
>>>> +
>>>> +	down_write(&env->bpf_progs.lock);
>>>> +
>>>> +	for (i =3D 0; i < count; ++i) {
>>>> +		u32 info_len, data_len;
>>>> +
>>>> +		info_linear =3D NULL;
>>>> +		info_node =3D NULL;
>>>> +		if (do_read_u32(ff, &info_len))
>>>> +			goto out;
>>>> +		if (do_read_u32(ff, &data_len))
>>>> +			goto out;
>>>> +
>>>> +		if (info_len > sizeof(struct bpf_prog_info)) {
>>>> +			pr_warning("detected invalid bpf_prog_info\n");
>>>> +			goto out;
>>>> +		}
>>>> +
>>>> +		info_linear =3D malloc(sizeof(struct bpf_prog_info_linear) +
>>>> +				     data_len);
>>>> +		if (!info_linear)
>>>> +			goto out;
>>>> +		info_linear->info_len =3D sizeof(struct bpf_prog_info);
>>>> +		info_linear->data_len =3D data_len;
>>>> +		if (do_read_u64(ff, (u64 *)(&info_linear->arrays)))
>>>> +			goto out;
>>>> +		if (__do_read(ff, &info_linear->info, info_len))
>>>> +			goto out;
>>>> +		if (info_len < sizeof(struct bpf_prog_info))
>>>> +			memset(((void *)(&info_linear->info)) + info_len, 0,
>>>> +			       sizeof(struct bpf_prog_info) - info_len);
>>>> +
>>>> +		if (__do_read(ff, info_linear->data, data_len))
>>>> +			goto out;
>>>> +
>>>> +		/* endian mismatch, drop the info, continue */
>>>> +		if (ff->ph->needs_swap) {
>>>> +			free(info_linear);
>>>> +			continue;
>>>> +		}
>>>=20
>>> so in this case we can check for needs_swap in the begining
>>> of the function and bail out without reading all the data
>>=20
>> If we bail out, perf-record will fail. If we read all the data=20
>> but ignore them, perf-record will continue without bpf annotation=20
>> support. I think the latter is a better experience with little=20
>> effort here.=20
>=20
> i did not mean bail out with error, just return 0, warn and go on
>=20
> jirka

In this case, do we need to read and discard all the data? If not,=20
the next header type (or data) will interpret these data as=20
something else, right? Or did I miss some protection against such
cases?

Thanks,
Song

>=20
>>=20
>>>=20
>>> also please display soem error message saying we don't support
>>> ebpf progs data report over the different endianity
>>=20
>> I will add a warning in the next version.=20
>>=20
>> Thanks,
>> Song
>>=20

