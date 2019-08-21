Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14E2C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F4A2089E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yozs2A9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbfHUMjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:39:23 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44734 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfHUMjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 08:39:23 -0400
Received: by mail-pl1-f193.google.com with SMTP id t14so1263790plr.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 05:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=omDwMrCmxk+7Xa7lFfgeuxa3H+tBB5SvsVtJ1gAu9m8=;
        b=Yozs2A9rBctqQEgyDcF4/wFS7L1lIhPOEhmkSZGKBb+/DVB8bYA74yRG4BfC1dwOKf
         p5EeZ+bWwbyVI++xjdHKzEnuXMnRtCKxmFTh+mxSzxwVxjEpvg+Fo42PrIegTm8lMHng
         Q0qbZ0l7GAmn94mbT7jEDSCPV0YKeb6jYQyuECAVQZToh3w7hdS41XgnsmlK9NKlYuB/
         VkL9D62LOk33Jgk7gQolCOInt4TwTo9RWQmzu9GD/I0dphlCHyrpUFD5mjUCcrUd5uja
         ZS/un4d/SI3xRV4auwVYlkw5PU8kE5CNsrehWc9bR/pmR0c1tafl4kXHdjcCqZk+WPPq
         68aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=omDwMrCmxk+7Xa7lFfgeuxa3H+tBB5SvsVtJ1gAu9m8=;
        b=DXeehz2VAs8s63wpNV9BAXhKKbKE+HGkgjQOJniXBIAQExYLh2k49OslqsojpR60N2
         v0T4RYU1tktwB4YXtJd8AG3B6aE6kzoZizOIwfnQb0+82Wgw1atbS5D+QyVEm4wZ8Vhn
         G18Ww7GV5QBOlf9bHHcKHeXsQR/eXLgwv0vSJcCWgf5n+x/7SrCa+1rG6PCadQWngNnx
         CuRxbBcSU7W7agq4EDCWgHRKg9CvxGBEDwt30HP8m8sMEqPuxAlzAPoLxleLg6SNxOMH
         aR+PUoOLpMAsZ7Zzq0BcdmT70l+tvEkOUKwhE6vuIvsh9xYjsf3VcA6uCbRFtVR+C28q
         Y3fg==
X-Gm-Message-State: APjAAAW3q/obcQAgbhgalz6N96/KRHcaZ+eYyxewyrG9WOT36CI++uLz
        v2ajRA+IRk3AfvZOnONoRRs082NV3BwHgQ==
X-Google-Smtp-Source: APXvYqy/uq6IK56H1aAY+ntEWpdXMXT6TaOjGPzJX2cRoieHDupaniomQNOmSqUC4nn11JMjtCrXnA==
X-Received: by 2002:a17:902:7d8b:: with SMTP id a11mr33463555plm.306.1566391162920;
        Wed, 21 Aug 2019 05:39:22 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id i124sm25677411pfe.61.2019.08.21.05.39.19
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Aug 2019 05:39:22 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, cixi.geng@unisoc.com,
        lanqing.liu@unisoc.com, baolin.wang@linaro.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: sprd: Add loopback function support
Date:   Wed, 21 Aug 2019 20:39:09 +0800
Message-Id: <1275cd9968f1ceb5ac049cc23f1e508025cd552f.1566375260.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add loopback function support for Spreadtrum serial controller.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/tty/serial/sprd_serial.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 73d71a4..85fc57c 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -79,6 +79,7 @@
 /* control register 1 */
 #define SPRD_CTL1		0x001C
 #define SPRD_DMA_EN		BIT(15)
+#define SPRD_LOOPBACK_EN	BIT(14)
 #define RX_HW_FLOW_CTL_THLD	BIT(6)
 #define RX_HW_FLOW_CTL_EN	BIT(7)
 #define TX_HW_FLOW_CTL_EN	BIT(8)
@@ -164,7 +165,14 @@ static unsigned int sprd_get_mctrl(struct uart_port *port)
 
 static void sprd_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
-	/* nothing to do */
+	u32 val = serial_in(port, SPRD_CTL1);
+
+	if (mctrl & TIOCM_LOOP)
+		val |= SPRD_LOOPBACK_EN;
+	else
+		val &= ~SPRD_LOOPBACK_EN;
+
+	serial_out(port, SPRD_CTL1, val);
 }
 
 static void sprd_stop_rx(struct uart_port *port)
-- 
1.7.9.5

