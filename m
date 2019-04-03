Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBA7C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A0420830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfDCOxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:53:23 -0400
Received: from smtp.asem.it ([151.1.184.197]:61517 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbfDCOxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 10:53:19 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 5.5.0)
        with ESMTP id SG003789494.MSG 
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 16:53:09 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1261.35; Wed, 3
 Apr 2019 16:53:08 +0200
Received: from flavio-x.asem.intra (172.16.17.208) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server id 15.1.1261.35 via Frontend
 Transport; Wed, 3 Apr 2019 16:53:07 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH 2/2] rtc: pcf2127: add battery-low INTn generation
Date:   Wed, 3 Apr 2019 16:52:45 +0200
Message-ID: <1554303165-24813-2-git-send-email-f.suligoi@asem.it>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554303165-24813-1-git-send-email-f.suligoi@asem.it>
References: <1554303165-24813-1-git-send-email-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: text/plain
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A0B0210.5CA4C8D4.0055,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pcf2127 has an automatic battery-low detection function.

In case of battery-low event, an interrupt generation through
the pin INTn (active low) can be enabled, setting the flag BLIE
in the register Control_3.

This function is activated by the "battery-low-hw-alarm" DT property.

Example of use for an NXP i.MX7D board:

&i2c3 {
	clock-frequency = <100000>;
	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_i2c3>;
	status = "okay";

	pcf2127@51 {
		compatible = "nxp,pcf2127";
		reg = <0x51>;
		battery-low-hw-alarm;
		status = "okay";
	};
};

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 drivers/rtc/rtc-pcf2127.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 7cb786d..e3805c8 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -228,6 +228,10 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 			const char *name, bool has_nvmem)
 {
 	struct pcf2127 *pcf2127;
+	struct device_node *np;
+	struct i2c_client *client = to_i2c_client(dev);
+	unsigned char buf[2];
+	int err;
 	int ret = 0;
 
 	dev_dbg(dev, "%s\n", __func__);
@@ -245,6 +249,35 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 	if (IS_ERR(pcf2127->rtc))
 		return PTR_ERR(pcf2127->rtc);
 
+	/*
+	 * The pcf2127 has an automatic battery-low detection function.
+	 *
+	 * In case of battery-low event, an interrupt generation through
+	 * the pin INTn (active low) can be enabled, setting the flag BLIE
+	 * in the register Control_3.
+	 */
+	np = of_node_get(dev->of_node);
+	if (!np) {
+		dev_err(dev, "failed to find the RTC pcf2127 node\n");
+		return -ENOENT;
+	}
+	if (of_get_property(np, "battery-low-hw-alarm", NULL)) {
+		dev_info(dev, "enable battery-low hw alarm on INTn pin\n");
+
+		/*
+		 * Set BLIE bit in register Control_3 (override is possible
+		 * because this register is fully zero after reset)
+		 */
+		buf[0] = PCF2127_REG_CTRL3;
+		buf[1] = 0x01;
+		/* write register's data */
+		err = i2c_master_send(client, buf, 2);
+		if (err != 2) {
+			dev_err(dev, "%s: err=%d", __func__, err);
+			return -EIO;
+		}
+	}
+
 	if (has_nvmem) {
 		struct nvmem_config nvmem_cfg = {
 			.priv = pcf2127,
-- 
2.7.4

