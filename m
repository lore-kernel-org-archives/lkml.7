Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6637C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3FFF2063F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ago94CZu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfCGRiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:38:19 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42553 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfCGRiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:38:19 -0500
Received: by mail-ed1-f68.google.com with SMTP id j89so14175362edb.9;
        Thu, 07 Mar 2019 09:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pYDdORtI49zbFv1HqxWCX32wqb6wh+6jCM2eUFdE2lM=;
        b=ago94CZuJLIrJXpXcbli2DSvDbViS5xrLxDWs229kYca99FVeMEke7S/U1ZPGPlNg3
         k4323GFsMLnOBQfMqQZOgvad/YFF5LqCzbwe8kDSN/GSGV7hpO2wpeXp3Ia7wRtz9/Uy
         CQE2Ug1X6JEuXWA888zoEusStuOPs9wDZ3D7LTBqAUUBoxQ+wuPNGzbOLSjXfxcraJ+Z
         3zxaLrPcaUSUYedeT51lsmIZBV3SVbTM1RkLG7bqjzThjyExZebSlbJ/nv/qk+GbeWJ1
         T6WYM4Sb9hDOsl5WavHSQXtywIKGT6ij90BGj3jtMOd0PbJl+J51ccVh8tfOGiXMH4Qq
         kQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pYDdORtI49zbFv1HqxWCX32wqb6wh+6jCM2eUFdE2lM=;
        b=YqmpvHquSpILRcViaFX7sLjlBpdkEu9KL6YP8WZPAbPWCPvd1SUY4AXXTpg0OgjwMu
         4oelzVsbiuTx3Q7nTsX63ujHm1QeHIjV3OKkIk8tKU71HiDD1uEYdQsQkUYLGirQvKt0
         jyGdNzlLyeE2mP7lkdv2g/el8jnJbaHJIBXSQ+HKKZS0jQyKV5suJ1HRDxNghnHcFq70
         EOTWo9Cx4mZItAwO0gb/8Nh+TDEOEBmo9UnoMIbQ0hyXcMzPdI/ZmzmfGyFC8BMc9n1k
         GD6B7Ofhz/jsTfOYMx8fjZT48u2vPgsNT6OfYrkfdk/8CZHyg2Z28W72okI1fIJvjmX7
         Vxow==
X-Gm-Message-State: APjAAAVQm/dvJg4DvlDOp32EqJyLygtwG8IKh/w6XT8p3q2752hNWVqB
        zT0jdtwstmAtjTZM8eUGUt5ysM2Z4izmdg==
X-Google-Smtp-Source: APXvYqwfQaJoZazjdCNEPGvA9lcW9B+570wcFvuwnsRkM0H4B9pgAjmIo7qKhcIciV5sR9bZcYk2pg==
X-Received: by 2002:a50:a5f4:: with SMTP id b49mr28958736edc.23.1551980296785;
        Thu, 07 Mar 2019 09:38:16 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id x36sm1505073eda.94.2019.03.07.09.38.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 09:38:16 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] ACPI / sysfs: Restructure get_status
Date:   Thu,  7 Mar 2019 10:38:02 -0700
Message-Id: <20190307173802.3448-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with -Wsometimes-uninitialized, Clang warns:

drivers/acpi/sysfs.c:667:13: warning: variable 'result' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]

Clang can't determine that all cases are covered by the two separate if
statements. We could combine then to look like this:

    int result;

    if (...) {
        ...
    } else if {
        ...
    } else {
        result -EINVAL;
    }

    return result;

However, at that point, we can further simplify this function by only
using result when absolutely needed and just direct returning the value
of the function.

Link: https://github.com/ClangBuiltLinux/linux/issues/388
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/acpi/sysfs.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 41324f0b1bee..6ed785cadad9 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -651,23 +651,18 @@ static void acpi_global_event_handler(u32 event_type, acpi_handle device,
 static int get_status(u32 index, acpi_event_status *status,
 		      acpi_handle *handle)
 {
-	int result;
-
-	if (index >= num_gpes + ACPI_NUM_FIXED_EVENTS)
-		return -EINVAL;
-
 	if (index < num_gpes) {
-		result = acpi_get_gpe_device(index, handle);
+		int result = acpi_get_gpe_device(index, handle);
 		if (result) {
 			ACPI_EXCEPTION((AE_INFO, AE_NOT_FOUND,
 					"Invalid GPE 0x%x", index));
 			return result;
 		}
-		result = acpi_get_gpe_status(*handle, index, status);
+		return acpi_get_gpe_status(*handle, index, status);
 	} else if (index < (num_gpes + ACPI_NUM_FIXED_EVENTS))
-		result = acpi_get_event_status(index - num_gpes, status);
+		return acpi_get_event_status(index - num_gpes, status);
 
-	return result;
+	return -EINVAL;
 }
 
 static ssize_t counter_show(struct kobject *kobj,
-- 
2.21.0

