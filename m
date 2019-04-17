Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8129C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 04:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7307204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 04:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="hgtlt/OI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfDQEww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 00:52:52 -0400
Received: from mail-eopbgr820043.outbound.protection.outlook.com ([40.107.82.43]:43522
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725767AbfDQEwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 00:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XLGOZoM3s6+j2c8/yRAow+92BVev5pANSVRls/GlKc=;
 b=hgtlt/OIZ/bgjvC7bg8zLQiuH2ign4g0m7VTtRB6UnVzgE1aYxuTb8a2rxemZQ/7lpNrFFRBlq338t0ttBVTUain1aprfFwwzPoCqnsjWnSK2PWFul8c8cxKAzguwuzsZTFzYj4mHyemSgYD/T2iq3rnEJYXJ02u5ixwdA4D0yI=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4853.namprd05.prod.outlook.com (52.135.235.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.3; Wed, 17 Apr 2019 04:52:40 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::4140:b8f2:8e3:f5fd]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::4140:b8f2:8e3:f5fd%4]) with mapi id 15.20.1813.011; Wed, 17 Apr 2019
 04:52:39 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] x86/tlb: Revert: Align TLB invalidation info
Thread-Topic: [PATCH] x86/tlb: Revert: Align TLB invalidation info
Thread-Index: AQHU9CrwOuZJw5VINkqY1zaggi7EUKY/D+qAgAAMIoCAAK5gAA==
Date:   Wed, 17 Apr 2019 04:52:39 +0000
Message-ID: <265A9BFA-8111-4ED8-8B49-0A15BA4EF9BA@vmware.com>
References: <20190416080335.GM7905@worktop.programming.kicks-ass.net>
 <CAHk-=whgXyXCy9vHY2hKJ9Pa8PnwdwKo9eOQ3jDbCs_FkdDvkQ@mail.gmail.com>
 <20190416182831.GU4038@hirez.programming.kicks-ass.net>
In-Reply-To: <20190416182831.GU4038@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23b33a0a-169d-464c-816a-08d6c2f084fe
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR05MB4853;
x-ms-traffictypediagnostic: BYAPR05MB4853:
x-microsoft-antispam-prvs: <BYAPR05MB4853A957FE07771470685790D0250@BYAPR05MB4853.namprd05.prod.outlook.com>
x-forefront-prvs: 0010D93EFE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(376002)(366004)(396003)(199004)(189003)(6436002)(4744005)(6506007)(36756003)(76176011)(68736007)(2906002)(6916009)(97736004)(186003)(71190400001)(54906003)(71200400001)(33656002)(83716004)(5660300002)(53546011)(256004)(106356001)(105586002)(102836004)(53936002)(26005)(99286004)(4326008)(6486002)(8676002)(305945005)(316002)(81166006)(81156014)(6246003)(229853002)(66066001)(476003)(14454004)(7736002)(6116002)(11346002)(446003)(86362001)(82746002)(6512007)(486006)(2616005)(8936002)(3846002)(25786009)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4853;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uSS4CZJCyMXz1Kaqbn02fayLRo4NthP6npcutjBN76N/zvDIb7BLB2AbDJb0583hDZEDQvkNMvVgdXHZc6viD0ehFJ1AGI/qtPp1Ne8Wtqrx7bGMhvv/j5UMFL4DI4fZIMkxiLyU5M7q1VUxMpsQXExAnS6TNmR1UnYUXDNW1l4u09xHEeS3EZEX89IM/001l76Xx/ZbYe5urStw+1ZLJKIvQxpB4eq++vjP8fkUktaUpStPRq3WIQofKrXg6WI3Fr1pVgYY0MTI2Ilrf0JguoyBgR05hQ6c/co/ILKNo2eSzcftgexuqn8JgVHPVfapKOxzJ5DgKXFhiFMbiACiVpKD1tQWXMv9x4fkg2P5a6JcNURVu1+oauwPkrmedwtRNIQQQd2MLGuo42+7LlN6k/rPyw413VjXw2ZNsWupDe8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5C9171472B078D4988F576A338752C01@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b33a0a-169d-464c-816a-08d6c2f084fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2019 04:52:39.6423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4853
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Apr 16, 2019, at 11:28 AM, Peter Zijlstra <peterz@infradead.org> wrote=
:
>=20
> On Tue, Apr 16, 2019 at 10:45:05AM -0700, Linus Torvalds wrote:
>> So very much Ack on that patch, but maybe we could do a bit more cleanup=
 here?
>=20
> Yeah, Nadav was going to try and clean that up. But I figured we should
> get this revert in and backported while it's hot :-)

I will get to it hopefully next week. I need to do some benchmarking to see
the impact of getting it off the stack, although usually the IPI itself
dominates the TLB shootdown performance overhead.=
