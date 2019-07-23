Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D39FC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BCC72190F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BIgbSuhO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389350AbfGWMEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 08:04:38 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:33605 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387746AbfGWMEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 08:04:38 -0400
Received: by mail-qk1-f202.google.com with SMTP id t196so36286799qke.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 05:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7twxm8O35NYk7pfkX+O8o5ZTBTioI+KPwipSFL00ox8=;
        b=BIgbSuhOvt/B/ZfHXKHsBY4f45MRi/Kx6NWWXbjTBQEOg9NP33sIS4K0nwtKNxe1jT
         kLKw4Xt3oxzK7AVfM6emxV/sx7KdtGNQE1ohUhKAcMmwh94HQ45sV9dqhcFMtz1NfSCH
         7zkfuO4U9YWxcjCIpfN2H7rfGfY6Z8RcLlNVBgS52ATnzQcUtqOXcBnLWlbua7tpvkVA
         ei9eFUe93bmS9Y7CuhDBzCcGPmxwcK6h9PkqRR6GjZ9IiytnasCLwicDaXIRc7FrMfcc
         i42H1pwuUBe5NRNrgytToB9+V8LwAlufEYfGAb93IXIeZBTEFk0ftYqASTYykC36p1JY
         eykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7twxm8O35NYk7pfkX+O8o5ZTBTioI+KPwipSFL00ox8=;
        b=W8kHpObDaq3r70YMiTOEVF/4zTlVf+0dTdbMbHOagkGCT03ETnbuEx68qz7vzr0a9U
         IHXQBaOJe3QhiYzRBhYBBOIxd/6Lvti2YvHienjsc827NpyoCDA94M8/Yqy5ltJkgX3/
         QBhYAXohUMUPNnsYFu0ZdeIqwmIDaQrvSdaSAfx32RCd+vskzwbv5Fg93CeNd/2G7XI/
         MgR6njCH6BpdrqyKKuHu3o1LqOYLmL+i/wMkmGRcoCkRHCOA2uodyejGGsjAvFZQh2Ha
         mwRrhACh99vFwxXGrNKQ6281vzU/R1C3CmamDqZqcMQfMv4P7FzzgSx6B06+9MHPDYNE
         qyqw==
X-Gm-Message-State: APjAAAVXpAHYzrzlP8B95IBiiMLmgG2MUw0uDIZkPBhtbQyJJlzfJMsh
        EvpcMgc3Yw2MwShnCgFxTbDYzJwo9Fo3
X-Google-Smtp-Source: APXvYqw8cTauj3YpqhNuKuSK13wy3Jt+l3JYQHz5PjHLILV66ahMm6F4/n18WcowYLwjkrumzrEgRSaY+f7H
X-Received: by 2002:a37:a346:: with SMTP id m67mr51388376qke.237.1563883476850;
 Tue, 23 Jul 2019 05:04:36 -0700 (PDT)
Date:   Tue, 23 Jul 2019 20:04:03 +0800
Message-Id: <20190723120403.219330-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH] platform/chrome: cros_ec_trace: update generating script
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
 drivers/platform/chrome/cros_ec_trace.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_trace.c b/drivers/platform/chrome/cros_ec_trace.c
index 0a76412095a9..9b6aba22441f 100644
--- a/drivers/platform/chrome/cros_ec_trace.c
+++ b/drivers/platform/chrome/cros_ec_trace.c
@@ -6,7 +6,23 @@
 #define TRACE_SYMBOL(a) {a, #a}
 
 // Generate the list using the following script:
-// sed -n 's/^#define \(EC_CMD_[[:alnum:]_]*\)\s.*/\tTRACE_SYMBOL(\1), \\/p' include/linux/mfd/cros_ec_commands.h
+// sed -n 's/^#define \(EC_CMD_[[:alnum:]_]*\)\s.*/\tTRACE_SYMBOL(\1), \\/p' \
+// include/linux/mfd/cros_ec_commands.h | awk '
+// BEGIN {
+//   on = 0;
+// }
+// {
+//   if (on)
+//     print buf;
+//   else
+//     on = 1;
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

