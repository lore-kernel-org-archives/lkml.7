Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3635CC3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C8820644
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569181101;
	bh=9YTmjz6JzHxwcmKGl0VJUGsFdEfzvM/9GRS2tB2FdWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LJ4xR+WbpNtkP076YeJ8cC3Vmylgp0Iqfm3bqWIVydf+SN4qhzQbenDrA2+R2c3Lc
	 9D/GneN4ne7itYv1AXr46xToGFYU1noakCYsDMcLVdH+vL0EtGvQrWZY1v+97uby9V
	 BCevwnYiEd6+L2SYrvbSz8uIubny2Nexv1UXrQgI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439277AbfIVTiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:38:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389327AbfIVSpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:45:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41CC721907;
        Sun, 22 Sep 2019 18:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569177933;
        bh=9YTmjz6JzHxwcmKGl0VJUGsFdEfzvM/9GRS2tB2FdWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wXx/I+Pzd1I3UMD1EXv3xtw2AVHodeg/5y3S2GEX+8JKzBjysfZLBplAPwQY0DQ8k
         IE2A8bLGBsfhX17946OsOZNbYf8NsTBjYP+zZHcQU6CYrDLeTKd5efrHRaMRSiDBT6
         Z1BiHpl22JYrtbZ4mhzQm6PrcQ3aztf9g5C/khEw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 5.3 043/203] soc: amlogic: meson-clk-measure: protect measure with a mutex
Date:   Sun, 22 Sep 2019 14:41:09 -0400
Message-Id: <20190922184350.30563-43-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922184350.30563-1-sashal@kernel.org>
References: <20190922184350.30563-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Armstrong <narmstrong@baylibre.com>

[ Upstream commit 3a760d986568b67d1f8411dab64608075817b90d ]

In order to protect clock measuring when multiple process asks for
a measure, protect the main measure function with mutexes.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/amlogic/meson-clk-measure.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/amlogic/meson-clk-measure.c b/drivers/soc/amlogic/meson-clk-measure.c
index 19d4cbc93a17a..c470e24f1dfa6 100644
--- a/drivers/soc/amlogic/meson-clk-measure.c
+++ b/drivers/soc/amlogic/meson-clk-measure.c
@@ -11,6 +11,8 @@
 #include <linux/debugfs.h>
 #include <linux/regmap.h>
 
+static DEFINE_MUTEX(measure_lock);
+
 #define MSR_CLK_DUTY		0x0
 #define MSR_CLK_REG0		0x4
 #define MSR_CLK_REG1		0x8
@@ -360,6 +362,10 @@ static int meson_measure_id(struct meson_msr_id *clk_msr_id,
 	unsigned int val;
 	int ret;
 
+	ret = mutex_lock_interruptible(&measure_lock);
+	if (ret)
+		return ret;
+
 	regmap_write(priv->regmap, MSR_CLK_REG0, 0);
 
 	/* Set measurement duration */
@@ -377,8 +383,10 @@ static int meson_measure_id(struct meson_msr_id *clk_msr_id,
 
 	ret = regmap_read_poll_timeout(priv->regmap, MSR_CLK_REG0,
 				       val, !(val & MSR_BUSY), 10, 10000);
-	if (ret)
+	if (ret) {
+		mutex_unlock(&measure_lock);
 		return ret;
+	}
 
 	/* Disable */
 	regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_ENABLE, 0);
@@ -386,6 +394,8 @@ static int meson_measure_id(struct meson_msr_id *clk_msr_id,
 	/* Get the value in multiple of gate time counts */
 	regmap_read(priv->regmap, MSR_CLK_REG2, &val);
 
+	mutex_unlock(&measure_lock);
+
 	if (val >= MSR_VAL_MASK)
 		return -EINVAL;
 
-- 
2.20.1

