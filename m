Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80ACDC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5053A20578
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="TweL8QRV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbfH2S0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:26:12 -0400
Received: from mail-eopbgr750082.outbound.protection.outlook.com ([40.107.75.82]:14597
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729851AbfH2S0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:26:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdXWoYD5lIlG8Ck4EXYCt16oLjnEhqVcFOM1GwXaHJiFxg5rRqUGr43gzh4Cs6QCmausyM1/RcDJKOoIvyJx6Z1Jc4wtB43snjEvchfe+cRd8+AUaTfoEP9nIBhjJ+2mu/yGnzPL0NaqrnEmjilU5/ZeNlrNfmbcefwkieFF9zCuMRca64kpIYqMsCUIKuG5V7vLMvgHNAq7+QpQK1jXOo2Ja5VKxsBUG+O/BS1omOObQ59A2P+UmhR9YZr3aMfbqbDY5wITr+hNE6k6rEh/iiD8AQ6ZMheNcuXgCnLGUqXSuXmVmW3OSl5KzIdRlmsFf7T9DIpLo3qk+YaNhoJaSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Elrp7tMe2s1X81AeQz29M0s1ma9HJ+JlK12Fr9GFqkw=;
 b=SGXJx4SPR8Qa/CNEeC54GCsMhEaMopWoFS6Rs9h7vk19j26m9aKxTMvySvJ59mmChNkVTI8lRbPWAMyOXsw404W8sRqVvN+lnmT8TPtc5ajXNn8wuNMRlUFA2iMh8TVh1IaItLzqXVyUjGMjPLORzItJWtoLI0Jhk9JK4rbjzjzWZ8U8cvyUB4QGcTSI6UlMJWbO1K/+JnsqzY/Aq3ad2YNG6QUKRwpCuoRx+E5dB5ZTu0ddnS9sh/yIKRz4hgIp9fOU1tKTvL9g4DZb1C9q621laIco9c1Jtd6lAV4KW8gZI48ntLM+2mHKnx78PzlrdxUfOH27U1NJJ7DRWld3Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Elrp7tMe2s1X81AeQz29M0s1ma9HJ+JlK12Fr9GFqkw=;
 b=TweL8QRVAwoN7n/ViFo5zmwU1vKWwwT9AuiArbO2Hds4VdwpvLJrDSiE35rJdjdWldn5RimyIz0/klp0lin6rQKo3WLyuil9QAwH0y+HDKINPlSQmV5SD6egIjXc6KKo/N0FQxhS0LXqtJj1ecOyUU0TK0+0EeXbBD8YaAx1htA=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4357.namprd05.prod.outlook.com (20.176.250.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.5; Thu, 29 Aug 2019 18:26:07 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::5163:1b6f:2d03:303d]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::5163:1b6f:2d03:303d%3]) with mapi id 15.20.2220.013; Thu, 29 Aug 2019
 18:26:07 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
CC:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [RFC PATCH 0/5] make use of gcc 9's "asm inline()"
Thread-Topic: [RFC PATCH 0/5] make use of gcc 9's "asm inline()"
Thread-Index: AQHVXkRaBqsQuToWZEu27cwbsZAFCqcSY/cAgAAK3ACAAAMVAA==
Date:   Thu, 29 Aug 2019 18:26:07 +0000
Message-ID: <6C70DE15-0F83-4CBB-B25B-EFF50BC34DD3@vmware.com>
References: <20190829083233.24162-1-linux@rasmusvillemoes.dk>
 <CAKwvOdnUXiX_cAUTSpqgYJTUERoRF-=3LfaydvwBWC6HtzfEdg@mail.gmail.com>
 <CAHk-=wgZ7Ge8QUkkSZLCfJBsHRsre65DkfTyZ2Kt5VPwa=dkuA@mail.gmail.com>
In-Reply-To: <CAHk-=wgZ7Ge8QUkkSZLCfJBsHRsre65DkfTyZ2Kt5VPwa=dkuA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37749bd7-c923-43b0-d438-08d72cae5bd0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB4357;
x-ms-traffictypediagnostic: BYAPR05MB4357:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR05MB435711A155EB57350497CFE7D0A20@BYAPR05MB4357.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(199004)(189003)(11346002)(486006)(6436002)(476003)(446003)(256004)(36756003)(71190400001)(71200400001)(478600001)(26005)(102836004)(6506007)(53546011)(6916009)(186003)(14454004)(305945005)(3846002)(6116002)(7736002)(8936002)(76176011)(2616005)(7416002)(966005)(99286004)(54906003)(316002)(229853002)(86362001)(6486002)(76116006)(8676002)(81156014)(81166006)(33656002)(66946007)(66446008)(64756008)(66556008)(25786009)(4326008)(53936002)(6246003)(6306002)(6512007)(5660300002)(66066001)(66476007)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4357;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uSCqbOGjA/Ud0PS3bnOqm/0o4MB9qDhnybCSr1Ojw6m1fzPGytR4mlo8+lQ9c9bvElsNMfc0nmA0vytwK0FlvSaIvdPwrNqI70izMfpudAQHDvP8CFFfuCKcRwGYHu/OT1eZL0/nTVwQAHZbok22/eBlolKciOf3l1wQxgKOath5AA08HW6c0GtVwKh8Ae9yiii9D9MCoRxOt1iP39kg28z1zHuQuumnb83XGJusMWk7DjDnB/NPw1iKvu69/x4yPjRQVs8A77DaHBtjvdVLEQ5hf6wz30NAsVzJZR9NALODGCCr0b8msUVDW1iMYj1E8wbpFek0ZBcPOoIsr9IGam0t/iPwgl4qmJtBzgPbreegvgjpKwbWOKr0zC7Zn6uI7XoCRrRXM0HNKGhfXewrvA+Kiy+NJCoGYJ9npLpb9Lc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <25C9E7220D8711439952559944FB54E9@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37749bd7-c923-43b0-d438-08d72cae5bd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 18:26:07.0549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GQuRXP3mz4ftQS4b1kfc/0/ou3S4IgqHTgiRZ769+dnJk5bLVig4YM7Xx01BOIMLAmR17iSYjRZ2lZcYv1yC3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4357
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Aug 29, 2019, at 11:15 AM, Linus Torvalds <torvalds@linux-foundation.o=
rg> wrote:
>=20
> On Thu, Aug 29, 2019 at 10:36 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
>> I'm curious what "the size of the asm" means, and how it differs
>> precisely from "how many instructions GCC thinks it is."  I would
>> think those are one and the same?  Or maybe "the size of the asm"
>> means the size in bytes when assembled to machine code, as opposed to
>> the count of assembly instructions?
>=20
> The problem is that we do different sections in the inline asm, and
> the instruction counts are completely bogus as a result.
>=20
> The actual instruction in the code stream may be just a single
> instruction. But the out-of-line sections can be multiple instructions
> and/or a data section that contains exception information.
>=20
> So we want the asm inlined, because the _inline_ part (and the hot
> instruction) is small, even though the asm technically maybe generates
> many more bytes of additional data.
>=20
> The worst offenders for this tend to be
>=20
> - various exception tables for user accesses etc
>=20
> - "alternatives" where we list two or more different asm alternatives
> and then pick the right one at boot time depending on CPU ID flags
>=20
> - "BUG_ON()" instructions where there's a "ud2" instruction and
> various data annotations going with it
>=20
> so gcc may be "technically correct" that the inline asm statement
> contains ten instructions or more, but the actual instruction _code_
> footprint in the asm is likely just a single instruction or two.
>=20
> The statement counting is also completely off by the fact that some of
> the "statements" are assembler directives (ie the
> ".pushsection"/".popsection" lines etc). So some of it is that the
> instruction counting is off, but the largest part is that it's just
> not relevant to the code footprint in that function.
>=20
> Un-inlining a function because it contains a single inline asm
> instruction is not productive. Yes, it might result in a smaller
> binary over-all (because all those other non-code sections do take up
> some space), but it actually results in a bigger code footprint.

For the record, here is my failing attempt to address the issue without GCC
support:

https://lore.kernel.org/lkml/20181003213100.189959-9-namit@vmware.com/T/

