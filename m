Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3837C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0EF217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="LVKruTS8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfDKJZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:25:16 -0400
Received: from mail-eopbgr00118.outbound.protection.outlook.com ([40.107.0.118]:17639
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726588AbfDKJZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrs3Ge3ptc84V0fG1G9YEJl4Ar5Wu9P26wXtRaXgbjo=;
 b=LVKruTS8p5zSmkJDC+Shf1J68fxZd4br09Pn1crxcuwW1w8h8tQ+np/UiuwZd5m0dxp/e9mZ+3Q7V8hhghKP8CJNRCK/NRK1Y9Kwhs7vVp1o5TBpQLW/LM7MtdMRkZWVTb6p3SlqKt+nls5Y3nGmTt0h493Z3OYhmAqGUMgrcXo=
Received: from HE1PR0701MB2652.eurprd07.prod.outlook.com (10.168.188.7) by
 HE1PR0701MB2107.eurprd07.prod.outlook.com (10.168.35.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.12; Thu, 11 Apr 2019 09:25:09 +0000
Received: from HE1PR0701MB2652.eurprd07.prod.outlook.com
 ([fe80::1449:d020:a36f:a8a3]) by HE1PR0701MB2652.eurprd07.prod.outlook.com
 ([fe80::1449:d020:a36f:a8a3%6]) with mapi id 15.20.1792.009; Thu, 11 Apr 2019
 09:25:09 +0000
From:   "Wiebe, Wladislav (Nokia - DE/Ulm)" <wladislav.wiebe@nokia.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "michal.lkml@markovi.net" <michal.lkml@markovi.net>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        Jonas Gorski <jonas.gorski@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] modpost: make KBUILD_MODPOST_WARN also configurable for
 external modules
Thread-Topic: [PATCH v3] modpost: make KBUILD_MODPOST_WARN also configurable
 for external modules
Thread-Index: AdTwSDzoNdQyvg9OT9e7o34Nbbkwtg==
Date:   Thu, 11 Apr 2019 09:25:08 +0000
Message-ID: <HE1PR0701MB2652279C2863E22F19B871FCFA2F0@HE1PR0701MB2652.eurprd07.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wladislav.wiebe@nokia.com; 
x-originating-ip: [131.228.32.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6b76328-ca2a-43d2-f7f2-08d6be5f9776
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:HE1PR0701MB2107;
x-ms-traffictypediagnostic: HE1PR0701MB2107:
x-microsoft-antispam-prvs: <HE1PR0701MB2107EBF42D421731B64318D1FA2F0@HE1PR0701MB2107.eurprd07.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39860400002)(376002)(396003)(346002)(189003)(199004)(186003)(5660300002)(476003)(33656002)(478600001)(2201001)(105586002)(14444005)(256004)(106356001)(71200400001)(71190400001)(86362001)(7736002)(2906002)(97736004)(14454004)(486006)(53936002)(102836004)(25786009)(6116002)(3846002)(26005)(68736007)(6506007)(7696005)(9686003)(81156014)(6436002)(99286004)(66066001)(8936002)(55016002)(305945005)(8676002)(4326008)(2501003)(74316002)(110136005)(316002)(52536014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0701MB2107;H:HE1PR0701MB2652.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +YDGrs9upHO/Qii3Q4mwW/Efu/AYUVpJcR5mVNUHHY62HVsolIUxqJqCAqzTzu/Ugt6LpstaZs7Nd2JQLKjHxnHfyV+4XzKK++tMzr7Yhe903JEy30ON5cApBO/GDFee+3dNmAEeMZkRck6XMiErkCD1eqM8gWJFUXE8GD644pNaQyEc6p5QZcgvzQJbnpZbMFfs7Q8z2Zs6Zjxv7O0bHLaxG6wnYHrvt3qy3u0MOOUw8ZxBUJE2X5m2/hiLTFJAAlYUTd9GblCG9qLpWmT4L7sYqZs9oGoem5Pnalv2aSTGwKA8+5b+QYFSCymy3hWo4t34LiEvnvDSBA2t1RYoSDt9f/LRXqBHoH7wGbAtx2h18SpAdPPUU2bZtRuWfUwI1098ka+oHbz4P80gaTon4jF5F8Q08zjSoIjkjoVUeMo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b76328-ca2a-43d2-f7f2-08d6be5f9776
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 09:25:09.0259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2107
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
