Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE64C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 11:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961EA206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 11:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="PFrPXl7Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbfH0LJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 07:09:27 -0400
Received: from mail-eopbgr70109.outbound.protection.outlook.com ([40.107.7.109]:11264
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725912AbfH0LJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 07:09:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfyamY94iHGd1cO+JMcEeK1F1gkRhpjaFzRioXavbMs7WEOFrJcJvS7RVr75yyvgSN9w8oaXmGMzEOjmoV3U97DzS/6TivRrC0QTUmsrjsGpNrWlv26bqUhtHOwr2wOzJhAEFE4t9amvfZDdoPyfLq3vMPpJU/ll/bEbSruDHnqkfgzUYrIXK8k4ZRhuZ7MbFESiLhYsAvDQQyoVHFuRTUCZLy2jyUf9X8nt2RHWyCzjohnZfXj3iwzuK5m1xnIMr5GFLwy733kucpsEICEu07+WHzfgVHbnDhtmm0+vU5ic7ATHXTpAL1Nj/f3D/Rln5Hl9P8HiM60FRFFu4eTp+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRqjE0WZVuRCuSo2PfQxoEd4jTslFS6OgAsaH9Mtu1o=;
 b=Dx4n4RZKo44b8p/IfEMofBrpbGmhTNI9s0IvN8sNHeBW2+4Bt9YQbCWClN7m6y5Lo8Up9c2eV5rXS8h/pa4kOdRaUFBtfgQSC8jjN4Vn6P09zYGkPzOrttjzL1pPsw8EQcdRt13m0TVmnBkyxTOHhY7QUB0OnB/030mlYrcHcaQ8Gq0ZEKozlopeAy74Uwe1quAeXDuzP1OxpN7vHHxfVvgkCVQToVMguU8WQ3pxDPTTvek+rxMZW+174K/BFHY+Ya7yXlBUcFz4S3CMCuiXg8fjoA9TNyusDyLeZuHMLQSV7U6QrGWtLQlP3jAnEzVqKz/QrzldAnn9ChrPE0Nprw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRqjE0WZVuRCuSo2PfQxoEd4jTslFS6OgAsaH9Mtu1o=;
 b=PFrPXl7Q/96EZP9vDnq84iRYJBC5H5Z7uCtx6yq0AQ8Shm+IW+ne2c4xSjJKn0R6aTskhZUsulZF9RD0kWnfr2Iw1kAowKs6bMSMEpEhI6EXzBkHgP+arzEm/mjYIqRsfCzhuAuRmGxwcF0pHPL8uZg6yWnfrK7mVRHAgA3/3Uc=
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com (52.134.66.158) by
 DB3PR0202MB3465.eurprd02.prod.outlook.com (52.134.65.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 27 Aug 2019 11:09:21 +0000
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::a0df:d7d9:f95e:f3ea]) by DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::a0df:d7d9:f95e:f3ea%3]) with mapi id 15.20.2178.023; Tue, 27 Aug 2019
 11:09:21 +0000
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
Subject: [PATCH v3 2/3] fbdev: fbmem: allow overriding the number of bootup
 logos
Thread-Topic: [PATCH v3 2/3] fbdev: fbmem: allow overriding the number of
 bootup logos
Thread-Index: AQHVXMfgYnRTlyUjn0+AfY7i/XbReA==
Date:   Tue, 27 Aug 2019 11:09:21 +0000
Message-ID: <20190827110854.12574-3-peda@axentia.se>
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
x-ms-office365-filtering-correlation-id: 2e726720-34f3-4045-da00-08d72adf0328
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB3PR0202MB3465;
x-ms-traffictypediagnostic: DB3PR0202MB3465:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0202MB3465C49B304DAB2F30289C5BBCA00@DB3PR0202MB3465.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(366004)(376002)(346002)(396003)(136003)(189003)(199004)(508600001)(99286004)(186003)(25786009)(6436002)(53936002)(2351001)(5660300002)(26005)(7736002)(2501003)(256004)(6116002)(8936002)(305945005)(54906003)(1076003)(81166006)(81156014)(6916009)(5024004)(3846002)(8676002)(50226002)(386003)(6506007)(66066001)(66946007)(6512007)(52116002)(76176011)(102836004)(36756003)(446003)(486006)(11346002)(2616005)(6486002)(316002)(4326008)(71190400001)(2906002)(86362001)(14454004)(5640700003)(476003)(71200400001)(66476007)(66446008)(66556008)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:DB3PR0202MB3465;H:DB3PR0202MB3434.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hf0xrqgkG/U54WB/5TT2us1wSpYiQi2RglkLY8S48bd7SvT3Vl/S47TR67VJQ+tXcVHbYqZBxDdxgMkuffCcPGcqHzPTqNYITxAVlp9m2rlnmUEFpltPH3aCqEVuSpfinIAEeNS2NjOmQThut0ySPUTfOjC84lpUI9io4KS+WFER3VrV2obWWURcU3N633QPErUJu5V4iPDAkyVJ7Qho6QKUR4bE00jS+YsTIJkdctLaM0U9ATzX1lIh4GehyRXq21iWU0HdmVEanQ9nGFTtJRLxHsJF7HPZ6WtfaHAz9x8Ef3jyt3zTY08iylYBhGty6wtBWenpVRfmND9dDaOQgYZfgJjPN7Jg4MLwuFfbZUTcMbuRUgh75nUJh+7odF0tJ7C6nD7+ubsIKdr3zA1gydjioCI54y+J6dcshy1t1Ic=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e726720-34f3-4045-da00-08d72adf0328
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 11:09:21.7115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y2xIZUjmmr3A9h7GrLQKyJ3wiWvW6S8oyqNIB6ChpGP1COPcxLUyQnG6mVQgw80W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3465
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Probably most useful if you want no logo at all, or if you only want one
logo regardless of how many CPU cores you have.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/fb/fbcon.rst       |  5 +++++
 drivers/video/fbdev/core/fbcon.c |  7 +++++++
 drivers/video/fbdev/core/fbmem.c | 12 +++++++++---
 include/linux/fb.h               |  1 +
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/Documentation/fb/fbcon.rst b/Documentation/fb/fbcon.rst
index 65ba40255137..e57a3d1d085a 100644
--- a/Documentation/fb/fbcon.rst
+++ b/Documentation/fb/fbcon.rst
@@ -174,6 +174,11 @@ C. Boot options
 	displayed due to multiple CPUs, the collected line of logos is moved
 	as a whole.
=20
+9. fbcon=3Dlogo-count:<n>
+
+	The value 'n' overrides the number of bootup logos. 0 disables the
+	logo, and -1 gives the default which is the number of online CPUs.
+
 C. Attaching, Detaching and Unloading
=20
 Before going on to how to attach, detach and unload the framebuffer consol=
e, an
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fb=
con.c
index c9235a2f42f8..bb6ae995c2e5 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -536,6 +536,13 @@ static int __init fb_console_setup(char *this_opt)
 				fb_center_logo =3D true;
 			continue;
 		}
+
+		if (!strncmp(options, "logo-count:", 11)) {
+			options +=3D 11;
+			if (*options)
+				fb_logo_count =3D simple_strtol(options, &options, 0);
+			continue;
+		}
 	}
 	return 1;
 }
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fb=
mem.c
index 64dd732021d8..c7ddcb72025b 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -56,6 +56,8 @@ EXPORT_SYMBOL(num_registered_fb);
 bool fb_center_logo __read_mostly;
 EXPORT_SYMBOL(fb_center_logo);
=20
+int fb_logo_count __read_mostly =3D -1;
+
 static struct fb_info *get_fb_info(unsigned int idx)
 {
 	struct fb_info *fb_info;
@@ -620,7 +622,7 @@ int fb_prepare_logo(struct fb_info *info, int rotate)
 	memset(&fb_logo, 0, sizeof(struct logo_data));
=20
 	if (info->flags & FBINFO_MISC_TILEBLITTING ||
-	    info->fbops->owner)
+	    info->fbops->owner || !fb_logo_count)
 		return 0;
=20
 	if (info->fix.visual =3D=3D FB_VISUAL_DIRECTCOLOR) {
@@ -686,10 +688,14 @@ int fb_prepare_logo(struct fb_info *info, int rotate)
=20
 int fb_show_logo(struct fb_info *info, int rotate)
 {
+	unsigned int count;
 	int y;
=20
-	y =3D fb_show_logo_line(info, rotate, fb_logo.logo, 0,
-			      num_online_cpus());
+	if (!fb_logo_count)
+		return 0;
+
+	count =3D fb_logo_count < 0 ? num_online_cpus() : fb_logo_count;
+	y =3D fb_show_logo_line(info, rotate, fb_logo.logo, 0, count);
 	y =3D fb_show_extra_logos(info, y, rotate);
=20
 	return y;
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 303771264644..e37f72b2efca 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -630,6 +630,7 @@ extern int fb_new_modelist(struct fb_info *info);
 extern struct fb_info *registered_fb[FB_MAX];
 extern int num_registered_fb;
 extern bool fb_center_logo;
+extern int fb_logo_count;
 extern struct class *fb_class;
=20
 #define for_each_registered_fb(i)		\
--=20
2.11.0

