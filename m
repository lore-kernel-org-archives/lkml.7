Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7ABC00523
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 07:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB23222C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 07:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578035982;
	bh=FV053rnnc3Ysq//ItKxgra7oEosNJ8yKfv9gjd3Akao=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=2enRnOdFxauSHDrfFsjtv7p1NnKBZPeIxGsUphX1Qkyvg0XdUM8F/6Vg3QJhuQP8b
	 jnKNuNi7VUORBbDye7+9MzFe+Ppzv64h8XVx0FLacpjG0mcEUuPOHA7g9Fl/2RYDYD
	 kY6w+OOKEgoZ+XRx7y5XSon9UnRzSo1Zi6/d/4nI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgACHSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 02:18:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:34846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgACHSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 02:18:51 -0500
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72899222C3;
        Fri,  3 Jan 2020 07:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578035930;
        bh=FV053rnnc3Ysq//ItKxgra7oEosNJ8yKfv9gjd3Akao=;
        h=From:To:Cc:Subject:Date:From;
        b=jzgTO2MqtxBwsNZQ8PN9KIeVu9nevlCM/egS/oKHH34BfyhH+O3qwNe/11pHQE+2c
         qJJnU1488/tJXT56WynIKr0FXlxgcqMFhs6cEEkYZ2X/fd7MZ2aOhnQw6wSIb/Y8bK
         QCxSt9n1aOpQLsKv6BcOS/lZhjk72rYAgLUsrZpY=
Received: by wens.tw (Postfix, from userid 1000)
        id BCD7E5FC7C; Fri,  3 Jan 2020 15:18:48 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: sunxi-ng: r40: Export MBUS clock
Date:   Fri,  3 Jan 2020 15:18:48 +0800
Message-Id: <20200103071848.3977-1-wens@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The MBUS clock needs to be referenced in the MBUS device node.
Export it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun8i-r40.h      | 4 ----
 include/dt-bindings/clock/sun8i-r40-ccu.h | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r40.h b/drivers/clk/sunxi-ng/ccu-sun8i-r40.h
index a69637b6b0c1..6f7071df8e1c 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r40.h
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r40.h
@@ -55,10 +55,6 @@
 
 /* Some more module clocks are exported */
 
-#define CLK_MBUS		155
-
-/* Another bunch of module clocks are exported */
-
 #define CLK_NUMBER		(CLK_OUTB + 1)
 
 #endif /* _CCU_SUN8I_R40_H_ */
diff --git a/include/dt-bindings/clock/sun8i-r40-ccu.h b/include/dt-bindings/clock/sun8i-r40-ccu.h
index f9e15a235626..d7337b55a4ef 100644
--- a/include/dt-bindings/clock/sun8i-r40-ccu.h
+++ b/include/dt-bindings/clock/sun8i-r40-ccu.h
@@ -176,7 +176,7 @@
 #define CLK_AVS			152
 #define CLK_HDMI		153
 #define CLK_HDMI_SLOW		154
-
+#define CLK_MBUS		155
 #define CLK_DSI_DPHY		156
 #define CLK_TVE0		157
 #define CLK_TVE1		158
-- 
2.24.1

