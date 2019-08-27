Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFFBC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 11:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B98206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 11:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="bn4m/dWu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbfH0LJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 07:09:31 -0400
Received: from mail-eopbgr70109.outbound.protection.outlook.com ([40.107.7.109]:11264
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729582AbfH0LJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 07:09:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNodGOzrxlgZMqXBjUXDPimj6297jpCDIAAGQ3pmnDqW+AMp//Ja/HHEDb1HMZoqI1GzyQY9711y3PuDwMF3fxJWn+VVFIYPXaFEb++ktheePDkaA0JUc3YYFPf7DsFLlNqkFJ1FmgbzJp3U24ws8MV+g1zfCR8FLS01sIA4nu+LdVrprGlqzlUnFSZ/fi4nfJ17WgeeOese9UJOeZHW1L877Zui5oqwahyi+HEc2tCMT9kuCl7Q56HBSv+AS+gwsC4Y3QOqTW03QGBpQCDd4KAPu44/Cpm0ku5aHm1U1T1xaYPMHVDzA3SlsMOEp5O8d2ZGmgwOIs19vRc6OHpoxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91VOH+vDNas5HY7lNAsbI7PTV7qG4iDbOpjyyXSQXfY=;
 b=H31bJCqLNvG4JJRSaJ+nYlvRD96bnFxW20DK68nfuJj4sEAJZQlR9DUgd2XciJE5crcJzX1w3E02ZKkL66ocC6/n40/uD2udBRmVWbk20djAwf3mGwWXwIG22IMs0K3uWfduaBtKT5oMvRE+PXpUah5vcnBFxrawF9jJMeeIj0R/GeUs3uMIB3EOKxW/i/nIjkxwAZx6PwsjXy0MyM5F7efxjD7Tuf6YQVbu5E9La42tWNCk8DRMltWceuZDWRBIqz83lgH1vp1OBZm+L4DEnc6ot7505L30z1iaRNHe/KyORhSUW4ZoC6wx2idxGCnn+/kkomErkr8LjpppmfEiew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91VOH+vDNas5HY7lNAsbI7PTV7qG4iDbOpjyyXSQXfY=;
 b=bn4m/dWuYJP3NXd5ipuFtGM0ZooAFnGVSRD2GhOMFlqU60o6YQzeX7p8YOl62DETyayQVMgHDdM5dmRhwnR6OsyYcvc5kmzaMVECKzMeUj55Lk/8gVYO0Pb8siaLeywz/dkmrclf5ozLX/EX4ABit9Trg4uKc70ROdXK82f/vpI=
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com (52.134.66.158) by
 DB3PR0202MB3465.eurprd02.prod.outlook.com (52.134.65.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 27 Aug 2019 11:09:26 +0000
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::a0df:d7d9:f95e:f3ea]) by DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::a0df:d7d9:f95e:f3ea%3]) with mapi id 15.20.2178.023; Tue, 27 Aug 2019
 11:09:26 +0000
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
Subject: [PATCH v3 3/3] fbdev: fbmem: avoid exporting fb_center_logo
Thread-Topic: [PATCH v3 3/3] fbdev: fbmem: avoid exporting fb_center_logo
Thread-Index: AQHVXMfjb9HuvMXdNUO0R8iyHBP+3g==
Date:   Tue, 27 Aug 2019 11:09:26 +0000
Message-ID: <20190827110854.12574-4-peda@axentia.se>
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
x-ms-office365-filtering-correlation-id: d7bd2115-667c-4dbe-1add-08d72adf05ce
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB3PR0202MB3465;
x-ms-traffictypediagnostic: DB3PR0202MB3465:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0202MB34654718A140BDCEE03C488ABCA00@DB3PR0202MB3465.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(366004)(376002)(346002)(396003)(136003)(189003)(199004)(508600001)(99286004)(186003)(25786009)(6436002)(53936002)(2351001)(5660300002)(26005)(7736002)(2501003)(256004)(6116002)(8936002)(305945005)(54906003)(4744005)(1076003)(81166006)(81156014)(6916009)(3846002)(14444005)(8676002)(50226002)(386003)(6506007)(66066001)(66946007)(6512007)(52116002)(76176011)(102836004)(36756003)(446003)(486006)(11346002)(2616005)(6486002)(316002)(4326008)(71190400001)(2906002)(86362001)(14454004)(5640700003)(476003)(71200400001)(66476007)(66446008)(66556008)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:DB3PR0202MB3465;H:DB3PR0202MB3434.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Jj8d+sWO9ZcXy2Ngr7R2Ejwz3pp0jADgPHJuhRcUoc1SLRyiAw7wWmwlZajtDF0NA2cbNHbUzk6UjCXHJXDVksojOqVJ7Mioxce+7TRYdQdd6+8Job/0kVTDO6fFPi/ovu06RMlCrpMypIxvNz0HgpZHzJ/HmhuNnNLl1H7LCZcPD8f4AX9dUBqOFLAgm7AwDW4jDPplfFPZS7tntMHm4z1VoOSbikNGJ82SKR+OhZNEoCG6gYTgygZxgUgZLTwoYxw8hx6qGq7dINFQt4GJD8riv8voBuSAJTQyuShPddXdCvZtbc3j8fjdXExOtuF3QomPcIO/HgtF2oYacOfKLaCVZ8t83gX6+KEnf6e4BYwFhF2JuhVL6IXZtQo7JIlpdvudDe/bkV9tWlcAdaT3T2fAXIyUTDyjSJeBSpoqbgk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: d7bd2115-667c-4dbe-1add-08d72adf05ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 11:09:26.1960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uy8s3wiwEGlN7NOvh8VgJgSsQUoDC+G2pmMplqYu6nAxjjd/83hQHLNP3Xvvvqgw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3465
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable is only ever used from fbcon.c which is linked into the
same module. Therefore, the export is not needed.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/video/fbdev/core/fbmem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fb=
mem.c
index c7ddcb72025b..d45e59ac351b 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -54,7 +54,6 @@ int num_registered_fb __read_mostly;
 EXPORT_SYMBOL(num_registered_fb);
=20
 bool fb_center_logo __read_mostly;
-EXPORT_SYMBOL(fb_center_logo);
=20
 int fb_logo_count __read_mostly =3D -1;
=20
--=20
2.11.0

