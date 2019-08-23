Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33532C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6C322CEC
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="Eoo1CAa6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392962AbfHWIrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 04:47:46 -0400
Received: from mail-eopbgr80130.outbound.protection.outlook.com ([40.107.8.130]:3201
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732418AbfHWIrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:47:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OlKgC1IrgNIFKl4vw1Y7wDsD+lNZYR2772EAlkj6uV14ryKuo0Q1kupX8uxgNJqW8DptcGFdERo2EeUK3yuKX4sgnxqsQsFydCYNUjeCilps0i+cLnxzblLl1nxlRHE3G1GbTaWoTXLvbzkZDGoR3ZM0XgnBWKKxTwXo+uaoVgJqWhG2lq0jQosVMYbpb5bzChzmc52Kuh4xToYIMiEZETbutp6cygb8wdTjjqenxrOCPkwdDXZRaNdQRZ5asRpKtPGBKMvejmbQ6Dwp6r8AOU2pmPWnMLOz44CPM1HHP8swAVP4Q/YKSiET0DWGfzPqV/f0h6PWt9pPLF1fiZ1WQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzYkXKffNLiNfCQH5tfbnjcUD+zFyx9WF2wEk9JCzMY=;
 b=BE7I7WrhDW+aLOwLVrC+fqEGZXwpyIItfJ0g+6XJB7bRDsiWK/XQbQM8Yx32zFHOSwRQlbQPOFUGnWc41AGqamRj0Ae2G5Anmk6lRehPumUec9C1X9Fzx9/2d04Wz7ebw+SpVjpyyDNKGryS/egvJNLe9GIaqiknuSZf2VZ33LySHvKj6ghpjgfWFzykMcLQcTNEoXQO2XFtTa6cSP3joPsFpp+iSD1weyC46sjtC1dIiLNW9JHhRjjNtWB+W0zdVelF2FNkQkjHp7QnB9l5OCfUuwWWluS56de5l56USwktvtl6f1mKWar59UkNtqdx7RMLlEnGmSnb/L9rb/dlfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzYkXKffNLiNfCQH5tfbnjcUD+zFyx9WF2wEk9JCzMY=;
 b=Eoo1CAa6SJmQ92glKJYweU/qQvLNsMtFnFSi6ojaDG+thrRemm4l8AtBCtZla0FZMQNue3qArk9HthQT1MvnM58/AwHiUZMJ42wOTRARFNCEai+Af0jhvg2Ewr7cUbyJK9viSMlRekhAqHX1yVJ3DINUkGE0NU9VnlrdYHSYfEg=
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com (52.134.66.158) by
 DB3PR0202MB3530.eurprd02.prod.outlook.com (52.134.69.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.19; Fri, 23 Aug 2019 08:47:41 +0000
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::a0df:d7d9:f95e:f3ea]) by DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::a0df:d7d9:f95e:f3ea%3]) with mapi id 15.20.2178.020; Fri, 23 Aug 2019
 08:47:41 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: [PATCH 1/2] fbdev: fix numbering of fbcon options
Thread-Topic: [PATCH 1/2] fbdev: fix numbering of fbcon options
Thread-Index: AQHVWY9s15L4R7AIg0aauCg41bxnyg==
Date:   Fri, 23 Aug 2019 08:47:40 +0000
Message-ID: <20190823084725.4271-2-peda@axentia.se>
References: <20190823084725.4271-1-peda@axentia.se>
In-Reply-To: <20190823084725.4271-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1PR0401CA0084.eurprd04.prod.outlook.com
 (2603:10a6:3:19::52) To DB3PR0202MB3434.eurprd02.prod.outlook.com
 (2603:10a6:8:5::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 861411c9-a759-440a-3590-08d727a68e66
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB3PR0202MB3530;
x-ms-traffictypediagnostic: DB3PR0202MB3530:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0202MB3530FC030785B7F4EFC49CADBCA40@DB3PR0202MB3530.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(396003)(136003)(346002)(376002)(366004)(199004)(189003)(14454004)(186003)(6116002)(2616005)(476003)(2501003)(26005)(71190400001)(6436002)(2351001)(6512007)(8676002)(81156014)(54906003)(81166006)(76176011)(52116002)(6506007)(386003)(2906002)(3846002)(25786009)(102836004)(11346002)(446003)(99286004)(486006)(508600001)(5660300002)(305945005)(66446008)(66066001)(64756008)(66556008)(7736002)(6486002)(50226002)(36756003)(8936002)(5640700003)(1076003)(53936002)(4326008)(86362001)(256004)(14444005)(66476007)(316002)(66946007)(71200400001)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:DB3PR0202MB3530;H:DB3PR0202MB3434.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oboJipY39yjqH7VHajiBsPkZb9g8xjTNWNS1G+i0S2a8sUT2TOB+Kr8QCyGKHtGdz6ds4tbHiaMz+n1iFbWZo00TI2FPZkeZq95PGn3fCvjKgeWB3+mH/yEtX9En/UBT+C1E2n7Glv8gKQpBr+MDHg5dLJICYqH9FbxGe7w/KITueVP+nXyPQW92LJl6gP8T4y9Q3l5XnzeuRFEkeJ4XA3lS7IbJM0En/PMb+dsXXjs9lK3mIKeDQS46HNTlH6MPPqWAPw56AGwhFLJDRwDv4JFSOiAP/VAwLTldszlVIPYMY8i1m5AU8gdtuPym7o3wq5FiaI0RFXnR6l4KGqGGRgIIUU0tg6fNkL8hxVI4YGCRi4QxyqIlLwIklPYvRY7bh6pNFshb5ER/TkCEMvaPeEak5Vxox1oYvhRWJ0NV3dU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 861411c9-a759-440a-3590-08d727a68e66
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 08:47:40.9178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3J9LnhxrZW5PXeFypzWazag5FMwIdB4WHi0PDaZJSk2aoOvWQygOXZsA3FwLfezk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3530
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three shall be the number thou shalt count, and the number of the
counting shall be three. Four shalt thou not count...

One! Two! Five!

Fixes: efb985f6b265 ("[PATCH] fbcon: Console Rotation - Add framebuffer con=
sole documentation")
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/fb/fbcon.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/fb/fbcon.rst b/Documentation/fb/fbcon.rst
index ebca41785abe..65ba40255137 100644
--- a/Documentation/fb/fbcon.rst
+++ b/Documentation/fb/fbcon.rst
@@ -127,7 +127,7 @@ C. Boot options
 	is typically located on the same video card.  Thus, the consoles that
 	are controlled by the VGA console will be garbled.
=20
-4. fbcon=3Drotate:<n>
+5. fbcon=3Drotate:<n>
=20
 	This option changes the orientation angle of the console display. The
 	value 'n' accepts the following:
@@ -152,21 +152,21 @@ C. Boot options
 	Actually, the underlying fb driver is totally ignorant of console
 	rotation.
=20
-5. fbcon=3Dmargin:<color>
+6. fbcon=3Dmargin:<color>
=20
 	This option specifies the color of the margins. The margins are the
 	leftover area at the right and the bottom of the screen that are not
 	used by text. By default, this area will be black. The 'color' value
 	is an integer number that depends on the framebuffer driver being used.
=20
-6. fbcon=3Dnodefer
+7. fbcon=3Dnodefer
=20
 	If the kernel is compiled with deferred fbcon takeover support, normally
 	the framebuffer contents, left in place by the firmware/bootloader, will
 	be preserved until there actually is some text is output to the console.
 	This option causes fbcon to bind immediately to the fbdev device.
=20
-7. fbcon=3Dlogo-pos:<location>
+8. fbcon=3Dlogo-pos:<location>
=20
 	The only possible 'location' is 'center' (without quotes), and when
 	given, the bootup logo is moved from the default top-left corner
--=20
2.11.0

