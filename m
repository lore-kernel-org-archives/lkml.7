Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC92C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E307205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="o39wiOay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731385AbfCZJ6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:58:46 -0400
Received: from mail-eopbgr20104.outbound.protection.outlook.com ([40.107.2.104]:27879
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726175AbfCZJ6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fy9TkPagS61qZfaMiPABu3VFDAZJaaLY5FVG5bNN0Uo=;
 b=o39wiOayQAYHDmhhAnJn5Z0QmzHiOYQSYrsxd5X8YeGLWRqo5xsDL+Ugmjhcrr7hWI28bynTBHTd8TvYZpCyqTzpQBuuEP03AmJjhORyIY+FADFd0Ktpd9bmf9LCkvxfgkP0eG7cv9pK1jo+aO7ZaddrnoOJi7dOfpkp3zcydhY=
Received: from HE1PR0701MB2652.eurprd07.prod.outlook.com (10.168.188.7) by
 HE1PR0701MB2652.eurprd07.prod.outlook.com (10.168.188.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.14; Tue, 26 Mar 2019 09:58:40 +0000
Received: from HE1PR0701MB2652.eurprd07.prod.outlook.com
 ([fe80::1449:d020:a36f:a8a3]) by HE1PR0701MB2652.eurprd07.prod.outlook.com
 ([fe80::1449:d020:a36f:a8a3%6]) with mapi id 15.20.1750.014; Tue, 26 Mar 2019
 09:58:40 +0000
From:   "Wiebe, Wladislav (Nokia - DE/Ulm)" <wladislav.wiebe@nokia.com>
To:     "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "michal.lkml@markovi.net" <michal.lkml@markovi.net>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] modpost: make KBUILD_MODPOST_WARN also configurable for
 external modules
Thread-Topic: [PATCH] modpost: make KBUILD_MODPOST_WARN also configurable for
 external modules
Thread-Index: AdTjuez0lIeTgqS2RiGNuzvA7YdwJA==
Date:   Tue, 26 Mar 2019 09:58:39 +0000
Message-ID: <HE1PR0701MB2652FC3F5D8E46EA93AF033AFA5F0@HE1PR0701MB2652.eurprd07.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wladislav.wiebe@nokia.com; 
x-originating-ip: [131.228.32.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8af43697-934a-4254-b7c2-08d6b1d19f78
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:HE1PR0701MB2652;
x-ms-traffictypediagnostic: HE1PR0701MB2652:
x-microsoft-antispam-prvs: <HE1PR0701MB26522590CA1A29B9C4ABA619FA5F0@HE1PR0701MB2652.eurprd07.prod.outlook.com>
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(376002)(396003)(189003)(199004)(486006)(6436002)(186003)(6116002)(68736007)(102836004)(476003)(6506007)(2906002)(3846002)(26005)(105586002)(55016002)(99286004)(7696005)(2501003)(478600001)(9686003)(14444005)(33656002)(110136005)(316002)(106356001)(4326008)(7736002)(305945005)(14454004)(74316002)(53936002)(97736004)(81156014)(8676002)(2201001)(86362001)(81166006)(8936002)(52536014)(5660300002)(66066001)(25786009)(71200400001)(71190400001)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0701MB2652;H:HE1PR0701MB2652.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: irC+0PzOQ0yqRKHFR3qIva70pn5w+c82Y6EWNZfc78HFzGJGEkzU6FpeabuKRzpUBvMJz5BJNK7QDF8PIxS2nW+XwyhcDiNZsMFSfyDLYkIV3RKpfSFGEoC5opWzBLmL4jjngMEOlMlR1kjukaSn+03FLiIje/HW4+Iz+wVBy3d6rTgFJulfYs0s8fcDh/ErephTmCVktIBq2vsUpdjKpDl/ZcF2SR/2wtEJkwHSXwgoKQwSXZY6Kx1L3DULIQ8OwIGZysB9ZNa3hvDssthcDZ2OTdIaCcecX1cQbXPMM+XOI0zHevcsLeSyNaXqS2V89NlmtXRDo6LM6o9wR4vONNo9n6k+ccYI3FqyvPKIzZvG6D2djPbFjuszubV/cTFlQW615WY+X13NaD36vJ1HyJoqsw+0JXReovx6KiqxQSc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af43697-934a-4254-b7c2-08d6b1d19f78
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 09:58:39.9922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2652
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ea837f1c0503 ("kbuild: make modpost processing configurable")
was intended to give KBUILD_MODPOST_WARN flexibility to be configurable.
Right now KBUILD_MODPOST_WARN gets just ignored when KBUILD_EXTMOD is
set which happens per default when building modules out of the tree.

This change gives the opportunity to define module build behaving also
in case of out of tree builds and default will become exit on error.
Errors which can be detected by the build should be trapped out of the box
there, unless somebody wants to notice broken stuff later at runtime.

Signed-off-by: Wladislav Wiebe <wladislav.wiebe@nokia.com>
---
 scripts/Makefile.modpost | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 6b7f354f189a..fec6ec2ffa47 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -78,7 +78,7 @@ modpost =3D scripts/mod/modpost                    \
  $(if $(KBUILD_EXTRA_SYMBOLS), $(patsubst %, -e %,$(KBUILD_EXTRA_SYMBOLS))=
) \
  $(if $(KBUILD_EXTMOD),-o $(modulesymfile))      \
  $(if $(CONFIG_SECTION_MISMATCH_WARN_ONLY),,-E)  \
- $(if $(KBUILD_EXTMOD)$(KBUILD_MODPOST_WARN),-w)
+ $(if $(KBUILD_MODPOST_WARN),-w)
=20
 MODPOST_OPT=3D$(subst -i,-n,$(filter -i,$(MAKEFLAGS)))
=20
--=20
2.19.2
