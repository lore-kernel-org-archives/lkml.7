Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C9EC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B4422543
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qMcb0tg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390278AbfGWNeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 09:34:01 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:38455 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732181AbfGWNeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:34:01 -0400
Received: by mail-qt1-f202.google.com with SMTP id r58so38571803qtb.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 06:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Sgnu4vpaA9XtGSZHcQIHrWEp1ODMF66MA7HE6PUCeb0=;
        b=qMcb0tg6w5Hgz5CXMpdF61VWMgpjZRT022UxsxP/x4R1+wYJcZUdRNfdF0rZSO1Sf6
         f8u8RMtgKPPoI5O2nvFaGLkLzeGs1HQ/+em4S7GGwR+aQwu46L8psfJRk7bEd1nvogeR
         amDLIfE61X64r7wuJbfgMX8JTFoqsc/yTnCeTY7LMHQpusKm7PLf9YymyDYm6V6gGvsR
         cCam2td6JZ8c4sDlIadfByNhhppzG/k1FfiBHlf13vXnRrpLKE13kquPOh8dETueOoxl
         cdwK28hHC2tA6p0fWJQP9K5rSDaMsz9ClwLOIB5eBPEb3NAYgTk78W+GA8yoW8cNYAnW
         Bnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Sgnu4vpaA9XtGSZHcQIHrWEp1ODMF66MA7HE6PUCeb0=;
        b=XDeCLHMaa6xmpJDxZIlQ5Va36vDPbBUMRlV7632a5mrGXuxPjMlPJ41tG7ihR7uDyd
         HIqsQ+ziwRrv1443vZmFXsdfPGG84eCPDrSsbc44WLpsAK70HI+MpTte0ZNjCXh7yhA1
         39qMd4qNU5nm4fr+Dyjbo6+5+lzimz1qHxjsvj8oKDRlX7lnaPPsKS8gVttu/v0mWcun
         1cjcb+giiqq7jmfZ7LktMvrOc7M0KQdZ8i9lgAO/Y1X7uwNmHjeyV5U9quC49OGtqlRW
         gweG/EsujBzYK4ucruPFy6zKzn/LvwC5WA0kQFeGH/EkaJO1261Alsv899koHRtJZeew
         bfwQ==
X-Gm-Message-State: APjAAAWap4PoLAkJDlsQO5/QJs8rLdR7SMHmqUEAeJS/xeut6aL2TZD8
        Iqk7DuKPT1+vo8uZ3EDGzUh15HJimWSD
X-Google-Smtp-Source: APXvYqwtzu9aeMCIKMEiBMz0fAzsdRhGOi6XU++84WSHIsiecjBtKVrhgT0aC0/oz6nlkaMysnlfNYLM4R3M
X-Received: by 2002:ac8:3fb3:: with SMTP id d48mr53297333qtk.290.1563888840244;
 Tue, 23 Jul 2019 06:34:00 -0700 (PDT)
Date:   Tue, 23 Jul 2019 21:33:22 +0800
Message-Id: <20190723133322.243286-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH v2] platform/chrome: cros_ec_trace: update generating script
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org
Cc:     linux-kernel@vger.kernel.org, cychiang@google.com,
        dgreid@google.com, tzungbi@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To remove ", \" from the last line.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
Changes from v1:
- simpler awk code

 drivers/platform/chrome/cros_ec_trace.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_trace.c b/drivers/platform/chrome/cros_ec_trace.c
index 0a76412095a9..667460952dad 100644
--- a/drivers/platform/chrome/cros_ec_trace.c
+++ b/drivers/platform/chrome/cros_ec_trace.c
@@ -6,7 +6,18 @@
 #define TRACE_SYMBOL(a) {a, #a}
 
 // Generate the list using the following script:
-// sed -n 's/^#define \(EC_CMD_[[:alnum:]_]*\)\s.*/\tTRACE_SYMBOL(\1), \\/p' include/linux/mfd/cros_ec_commands.h
+// sed -n 's/^#define \(EC_CMD_[[:alnum:]_]*\)\s.*/\tTRACE_SYMBOL(\1), \\/p' \
+// include/linux/mfd/cros_ec_commands.h | awk '
+// {
+//   if (NR != 1)
+//     print buf;
+//   buf = $0;
+// }
+// END {
+//   gsub(/, \\/, "", buf);
+//   print buf;
+// }
+// '
 #define EC_CMDS \
 	TRACE_SYMBOL(EC_CMD_PROTO_VERSION), \
 	TRACE_SYMBOL(EC_CMD_HELLO), \
-- 
2.22.0.657.g960e92d24f-goog

