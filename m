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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14845C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D064220821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tYTU/hUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730035AbfDPQcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:32:54 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45392 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDPQcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:32:54 -0400
Received: by mail-pl1-f196.google.com with SMTP id bf11so10581072plb.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 09:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=p/OnrsWOg/m/rXsYLVRTgg7ytcaibA5V2ZfF8xbURv4=;
        b=tYTU/hUap1jwXIjb7KJkvmQyoSIoSrS2w2CC4Iq8zCkqUvxJaf5+KDFAF4op4aey3R
         nqFvuK8UN3q+ymLkILIhaZJPVi2fXz0o9W+eEHrdQnCJpezL+gV9jN8A16He9wJSLx81
         ySrYgFk3qnM+NuFWgwRoxSSZa5Ipe/DrXyWvkB/goPjcWKHPSj2KdazsGOMfVr7X/pJJ
         gLgn2d92dDbvuXWn004L5hsn6LBG51XPP+HBU+zDSVai7jhSIIpl542RjxIa4qoCmc+B
         LfTjeHkcB8xgQVC9SLOuSj8xnImjJgVk3FT9Gfuum+qGCccQoIMtAybLzOdPVyNtW+ue
         swcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p/OnrsWOg/m/rXsYLVRTgg7ytcaibA5V2ZfF8xbURv4=;
        b=RqMjzyEUJ7G4MMGtPFHvr2jDz1lvCOKXAjiHn+JYdVC1Tc2e8K5vXiiSOTrZ7RPsi3
         LCcdIfwYyjc6U4L75ejEItg2MqpAoYgRSXSDBm3N89OBgx4NiXKTPdPy1tBu6wii5Oot
         pZ5yRkodE0H3NJT7sGzyc9XTkGKR3y2rvXKgHceayExSk7K36PivFTTMsntZk8mwyfoy
         PrFgTZB+KogwiYzyK2YaTmbjzLnjE0qzha2hceL65A2QCBqpSO4pwEGKDUh/9iyoPveX
         sKdkQRHEFa01fb0jthIDAupJe/pft1vjDtofixOe2VqNc502Sqa8J0aN1M0HasgNqSUJ
         Lhsg==
X-Gm-Message-State: APjAAAXe3WNtASJ+IQqggex0crQCYwjLJ04n148NUfzWxGLY4zDh/Nml
        Wp5Dz1Mgi8uUU1TXyMld4Tk=
X-Google-Smtp-Source: APXvYqysE3CrWR7x28a55ScdWBLFZqF2Yh6RMNfXvt246TgaFeEjW0PMxxNuWhQxK8mgaDSzeCa0hA==
X-Received: by 2002:a17:902:1486:: with SMTP id k6mr49023181pla.208.1555432373828;
        Tue, 16 Apr 2019 09:32:53 -0700 (PDT)
Received: from localhost.localdomain ([103.227.98.54])
        by smtp.googlemail.com with ESMTPSA id q128sm83164085pga.60.2019.04.16.09.32.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 09:32:53 -0700 (PDT)
From:   Moses Christopher <moseschristopherb@gmail.com>
Cc:     moseschristopherb@gmail.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clocksource: timer-probe: change log level to info
Date:   Tue, 16 Apr 2019 22:02:30 +0530
Message-Id: <20190416163230.4992-1-moseschristopherb@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  - In drivers/clocksource/timer-probe.c, the log level for the message
    stating "no matching timers found" should be informational rather
    than critical.
  - Reference:
     - https://e2e.ti.com/support/processors/f/791/t/726024

Signed-off-by: Moses Christopher <moseschristopherb@gmail.com>
---
 drivers/clocksource/timer-probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-probe.c b/drivers/clocksource/timer-probe.c
index 028075720334..f0dcb41e079f 100644
--- a/drivers/clocksource/timer-probe.c
+++ b/drivers/clocksource/timer-probe.c
@@ -50,5 +50,5 @@ void __init timer_probe(void)
 	timers += acpi_probe_device_table(timer);
 
 	if (!timers)
-		pr_crit("%s: no matching timers found\n", __func__);
+		pr_info("%s: no matching timers found\n", __func__);
 }
-- 
2.17.1

