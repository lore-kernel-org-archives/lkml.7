Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24A0C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 05:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666EF20870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 05:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="KEnC70vJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731205AbfIEFnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 01:43:09 -0400
Received: from mail-eopbgr820045.outbound.protection.outlook.com ([40.107.82.45]:26944
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726088AbfIEFnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 01:43:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aazve+NoOdtqIyn5Q0arXiQQ0nvdYdY0WtZBL+aEZgdsjukMIpSIFms/mw1DbBy9hjX4ppR5sNk/BoJWNM8xyKvKvyEaw2v3AioUq7Pm24qVjohOjjOccBrvpo6hqrnKtEREKsJe13kTK77kBGlGbHjJZe2hNhyyO7tCwUm5ar5ZAOxGDGnuNuhQ9yS/0P/w8fPdP0uEObWnI27hi3KpKyNtXynJ+ZKDlCi0TPN5XC3uhgO/5w4zn6opqhWu9yom5hBUKzrThQsorGToKmf9en8GuSOJO0qzM9yy+eKGzUb6A31y5d6iQ/ExPpGWlAa3RRz5YFpPWVaUB40STQOnMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8Ku5Ysvbh4L7j8Y5CF63aDcv/NN/Qzu1ar2MGDWO7E=;
 b=DfeKLL0Gp5yCNbw8tJnwYOOWu+ZgCyzvH6i5c8LZrSOXeD3E6wOTnktWLUCqyJBKxU/E50+/T5c3lf41/2XYcfb2Pm6wk6Bhy78504Ks2oL96OsgA6eRzILK6vOzxX+fnCfEsyjdcSrtwxlNOVuwOp3yvhxWEmUhOhz/aEUVygaBQdguViLKRnaFT0audtYr17NQo1IVSMaxtjc66Uuj8fLl7Kua5OM1/4S/hzfQojJPtZ9z3V/zKcnr17at9ybRJyX36mrEvj8YZ/UeLz6VZfHyCrI4sydu8MKFJw6vnwtbKcLoPVGcaBoObUKUKMukdyt/GZ/KlAKqVovDxDmAbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8Ku5Ysvbh4L7j8Y5CF63aDcv/NN/Qzu1ar2MGDWO7E=;
 b=KEnC70vJ0MzXcmIjlBvLGyLyUC1bef07nMAQ66TaLsCzpa1+mXFL5BH1eczcfDgR4VjW9dzpxr2+ZQdA+NmVVTWLbnC9tFphcwVC6RI7mH0JHGQZYjCz8Lw7YULNtD7dMxA+qFhU6HS+9jfMakU3PFgsZKG+Z070yFbzc4TzUWs=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6694.namprd05.prod.outlook.com (20.178.235.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.7; Thu, 5 Sep 2019 05:43:05 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::b5c9:9c17:bcf1:1310]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::b5c9:9c17:bcf1:1310%5]) with mapi id 15.20.2241.011; Thu, 5 Sep 2019
 05:43:05 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
CC:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH v2 4/6] compiler-gcc.h: add asm_inline definition
Thread-Topic: [PATCH v2 4/6] compiler-gcc.h: add asm_inline definition
Thread-Index: AQHVX4jXnzVNLzmXMEaCagqvuSDaIaccP+wAgABalAA=
Date:   Thu, 5 Sep 2019 05:43:05 +0000
Message-ID: <C0D6E68C-AA52-4097-A626-5B8FBC67D445@vmware.com>
References: <20190829083233.24162-1-linux@rasmusvillemoes.dk>
 <20190830231527.22304-1-linux@rasmusvillemoes.dk>
 <20190830231527.22304-5-linux@rasmusvillemoes.dk>
 <CAKwvOdktYpMH8WnEQwNE2JJdKn4w0CHv3L=YHkqU2JzQ6Qwkew@mail.gmail.com>
In-Reply-To: <CAKwvOdktYpMH8WnEQwNE2JJdKn4w0CHv3L=YHkqU2JzQ6Qwkew@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd440251-27bc-48fe-f4d1-08d731c3ecce
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB6694;
x-ms-traffictypediagnostic: BYAPR05MB6694:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <BYAPR05MB669451CD1717AD2D87CD9331D0BB0@BYAPR05MB6694.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(199004)(189003)(33656002)(86362001)(8676002)(81156014)(81166006)(14454004)(966005)(99286004)(6486002)(476003)(4326008)(71190400001)(53546011)(76176011)(71200400001)(102836004)(76116006)(2616005)(8936002)(66946007)(25786009)(66446008)(64756008)(66556008)(66476007)(229853002)(11346002)(6506007)(36756003)(6246003)(53936002)(3846002)(6436002)(6306002)(26005)(446003)(6512007)(186003)(6916009)(316002)(6116002)(486006)(7736002)(256004)(305945005)(5660300002)(478600001)(66066001)(5024004)(54906003)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6694;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bFP83wmE/U8YdHtxnbx4dWhze2QdUIWwq1E6SKkwnL+9ZFJGtbQdZA0Yo5Ub00mDQ4a960TL5oWdp6HCGLjF0DZfDYzt0dUw335DejXsDUInfZRa/ugRm1M+cemu9J5+qFdwn/krgyS1AxH1HM+nC1F2TedWN0mdgboBzsMTZ+xLCYymU6pgGOYnnkUphu/HWO1V/kVfPFwvb5WiGenFXdvInUFgGlTs/i2ahrFjYw+8HarVYUFnqf8DT3pKu+X+0FvAQDRX4Frt3PqDP3CHn4W2vIokAHXR7fw/sK3GB0Rfs2bb5O+5sZaxaAt0w1FD5FeLqT0dGeJjg2RIVkZ73AbFYTfifkvXdSTQdHvJwWstjS5UqguiFfZJETfsPB3wkMFNi4NwAb4v2AWm8puZxgRcPJl0/E1aMXNxJLPsr5s=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B95A2C569ED4C04EB343227BA0A1D812@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd440251-27bc-48fe-f4d1-08d731c3ecce
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 05:43:05.5815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CFDkdjSonOQarpQq1Bx5dcQ6/7dnV/hhuU+nlFo7wds/7WK9zS+e6zBfyndsYs6HwxqPr3EIwtYuERAAtESKeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6694
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sep 4, 2019, at 5:18 PM, Nick Desaulniers <ndesaulniers@google.com> wr=
ote:
>=20
> On Fri, Aug 30, 2019 at 4:15 PM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>> This adds an asm_inline macro which expands to "asm inline" [1] when gcc
>> is new enough (>=3D 9.1), and just asm for older gccs and other
>> compilers.
>>=20
>> Using asm inline("foo") instead of asm("foo") overrules gcc's
>> heuristic estimate of the size of the code represented by the asm()
>> statement, and makes gcc use the minimum possible size instead. That
>> can in turn affect gcc's inlining decisions.
>>=20
>> I wasn't sure whether to make this a function-like macro or not - this
>> way, it can be combined with volatile as
>>=20
>>  asm_inline volatile()
>>=20
>> but perhaps we'd prefer to spell that
>>=20
>>  asm_inline_volatile()
>>=20
>> anyway.
>>=20
>> [1] Technically, asm __inline, since both inline and __inline__
>> are macros that attach various attributes, making gcc barf if one
>> literally does "asm inline()". However, the third spelling __inline is
>> available for referring to the bare keyword.
>>=20
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> ---
>> include/linux/compiler-gcc.h   | 4 ++++
>> include/linux/compiler_types.h | 4 ++++
>> 2 files changed, 8 insertions(+)
>>=20
>> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
>> index d7ee4c6bad48..544b87b41b58 100644
>> --- a/include/linux/compiler-gcc.h
>> +++ b/include/linux/compiler-gcc.h
>> @@ -172,3 +172,7 @@
>> #endif
>>=20
>> #define __no_fgcse __attribute__((optimize("-fno-gcse")))
>> +
>> +#if GCC_VERSION >=3D 90100
>=20
> Is it too late to ask for a feature test macro? Maybe one already
> exists?  I was not able to find documentation or a bug on `asm
> inline`.  I'm quite curious how you even found or heard of this
> feature.  To the source we must go...

When I had some free time I wrote a detailed blog post about this issue:
https://nadav.amit.zone/linux/2018/10/10/newline.html

Which later Borislav took to gcc people:
https://lore.kernel.org/lkml/20181007091805.GA30687@zn.tnic/

