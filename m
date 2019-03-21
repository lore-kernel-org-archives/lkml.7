Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AAAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A6C20850
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LTKS+zYT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbfCUJ5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:57:20 -0400
Received: from mail-eopbgr40045.outbound.protection.outlook.com ([40.107.4.45]:17445
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727892AbfCUJ5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBn/iF7VTRRmezzSQS3bRMxDxff+zcX2a29L8DxtxMQ=;
 b=LTKS+zYTV83QwYKPPsnXm3LlANHQffIJWe9qQQnWQXsDEInw1Sx4gK1DNeKykbR3Bo3hM85d1NaIQxmI6kR36JldsoZ9/d3TRqsAwzgVHHWXg4Niibz9vA5hpmPbaqE4PzVYzNXLh1d+2Z+r5TmdW6h+J5U2Wt5mExr16cpdV9k=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB5320.eurprd04.prod.outlook.com (20.177.36.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Thu, 21 Mar 2019 09:57:15 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::5841:afe:53fd:42bb]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::5841:afe:53fd:42bb%6]) with mapi id 15.20.1709.015; Thu, 21 Mar 2019
 09:57:14 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] spi: lpspi: fix dataloss when SS is inactivated between every
 words
Thread-Topic: [PATCH] spi: lpspi: fix dataloss when SS is inactivated between
 every words
Thread-Index: AQHU38x0W9tIzHKRmEaCu103SB08IA==
Date:   Thu, 21 Mar 2019 09:57:12 +0000
Message-ID: <20190321095720.14438-1-xiaoning.wang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2P274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::21)
 To AM6PR04MB5016.eurprd04.prod.outlook.com (2603:10a6:20b:9::24)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaoning.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 288100d5-c318-4dfe-fcf4-08d6ade39632
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5320;
x-ms-traffictypediagnostic: AM6PR04MB5320:
x-microsoft-antispam-prvs: <AM6PR04MB532031A5F1AFB6DAAEEDC8BEF3420@AM6PR04MB5320.eurprd04.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(366004)(376002)(39860400002)(199004)(189003)(106356001)(105586002)(386003)(14454004)(6506007)(52116002)(6436002)(6486002)(71190400001)(71200400001)(102836004)(2906002)(86362001)(14444005)(256004)(26005)(186003)(478600001)(3846002)(6116002)(1076003)(476003)(50226002)(53936002)(5660300002)(8676002)(1730700003)(6512007)(99286004)(486006)(305945005)(66066001)(7736002)(97736004)(316002)(4326008)(2616005)(2351001)(81166006)(2501003)(81156014)(25786009)(36756003)(6916009)(8936002)(68736007)(5640700003)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5320;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:3;MX:3;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GYCAaa6/CWP1X9uQh/33oPY+FTnxZCD0xw15zfYGdtqpQ95fK3eb2OYL0q1ucigEXthD07Hz1w8U7gMSqrotTM/SGrdqnClPdtC6wrz/HwHrDP9VaMpDfi/Fha4BzD+oIvtDOQJQy537vgUoNS//0L4gCqspBQYonMMNDl8h4d3FXGJw4eoiyXkmAONZAhWhXwmbisJz6vabtqPI55mpyUAgs1bhINNHedzhqz5wzNH/oBsiIvAH28vFrGogFeKw0O1IDEe6PbwG1zSe8s75Zi1gxnSLzMNI07ZNr1Pi5JqzEvqRydKcl7qN/MNkURRIlVfASPCw92QUfLqcIh1k5NIl7AdLPrChTJH868BkSt+r5YSnlPVADDijPc+aM042kUxr3sYeXCU4rs1/p5dYKDT5F9CRuLOMOkAX5EEl7UE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 288100d5-c318-4dfe-fcf4-08d6ade39632
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 09:57:14.7066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5320
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we don't use CONT to keep SS activated or use DMA mode without
cs-gpio, SS will be inactivated between every words. The word here
means the data sent once which length can be set as 1/2/4 bytes.

In the isr function, we read the FSR_RXCOUNT just behind the
fsl_lpspi_read_rx_fifo. This causes the value of FSR_RXCOUNT cannot
reflect whether there is still data not sent timely. So do this
judgement by FSR_TXCOUNT.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 4de8eb378752..0252cae0b35b 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -77,7 +77,7 @@
 #define CFGR1_PCSPOL	BIT(8)
 #define CFGR1_NOSTALL	BIT(3)
 #define CFGR1_MASTER	BIT(0)
-#define FSR_RXCOUNT	(BIT(16)|BIT(17)|BIT(18))
+#define FSR_TXCOUNT	(0xFF)
 #define RSR_RXEMPTY	BIT(1)
 #define TCR_CPOL	BIT(31)
 #define TCR_CPHA	BIT(30)
@@ -765,7 +765,7 @@ static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id)
 	}
=20
 	if (temp_SR & SR_MBF ||
-	    readl(fsl_lpspi->base + IMX7ULP_FSR) & FSR_RXCOUNT) {
+	    readl(fsl_lpspi->base + IMX7ULP_FSR) & FSR_TXCOUNT) {
 		writel(SR_FCF, fsl_lpspi->base + IMX7ULP_SR);
 		fsl_lpspi_intctrl(fsl_lpspi, IER_FCIE);
 		return IRQ_HANDLED;
--=20
2.17.1

