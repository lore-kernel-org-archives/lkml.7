Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C24C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1751420674
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="V4e6jmE4";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="VFKGnab+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732948AbfDQQ6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:58:15 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60874 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729512AbfDQQ6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:58:13 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3HGmYUi019187;
        Wed, 17 Apr 2019 09:56:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=z0hei0g4+b58mGNSruovWWb8VatTq7KPnh4mLCkojMw=;
 b=V4e6jmE4TVFC5lPEzop/gUGodLJbatHmMLvZFHsfkCIcmttUcmQQs5oH8YpQ3ipRZPlZ
 wT+Eb+Cgu4QDZggVmqDBkbKQB0DFyoPsb7kJR6ORcYySOzHsjnlY+Or8hdGm96Id3Uom
 i4Ai4Lht1bUQsiL/xddziUXUC+kUo781ua8= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rx7smr2ma-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 17 Apr 2019 09:56:47 -0700
Received: from frc-mbx07.TheFacebook.com (2620:10d:c0a1:f82::31) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 17 Apr 2019 09:56:45 -0700
Received: from frc-hub01.TheFacebook.com (2620:10d:c021:18::171) by
 frc-mbx07.TheFacebook.com (2620:10d:c0a1:f82::31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 17 Apr 2019 09:56:45 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 17 Apr 2019 09:56:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0hei0g4+b58mGNSruovWWb8VatTq7KPnh4mLCkojMw=;
 b=VFKGnab+aAPNKpVfgW3oRK/cAFyPKjnTSQ/Jv5PGnMJHaXZ2SIk48IIpPCFTB35d5qS+6/YCkWe56QADUyAzo1IctZPxfPOo7AN6ZS5/FDf47xQ9XgHkTlRl1+LxWWXPMjOa88+dolHbOe328KgGP6jNSDjBhuBBFKxZjZJPiKA=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1504.namprd15.prod.outlook.com (10.173.235.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Wed, 17 Apr 2019 16:56:41 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::5185:8137:2f1d:7171]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::5185:8137:2f1d:7171%2]) with mapi id 15.20.1792.018; Wed, 17 Apr 2019
 16:56:41 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH 11/12] perf tools: Reuse shared eBPF dso objects
Thread-Topic: [PATCH 11/12] perf tools: Reuse shared eBPF dso objects
Thread-Index: AQHU9G3HZKG3RseEUUSmcxz4FyjxX6Y/5qcAgAAEcoCAAAEcgIAACmmAgACdlAA=
Date:   Wed, 17 Apr 2019 16:56:41 +0000
Message-ID: <4CBDB645-513F-4CCA-9FA0-B29110F10C0E@fb.com>
References: <20190416160127.30203-1-jolsa@kernel.org>
 <20190416160127.30203-12-jolsa@kernel.org>
 <746f02e3-a509-5081-8427-b610e52c1fb0@intel.com>
 <20190417065127.GA17024@krava>
 <ed2f881b-c1b2-e6da-5c23-fc1eb4db131f@intel.com>
 <20190417073241.GC17024@krava>
In-Reply-To: <20190417073241.GC17024@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:200::2:a410]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70817bc3-0491-44eb-8c07-08d6c355aa43
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR15MB1504;
x-ms-traffictypediagnostic: MWHPR15MB1504:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR15MB150484FF6485569D3BFC02B9B3250@MWHPR15MB1504.namprd15.prod.outlook.com>
x-forefront-prvs: 0010D93EFE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(396003)(136003)(376002)(189003)(199004)(6916009)(478600001)(2906002)(966005)(6436002)(186003)(6512007)(5660300002)(6306002)(14454004)(7416002)(53936002)(6506007)(102836004)(97736004)(53546011)(50226002)(316002)(93886005)(68736007)(7736002)(33656002)(82746002)(8676002)(36756003)(81166006)(99286004)(76176011)(81156014)(57306001)(86362001)(305945005)(6116002)(54906003)(8936002)(476003)(11346002)(2616005)(46003)(71200400001)(105586002)(6486002)(446003)(106356001)(71190400001)(6246003)(4326008)(256004)(229853002)(486006)(83716004)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1504;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cMix3mU5VwUcn68eJ4rXwXcxFEz2FRVFsVghJKZNOfrIr13GgJiL5YHOaT5WOIvjgI0PGmly/AkLxup/IyIDtnZ/t15M6v41ChULbeqR+3Wtv0K7F04HqzAa/2X4/YJ/Z2uoLTgnCRBXRpeUeNFlHrz1u2oe/IzcSXEvkgwq2fYrxGp8rl77VaHXF5Mp7dRbcAO25XnBK4zw8Z/WsjDffPNE8R2jNYpbygy73femZZ2/swmsTl3F/0x2i4P7nLYSEGG8D9J4SivrkUCqdf8cCvzyBceEXYiKGQ4NTl5xkuoSrL7zgJXS1Y9nDv2cxerkPnwvr6okUEnYJToKxQJdPDjpMGVO5JFwS1LFdxR6IhBuZAqAGDPCAhlt//ZjFYYzgFK5uDjTE+p8j178yTfCxSFbgneTOASzNGby6ljaHSc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FDEEDA285DFEFA438EF49FFE3DEE59FF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 70817bc3-0491-44eb-8c07-08d6c355aa43
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2019 16:56:41.4182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1504
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-17_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 17, 2019, at 12:32 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Wed, Apr 17, 2019 at 09:55:25AM +0300, Adrian Hunter wrote:
>> On 17/04/19 9:51 AM, Jiri Olsa wrote:
>>> On Wed, Apr 17, 2019 at 09:35:32AM +0300, Adrian Hunter wrote:
>>>> On 16/04/19 7:01 PM, Jiri Olsa wrote:
>>>>> The eBPF program can be loaded multiple times
>>>>> with the same name (tag). We can share dso
>>>>> objects for those programs.
>>>>=20
>>>> Doesn't a eBPF program get recompiled differently every time it is loa=
ded?
>>>=20
>>> yes, but those with same tag are identical
>>=20
>> But won't recompiled eBPF programs be different due to blinded constants=
?
>> Or perhaps in the future other code randomization?
>=20
> ah right.. that can happen, let's skip this one then
>=20
> perhaps we could add bpf prog id to be part of the name
> to make it unique.. I'll check
>=20
> thanks,
> jirka

I thought about similar optimizations. However, this is not easy.=20

Tag of a BPF program is calculated _before_ JiT, so we really cannot
say two programs with same tag are identical. Current implementation=20
iterates over all bpf program IDs, so same program id will not appear
twice in the same perf session.=20

I think the more realistic opportunity of optimizations comes from=20
sharing the dsos cross multiple perf.data files.=20

Thanks,
Song

>>=20
>>>=20
>>> jirka
>>>=20
>>>>=20
>>>>>=20
>>>>> Link: http://lkml.kernel.org/n/tip-3damf8vq1dryhtpbk5b06jpt@git.kerne=
l.org
>>>>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>>>>> ---
>>>>> tools/perf/util/machine.c | 14 +++++++++++---
>>>>> 1 file changed, 11 insertions(+), 3 deletions(-)
>>>>>=20
>>>>> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
>>>>> index d4aa44489011..a60653827891 100644
>>>>> --- a/tools/perf/util/machine.c
>>>>> +++ b/tools/perf/util/machine.c
>>>>> @@ -23,6 +23,7 @@
>>>>> #include "linux/hash.h"
>>>>> #include "asm/bug.h"
>>>>> #include "bpf-event.h"
>>>>> +#include "dso.h"
>>>>>=20
>>>>> #include "sane_ctype.h"
>>>>> #include <symbol/kallsyms.h>
>>>>> @@ -699,11 +700,18 @@ static int machine__process_ksymbol_register(st=
ruct machine *machine,
>>>>>=20
>>>>> 	map =3D map_groups__find(&machine->kmaps, event->ksymbol_event.addr)=
;
>>>>> 	if (!map) {
>>>>> -		map =3D dso__new_map(event->ksymbol_event.name);
>>>>> -		if (!map)
>>>>> +		struct dso *dso;
>>>>> +
>>>>> +		dso =3D dsos__findnew(&machine->dsos, event->ksymbol_event.name);
>>>>> +		if (!dso)
>>>>> 			return -ENOMEM;
>>>>>=20
>>>>> -		map->start =3D event->ksymbol_event.addr;
>>>>> +		map =3D map__new2(event->ksymbol_event.addr, dso);
>>>>> +		if (!map) {
>>>>> +			dso__put(dso);
>>>>> +			return -ENOMEM;
>>>>> +		}
>>>>> +
>>>>> 		map->end =3D map->start + event->ksymbol_event.len;
>>>>> 		map_groups__insert(&machine->kmaps, map);
>>>>> 	}

