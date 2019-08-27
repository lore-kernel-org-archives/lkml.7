Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16545C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 11:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6EFE206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 11:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="gPPkmLbo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbfH0LJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 07:09:21 -0400
Received: from mail-eopbgr10093.outbound.protection.outlook.com ([40.107.1.93]:44093
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725912AbfH0LJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 07:09:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LlVFuWg8UodMRa1zfCpjo3awEhcZbESYdq9rpPTtbKjdspm6g//MglKVK1Vk8cgJHGwD6I0/MZf+YQQBhE+cv1LTvoeK6XMm8w/R94qhy0C1JZ1V6MRii+je31uUmD8EzjNTd4Nu7LhewniXEudb5vH3ttUcZbFF0LTEzGZMYFwd+cgF6HktX1urAcesAc0lpBjJxgP5s7kXyaq4O8DmibiPOZUaXGW97NDm+pCtBtnrMuKzn5GSxSVHInDcF54XKlOmmNN7cGPDiR8xbQ9z3/wC1xKOrmOIzsCpmiKSgM/jwIygCA2lRlNsoyuq3pqNSx1C+zZq1IX53hyPLJeEgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzYkXKffNLiNfCQH5tfbnjcUD+zFyx9WF2wEk9JCzMY=;
 b=SechQxCzML1Tg4Em23j43XKFjVglpkPu4NVwdOkH+E2IaMbeR++BV4JIGLTmazaYYEg4mKTHR7XoDTrAf/ExEGGMa6ynCTqzxN3P/9zHhLyA3jysu/Fayp7mxuhwqfNk7ABha73J+mC6qsxNCzfmblO7WBG+TC9AZNOvtFIC6XU6wqgERm6LEfs5Hq+k9z+zjaWgauiI2SYfz61fZBPc/gz+IOTDWkL8m7Dv3mPUFs/0f+vb+TCXExq8Dz+59wN60PNEV34814n9Z0eNckhhspt1Z7lvj1eO4PPLBSZh0AZbNBZ3PwpTDhAyGgGIeX6pQA3ueKeMPZaKZsUGB76KCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzYkXKffNLiNfCQH5tfbnjcUD+zFyx9WF2wEk9JCzMY=;
 b=gPPkmLboCGOlVVNYI2ZgjnejbnKWA3orDO/rMtZV4MUrW4Qggfr4ZLDmROzcSxay5d8SDAp4I6yYD3DVhADNMNtWxWkAj41U62HPq3+dNdO+jcW+i+aE+HxTmw4E+oP2HcY8+r/zmZaRUmP+GHXo6rbMx+9OHzlKg4Nndq2HLQ8=
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com (52.134.66.158) by
 DB3PR0202MB3420.eurprd02.prod.outlook.com (52.134.67.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 27 Aug 2019 11:09:16 +0000
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::a0df:d7d9:f95e:f3ea]) by DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::a0df:d7d9:f95e:f3ea%3]) with mapi id 15.20.2178.023; Tue, 27 Aug 2019
 11:09:16 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v3 1/3] fbdev: fix numbering of fbcon options
Thread-Topic: [PATCH v3 1/3] fbdev: fix numbering of fbcon options
Thread-Index: AQHVXMfd9MAF8GUPp0SqrWDsOYLJ5w==
Date:   Tue, 27 Aug 2019 11:09:16 +0000
Message-ID: <20190827110854.12574-2-peda@axentia.se>
References: <20190827110854.12574-1-peda@axentia.se>
In-Reply-To: <20190827110854.12574-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1PR0802CA0012.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::22) To DB3PR0202MB3434.eurprd02.prod.outlook.com
 (2603:10a6:8:5::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f9b339b-b721-405d-dcf2-08d72adf001f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB3PR0202MB3420;
x-ms-traffictypediagnostic: DB3PR0202MB3420:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0202MB3420B3E7154ED02B31752EFABCA00@DB3PR0202MB3420.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(39830400003)(396003)(376002)(199004)(189003)(3846002)(50226002)(2906002)(81156014)(6436002)(81166006)(4326008)(8936002)(6116002)(36756003)(66446008)(186003)(26005)(53936002)(76176011)(256004)(5640700003)(99286004)(52116002)(6506007)(102836004)(25786009)(6512007)(14444005)(386003)(66476007)(66556008)(1076003)(8676002)(5660300002)(6486002)(86362001)(14454004)(305945005)(7736002)(446003)(316002)(66066001)(64756008)(66946007)(2351001)(508600001)(2501003)(71190400001)(476003)(71200400001)(6916009)(486006)(11346002)(2616005)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB3PR0202MB3420;H:DB3PR0202MB3434.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YIrlV1vWmV4GiLQ/KUBZLtLlblCypktSzvmuyU4DNnj7MeLAOEvUjBBD+XZNIRjDbvHYdQ5/Hz+w9szb7xKlSWEKebmtydfswbcbuuE96SnM/RX5+vpjeZpHeAIg9GYieXbIejBnEyCwoesJfoi/MauMzwK9+ue1f1ziWHaBc3DYoAnv0A0X+6UFbrs/Ivsz8WDIU00UhCkBpGAs29lHx5j9YMETFY20R0l24ucBVGfwz/C9Q1GVyIgMToVBN4W/poJzaXJJDJ/U5nW54OTbVS0KA6oIax6hJQ7HyKsDsz8RKnGtxJ2ZLmIi45IzC+DwzQBqeMnPEbf1Jan6q2PjZfZOzkOM0f/JkbreOzzxOnl8yRxiHjQoI76kjHbDjNzH83lCj0BcydySKiqUlVQHgyjgdtHaVlqs2om6qYpxJXE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9b339b-b721-405d-dcf2-08d72adf001f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 11:09:16.5915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mZ0+DqBVKcyojV+oZvP7jAJh1oKG+NiXqawjOVhMPZyGfhRQPIlasPaioMgGhv3Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3420
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

