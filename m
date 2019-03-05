Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A101C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBB9205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="RU87NS5E";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="RKWGnKu5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfCEUhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 15:37:53 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60576 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726210AbfCEUhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 15:37:53 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x25KSMBW029269;
        Tue, 5 Mar 2019 12:37:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Hw93IGfGVpFO5BUXWpld4oU+17IY5uw0/elS2QLVLl4=;
 b=RU87NS5Eup7jLseiWYM8D4lJYrv4W48AP1IoY+jSc+wYYWwL5m9FupjBpuS5x9ai8EE+
 ZDk7rC03crCuvYSoUESS9/JtgTHNJUXoSQJ9U0uY7UXJ6XF044PFxNsxdOAc/vRv5JQO
 VBqSC4Ytl5l3yth25exIdRSt8SBWwZsxUDo= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r1yng84py-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 05 Mar 2019 12:37:21 -0800
Received: from prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 5 Mar 2019 12:37:19 -0800
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 5 Mar 2019 12:37:19 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 5 Mar 2019 12:37:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hw93IGfGVpFO5BUXWpld4oU+17IY5uw0/elS2QLVLl4=;
 b=RKWGnKu5rJRRr7Ym4dVRY0VqyOwYqA0kqEXcjmpID2Jk5AmPNAo8l0FmQPQNwljxwC9UENAxen0xIeTvazhJrmBKz7Byv7Y72OEXTIzhx0BkSr9T3k0wZ2lG6lEqdXC+w6OU2YiSpMuoLZmjoaeyBssDCMSQ/vQsm+uq+mz4cdQ=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1632.namprd15.prod.outlook.com (10.175.135.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Tue, 5 Mar 2019 20:37:17 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065%6]) with mapi id 15.20.1665.020; Tue, 5 Mar 2019
 20:37:17 +0000
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
Thread-Index: AQHUzWlKCfZJunEblEKUEZkb6eySeqXzo8KAgAhnFoCAAOB3AIAAoE8A
Date:   Tue, 5 Mar 2019 20:37:17 +0000
Message-ID: <3CC5A7C5-C417-46D4-8B09-4BD1A2CE3A96@fb.com>
References: <20190226002019.3748539-1-songliubraving@fb.com>
 <20190226002019.3748539-15-songliubraving@fb.com>
 <20190227132105.GC18893@krava> <15CE7BE1-9D48-404D-BF09-847C09C4300E@fb.com>
 <20190305110330.GA16022@krava>
In-Reply-To: <20190305110330.GA16022@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::2:9db8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bfcb5c9-2916-488c-882a-08d6a1aa5b80
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1632;
x-ms-traffictypediagnostic: MWHPR15MB1632:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1632;20:JFCtZFe1H3SJ+EQAIsdygHNv7DLrOBkBkeAeSNg5EJRUM+VyV0I1kv6NXcX4UncXgRjx03dbjWJLnaTK1FKvPz9YgGw7PFCrN2uGJxKy0Xa2Oo+ZdaJYkobEVcSGUklPcv/W7wAQVM8EyPhTkbhbasyRZmqPwbtlxwwYB06UBHI=
x-microsoft-antispam-prvs: <MWHPR15MB163265EE8DD3FB386DA5CEA5B3720@MWHPR15MB1632.namprd15.prod.outlook.com>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(396003)(366004)(376002)(189003)(199004)(6116002)(6916009)(316002)(93886005)(106356001)(82746002)(57306001)(33656002)(36756003)(86362001)(4326008)(68736007)(6246003)(561944003)(478600001)(105586002)(8676002)(81166006)(6512007)(81156014)(102836004)(6506007)(76176011)(2906002)(486006)(186003)(53936002)(2616005)(476003)(46003)(11346002)(446003)(256004)(71190400001)(71200400001)(5660300002)(83716004)(97736004)(8936002)(6436002)(7736002)(99286004)(14454004)(50226002)(305945005)(53546011)(54906003)(229853002)(6486002)(25786009)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1632;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uVGTjLIbA57CsT2rfURAJ4+eHdwN67rV7C+s2/WFAZITGTOst7O85HmANq7W1+55n//so9nxphJlKNXB5wr272u4lQZAh8mAvpKkM8tVCToVSSYaXgoyaIroEMh/s5pOnftngbhkeqEkbp1BQ6aC6BGEXJxkTSxDXefnFOwlfNgQso5/dEHlVkZgcGvCEcuIJveg8/URCDIy9J9D/SGXORdOKS5qpJ9zHCyTFZEQQC/y6sroDCS+oxl7uk8bnETtfah/VHcNCWVgWI8rzjEZbwHabfVn7GB5iimrtHqOGcNBnPhcdud7jBeqhSo8Tfv9ALlG6n97xfL3feptvZsnQuYkidanrPsasucqbyI/ty1atDDryM9IPeZ6KYF8eDHqq739R9yXz6tAxprTjNxIZISX5uHSttZDO3dTU2YBZ50=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D833B5271EB99D4BA6A1D46E541D6C5F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bfcb5c9-2916-488c-882a-08d6a1aa5b80
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 20:37:17.0395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1632
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-05_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 5, 2019, at 3:03 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Mon, Mar 04, 2019 at 09:40:07PM +0000, Song Liu wrote:
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
>>>=20
>>> struct perf_evlist {
>>> 	...
>>> 	struct {
>>> 		pthread_t	th;
>>> 		int		state;
>>> 	} thread;
>>> };
>>>=20
>>> typedef int (perf_evlist__thread_cb_t)(perf_evlist, union perf_event *e=
vent,....)
>>>=20
>>> perf_evlist__start_thread(perf_evlist, perf_evlist__thread_cb_t cb);
>>> perf_evlist__stop_thread(perf_evlist);
>>>=20
>>>=20
>>> jirka
>>=20
>> More questions on this proposal:=20
>>=20
>> IIUC, this approach creates one perf_evlist and one thread for each side=
 band
>> event (only bpf for now, more afterwards). Each of these perf_evlists wi=
ll=20
>> create its own ring buffer.=20
>>=20
>> On the other hand, current patch allows different events to share the th=
read,=20
>> the perf_evlist, and the ring buffer.=20
>=20
> you can have those events in single evlist no?
>=20
>>=20
>> If my understanding is correct, current patch would be more efficient do=
wn the=20
>> road? Did I miss some downsides of current patch?
>=20
> I'd just like something configurable and with single handle
> not scattered around the code, so it's easy to add new callback=20
>=20
> jirka

To make adding callbacks easy, we need to register callback per perf_evsel,=
 so=20
multiple side band events could share the perf_evlist. It will be something=
 like:

typedef int (perf_evsel__sb_cb_t)(union perf_event *event, void *data);

struct perf_evsel {
	...
	struct {
		perf_evsel__sb_cb_t *cb;
		void *data;
	} side_band;
};

perf_evlist__add_sb_event(struct perf_evlist *evlist,=20
			  struct perf_event_attr *attr,=20
			  perf_evsel__sb_cb_t cb,=20
			  void *data);
perf_evlist__start_sb_evlist(struct perf_evlist *evlist);
perf_evlist__stop_sb_evlist(struct perf_evlist *evlist);


Does this look like a good approach?

Thanks,
Song

