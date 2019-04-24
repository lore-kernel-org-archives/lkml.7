Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B46C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC43020835
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENh4FaCf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbfDXGt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:49:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34620 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729988AbfDXGtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:49:23 -0400
Received: by mail-pg1-f196.google.com with SMTP id v12so8898505pgq.1;
        Tue, 23 Apr 2019 23:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LHtgcg1Zf0pIA2u538aF6THujnYqeIu7AUO/MXWnU04=;
        b=ENh4FaCf4z2e1QhrXdvYc48z3uOFW2fMHKwFhvPG8Q3+ID/Un4pEu503bAnh9a/4/s
         ZGY+7XV8E/bsPIdYNZ7kFzT+f2dspur8Td1C+P0fmPYty7HH+mI1XALGxD2a6I6+F+QU
         UyIfPJcwRwU3yE/TrLPyC7HwxefJoIgrnt7oiPw0fXcm2rfGU/rsKj/ofgI6kxKFzhLb
         YLe2ukqMscUK0dxbu9gzyTKg9UbTLwXmjgV0zXDLDYLJO0byO0ANo6UEoYYFfbvnQj/C
         JTbYtdmsZmzWqxQNRp/VJX3E9nl49C/GwFUAC4XDaNsb1Qa02fk8Uf3GobLNfUXq11pL
         FqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LHtgcg1Zf0pIA2u538aF6THujnYqeIu7AUO/MXWnU04=;
        b=ZOBv2e5wpB7y7lVSdoNfxEa35drIuBGTft9RY3hAmfj3cRt0aMM0yx1+8tVCb4LNmd
         9ZlfGJX75G/1Zfac78PYi7ahOR85highgGTU9iSUmtFprpYiKbMPZVOJs3Qc+aSua+ZH
         iN5EmjvHtnjCun6LsAUTMGnx9iCeHPVB7UjzisJhRlA5VC6hn0/tYM8gK4JIC7xDWbGR
         PLTba8CIL3374H6s8kQC45czRMMb/ybtonpx4aGMuIoWSeuVbBNP716EdikGndeOmuVH
         4/xcsuEL/7AmOCjiH8Kz2RLT0ZgLLRUY9wbXTxVcXSai6WswUAjMse0VhE+LncQzTQnm
         LHQw==
X-Gm-Message-State: APjAAAU+u6usY+/+ARlHRULHz2bZd6m5bwNG3hQ9xOQFJahGDIisYvMp
        Ftmj1rKvQrte/ChL8Bj6wHvj960VMxg=
X-Google-Smtp-Source: APXvYqzrEqBa6Gy6x8lbVlOg3hQNvschZK2zRj24hNGYIMRyi9IxBVV+1OuXaLf7HxJsee/XPx8tkw==
X-Received: by 2002:a65:6282:: with SMTP id f2mr7184655pgv.152.1556088562076;
        Tue, 23 Apr 2019 23:49:22 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id e13sm26332457pgb.37.2019.04.23.23.49.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 23:49:21 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 10/12] thermal: qoriq: Do not report invalid temperature reading
Date:   Tue, 23 Apr 2019 23:48:28 -0700
Message-Id: <20190424064830.18179-11-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424064830.18179-1-andrew.smirnov@gmail.com>
References: <20190424064830.18179-1-andrew.smirnov@gmail.com>
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
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Lucas Stach <l.stach@pengutronix.de>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Angus Ainslie (Purism) <angus@akkea.ca>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/qoriq_thermal.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index d8d9f567a632..f97d0cc82b2b 100644
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
@@ -48,10 +49,25 @@ static int tmu_get_temp(int id, void *p, int *temp)
 {
 	struct qoriq_tmu_data *qdata = p;
 	u32 val;
+	/*
+	 * REGS_TRITSR(id) has the following layout:
+	 *
+	 * 31  ... 7 6 5 4 3 2 1 0
+	 *  V          TEMP
+	 *
+	 * Where V bit signifies if the measurement is ready and is
+	 * within sensor range. TEMP is an 8 bit value representing
+	 * temperature in C.
+	 */
+	if (regmap_read_poll_timeout(qdata->regmap,
+				     REGS_TRITSR(id),
+				     val,
+				     val & TRITSR_V,
+				     USEC_PER_MSEC,
+				     10 * USEC_PER_MSEC))
+		return -ENODATA;
 
-	regmap_read(qdata->regmap, REGS_TRITSR(id), &val);
 	*temp = (val & 0xff) * 1000;
-
 	return 0;
 }
 
-- 
2.20.1

