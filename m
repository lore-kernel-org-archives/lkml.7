Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA15CC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 19:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42BF206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 19:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="ojnB0ZJI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387938AbfHZT7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 15:59:09 -0400
Received: from mail-eopbgr70098.outbound.protection.outlook.com ([40.107.7.98]:60425
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387913AbfHZT7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 15:59:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIn7ndJNEyECxfxfEPcAnWmXHC47wB2l08anrxiEkkzXdtZBwn6bn62BOVA5HOBGy/jZ+sU9GVBPVcCEyhDh1RCqArRALPBJfaxyumOUQ6vIYwlrzd6CJM1r0A4l1+i0ZnowCrx6fIOImwSdexqDXUgvnK7NRoX5svBuUBf1j33zu5m6qmqZoA1tgmwfv+YDh4hqpGAXwrzht0Sb5zbGoN/1PtCaxsp8NPjbcF26llq+KW001Mnm1t/If6VKdr2D02aSDDrjZzMOuxArG0k2czNEoNVpKx0lKCvvPtbEDzvbat1JOODlaegStPDNsRWQkYt9qXqoQD7TDhcd73OBvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MbhNTXPO54Q94aVZE1Dy3M9rRyzC1l5DJov7oEsDgs=;
 b=EY0xTIaWJY3nWYx0eqXqmUVOf7nYFYZYFCxUnGj9LBpUtATnXLgZM3qx3KDCd33X+i+9ERI3X2bWDzzdLiHDH6rTc4dZuyKxrm7e8eLpI2FIIP8phuCBJaoNjGa/nMegn9ZaFu8kv+TLIPrexUkojXhO4VTSIfaRUkpynT1yVtfxCG+s5SPVffatEa7bbta2OSOt01rniRYgO3v5Iy510wT3yXsc6fNJrlGCiXuRSvioeVLFXjo7MjLE96UBZ1c3rpqvrfD0+T2UoXEj7CLsyLT/5zNHjM6PSnCLV+n85v/USY6TF9h6kf9p9ugrwXhpFEVk7TXb7S5F7m9bgVnIrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MbhNTXPO54Q94aVZE1Dy3M9rRyzC1l5DJov7oEsDgs=;
 b=ojnB0ZJIxq5VoegcD6W9xPD5mNoluM8SvdzH/ppJzOuc5kQ4hkI8MZmMVZX+ntz/vod0aUQvXPOCdmcEygMZyD72di0PxZ3YtKMmUJ2PF8CffaQkFWJDjuchcPhz9VDJrrZb6jZLMnK9HCmBwQEi1jOhu/HM5TR5POvijssmH9g=
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com (52.134.66.158) by
 DB3PR0202MB3340.eurprd02.prod.outlook.com (52.134.67.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Mon, 26 Aug 2019 19:59:02 +0000
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::a0df:d7d9:f95e:f3ea]) by DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::a0df:d7d9:f95e:f3ea%3]) with mapi id 15.20.2178.023; Mon, 26 Aug 2019
 19:59:02 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 3/3] fbdev: fbmem: avoid exporting fb_center_logo
Thread-Topic: [PATCH v2 3/3] fbdev: fbmem: avoid exporting fb_center_logo
Thread-Index: AQHVXEi1s/RzebcL0EaG+mipfctuhg==
Date:   Mon, 26 Aug 2019 19:59:02 +0000
Message-ID: <20190826195740.29415-4-peda@axentia.se>
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
x-ms-office365-filtering-correlation-id: 8dd4ea91-4e4a-483b-546f-08d72a5fd789
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB3PR0202MB3340;
x-ms-traffictypediagnostic: DB3PR0202MB3340:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0202MB3340961782A9046222A5BFDFBCA10@DB3PR0202MB3340.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39830400003)(136003)(189003)(199004)(8936002)(256004)(316002)(54906003)(26005)(476003)(2616005)(99286004)(102836004)(76176011)(386003)(6506007)(4744005)(66066001)(52116002)(5640700003)(508600001)(186003)(6436002)(486006)(66946007)(66476007)(66446008)(36756003)(64756008)(66556008)(2351001)(1076003)(6486002)(6916009)(2906002)(50226002)(86362001)(71200400001)(71190400001)(2501003)(53936002)(6512007)(4326008)(25786009)(11346002)(446003)(3846002)(6116002)(305945005)(14454004)(81156014)(81166006)(14444005)(5660300002)(7736002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB3PR0202MB3340;H:DB3PR0202MB3434.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vNp2caZncq4smv0/uWsmT+TZHCmJebTsosLmLCEs0zS7ME7nqAs3ldx52jjWPdFwIH5RPu0x1LfEpEgzrL0LKjXX+BF5Lk8mtxaYg6VI+gXS8vK374uV4N34SY0+cUCOfruKHs99+DiuYUG0oiXMmjAnoM4E8lbGEg0EqDen6K77/1GdtSg+io0x/EsyJ1u2zACiaFyNGUAkbcWTxfLCYDx5RIoiT2qblTnVgz8DjNm2kIgEJ8oZyXpPWG5Ka87sfQwtfOXea+8qkWyzbFduVHVR9C/aj4vJwa8udcqrs1gs0keHdLGXAYlFtcAMhk573DQZsFsqWxlsgGB9H8jn4+QaX28JoLdfGiCawHhFm/Zw9hAMAIw5tEfYJbjcjqs+eOXUBjm+bSc6lZ2AeCLazvip2VANuh0WPVexx9gVeHI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd4ea91-4e4a-483b-546f-08d72a5fd789
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 19:59:02.5094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zCnlJx5ClcUIro4NIuPpWNtCl4f1jcwfY1daPzEgRUq03i5DwMr9Q1Tc7KIkCcAX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3340
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
index a7d8022db516..17e250a515b0 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -54,7 +54,6 @@ int num_registered_fb __read_mostly;
 EXPORT_SYMBOL(num_registered_fb);
=20
 bool fb_center_logo __read_mostly;
-EXPORT_SYMBOL(fb_center_logo);
=20
 unsigned int fb_logo_count __read_mostly;
=20
--=20
2.11.0

