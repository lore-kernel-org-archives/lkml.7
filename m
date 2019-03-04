Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FBAC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC94920830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Zd/RieQt";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="GwROwBWZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfCDUpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:45:02 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36634 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726355AbfCDUpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:45:01 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x24KcItC023473;
        Mon, 4 Mar 2019 12:44:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=jbW/i57cVnS6nGt/mk9YVuNeKGArxql2O1S8ODOBdTI=;
 b=Zd/RieQtPY22mWxUzvvtAe1p0+UkbG/rJSZp0xeH0/vOyxD7jkAkqdYQ5ttK7wSSkQca
 3Jh5XU1MEuSqSOqfoXfbPjbeJdFVdzOEwYI3YJeb+M9zNWsgwbP4UnsPlWABuVNzjIgC
 nWf0XgmGG2VGTJ+1Dxc0NzNuQ7jLiT5ar60= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r19wg89wt-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 04 Mar 2019 12:44:34 -0800
Received: from frc-mbx03.TheFacebook.com (2620:10d:c0a1:f82::27) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 4 Mar 2019 12:44:28 -0800
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-mbx03.TheFacebook.com (2620:10d:c0a1:f82::27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 4 Mar 2019 12:44:28 -0800
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 4 Mar 2019 12:44:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbW/i57cVnS6nGt/mk9YVuNeKGArxql2O1S8ODOBdTI=;
 b=GwROwBWZIcKDataYFdyWSYkh4mlCCc/KcxVvlEFyWramC/8tQNWRzx9sKKizUwa3eVfvTzCSkqdc5+4Z56RQUD08IYfNWOlalxl5MwUpDV+4MBIx9PTiMFUrrGWxdIaqmqWlArheOlGd3Bjpqr6nlmHJvIxd68i9trl/IezseIk=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1824.namprd15.prod.outlook.com (10.174.255.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.16; Mon, 4 Mar 2019 20:44:25 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065%6]) with mapi id 15.20.1665.020; Mon, 4 Mar 2019
 20:44:25 +0000
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
Thread-Index: AQHUzWlKCfZJunEblEKUEZkb6eySeqXzo8KAgABL74CAB5h6AIAAY6eAgAAOggCAAADzAA==
Date:   Mon, 4 Mar 2019 20:44:25 +0000
Message-ID: <DB8CAEB3-B02B-41DE-9BBE-55B3C899C806@fb.com>
References: <20190226002019.3748539-1-songliubraving@fb.com>
 <20190226002019.3748539-15-songliubraving@fb.com>
 <20190227132105.GC18893@krava> <2506D6CF-F0E3-4640-B385-DD0843AD2928@fb.com>
 <20190304135224.GD19809@krava> <3B7ECDFA-E6F7-4136-A2E4-6115C5A4791B@fb.com>
 <20190304204100.GE2563@krava>
In-Reply-To: <20190304204100.GE2563@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::3:1d00]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: beaa2763-5077-4b44-82e1-08d6a0e23094
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1824;
x-ms-traffictypediagnostic: MWHPR15MB1824:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1824;20:4V5XqsyM+nxrR87iebew0y6jkgK133PLDWm8qOq+lre5WzQ6cpdJdgzM0uRYcUWiy7DMBNospq6ICuwOy4toKk5PSCaE4lRxMCxbTIPRTs9vEOiNkhQfzFpTqGZaEFDqKW9yrh9dZ0qrYtEYujZOM7q2qjYday+47vE7CKxP6Do=
x-microsoft-antispam-prvs: <MWHPR15MB1824D2B84446C3B29DF8BC35B3710@MWHPR15MB1824.namprd15.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(136003)(396003)(376002)(189003)(199004)(54906003)(6486002)(71190400001)(6512007)(53936002)(7736002)(6116002)(229853002)(71200400001)(478600001)(93886005)(86362001)(256004)(33656002)(316002)(36756003)(83716004)(4326008)(14454004)(5660300002)(76176011)(81166006)(82746002)(81156014)(99286004)(25786009)(6506007)(53546011)(2906002)(8676002)(57306001)(102836004)(6246003)(106356001)(105586002)(97736004)(6436002)(305945005)(486006)(68736007)(186003)(6916009)(50226002)(8936002)(446003)(11346002)(476003)(46003)(2616005)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1824;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jL7/9N34Msl0OdvrJPfw/emT1EhPCGp6rZEx4O1Xk5S4jlQpceVRuu0NZBnFZpVLNUxptHwvwD2KA9I5gFRcv41TRqrNjD4fB+Kkpxj4E/QiM7YoguQvuP+b8VgBCrkHerz7zbZcz3CgLTknkDPoAzKaiq/Uath+BOk6t28McfTGQRX0JZSPm0UIAZipQ18kxpCiW4ncc6HqcxCV7VU5IulEAcMs0l1ztH/puZ2a42sqGaYw0qYvjrdLU2HM5qTAjYNeTHZdzYZxOd7Xd+7oW/1tInVC2bVFwgdMXi1X9oEH2arHBydoT+oVlDRISiYJ61iOeZI5uzp2WkaIVE2gT+eBHDnz3mEtWV3XVBenFs1Jev+uSDKOBh5EwzUU52IQpJaImoPjQhq9xNPCUbMyF4Apcihpq2gZHqSweRlV5Uk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <40EEC074A2ADA34ABD11DAC299B4B905@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: beaa2763-5077-4b44-82e1-08d6a0e23094
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 20:44:25.5514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1824
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-04_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 4, 2019, at 12:41 PM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Mon, Mar 04, 2019 at 07:49:06PM +0000, Song Liu wrote:
>>=20
>>=20
>>> On Mar 4, 2019, at 5:52 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>>>=20
>>> On Wed, Feb 27, 2019 at 05:52:52PM +0000, Song Liu wrote:
>>>>=20
>>>>=20
>>>>> On Feb 27, 2019, at 5:21 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>>>>>=20
>>>>> On Mon, Feb 25, 2019 at 04:20:18PM -0800, Song Liu wrote:
>>>>>=20
>>>>> SNIP
>>>>>=20
>>>>>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
>>>>>> index 8c902276d4b4..61b87c8111e6 100644
>>>>>> --- a/tools/perf/util/evlist.c
>>>>>> +++ b/tools/perf/util/evlist.c
>>>>>> @@ -19,6 +19,7 @@
>>>>>> #include "debug.h"
>>>>>> #include "units.h"
>>>>>> #include "asm/bug.h"
>>>>>> +#include "bpf-event.h"
>>>>>> #include <signal.h>
>>>>>> #include <unistd.h>
>>>>>>=20
>>>>>> @@ -1841,3 +1842,102 @@ struct perf_evsel *perf_evlist__reset_weak_g=
roup(struct perf_evlist *evsel_list,
>>>>>> 	}
>>>>>> 	return leader;
>>>>>> }
>>>>>> +
>>>>>> +static struct perf_evlist *sb_evlist;
>>>>>> +pthread_t poll_thread;
>>>>>=20
>>>>> so some of the things are static and some like poll_args
>>>>> you alloced on the stack.. I dont like this interface,
>>>>> could we come up with something generic? perhaps
>>>>> encapsulated in perf_evlist, like:
>>>>=20
>>>> I picked global sb_evlist and poll_thread because there=20
>>>> should be only one sb_evlist and one thread polling it.=20
>>>> There might be multiple evsel on the sb_evlist.=20
>>>>=20
>>>> I am not sure I understand your suggestion..
>>>>=20
>>>>> struct perf_evlist {
>>>>> 	...
>>>>> 	struct {
>>>>> 		pthread_t	th;
>>>>> 		int		state;
>>>>> 	} thread;
>>>>=20
>>>> This will not be used by the main perf_evlist, right?
>>>=20
>>> no, just by the thread interface
>>=20
>> What is "state" here?
>=20
> it's replacement for the 'done' pointer u had,
> which I did not like.. leting each thread having
> its own state is better IMO
>=20
> jirka

I see. Let me try that.=20

Song

