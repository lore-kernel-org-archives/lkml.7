Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C3EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBE52084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="pqPp7pu1";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="L4iknuZ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfCKOQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:16:50 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49226 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727524AbfCKOQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:16:49 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2BE83xv025992;
        Mon, 11 Mar 2019 07:16:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=qaG3behjtkvXDXrF/MqjG1WPh+Yi5FghDDRgLqxYcvY=;
 b=pqPp7pu1ouQCO64BSnHUi6slj+6mNEEuTRtG2PHFFA60iOq2GfOYlkjomv3H1VQ3d/bJ
 O3O5bYmzuBrSBzfVXySZ2HOKA6ZiufthWTLqkGLzF1vfcq5AR+LUc46rVHPYNZ1GCo6N
 eyBv3l/JshngrEYC1zWrks5w0PD+iTueBY0= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r5r8v07y3-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 11 Mar 2019 07:16:17 -0700
Received: from frc-mbx03.TheFacebook.com (2620:10d:c0a1:f82::27) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 11 Mar 2019 07:16:15 -0700
Received: from frc-hub06.TheFacebook.com (2620:10d:c021:18::176) by
 frc-mbx03.TheFacebook.com (2620:10d:c0a1:f82::27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 11 Mar 2019 07:16:14 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 11 Mar 2019 07:16:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaG3behjtkvXDXrF/MqjG1WPh+Yi5FghDDRgLqxYcvY=;
 b=L4iknuZ5gYMylEskhtTlfQDexuWQKYwlxI53Yp3OeMKcAmk1ABSXUnUDtba/QCgu6tB1hnv+QGZxo1dGX+xoBBiczpzGiw7igJqeauQ77p+IrTKDtoxnL4vXgRgCGm9quJX1pmo2E7sDPFheXg8imxUSqysgQe5xhGPX8UA/2VA=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1952.namprd15.prod.outlook.com (10.175.8.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Mon, 11 Mar 2019 14:16:12 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065%6]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 14:16:12 +0000
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
Subject: Re: [PATCH v7 perf,bpf 00/15] perf annotation of BPF programs
Thread-Topic: [PATCH v7 perf,bpf 00/15] perf annotation of BPF programs
Thread-Index: AQHU1Q9rEcvPzV2+4keApk5iOSJqDqYGezEAgAAEpIA=
Date:   Mon, 11 Mar 2019 14:16:12 +0000
Message-ID: <DAC2D672-4A5C-42CF-A9ED-743574AFE9BD@fb.com>
References: <20190307175810.249857-1-songliubraving@fb.com>
 <20190311135934.GA7160@krava>
In-Reply-To: <20190311135934.GA7160@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:180::6130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30f73614-c168-4c7e-70e7-08d6a62c1dcd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1952;
x-ms-traffictypediagnostic: MWHPR15MB1952:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1952;20:BUZyg+wGLZEho2z4WRu8yOfbKf6d6+xyM7KZ7Qh+TOsN9tBhVDJRwIO4g4g5PdE4RDh5XFgMu5xiSc1KfSwNR4aOcHbzLf1NHy5r3yRNS57CGqNOpsORST5x43PKxL4XOe7iTAutyTAzrP5deQaowDN49ig93mTW3nhBWRkxdYU=
x-microsoft-antispam-prvs: <MWHPR15MB19522CF01BCB6CACF1DA2CE7B3480@MWHPR15MB1952.namprd15.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(366004)(346002)(396003)(136003)(189003)(199004)(486006)(6436002)(105586002)(53546011)(7736002)(106356001)(6512007)(7416002)(102836004)(5660300002)(966005)(99286004)(229853002)(33656002)(50226002)(6116002)(86362001)(6486002)(81156014)(6506007)(8676002)(68736007)(478600001)(305945005)(6916009)(81166006)(8936002)(76176011)(36756003)(71200400001)(83716004)(71190400001)(11346002)(53936002)(446003)(46003)(256004)(14444005)(54906003)(316002)(6246003)(57306001)(2906002)(2616005)(14454004)(4326008)(82746002)(25786009)(186003)(97736004)(476003)(6306002)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1952;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pQYxVa17gTmMYyXdloFmp4SZSIYcv9KeilqipUgXUxLFHNpYUAOxdzZ8QuE0jT/ypsE0LxNu9j86qEBapJGytKbhy3COts/MHlXbJvFEdq8WEPj52n9J1qzCuvS1GEcAZWT3FkFDtMWFJNkP2cNTnDMT1IyhipL5wi4YgtqbCzdnPTK3QZ8CbhN7FXsymhKqybtORJerkyzH9BNdO9dtxknnbLA2wJ4uDVdoDbTuFGLpUNGdAe2enjBpFxX/+oADbGYyA2twZYG4yw34a7gt6SRJ0PCs6s+PIQFUyOB+T1rGrvjzaHjz1FQOR2ZIhrJwlqV8q2nO2B25IcRVv94Wv9W0MYGVOCvQZa621oaKXKZukARONXnh3PNGQZz1MFvfGQ2+vEOP2DsD2bThpD56TUosOACl+UKBrjlXeyj/8aM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DAFD1442B09F634495E91D9573622475@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f73614-c168-4c7e-70e7-08d6a62c1dcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 14:16:12.6807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1952
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-11_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 11, 2019, at 6:59 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Thu, Mar 07, 2019 at 09:57:55AM -0800, Song Liu wrote:
>=20
> SNIP
>=20
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Note on =
patch dependency  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>> This set has dependency in both bpf-next tree and tip/perf/core. Current
>> version is developed on bpf-next tree with the following commits
>> cherry-picked from tip/perf/core (or acme/perf/core):
>>=20
>> (from 1/11 to 11/11)
>> commit 76193a94522f ("perf, bpf: Introduce PERF_RECORD_KSYMBOL")
>> commit d764ac646491 ("tools headers uapi: Sync tools/include/uapi/linux/=
perf_event.h")
>> commit 6ee52e2a3fe4 ("perf, bpf: Introduce PERF_RECORD_BPF_EVENT")
>> commit df063c83aa2c ("tools headers uapi: Sync tools/include/uapi/linux/=
perf_event.h")
>> commit 9aa0bfa370b2 ("perf tools: Handle PERF_RECORD_KSYMBOL")
>> commit 45178a928a4b ("perf tools: Handle PERF_RECORD_BPF_EVENT")
>> commit 7b612e291a5a ("perf tools: Synthesize PERF_RECORD_* for loaded BP=
F programs")
>> commit a40b95bcd30c ("perf top: Synthesize BPF events for pre-existing l=
oaded BPF programs")
>> commit 6934058d9fb6 ("bpf: Add module name [bpf] to ksymbols for bpf pro=
grams")
>> commit 811184fb6977 ("perf bpf: Fix synthesized PERF_RECORD_KSYMBOL/BPF_=
EVENT")
>> comimt 94816add0005 ("perf tools: Add perf_exe() helper to find perf bin=
ary")
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> This set is also available at:
>>=20
>> https://github.com/liu-song-6/linux/tree/bpf-annotation
>=20
> could you please update the branch? it seems to have still the old versio=
n
>=20
> thanks,
> jirka

Just updated. Sorry for the confusion.=20

Song=
