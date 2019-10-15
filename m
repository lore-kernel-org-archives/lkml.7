Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3C1ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A3520873
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=daktronics.com header.i=@daktronics.com header.b="br6Lr4Ah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732840AbfJOObl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 10:31:41 -0400
Received: from mail-eopbgr720052.outbound.protection.outlook.com ([40.107.72.52]:35376
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732599AbfJOObi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 10:31:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfXRkD7gM6qWzXjXKKcrr1B8O4QA/lvmHgsyGKfBI71wCGTvSIGyW4NsuCj6kkrYfk0+xKIUJrE3Brt7KkN8IJivJ0I0lzIjwTJMWvQ31xwCjmxOSgLYNfx+ylStr2KI3FKoFM0UDbVy3U1nzcV5CgtVvodfEhChQar48dS2wLSKseAxPgCz7J5YPf2xmV1eOYwcNBByVd+JY1qV6dmPx+1nCDkaTAUpWRub/Kyo8BXbMh/WsnCXmCa8oFMRUh6Tys1vUwE5bPQ3yTRohkODisAMq0nNCY+99LBW29J9wL+lVInSTcBNpYk+2ldjeO4crFIG+wU/XliwdoKaOshH4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sP0q4XouXJc9lVYM1pusLc3PQJ+bDeWaxAir6zEOMdk=;
 b=R80SsPNPlWyMjOCOiy9JUOM1IzEPiwGXvwWmNOh2hK/+eKHYXtFQ/UR08djzWEHgXTgGjDHGGMrqIGU01R1C30XbTq30Iy1RqT4CMa+kLqFXezVpz9BCARqjqlzCKwYdg6hA6OhefM64HRWTlqbVNZ8RZGYMly1h0n9wBhKjxLKzhLvDRJeOP+urGUJ7P8RcXOkUHw7CqmJfqbgA7T6XSEsmzEQyiWnUY++NLU/LKplxpUdAlix0NYt+K0tZ+2SgpaJToWEfI0o5Z/NeKEui8gRW8VBIIHskLN+K73Gn7LuH6ze39FT4Jni12YPod58pLCK3pwuB3S7+kyHBjzU2NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=daktronics.com; dmarc=pass action=none
 header.from=daktronics.com; dkim=pass header.d=daktronics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=daktronics.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sP0q4XouXJc9lVYM1pusLc3PQJ+bDeWaxAir6zEOMdk=;
 b=br6Lr4AhRzfxS6kVUaTt2yO9XJyvc8N5+4gzm1RJt82qKfytqimOi/I69av03cKmkEP0nn/Aygw03bg5WjqGVYDB5Le6hgfemAB8cXIqBxujntTYehPAqzGkxWexDpFc+qyY5Ul8Lz1nMcwy3Jm+5CrR9vLScxkLPzBaB4jx9fE=
Received: from SN6PR02MB4016.namprd02.prod.outlook.com (52.135.69.145) by
 SN6PR02MB5343.namprd02.prod.outlook.com (52.135.104.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Tue, 15 Oct 2019 14:31:35 +0000
Received: from SN6PR02MB4016.namprd02.prod.outlook.com
 ([fe80::ec31:ae9d:c354:319a]) by SN6PR02MB4016.namprd02.prod.outlook.com
 ([fe80::ec31:ae9d:c354:319a%5]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 14:31:35 +0000
From:   Matt Sickler <Matt.Sickler@daktronics.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "trivial@kernel.org" <trivial@kernel.org>
Subject: [PATCH] MAINTAINERS: Add myself as maintainer
Thread-Topic: [PATCH] MAINTAINERS: Add myself as maintainer
Thread-Index: AdWDZCk+mJVt8MIbSyGixWGVWbDdAg==
Date:   Tue, 15 Oct 2019 14:31:35 +0000
Message-ID: <SN6PR02MB401607858423D8BF3781A399EE930@SN6PR02MB4016.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Matt.Sickler@daktronics.com; 
x-originating-ip: [2620:9b:8000:6046:242b:c155:97bc:1f1f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ad0700f-dc9a-42a8-b6da-08d7517c61d8
x-ms-traffictypediagnostic: SN6PR02MB5343:
x-microsoft-antispam-prvs: <SN6PR02MB53437E4C9E040C0DABE5EDDCEE930@SN6PR02MB5343.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 01917B1794
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(39850400004)(376002)(396003)(136003)(199004)(189003)(76116006)(476003)(7736002)(305945005)(66446008)(66946007)(74316002)(71200400001)(71190400001)(6916009)(64756008)(66556008)(66476007)(8676002)(8936002)(81156014)(81166006)(86362001)(186003)(102836004)(486006)(2906002)(33656002)(52536014)(5660300002)(99286004)(53546011)(316002)(4744005)(7696005)(6116002)(2501003)(2351001)(6506007)(25786009)(9686003)(55016002)(46003)(4326008)(6436002)(5640700003)(478600001)(14454004)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5343;H:SN6PR02MB4016.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: daktronics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tFaJicNXFB/U2yQOjdTDNM0bUb5R0Lvz2SNZWyGMzSdbgtgzCAZt4kEiB7diwr1B1b5hFxQA+th+PQCnwuPCTcuCSZ5jJrrLf9MxZssTZFtIjkB/8XJawHZoruC3ClS0DCAtXTboullBxzB3OyHvmh6qdJedeu+hWp+gVtfXeZM9YZRm4/TiFu5n+7f1zDR3uocDstz7qnTfeUghLZwACTaltNd7D2P4wBJqy2BdcC3SpuHhZEiAhH2QCJWa/CP8J3vxWvxAHk4MDy76eacWT0oeWWF9v2vLa0tsqwlOMdjmJg6dSD4PP7BXDMdVdDA/kM0agqTYlen3Al6KIlVy8w88NlQh/8gQ5cCcL/armYC2AK5+xKIuas3/lQPKP0hkrECt1gD+Nmy25yPnF93R5lypUrt1dSiswKwTWXyd6YI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: daktronics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad0700f-dc9a-42a8-b6da-08d7517c61d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2019 14:31:35.3422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be88af81-0945-42aa-a3d2-b122777351a2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A5B+4z+IkcSf5eTKBqKK6i6jh0UePD+Gvt3UnmiWWiY/Bwsbn4ICNDcQGU/LpmPkJ8TBJFBYHnZNbvLpdbOPqxkQ68VgAm75md/CunUk1Xc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5343
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 1943c35f5c6068cea3cdfb33a48990eca5767c9b Mon Sep 17 00:00:00 2001
From: Matt Sickler <Matt.Sickler@daktronics.com>
Date: Tue, 15 Oct 2019 09:11:17 -0500
Subject: [PATCH] MAINTAINERS: Add myself as maintainer for the Daktronics
 Drivers

Signed-off-by: Matt Sickler <Matt.Sickler@daktronics.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a69e6db80c79..b2c084c2face 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4563,6 +4563,11 @@ L:	linux-input@vger.kernel.org
 S:	Supported
 F:	drivers/input/keyboard/dlink-dir685-touchkeys.c
=20
+DAKTRONICS KADOKA DRIVERS
+M:	Matt Sickler <matt.sickler@daktronics.com>
+S:	Supported
+F:	drivers/staging/kpc2000/
+
 DALLAS/MAXIM DS1685-FAMILY REAL TIME CLOCK
 M:	Joshua Kinard <kumba@gentoo.org>
 S:	Maintained
--=20
2.11.0

