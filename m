Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5132AC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1892520851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="pYRUU0JY";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="VFStiZF+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfCGRWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:22:24 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53160 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726172AbfCGRWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:22:24 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x27HKqUZ022541;
        Thu, 7 Mar 2019 09:21:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Nzr2pGW94dfSg5zL0CwVl2Km94fNFDn1igIRLjhB99M=;
 b=pYRUU0JYbxqdphed6P1Ugs/D4ZqBXyAR/n0oLeN61FirEe6Rzm+8FbkMungmDYF9ALpI
 IDTRzxdMEC7cDIGgWLwJfINQ73xbYt6lGBiUdPEmd+B33/YqLfxfympueF0TnC5jgNSI
 5yCgWWlQ+PFSxD6PLXqwsuNxwcsEAa7DY5Q= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r37m8r05n-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 07 Mar 2019 09:21:56 -0800
Received: from frc-mbx04.TheFacebook.com (192.168.155.19) by
 frc-hub04.TheFacebook.com (192.168.177.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 7 Mar 2019 09:20:29 -0800
Received: from frc-hub05.TheFacebook.com (192.168.177.75) by
 frc-mbx04.TheFacebook.com (192.168.155.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 7 Mar 2019 09:20:29 -0800
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 7 Mar 2019 09:20:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nzr2pGW94dfSg5zL0CwVl2Km94fNFDn1igIRLjhB99M=;
 b=VFStiZF+oMnFpfpf+fm+zm3/EYAAtS14iHoSWOAAophUeWMlzOu9t6Fxo33d03mPS4U/cGu6vnl3yH3QAkLIlQL1Kjv+RDdB54eX8ftJsH+iC0LnwCwc0dIaG/UjmPk52TsyO+hvDJuN4YYIQyn0dF5xw9KFg2kulYQ1qD4Zwgk=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1549.namprd15.prod.outlook.com (10.173.235.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Thu, 7 Mar 2019 17:20:26 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065%6]) with mapi id 15.20.1665.021; Thu, 7 Mar 2019
 17:20:26 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v6 perf,bpf 06/15] perf, bpf: save bpf_prog_info in a
 rbtree in perf_env
Thread-Topic: [PATCH v6 perf,bpf 06/15] perf, bpf: save bpf_prog_info in a
 rbtree in perf_env
Thread-Index: AQHU0+xZMMlTcbdY6kWz78hkxUVw/6YANd8AgAA2YoA=
Date:   Thu, 7 Mar 2019 17:20:26 +0000
Message-ID: <E852B54E-AEA6-4C2C-A756-DA9325C35FEE@fb.com>
References: <20190306071359.2359896-1-songliubraving@fb.com>
 <20190306071359.2359896-7-songliubraving@fb.com>
 <20190307140546.GC7233@krava>
In-Reply-To: <20190307140546.GC7233@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::3:415b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80abf55e-e032-49ae-70a8-08d6a32130df
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1549;
x-ms-traffictypediagnostic: MWHPR15MB1549:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1549;20:bV3i1FKCAMy9qwibu1BI6+YVowipzczN6DRr1KnBAeiEYycE3isym3OER+fqyki3ccNbkaR6tYuenNwAh6SfcFsl/jEll99/Yr7vqlHhd6WWMm5Zq219OrZbiQNsqSjsbVU/KoHEA7tJ0DMYchLgq20Y5JPvl+zmZtnN4IhwxWQ=
x-microsoft-antispam-prvs: <MWHPR15MB1549A81A8106D5416E5B3F25B34C0@MWHPR15MB1549.namprd15.prod.outlook.com>
x-forefront-prvs: 096943F07A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(346002)(376002)(396003)(189003)(199004)(51914003)(54534003)(54906003)(33656002)(71190400001)(71200400001)(11346002)(186003)(6486002)(82746002)(6436002)(229853002)(478600001)(6916009)(486006)(256004)(68736007)(53936002)(83716004)(316002)(2616005)(8936002)(50226002)(57306001)(6512007)(476003)(5660300002)(446003)(106356001)(105586002)(7736002)(99286004)(81166006)(46003)(8676002)(14454004)(2906002)(81156014)(102836004)(305945005)(53546011)(6506007)(7416002)(6116002)(76176011)(4326008)(97736004)(25786009)(36756003)(6246003)(86362001)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1549;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FakjSkFR78VB5p+/Szi06W5J9dS/sj+JAzrH5gDSxBishFgndHNKEWquahJmJ3kXPO9h/n9YrNBPmA0ms8hKicIBvxY1eoUg3rpt+PL6ofgOgCqo9cHl3mYQjpJhR1jqWTPfsKiCSGGoSBNrMEWVSNd6OIeBQJRJHRt5OCSqTPXnvhuNFqBoQiz69D90Dvr+uQx2hNLU8U+t9G+ZIGlfEKdY9ZoDqcUukjkQXYsWLksNAB5z57nZSQe7x0A4A3cbHX+gpbI4HQu45MyWDdg6p28V//zopd5DOqJLZdc9zmLjhRmd/fYEm0M3WvteD/uwECjZzlznrnisHRZhS8GcqNAoq4WkXwtP5fv/0mXGJgTwQFoPaYImUYf/HlnIFgxKVnNgyXAL8ZlEDd+LhWANMHRDTWBh7iedhqS6L0gYILM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4CEAE0F39F598B44813464DBB8B7D53E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 80abf55e-e032-49ae-70a8-08d6a32130df
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2019 17:20:26.6710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1549
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-07_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 7, 2019, at 6:05 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Tue, Mar 05, 2019 at 11:13:50PM -0800, Song Liu wrote:
>> bpf_prog_info contains information necessary to annotate bpf programs.
>> This patch saves bpf_prog_info for bpf programs loaded in the system.
>>=20
>> Some big picture of the next few patches:
>>=20
>> To fully annotate BPF programs with source code mapping, 4 different
>> information are needed:
>>    1) PERF_RECORD_KSYMBOL
>>    2) PERF_RECORD_BPF_EVENT
>>    3) bpf_prog_info
>>    4) btf
>>=20
>> Before this set, 1) and 2) in the list are already saved to perf.data
>> file. For BPF programs that are already loaded before perf run, 1) and 2=
)
>> are synthesized by perf_event__synthesize_bpf_events(). For short living
>> BPF programs, 1) and 2) are generated by kernel.
>>=20
>> This set handles 3) and 4) from the list. Again, it is necessary to hand=
le
>> existing BPF program and short living program separately.
>>=20
>> This patch handles 3) for exising BPF programs while synthesizing 1) and
>> 2) in perf_event__synthesize_bpf_events(). These data are stored in
>> perf_env. The next patch saves these data from perf_env to perf.data as
>> headers.
>>=20
>> Similarly, the two patches after the next saves 4) of existing BPF
>> programs to perf_env and perf.data.
>>=20
>> Another patch later will handle 3) and 4) for short living BPF programs
>> by monitoring 1) and 2) in a dedicate thread.
>>=20
>=20
> thanks for the changelog
>=20
> SNIP
>=20
>> +
>> +		/* save bpf_prog_info to env */
>> +		info_node =3D malloc(sizeof(struct bpf_prog_info_node));
>> +
>> +		/*
>> +		 * Do not bail out for !info_node, as we still want to
>> +		 * call  perf_tool__process_synth_event()
>> +		 */
>=20
> well, we are out of memory, so I dont think perf_tool__process_synth_even=
t
> will get too far.. also the perf_env data would be inconsistent with what
> you store as event.. how can that work?
>=20
> jirka

Yeah, that makes sense. Let's bail out then.=20

Thanks,
Song

>> +		if (info_node) {
>> +			info_node->info_linear =3D info_linear;
>> +			perf_env__insert_bpf_prog_info(env, info_node);
>> +			info_linear =3D NULL;
>> +		}
>=20
> SNIP

