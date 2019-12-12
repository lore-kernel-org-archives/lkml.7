Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42143C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BBCC20663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="E2t3y5q1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbfLLMce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 07:32:34 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38126 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729092AbfLLMcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 07:32:33 -0500
Received: by mail-pf1-f196.google.com with SMTP id x185so696109pfc.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 04:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=9sBfV8A9Gi7/9h4NUiER2g/Z/6X+tDwbNIeFjDaeKe8=;
        b=E2t3y5q1A6U3YMflqCkd7C6Y6H2tEc6Ey4FQjStJzai3KPK0UZS9UYmrU86ZrMb53G
         h768jeRqjoAJwi2estu/gfeZPaa3Ab42PUTP4PR3T0BaUzkENI3b2LbVscnALiskDiwl
         yS9OnYGglwPPIf06sSBHq32aZkuWJ4/ofHYqzKTxChaDrLZ98Ahk6OKojj3vJ0eWNrUm
         WCWUFZ1uafgotLAsTtIaKPRfoWeMeLigrswYmu2gxsC9SH6K1eusSSY0VwDzys3NZxgf
         MXoGsTx3KUdRYIBNmYlhyIBNf98iL4N2beVglONk+Aoz2kakS7Wc3N0nwiQIMCls420f
         WbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9sBfV8A9Gi7/9h4NUiER2g/Z/6X+tDwbNIeFjDaeKe8=;
        b=AbEUMpvkrRko0/ak1MY7noyS+aGwGVytMVuDUbmJWhsuZyER8fO1AWtD3hMSnAeX6P
         Q6a6+zKeOpLQSJ8pgbMYkGehOjyNXCLGqI5G70KZlKNlFLyTL4xSuXqkRsvU7dTWRfF6
         Ui0xkT16mXCd03+JbbW4KQe5XCpI/si7Wo6a5qGIWksbvAtLVeozbN+PHBEQUXPoHuwx
         p3Wydht5Roqc46ZgxMW8tUWWfCIcNB7Uaa/6PQ63lbSiKO6tzZtdsirXlXYX5Ts0p+TR
         fr1XHu1KzUGv6dTpJJshiwPN6jMYo5Jcwo9V+xfeym7/c103DO3/HsTPuuPvBhHrdthy
         58lQ==
X-Gm-Message-State: APjAAAXMoD0ozHqjioacbWd/QJj0wz+HF1akmQfma57cYiMrFJ3bv9BP
        876n7jnJ6xyiH6ft+WHWFsjbBRt6GoU=
X-Google-Smtp-Source: APXvYqwKVOoYX/80PIQN+LH+fun7vrr4coCVo6LPlyIiAprjSJCbzPxw8DC0ERzCeDgepVPv9645aQ==
X-Received: by 2002:a63:31d1:: with SMTP id x200mr9435694pgx.405.1576153953124;
        Thu, 12 Dec 2019 04:32:33 -0800 (PST)
Received: from libai.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id t30sm6571490pgl.75.2019.12.12.04.32.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 04:32:32 -0800 (PST)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org, peng.hao2@zte.com.cn
Cc:     linux-kernel@vger.kernel.org, pizhenwei@bytedance.com
Subject: [PATCH] misc: pvpanic: add crash loaded event
Date:   Thu, 12 Dec 2019 20:32:26 +0800
Message-Id: <20191212123226.1879155-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some users prefer kdump tools to generate guest kernel dumpfile,
at the same time, need a out-of-band kernel panic event.

Currently if booting guest kernel with 'crash_kexec_post_notifiers',
QEMU will recieve PVPANIC_PANICKED event and stop VM. If booting
guest kernel without 'crash_kexec_post_notifiers', guest will not
call notifier chain.

Add PVPANIC_CRASH_LOADED bit for pvpanic event, it means that guest
actually hit a kernel panic, but kernel wants to handle by itself.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/misc/pvpanic.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
index 95ff7c5a1dfb..a8cc96c90550 100644
--- a/drivers/misc/pvpanic.c
+++ b/drivers/misc/pvpanic.c
@@ -10,6 +10,7 @@
 
 #include <linux/acpi.h>
 #include <linux/kernel.h>
+#include <linux/kexec.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -19,6 +20,7 @@
 static void __iomem *base;
 
 #define PVPANIC_PANICKED        (1 << 0)
+#define PVPANIC_CRASH_LOADED    (1 << 1)
 
 MODULE_AUTHOR("Hu Tao <hutao@cn.fujitsu.com>");
 MODULE_DESCRIPTION("pvpanic device driver");
@@ -34,7 +36,13 @@ static int
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
 
-- 
2.11.0

