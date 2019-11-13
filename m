Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B62C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC49204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alertlogic.onmicrosoft.com header.i=@alertlogic.onmicrosoft.com header.b="H7bPLmhV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfKMKP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:15:27 -0500
Received: from mail-eopbgr730128.outbound.protection.outlook.com ([40.107.73.128]:14105
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726338AbfKMKP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:15:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCD6JFvO1BWYmG4mtE1lU605EJ0lXCdV6Jxr0D8X0JnZWB36pILT3c5Ssr8Z2kWEcFINhpeluWk8R+GbR7B1ykNQ/bC00afgquUawj/xetVAq3ylqaxVVKr/y83r06osvN0l10nFDbxbGJVVK/t44R+zxvatYeg5ddCED5LTG7uF/KxXJP2Yl8ihK3fdoKRV0XKe1Cuv9W9gufcyHES+wc7ThMJ7oY7QBZTWuIswnpQMhiXJZ9y0xEYYId52anoSVtdj96Zx22p6nv10G18pqaNIn7qM8cSAwDi4KrR2CWfby1j14mkGZq9rFjEpZEjD41iEybWAqgUV/i9ra4KcTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1giSbq9xao5o2Wa4LV27iUCo8q0FNFq6t3RBBsxKJdY=;
 b=K/jC2kHDiSDVvT9RPKsZVDZEde6zdyle04JR0jqv70p+3jnBSDBfbN0I1vjvyL6pbXKq/nzJYTYUZJVg7yd7q0QO8JmnqfiiajzvS2bh6HjyyV28cYmBNoxQqqffWXGqnRh/ZML+KogWvfkcwCIW1hURNLOhUc6JSPEz5uP87yb4iHlZoZEvXXw9wDKy5/Ot17cGDljRKbvvxcABeCptOEnUiuVkSVHFmgHqGSftxjwDThVEUT2D56gugmfulUQZd1RZs7y70I4+pvrK5w3WOQcVnG2DfbJijyjoDQW2e/5ZSqcsckLJlkt9JEmKULtx4kZtPH7G4QEAIkAa7zn+ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=alertlogic.com; dmarc=pass action=none
 header.from=alertlogic.com; dkim=pass header.d=alertlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=alertlogic.onmicrosoft.com; s=selector2-alertlogic-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1giSbq9xao5o2Wa4LV27iUCo8q0FNFq6t3RBBsxKJdY=;
 b=H7bPLmhV8X8OZuxks30uiQxrxfcctWL1Dx/bNPPMEhsS76AsIRk1mEO7Ntm+Lv8miawcDfCuI/aIKJhvcqoWMn18yxPQ0i9SsKOnXAe6zhM6THGVZTi/BW2HwNH0QghBB3oSJfxnyHFsWOVd3CA49C9YsIxmI1OARhLtF3brlvw=
Received: from BYAPR20MB2726.namprd20.prod.outlook.com (20.178.238.150) by
 BYAPR20MB2791.namprd20.prod.outlook.com (20.178.238.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Wed, 13 Nov 2019 10:15:22 +0000
Received: from BYAPR20MB2726.namprd20.prod.outlook.com
 ([fe80::b1ef:70a1:4100:26a4]) by BYAPR20MB2726.namprd20.prod.outlook.com
 ([fe80::b1ef:70a1:4100:26a4%3]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 10:15:22 +0000
From:   "Harris, Robert" <robert.harris@alertlogic.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Ingo Molnar <mingo@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Harris, Robert" <robert.harris@alertlogic.com>
Subject: Re: Help requested: futex(..., FUTEX_WAIT_PRIVATE, ...) returns EPERM
Thread-Topic: Help requested: futex(..., FUTEX_WAIT_PRIVATE, ...) returns
 EPERM
Thread-Index: AQHVmYBWfg0+aL4WQEeFFOC3OWpiUqeIz6MAgAAT34A=
Date:   Wed, 13 Nov 2019 10:15:21 +0000
Message-ID: <90781C7F-BF54-4913-8548-2FE815CCAC95@alertlogic.com>
References: <E0332978-739B-4546-9C3F-975216C349D2@alertlogic.com>
 <alpine.DEB.2.21.1911130956150.1833@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1911130956150.1833@nanos.tec.linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=robert.harris@alertlogic.com; 
x-originating-ip: [165.225.81.101]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49a6f767-92c2-44f3-23b0-08d7682264a5
x-ms-traffictypediagnostic: BYAPR20MB2791:
x-ms-exchange-purlcount: 4
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR20MB27910E7BB653E5D933CA51B294760@BYAPR20MB2791.namprd20.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10019020)(346002)(376002)(396003)(366004)(136003)(39850400004)(199004)(189003)(6306002)(6512007)(64756008)(66556008)(446003)(86362001)(14454004)(6916009)(91956017)(76116006)(66946007)(71200400001)(66476007)(71190400001)(99286004)(25786009)(76176011)(54906003)(66446008)(36756003)(6436002)(966005)(316002)(6486002)(6246003)(478600001)(486006)(11346002)(2616005)(476003)(33656002)(2906002)(6116002)(3846002)(102836004)(26005)(5024004)(186003)(256004)(81156014)(81166006)(53546011)(6506007)(5660300002)(8676002)(8936002)(229853002)(14444005)(55236004)(7736002)(4326008)(66066001)(305945005)(107886003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR20MB2791;H:BYAPR20MB2726.namprd20.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: alertlogic.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FdCvZiZMFIXTDTaqm8H+fuPa62GJw71KPFwDQl56B4Axw+5ajWIaFC46GsxBWnAxHrOzSXtFo/5JgRHOTjUpWbmtuew2OpxMt++oQBQ7JPuVxFrwk1NdwLrUeBk1RSc6Vlexnn15nct5XfweDOn6Oz6NfzVVronwkxTgy65WIrMhcx9MvaRB1Rg0hXrF9cNTihk6B5/ndNvFyPmR6KPLauTNbTeKeP4E/eHFikp3j9MOmcZ9wZ1ceyMXEGIZS0F8qiQeImk1EuFBnY6A1ucNwjXsJBwhHYceRLhvFyLT5gLDwC4whSyQtMJ4dqM720Nx1DFKDf4U2YQu/7DJSeC5v6EAX1lDFQakJei+2EnE8zJF7zB383BRz2b8Lith7sz1vw5nyaRu6I87KaVp4eNQIV/sgn/D2s5wo7punS+a9s8P0WqxCGk+NKhVJBIryAupbBgg2bcKJgBq85EcbM9/JqYQpfMSURVaVUdWkfr6ar6ZhikcpkJFojn1m6iqMfhhRCb+MTf36dmk/nE3THqelpS+X8KPpSMBnAG1IRqbwYw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30901EDAF0C91447B7FD61B2F82AE8B1@namprd20.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: alertlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a6f767-92c2-44f3-23b0-08d7682264a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 10:15:21.9577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04151827-cb2a-4231-9c24-1ef5ffc408eb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YzMVhxXv7gaKfC/hL7BbuALCA+v9OO1BIJt2Xaf5IG5TzUZSMO7YxlI2Z5p7RYddLLcWPEFoW8ISVvzdK+kCRcWy4BQgfSX0gLbQxVd/r80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR20MB2791
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 13 Nov 2019, at 09:04, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Tue, 12 Nov 2019, Harris, Robert wrote:
>
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
> sys_futex(FUTEX_WAIT_PRIVATE) does not return -EPERM. Only the PI variant=
s
> do that.

In that case I would appreciate a second pair of eyes.  The error I see
(intermittently) is

pthread/ethr_event.c:164: Fatal error in wait__(): Operation not permitted =
(1)

which comes from

https://github.com/erlang/otp/blob/348e328375fb774b3fa919ffd1c4811367406516=
/erts/lib_src/pthread/ethr_event.c#L152-L164

> res =3D ETHR_FUTEX__(&e->futex,
>    ETHR_FUTEX_WAIT__,
>    ETHR_EVENT_OFF_WAITER__,
>    tsp);
> switch (res) {
> case EINTR:
> case ETIMEDOUT:
>     return res;
> case 0:
> case EWOULDBLOCK:
>     break;
> default:
>     ETHR_FATAL_ERROR__(res);

where

https://github.com/erlang/otp/blob/348e328375fb774b3fa919ffd1c4811367406516=
/erts/include/internal/ethread.h#L259-L260

> #define ETHR_FATAL_ERROR__(ERR) \
>   ethr_fatal_error__(__FILE__, __LINE__, __func__, (ERR))

and

https://github.com/erlang/otp/blob/348e328375fb774b3fa919ffd1c4811367406516=
/erts/lib_src/common/ethr_aux.c#L725-L741

> ETHR_IMPL_NORETURN__ ethr_fatal_error__(const char *file,
> int line,
> const char *func,
> int err)
> {
>     char *errstr;
>     if (err =3D=3D ENOTSUP)
> errstr =3D "Operation not supported";
>     else {
> errstr =3D strerror(err);
> if (!errstr)
>     errstr =3D "Unknown error";
>     }
>     fprintf(stderr, "%s:%d: Fatal error in %s(): %s (%d)\n",
>     file, line, func, errstr, err);
>     ethr_abort__();
> }

and

https://github.com/erlang/otp/blob/348e328375fb774b3fa919ffd1c4811367406516=
/erts/include/internal/pthread/ethr_event.h#L38-L58

> #if defined(FUTEX_WAIT_PRIVATE) && defined(FUTEX_WAKE_PRIVATE)
> #  define ETHR_FUTEX_WAIT__ FUTEX_WAIT_PRIVATE
> #  define ETHR_FUTEX_WAKE__ FUTEX_WAKE_PRIVATE
> #else
> #  define ETHR_FUTEX_WAIT__ FUTEX_WAIT
> #  define ETHR_FUTEX_WAKE__ FUTEX_WAKE
> #endif
>
> typedef struct {
>     ethr_atomic32_t futex;
> } ethr_event;
>
> #define ETHR_FUTEX__(FTX, OP, VAL, TIMEOUT)\
>   (-1 =3D=3D syscall(__NR_futex,\
>  (void *) ethr_atomic32_addr((FTX)),\
>  (OP),\
>  (int) (VAL),\
>  (TIMEOUT),\
>  NULL,\
>  0)\
>    ? errno : 0)

To be sure:

>    0x0000000000687e65 <+325>:   mov    $0x80,%edx
>    0x0000000000687e6a <+330>:   mov    $0xca,%edi
>    0x0000000000687e6f <+335>:   callq  0x443ab0 <syscall@plt>

Thanks,

Robert


Confidentiality Notice | This email and any included attachments may be pri=
vileged, confidential and/or otherwise protected from disclosure. Access to=
 this email by anyone other than the intended recipient is unauthorized. If=
 you believe you have received this email in error, please contact the send=
er immediately and delete all copies. If you are not the intended recipient=
, you are notified that disclosing, copying, distributing or taking any act=
ion in reliance on the contents of this information is strictly prohibited.
