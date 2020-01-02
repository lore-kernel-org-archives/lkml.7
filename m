Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14070C2D0DE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 02:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9C620866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 02:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="Js67nZwO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgABCfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 21:35:31 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42559 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbgABCf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 21:35:28 -0500
Received: by mail-pl1-f193.google.com with SMTP id p9so17275474plk.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 18:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w0hfOFdpppNhfx4JZoVAcogfBULm51LLYT9TT+3UyFc=;
        b=Js67nZwO+nVQTqkYaEx6Xf/tTAeSIoxp5sPr86Z2pqgsGjEX+U3OY8mgLrBTM9r1C5
         LgbixzeQrcBfDQ/rJtPWYom51EsTh6eJBkxB2i++nLDopKaJmfrU7hmrTxpmZCU+24q/
         NqGPoFmaHempS0pAf8xrbcK6qrcZXYYSMFTu2y3ErmHErkhEoW12h2Y2wXO8BHjKC0qM
         tw2vdf0e+mhgwKTMd79/V6z9x6vr09uU7xqMXAx307DNHO+2mGkvdmpQlul6SnXHeFjL
         fdPtI4VHJFo1331IiHv7ObC+hNB4ySbAuCamBupdf1Zs2xmOzMm6aEOfxpKsEYr/+CK/
         wXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w0hfOFdpppNhfx4JZoVAcogfBULm51LLYT9TT+3UyFc=;
        b=MOxI96vHnqBkGk6U/7z6LB8RNoOCA3C2LNB/Hs7p167baEhdherXj690RvMDXyxZz+
         yafjuKxb9G9HUW/8vYustdp7uGHrD1WO6euRFvIXgx09KFMVgrQfwRjeo0VCzRjY8ZsU
         5EyQJDzTyE12wIJC6Pt+mGcyEeG1nEJhOhkR3r93d+HpAOv/UBBckIS2NUcCiE6ZY4Ex
         Q52jRAtx/tG9cFoAmky/usVx5TfuN4JaToJEBjtAnrtd+66WV7hN+e/NNKqMsQnkMvbd
         UzhO3rflcCCylcP4E0SObx/5Id7WPjQfaxdDhsPnvj1EGvOJG/0gpJMtrUpXe4lRbC4d
         cktQ==
X-Gm-Message-State: APjAAAVR94EYclXDpXVEltMXiewLSCuYJggyE0O8aw18Q9AhbpG492GG
        2LFRyJhHeyM14k2W5sgWXLGRZw==
X-Google-Smtp-Source: APXvYqxf/9Q8Ac+TQyreUWpYYFYUsiYcKLQYmXqn1dMwWpID07CCOl05uetAvTn2nDhEgLHTXG4XAA==
X-Received: by 2002:a17:90a:d807:: with SMTP id a7mr17422645pjv.15.1577932527663;
        Wed, 01 Jan 2020 18:35:27 -0800 (PST)
Received: from libai.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id s18sm56572809pfh.179.2020.01.01.18.35.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jan 2020 18:35:27 -0800 (PST)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, pizhenwei@bytedance.com
Subject: [PATCH v2 2/2] misc: pvpanic: add crash loaded event
Date:   Thu,  2 Jan 2020 10:35:13 +0800
Message-Id: <20200102023513.318836-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200102023513.318836-1-pizhenwei@bytedance.com>
References: <20200102023513.318836-1-pizhenwei@bytedance.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some users prefer kdump tools to generate guest kernel dumpfile,
at the same time, need a out-of-band kernel panic event.

Currently if booting guest kernel with 'crash_kexec_post_notifiers',
QEMU will receive PVPANIC_PANICKED event and stop VM. If booting
guest kernel without 'crash_kexec_post_notifiers', guest will not
call notifier chain.

Add PVPANIC_CRASH_LOADED bit for pvpanic event, it means that guest
kernel actually hit a kernel panic, but the guest kernel wants to
handle by itself.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/misc/pvpanic.c      | 9 ++++++++-
 include/uapi/misc/pvpanic.h | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
index 3f0de3be0a19..a6e1a8983e1f 100644
--- a/drivers/misc/pvpanic.c
+++ b/drivers/misc/pvpanic.c
@@ -10,6 +10,7 @@
 
 #include <linux/acpi.h>
 #include <linux/kernel.h>
+#include <linux/kexec.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -33,7 +34,13 @@ static int
 pvpanic_panic_notify(struct notifier_block *nb, unsigned long code,
 		     void *unused)
 {
-	pvpanic_send_event(PVPANIC_PANICKED);
+	unsigned int event = PVPANIC_PANICKED;
+
+	if (kexec_crash_loaded())
+		event = PVPANIC_CRASH_LOADED;
+
+	pvpanic_send_event(event);
+
 	return NOTIFY_DONE;
 }
 
diff --git a/include/uapi/misc/pvpanic.h b/include/uapi/misc/pvpanic.h
index cae69a822b25..54b7485390d3 100644
--- a/include/uapi/misc/pvpanic.h
+++ b/include/uapi/misc/pvpanic.h
@@ -4,5 +4,6 @@
 #define __PVPANIC_H__
 
 #define PVPANIC_PANICKED	(1 << 0)
+#define PVPANIC_CRASH_LOADED	(1 << 1)
 
 #endif /* __PVPANIC_H__ */
-- 
2.11.0

