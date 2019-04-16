Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD92C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4450206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQcUqvP0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbfDPRXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:23:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43009 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbfDPRXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:23:54 -0400
Received: by mail-pl1-f194.google.com with SMTP id n8so10644028plp.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 10:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tT1+k/oL7sF0hQEa5Qvy4bzCNMftJlu6IbRe+573x4c=;
        b=YQcUqvP0JVMJVLbk/mNqAs64Lh2aMUeufYPf+ZmInTLuDvaofHREQOzldM6NvAEfFR
         TW/KuT2ADZceurAZo7zpQ93df04Y5tL8oiWRiHRwkibEY9gBT74jJrOO552UdBkHjhjn
         WZ8Yfrgg4crTVE6FCl3JBGeUUMLHTTCsb/T5Od6y6YzlaUii3bIdIkoli7dyUG+lL0Oj
         G6xNjf1H33I3eWiN9C9GNUQ1i9ah9yvhacd9eEg0OxiFunijUGKHGEGssOablE89W4jM
         8iOH30W+eidfZtdSWI4onARbnun7Nvgk2QjGNxGMNIkbA0HChLTGyrKF9s1MP2ExsKtY
         adfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tT1+k/oL7sF0hQEa5Qvy4bzCNMftJlu6IbRe+573x4c=;
        b=qBqsyQPSeQsnKr7E9aOsQxFX7nnOhYtHfxnb3stFlulK9+QzhAzpk9UdtcjXXO2f1Y
         fsoivpLbEIlHXNUEJ5+NNpVNTjAg6UBwmGxaW3LCLE5zKbn5+NHn/H8pAX+sP40OYLO0
         zcRbMWFHLdrLhRjcQOLIycwJDzrh8E3Urt14D7/ILCLHKVj16Zdm64VaRNn+OiWRqERh
         zE6VfIdCM/RU5XhlBHD0z5YfQYFtZwEo28ktvzLlYsnEA4NPuvu3kB9l6DwpgXwr6cd7
         u8kFryDpDVHvGHEjbsj2vt+86lMGQ0FShjiZonZsL5ueJ20UccdGxort7HqIFmJ4Isj5
         iwXQ==
X-Gm-Message-State: APjAAAV/lFGTDrBWl6LxYGa8EBD1BR8L986TS3MI8gKBNqN577APMasQ
        dJoPORA+el9iLeibglgV2yw=
X-Google-Smtp-Source: APXvYqzUjHeQ8lk0zi+6cQb9ydZrS+nDn0xiKEYshq8RqJvxt2a8vjBxXbEInaKg7Qu/PrNAod71Rw==
X-Received: by 2002:a17:902:266:: with SMTP id 93mr45458538plc.201.1555435433471;
        Tue, 16 Apr 2019 10:23:53 -0700 (PDT)
Received: from localhost.localdomain ([103.227.96.90])
        by smtp.googlemail.com with ESMTPSA id i68sm40481184pfj.96.2019.04.16.10.23.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 10:23:52 -0700 (PDT)
From:   Moses Christopher <moseschristopherb@gmail.com>
Cc:     moseschristopherb@gmail.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clocksource: timer-probe: change log level to warn
Date:   Tue, 16 Apr 2019 22:53:09 +0530
Message-Id: <20190416172309.7428-1-moseschristopherb@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  - In drivers/clocksource/timer-probe.c, the log level for the message
    stating "no matching timers found" should be of warning(4) rather
    than critical(2)
  - Reference:
     - https://e2e.ti.com/support/processors/f/791/t/726024
     - As per the feedback received from Daniel Lezcano

Signed-off-by: Moses Christopher <moseschristopherb@gmail.com>
---
 drivers/clocksource/timer-probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-probe.c b/drivers/clocksource/timer-probe.c
index 028075720334..246b45d22d08 100644
--- a/drivers/clocksource/timer-probe.c
+++ b/drivers/clocksource/timer-probe.c
@@ -50,5 +50,5 @@ void __init timer_probe(void)
 	timers += acpi_probe_device_table(timer);
 
 	if (!timers)
-		pr_crit("%s: no matching timers found\n", __func__);
+		pr_warn("%s: no matching timers found\n", __func__);
 }
-- 
2.17.1

