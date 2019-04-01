Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5DAC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B13620870
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcEVM51v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731799AbfDAEOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 00:14:53 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45907 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731692AbfDAEOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 00:14:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id y3so4042354pgk.12;
        Sun, 31 Mar 2019 21:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4fayQCf50B/SpG2UN3cuJKqLKCnufoicggcy9d1WYVI=;
        b=dcEVM51v6IDo40IP/tEwGUwV2q1qvL/OmFzIbpPt0gGxKG71PXSZrJRLMrXWZeojVb
         yZRcDdJEn+UOEoMQxBs+ilEjP3UhG9a2msCcf2tNHCL2mlf7B1t3C2K+OrnvDMtXLBdo
         mbcXvh/7rdz1bRhGS/knn+xPYT7daxy3wYqrN6SlBayDzYSa76EZ9FR/Hic/ZkYvf+/7
         sX5olX+SJ2MXmt5kCzYTHRd/CeeyWEwdCPz66XzUNI6v7WrT3fCuBvSUOdPi527Hlqaf
         n5XfCYGXfBVngGaJT/P7O71ndn5LvpcOx2nFodc0OuqOUJXsY0JaDnoKriGBPagvgZ8T
         HZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4fayQCf50B/SpG2UN3cuJKqLKCnufoicggcy9d1WYVI=;
        b=ir9ReCJdFKacwgOJ2M0RP8a1apEH8C8VrqOa0hA25CNYx4JyaCU3FzPQNIe0HsRRdf
         vWsqvKO67gnuGNaIlHwkJt9N21p0ATJO1e6T80DSgWxCrGN2JB6/nhrQ+36EtboZjzxG
         VBTnTWDJuo+nV1SnAtVk0v3T3/kHqVxN7FdI3niEdOOkhHfps0lF/2DeTUvPR7sccHZC
         tgU5g8BzlC8a9KC1yJuSbyqQPnVuE6TRyGxEDl6DDQIwUhPnhcLKy9FCZ9fqG6dnYh8Q
         z5TgkP2lB0NwB9kfc9Lal3LFqdMWcHqO6hLyWQC4k22qTqWueUrnlJIHyo5jmaoLANay
         KpbQ==
X-Gm-Message-State: APjAAAX2Bh7aVLDXxhAOZu/tRjPr8EFvJMKE84BFmt51Ogcr0ZS0jpCB
        wzTiEfpwwgWEjA6GRzqBMhbVfrly
X-Google-Smtp-Source: APXvYqzpaB1q6NUrCmOQsSx4OKqBdhCrFvP/pDVa+h4A2dcNxjazikwwWfIo4s1z4aZBRbKDGEob6Q==
X-Received: by 2002:a63:7444:: with SMTP id e4mr40526621pgn.261.1554092089443;
        Sun, 31 Mar 2019 21:14:49 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id a12sm9968504pgq.21.2019.03.31.21.14.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 21:14:48 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/13] thermal: qoriq: Do not report invalid temperature reading
Date:   Sun, 31 Mar 2019 21:14:16 -0700
Message-Id: <20190401041418.5999-12-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401041418.5999-1-andrew.smirnov@gmail.com>
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before returning measured temperature data to upper layer we need to
make sure that the reading was marked as "valid" to avoid reporting
bogus data.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Angus Ainslie (Purism) <angus@akkea.ca>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/qoriq_thermal.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 7ff93dfcd68b..9d227654f879 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -37,6 +37,7 @@
 #define REGS_TRITSR(n)	(0x100 + 16 * (n)) /* Immediate Temperature
 					    * Site Register
 					    */
+#define TRITSR_V	BIT(31)
 #define REGS_TTRnCR(n)	(0xf10 + 4 * (n)) /* Temperature Range n
 					   * Control Register
 					   */
@@ -62,10 +63,18 @@ static int tmu_get_temp(void *p, int *temp)
 	struct qoriq_sensor *qsensor = p;
 	struct qoriq_tmu_data *qdata = qoriq_sensor_to_data(qsensor);
 	u32 val;
+	int ret;
 
-	regmap_read(qdata->regmap, REGS_TRITSR(qsensor->id), &val);
-	*temp = (val & 0xff) * 1000;
+	ret = regmap_read_poll_timeout(qdata->regmap,
+				       REGS_TRITSR(qsensor->id),
+				       val,
+				       val & TRITSR_V,
+				       USEC_PER_MSEC,
+				       10 * USEC_PER_MSEC);
+	if (ret)
+		return ret;
 
+	*temp = (val & 0xff) * 1000;
 	return 0;
 }
 
-- 
2.20.1

