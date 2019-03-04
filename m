Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AA1C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E2E420663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="bAamZA3I";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="V98lpIsr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfCDVkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 16:40:49 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34766 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726069AbfCDVks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 16:40:48 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x24LSR0g013397;
        Mon, 4 Mar 2019 13:40:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=6bGqLHZhWQWILVw/rlfQnhYt827LhPfWBf+qLCVT2Y8=;
 b=bAamZA3IMZzq/rAFMNszUxVmCauM6yCjQ0mFwM/Nj38VVDcGaGiVFxvgfk3qNPo5675t
 BNno++QN7dxi12dF47IVLzcw/3nYgoqGW/2QoOCyAE7RzzLzQH+MLwVOQZ1EN9JHb1XO
 5KxOxSy5ybEccYgoum40lbhXuJUF/JpmvDc= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r1bc78571-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 04 Mar 2019 13:40:20 -0800
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 4 Mar 2019 13:40:18 -0800
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 4 Mar 2019 13:40:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bGqLHZhWQWILVw/rlfQnhYt827LhPfWBf+qLCVT2Y8=;
 b=V98lpIsrDfpQz6KnWb3TFMPghhUtQo5Zad6oxXXRF0colDEynnKKm3Sh8qOp+Ne0JD+CB6OiD8QefHE00IVRO+lwdZp61kM6YQ+KakbIXxE8kcYuR0eTjREy10zFyKoze6e5VBeLB1H1nxKtagCGAFQTXRmpOVzGIloAsIauat4=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1710.namprd15.prod.outlook.com (10.174.254.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.18; Mon, 4 Mar 2019 21:40:08 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065%6]) with mapi id 15.20.1665.020; Mon, 4 Mar 2019
 21:40:08 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Networking <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v4 perf,bpf 14/15] perf: introduce side band thread
Thread-Topic: [PATCH v4 perf,bpf 14/15] perf: introduce side band thread
Thread-Index: AQHUzWlKCfZJunEblEKUEZkb6eySeqXzo8KAgAhnFoA=
Date:   Mon, 4 Mar 2019 21:40:07 +0000
Message-ID: <15CE7BE1-9D48-404D-BF09-847C09C4300E@fb.com>
References: <20190226002019.3748539-1-songliubraving@fb.com>
 <20190226002019.3748539-15-songliubraving@fb.com>
 <20190227132105.GC18893@krava>
In-Reply-To: <20190227132105.GC18893@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::3:1d00]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d60fc57e-53d2-4259-eceb-08d6a0e9f8be
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1710;
x-ms-traffictypediagnostic: MWHPR15MB1710:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1710;20:fbU/hidebR3lnO5BE256uwJcln4hT/jRISVtKf0s/l9nF2/bWH/1XbwdfElU6jCvZ0jSj0C8hcDt3x84+YVG5gUVjT7Ov5nD98ozU9T8gRci1lz3+nTkMA3g1V8o2iW7cM2FYvMpl5Rd/XpyG2DirK4IVYPu2MXOkMSp8ksH/hY=
x-microsoft-antispam-prvs: <MWHPR15MB17103DF8C1D097B571E5D0D9B3710@MWHPR15MB1710.namprd15.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(39860400002)(346002)(376002)(199004)(189003)(81166006)(97736004)(50226002)(8676002)(8936002)(105586002)(7736002)(305945005)(6246003)(229853002)(71190400001)(71200400001)(76176011)(4326008)(102836004)(81156014)(2906002)(46003)(106356001)(561944003)(6486002)(33656002)(68736007)(186003)(6506007)(53546011)(6512007)(57306001)(82746002)(6436002)(99286004)(86362001)(2616005)(25786009)(53936002)(486006)(11346002)(446003)(476003)(478600001)(6916009)(316002)(14454004)(83716004)(256004)(5660300002)(36756003)(54906003)(6116002)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1710;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Vd0sIwD7ug0BrXivK7IUezwFcBt+yW3OghnQEXieKeXCAqw1Xjv2ukSs6PAdAfZqdsshYaHI/S3rdS79gnspMvReF8H7Tle5spBiUZFUV39MRcP2H3mvpTVhpYkMroSgQCeYPGQON/2nSq3/Ie2WNWJVc8qyKtOLuGMX58JnLBM1FKZdfaRZs9Em/9PXKO4vM6jRakBZpmd5g835osAnZzzV7psGLnNaJxhB6g8pAsR3h2vW55gkuULyFbTrpbxoXtfbxshzCoMDhyo2/Ib6uLGNUBYGpFdu0wnQuH43KbtR/7tw2uYv6EyRoH+Fg7Gyw2vp8vHLk/9HGcvSKnFVGNZM/oC7OBn0acyCKfvjHLolnnELqfh3nEfhuKhCoi0F7597nUbYzOQAAu8R5KOsFYxGMknkPqb7/IKR4FYj3KA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9C1FD247A448094F859731D4E0AA4FCE@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d60fc57e-53d2-4259-eceb-08d6a0e9f8be
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 21:40:07.9499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1710
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-04_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 27, 2019, at 5:21 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Mon, Feb 25, 2019 at 04:20:18PM -0800, Song Liu wrote:
>=20
> SNIP
>=20
>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
>> index 8c902276d4b4..61b87c8111e6 100644
>> --- a/tools/perf/util/evlist.c
>> +++ b/tools/perf/util/evlist.c
>> @@ -19,6 +19,7 @@
>> #include "debug.h"
>> #include "units.h"
>> #include "asm/bug.h"
>> +#include "bpf-event.h"
>> #include <signal.h>
>> #include <unistd.h>
>>=20
>> @@ -1841,3 +1842,102 @@ struct perf_evsel *perf_evlist__reset_weak_group=
(struct perf_evlist *evsel_list,
>> 	}
>> 	return leader;
>> }
>> +
>> +static struct perf_evlist *sb_evlist;
>> +pthread_t poll_thread;
>=20
> so some of the things are static and some like poll_args
> you alloced on the stack.. I dont like this interface,
> could we come up with something generic? perhaps
> encapsulated in perf_evlist, like:
>=20
> struct perf_evlist {
> 	...
> 	struct {
> 		pthread_t	th;
> 		int		state;
> 	} thread;
> };
>=20
> typedef int (perf_evlist__thread_cb_t)(perf_evlist, union perf_event *eve=
nt,....)
>=20
> perf_evlist__start_thread(perf_evlist, perf_evlist__thread_cb_t cb);
> perf_evlist__stop_thread(perf_evlist);
>=20
>=20
> jirka

More questions on this proposal:=20

IIUC, this approach creates one perf_evlist and one thread for each side ba=
nd
event (only bpf for now, more afterwards). Each of these perf_evlists will=
=20
create its own ring buffer.=20

On the other hand, current patch allows different events to share the threa=
d,=20
the perf_evlist, and the ring buffer.=20

If my understanding is correct, current patch would be more efficient down =
the=20
road? Did I miss some downsides of current patch?

Thanks,
Song

