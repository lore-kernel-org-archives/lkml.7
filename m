Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EEEC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA8120637
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alertlogic.onmicrosoft.com header.i=@alertlogic.onmicrosoft.com header.b="LEuFzO9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbfKMRE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:04:29 -0500
Received: from mail-eopbgr730090.outbound.protection.outlook.com ([40.107.73.90]:21376
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727001AbfKMRE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 12:04:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VN8qn0QYFeVKfmzUSlXUzSIjG+VcSaS3QO4QqZT6Z5DQU8rPLZv0uEHzyKr7YtbhVlSqJpmz+fi3+BVXApijh0buRTsJLA8W315mRRo7bya1Ku3mWOO0UTTbzgnp21sYlh959mdMqSyeK8X6jNdDxNHOfhTAjH0FtxJlL4hHUKWjPuSnjVSjR/Y9UdjAeKmWK/E90FmDd3nfDSv6nJMyAxMa9sfKpJgWtCvoi45s57++SYzXwlNB12aq1SaUD1gRUIMjn4aj6Gc3B8gLN6Yti/pNQ6eXMnBZVvIQmBEtzIOBshd4HCxB4Xumc48WtfjDH3avAwnmEoFtI61HNRxkoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tf3OC2zISoJw0lCOGaei0Pe4md8B6jtyM5EKCXRvwXs=;
 b=dLPehNL0l2Xf/345EhE7EdU7LeDq1cEzs2P6RSzytUTYMWtPIs0Kt8i4SZBSMQBPkxUbM6I49mnZ6uy/shwlREk9qMyTG5dmA8fH1cwIbjvuFxA01+ND/Bp5dsOfyjQjlAzjQT+hqbbHJRmlTYZvA3SryPuPb4/srVhrONSuNuk53figRoE46CEyjUmOJQd4WErjMvKCx/cHpvYgwd1Nt4s958wx/9D3w2Erh9CDEZqOxL1yWgQGxMSeDimNtSX5yzSQ47q3lP9DdnExuVIXr8JP1SYuRK5dwaW1G67kWO/8yWSLMr/pbE8PLL2fANC25c4480+49/Y3vZixxKqkXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=alertlogic.com; dmarc=pass action=none
 header.from=alertlogic.com; dkim=pass header.d=alertlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=alertlogic.onmicrosoft.com; s=selector2-alertlogic-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tf3OC2zISoJw0lCOGaei0Pe4md8B6jtyM5EKCXRvwXs=;
 b=LEuFzO9lo42WLVkfBiMhI2wBVeEVMPZK7Z/kquID2R4M6Er+XqMdlpagDQPlqQb/nM4ZwG3ilxs+53ck2HueS+TjAA2cL9JGauppJQkv3fecZdkL2UviIuU1k3pVDMq+3paVZj2GcVYYTspW8DNmwgis7I3YEpMDcON4S3yQCgE=
Received: from BYAPR20MB2726.namprd20.prod.outlook.com (20.178.238.150) by
 BYAPR20MB2664.namprd20.prod.outlook.com (20.178.238.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Wed, 13 Nov 2019 17:03:45 +0000
Received: from BYAPR20MB2726.namprd20.prod.outlook.com
 ([fe80::b1ef:70a1:4100:26a4]) by BYAPR20MB2726.namprd20.prod.outlook.com
 ([fe80::b1ef:70a1:4100:26a4%3]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 17:03:44 +0000
From:   "Harris, Robert" <robert.harris@alertlogic.com>
To:     Mikael Pettersson <mikpelinux@gmail.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Harris, Robert" <robert.harris@alertlogic.com>
Subject: Re: Help requested: futex(..., FUTEX_WAIT_PRIVATE, ...) returns EPERM
Thread-Topic: Help requested: futex(..., FUTEX_WAIT_PRIVATE, ...) returns
 EPERM
Thread-Index: AQHVmYBWfg0+aL4WQEeFFOC3OWpiUqeJGdEAgAA7yYA=
Date:   Wed, 13 Nov 2019 17:03:44 +0000
Message-ID: <B5EC0909-54CE-47D6-8930-8C9CFC243180@alertlogic.com>
References: <E0332978-739B-4546-9C3F-975216C349D2@alertlogic.com>
 <CAM43=SP-CTHWdMCJwioUiEVSNnh-AgZj7YEK1i08TXHk3oCbLQ@mail.gmail.com>
In-Reply-To: <CAM43=SP-CTHWdMCJwioUiEVSNnh-AgZj7YEK1i08TXHk3oCbLQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=robert.harris@alertlogic.com; 
x-originating-ip: [165.225.81.101]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d148f9b-0b47-4f16-12fa-08d7685b7153
x-ms-traffictypediagnostic: BYAPR20MB2664:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR20MB2664CD25DFB3413AC4D8170E94760@BYAPR20MB2664.namprd20.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(136003)(376002)(366004)(39850400004)(199004)(189003)(8936002)(6246003)(1411001)(81166006)(66476007)(316002)(66946007)(3846002)(229853002)(99286004)(76116006)(66446008)(64756008)(8676002)(91956017)(6116002)(54906003)(107886003)(33656002)(81156014)(2906002)(66556008)(6436002)(5660300002)(6486002)(71200400001)(6512007)(478600001)(14454004)(6916009)(66066001)(4326008)(53546011)(2616005)(256004)(5024004)(14444005)(25786009)(86362001)(11346002)(446003)(36756003)(4001150100001)(486006)(305945005)(476003)(7736002)(55236004)(186003)(102836004)(6506007)(26005)(76176011)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR20MB2664;H:BYAPR20MB2726.namprd20.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: alertlogic.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Okz9hTpUzHA4O0TAtAqgrCn6SqeI9nWXsccoGbiS3LtnR+ysxS0Rs/dsLmiuItBv9zHdBa46/g5KZ6ZKqAPJloWPCWg1LfqxxNLtDZPfTPpG1NKeVMJbK9g68apnTsq0KdSXJRrAPQQ+634zx7vjT7QuRKXyLywJlQgHa8pP970cNragvMMcTmpfIs0XtCcscwwQc+DjHzox8ID/tc+SVyVoLR/paC7w5bLs/HmKO0S4kz+hFtxahGsReA1FCjHqyZ3eqtiA9/15jgIHeAuTTWIEAz+ILY17Ey7k2W9WXXaOIff4RuyLj3tAD5P2my3U+YbvySpQ1GGLbNQrhPpefxHvqACYJ/yXz62XME6gm1Vqn6J5SG8KSjg69H6PVsFEg7bvig9ka+JgJlmdQewe2dtm537/14zlquCe8FjxpuU43xGNA1iNf13PQwoxZqOn
Content-Type: text/plain; charset="us-ascii"
Content-ID: <44DAA7D80C967C44BD812C265C9D12AE@namprd20.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: alertlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d148f9b-0b47-4f16-12fa-08d7685b7153
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 17:03:44.5368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04151827-cb2a-4231-9c24-1ef5ffc408eb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tWVgwPrYFwNcYZ/m2Sco9Waxx2vkrXSPO3MuWvnfDTPOW5saXGFF9I+7pCUrY1eONKVvN5d8EjLeNipE2Al7U1fjmMAbFBnOT4tV0p0T+Qk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR20MB2664
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 13 Nov 2019, at 13:29, Mikael Pettersson <mikpelinux@gmail.com> wrote:
>
> On Tue, Nov 12, 2019 at 6:43 PM Harris, Robert
> <robert.harris@alertlogic.com> wrote:
>>
>> I am investigating an issue on 4.9.184 in which futex() returns EPERM
>> intermittently for
>>
>> futex(uaddr, FUTEX_WAIT_PRIVATE, val, &timeout, NULL, 0)
>>
>> The failure affects an application in an AWS lambda;  traditional
>> debugging approaches vary from difficult to impossible.  I cannot
>> reproduce the problem at will, instrument the kernel, install a new
>> kernel or get an application core dump.
>>
>> Understanding the circumstances under which EPERM can be returned for
>> FUTEX_WAIT_PRIVATE would be useful but it is not a documented failure
>> mode.  I have spent some time looking through futex.c but have not
>> found anything yet.  I would be grateful for a hint from someone more
>> knowledgeable.
>
>
> I just wanted to add that a colleague of mine reported the exact same
> issue to me two days ago: a highly threaded application (the Erlang
> VM) running in AWS lambda, futex wait calls occasionally failing with
> EPERM.  I don't have more specifics than that, I've asked for kernel
> version and the exact parameters in the failed futex call.

Thanks, that's a great data point.  One of my outstanding questions had
been "why does this happen to only us?"

When I look at the timings I can say with some confidence that the
problem stopped for us minutes after

2017 on 2019-10-23 in us-east-1
2030 on 2019-10-24 in eu-west-1
1817 on 2019-10-25 in us-west-2

(all times UTC).  I've logged a ticket with Amazon to find out what
changed.

Robert
Confidentiality Notice | This email and any included attachments may be pri=
vileged, confidential and/or otherwise protected from disclosure. Access to=
 this email by anyone other than the intended recipient is unauthorized. If=
 you believe you have received this email in error, please contact the send=
er immediately and delete all copies. If you are not the intended recipient=
, you are notified that disclosing, copying, distributing or taking any act=
ion in reliance on the contents of this information is strictly prohibited.
