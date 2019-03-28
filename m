Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFA7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE20B2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="d0cWERMf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfC1LTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 07:19:49 -0400
Received: from mail-eopbgr10120.outbound.protection.outlook.com ([40.107.1.120]:50429
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725779AbfC1LTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 07:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Te6jmVC9nXVJiHTUVQHLK6IYUPBIDnb4aGXcE86/zw=;
 b=d0cWERMfJvkEHQzuWyZWB6AzhC1BZbxL94+AbkSjsPywocH+/NmDkJCMGfvn95bD/0ipJhJtFSBy/QAkKSGzat0kxDxPEId42qmkYeixjl/3DvzON/hDD0EpFO6gupo1paltnfntbp0+z6bj/aBj6tjfW0o4uKW+p6AZ6QjT9e0=
Received: from HE1PR07MB3337.eurprd07.prod.outlook.com (10.170.247.12) by
 HE1PR07MB3179.eurprd07.prod.outlook.com (10.170.245.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Thu, 28 Mar 2019 11:19:45 +0000
Received: from HE1PR07MB3337.eurprd07.prod.outlook.com
 ([fe80::cd23:d96f:5d94:cee6]) by HE1PR07MB3337.eurprd07.prod.outlook.com
 ([fe80::cd23:d96f:5d94:cee6%6]) with mapi id 15.20.1771.006; Thu, 28 Mar 2019
 11:19:45 +0000
From:   "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
Subject: [PATCH] axxia-i2c: use auto cmd for last message
Thread-Topic: [PATCH] axxia-i2c: use auto cmd for last message
Thread-Index: AQHU5VgluQk1IDQL20CnwTnxqmnvdw==
Date:   Thu, 28 Mar 2019 11:19:45 +0000
Message-ID: <20190328111858.GA17086@localhost.localdomain>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0502CA0003.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::13) To HE1PR07MB3337.eurprd07.prod.outlook.com
 (2603:10a6:7:2d::12)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [131.228.32.167]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 615dd99f-58e5-4304-7ac7-08d6b36f47ec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:HE1PR07MB3179;
x-ms-traffictypediagnostic: HE1PR07MB3179:
x-microsoft-antispam-prvs: <HE1PR07MB3179BE36C87EFF0ECF55D871EF590@HE1PR07MB3179.eurprd07.prod.outlook.com>
x-forefront-prvs: 0990C54589
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(136003)(346002)(376002)(189003)(199004)(316002)(71190400001)(4326008)(53936002)(52116002)(106356001)(107886003)(86362001)(8936002)(6916009)(66066001)(1076003)(81156014)(486006)(6486002)(61506002)(105586002)(6512007)(476003)(6506007)(6436002)(186003)(71200400001)(81166006)(386003)(8676002)(102836004)(26005)(9686003)(6346003)(7736002)(6116002)(15650500001)(3846002)(478600001)(14454004)(256004)(25786009)(5660300002)(68736007)(2906002)(14444005)(33656002)(97736004)(305945005)(54906003)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR07MB3179;H:HE1PR07MB3337.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=krzysztof.adamski@nokia.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /NL67O+C+vTjucg61zRESbdVfIwDdF5vVYDB9lOScDKOh94YhtxUhzjVmLR4I/oxqlHtIjnCbEzmzY+tP0uznbne0am781ibKts5Liim+lskad7QcHCFyPsPF5FN5AUwjYvPFHX3G0tjz/uDWslI0Ju11e95UOGMBM/sau7yApEw16Fyx/7UZv8tXv6XMX6fUnec07GN2Wr0bMiIkgd5lDe06jHJMJDjFIuEbFsNbJhti7axzyQk/7vY5aSAHf6q5LQzrhT03qsrxOJZ0ljCopnTg22f4znqzpv1QL1G3u5n3V+4kq75PVfkbEXDh6ulyoPa9l674mwaKZizcLg0mnz3qiZf9JD+F9GTuajvdBPpHG5C3TR37IYkdET55CUAYXGkSjmxrehC2oexlMfuauBh4DekIcKToZ6T9xWdCf0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <51E43BBE31C5E44EA30B74CEA2E66618@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 615dd99f-58e5-4304-7ac7-08d6b36f47ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2019 11:19:45.1777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR07MB3179
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some recent commits to this driver were trying to make sure the TSS
interrupt is not generated on busy system due to 25ms timer expiring
between commands. It can still happen, however if STOP command is not
issued on time at the end of the transmission. If wait_for_completion in
axxia_i2c_xfer_msg() would not return after 25ms of getting an
interrupt, TSS will be generated and idev->err_msg will be set to
-ETIMEDOUT which will be returned from the axxia_i2c_xfer_msg(), even
though the transfer did actually succeed (STOP is automatically issued
when TSS triggers).

Fortunately, apart from already used manual and sequence commands, the
controller also has so called auto command. It works just like manual
mode but it but an automatic STOP is issued when either transfer length
is met or NAK is received from slave device.

This patch changes the axxia_i2c_xfer_msg() function so that auto
command is used for last message in transaction letting hardware manage
issuing STOP. TSS is disabled just after command transferring last
message finishes. Auto command, just like sequence, ends with SS
interrupt instead of SNS so handling of both had to be unified.

The axxia_i2c_stop() is no longer needed as the transfer can only end
with following conditions:
- fully successful - then last message was send by AUTO command and STOP
  was issued automatically
- NAK received - STOP is issued automatically by controller
- arbitration lost - STOP should not be issued as we don't control the
  bus
- IP interrupt received - this is sent when transfer length is set to 0
  for auto/sequence command. The check for that is done before START is
  send so no STOP is required
- TSS received between commands - STOP is issued by the controller

Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 drivers/i2c/busses/i2c-axxia.c | 57 ++++++++++++----------------------
 1 file changed, 19 insertions(+), 38 deletions(-)

diff --git a/drivers/i2c/busses/i2c-axxia.c b/drivers/i2c/busses/i2c-axxia.=
c
index bf564391091f..1c7b41f45c83 100644
--- a/drivers/i2c/busses/i2c-axxia.c
+++ b/drivers/i2c/busses/i2c-axxia.c
@@ -99,6 +99,7 @@
  * @adapter: core i2c abstraction
  * @i2c_clk: clock reference for i2c input clock
  * @bus_clk_rate: current i2c bus clock rate
+ * @last: a flag indicating is this is last message in transfer
  */
 struct axxia_i2c_dev {
 	void __iomem *base;
@@ -112,6 +113,7 @@ struct axxia_i2c_dev {
 	struct i2c_adapter adapter;
 	struct clk *i2c_clk;
 	u32 bus_clk_rate;
+	bool last;
 };
=20
 static void i2c_int_disable(struct axxia_i2c_dev *idev, u32 mask)
@@ -324,15 +326,14 @@ static irqreturn_t axxia_i2c_isr(int irq, void *_dev)
 		/* Stop completed */
 		i2c_int_disable(idev, ~MST_STATUS_TSS);
 		complete(&idev->msg_complete);
-	} else if (status & MST_STATUS_SNS) {
+	} else if (status & (MST_STATUS_SNS | MST_STATUS_SS)) {
 		/* Transfer done */
-		i2c_int_disable(idev, ~MST_STATUS_TSS);
+		int mask =3D idev->last ? ~0 : ~MST_STATUS_TSS;
+
+		i2c_int_disable(idev, mask);
 		if (i2c_m_rd(idev->msg_r) && idev->msg_xfrd_r < idev->msg_r->len)
 			axxia_i2c_empty_rx_fifo(idev);
 		complete(&idev->msg_complete);
-	} else if (status & MST_STATUS_SS) {
-		/* Auto/Sequence transfer done */
-		complete(&idev->msg_complete);
 	} else if (status & MST_STATUS_TSS) {
 		/* Transfer timeout */
 		idev->msg_err =3D -ETIMEDOUT;
@@ -405,6 +406,7 @@ static int axxia_i2c_xfer_seq(struct axxia_i2c_dev *ide=
v, struct i2c_msg msgs[])
 	idev->msg_r =3D &msgs[1];
 	idev->msg_xfrd =3D 0;
 	idev->msg_xfrd_r =3D 0;
+	idev->last =3D true;
 	axxia_i2c_fill_tx_fifo(idev);
=20
 	writel(CMD_SEQUENCE, idev->base + MST_COMMAND);
@@ -415,10 +417,6 @@ static int axxia_i2c_xfer_seq(struct axxia_i2c_dev *id=
ev, struct i2c_msg msgs[])
 	time_left =3D wait_for_completion_timeout(&idev->msg_complete,
 						I2C_XFER_TIMEOUT);
=20
-	i2c_int_disable(idev, int_mask);
-
-	axxia_i2c_empty_rx_fifo(idev);
-
 	if (idev->msg_err =3D=3D -ENXIO) {
 		if (axxia_i2c_handle_seq_nak(idev))
 			axxia_i2c_init(idev);
@@ -438,9 +436,10 @@ static int axxia_i2c_xfer_seq(struct axxia_i2c_dev *id=
ev, struct i2c_msg msgs[])
 	return idev->msg_err;
 }
=20
-static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *idev, struct i2c_msg *=
msg)
+static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *idev, struct i2c_msg *=
msg,
+			      bool last)
 {
-	u32 int_mask =3D MST_STATUS_ERR | MST_STATUS_SNS;
+	u32 int_mask =3D MST_STATUS_ERR;
 	u32 rx_xfer, tx_xfer;
 	unsigned long time_left;
 	unsigned int wt_value;
@@ -449,6 +448,7 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *ide=
v, struct i2c_msg *msg)
 	idev->msg_r =3D msg;
 	idev->msg_xfrd =3D 0;
 	idev->msg_xfrd_r =3D 0;
+	idev->last =3D last;
 	reinit_completion(&idev->msg_complete);
=20
 	axxia_i2c_set_addr(idev, msg);
@@ -478,8 +478,13 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *id=
ev, struct i2c_msg *msg)
 	if (idev->msg_err)
 		goto out;
=20
-	/* Start manual mode */
-	writel(CMD_MANUAL, idev->base + MST_COMMAND);
+	if (!last) {
+		writel(CMD_MANUAL, idev->base + MST_COMMAND);
+		int_mask |=3D MST_STATUS_SNS;
+	} else {
+		writel(CMD_AUTO, idev->base + MST_COMMAND);
+		int_mask |=3D MST_STATUS_SS;
+	}
=20
 	writel(WT_EN | wt_value, idev->base + WAIT_TIMER_CONTROL);
=20
@@ -507,28 +512,6 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *id=
ev, struct i2c_msg *msg)
 	return idev->msg_err;
 }
=20
-static int axxia_i2c_stop(struct axxia_i2c_dev *idev)
-{
-	u32 int_mask =3D MST_STATUS_ERR | MST_STATUS_SCC | MST_STATUS_TSS;
-	unsigned long time_left;
-
-	reinit_completion(&idev->msg_complete);
-
-	/* Issue stop */
-	writel(0xb, idev->base + MST_COMMAND);
-	i2c_int_enable(idev, int_mask);
-	time_left =3D wait_for_completion_timeout(&idev->msg_complete,
-					      I2C_STOP_TIMEOUT);
-	i2c_int_disable(idev, int_mask);
-	if (time_left =3D=3D 0)
-		return -ETIMEDOUT;
-
-	if (readl(idev->base + MST_COMMAND) & CMD_BUSY)
-		dev_warn(idev->dev, "busy after stop\n");
-
-	return 0;
-}
-
 /* This function checks if the msgs[] array contains messages compatible w=
ith
  * Sequence mode of operation. This mode assumes there will be exactly one
  * write of non-zero length followed by exactly one read of non-zero lengt=
h,
@@ -558,9 +541,7 @@ axxia_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg=
 msgs[], int num)
 	i2c_int_enable(idev, MST_STATUS_TSS);
=20
 	for (i =3D 0; ret =3D=3D 0 && i < num; ++i)
-		ret =3D axxia_i2c_xfer_msg(idev, &msgs[i]);
-
-	axxia_i2c_stop(idev);
+		ret =3D axxia_i2c_xfer_msg(idev, &msgs[i], i =3D=3D (num - 1));
=20
 	return ret ? : i;
 }
--=20
2.20.1

