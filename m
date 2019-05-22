Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C561C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 11:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56A420868
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 11:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=elektrobit.onmicrosoft.com header.i=@elektrobit.onmicrosoft.com header.b="Xy41ts+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbfEVLis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 07:38:48 -0400
Received: from smtpgwcipde.automotive.elektrobit.com ([213.95.163.141]:44053
        "EHLO smtpgwcipde.elektrobit.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727464AbfEVLir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 07:38:47 -0400
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 May 2019 07:38:45 EDT
Received: from denue6es002.localdomain (denue6es002.automotive.elektrobit.com [213.95.163.135])
        by smtpgwcipde.elektrobit.com  with ESMTP id x4MBNeGF007207-x4MBNeGH007207
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=OK);
        Wed, 22 May 2019 13:23:40 +0200
Received: from denue6es002.securemail.local (localhost [127.0.0.1])
        by denue6es002.localdomain (Postfix) with SMTP id 5C1C419290;
        Wed, 22 May 2019 13:23:40 +0200 (CEST)
Received: from denue6es011.ebgroup.elektrobit.com (denue6es011.ebgroup.elektrobit.com [10.243.160.101])
        by denue6es002.localdomain (Postfix) with ESMTPS;
        Wed, 22 May 2019 13:23:40 +0200 (CEST)
Received: from denue6es011.ebgroup.elektrobit.com (10.243.160.101) by
 denue6es011.ebgroup.elektrobit.com (10.243.160.101) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 22 May 2019 13:23:39 +0200
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.55) by
 denue6es011.ebgroup.elektrobit.com (10.243.160.101) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1713.5 via Frontend Transport; Wed, 22 May 2019 13:23:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=elektrobit.onmicrosoft.com; s=selector1-elektrobit-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3qUcyHfwJMHZo98lJ+qRQwV7diyCI8RPus5xuBV6H4=;
 b=Xy41ts+xGuDJZ1OznwsSgc49wEnkvDnplPfmdB1nJLTD+jVvw36g2wAHXC61qGFUNOxnN2m3ZU7YZS/3SjK781zP4da62WDTc17WCPamyghHLXBraxKDs7kUOYfSlMHr2Wtydgv7PYdbV5ER1DkTjm2zJV2bdNPIfOjI6yyLeMc=
Received: from DM6PR08MB5195.namprd08.prod.outlook.com (20.176.118.25) by
 DM6PR08MB4810.namprd08.prod.outlook.com (20.176.115.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Wed, 22 May 2019 11:23:37 +0000
Received: from DM6PR08MB5195.namprd08.prod.outlook.com
 ([fe80::7533:416f:4217:461a]) by DM6PR08MB5195.namprd08.prod.outlook.com
 ([fe80::7533:416f:4217:461a%6]) with mapi id 15.20.1900.020; Wed, 22 May 2019
 11:23:37 +0000
From:   "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>,
        "Jordan, Tobias" <Tobias.Jordan@elektrobit.com>
Subject: [PATCH] mm: mlockall error for flag MCL_ONFAULT
Thread-Topic: [PATCH] mm: mlockall error for flag MCL_ONFAULT
Thread-Index: AQHVEJDM40/Q2Jusd0KD0xzATvP7RQ==
Date:   Wed, 22 May 2019 11:23:37 +0000
Message-ID: <20190522112329.GA25483@er01809n.ebgroup.elektrobit.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0051.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:8e::28) To DM6PR08MB5195.namprd08.prod.outlook.com
 (2603:10b6:5:42::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Stefan.Potyra@elektrobit.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [213.95.148.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d7cce5c-e1b1-4cf2-f92b-08d6dea7eee1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:DM6PR08MB4810;
x-ms-traffictypediagnostic: DM6PR08MB4810:
x-microsoft-antispam-prvs: <DM6PR08MB4810B0E1126B800CE48C2E2280000@DM6PR08MB4810.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(366004)(39850400004)(376002)(189003)(199004)(68736007)(102836004)(14444005)(256004)(53936002)(71190400001)(71200400001)(6486002)(316002)(25786009)(26005)(186003)(73956011)(6512007)(107886003)(6436002)(305945005)(4326008)(66476007)(110136005)(7736002)(54906003)(5660300002)(386003)(6506007)(64756008)(86362001)(66556008)(14454004)(66946007)(99286004)(486006)(2906002)(8676002)(33656002)(81166006)(81156014)(72206003)(6116002)(3846002)(478600001)(476003)(66066001)(66446008)(52116002)(2501003)(8936002)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR08MB4810;H:DM6PR08MB5195.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: elektrobit.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bjds9HZxPzsJToVrpCeSufyeGWPVwKvU+l3rMrKASBzZCLTtazVpr6486+849D9wxuC7D0fxhEsIJMWk7Mbln+mWcqA7QnazfBicKysNWv9DxiVW/kMJDy/msHgWQdTyvhqP3ZU2oziBlL63ThwR+yVRisrHMU3yKG7uWZ8Jj42vosCevQ35ok3MQsYu6kNAg8Nn+xNpXXGhLdKM2YaUjF0tv0lDMhqYgrtdG3Ya8hYttdZvkIiQyc6GGhU9omn7k5CPPrA2NFHjf5At2QRG9DS7FPtk/Ad20J7F86R/FxxH7nhzHwqIn6+6QsF0Ge7jasnplkW5a5Oz3sMBc9va0n+Z3pZaaYpE9JWbfcvVmUMZSlWOnrFzAb6p8s1FIiTwOW3ra/hzuFTwLlEfLsWREgR/eWX+Ju0ZxELZGQb8ZVQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <81DE7C41012F734098C84CCBC364F602@namprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7cce5c-e1b1-4cf2-f92b-08d6dea7eee1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 11:23:37.4112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e764c36b-012e-4216-910d-8fd16283182d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4810
X-OriginatorOrg: elektrobit.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If mlockall() is called with only MCL_ONFAULT as flag,
it removes any previously applied lockings and does
nothing else.

This behavior is counter-intuitive and doesn't match the
Linux man page.

Consequently, return the error EINVAL, if only MCL_ONFAULT
is passed. That way, applications will at least detect that
they are calling mlockall() incorrectly.

Fixes: b0f205c2a308 ("mm: mlock: add mlock flags to enable VM_LOCKONFAULT u=
sage")
Signed-off-by: Stefan Potyra <Stefan.Potyra@elektrobit.com>
---
Sparse shows a warning for mlock.c, but it is not related to
this patch.

 mm/mlock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index e492a155c51a..03f39cbdd4c4 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -797,7 +797,8 @@ SYSCALL_DEFINE1(mlockall, int, flags)
 	unsigned long lock_limit;
 	int ret;
=20
-	if (!flags || (flags & ~(MCL_CURRENT | MCL_FUTURE | MCL_ONFAULT)))
+	if (!flags || (flags & ~(MCL_CURRENT | MCL_FUTURE | MCL_ONFAULT)) ||
+	    flags =3D=3D MCL_ONFAULT)
 		return -EINVAL;
=20
 	if (!can_do_mlock())
--=20
2.20.1

