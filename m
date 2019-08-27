Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108EBC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 11:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47F4206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 11:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="WSPzSS36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbfH0LJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 07:09:18 -0400
Received: from mail-eopbgr10093.outbound.protection.outlook.com ([40.107.1.93]:44093
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725912AbfH0LJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 07:09:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAV6j1SjBj1Ycdlvo96H8/tpxsFmU3MIY8rapajZdeW0HAbJ/E5WQch7MfXdOvLWeWuDIBBp9GRZD19lNmA8y09P3fMS3YCxGD/2CBstLsAvhpDzZpQfJ/MxRMexPmM87AnV8taEMj1NJxpQBa/j6gmWW+6y17SdFCjz0YZlsRfCxuP+4+/iV2YJ8nOMxezIiqEbwvmYgbLBeHaBNpU71k0mUQgUXW/cchZpjJLu6wJ3pGLnXGPz6Dw+pcx0XDGysHd7SSKH8Y6jJHSpm0c+NZIRVB1tXe3kCqaTpE5jrpHcxaa5aY+l4QwK2EjCF0qs9Q+GBerXIaIWycyiBQSjZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYo8sJBv8YM1g/V/cokURBHRLd8P6275YpESc1rKdIE=;
 b=YN+AkrztSL73oWy3BiefA4vEHHf056HG2ag9RGln+ZvkdGdlwC8i6sJErwkR76550WfQnIpaZXisbc0e0tqT8a1xOKWWA6gsi70lu/RG0/rnHUTaZNnjRkkU9Gn/Y8n5WC8EF+P7qq5qti5KNgechhXXtiRmZaYElHtCI27SJ6xGCcKNzJKeuBIQCChBx43eLNvENv9RneVquSk6S6zNk0lkBwBD2o71bKddRIoVuIeDg/JiLdGo8YURNiIsPy2N4o/8zAgERQwMmeaS7ZHW3x3zl/ADmxzMczTirELnNfo0TOROVrvJ+pmSFYssZFJf+lzKMQRNJoPtbgn8jbyUXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYo8sJBv8YM1g/V/cokURBHRLd8P6275YpESc1rKdIE=;
 b=WSPzSS36WfpmG9pSQkJjcW7L7DVCYUCLqEQJEQaxf2XNpuLEa15RMIrAtjj5SDC9iwbAh+XxhwCl1tHe7IkZCKKQSEHGI/8LIIzTHhzlnw/g6/OnkA08IiCazI2qTzWVocaNHawyvZWOlsIlNrJHe1BF2Mwht2/fTo6RAr1LPLQ=
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com (52.134.66.158) by
 DB3PR0202MB3420.eurprd02.prod.outlook.com (52.134.67.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 27 Aug 2019 11:09:11 +0000
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::a0df:d7d9:f95e:f3ea]) by DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::a0df:d7d9:f95e:f3ea%3]) with mapi id 15.20.2178.023; Tue, 27 Aug 2019
 11:09:11 +0000
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
Subject: [PATCH v3 0/3] Add possibility to specify the number of displayed
 logos
Thread-Topic: [PATCH v3 0/3] Add possibility to specify the number of
 displayed logos
Thread-Index: AQHVXMfaisPyvC57MUmljkwoBL1ZPA==
Date:   Tue, 27 Aug 2019 11:09:11 +0000
Message-ID: <20190827110854.12574-1-peda@axentia.se>
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
x-ms-office365-filtering-correlation-id: 99923712-40e9-4990-a6e9-08d72adefce1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB3PR0202MB3420;
x-ms-traffictypediagnostic: DB3PR0202MB3420:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0202MB3420B6F0E4C07C5C98684127BCA00@DB3PR0202MB3420.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(39830400003)(396003)(376002)(199004)(189003)(3846002)(50226002)(2906002)(81156014)(6436002)(81166006)(4326008)(8936002)(6116002)(36756003)(66446008)(186003)(26005)(53936002)(256004)(5640700003)(99286004)(52116002)(6506007)(102836004)(25786009)(6512007)(14444005)(386003)(66476007)(66556008)(1076003)(4744005)(8676002)(5660300002)(6486002)(86362001)(14454004)(305945005)(7736002)(316002)(66066001)(64756008)(66946007)(2351001)(508600001)(2501003)(71190400001)(476003)(71200400001)(6916009)(486006)(2616005)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB3PR0202MB3420;H:DB3PR0202MB3434.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nRINbDps++ALpDsPj3Vwaw1+WA7BKtcp34LG2dynwYdq0Y9KAckr8P8xvxjNT6GETPbs0D0W6QTcY+3GDTO5EQH0guSSPGUaP3a0ogBeA/TFnJVZYGg0zL7Qao+iRQnHOCvRWJcF9yA9G1O9IiDZN+bx75sLms0awoQKxSLDW9NZzZckEpE8PfhOqFCiWrkuH8bkQrDeGojozum/tKuZtf6v7Y0DEmWSF28G7vDsd3tQjY1/oHbzCaxWk/uOFmV4jtGWRdqgOQXEo8b44lEr8iW/INkNuPtk6hJ4IpB1Fp3DvmRmG5XtvgFwIft+rqiW8RAY3UtxmmgdXCjIQi8FiTY74XDRgxRxZbKqdDzbuH6J1I2A34tX7yU1wFEDi4J0TprVIPLhXhM82djFcycJc3f9cwDXeYldrt4FsbdIV/Y=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 99923712-40e9-4990-a6e9-08d72adefce1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 11:09:11.6014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NHu3a5FVn7pFm7hTAjPCOlYZngF/4sZ7jk3F7z7jAo57OHlr3UuWTYw5Zb0nh78x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3420
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The first patch fixes the fact that there are two items numbered "4" in
the list of fbcon options. This bug is a teenager...

The second patch extends that list with a new option that allows the
user to display any number of logos (that fits on the screen). I need it
to limit the display to only one logo instead of one for each CPU core.

Changes since v2

- make -1 the default and make 0 disable the logo [Geert Uytterhoeven]
- cpu -> CPU

Changes since v1

- do not needlessly export fb_logo_count [Matthew Wilcox]
- added patch 3/3, which removes the export of fb_center_logo

Cheers,
Peter

Peter Rosin (3):
  fbdev: fix numbering of fbcon options
  fbdev: fbmem: allow overriding the number of bootup logos
  fbdev: fbmem: avoid exporting fb_center_logo

 Documentation/fb/fbcon.rst       | 13 +++++++++----
 drivers/video/fbdev/core/fbcon.c |  7 +++++++
 drivers/video/fbdev/core/fbmem.c | 13 +++++++++----
 include/linux/fb.h               |  1 +
 4 files changed, 26 insertions(+), 8 deletions(-)

--=20
2.11.0

