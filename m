Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E78C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00CFB2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="WuNoq5ND"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfDOM0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:26:34 -0400
Received: from mail-eopbgr680081.outbound.protection.outlook.com ([40.107.68.81]:29186
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726147AbfDOM0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:26:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giQx8NMjVMgEy7h9MWpHT9I1KNINNjmRNltR9xDVccU=;
 b=WuNoq5ND0Ewh4LFc2yB04VJdR61Frwlb2ARCU3Ob4t6fqkc43LvMCpN1rWSr8yIqCtcgaVTK5wyitcChxBUGljcvUpX9CuS3XEQxkkCu/WnQvoW53gW9LH8LmY1hrQxXRHB6TJWAH/bedoN8O3+U2fLGFNrKKIDklYm9zbXMVIg=
Received: from DM6PR03CA0028.namprd03.prod.outlook.com (2603:10b6:5:40::41) by
 BL2PR03MB545.namprd03.prod.outlook.com (2a01:111:e400:c23::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.19; Mon, 15 Apr 2019 12:26:30 +0000
Received: from BL2NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by DM6PR03CA0028.outlook.office365.com
 (2603:10b6:5:40::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1792.16 via Frontend
 Transport; Mon, 15 Apr 2019 12:26:30 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT028.mail.protection.outlook.com (10.152.77.165) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1771.16
 via Frontend Transport; Mon, 15 Apr 2019 12:26:30 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x3FCQUx8008912
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 15 Apr 2019 05:26:30 -0700
Received: from btogorean-pc.analog.com (10.50.1.212) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 15 Apr 2019 08:26:29 -0400
From:   Bogdan Togorean <bogdan.togorean@analog.com>
To:     <linux-input@vger.kernel.org>
CC:     <dmitry.torokhov@gmail.com>, <gustavo@embeddedor.com>,
        <linux-kernel@vger.kernel.org>,
        Bogdan Togorean <bogdan.togorean@analog.com>
Subject: [PATCH 1/1] input: adp5589: Add gpio_set_multiple interface
Date:   Mon, 15 Apr 2019 15:25:25 +0300
Message-ID: <20190415122525.2576-1-bogdan.togorean@analog.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(2980300002)(189003)(199004)(54906003)(316002)(186003)(106002)(14444005)(50226002)(107886003)(106466001)(36756003)(336012)(8936002)(8676002)(47776003)(476003)(2616005)(246002)(6666004)(7696005)(44832011)(5660300002)(305945005)(486006)(426003)(51416003)(2870700001)(77096007)(4326008)(7636002)(86362001)(6916009)(2351001)(126002)(72206003)(356004)(478600001)(53416004)(50466002)(1076003)(2906002)(48376002)(26005)(16060500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB545;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d404536-23c2-460c-7dac-08d6c19d96e0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:BL2PR03MB545;
X-MS-TrafficTypeDiagnostic: BL2PR03MB545:
X-Microsoft-Antispam-PRVS: <BL2PR03MB5453928485AB0944E32DC309B2B0@BL2PR03MB545.namprd03.prod.outlook.com>
X-Forefront-PRVS: 000800954F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Kcw6RSjBJcPkZSWjcqRGHXb0xMWiX1FzUhp2es6qzMFCbRurXU5JvIqofztzVPxVFYtnzFWKPrYpXF9BNwRnLd0NZEdfkOYa1oKDWWpqtxQlFCI2pAyrKdTcLDAJpWk+3s6kMoQPfuTE/ckPwGT4eDCv3F18nDaVV6dWinl2IGLqKHjWUHv11MJGZvlJZZtZAMDw/Iwcb0ocGfZX5/FLFql9ASoGg0u8EqzT6C2XKRCMQL5t/MZb+AtZb/3qrgd51xC6iyjtZw28nmGGyu63bPyOYBZpOCtDfibA5JtsQidYSnFRliCQLE2VEo0+qXwLj0bNCUkOLPt9qY+U1i28lZJ/r1FudUxhSHiuoQAv/+/9DokBzdR6PvJ9RP/yZZyxTLTvZqQ5nD1BaaghEbFyOjLW2yQNMRbPcSA/++n6tuE=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2019 12:26:30.3773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d404536-23c2-460c-7dac-08d6c19d96e0
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB545
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the gpio_set_multiple interface for ADP558x chip.

Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
---
 drivers/input/keyboard/adp5589-keys.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/input/keyboard/adp5589-keys.c b/drivers/input/keyboard/adp5589-keys.c
index 2835fba71c33..143871bd60ef 100644
--- a/drivers/input/keyboard/adp5589-keys.c
+++ b/drivers/input/keyboard/adp5589-keys.c
@@ -416,6 +416,30 @@ static void adp5589_gpio_set_value(struct gpio_chip *chip,
 	mutex_unlock(&kpad->gpio_lock);
 }
 
+static void adp5589_gpio_set_multiple(struct gpio_chip *chip,
+				      unsigned long *mask, unsigned long *bits)
+{
+	struct adp5589_kpad *kpad = container_of(chip, struct adp5589_kpad, gc);
+	u8 bank, reg_mask, reg_bits;
+
+	mutex_lock(&kpad->gpio_lock);
+
+	for (bank = 0; bank <= kpad->var->bank(kpad->var->maxgpio); bank++) {
+		if (bank > kpad->var->bank(get_bitmask_order(*mask) - 1))
+			break;
+		reg_mask = mask[bank / sizeof(*mask)] >>
+			   ((bank % sizeof(*mask)) * BITS_PER_BYTE);
+		reg_bits = bits[bank / sizeof(*bits)] >>
+			   ((bank % sizeof(*bits)) * BITS_PER_BYTE);
+		kpad->dat_out[bank] &= ~reg_mask;
+		kpad->dat_out[bank] |= reg_bits & reg_mask;
+		adp5589_write(kpad->client, kpad->var->reg(ADP5589_GPO_DATA_OUT_A) + bank,
+			      kpad->dat_out[bank]);
+	}
+
+	mutex_unlock(&kpad->gpio_lock);
+}
+
 static int adp5589_gpio_direction_input(struct gpio_chip *chip, unsigned off)
 {
 	struct adp5589_kpad *kpad = gpiochip_get_data(chip);
@@ -517,6 +541,7 @@ static int adp5589_gpio_add(struct adp5589_kpad *kpad)
 	kpad->gc.direction_output = adp5589_gpio_direction_output;
 	kpad->gc.get = adp5589_gpio_get_value;
 	kpad->gc.set = adp5589_gpio_set_value;
+	kpad->gc.set_multiple = adp5589_gpio_set_multiple;
 	kpad->gc.can_sleep = 1;
 
 	kpad->gc.base = gpio_data->gpio_start;
-- 
2.21.0

