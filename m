Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135FEC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDCC020833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gE6amvM9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfDIIfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:35:37 -0400
Received: from mail-eopbgr50062.outbound.protection.outlook.com ([40.107.5.62]:51458
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726001AbfDIIfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 04:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKyQOYskVdxn8N+6HX2swIrTYpzXXWn5AcjdjOOkKnw=;
 b=gE6amvM93XkGVbbq4VbCWf/6CeWEuw7kmDIqraswc75GnBT/UgfmpjlRtA3IaRiNzB8vl4Th3nrDQs44Sn0LIrNgXZdJm6lnG4OT5JtDhKNE88ewyQw0X8kBKfky2iufKcHwMCj8McJmZ4lp+gstjQceFxw4wxstLE7WM0KhkPs=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB3982.eurprd04.prod.outlook.com (10.171.182.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.21; Tue, 9 Apr 2019 08:35:33 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888%3]) with mapi id 15.20.1792.009; Tue, 9 Apr 2019
 08:35:33 +0000
From:   Viorel Suman <viorel.suman@nxp.com>
To:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Julia Lawall <Julia.Lawall@lip6.fr>
CC:     Viorel Suman <viorel.suman@nxp.com>,
        Viorel Suman <viorel.suman@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/2] ASoC: fsl: audmix: fix two issues
Thread-Topic: [PATCH 0/2] ASoC: fsl: audmix: fix two issues
Thread-Index: AQHU7q8yBr+pG49UL0OPQueKZODeUg==
Date:   Tue, 9 Apr 2019 08:35:32 +0000
Message-ID: <1554798876-20653-1-git-send-email-viorel.suman@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VE1PR03CA0004.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::16) To VI1PR04MB4704.eurprd04.prod.outlook.com
 (2603:10a6:803:52::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b2182f4-5062-4b63-114e-08d6bcc65480
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB3982;
x-ms-traffictypediagnostic: VI1PR04MB3982:
x-microsoft-antispam-prvs: <VI1PR04MB3982E344FAEDC6F8836B356B922D0@VI1PR04MB3982.eurprd04.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(376002)(346002)(39860400002)(199004)(189003)(6512007)(8936002)(97736004)(486006)(8676002)(7416002)(81166006)(476003)(305945005)(53936002)(68736007)(7736002)(50226002)(6436002)(66066001)(86362001)(2616005)(316002)(6486002)(14454004)(36756003)(4326008)(2906002)(54906003)(106356001)(110136005)(71190400001)(105586002)(5660300002)(71200400001)(44832011)(186003)(6116002)(25786009)(3846002)(256004)(102836004)(26005)(52116002)(4744005)(99286004)(6506007)(386003)(81156014)(478600001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3982;H:VI1PR04MB4704.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: c2D23PYke54pRJQJKgzEcxuQpvLIvyzaE0g4rITX9DTedSNQeB5T/oUz35kgLAuYKjhGAvW6afNp3gmW9nkC+0DUSuOG71Ke5VwoyavUyGWzPfmUDIwS7zeEFU2FWws/MAAQD7hZNRGaNi60/R7jumb1v/Nq/Wwo08ZFEJcdOO1ZW5MWG+kAzepBNnbxk7mKD2giaEAVOEiCn4RaU11xHGTeSmn9MBQIdZ544/61d5K6Uye1mgBQclmuH4JG9Ln3B/sdlvbMYjvyXShBH2KQOPahTqisLexX+w6PNLZ4vK4itjA+R57Zo/NlD+j/J4R/+nDapTSqtYZhRKYGICo6YDffW+i3z7LwdDxzPJKdi5hJy9JAjnzbuTN3s5leD5jHGzIIxDXu4PRrvwAO3akqToSVqHfWZB5mOuNRELJ8Pls=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2182f4-5062-4b63-114e-08d6bcc65480
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 08:35:33.0232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3982
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGxhdGVzdCBhdWRtaXggcGF0Y2gtc2V0ICh2NSkgaGFkIHRoZSAibW9kZWwiIGF0dHJpYnV0
ZQ0KcmVtb3ZlZCBhcyByZXF1ZXN0ZWQgYnkgTmljb2xpbiBDaGVuLCBidXQgbG9va3MgbGlrZSAo
djQpDQp2ZXJzaW9uIG9mIERBSSBkcml2ZXIgcmVhY2hlZCAiZm9yLW5leHQiIGJyYW5jaCAtIGZp
eCB0aGlzLg0KQXNzaWRlIG9mIHRoaXMgZml4IG9iamVjdCByZWZlcmVuY2UgbGVha3MgaW4gbWFj
aGluZSBwcm9iZSByZXBvcnRlZA0KYnkgSnVsaWEgTGF3YWxsLg0KDQpWaW9yZWwgU3VtYW4gKDIp
Og0KICBBU29DOiBmc2xfYXVkbWl4OiByZW1vdmUgIm1vZGVsIiBhdHRyaWJ1dGUNCiAgQVNvQzog
aW14LWF1ZG1peDogZml4IG9iamVjdCByZWZlcmVuY2UgbGVha3MgaW4gcHJvYmUNCg0KIHNvdW5k
L3NvYy9mc2wvZnNsX2F1ZG1peC5jIHwgNjEgKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KIHNvdW5kL3NvYy9mc2wvaW14LWF1ZG1peC5jIHwgMzEgKysrKysr
KysrLS0tLS0tLS0tLS0tLS0NCiAyIGZpbGVzIGNoYW5nZWQsIDQzIGluc2VydGlvbnMoKyksIDQ5
IGRlbGV0aW9ucygtKQ0KDQotLSANCjIuNy40DQoNCg==
