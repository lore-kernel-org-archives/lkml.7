Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D574C04AAD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5659120825
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="YcUzhO/G";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="BX8xsQ+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfEGQNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 12:13:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36682 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726954AbfEGQNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 12:13:36 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x47GCPDY032545;
        Tue, 7 May 2019 09:13:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=vFznFHj7Ieb3B/W32DVJ5ldQIEFeJzxVRGhWTmGeYLU=;
 b=YcUzhO/GdAvDd89Ba/jwAAtTAFDxWAv69LDnKnYpWopPXt0x9og4Wa9JjQc8v4xLffFl
 gFy+OgsUyud17/M8CRo0JHHZgqi30YrRWcl0U1AyunaeZJ11tQh5hzi/mkAoqbkAyK5C
 f2KyiyvDo8anEUegXmFvjhfx7qMX7hCnqvc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0b-00082601.pphosted.com with ESMTP id 2sb7441b1m-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 07 May 2019 09:13:27 -0700
Received: from ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 7 May 2019 09:13:26 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 7 May 2019 09:13:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFznFHj7Ieb3B/W32DVJ5ldQIEFeJzxVRGhWTmGeYLU=;
 b=BX8xsQ+1AVKJVwztWRw7DOOcMtseHQWYeurNGIPEtpqmS+S0EZ8EXtDubQ6IwWhu5eV9DzTIGtmWhghxR1kkFfKv/RThKONKUHPGZKBYjECYlXNDE+le5uPBzUcBgFgnXGXtN3ozxmi+x2Ei8doNUzQ8NsjkfKpkwm8XePLpAvo=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1391.namprd15.prod.outlook.com (10.173.234.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Tue, 7 May 2019 16:13:16 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15%11]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 16:13:16 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] perf: allow non-privileged uprobe for user processes
Thread-Topic: [PATCH] perf: allow non-privileged uprobe for user processes
Thread-Index: AQHVBKibCCeKunJUxUmHRUHlbGlwGqZfieoAgABMUAA=
Date:   Tue, 7 May 2019 16:13:16 +0000
Message-ID: <2365C14A-C579-497D-A271-EC24911A6BE1@fb.com>
References: <20190507074315.3337668-1-songliubraving@fb.com>
 <20190507114006.GS2606@hirez.programming.kicks-ass.net>
In-Reply-To: <20190507114006.GS2606@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:180::5639]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8752bd4e-c19f-4431-5011-08d6d306e9b1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1391;
x-ms-traffictypediagnostic: MWHPR15MB1391:
x-microsoft-antispam-prvs: <MWHPR15MB139165AF00C3488F0A7BDB4DB3310@MWHPR15MB1391.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:741;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(136003)(376002)(396003)(39860400002)(199004)(189003)(53936002)(6486002)(229853002)(316002)(25786009)(4326008)(186003)(6436002)(11346002)(6246003)(446003)(486006)(476003)(2616005)(6916009)(82746002)(33656002)(6506007)(50226002)(73956011)(64756008)(66556008)(66946007)(66476007)(66446008)(46003)(99286004)(53546011)(76176011)(5660300002)(102836004)(256004)(57306001)(83716004)(71190400001)(76116006)(4744005)(6512007)(68736007)(71200400001)(36756003)(2906002)(86362001)(8936002)(14454004)(54906003)(478600001)(7736002)(6116002)(81166006)(8676002)(81156014)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1391;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3qWwR7ZyCeOhXEMz5uUG/rfYaOrBFwvrh98xrTByg0RSx5f/54MYysYCW6hup1Imf6KdkiotmgenetTa+kYK19vdFIXTjI/zfxJsRMYVG8MPCJFFtAjznnAWDtFL744g1F59m7TT0QIv+O58zGP1J1RFPyeKW45ls4bRS6FcH96qq37f2IJDYYa5iqOl+ib4qFkVG2BfEBFFz3fuw/G8xC0v/cF5qG2OqrhP7uQUlam4sfUn7v3Z64M6cqJf609BqUvdCpBPB7i6b7JrLSFl9o0AGdCqeAou66AC3U7DA5esyZrONjfkxulW8Y39t9quycz/E2SZNYoR3YreiymoxTDnJTiWlMWQ2uFcBF/PU85t+3XtuZH5Go7vOdx6gtNYEfd4aCilVLjgkLf5B+QX3eVbZdTewWdmEHkm6t+/vOs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D8D19392457B7F4CBAAA78681A1F0716@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8752bd4e-c19f-4431-5011-08d6d306e9b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 16:13:16.2008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1391
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-07_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=962 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905070105
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 7, 2019, at 4:40 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Tue, May 07, 2019 at 12:43:15AM -0700, Song Liu wrote:
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index abbd4b3b96c2..0508774d82e4 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -8532,9 +8532,10 @@ static int perf_tp_event_match(struct perf_event =
*event,
>> 	if (event->hw.state & PERF_HES_STOPPED)
>> 		return 0;
>> 	/*
>> -	 * All tracepoints are from kernel-space.
>> +	 * All tracepoints except uprobes are from kernel-space.
>> 	 */
>> -	if (event->attr.exclude_kernel)
>> +	if (event->attr.exclude_kernel &&
>> +	    ((event->tp_event->flags & TRACE_EVENT_FL_UPROBE) =3D=3D 0))
>=20
> That doesn't make sense; should you not be checking user_mode(regs)
> instead?

Yes! user_mode(regs) is better! V2 coming soon.

Thanks,
Song

