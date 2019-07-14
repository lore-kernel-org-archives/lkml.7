Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD28C742D2
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 17:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08DA205F4
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 17:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="wmLdsAkZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbfGNRVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 13:21:24 -0400
Received: from mail-eopbgr680084.outbound.protection.outlook.com ([40.107.68.84]:36516
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728297AbfGNRVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 13:21:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRGeO15FcxuEoJZYUApq9OLjqdh+sIHkvd4AkDAHdWbd8ch8Vvy6NtObSg7THiZfbGWkD6WWVSlAmiY+4qITt8VQdd1LrSq70rBW3Sk9QxgKLcB3WiO4BZJjzKx8J5Ex3LvVx7fvulJJ/ONZ9Bc2Azuo7UKzso5Y9BM16D3bbRvoH5kH+hpfo4oapPE4fTj7jGXE5EIMIAGSxPt55l1xRwQXT/t3g2EgzfAY8Ft7y9uqandtAeu2AoWI66JXKhaePvjyn6+1imHv5Q8kCU76tZ0q/7BzzduWq54obNxk9q7ipXP/7fFH1yrBa5B1Gr/v33KdIN/upkhTvLxRsRsz1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwaVWg1GM6HK4HTzHPzW+lD0NEQTf+/yOwf9h870GfA=;
 b=O10LS/RmDhSrmb166X4So5k3bd9dEq0q+5f0vq4P8zgflcIbVQkcAstw9c5g0A+zdZ+FTPJuk8t54qPzoAmufm55dz+FW9mByXw5q/hug5rZQc5FuSKdGPL/eMAHqgxwqYikdAhUb1424yxgBxXP65zgEz+zGpMvBkQo6GodSQH9Y0czOjp3/Cy0XdAK8cOp4zhxiMgewyRv6+WYE7rKA0G9bus4a/LeGOUkTR6DsIyjBSi733bYuQOIeKG5994xYdEwX5WiPqR5D2DUyKaC6a/Bru0nximTHqA/sb9Xk7SkO608jN++FYX0TXVZq7+99Dp5rvhlJLxf0St/BlFtyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=vmware.com;dmarc=pass action=none
 header.from=vmware.com;dkim=pass header.d=vmware.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwaVWg1GM6HK4HTzHPzW+lD0NEQTf+/yOwf9h870GfA=;
 b=wmLdsAkZ506JsY5E0bPNSQl+k2nFEcQby/7MGvVMEDZdqh658c7pfyXiP2cKu+L+Wh89TKcHi8JIuoxz1HCcYlZydE06fMLmcam66qfGl/kMRUL61ZELjoaGxxLZVW+N+2M+4q4uBJA2dB5UZT9pDFrI8RvBeGGccvsnaOfDrdQ=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4631.namprd05.prod.outlook.com (52.135.233.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.8; Sun, 14 Jul 2019 17:21:20 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58%7]) with mapi id 15.20.2073.012; Sun, 14 Jul 2019
 17:21:19 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH] x86/apic: Initialize TPR to block interrupts 16-31
Thread-Topic: [PATCH] x86/apic: Initialize TPR to block interrupts 16-31
Thread-Index: AQHVOliSQEatmYzQkESWBh33bdcvFqbKXGiA
Date:   Sun, 14 Jul 2019 17:21:19 +0000
Message-ID: <D7C365E9-0DAD-46B9-95C9-B3475879F813@vmware.com>
References: <dc04a9f8b234d7b0956a8d2560b8945bcd9c4bf7.1563117760.git.luto@kernel.org>
In-Reply-To: <dc04a9f8b234d7b0956a8d2560b8945bcd9c4bf7.1563117760.git.luto@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [2601:647:4580:b719:3413:f6ce:116f:839c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47ae56fe-bfce-4a25-e0d2-08d7087fafcc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB4631;
x-ms-traffictypediagnostic: BYAPR05MB4631:
x-microsoft-antispam-prvs: <BYAPR05MB4631CDFD5880F615ACCE4C63D0CC0@BYAPR05MB4631.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0098BA6C6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(189003)(199004)(71190400001)(71200400001)(46003)(66556008)(66946007)(76116006)(76176011)(66446008)(64756008)(186003)(478600001)(486006)(229853002)(305945005)(36756003)(66476007)(7736002)(53546011)(102836004)(6116002)(14454004)(6246003)(54906003)(4326008)(8936002)(11346002)(53936002)(81156014)(14444005)(81166006)(6436002)(6486002)(86362001)(2616005)(476003)(6506007)(5660300002)(2906002)(33656002)(446003)(68736007)(316002)(6916009)(256004)(99286004)(8676002)(25786009)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4631;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xKodSpgmzEMhjgoA7OulD7yJewHhd8ASa85zjhJhk2hag2A59ppVoo4znxdLR99tZKPCrGSe9HLNh7+1MNM1UpoSN8mdC+1qS464YvB+qxYD55Ok9WzY0tifypFWcKYh0LJtmqo1SQ0M6x9ClkTwnCEc8qALUxiftTKwGjQccsGn0UQoY6mp+PpcOqCaMbkVLqq1Z82ybRC0CQDfiSTAQ/c9+0MugFpGY7uZNRYkUW/pJDbAN/UruY5Kdzx7u1xp04DlU8pIfZeg7EifW4WS4ETFvrzc2AGpjwLkS2aT2g6hnjmTIWTGkx4Szzztqoaz/dxYbHa4BdvaLL27/RXGuumV81wTTkW2/mrvIJYIVuTtb5oify7RYUySXohXxHu/h4qzypzztNwTKzuhMboVA9QPCr1CgLtmzdxtBa64KoQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E0460F700268A2409E411A9F98948096@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ae56fe-bfce-4a25-e0d2-08d7087fafcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2019 17:21:19.8123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4631
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jul 14, 2019, at 8:23 AM, Andy Lutomirski <luto@kernel.org> wrote:
>=20
> The APIC, per spec, is fundamentally confused and thinks that
> interrupt vectors 16-31 are valid.  This makes no sense -- the CPU
> reserves vectors 0-31 for exceptions (faults, traps, etc).
> Obviously, no device should actually produce an interrupt with
> vector 16-31, but we can improve robustness by setting the APIC TPR
> class to 1, which will prevent delivery of an interrupt with a
> vector below 32.
>=20
> Note: this is *not* intended as a security measure against attackers
> who control malicious hardware.  Any PCI or similar hardware that
> can be controlled by an attacker MUST be behind a functional IOMMU
> that remaps interrupts.  The purpose of this patch is to reduce the
> chance that a certain class of device malfunctions crashes the
> kernel in hard-to-debug ways.
>=20
> Cc: Nadav Amit <namit@vmware.com>
> Cc: Stephane Eranian <eranian@google.com>
> Cc: Feng Tang <feng.tang@intel.com>
> Suggested-by: Andrew Cooper <andrew.cooper3@citrix.com>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
> arch/x86/kernel/apic/apic.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index 177aa8ef2afa..ff31322f8839 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -1531,11 +1531,14 @@ static void setup_local_APIC(void)
> #endif
>=20
> 	/*
> -	 * Set Task Priority to 'accept all'. We never change this
> -	 * later on.
> +	 * Set Task Priority to 'accept all except vectors 0-31'.  An APIC
> +	 * vector in the 16-31 range could be delivered if TPR =3D=3D 0, but we
> +	 * would think it's an exception and terrible things will happen.  We
> +	 * never change this later on.
> 	 */
> 	value =3D apic_read(APIC_TASKPRI);
> 	value &=3D ~APIC_TPRI_MASK;
> +	value |=3D 0x10;
> 	apic_write(APIC_TASKPRI, value);
>=20
> 	apic_pending_intr_clear();

It looks fine, and indeed it seems that writes to APIC_TASKPRI and CR8 are
not overwriting this value.

Yet, the fact that if someone overwrites with zero (or does not restore) th=
e
TPR will not produce any warning is not that great. Not that I know what th=
e
right course of action is (adding checks in write_cr8()? but then what abou=
t
if APIC_TASKPRI is not restored after some APIC reset?)

