Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B67C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4665B214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Jxlnaf7y";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="B0MvJ6Lk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbfCKVCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:02:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37182 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727660AbfCKVCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:02:20 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2BKutGJ012384;
        Mon, 11 Mar 2019 14:01:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=vFGu6UqDt/yu0oMB1Xc6TPFLbAwQuSuz6EJsTpyns8U=;
 b=Jxlnaf7yXQfEx7A2KGiWiLnaxEwOMmPvKPn0bFdR25jzTUKvEd/fGYZ3Zm6vPjLfZsj7
 NDOmQvyYl9SI3+YVxk1Il7Wh7xGLyXmkBK1P9y+ZZ9zFeS+GYXqlq/nrJ/BXUBPhMBld
 +zV61G53zirLfJjEcrXwVvRtB31KsqD2Xpo= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r5v488q6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 11 Mar 2019 14:01:52 -0700
Received: from frc-hub02.TheFacebook.com (2620:10d:c021:18::172) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 11 Mar 2019 14:01:50 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 11 Mar 2019 14:01:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFGu6UqDt/yu0oMB1Xc6TPFLbAwQuSuz6EJsTpyns8U=;
 b=B0MvJ6LkQih1pNnRPBPR+B5vb7b4YRPX2uoztTxfoJR/oEteUXNfMKv7VOrDAv5kCXi3oDNjIVwWKRzpDawpW78RzOOBIhvIHZB98TNm2UOjHzHBF4oOeyMSpDM2JkmnArIUgNsWwIVf9uc/LmuOabfHsSgZpkEv57wO4S5btOM=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1117.namprd15.prod.outlook.com (10.175.2.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.20; Mon, 11 Mar 2019 21:01:48 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065%6]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 21:01:48 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "sdf@fomichev.me" <sdf@fomichev.me>,
        "acme@kernel.org" <acme@kernel.org>
Subject: Re: [PATCH v8 perf,bpf 00/15] perf annotation of BPF programs
Thread-Topic: [PATCH v8 perf,bpf 00/15] perf annotation of BPF programs
Thread-Index: AQHU2ESEhUo7NOm9yEuQuJ5Kxn1dHqYG4EAAgAAKfoA=
Date:   Mon, 11 Mar 2019 21:01:48 +0000
Message-ID: <B72EC7B0-6B8B-4739-87A0-15364D3DE44F@fb.com>
References: <20190311195555.889995-1-songliubraving@fb.com>
 <20190311202414.GA3078@redhat.com>
In-Reply-To: <20190311202414.GA3078@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::2:e2c1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 359de5b8-cbe2-4617-b588-08d6a664c6e1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1117;
x-ms-traffictypediagnostic: MWHPR15MB1117:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1117;20:EVrfCafIZI/QId/U9All/SUcY+xnESqAchG1AbGnFgji+1veua2DS7Y3TeNgyl9wzgWI5ne7EoeJGlAWE+N9pxwkLqG7Yq8HP8SueXzlWrLyIyxHG8YM/byHRJnQx4XmSk2KRo+P+f8o0834F4+ekV69ECNQx5kyznFzFBFqyvw=
x-microsoft-antispam-prvs: <MWHPR15MB111765D41BF7ABDE36F570F4B3480@MWHPR15MB1117.namprd15.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(396003)(376002)(136003)(189003)(199004)(6116002)(71190400001)(71200400001)(54906003)(2616005)(83716004)(486006)(36756003)(476003)(6512007)(316002)(478600001)(68736007)(11346002)(76176011)(2906002)(7416002)(46003)(82746002)(25786009)(6916009)(6246003)(99286004)(86362001)(81166006)(7736002)(14454004)(53546011)(8936002)(57306001)(97736004)(6506007)(4326008)(81156014)(50226002)(256004)(33656002)(8676002)(186003)(53936002)(446003)(229853002)(5660300002)(102836004)(305945005)(6436002)(106356001)(6486002)(105586002)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1117;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uwbQBy8br5UtaKSdZXyLZxmhzTfIn6k3ofgm7y5R0/D/pEhMYqEU6x8IBxfxhDHyaQY4amoKb00ZxrsirJhzQ/WnJ/HBGmfibdI5GAh8fgxVtEYcklYC8EBe2FkU2/gdVbNKB/T//5P6RzP/rY3qRL1ydhcnK3vmjHdCmYDsZSgDMSg7IB1HLqZ6xPkQC8Gtvj1yF2NLq2ljFJLBjWO/Z+v9DUVgl+3lCtDG/K5rBgt/eN/43kQsKskJF1ZPLB3NnxN3MkxOoAX7DS3QajX3sDcDgZK9AgCNsim7cQJ25VLU9IxS0iKfrtWFVyZUceS4uFrg20dIczXHBb/aho6bwLhnePqA0KdjSPiylYnzCaZ3mepZwDYoSMdDlzIIPZPW5CWYJX8QDaU9djAlqzz6ahIorUifIpwJmEQSpY9kgfw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4E9B33F2B5901C49A429204CE949BE87@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 359de5b8-cbe2-4617-b588-08d6a664c6e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 21:01:48.1834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1117
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-11_16:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 11, 2019, at 1:24 PM, Arnaldo Carvalho de Melo <acme@redhat.com> w=
rote:
>=20
> Em Mon, Mar 11, 2019 at 12:55:40PM -0700, Song Liu escreveu:
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
>=20
> These csets are already upstream, i.e. already hit torvalds/master, i.e.
> will be in 5.1, can you check that we still need doing this
> cherry-picking?
>=20
> - Arnaldo

I just checked that 02-15 of the set could apply to torvalds/master (with=20
some minor conflicts), and it works as expected.=20

Thanks,
Song=
