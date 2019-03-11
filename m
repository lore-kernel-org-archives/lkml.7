Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051A5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B99342147C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="WekNFL2w";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="SFm1Aix8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbfCKVJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:09:04 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33288 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728071AbfCKVJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:09:03 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2BL5qgk020143;
        Mon, 11 Mar 2019 14:08:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=FilvdTRWVqyjvQja1fWCJij7tVKw5fC8iq5OkjV3ELI=;
 b=WekNFL2wD19HWbmADpX3/eCXtB849JoKlH20tuZOeNqI50TbNz1RfeAHfVJdtdvSsxOK
 shtHwBOijKmFoD2lHr7X1ACyboCZsPVOKlmXXfJUs9EVoPESD6dFQt8nZ5oI1L5cgHK6
 9i69I0hXdukCkpughoRHemG6SZASKLFRSzY= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r5wuw8ay7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 11 Mar 2019 14:08:36 -0700
Received: from prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 11 Mar 2019 14:08:34 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 11 Mar 2019 14:08:34 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 11 Mar 2019 14:08:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FilvdTRWVqyjvQja1fWCJij7tVKw5fC8iq5OkjV3ELI=;
 b=SFm1Aix87BYCeDJ1+w2dUEdpWAqfvpmkzavhpy4x3+yknoswdUag2z9b+e2YjbS7H+Rxv7sJJFlrSyuGGcH3lc8r+dujX2aD10LWl+4BDhztu5gH9ykg1IWFDgHMpmR9ayzovGvXT5K2GVx8+eANJkAPwREOBmBCPZdRId3P0E8=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1888.namprd15.prod.outlook.com (10.174.100.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.20; Mon, 11 Mar 2019 21:08:31 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065%6]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 21:08:31 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "sdf@fomichev.me" <sdf@fomichev.me>
Subject: Re: [PATCH v8 perf,bpf 00/15] perf annotation of BPF programs
Thread-Topic: [PATCH v8 perf,bpf 00/15] perf annotation of BPF programs
Thread-Index: AQHU2ESEhUo7NOm9yEuQuJ5Kxn1dHqYG4EAAgAAKfoCAAADugIAAAPIA
Date:   Mon, 11 Mar 2019 21:08:31 +0000
Message-ID: <944EE4E6-FD71-4D41-ABE1-279C6950EB11@fb.com>
References: <20190311195555.889995-1-songliubraving@fb.com>
 <20190311202414.GA3078@redhat.com>
 <B72EC7B0-6B8B-4739-87A0-15364D3DE44F@fb.com>
 <20190311210507.GF10690@kernel.org>
In-Reply-To: <20190311210507.GF10690@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::2:e2c1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a9a84ab-f802-4df7-1a11-08d6a665b76b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1888;
x-ms-traffictypediagnostic: MWHPR15MB1888:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1888;20:0LC/NsyUvMY5DQZ35Jqd/eYQfYkAthx9SdhfFDH7u6AanPyTq+D2/U4fNTplciJZ6LZObkt75u8TEDfDO1SykWTBUVhp7YrzltMNs31vuU7J86LFsB+SaLeLaYVSNuKTM111Ql4QgHuoi4q4qEZFKIwXxtwEypdgRuRa7nKafww=
x-microsoft-antispam-prvs: <MWHPR15MB1888891D2D1DE3681C8C82AEB3480@MWHPR15MB1888.namprd15.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(376002)(346002)(39860400002)(136003)(366004)(189003)(199004)(2906002)(50226002)(71190400001)(71200400001)(93886005)(8936002)(478600001)(6916009)(6486002)(4326008)(6116002)(229853002)(54906003)(57306001)(86362001)(97736004)(83716004)(14454004)(316002)(256004)(25786009)(82746002)(186003)(99286004)(486006)(7416002)(102836004)(6512007)(6246003)(33656002)(2616005)(476003)(11346002)(7736002)(6436002)(76176011)(53546011)(36756003)(105586002)(305945005)(8676002)(68736007)(81166006)(5660300002)(81156014)(446003)(53936002)(46003)(6506007)(106356001)(142933001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1888;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kcXFVO3ht6F3KjV9YHb+uO4jHcmH0mBFMS5XqgzUNiXB1h6nxRBpnDpWMJbQhw5ns/DlF56yD3Y6uwqsPAx2XgFYMsGS54uIcwaPL8XIPaZxl1E/toGBYL92f5TL5kN+Y7ofk/ZlBglA387WrRAqcFKF50kediQ6TPL36e5wuZOuVKGSqlFnKDpy7YjIwwKCB5FYDRw6UcqLsgY/uvLXZ24hDQNsppiuXcJ6IWxq4UTCPSQmJKqxS6MPxDDgxeEyWvpiiyYUUybHKxnUxkVU8a3UqKyzCmW1o+CtVGaXRSGY6fyfKtx8isI5Kc/EFHZTry9AsDy8O+ycLyKxbfp0dazKxtmIGXr2jVOG3Bnb2Q303rvNSlGPZgyOfUshobCbnWpglFQtzpAAFM+8YerJvEn0UdmiQTQOVSj1YK6h4Cs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <652AB5A23FE4314AB110D55E1CF77F94@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9a84ab-f802-4df7-1a11-08d6a665b76b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 21:08:31.7199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1888
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-11_16:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 11, 2019, at 2:05 PM, Arnaldo Carvalho de Melo <arnaldo.melo@gmail=
.com> wrote:
>=20
> Em Mon, Mar 11, 2019 at 09:01:48PM +0000, Song Liu escreveu:
>>=20
>>=20
>>> On Mar 11, 2019, at 1:24 PM, Arnaldo Carvalho de Melo <acme@redhat.com>=
 wrote:
>>>=20
>>> Em Mon, Mar 11, 2019 at 12:55:40PM -0700, Song Liu escreveu:
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Note o=
n patch dependency  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>>>> This set has dependency in both bpf-next tree and tip/perf/core. Curre=
nt
>>>> version is developed on bpf-next tree with the following commits
>>>> cherry-picked from tip/perf/core (or acme/perf/core):
>>>>=20
>>>> (from 1/11 to 11/11)
>>>> commit 76193a94522f ("perf, bpf: Introduce PERF_RECORD_KSYMBOL")
>>>> commit d764ac646491 ("tools headers uapi: Sync tools/include/uapi/linu=
x/perf_event.h")
>>>> commit 6ee52e2a3fe4 ("perf, bpf: Introduce PERF_RECORD_BPF_EVENT")
>>>> commit df063c83aa2c ("tools headers uapi: Sync tools/include/uapi/linu=
x/perf_event.h")
>>>> commit 9aa0bfa370b2 ("perf tools: Handle PERF_RECORD_KSYMBOL")
>>>> commit 45178a928a4b ("perf tools: Handle PERF_RECORD_BPF_EVENT")
>>>> commit 7b612e291a5a ("perf tools: Synthesize PERF_RECORD_* for loaded =
BPF programs")
>>>> commit a40b95bcd30c ("perf top: Synthesize BPF events for pre-existing=
 loaded BPF programs")
>>>> commit 6934058d9fb6 ("bpf: Add module name [bpf] to ksymbols for bpf p=
rograms")
>>>> commit 811184fb6977 ("perf bpf: Fix synthesized PERF_RECORD_KSYMBOL/BP=
F_EVENT")
>>>> comimt 94816add0005 ("perf tools: Add perf_exe() helper to find perf b=
inary")
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>=20
>>> These csets are already upstream, i.e. already hit torvalds/master, i.e=
.
>>> will be in 5.1, can you check that we still need doing this
>>> cherry-picking?
>>>=20
>>> - Arnaldo
>>=20
>> I just checked that 02-15 of the set could apply to torvalds/master (wit=
h=20
>> some minor conflicts), and it works as expected.=20
>=20
> So no need to cherrypick, just use torvalds/master as a base, ok.
>=20
> - Arnaldo

Do you want me to resend the set with the conflict resolved?=20

Thanks,
Song=
