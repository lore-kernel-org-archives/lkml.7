Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7625FC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4985F2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="njxaDbW6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731271AbfG3Nrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 09:47:47 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:55021 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbfG3Nrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 09:47:47 -0400
Received: by mail-yw1-f74.google.com with SMTP id v3so47314985ywe.21
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 06:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=6y8Zx9TfLiZrL5lPVE8UPHZWX8fiWMpaaIJpa8RuQ8s=;
        b=njxaDbW6OkR0+qoulTNG0hQgYmD2uhbqvXbWrkTwP/q37rH3ODxN0ECvo3BDJdN/D+
         8LAcx61EzO66gkqmFiskho7lp081UIeU6ft6rpmDpP02KYPePXjUEKU7RNKjwsDpvfbt
         /lv0nIiy/V0Omi/KTvQHFZ0ReECwlWs7az+wEUZI0fVcF/EWSCk7uPt7ha4OYBVbe5xF
         +3TnGQiKfSRm5QpSi3iPjCQoXpoFuKl0i2vLZPiNpoj2qi0Pw5E++fQyF6Ci5R1w/qxR
         BZwT6e7JG3u0B+ayZDvvHcuL8Xyy0gkKvW26ILBCwDM7sJ2jOkG3g0jpnNtFjfcpk49l
         4Y5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=6y8Zx9TfLiZrL5lPVE8UPHZWX8fiWMpaaIJpa8RuQ8s=;
        b=HYVkhvhTZDoaJFBXZHKN6J16m+voKAcxGqWFGqCUJ2Jq0kXOw6IDyYdhJt0glZqv89
         JiPsUZpkbyAiaBnSo+fFyPVL1il4a3o0FoRkVybjVcA4f3S3ixuwkOvdtKRWfukZAFg8
         9Z+Py0KL6Pzo1TX4x0Iujki9VF5evkTsEZdYte/R6HPtNwt4o3tx+ryzjCd8wqyEGAKg
         45RVRzfGJxJFZHqqrffaQtAnvYU/JGhgQ5h1wdTO2iOHjsJKw/Nw1Rl+O0tfnO/UJwhF
         CM7nT/aCCeKGYKDv3/pkZC4BN5lsPmFyPE1bsYwNXJPtIBa5ZEyNc/M65tyECvgwIwuo
         eOzA==
X-Gm-Message-State: APjAAAXhQuTJ5Eek0/3rPSaTXTOi5sydDfImvDB1IzOyuIMs75Pa1vzH
        TSs7v5Od9pz69pEjy6pp3L0MJoarZhHR
X-Google-Smtp-Source: APXvYqyELFr9EqSpnvYZHxDCxa04SqdPpisD8klKD+ZjsEzO5Pgt9OlKXhBz/o/zQYpsKxVaCHPKPK3k99ig
X-Received: by 2002:a81:5e8a:: with SMTP id s132mr63397428ywb.262.1564494465939;
 Tue, 30 Jul 2019 06:47:45 -0700 (PDT)
Date:   Tue, 30 Jul 2019 21:47:04 +0800
Message-Id: <20190730134704.44515-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v4] platform/chrome: cros_ec_trace: update generating script
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, rrangel@chromium.org
Cc:     linux-kernel@vger.kernel.org, cychiang@google.com,
        dgreid@google.com, tzungbi@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original script generates unneeded ", \" on the last line which
results in compile error if one would forget to remove them.  Update the
script to not generate ", \" on the last line.  Also add a define guard
for EC_CMDS.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
Changes from v1:
- simpler awk code
Changes from v2:
- use c style comments instead of c++ style
- use '@' delimiter in sed instead of '/' to avoid unintentional end of
  comment "*/"
Changes from v3:
- more detail commit message
- add define guard for EC_CMDS

 drivers/platform/chrome/cros_ec_trace.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_trace.c b/drivers/platform/chrome/cros_ec_trace.c
index 0a76412095a9..1412ae024435 100644
--- a/drivers/platform/chrome/cros_ec_trace.c
+++ b/drivers/platform/chrome/cros_ec_trace.c
@@ -5,8 +5,27 @@
 
 #define TRACE_SYMBOL(a) {a, #a}
 
-// Generate the list using the following script:
-// sed -n 's/^#define \(EC_CMD_[[:alnum:]_]*\)\s.*/\tTRACE_SYMBOL(\1), \\/p' include/linux/mfd/cros_ec_commands.h
+/*
+ * Generate the list using the following script:
+ * sed -n 's@^#define \(EC_CMD_[[:alnum:]_]*\)\s.*@\tTRACE_SYMBOL(\1), \\@p' \
+ * include/linux/mfd/cros_ec_commands.h | awk '
+ * BEGIN {
+ *   print "#ifndef EC_CMDS";
+ *   print "#define EC_CMDS \\";
+ * }
+ * {
+ *   if (NR != 1)
+ *     print buf;
+ *   buf = $0;
+ * }
+ * END {
+ *   gsub(/, \\/, "", buf);
+ *   print buf;
+ *   print "#endif";
+ * }
+ * '
+ */
+#ifndef EC_CMDS
 #define EC_CMDS \
 	TRACE_SYMBOL(EC_CMD_PROTO_VERSION), \
 	TRACE_SYMBOL(EC_CMD_HELLO), \
@@ -119,6 +138,7 @@
 	TRACE_SYMBOL(EC_CMD_PD_CHARGE_PORT_OVERRIDE), \
 	TRACE_SYMBOL(EC_CMD_PD_GET_LOG_ENTRY), \
 	TRACE_SYMBOL(EC_CMD_USB_PD_MUX_INFO)
+#endif
 
 #define CREATE_TRACE_POINTS
 #include "cros_ec_trace.h"
-- 
2.22.0.709.g102302147b-goog

