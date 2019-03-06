Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B700DC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9DB206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oHBfH+mj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbfCFGbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 01:31:15 -0500
Received: from mail-eopbgr50089.outbound.protection.outlook.com ([40.107.5.89]:43681
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729000AbfCFGaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 01:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+IVxQPrefSbya8gbOMGStjGMWB28FqD40Gw/UQgXL0=;
 b=oHBfH+mjzHrBDejelcC5Z0u400alHB9bZbUjoq6hXduzlfDsRf1opryT97Vy6OHdkkeYrUbBt8XrXk91bBpZOW7/2rL7i9Ey/OTrCa+jxxkZJJYrB+tch9HuNCMMIeCIU4EXT/FNMq2WFbsBc8JwU8gu9dZUu2HNXjA8ojGQJ/A=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB4373.eurprd04.prod.outlook.com (20.177.38.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Wed, 6 Mar 2019 06:30:41 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::5841:afe:53fd:42bb]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::5841:afe:53fd:42bb%6]) with mapi id 15.20.1665.020; Wed, 6 Mar 2019
 06:30:41 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 4/8] spi: lpspi: add the error info of transfer speed
 setting
Thread-Topic: [PATCH V2 4/8] spi: lpspi: add the error info of transfer speed
 setting
Thread-Index: AQHU0+YeeShjZYAheEKu2sFsXPOkAQ==
Date:   Wed, 6 Mar 2019 06:30:41 +0000
Message-ID: <20190306063020.793-5-xiaoning.wang@nxp.com>
References: <20190306063020.793-1-xiaoning.wang@nxp.com>
In-Reply-To: <20190306063020.793-1-xiaoning.wang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:3:18::17) To AM6PR04MB5016.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::24)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaoning.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 741b5e45-65db-4368-97ae-08d6a1fd40df
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4373;
x-ms-traffictypediagnostic: AM6PR04MB4373:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB4373;23:gEiSB44yjMG9JBryVSepKWMP2etbF6mc1IezGkf?=
 =?iso-8859-1?Q?7jC5N5urn76mph30iqSySqcbd0zI2UW22uaRf+c/uY+mCIw0+LWyR7GxZp?=
 =?iso-8859-1?Q?Ucfv2obsJMizmGBmbyKe35KrmZEZzb1bTDWNPzE4uUT8Lz33iIDr1Asfnz?=
 =?iso-8859-1?Q?A5IyXVU7jmOJqBK49XUK0zMVV9H2lzhH138B+4L7sMZFajSEw35HV2VHBi?=
 =?iso-8859-1?Q?eVxZbO8IDzgkLWnuyRytWqMCh0qF9okaOrZFO9EvQzq9YKcZ0DRmj6Usvx?=
 =?iso-8859-1?Q?baezosrWYRetqG9jGuk0iadSSwyuDqDfrY3pHFNAoG+XnXYxgS3UouXR+h?=
 =?iso-8859-1?Q?PTIqatxIRrEd1BPjoR17PlIDPwI4Vxw7ljA/I0eRvRgZHCVykC9UpLBuv1?=
 =?iso-8859-1?Q?nkGdJSt3rk48hNxK/tnEHMzfEAf1khVdcR7q9PNRsKHg2HyxBAy8OT1jFB?=
 =?iso-8859-1?Q?C6ag1Ergk25pqgdFIfvBgWE++vwkzy/t9bXv6019ofaLUehMOBgTukX6HZ?=
 =?iso-8859-1?Q?xwFLs3QbqOBy3m1L9bMpAyx6BD2CpIhSJRNHZgDeFNv7BOxD71G58JdaXP?=
 =?iso-8859-1?Q?Eejfh4duc0eknseA8WhrcYJWuDoKgVsOhAeaNsi2MLwJdn2LsPMVPoHils?=
 =?iso-8859-1?Q?m4Fwnb3UPdagnCyFrRvdCgn3s/8/TlebKx9wetiHv5ZecO5bvHsAHJbGyM?=
 =?iso-8859-1?Q?b1nROXlW4y/bofczYMT+wwkp0qs85ekL5PtmJMJHID56bytwhWZ5u1kyaS?=
 =?iso-8859-1?Q?pw1A7xBpzfZmEFy+s3gJfcQYZQzF3/U39GtHN5W5IWQC5nusZUfyM6mb3Y?=
 =?iso-8859-1?Q?AohSVjEVlW7mULd6WQhzA7f6L962x88PXBCBT/1/zaXHMvbf5KPltFcbJ9?=
 =?iso-8859-1?Q?cc0vr5LeoTnJEVSqGiPM4coguJJONiB2b8VMmsLMp2i5eSwFkcpcrUHjCK?=
 =?iso-8859-1?Q?0NGhVZcQk8wtAruHr8b2AcHSwPWUinppJJikVa2zl4HVpzPrqww6JquNzO?=
 =?iso-8859-1?Q?S8eCdLJagbchjTL+dFOKjOvMFupw3xlTaB6G6nmyLC0XxucxRJS0egPAXl?=
 =?iso-8859-1?Q?4jv+D4FK6hwueqN05yTvT9AI3zGhxXsD1pf+y0wuThkOYPcGJ8n5bGfWFr?=
 =?iso-8859-1?Q?eJ0T7BE4fEW9qfi+fLuLxEQwsA2vzD2HyGM8q86QDZcxzDeBth5xZVMxww?=
 =?iso-8859-1?Q?7HG9cPlzQOiJww2xksxA+iYV+/iQElx1J6GE2/nJalmFREnDDWLnvL9u3+?=
 =?iso-8859-1?Q?J90QGcHlDcqa1aRSQ7sf0MNDqLtTYnGgechCUyDiy6SuSAf2qxXCZ+iiWY?=
 =?iso-8859-1?Q?Vk7YuKKFNko/eo18/vSwSL/YWlVDuHuxvUInDPGG1IUDA=3D=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB43739530199DB3399263E037F3730@AM6PR04MB4373.eurprd04.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(366004)(39860400002)(396003)(199004)(189003)(97736004)(6116002)(386003)(8936002)(6506007)(106356001)(52116002)(1730700003)(8676002)(26005)(81156014)(81166006)(256004)(105586002)(102836004)(50226002)(2501003)(76176011)(99286004)(6512007)(305945005)(71200400001)(6436002)(5640700003)(6486002)(4326008)(53936002)(71190400001)(476003)(25786009)(486006)(66066001)(2616005)(7736002)(186003)(68736007)(446003)(1076003)(11346002)(54906003)(478600001)(316002)(36756003)(6916009)(2351001)(14454004)(86362001)(2906002)(5660300002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4373;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6PUsKQdyjpJcQASfQcPIuwy7JdZeafkBfy+AJbyUMDKn4gryVibM4dpOx2GN4ikAIBvDDyuk11WPDa0Gj2cJZzCCyScFf69KDMzrRQHKB3HXnBMbYGYQTP0XKVkjLd6jdrgxUvUEakxDzThjUK4lcmwZiantWDzbMhzYgu2d4U4o0rjNe427kp5BaAXKwMH+iD3XViCs8oVIUzN+yEndb823uvEdD9ivdNwZ42pxMjN9GlPAB70VjrL5h4n75bpZlF1/sc/VVgE5/x99cZG+ju6u0Kuwxkj2P+OiYM7F+PRj7TFsI0z6cKEbC5+RV+s3nEGtQA48Jw/T/Z73qQGpchGX7s9ZucL9ssHjV8Oz4yG9YIFQZ5eAl/WXChRiRPPoM9mmeI+0Kwvnh4dL0oMfn2iiWdO/BmKUeEoCk7DIdKY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 741b5e45-65db-4368-97ae-08d6a1fd40df
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 06:30:41.0799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4373
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a error info when set a speed which greater than half of per-clk of
spi module.

The minimum SCK period is 2 cycles(CCR[SCKDIV]). So the maximum transfer
speed is half of spi per-clk.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
V2:
 - No change. Resend for applying.
---
 drivers/spi/spi-fsl-lpspi.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 84dcb9e176b8..69635cde0e22 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -255,6 +255,13 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data=
 *fsl_lpspi)
 	u8 prescale;
=20
 	perclk_rate =3D clk_get_rate(fsl_lpspi->clk_per);
+
+	if (config.speed_hz > perclk_rate / 2) {
+		dev_err(fsl_lpspi->dev,
+		      "per-clk should be at least two times of transfer speed");
+		return -EINVAL;
+	}
+
 	for (prescale =3D 0; prescale < 8; prescale++) {
 		scldiv =3D perclk_rate /
 			 (clkdivs[prescale] * config.speed_hz) - 2;
@@ -304,7 +311,7 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_=
lpspi)
 	return 0;
 }
=20
-static void fsl_lpspi_setup_transfer(struct spi_device *spi,
+static int fsl_lpspi_setup_transfer(struct spi_device *spi,
 				     struct spi_transfer *t)
 {
 	struct fsl_lpspi_data *fsl_lpspi =3D
@@ -337,7 +344,7 @@ static void fsl_lpspi_setup_transfer(struct spi_device =
*spi,
 	else
 		fsl_lpspi->watermark =3D fsl_lpspi->txfifosize;
=20
-	fsl_lpspi_config(fsl_lpspi);
+	return fsl_lpspi_config(fsl_lpspi);
 }
=20
 static int fsl_lpspi_slave_abort(struct spi_controller *controller)
@@ -429,7 +436,10 @@ static int fsl_lpspi_transfer_one_msg(struct spi_contr=
oller *controller,
 	msg->actual_length =3D 0;
=20
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
-		fsl_lpspi_setup_transfer(spi, xfer);
+		ret =3D fsl_lpspi_setup_transfer(spi, xfer);
+		if (ret < 0)
+			goto complete;
+
 		fsl_lpspi_set_cmd(fsl_lpspi, is_first_xfer);
=20
 		is_first_xfer =3D false;
--=20
2.17.1

