Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30FAC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 19:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8CC206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 19:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="cK4obFu0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387926AbfHZT7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 15:59:06 -0400
Received: from mail-eopbgr70098.outbound.protection.outlook.com ([40.107.7.98]:60425
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733294AbfHZT7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 15:59:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRzljwf6/beSMvsGWgUin0Mr0azW4md7lMVeJDYuE9pC6nf5U8tzMMV0RBoD1LENHcpgewjpF0VYl99SQBBxKpgLwSgb0HPBjFptdGOHBS+2Iy9908pbACdr4rZUwC5F8qzhlmbqMBud5FcaocF+hR/e/pf+FbVrK2H5C9y+NkbKBA5XLiJYLQRI/K2UhB3suUhpqMlYMeWuxEYsLOSLbPNs6IpEmMdFoXwIg4entrRYIN4JTr3RKl3TdVqwWp5VwUGCpG9X8nUeCCEIJWI11wIi8S+Orr1Hw/bXS/Z95hIskEjdw/nFzedd/5Bh6BaG2WD4fg96EzfqUcy3qSZubg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r48C9G2I6doSYZhilQaVgfdxXd9WEOXf/GFjchabS4M=;
 b=T4cM22YhXwPU9O7U5ZwsnFrsftP3LHP39QzjiduOrq6ZK+t//bw8tjuOn9TSuAtj4bXExCpDancr0O+5ZY0eHsUzqOJ9l12wRoKE8cwYlK86Ye6c1ZUib1Rc45TSEWAXajXcMZD8HUleosCJv9AOGj8DwSIZDH3BqH6EssqN6d/9sLAlrtWI6bVNr3UkiSK8k2MYuSx5kheUWjEASxeFkscKdnuk6xMKDASXqPNDHZ7yPwJ31MB2Mkc4eCr/MXkNQjiN9dQilAGh/wBpw0JDKspIEFRSKOI/IT6GJtXFtQ8El2gQb3GHkqqxxbtiWFhyBaCiS7QE1qvU9EBovmS/0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r48C9G2I6doSYZhilQaVgfdxXd9WEOXf/GFjchabS4M=;
 b=cK4obFu0JaYJvAXAxs0++rP4HhqiIaDmrUu38U8CQsVVZ7eJVcE4s97Zueb/e/K4QFA2E3jJTHcvU0OodROg/CRwgLNO1PJjHIIK9L+pRKrpKv98upto1iAwkxskijS9fVsYNhxw+nE8GM1+F/qEV/84wHC+BYRMJi14eEuu1cQ=
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com (52.134.66.158) by
 DB3PR0202MB3340.eurprd02.prod.outlook.com (52.134.67.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Mon, 26 Aug 2019 19:58:58 +0000
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::a0df:d7d9:f95e:f3ea]) by DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::a0df:d7d9:f95e:f3ea%3]) with mapi id 15.20.2178.023; Mon, 26 Aug 2019
 19:58:58 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 2/3] fbdev: fbmem: allow overriding the number of bootup
 logos
Thread-Topic: [PATCH v2 2/3] fbdev: fbmem: allow overriding the number of
 bootup logos
Thread-Index: AQHVXEiydN7Y70k3jUSZvl39hK1AWQ==
Date:   Mon, 26 Aug 2019 19:58:58 +0000
Message-ID: <20190826195740.29415-3-peda@axentia.se>
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
x-ms-office365-filtering-correlation-id: 365c794a-7de3-43a0-a10a-08d72a5fd542
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB3PR0202MB3340;
x-ms-traffictypediagnostic: DB3PR0202MB3340:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0202MB33406A3E38AD7B784776CE9BBCA10@DB3PR0202MB3340.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39830400003)(136003)(189003)(199004)(8936002)(256004)(316002)(54906003)(26005)(476003)(2616005)(99286004)(102836004)(76176011)(386003)(6506007)(66066001)(52116002)(5640700003)(508600001)(186003)(6436002)(486006)(66946007)(66476007)(66446008)(36756003)(64756008)(66556008)(2351001)(1076003)(6486002)(6916009)(2906002)(50226002)(86362001)(71200400001)(71190400001)(2501003)(53936002)(6512007)(4326008)(25786009)(11346002)(446003)(3846002)(6116002)(305945005)(14454004)(81156014)(81166006)(5024004)(14444005)(5660300002)(7736002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB3PR0202MB3340;H:DB3PR0202MB3434.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: l6jgyRjVcYmbXaWS06x6L2ziSOqjiebJWE0Y/JserifjhN5BCa/xxlEv9DOtPz0aL7QBJxmoAvH/a/9hYo1p6ekmRQrWN2XPKKGffhrZYP4RcfjfZqteYWhKRxwxMUfpiKOB/iE1ZiB2s7i2dXo88or7Z7VqCkhNs7n2oWC1YsexYearZA6rmqsHFGgcA3w9PvtLZ7woEwO0jeVLs5+vjMjFK51oBY6ZQsdGaL4NjHJ1fz1+igS3jFOryCiS4udf3D37azgkHbAxCYUznf5rUlA0gaA4G/99LiBl05lZ1jcUQnsuDG1AwVPQLKVGe0F2IBwHpkTU0/yCHLlp5LMQEj4TKFkUGpkvb8ZVb0I5q7hDXMNl95LPVnWU8u0gQHw/Tc0e8E+33F/NSSEKK1cfF5gcDrdv8pO0pX6cyM3X0Dg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 365c794a-7de3-43a0-a10a-08d72a5fd542
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 19:58:58.6526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ffz/OaaPPIlQqPQFeossdHYIMwCeTNjOLUNmf6dQeWhOQyQZAD5T9SuWwE7uJOno
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3340
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
 drivers/video/fbdev/core/fbmem.c | 4 +++-
 include/linux/fb.h               | 1 +
 4 files changed, 16 insertions(+), 1 deletion(-)

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
index 64dd732021d8..a7d8022db516 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -56,6 +56,8 @@ EXPORT_SYMBOL(num_registered_fb);
 bool fb_center_logo __read_mostly;
 EXPORT_SYMBOL(fb_center_logo);
=20
+unsigned int fb_logo_count __read_mostly;
+
 static struct fb_info *get_fb_info(unsigned int idx)
 {
 	struct fb_info *fb_info;
@@ -689,7 +691,7 @@ int fb_show_logo(struct fb_info *info, int rotate)
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

