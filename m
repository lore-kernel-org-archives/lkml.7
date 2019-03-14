Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07101C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FE2217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="X5WJysly";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="YrBUSVM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbfCNFJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 01:09:44 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59908 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbfCNFJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 01:09:44 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2E53CoC008788;
        Wed, 13 Mar 2019 22:09:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=yjSDOoWOR8xzl1BykMjxizgq5ApeM9TOLmccrGe6GOE=;
 b=X5WJyslyKnQcjleE1yIA7fyGonm1FginbtRA5EQj+Ha6t2rDL6kVZSHDgbgn4X+QGYJ8
 6/JyLaF/hPLSG2lzwe7e8UmOv6y6AOlqq4rOcWeqrySBmRv5ug64BpTQt6xqO4hQxZz5
 7bY3grDDx1tKrW5pMVy0KO1SZ8QXIoiY1qg= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r7g5mr2nj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 13 Mar 2019 22:09:14 -0700
Received: from frc-mbx03.TheFacebook.com (2620:10d:c0a1:f82::27) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 13 Mar 2019 22:09:13 -0700
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-mbx03.TheFacebook.com (2620:10d:c0a1:f82::27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 13 Mar 2019 22:09:13 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 13 Mar 2019 22:09:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjSDOoWOR8xzl1BykMjxizgq5ApeM9TOLmccrGe6GOE=;
 b=YrBUSVM2Ymd/JbaDMuqrlzJjsxtQj1I8lMc2WBPQ+W5I4p+65OshozQCGlV93lt9Fh6pbJw1Hoxs+dTXHjTrAf9vzRa+lGDuoTEA0m1ba6sb30CJy9OuM4J7zDEiyilQYJswMBDJoK+Kfpv9e9oBpwugF4jK3lpUrqgH+C7Ohcc=
Received: from DM5PR15MB1163.namprd15.prod.outlook.com (10.173.208.149) by
 DM5PR15MB1833.namprd15.prod.outlook.com (10.174.247.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.21; Thu, 14 Mar 2019 05:08:57 +0000
Received: from DM5PR15MB1163.namprd15.prod.outlook.com
 ([fe80::70da:9dd8:a94b:43f]) by DM5PR15MB1163.namprd15.prod.outlook.com
 ([fe80::70da:9dd8:a94b:43f%7]) with mapi id 15.20.1709.011; Thu, 14 Mar 2019
 05:08:57 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "sdf@fomichev.me" <sdf@fomichev.me>
Subject: Re: [PATCH v9 perf,bpf 04/15] perf, bpf: synthesize bpf events with
 bpf_program__get_prog_info_linear()
Thread-Topic: [PATCH v9 perf,bpf 04/15] perf, bpf: synthesize bpf events with
 bpf_program__get_prog_info_linear()
Thread-Index: AQHU2JTXwZPPk3q4wkauSQW5gq/2fqYKJLpugAByJ4A=
Date:   Thu, 14 Mar 2019 05:08:56 +0000
Message-ID: <A61CCE47-BB1E-48BD-B8F5-C8289E5F7B2E@fb.com>
References: <20190312053051.2690567-1-songliubraving@fb.com>
 <20190312053051.2690567-5-songliubraving@fb.com>
 <20190313210030.GA16304@kernel.org> <20190313210840.GB4786@kernel.org>
In-Reply-To: <20190313210840.GB4786@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:180::aed1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 577e7536-e1b9-48fd-0a63-08d6a83b296c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1833;
x-ms-traffictypediagnostic: DM5PR15MB1833:
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1833;20:qYiEhwZ5Mc/NGgbE+8zMYe9YRhHjH3Yz95n3yigitg+0azJV+XxVOyH9aXHP1kGsF9Cn3jyRMLRU35dDkrybB3eDwxvkl3J/Gu7G38QLYgOGBhoDRvFNlDWyLhOFcJ3HxtzVxC+y2xRaDVX1KR95ivDG+14iFYGEPTLhnDN/jqc=
x-microsoft-antispam-prvs: <DM5PR15MB1833BD39D1920C5F1D130DEFB34B0@DM5PR15MB1833.namprd15.prod.outlook.com>
x-forefront-prvs: 09760A0505
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(346002)(396003)(136003)(189003)(199004)(6512007)(53936002)(68736007)(33656002)(186003)(54906003)(6116002)(316002)(6436002)(6486002)(14454004)(229853002)(6916009)(99286004)(8936002)(93886005)(105586002)(106356001)(486006)(2906002)(76176011)(7416002)(82746002)(4326008)(50226002)(25786009)(57306001)(478600001)(102836004)(7736002)(305945005)(6506007)(53546011)(8676002)(71190400001)(36756003)(476003)(71200400001)(83716004)(2616005)(6246003)(81156014)(11346002)(81166006)(97736004)(256004)(46003)(5660300002)(86362001)(446003)(142933001)(101420200001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1833;H:DM5PR15MB1163.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cEULvh7mUz1cnv5b8+CnBzhS+YJvP/0I17L5Ve2+3+j1iGA3DsX536AtuNfzFB47l7s1QOsb1mNPArcpRfoctHPs7C3MC6YoVfcU5HMbS/btxvBlLCPutvmEMn6AJ6GQ1ibH5cKOnJMdzkeSzR+Eq8qU8YXM/tEbou5tPvUxoTbYyx737gMlnx0xsJ8Nrc696B4cm/DWfWMwSTR2rpIj+N2n4/rO3pEHRj9NRT4Ch28f63396LRu2NzbIEegzK0w6GwHnul2K6xtjdNOiWDxmfFjORhNqj3j+inIuwXlbTzR8H/trQVTILiapTR3YEeGq3A3zNs+cMahNOEUnVVrjkgETOuJwQNU51MBaY5hbizsHDNcM6DXW5MBZdsndIWBrsCxAa8rrSuGa1FiUCh6BWmaloOisD8NDZQkV1/ybRs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9E996E5C51908D46826E372D42B99EBE@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 577e7536-e1b9-48fd-0a63-08d6a83b296c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2019 05:08:56.9555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1833
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-14_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 13, 2019, at 2:08 PM, Arnaldo Carvalho de Melo <arnaldo.melo@gmail=
.com> wrote:
>=20
> Em Wed, Mar 13, 2019 at 06:00:30PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
>> Em Mon, Mar 11, 2019 at 10:30:40PM -0700, Song Liu escreveu:
>>> -
>>> 	/* Synthesize PERF_RECORD_KSYMBOL */
>>> 	for (i =3D 0; i < sub_prog_cnt; i++) {
>>> +		u8 (*prog_tags)[BPF_TAG_SIZE] =3D (void *)(info->prog_tags);
>>=20
>> Need this:
>>=20
>> -               u8 (*prog_tags)[BPF_TAG_SIZE] =3D (void *)(info->prog_ta=
gs);
>> +               u8 (*prog_tags)[BPF_TAG_SIZE] =3D (u8 *)(info->prog_tags=
);
>>=20
>>=20
>> To overcome this on debian:experimental-x-mips, i.e. Debian Experimental
>> cross building to MIPS 32-bit:
>>=20
>> util/bpf-event.c: In function 'perf_event__synthesize_one_bpf_prog':
>> util/bpf-event.c:143:35: error: cast to pointer from integer of differen=
t size [-Werror=3Dint-to-pointer-cast]
>>   u8 (*prog_tags)[BPF_TAG_SIZE] =3D (void *)(info->prog_tags);
>>                                   ^
>> util/bpf-event.c:144:22: error: cast to pointer from integer of differen=
t size [-Werror=3Dint-to-pointer-cast]
>>   __u32 *prog_lens =3D (__u32 *)(info->jited_func_lens);
>>                      ^
>> util/bpf-event.c:145:23: error: cast to pointer from integer of differen=
t size [-Werror=3Dint-to-pointer-cast]
>>   __u64 *prog_addrs =3D (__u64 *)(info->jited_ksyms);
>>                       ^
>> util/bpf-event.c:146:22: error: cast to pointer from integer of differen=
t size [-Werror=3Dint-to-pointer-cast]
>>   void *func_infos =3D (void *)(info->func_info);
>>                      ^
>>  CC       /tmp/build/perf/util/pmu.o
>>  CC       /tmp/build/perf/util/pmu-flex.o
>> cc1: all warnings being treated as errors
>=20
> Argh, hit the send button too fast, that is not the only case and then
> my change just changed the error:
>=20
> util/bpf-event.c: In function 'perf_event__synthesize_one_bpf_prog':
> util/bpf-event.c:143:35: error: cast to pointer from integer of different=
 size [-Werror=3Dint-to-pointer-cast]
>   u8 (*prog_tags)[BPF_TAG_SIZE] =3D (u8 *)(info->prog_tags);
>                                   ^
> util/bpf-event.c:143:35: error: initialization of 'u8 (*)[8]' {aka 'unsig=
ned char (*)[8]'} from incompatible pointer type 'u8 *' {aka 'unsigned char=
 *'} [-Werror=3Dincompatible-pointer-types]
> util/bpf-event.c:144:22: error: cast to pointer from integer of different=
 size [-Werror=3Dint-to-pointer-cast]
>   __u32 *prog_lens =3D (__u32 *)(info->jited_func_lens);
>                      ^
> util/bpf-event.c:145:23: error: cast to pointer from integer of different=
 size [-Werror=3Dint-to-pointer-cast]
>   __u64 *prog_addrs =3D (__u64 *)(info->jited_ksyms);
>                       ^
> util/bpf-event.c:146:22: error: cast to pointer from integer of different=
 size [-Werror=3Dint-to-pointer-cast]
>   void *func_infos =3D (void *)(info->func_info);
>                      ^
>  CC       /tmp/build/perf/util/pmu.o
>  CC       /tmp/build/perf/util/pmu-flex.o
> cc1: all warnings being treated as errors
> mv: cannot stat '/tmp/build/perf/util/.bpf-event.o.tmp': No such file or =
directory
>=20

We can fix it with the following:

-               u8 (*prog_tags)[BPF_TAG_SIZE] =3D (void *)(info->prog_tags)=
;
-               __u32 *prog_lens =3D (__u32 *)(info->jited_func_lens);
-               __u64 *prog_addrs =3D (__u64 *)(info->jited_ksyms);
-               void *func_infos =3D (void *)(info->func_info);
+               u8 (*prog_tags)[BPF_TAG_SIZE] =3D (void *)(intptr_t)(info->=
prog_tags);
+               __u32 *prog_lens =3D (__u32 *)(intptr_t)(info->jited_func_l=
ens);
+               __u64 *prog_addrs =3D (__u64 *)(intptr_t)(info->jited_ksyms=
);
+               void *func_infos =3D (void *)(intptr_t)(info->func_info);

Thanks,
Song

