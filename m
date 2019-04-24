Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC43C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE542175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="lEzuZVIw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbfDXKUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:20:10 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:54164 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728254AbfDXKUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:20:09 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OAJwBK012732;
        Wed, 24 Apr 2019 12:19:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=bu+FSSjL3xpYfr+iGtfEQuju6aILlJj4WyU2xE6oOeo=;
 b=lEzuZVIw0jUl623w6v6mXcpjyoC9rtmVEepCEWXaArJ33dbZb1ONwwS4mm+XlxhyCwqB
 GEIN7IfPZhT9s++dhMO/3ZO/3cxxvQ+/1QAwHZyJLDRgE8HKUePNH4wO/AxMgqB3LgJt
 C25u9xl0IzrT327KCCg+szDLGaGE3IjqJ0bH3lFN0QGF1n08RsZ6C44jjAdgBvDHW+fE
 LMHPZ1o/dOh8Yht//c/Hi+Fe68ti+YcE+DgP6Sx4Ef5xTzRzSPIA0e7VPU4DvL4LY8TG
 Zy+uKvKu0QA0ukl2660tNDc/k8dF2ZSDtRBaJC/uBq0npR2thU4sGxsfs82SIcgGsA13 fA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rytad5ubw-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Apr 2019 12:19:59 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3A20138;
        Wed, 24 Apr 2019 10:19:46 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 180E21653;
        Wed, 24 Apr 2019 10:19:46 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 24 Apr
 2019 12:19:45 +0200
Received: from localhost (10.201.20.122) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 24 Apr 2019 12:19:43
 +0200
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <rafael.j.wysocki@intel.com>, <dmitry.torokhov@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <hadess@hadess.net>,
        <frowand.list@gmail.com>, <m.felsch@pengutronix.de>,
        <agx@sigxcpu.org>, <yannick.fertre@st.com>, <arnd@arndb.de>
CC:     <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <broonie@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 5/5] input: goodix - Call devm_of_device_links_add() to create links
Date:   Wed, 24 Apr 2019 12:19:13 +0200
Message-ID: <20190424101913.1534-6-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190424101913.1534-1-benjamin.gaignard@st.com>
References: <20190424101913.1534-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.122]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yannick FertrÃ© <yannick.fertre@st.com>

Add a call to devm_of_device_links_add() to create links with suppliers
at probe time.

Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/input/touchscreen/goodix.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index f57d82220a88..9aefbfa39319 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -30,6 +30,7 @@
 #include <linux/slab.h>
 #include <linux/acpi.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <asm/unaligned.h>
 
 struct goodix_ts_data;
@@ -812,6 +813,8 @@ static int goodix_ts_probe(struct i2c_client *client,
 
 	ts->chip = goodix_get_chip_data(ts->id);
 
+	devm_of_device_links_add(&client->dev);
+
 	if (ts->gpiod_int && ts->gpiod_rst) {
 		/* update device config */
 		ts->cfg_name = devm_kasprintf(&client->dev, GFP_KERNEL,
-- 
2.15.0

