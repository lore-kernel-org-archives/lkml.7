Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79333C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4538220651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="RKpGRNWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbfC0Oax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:30:53 -0400
Received: from mail-eopbgr50133.outbound.protection.outlook.com ([40.107.5.133]:29441
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727709AbfC0Oaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUe5IqCyYvM7ecV4KrrXwKik4tMBZo9tHc76+gldgu0=;
 b=RKpGRNWdkVTmRuYaSMs6JOv8VKaCCXIGiBXQsIdXpfQWokgeoLIVz6E6arHlS0UWn8Qe4cbzk1nzzDrU6bAxz935mxmLT4N0w/QI1GwrbytEawibOdUKVMagqmyGo/YrtwuY5PBqggStCxGRTEqtrMCMkWegYoBkSMA63ji+QKY=
Received: from AM6PR10MB2661.EURPRD10.PROD.OUTLOOK.COM (20.179.1.31) by
 AM6PR10MB1894.EURPRD10.PROD.OUTLOOK.COM (52.134.117.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Wed, 27 Mar 2019 14:30:49 +0000
Received: from AM6PR10MB2661.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a442:a35b:115a:ef14]) by AM6PR10MB2661.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a442:a35b:115a:ef14%2]) with mapi id 15.20.1750.014; Wed, 27 Mar 2019
 14:30:49 +0000
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
Subject: [RFC PATCH 0/4] spi: spi-fsl-spi: try to make cpu-mode transfers
 faster
Thread-Topic: [RFC PATCH 0/4] spi: spi-fsl-spi: try to make cpu-mode transfers
 faster
Thread-Index: AQHU5KmsQtL43pgBMESWjpaISK6vdw==
Date:   Wed, 27 Mar 2019 14:30:48 +0000
Message-ID: <20190327143040.16013-1-rasmus.villemoes@prevas.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0055.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::44) To AM6PR10MB2661.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:a5::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [81.216.59.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97ae7a9c-7397-4c57-9128-08d6b2c0ce6a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR10MB1894;
x-ms-traffictypediagnostic: AM6PR10MB1894:
x-microsoft-antispam-prvs: <AM6PR10MB18940C0E0D1ECF21BF314D038A580@AM6PR10MB1894.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(376002)(366004)(346002)(396003)(136003)(199004)(189003)(99286004)(72206003)(74482002)(66066001)(2501003)(14454004)(44832011)(6512007)(25786009)(256004)(5660300002)(53936002)(107886003)(7736002)(4326008)(305945005)(478600001)(6486002)(105586002)(106356001)(81166006)(8676002)(81156014)(68736007)(42882007)(54906003)(110136005)(71200400001)(102836004)(8976002)(50226002)(8936002)(186003)(26005)(6506007)(386003)(2906002)(36756003)(97736004)(71190400001)(4744005)(6436002)(3846002)(6116002)(1076003)(52116002)(2616005)(316002)(486006)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR10MB1894;H:AM6PR10MB2661.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uia328C7+akDUwReJmMek8UkFdcKEus/jp2IdwDM2qabd0Zfh2xVNiYtVNTeNApQNXZVFuXRifSG1rinDhY6QcNQ3uUnyxfwPUvmFqnD4v6ih16ZYm/PczIexz7WEEd+OmdXHWFb6XM+DEaNEX83TYmJr1wquf2W7tHp55fCHNd3WdimU+LwmaiIjvWfYk4ytDVeIyTDOmEcPH6ffkyPFe/ajXXmShdJM3U+C4PnXzUocHRPgVsgBg2rpacGDy9TthLxPTW+RAyLAarTvctioCiPKzcggjEE3cGjjF8w576wuCqKibUgj3sMH+NNBvalQI1SXFqN5r78F5TPrhr55vCeK/8Cm5H+IKF2BtVAJExvucbALfvlkpGkXB6nr98dOHq+TodgUzXCC492eNSKpHBA+GgyXSqG0WRFkFORNNI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ae7a9c-7397-4c57-9128-08d6b2c0ce6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 14:30:49.0232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB1894
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I doubt patches 3 and 4 are acceptable, but I'd still like to get
comments and/or alternative suggestions for making large transfers
faster.

The patches have been tested on an MPC8309 with a Cypress S25FL032P
spi-nor slave, and make various operations between 50% and 73%
faster.

We have not observed any problems, but to completely rule out the
possibility of "glitches on SPI CLK" mentioned in patch 3 would of
course require testing on a much wider set of hardware combinations.

Rasmus Villemoes (4):
  spi: spi-fsl-spi: remove always-true conditional in fsl_spi_do_one_msg
  spi: spi-fsl-spi: relax message sanity checking a little
  spi: spi-fsl-spi: allow changing bits_per_word while CS is still
    active
  spi: spi-fsl-spi: automatically adapt bits-per-word in cpu mode

 drivers/spi/spi-fsl-spi.c | 41 +++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

--=20
2.20.1

