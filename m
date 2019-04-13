Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5887FC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E66B218C3
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIZedw5E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfDMI2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 04:28:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46900 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbfDMI2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 04:28:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id 9so6217193pfj.13;
        Sat, 13 Apr 2019 01:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fa9VbtAEA5XxQk9udn1SCQKBpCj0lIUFDw7+3syeD9M=;
        b=cIZedw5EAO3l9Jp8aV2T0bXUIyd4bK7Yoqd4/4TlC3Bw6PAB5RBCfhEPMCQiKhXu33
         hU56UMgs685hBDwQkJSKkG5JogJek94vg0slSj3qriFzdfugZadKrJxoBED3wZbrDvdu
         z2CpAn0wC6kR79yXyEmbcYayUKiLkRU8BKvqIATnOWzHKA4RZ5HK12Oe799Lpe+6nSd2
         40bAIAKfgnO0ad1zVrF/WPJGC4417YG5LdOWfTVoGwlmpo1ShX6hAaoYGf+ymKVzUtDX
         1cNtdBAgFIuROUxPAUZBVBHXqCy0UOBwPOazdLzMLb3s653OJ2WCit32bGf31cpwgKpx
         wewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fa9VbtAEA5XxQk9udn1SCQKBpCj0lIUFDw7+3syeD9M=;
        b=jZMvIDzSwFdChbriShYMGXgugPjOcAApHi32YNk9uk0HAJFY5PgQvRoH22rcyLVv9Z
         T4NHYghIU+oSk106Yk3GgpMOx+MfuVInHIPsyCBbgsu1UhUIgKyFWquYIrep9ewySZp0
         17ESvB8wYj4kJjurDXtWed8o9unsvkBTmarUuYLyDSxfQijDDcZ5gsz/jUJW9lDJ3Kdb
         FMOll1rXymw+yRpGxKjFaTmXZVaKDHmmT+BWZ8UDRgfPiNpvJTdnDaofcytSH5uUBWtI
         0ukcmOSEAcMtj0QjSKY0VyXErY2rLkd/ayGa5h7UwcdLRSoiGJTNYRjDvg49upToy2Vt
         Ldpg==
X-Gm-Message-State: APjAAAVlYuP3XFkRXYX57Su99POg0ztV85/+WwHsVqaJ+GPiIKuYrCn4
        idwQ0KWLJHRx4PF+wUuaEKD75Vth
X-Google-Smtp-Source: APXvYqypU3Fpoc0fnbetc8eAplZiNuSLI/O77OXWw48TbSU9zR+w8fxQRO7aMGWPO2Y9HM4Rj6NvvA==
X-Received: by 2002:a63:6842:: with SMTP id d63mr56387934pgc.49.1555144097924;
        Sat, 13 Apr 2019 01:28:17 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id z20sm58261328pgf.70.2019.04.13.01.28.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Apr 2019 01:28:16 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/12] thermal: qoriq: Do not report invalid temperature reading
Date:   Sat, 13 Apr 2019 01:27:46 -0700
Message-Id: <20190413082748.29990-11-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190413082748.29990-1-andrew.smirnov@gmail.com>
References: <20190413082748.29990-1-andrew.smirnov@gmail.com>
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
index abbbfe88422e..5c459a9d0db3 100644
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

