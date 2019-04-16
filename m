Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A556C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2981B20663
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="I9moYb0C";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="J1fxfsIG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbfDPUZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:25:28 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49872 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727136AbfDPUZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:25:28 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x3GKOZ1R007064;
        Tue, 16 Apr 2019 13:25:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=WGOboOO30u7Xkm/FjR5Bk/6f+LFZ+J35Zbf3q8dKbWA=;
 b=I9moYb0CzIosH7EX1HnKpZybWi/QrmErqjuXGylPhhI/ZKSblsl9dcj/ZTy+fFCOjyRz
 HHm18s01TalMd1XUwUCsZLzuEM5T0YuMKw7Tk8HTFUXCzIrmIm7yEh58yVH+cpdsqOgA
 hly/eMVkHFzjTEvzGywemc0KIDT16wANBno= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2rwfr71n8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 16 Apr 2019 13:25:20 -0700
Received: from prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 16 Apr 2019 13:25:19 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 16 Apr 2019 13:25:19 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 16 Apr 2019 13:25:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGOboOO30u7Xkm/FjR5Bk/6f+LFZ+J35Zbf3q8dKbWA=;
 b=J1fxfsIGp5o5Dy9vT4S62et3uRQjOT/2nqKY0eEMY3HM44EVTtAW5Eb9lHNfD9eN24pDdsd2EgTqC+WBWy75akry6ARaEh39sq9ghQ4ml5vc+2ahNxemSsffNBXAveHTaZub2G+fizOErslZQzsQpe2KOw2d3bM6lskL3erj8XA=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1359.namprd15.prod.outlook.com (10.173.232.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Tue, 16 Apr 2019 20:25:17 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::5185:8137:2f1d:7171]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::5185:8137:2f1d:7171%2]) with mapi id 15.20.1792.018; Tue, 16 Apr 2019
 20:25:17 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] perf tools: Fix perf_env__find_bpf_prog_info rb tree
 lookup
Thread-Topic: [PATCH] perf tools: Fix perf_env__find_bpf_prog_info rb tree
 lookup
Thread-Index: AQHU9Fo3DtW8FFjk2UuQFajrTPU/j6Y+1mAAgAAEBgCAAABKAIAAAIcAgABhFQA=
Date:   Tue, 16 Apr 2019 20:25:17 +0000
Message-ID: <48CA4238-740E-4B42-BDB1-C2DD85A558C3@fb.com>
References: <20190416134151.15282-1-jolsa@kernel.org>
 <20190416142028.GH11294@kernel.org> <20190416143452.GB10125@krava>
 <20190416143554.GB2459@kernel.org> <20190416143748.GC2459@kernel.org>
In-Reply-To: <20190416143748.GC2459@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:200::2:2171]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a472fd3-5b45-4ddd-e554-08d6c2a9a3d0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR15MB1359;
x-ms-traffictypediagnostic: MWHPR15MB1359:
x-microsoft-antispam-prvs: <MWHPR15MB1359F9B43BE10DB4001F914BB3240@MWHPR15MB1359.namprd15.prod.outlook.com>
x-forefront-prvs: 000947967F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(366004)(39860400002)(346002)(189003)(199004)(99286004)(71200400001)(83716004)(4326008)(476003)(186003)(8936002)(486006)(478600001)(106356001)(71190400001)(68736007)(6486002)(105586002)(25786009)(5660300002)(93886005)(8676002)(36756003)(81166006)(97736004)(256004)(2906002)(81156014)(6512007)(6246003)(2616005)(6116002)(11346002)(102836004)(446003)(46003)(76176011)(57306001)(229853002)(7736002)(316002)(53936002)(14454004)(54906003)(6916009)(50226002)(82746002)(53546011)(33656002)(86362001)(6436002)(305945005)(6506007)(101420200001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1359;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7f/5ZCBw10RFdF7yPgmE2an3yYsIV0qo+VDkXMGduCzkZqqNUE40aS4atecs04nlpImYncIVAA/wGlqNjgwhjsDRvhLuZvKayIQQVTQZOTlzeJu/lp/5MX4fq0ffOF5w2SbBUjEFQLCa1ynWTVQgWDy2QU30cJUMJybZ5u88V8+BlIZZGf/JSE3LQJ+7dUvrLK/8DCZem3mlW4vwCYneBKSVw39/9HimWNeuEPf/0qqDD4MhhDxVQ/Uhsv5zL9DBwW92VpffrCAwuwqhcp0CDJX+9bfJ1a9aY7lsR8NqLpwg6lTEM5JYfNds20OyLafbV418RMF/qxs624eXo2uumGbqS3tx3rq198dYNN9jjkzUKnY6V31+rZrhcb/LZ+ry5DCjTX3AzOY8zTwe+Y7X7vtKerq2bfEvgXL7pSLNiwg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8AC91E11658DCA418C7B4F3633B2698F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a472fd3-5b45-4ddd-e554-08d6c2a9a3d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2019 20:25:17.1630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1359
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-16_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 16, 2019, at 7:37 AM, Arnaldo Carvalho de Melo <arnaldo.melo@gmail=
.com> wrote:
>=20
> Em Tue, Apr 16, 2019 at 11:35:54AM -0300, Arnaldo Carvalho de Melo escrev=
eu:
>> Em Tue, Apr 16, 2019 at 04:34:52PM +0200, Jiri Olsa escreveu:
>>> On Tue, Apr 16, 2019 at 11:20:28AM -0300, Arnaldo Carvalho de Melo wrot=
e:
>>>> Em Tue, Apr 16, 2019 at 03:41:51PM +0200, Jiri Olsa escreveu:
>>>>> We currently don't return NULL in case we don't find
>>>>> the bpf_prog_info_node, fixing that.
>>>>=20
>>>> Can you please try to figure out what was the changeset that introduce=
d
>>>> this problem so that we can have a Fixes: tag that helps me determine =
if
>>>> this should go to perf/urgent (likely) or (perf/core) and to help the
>>>> stable guys as well?
>>>=20
>>> sry, I keep forgetting this..
>>>=20
>>> Fixes: e4378f0cb90b ("perf bpf: Save bpf_prog_info in a rbtree in perf_=
env")
>>=20
>> I had just added:
>>=20
>> Fixes: e4378f0cb90b ("perf bpf: Save bpf_prog_info in a rbtree in perf_e=
nv")
>>=20
>> matches, good :-)
>>=20
>> At firts I thought hey the look checks for NULL, then, hey, different
>> variable... good catch!
>=20
> Ah, I also changed the summary from:
>=20
>   "perf tools: Fix perf_env__find_bpf_prog_info rb tree"
>=20
> to:
>=20
>  perf bpf: Return NULL when RB tree lookup fails in perf_env__find_bpf_pr=
og_info()
>=20
> Thanks,
>=20
> - Arnaldo

Thanks Jiri and Arnaldo!

I think we will need similar fix for perf_env__find_btf().=20

Song=
