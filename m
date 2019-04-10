Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF1AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BACDA2077C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="arrJ0gtn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbfDJJXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:23:20 -0400
Received: from mail-eopbgr40096.outbound.protection.outlook.com ([40.107.4.96]:23810
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729367AbfDJJXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 05:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrs3Ge3ptc84V0fG1G9YEJl4Ar5Wu9P26wXtRaXgbjo=;
 b=arrJ0gtnO/qBqfEX1huI1Qp8TAKv0q1X5zAsU/tWl0cR9IooqhkmgTqiD54i41eWcXH3DQksROKSjLPGvuIL/q7n9QaD9aCfw3EQiRnZrYg3s8E9FqBLsE7LyHiw69lRLyEdj/QqVSGMSWz/LPfO8+eFXVGp1/EY/lG7Ptye8Ng=
Received: from HE1PR0701MB2652.eurprd07.prod.outlook.com (10.168.188.7) by
 HE1PR0701MB2604.eurprd07.prod.outlook.com (10.168.187.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.11; Wed, 10 Apr 2019 09:23:15 +0000
Received: from HE1PR0701MB2652.eurprd07.prod.outlook.com
 ([fe80::1449:d020:a36f:a8a3]) by HE1PR0701MB2652.eurprd07.prod.outlook.com
 ([fe80::1449:d020:a36f:a8a3%6]) with mapi id 15.20.1792.009; Wed, 10 Apr 2019
 09:23:15 +0000
From:   "Wiebe, Wladislav (Nokia - DE/Ulm)" <wladislav.wiebe@nokia.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "michal.lkml@markovi.net" <michal.lkml@markovi.net>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        Jonas Gorski <jonas.gorski@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] modpost: make KBUILD_MODPOST_WARN also configurable for
Thread-Topic: [PATCH v2] modpost: make KBUILD_MODPOST_WARN also configurable
 for
Thread-Index: AdTvfB/gjVQwJ0l9SOGmgdISIvt+nw==
Date:   Wed, 10 Apr 2019 09:23:15 +0000
Message-ID: <HE1PR0701MB2652D08633C7322BDEABDACBFA2E0@HE1PR0701MB2652.eurprd07.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wladislav.wiebe@nokia.com; 
x-originating-ip: [131.228.32.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e64ee84c-a58a-482c-d1b0-08d6bd962929
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:HE1PR0701MB2604;
x-ms-traffictypediagnostic: HE1PR0701MB2604:
x-microsoft-antispam-prvs: <HE1PR0701MB26046972B9DD4E6F28138C33FA2E0@HE1PR0701MB2604.eurprd07.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(136003)(39860400002)(189003)(199004)(105586002)(86362001)(478600001)(14454004)(9686003)(106356001)(2501003)(71190400001)(74316002)(256004)(53936002)(55016002)(2201001)(14444005)(71200400001)(3846002)(5660300002)(52536014)(6116002)(2906002)(25786009)(4326008)(305945005)(7736002)(7696005)(8676002)(81156014)(33656002)(110136005)(99286004)(102836004)(97736004)(6506007)(316002)(26005)(68736007)(476003)(486006)(186003)(66066001)(6436002)(8936002)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0701MB2604;H:HE1PR0701MB2652.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mrAt/pHfYqndRPjeimgKZh4eZj4FThV8rwbjulBnvwF1NhnJNzPevMGayff6c2nCcc+hB62W5MalVyTRjldPq3+I7/aIq5ZqR5lGmwFxHTDOURUk6HAY9OE3nl7vQGCCgm12ynTolm7VnGYW6SJ49LAewwZdXV4YkP62FK27RmyqE1pA5FIVdN2WdrN3/4EomDB007enfEBwN9ubj1j/i8q73wQst8or/dlcJ0eEZfy/XrsKCMYmmcbTtSrRPyDcQ2nQ4srcz5kz9R1S7WLgGSfyl53Ja/tOuogZKKXPFO5h3W23a5msPW2qbN8z5wCvZY+3Webwb92L1VTzjZOfaIa3JDL2Woc+DCNe5t656PCX7bbgo5rghqAyhT9HYAsQyGr59YvRZaUOZ1EnIKCOvZQNBMjjCtj/8kMAppKhm5w=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e64ee84c-a58a-482c-d1b0-08d6bd962929
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 09:23:15.0952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2604
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

As this patch changes the default behaving from warning to error,
users can consider to fix it for external module builds by:
- providing module symbol table via KBUILD_EXTRA_SYMBOLS for
  modules which are dependent
- OR getting old behaving back by passing KBUILD_MODPOST_WARN to the build

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
