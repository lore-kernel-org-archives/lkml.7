Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26650C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAEC320823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="f9oTX4t6";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="US1zsU1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfCDTtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:49:36 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55646 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726076AbfCDTtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:49:35 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x24JkuoV021801;
        Mon, 4 Mar 2019 11:49:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=tw+DznQ4jH6hwQMtC3tk+2lviOIZqsNKU/w1ZJVN36w=;
 b=f9oTX4t657TzN5chlVJaYIQ3WUcxikVXvIapSQ3j8hsN5cBMZ2kxajYQchldQjOzf+Bo
 EKiHpKEKshWS2FzINUa9LGgaim1DLKODa0KyrcjxxPBc5L91/HxPlUbiTZi6O8gxERii
 MJr0GttTqPI8uaOHKurNrdHs890EvqvE/qg= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r17u40ncw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 04 Mar 2019 11:49:09 -0800
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 4 Mar 2019 11:49:08 -0800
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 4 Mar 2019 11:49:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tw+DznQ4jH6hwQMtC3tk+2lviOIZqsNKU/w1ZJVN36w=;
 b=US1zsU1T9SMaKfhmEk7qXiFP+bYFgqae+xqcoU+Qeq1CKdpcfIgDW6smEId1kKbmEE8kRgp/o/R4OcbshYazBpN4GkbH9GSYCKhtkZ6VnPzodlqoZg2OYIGxwHOxfpRnBZj/MpuM8ZF/IoklcjO2ZudvBV76ztIbShKzT20gjrw=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1389.namprd15.prod.outlook.com (10.173.234.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.18; Mon, 4 Mar 2019 19:49:06 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065%6]) with mapi id 15.20.1665.020; Mon, 4 Mar 2019
 19:49:06 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v4 perf,bpf 14/15] perf: introduce side band thread
Thread-Topic: [PATCH v4 perf,bpf 14/15] perf: introduce side band thread
Thread-Index: AQHUzWlKCfZJunEblEKUEZkb6eySeqXzo8KAgABL74CAB5h6AIAAY6eA
Date:   Mon, 4 Mar 2019 19:49:06 +0000
Message-ID: <3B7ECDFA-E6F7-4136-A2E4-6115C5A4791B@fb.com>
References: <20190226002019.3748539-1-songliubraving@fb.com>
 <20190226002019.3748539-15-songliubraving@fb.com>
 <20190227132105.GC18893@krava> <2506D6CF-F0E3-4640-B385-DD0843AD2928@fb.com>
 <20190304135224.GD19809@krava>
In-Reply-To: <20190304135224.GD19809@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::3:1d00]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c95eacf-80a2-4c48-ca18-08d6a0da764e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1389;
x-ms-traffictypediagnostic: MWHPR15MB1389:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1389;20:5B7PglUOBHz8+JzMhp4iERCQY82/7t3509nbNkQVYoc3ydhRfyMrIpijGlmuANI82oyzLMl0exGmIcTlJ4TMYjBPjnMxblTIwIcBXqZ9qzWFvn5U3Bqdrv53/aXZ9bK//yBU7Ut+taZemob9HKaaDhmobW++eTIdSZWjtLX2HLU=
x-microsoft-antispam-prvs: <MWHPR15MB1389F00D19F6CF164E031280B3710@MWHPR15MB1389.namprd15.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(136003)(366004)(39860400002)(199004)(189003)(6506007)(53546011)(102836004)(6346003)(25786009)(36756003)(305945005)(486006)(6916009)(99286004)(93886005)(82746002)(33656002)(14454004)(76176011)(446003)(11346002)(476003)(7736002)(478600001)(46003)(81156014)(81166006)(8676002)(8936002)(229853002)(57306001)(6486002)(6436002)(105586002)(6116002)(106356001)(186003)(2616005)(5660300002)(83716004)(71200400001)(71190400001)(50226002)(256004)(68736007)(54906003)(86362001)(6246003)(4326008)(316002)(2906002)(53936002)(97736004)(6512007)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1389;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Bhsss1/WKus/cKEQsiG20Cg27JgxHB+tNhN5MVKMcN5xe7uOjcgNQ39mrYVmz6KEHhgk+g7VmSusERC7AqYL+oVNWUSR9WgWK2hkeuxlS5kWkIyHIb2RwIMWn8ei6g89cLPAjethYFIaxt/cXhkif8s9g1zlBbHervAIUiiit/Ehp+2F3VOZsVPx7CfTb3mD1lL7hLFkd/LJGM2VoW+fWP1EOHlvd9SbsL2Ufn/p4umN9gAvtJIzGSwpn8Su8oW1dSikOYvBqr2SJD4JTJ44HPy2LrivkPQhIZAp7CTVQZZ4xHg8nXaebcjPKXBFOZBVUZ3ff4uf1Vpritt6ZvMFurMusRxER955sPKfxsrkTuvwkJjAJomdS/krdUpyRsLHgZBrZDpnS7NScRGVnRDoxk7rTKNwRNRFAHjYts9uGCg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <73B7883D8E41E649BFCC48CCA03260FE@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c95eacf-80a2-4c48-ca18-08d6a0da764e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 19:49:06.5351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1389
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-04_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 4, 2019, at 5:52 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Wed, Feb 27, 2019 at 05:52:52PM +0000, Song Liu wrote:
>>=20
>>=20
>>> On Feb 27, 2019, at 5:21 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>>>=20
>>> On Mon, Feb 25, 2019 at 04:20:18PM -0800, Song Liu wrote:
>>>=20
>>> SNIP
>>>=20
>>>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
>>>> index 8c902276d4b4..61b87c8111e6 100644
>>>> --- a/tools/perf/util/evlist.c
>>>> +++ b/tools/perf/util/evlist.c
>>>> @@ -19,6 +19,7 @@
>>>> #include "debug.h"
>>>> #include "units.h"
>>>> #include "asm/bug.h"
>>>> +#include "bpf-event.h"
>>>> #include <signal.h>
>>>> #include <unistd.h>
>>>>=20
>>>> @@ -1841,3 +1842,102 @@ struct perf_evsel *perf_evlist__reset_weak_gro=
up(struct perf_evlist *evsel_list,
>>>> 	}
>>>> 	return leader;
>>>> }
>>>> +
>>>> +static struct perf_evlist *sb_evlist;
>>>> +pthread_t poll_thread;
>>>=20
>>> so some of the things are static and some like poll_args
>>> you alloced on the stack.. I dont like this interface,
>>> could we come up with something generic? perhaps
>>> encapsulated in perf_evlist, like:
>>=20
>> I picked global sb_evlist and poll_thread because there=20
>> should be only one sb_evlist and one thread polling it.=20
>> There might be multiple evsel on the sb_evlist.=20
>>=20
>> I am not sure I understand your suggestion..
>>=20
>>> struct perf_evlist {
>>> 	...
>>> 	struct {
>>> 		pthread_t	th;
>>> 		int		state;
>>> 	} thread;
>>=20
>> This will not be used by the main perf_evlist, right?
>=20
> no, just by the thread interface

What is "state" here?

>=20
>>=20
>>> };
>>>=20
>>> typedef int (perf_evlist__thread_cb_t)(perf_evlist, union perf_event *e=
vent,....)
>>=20
>> How do we use this callback? We need a way to specify which
>> events to poll (mmap, bpf_event, ksymbol, etc). How do we do=20
>> that with the callback function?
>=20
> you provide your own callback

I guess I get your point now. I can try that.=20

Thanks,
Song

> jirka

