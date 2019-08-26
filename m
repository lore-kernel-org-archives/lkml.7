Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35280C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 19:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52AE2184D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 19:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="IsmC8/Rz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387891AbfHZT6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 15:58:55 -0400
Received: from mail-eopbgr70118.outbound.protection.outlook.com ([40.107.7.118]:6592
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727504AbfHZT6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 15:58:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNfUCV95ETOWVzhCJnZRuV0/KiW6ePcs8w9GQ1pTe2XMm9rirG4ZqpwTm00rqju0OoFHxqIzcMwITvPs2U3JyxXppvIDJ674xXtTnWfMmJXOhrGeNzFV2NHIJAri0L5B5wLCqf3tq830H/Bqh+De9p7J19xr7X76zaNK91YcXJrOpYvj6kFGzkD4r4qy0YEG/LxoQV9/fFYWy7qqtcPTBNDpH5kImifDopWn5H4Ltd5doFr0gSFMKtsiF3v3y91KWLHBZBq0p1qZ+R9OpZ605fiRsKNmj1GBGSWYO3rfAbKeU3NU0Xyb/Y27wDuCLwnnw1ZPzxSB0pKJkxFkXYeAVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMeM0C91Pv4VBt3O65TdvV1hEoXv618AVnADCtf63yM=;
 b=ZhGGzmvMFQhR6M1kL5nNdSD9poVFEZyPpxRNJTrnCQoxy2Q9y3Eqo0zLLP4Vn3qVvVRmfXU8ldHL65c7VPMeDAYO/k17omR5Pb4o5uTJFeNapd/+FCSbTOqwWeu2EOWOZM2cKQMvRHOy1tyGSq5oSGm9LGqhDGZXFBJ5DweBUFuqBTkzZDbPhenhsLqpYktpOljBmdnGU8HbHnLj+Jxitgw5EWrS99obkRGWv7vFsi6vlQhfNEy1h3agxm6DEJ+OdKSm4iZmHhYJGzvNKzh6AEgV9EAz8dusE5MXYeOujosehj76JVuv/Jb9Tk/ajExC9sCZtoIhRaCQm2ktm6LLHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMeM0C91Pv4VBt3O65TdvV1hEoXv618AVnADCtf63yM=;
 b=IsmC8/RzhQAoZfUSkH8S3WqCI24mqJeWfpzvsLbYGif3pwFR399eLyPM8noh36poete/h3+dJQQrUip7KBa5WFHohNedjsWX4lUcwdWo7wIzJsOmBTPzg8xNCy/tcxuOqP2Dg4+QLzrEglICVnKnymXDG58mnApW7QdcLSEZIoQ=
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com (52.134.66.158) by
 DB3PR0202MB3340.eurprd02.prod.outlook.com (52.134.67.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Mon, 26 Aug 2019 19:58:49 +0000
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::a0df:d7d9:f95e:f3ea]) by DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::a0df:d7d9:f95e:f3ea%3]) with mapi id 15.20.2178.023; Mon, 26 Aug 2019
 19:58:49 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 0/3] Add possibility to specify the number of displayed
 logos
Thread-Topic: [PATCH v2 0/3] Add possibility to specify the number of
 displayed logos
Thread-Index: AQHVXEittl9d6/zAz0iinWdXxueGTA==
Date:   Mon, 26 Aug 2019 19:58:49 +0000
Message-ID: <20190826195740.29415-1-peda@axentia.se>
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
x-ms-office365-filtering-correlation-id: 7bb67bbf-f294-4f80-9bd0-08d72a5fcfa7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB3PR0202MB3340;
x-ms-traffictypediagnostic: DB3PR0202MB3340:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0202MB3340F6895D68348E7EB6875EBCA10@DB3PR0202MB3340.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39830400003)(136003)(189003)(199004)(8936002)(256004)(316002)(54906003)(26005)(476003)(2616005)(99286004)(102836004)(386003)(6506007)(4744005)(66066001)(52116002)(5640700003)(508600001)(186003)(6436002)(486006)(66946007)(66476007)(66446008)(36756003)(64756008)(66556008)(2351001)(1076003)(6486002)(6916009)(2906002)(50226002)(86362001)(71200400001)(71190400001)(2501003)(53936002)(6512007)(4326008)(25786009)(3846002)(6116002)(305945005)(14454004)(81156014)(81166006)(14444005)(5660300002)(7736002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB3PR0202MB3340;H:DB3PR0202MB3434.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: b2mMQfEXBY1lAbxpM7TADQmq+KCYL6SUfURiTkogsgnsOx+6CopdsJCx0KPPngX3lFaY6ZWlLABbnx+j385v/oXkazbKjxZ0KmvpSRjBLR20/wPQ2jwbBAmr+0dH94Kr1DN6gWsxxcHPKtCgLtDyv/msotdXN0DVIKNohhMmzCTmDXR1qeCM1nttl2cC/+1qq0nNB8FOQAbb41xHpZ/Cf/63CFZK4JErEAEsc/Mk/wMfUg3vWPUW3RWc7/jOb/bKjXGkB7tTsaPA8NKAc45m1WVNTbPfo6oUy9155hgeaMr9HlUx6VBVrH8J7XHEo/Arvo85XmxAl72dUY0rbhx2L/1e5vtg4Al1eppmAheTKNi/xuEKX/DTLHCJQyy10dMyoGmTN0fkDOtUon1w5OViFFOFNc/1LGZflQWemsfAbOU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb67bbf-f294-4f80-9bd0-08d72a5fcfa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 19:58:49.5399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UJYYvQsJFtCR2z7mYeLY9eLESvEEZio4MsSK5WjGJtcOpkwh9gyMI7ITo94ElfRP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3340
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
 drivers/video/fbdev/core/fbmem.c |  5 +++--
 include/linux/fb.h               |  1 +
 4 files changed, 20 insertions(+), 6 deletions(-)

--=20
2.11.0

