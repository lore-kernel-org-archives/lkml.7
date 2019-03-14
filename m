Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A36C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1BC42087C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="qsvvZF1P";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="GRE2prQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbfCNQpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:45:49 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47920 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726157AbfCNQps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:45:48 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2EGiBE7022194;
        Thu, 14 Mar 2019 09:45:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=HfXNOjSwOLLJqI/AMANmonf6+KfpjU0YtBB9niQH/sQ=;
 b=qsvvZF1Ph33IAN6ndndnGlLNsC+nDAG1J47UYMYAQZDlQZYRuM57I+dHRDks50QGonmM
 f8QpZcFBnCX/Wz2uqaRvExD03zUC7O0Dopx5nrW7KveOyJScAtEoNGrI5jXXJKwF16qi
 n/X852E91KSKUIj8woG8gV7Fu8gg1KPNn3k= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r7h3g1vfa-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 14 Mar 2019 09:45:26 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 14 Mar 2019 09:45:24 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 14 Mar 2019 09:45:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfXNOjSwOLLJqI/AMANmonf6+KfpjU0YtBB9niQH/sQ=;
 b=GRE2prQJ9auqk/fws4+6HKA+WWJErATVE2Ex13z1ybs6tCqVsKE7A0lKjxUOzQ+nnx7pBbVzzLSWVjl9pD60+Q24DTDN42zdPA84TlwAo4XxjaV7C0GrkrktZ8bMgBBOcKGvqgm2g9q1mivCkgfq199FMKeNvKWgmHANhXXiYgI=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1373.namprd15.prod.outlook.com (10.173.233.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Thu, 14 Mar 2019 16:45:22 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065%6]) with mapi id 15.20.1709.011; Thu, 14 Mar 2019
 16:45:22 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Kernel Team" <Kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "sdf@fomichev.me" <sdf@fomichev.me>
Subject: Re: [PATCH v9 perf,bpf 04/15] perf, bpf: synthesize bpf events with
 bpf_program__get_prog_info_linear()
Thread-Topic: [PATCH v9 perf,bpf 04/15] perf, bpf: synthesize bpf events with
 bpf_program__get_prog_info_linear()
Thread-Index: AQHU2JTXwZPPk3q4wkauSQW5gq/2fqYKJLpugAByJ4CAAMKVgA==
Date:   Thu, 14 Mar 2019 16:45:22 +0000
Message-ID: <741F3DF8-F95F-4521-BD46-B31A675D8E76@fb.com>
References: <20190312053051.2690567-1-songliubraving@fb.com>
 <20190312053051.2690567-5-songliubraving@fb.com>
 <20190313210030.GA16304@kernel.org> <20190313210840.GB4786@kernel.org>
 <A61CCE47-BB1E-48BD-B8F5-C8289E5F7B2E@fb.com>
In-Reply-To: <A61CCE47-BB1E-48BD-B8F5-C8289E5F7B2E@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::1e38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a58ca76-899e-429d-006c-08d6a89c734a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1373;
x-ms-traffictypediagnostic: MWHPR15MB1373:
x-microsoft-antispam-prvs: <MWHPR15MB1373633F4E4E9695BE86B7F3B34B0@MWHPR15MB1373.namprd15.prod.outlook.com>
x-forefront-prvs: 09760A0505
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(136003)(39860400002)(189003)(199004)(50226002)(186003)(6436002)(446003)(33656002)(82746002)(106356001)(105586002)(8936002)(46003)(81166006)(81156014)(8676002)(4326008)(93886005)(7416002)(305945005)(6916009)(476003)(11346002)(2616005)(486006)(97736004)(2906002)(57306001)(7736002)(6512007)(6246003)(53546011)(256004)(6506007)(6486002)(83716004)(229853002)(14454004)(76176011)(36756003)(25786009)(68736007)(478600001)(102836004)(86362001)(99286004)(53936002)(71190400001)(71200400001)(316002)(6116002)(5660300002)(54906003)(101420200001)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1373;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3X2tSZ9goXBFU8D7OAdayigxp16Z0Vu4ltZ5xfK3rENdFRzc++6ZJb4NGfNJdCYRrW5gYVDHd/yF9lbp9qTicBw9P1t1oJWsgDsytSCunG4N4Zgy8vonMzWBYphFTGPBfY9/boMuPp3R2r+q3NU8hHEBgYpNLpwhIyfAc2bJN1R3m324DDFO9WYGv/WB3owRdXVA4q7aRyx3IxE2WYGFKmjBR3MLDAUXMjDH5rjEGZpte7TvI59nDRuISntRVyLNsAeFJOIHYdNRj3U+Z1In09gNZzUgiGJmV+/Vjw95o4vu5k59Be3flTkTpKxJb8YYH65bO5eRYkOdV9KFGfkMNpjLpMHRBPBvfbNEsGEkl66bUXL/7gJA2wOF29XwN8WNlgbcOp0RYHn4IrOcr1tq3v0rvwE6FNZ9qs1xHqcRXdA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FB69C9E694233F4B8295557C050F2FA1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a58ca76-899e-429d-006c-08d6a89c734a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2019 16:45:22.0296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1373
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-14_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 13, 2019, at 10:08 PM, Song Liu <songliubraving@fb.com> wrote:
>=20
>=20
>=20
>> On Mar 13, 2019, at 2:08 PM, Arnaldo Carvalho de Melo <arnaldo.melo@gmai=
l.com> wrote:
>>=20
>> Em Wed, Mar 13, 2019 at 06:00:30PM -0300, Arnaldo Carvalho de Melo escre=
veu:
>>> Em Mon, Mar 11, 2019 at 10:30:40PM -0700, Song Liu escreveu:
>>>> -
>>>> 	/* Synthesize PERF_RECORD_KSYMBOL */
>>>> 	for (i =3D 0; i < sub_prog_cnt; i++) {
>>>> +		u8 (*prog_tags)[BPF_TAG_SIZE] =3D (void *)(info->prog_tags);
>>>=20
>>> Need this:
>>>=20
>>> -               u8 (*prog_tags)[BPF_TAG_SIZE] =3D (void *)(info->prog_t=
ags);
>>> +               u8 (*prog_tags)[BPF_TAG_SIZE] =3D (u8 *)(info->prog_tag=
s);
>>>=20
>>>=20
>>> To overcome this on debian:experimental-x-mips, i.e. Debian Experimenta=
l
>>> cross building to MIPS 32-bit:
>>>=20
>>> util/bpf-event.c: In function 'perf_event__synthesize_one_bpf_prog':
>>> util/bpf-event.c:143:35: error: cast to pointer from integer of differe=
nt size [-Werror=3Dint-to-pointer-cast]
>>>  u8 (*prog_tags)[BPF_TAG_SIZE] =3D (void *)(info->prog_tags);
>>>                                  ^
>>> util/bpf-event.c:144:22: error: cast to pointer from integer of differe=
nt size [-Werror=3Dint-to-pointer-cast]
>>>  __u32 *prog_lens =3D (__u32 *)(info->jited_func_lens);
>>>                     ^
>>> util/bpf-event.c:145:23: error: cast to pointer from integer of differe=
nt size [-Werror=3Dint-to-pointer-cast]
>>>  __u64 *prog_addrs =3D (__u64 *)(info->jited_ksyms);
>>>                      ^
>>> util/bpf-event.c:146:22: error: cast to pointer from integer of differe=
nt size [-Werror=3Dint-to-pointer-cast]
>>>  void *func_infos =3D (void *)(info->func_info);
>>>                     ^
>>> CC       /tmp/build/perf/util/pmu.o
>>> CC       /tmp/build/perf/util/pmu-flex.o
>>> cc1: all warnings being treated as errors
>>=20
>> Argh, hit the send button too fast, that is not the only case and then
>> my change just changed the error:
>>=20
>> util/bpf-event.c: In function 'perf_event__synthesize_one_bpf_prog':
>> util/bpf-event.c:143:35: error: cast to pointer from integer of differen=
t size [-Werror=3Dint-to-pointer-cast]
>>  u8 (*prog_tags)[BPF_TAG_SIZE] =3D (u8 *)(info->prog_tags);
>>                                  ^
>> util/bpf-event.c:143:35: error: initialization of 'u8 (*)[8]' {aka 'unsi=
gned char (*)[8]'} from incompatible pointer type 'u8 *' {aka 'unsigned cha=
r *'} [-Werror=3Dincompatible-pointer-types]
>> util/bpf-event.c:144:22: error: cast to pointer from integer of differen=
t size [-Werror=3Dint-to-pointer-cast]
>>  __u32 *prog_lens =3D (__u32 *)(info->jited_func_lens);
>>                     ^
>> util/bpf-event.c:145:23: error: cast to pointer from integer of differen=
t size [-Werror=3Dint-to-pointer-cast]
>>  __u64 *prog_addrs =3D (__u64 *)(info->jited_ksyms);
>>                      ^
>> util/bpf-event.c:146:22: error: cast to pointer from integer of differen=
t size [-Werror=3Dint-to-pointer-cast]
>>  void *func_infos =3D (void *)(info->func_info);
>>                     ^
>> CC       /tmp/build/perf/util/pmu.o
>> CC       /tmp/build/perf/util/pmu-flex.o
>> cc1: all warnings being treated as errors
>> mv: cannot stat '/tmp/build/perf/util/.bpf-event.o.tmp': No such file or=
 directory
>>=20
>=20
> We can fix it with the following:
>=20
> -               u8 (*prog_tags)[BPF_TAG_SIZE] =3D (void *)(info->prog_tag=
s);
> -               __u32 *prog_lens =3D (__u32 *)(info->jited_func_lens);
> -               __u64 *prog_addrs =3D (__u64 *)(info->jited_ksyms);
> -               void *func_infos =3D (void *)(info->func_info);
> +               u8 (*prog_tags)[BPF_TAG_SIZE] =3D (void *)(intptr_t)(info=
->prog_tags);
> +               __u32 *prog_lens =3D (__u32 *)(intptr_t)(info->jited_func=
_lens);
> +               __u64 *prog_addrs =3D (__u64 *)(intptr_t)(info->jited_ksy=
ms);
> +               void *func_infos =3D (void *)(intptr_t)(info->func_info);
>=20
> Thanks,
> Song

Actually, I think uintptr_t is better than intptr_t here.=20

Thanks,
Song=
