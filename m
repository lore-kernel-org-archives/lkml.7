Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DC5C49ED9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 19:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B193721924
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 19:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="T5jK5zOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfIJTFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 15:05:54 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:55647 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfIJTFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 15:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568142352; x=1599678352;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=tjxNGJLyX19AQqhMICAaAGbwGhdaVJ8YEOzgZyyiKDg=;
  b=T5jK5zOvygYDV4+w3VtqcCOcq6s8u7EonWN9MdypBIyOjc2BV0pbQ9TO
   ZBUe+RK/dW7WoZPEX2re5fa1ZI9jRkugsxUSrzaUF/8ODd5P3WKsZGxTr
   yQ+qFsXMq5/UYHv3h0hV0QVstcB1d2gY7hzMEngzXwKWXfcnxX3se3BdN
   o=;
X-IronPort-AV: E=Sophos;i="5.64,490,1559520000"; 
   d="scan'208";a="750032858"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 10 Sep 2019 19:05:50 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com (Postfix) with ESMTPS id 41C92A1C2C;
        Tue, 10 Sep 2019 19:05:49 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 10 Sep 2019 19:05:48 +0000
Received: from udc4a3e82dbc15a031435.hfa15.amazon.com (10.43.160.5) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 10 Sep 2019 19:05:41 +0000
From:   Talel Shenhar <talel@amazon.com>
To:     <robh+dt@kernel.org>, <marc.zyngier@arm.com>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <mark.rutland@arm.com>,
        <nicolas.ferre@microchip.com>, <mchehab+samsung@kernel.org>,
        <shawn.lin@rock-chips.com>, <gregkh@linuxfoundation.org>,
        <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <talel@amazon.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 3/3] soc: amazon: al-pos: cast to u64 before left shifting
Date:   Tue, 10 Sep 2019 22:05:10 +0300
Message-ID: <1568142310-17622-4-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568142310-17622-1-git-send-email-talel@amazon.com>
References: <1568142310-17622-1-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.5]
X-ClientProxiedBy: EX13D03UWC002.ant.amazon.com (10.43.162.160) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix wrap around for pos errors on addresses above 32 bit.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Talel Shenhar <talel@amazon.com>
---
 drivers/soc/amazon/al_pos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/amazon/al_pos.c b/drivers/soc/amazon/al_pos.c
index a865111..e95e1fc 100644
--- a/drivers/soc/amazon/al_pos.c
+++ b/drivers/soc/amazon/al_pos.c
@@ -49,7 +49,7 @@ static irqreturn_t al_pos_irq_handler(int irq, void *info)
 	writel(0, pos->mmio_base + AL_POS_ERROR_LOG_1);
 
 	addr = FIELD_GET(AL_POS_ERROR_LOG_0_ADDR_LOW, log0);
-	addr |= (FIELD_GET(AL_POS_ERROR_LOG_1_ADDR_HIGH, log1) << 32);
+	addr |= (((u64)FIELD_GET(AL_POS_ERROR_LOG_1_ADDR_HIGH, log1)) << 32);
 	request_id = FIELD_GET(AL_POS_ERROR_LOG_1_REQUEST_ID, log1);
 	bresp = FIELD_GET(AL_POS_ERROR_LOG_1_BRESP, log1);
 
-- 
2.7.4

