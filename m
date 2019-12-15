Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A23CC43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 03:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E04D62072B
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 03:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="WXIq8DfW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfLODsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 22:48:55 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45633 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfLODsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 22:48:54 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22so25554pls.12
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 19:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w0hfOFdpppNhfx4JZoVAcogfBULm51LLYT9TT+3UyFc=;
        b=WXIq8DfWNNqntE5sjsiiJc8aM0hdIZ0I0iplda6l934CZG411RaQ3JmsLvd4ZSsPAk
         VjYR8qXVjX+ya/TxiWnNagUS9JbI2E9WjIS+Bo/Zoeoe5s22klWAobZRrAkqE1kQI/a+
         qEEDNBC8F/Gn9zTTJQ5wctke9kAsLaGvcPATTj0OiwfDQbjiNqgVc6NRAgV6w5HHQvju
         nXzPc/OKWse1ASdw5Bo20+Cd5M3fYsP6EvU4g0PxVaQFWVB9etPtOUa8TPt362LzPf4S
         KyuoTqGSg5ZPwScgXEB4HF3jATmyB3piuaRI35WQJw60J4iJMFetvmQInHfPyZCObIEx
         TvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w0hfOFdpppNhfx4JZoVAcogfBULm51LLYT9TT+3UyFc=;
        b=PPcgmPi0LA0fvWSAMlqr/GWBxGnvjmRjB2YBG1g8nb9ar2HTErtGdqEDHvfgsrLcrz
         erCLsxtA0N3zivxFV4dzSNw2+rv3HLUGKjLrBe4myZ+Fsj5N6pYeSA5dFEp6+fHgHUVR
         ImobVtUwfL9YSiMphywo5oL+IIYuDqY+59opXxyn9SZgZDb2xJDGJWgR4UYbr4UpZwUA
         +rMvW1vGjUWCmI0p/OF+TyJC2kdO6/qpaGA9jXLxR28oR+U0QQcfFRn97Uz0783bAmvG
         IAIeYVKF0JeHS/vj5Uf6uAyI2Mpr35MTobNZUzfXp2a+Q+8R1+IF5GdHXZOGkXf0srt4
         iN0w==
X-Gm-Message-State: APjAAAWkC1skmUSeFtV1lLTzTt1ptPHYHrTwkUgR5/AIrKNeBvJRa2hl
        XdN9eWwzFP5UMc59bUpybIuUGQ==
X-Google-Smtp-Source: APXvYqzTbYlIqJ8ZOlpjDEpI4B8TCZfg8PLPqYYRQCl91Ux3tYZGqDLC2hOMJRjg9YCn8mjdYZKayw==
X-Received: by 2002:a17:902:b788:: with SMTP id e8mr9090440pls.1.1576381734127;
        Sat, 14 Dec 2019 19:48:54 -0800 (PST)
Received: from libai.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id e10sm17437727pfm.3.2019.12.14.19.48.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Dec 2019 19:48:53 -0800 (PST)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org, peng.hao2@zte.com.cn
Cc:     hutao@cn.fujitsu.com, linux-kernel@vger.kernel.org,
        pizhenwei@bytedance.com
Subject: [PATCH v2 2/2] misc: pvpanic: add crash loaded event
Date:   Sun, 15 Dec 2019 11:48:40 +0800
Message-Id: <20191215034840.2273096-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191215034840.2273096-1-pizhenwei@bytedance.com>
References: <20191215034840.2273096-1-pizhenwei@bytedance.com>
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

