Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18654C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFED8233A0
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="NXDxQjWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393041AbfHWIrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 04:47:52 -0400
Received: from mail-eopbgr80103.outbound.protection.outlook.com ([40.107.8.103]:56545
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732418AbfHWIrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:47:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+UrdJs2RBL7ysUeQBTYAmfh31bAtT31zoyNyO+/XTrlRVIeugLgjkEreHsA6yFqCgnMjydfMa5LjjB+FeUPVaso7EtnUMvPzIQM1MIl8bHIjCVBxxyo7MR/1NUIu0i6sqvewVqMjm94SYMqBNE5FHdNPeFJ6DOSTpYR4YSPYXK6qjPbMkqODCEZMMJeFXfb7onVtQX7tkaIJMRI0yttz5X24LvpIvrpzgpmgJ2OhohnYyXzg0rAqRPoc8s83kyoUgoj/vKmQ6f/aq25EGiumdU6NQp+34KmaYUD7P/BS5qHEo9FAgeA9i5XXUffQvBjTHdoCNPHWv8pDANmaPJaqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHh5pz6CDFYyQgu2xiYoU4VNbYl3Y4bYqHD8MPU44Ys=;
 b=NvvzTpTa8bOCD8GdV0cw+rw7NOVPHomyACCfTSmlUIwpexvV6UvlX2/E2AkIs7jjpbcSIS/p5DVQhEwGw/wxzazxBhVBiZQxRd+1ufzqC+d5Ml49gYJxRgzrQR94FAA8zYFNR3ka9OQpXNWqhu0Ko0F5od3qYDGRwaYF9MouPEYoukodP83J5VNtFokHTNT9mewPErb5lcdJrom5APoyanrrIyq9BAvqcLmEb5jYBraG9/SpjyVU3VLRN2q3r0ailqblRnNiHDdKLqGpOtG1HbSfu38vpGWTFqRoDcvgz7MbF2uzFE1SDtJfUZEfdKgRyvTAfajanmisVm1I3Gq46g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHh5pz6CDFYyQgu2xiYoU4VNbYl3Y4bYqHD8MPU44Ys=;
 b=NXDxQjWGXpKpJw5VZNzfeuzUuNUFBSe68UmsM3vq5bKCbPJxxoBMDje5zhieSnij7l1Vm5jlUuCRXrYc7E8qABW57f91VwTFUSS3aTGNl1wlcieAAZhkSzQ+nxE2/sQ6N/ygnV0n6cQMpTVJyVxs2x33cv/k9cfC11RWwN0jg38=
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com (52.134.66.158) by
 DB3PR0202MB3322.eurprd02.prod.outlook.com (52.134.66.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Fri, 23 Aug 2019 08:47:47 +0000
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::a0df:d7d9:f95e:f3ea]) by DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::a0df:d7d9:f95e:f3ea%3]) with mapi id 15.20.2178.020; Fri, 23 Aug 2019
 08:47:47 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: [PATCH 2/2] fbdev: fbmem: allow overriding the number of bootup logos
Thread-Topic: [PATCH 2/2] fbdev: fbmem: allow overriding the number of bootup
 logos
Thread-Index: AQHVWY9wDEebDlWGKU6SxCgqM+Aamg==
Date:   Fri, 23 Aug 2019 08:47:47 +0000
Message-ID: <20190823084725.4271-3-peda@axentia.se>
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
x-ms-office365-filtering-correlation-id: 81ce9c27-eab8-41e9-77f5-08d727a69292
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7193020);SRVR:DB3PR0202MB3322;
x-ms-traffictypediagnostic: DB3PR0202MB3322:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0202MB3322286FA48DD9A55BB6D204BCA40@DB3PR0202MB3322.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(376002)(396003)(39830400003)(189003)(199004)(2501003)(2351001)(86362001)(66066001)(36756003)(71190400001)(6512007)(71200400001)(2906002)(3846002)(4326008)(14444005)(5024004)(53936002)(256004)(25786009)(7736002)(26005)(305945005)(6486002)(6916009)(186003)(1076003)(102836004)(6506007)(386003)(6436002)(99286004)(52116002)(76176011)(8936002)(6116002)(11346002)(446003)(476003)(2616005)(50226002)(486006)(81156014)(81166006)(508600001)(8676002)(14454004)(5660300002)(66446008)(66946007)(5640700003)(54906003)(64756008)(316002)(66476007)(66556008);DIR:OUT;SFP:1102;SCL:1;SRVR:DB3PR0202MB3322;H:DB3PR0202MB3434.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GyDYt5qs7zZtv0oluN+lgqNqjZR+tsbUxYPcjACL0Dc4g7Z449phE7gbkGWh3FSLO1PxWqUC7iAGbFzB0hgWp4FAuhjvzyuPo7vudCn3h5oDlTo/XCuBoXA1XxtADA/0R7uApop/UsoUJm+SgBGyJHyR0CMpOnOP7MiSeeLZqyQGciaVHRPnINkXrLdlvBb6oO6Lcdj5APtGtIiklxq/VR4pfsBhjGvn9fSBi+C0Z5Z1AGxJ/YD4SvPkVnZq50TMCl0wgwgIpN1aEzKm9Sp8BDdPIBnJ999+TTdGkMLF4R+/Z4e2oibTeRuP5PzmHumpGRr6CqReEObaPZ27M1z7wFuPy5u46/IZF5C8vKFyRBdFEllVxo60/+pwKRydp6lknSaeQeX9E6dDWaNAMq9rEs/N+j3Lenfm4w+rMLj6P7Q=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ce9c27-eab8-41e9-77f5-08d727a69292
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 08:47:47.5200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xq39EpXg9qMmY/xvrGnMgD5fhd+EOVctJHSlxfVMc9RbnI6HRxovsEg3kN9zjbmB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3322
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Probably most useful if you only want one logo regardless of how many
CPU cores you have.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/fb/fbcon.rst       | 5 +++++
 drivers/video/fbdev/core/fbcon.c | 7 +++++++
 drivers/video/fbdev/core/fbmem.c | 5 ++++-
 include/linux/fb.h               | 1 +
 4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/fb/fbcon.rst b/Documentation/fb/fbcon.rst
index 65ba40255137..9f0b399d8d4e 100644
--- a/Documentation/fb/fbcon.rst
+++ b/Documentation/fb/fbcon.rst
@@ -174,6 +174,11 @@ C. Boot options
 	displayed due to multiple CPUs, the collected line of logos is moved
 	as a whole.
=20
+9. fbcon=3Dlogo-count:<n>
+
+	The value 'n' overrides the number of bootup logos. Zero gives the
+	default, which is the number of online cpus.
+
 C. Attaching, Detaching and Unloading
=20
 Before going on to how to attach, detach and unload the framebuffer consol=
e, an
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fb=
con.c
index c9235a2f42f8..be4bc5540aad 100644
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
+				fb_logo_count =3D simple_strtoul(options, &options, 0);
+			continue;
+		}
 	}
 	return 1;
 }
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fb=
mem.c
index 64dd732021d8..4c57d522b72e 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -56,6 +56,9 @@ EXPORT_SYMBOL(num_registered_fb);
 bool fb_center_logo __read_mostly;
 EXPORT_SYMBOL(fb_center_logo);
=20
+unsigned int fb_logo_count __read_mostly;
+EXPORT_SYMBOL(fb_logo_count);
+
 static struct fb_info *get_fb_info(unsigned int idx)
 {
 	struct fb_info *fb_info;
@@ -689,7 +692,7 @@ int fb_show_logo(struct fb_info *info, int rotate)
 	int y;
=20
 	y =3D fb_show_logo_line(info, rotate, fb_logo.logo, 0,
-			      num_online_cpus());
+			      fb_logo_count ?: num_online_cpus());
 	y =3D fb_show_extra_logos(info, y, rotate);
=20
 	return y;
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 303771264644..5f2b05406262 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -630,6 +630,7 @@ extern int fb_new_modelist(struct fb_info *info);
 extern struct fb_info *registered_fb[FB_MAX];
 extern int num_registered_fb;
 extern bool fb_center_logo;
+extern unsigned int fb_logo_count;
 extern struct class *fb_class;
=20
 #define for_each_registered_fb(i)		\
--=20
2.11.0

