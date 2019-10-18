Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCBCCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3643621925
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="LQKBiFBm";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="IqRD4rOP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504481AbfJRGzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 02:55:33 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54580 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2504384AbfJRGzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 02:55:33 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9I6rMGV024101;
        Thu, 17 Oct 2019 23:55:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=GeKlOV6HYItMeNLmIQ4dCfLmz2q4HrOKUJQL5ks5fxc=;
 b=LQKBiFBm8weLb1EIrllMlypGjRcznoaqDkKpr2QGjTYg7IiJwad8gkuZEf+RrP4HBhh+
 hB3zJ1vkKJumTBpuj99yzsyS0C1zaIVaLA+6p2P2ghK9QqvewcGL0/r0WlngjAFU+Mjy
 Um+h4rfARSxn/matJf2EfssdGcL/HGt09uQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vpsd6bxbf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 17 Oct 2019 23:55:17 -0700
Received: from ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) by
 ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 17 Oct 2019 23:55:16 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 17 Oct 2019 23:55:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KX6O9QUfe7fj5yR0C4LP3pZhWX+LDArZjgWDU8+yQLyPdp5K5/fbEbr3h/w0CptvQQj+lWVfP2cvZNfA2RjJAakFdahynPWYA+h1gDaWJicSsscHe0zF9QdKgGYXVbl1YKqI6uaKxNLZmMVEsI0R09/F3fl33YTmsw92j/yi6f/sRaPAxE/wsaGaK2q1WoE+objLb6EQ7SsnRl8QEZHMgggxU2b5qIhxNRVXU9YPVAPnbq2JYugdKvuaPEWY15nEb58K1ytR5c6Kan30l/Cxrti+yz0WGavrjVXUW1YlpG2wkFoTJ7tTRwwsy5G2+3WWXOygiLczsK5eIspAgUYEew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeKlOV6HYItMeNLmIQ4dCfLmz2q4HrOKUJQL5ks5fxc=;
 b=FAL08U2cUCo5H4Ar81G5Ind5lVZAS6tq9ddaDwbe5AbUOEOH42pjs/SuFESf0MmEG5nKGDgiSEyDNxWUDD1yCvWOTmvhxmbu3mChwHunt2y8Vuksn0lA+pguzieLjsrN/Qkyuzyc+zyXdLT2VsHQBnDdZ51lPP9Mgopz07K/tePn+u7m6OkXmLhEdwCUrGnkCaOTbbfCFzs1OuNGGSdHNgU7xR+LopNd32JheG0IPXsYilCGioZLtvex9kNRXZheqgLLvcaUGei+HFeCXYZruGmY4BgL77RLRCd1droa0qoLkLItjmQAv44TtAf2IvpSe2SPi63zIB8lN5TZi6s5BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeKlOV6HYItMeNLmIQ4dCfLmz2q4HrOKUJQL5ks5fxc=;
 b=IqRD4rOPg0YDMUhPQ4lGhTX5i+3+AKTkfcODpZGxU1NuRjsEx8BX9K96puxBYXb0+nMj8FjBoHI++g48ipviiZnzq0u79qk5MoOU2qD9fF/JkHUeWpV880omFwTKfA3OIZ8pt14cuH8AF7NvOVW8HL07vJBOSVdVly6dK4mEWuo=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1199.namprd15.prod.outlook.com (10.175.2.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.19; Fri, 18 Oct 2019 06:55:14 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5%5]) with mapi id 15.20.2367.019; Fri, 18 Oct 2019
 06:55:14 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Stephane Eranian <eranian@google.com>
CC:     open list <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@elte.hu" <mingo@elte.hu>,
        "acme@redhat.com" <acme@redhat.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "kan.liang@intel.com" <kan.liang@intel.com>,
        "irogers@google.com" <irogers@google.com>
Subject: Re: [PATCH] perf/core: fix multiplexing event scheduling issue
Thread-Topic: [PATCH] perf/core: fix multiplexing event scheduling issue
Thread-Index: AQHVhUsMoVyDSFs26kucCFo0fCE/0adf67AAgAABuQCAAAn8AA==
Date:   Fri, 18 Oct 2019 06:55:14 +0000
Message-ID: <32FCDA83-9888-480A-9A77-AEB37FD004CE@fb.com>
References: <20191018002746.149200-1-eranian@google.com>
 <7B6B74DF-53E0-42DA-97D6-3F04E84D688B@fb.com>
 <CABPqkBT40-wVWq7K93QJc1r_1=R0WQuoa_SHebWApPEstCWeNg@mail.gmail.com>
In-Reply-To: <CABPqkBT40-wVWq7K93QJc1r_1=R0WQuoa_SHebWApPEstCWeNg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3594.4.19)
x-originating-ip: [2620:10d:c090:180::37f8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f759ca0a-3899-461e-c7ff-08d7539820e1
x-ms-traffictypediagnostic: MWHPR15MB1199:
x-microsoft-antispam-prvs: <MWHPR15MB11991B54B96F7049CCFF247EB36C0@MWHPR15MB1199.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(376002)(346002)(136003)(189003)(199004)(51914003)(6512007)(46003)(6246003)(186003)(33656002)(81156014)(81166006)(8676002)(76116006)(66446008)(64756008)(66556008)(66946007)(66476007)(8936002)(229853002)(6436002)(50226002)(486006)(476003)(11346002)(2616005)(446003)(7736002)(305945005)(6486002)(76176011)(316002)(36756003)(6116002)(14454004)(256004)(86362001)(478600001)(2906002)(54906003)(6916009)(4326008)(71190400001)(25786009)(99286004)(5660300002)(6506007)(53546011)(71200400001)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1199;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IZ0t9yIcRFraF0OgqE1AS7qTu8xl8hHiEVzm7KTcm9RZvBMzBmJRQOXt8XfAaJlk50Lfgzvmb7haD1uxewl0EWDHkl8Fv2dpQB4HLDjUTzEAXq4LKDHeHkAHfJgiHVXddjusX0IIBfo0Rbf6SQQ1hMYTCubWUzgKuSgBxi3LyRZmH5u8NyZgFA4Y0ANkGd3Ump1IiJ3iNZReJ0GLytXY525vwTAkeIQWVex/CeHHgSmKJNeFoZuPCworAgQ1PN3d4JxigSIpnmlWo6BGIu+iD7h82BqB++N6tmacVka2IxHuDiYbXwtpMrY+l6AmjiD+9Y4l0fvCGBVB+S6CW8n9ExkiLKWKMK3uqIiLofFv1bu9M7i8Z2SEufjV4JPVta7RB/a8WvMnPfTZtViJyIyPAIe8YwUNh7PyH7pnI2PkBKM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1A09FA85496B174A90A7C5BC124A883A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f759ca0a-3899-461e-c7ff-08d7539820e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 06:55:14.6957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /xUwyRog+Fq2TT/k6q3BxQnAwt0fQwiafbul/ngNh/9FSIcLbq68YerGiPEhNybF/rvJv6jaGSLDmTyBRGnCYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1199
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-18_02:2019-10-17,2019-10-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0
 clxscore=1015 phishscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1910180065
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 17, 2019, at 11:19 PM, Stephane Eranian <eranian@google.com> wrote=
:
>=20
> On Thu, Oct 17, 2019 at 11:13 PM Song Liu <songliubraving@fb.com> wrote:
>>=20
>>=20
>>=20
>>> On Oct 17, 2019, at 5:27 PM, Stephane Eranian <eranian@google.com> wrot=
e:
>>>=20
>>> This patch complements the following commit:
>>> 7fa343b7fdc4 ("perf/core: Fix corner case in perf_rotate_context()")
>>>=20
>>> The fix from Song addresses the consequences of the problem but
>>> not the cause. This patch fixes the causes and can sit on top of
>>> Song's patch.
>>>=20
>>> This patch fixes a scheduling problem in the core functions of
>>> perf_events. Under certain conditions, some events would not be
>>> scheduled even though many counters would be available. This
>>> is related to multiplexing and is architecture agnostic and
>>> PMU agnostic (i.e., core or uncore).
>>>=20
>>> This problem can easily be reproduced when you have two perf
>>> stat sessions. The first session does not cause multiplexing,
>>> let's say it is measuring 1 event, E1. While it is measuring,
>>> a second session starts and causes multiplexing. Let's say it
>>> adds 6 events, B1-B6. Now, 7 events compete and are multiplexed.
>>> When the second session terminates, all 6 (B1-B6) events are
>>> removed. Normally, you'd expect the E1 event to continue to run
>>> with no multiplexing. However, the problem is that depending on
>>> the state Of E1 when B1-B6 are removed, it may never be scheduled
>>> again. If E1 was inactive at the time of removal, despite the
>>> multiplexing hrtimer still firing, it will not find any active
>>> events and will not try to reschedule. This is what Song's patch
>>> fixes. It forces the multiplexing code to consider non-active events.
>>=20
>> Good analysis! I kinda knew the example I had (with pinned event)
>> was not the only way to trigger this issue. But I didn't think
>> about event remove path.
>>=20
> I was pursuing this bug without knowledged of your patch. Your patch
> makes it harder to see. Clearly in my test case, it disappears, but it is
> just because of the multiplexing interval. If we get to the rotate code
> and we have no active events yet some inactive, there is something
> wrong because we are wasting counters. When I tracked the bug,
> I started from the remove_context code, then realized there was also
> the disable case. I fixed both and they I discovered your patch which
> is fixing it at the receiving end. Hopefully, there aren't any code path
> that can lead to this situation.

Thanks for the explanation. Agreed that blind spot has bigger impact=20
with longer rotation interval.=20

[...]

>>> Signed-off-by: Stephane Eranian <eranian@google.com>
>>=20
>> Maybe add:
>> Fixes: 8d5bce0c37fa ("perf/core: Optimize perf_rotate_context() event sc=
heduling")
>>=20
> It does not really fix your patch, I think we can keep it as a double
> precaution. It fixes
> the causes. I think it is useful to check beyond the active in the
> rotate code as well.

Also agreed, this is not really fixing that specific commit.=20

Acked-by: Song Liu <songliubraving@fb.com>

Thanks,
Song


