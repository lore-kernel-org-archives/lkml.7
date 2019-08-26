Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF29DC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 19:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA932206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 19:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="h/DTEI2N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387910AbfHZT67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 15:58:59 -0400
Received: from mail-eopbgr70118.outbound.protection.outlook.com ([40.107.7.118]:6592
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733294AbfHZT65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 15:58:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eju46C8364uT/n+fZscxhbmRk2A6pfLet9S0RxD2vCPFXhlrkfbqcUneGResVbXo1ZmGLZZr9OGWus63vnbjx/6bBcdFdlxBDXhl2UPpydJqQeylKrhj47Q42gpKW32BY9n+C+6ClcRRJzG5jazdB9cFs/azvnKsnFiSsx0hp3bHMDZTxuwhXZpIizSJMSJ/g1Sy/h+CRZQCEHb6bpMopbbohbLqiYcz5KDLa7rEHOYSx543v+0eYilShArNXGad1N66xvW/FwH1E5cj+a6cazCjtIg8x6NI/wX8i1cIPVeFNvKJP5huDFpUffHz1Vg16y1AN2W8uPdddV6L3BcBOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzYkXKffNLiNfCQH5tfbnjcUD+zFyx9WF2wEk9JCzMY=;
 b=SA13ZlqIiNNKW4H7TDi+0cROuZnjuFTK41ykypwTA4md8bUgHA/jvQyzJ/A+I5TazIlkME5GCZkVSxrRMLem2/+DzFnGLC7mQFANqybxjLbw2o4CYDfSyB4AmYtlGjM4iLXDzwu+zsfjfNOQfHfAgwD4bMhEOKrNiczLcfRYesnPwWGcQfKi9Q9YIW/PIEIeIDWmOCfrGYrw1gOphhpkSkBsF2qn9+sPxb5ZZpD+spZLNtKCxT+/pZW7uCgTqaQjBHHAUBbMQrUn6vI2KnJ++G2V10j/3vZfgAjQo0P/g8KkJ6WzY5RSFlsl+QuovRMCZC4qba7gdKJexpTU4SFX+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzYkXKffNLiNfCQH5tfbnjcUD+zFyx9WF2wEk9JCzMY=;
 b=h/DTEI2N4Zbzzl3U4u5aPIWhNu+L4aGyzG9+PwHaSMggENpO5r6L9rXNJ3g5WGdE1YaUA0xz7HMb+KZYJHyxXtdguRTEGbVfR/pa7IztkZStVOAcj5KvJfwsxPiUp3aW/QmPncW7vKaTLgMqFBTS+hJP6grH4u0M3E03ebxtY0Q=
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com (52.134.66.158) by
 DB3PR0202MB3340.eurprd02.prod.outlook.com (52.134.67.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Mon, 26 Aug 2019 19:58:54 +0000
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::a0df:d7d9:f95e:f3ea]) by DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::a0df:d7d9:f95e:f3ea%3]) with mapi id 15.20.2178.023; Mon, 26 Aug 2019
 19:58:54 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 1/3] fbdev: fix numbering of fbcon options
Thread-Topic: [PATCH v2 1/3] fbdev: fix numbering of fbcon options
Thread-Index: AQHVXEiw/LRCleLuAUGVU4XBezNSZg==
Date:   Mon, 26 Aug 2019 19:58:54 +0000
Message-ID: <20190826195740.29415-2-peda@axentia.se>
References: <20190826195740.29415-1-peda@axentia.se>
In-Reply-To: <20190826195740.29415-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1PR0901CA0054.eurprd09.prod.outlook.com
 (2603:10a6:3:45::22) To DB3PR0202MB3434.eurprd02.prod.outlook.com
 (2603:10a6:8:5::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e335a9b-3f48-478b-80ed-08d72a5fd2c3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB3PR0202MB3340;
x-ms-traffictypediagnostic: DB3PR0202MB3340:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0202MB3340C8B75558178783E6F3D5BCA10@DB3PR0202MB3340.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39830400003)(136003)(189003)(199004)(8936002)(256004)(316002)(54906003)(26005)(476003)(2616005)(99286004)(102836004)(76176011)(386003)(6506007)(66066001)(52116002)(5640700003)(508600001)(186003)(6436002)(486006)(66946007)(66476007)(66446008)(36756003)(64756008)(66556008)(2351001)(1076003)(6486002)(6916009)(2906002)(50226002)(86362001)(71200400001)(71190400001)(2501003)(53936002)(6512007)(4326008)(25786009)(11346002)(446003)(3846002)(6116002)(305945005)(14454004)(81156014)(81166006)(14444005)(5660300002)(7736002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB3PR0202MB3340;H:DB3PR0202MB3434.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jRI+w2kFyTUjZ+qAHX3MgBO1rVtqYYYmMNDaeKrCWca9U3zBrC8Ffjag6IgE26KrlX4xrqOXl1PHvOamS7TK707YHNn9t8l4P0C2DZOt7mg3eJUtwTnHxwn+YGeoljAf1UdvzhQF3/LbWvpV10bX1Ru8VyK/FoW3OB8DzmO+wMlsC0wKx5dw5WQb8oQgMPg6LlEosN9OJOJG7c89WyfZNcecqTNxWVgMfrLTzXlWpt1UGPTIotZqoF79Q4VOrrhe6IYDOIY32E+b0TkzAsLx9OfJV2X3r8sZAo20+5eMuOeL/c9e+eVDMR5zX2g6tyHn7J7G5bKm9AlJsVEl1KM6VY4jCAqbfy3uczx//uHhrxoRSWm7OW4sbW3KBCsdYcNWQL4/WIm6VJe23PGVyRPambCFZDhH4Ob7nN/ERdcpdgw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e335a9b-3f48-478b-80ed-08d72a5fd2c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 19:58:54.5250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WgMgXxylxdlEiVwcbDA4ZfefUI6ScWPqweRDa1vTCiXxw/gpQaABBZFr7h3pEhWI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3340
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

