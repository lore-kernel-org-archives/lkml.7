Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066B1C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B5C2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ogN5+2Jm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbfG2WCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 18:02:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45401 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbfG2V6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:58:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id f9so63438433wre.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L061fqxdJDm/6UczpPY16FNAif/88rIuI3OcvE+KkOc=;
        b=ogN5+2JmD4SlHV8uEUHv+BEicob+HzzLyT+ZxW7J54Ky+DgN8vY5Fwqm9+ru6WP5iy
         MrwTmdJGTd4K++K19BWpRt8aUQduNxQtkZSxmdHpXa3yNTwEJ0UOUDvAwsZe1YwQrjBo
         d1qFYla1wpXvtnxbS9GICk8FlqG8a+Rt7BwPo4GwzaizQFLB8EECUcEGwuu8OEuu+Q9R
         g+9TQuvAEehDZRFatPpeW4L8RhmCul5N+SQLeHDsQ5xlhAvDOxwj8tr33v+X+EK+Kauw
         lh+WrfbqXXm7t8KkEJ04ltvI4XbtAYWRBrojFExFYp5LxJVKW7yx/f2HGOklOjNKd4w6
         wHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L061fqxdJDm/6UczpPY16FNAif/88rIuI3OcvE+KkOc=;
        b=K6sJjnrEVbwB3w3Acryma9K3laNbGoTBo5pSVMvd1bQyO3u643CyERMkyV2oVHlsIi
         ONsi+cusLzk/FAxAaQBatI/XxCVXCS83lWY8xLBeSHJ6gM2I1IwNNNMrkkTNAE56NU07
         Hi+8jY4YIFygCk6drUUrOlxfQQw9Jaf0DKzK+NxEt0twra426P6T5qNhEmbH1VWSPTSv
         9p5LOIAGh/LHmBAsewpZWqhNc3Zk3y06OKnLEoxerOH/4DDCIEGsQwBKEGLD9iYotuFL
         bB4O1Lsw7976yl9qyFuI1iOpBAfpU/nhQEnvZSAz5ZCxBKVu8BaObTj2Q0QTwyZUhPMT
         svNg==
X-Gm-Message-State: APjAAAVn8qwq7Bp9YVRqRdmFwyfm3Z97/MmSKXOsGls1CtEVGGwETohA
        r4edBDx5+BbMJcatjVvCDJ6x3IraH7j9pYRVeSu9Ym7pabR0LUntXpGVdBOYKvY8ahVSgLDmk71
        tyItpJCZkqMmTDT5T/FAiBIbQkN68G9O4MBq++7xRvDcd/Ij35VDwQBMgfUb6dotlqA8oA+00es
        YJPf/4F1xiVJC+Y5HfXpUe3wTb2jkCyttJNIjYdiM=
X-Google-Smtp-Source: APXvYqzyt4liLdH6hYq+6/cRinDeCKXPr7U1KvpQ1kRUTB2GYCu8pn2Fx+mC6pBuAe9Gi5DEP/ackg==
X-Received: by 2002:adf:f6cb:: with SMTP id y11mr36925855wrp.245.1564437483010;
        Mon, 29 Jul 2019 14:58:03 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:02 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv5 02/37] timens: Add timens_offsets
Date:   Mon, 29 Jul 2019 22:56:44 +0100
Message-Id: <20190729215758.28405-3-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729215758.28405-1-dima@arista.com>
References: <20190729215758.28405-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@openvz.org>

Introduce offsets for time namespace. They will contain an adjustment
needed to convert clocks to/from host's.

Allocate one page for each time namespace that will be premapped into
userspace among vvar pages.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 MAINTAINERS                    |  1 +
 include/linux/time_namespace.h |  1 +
 include/linux/timens_offsets.h |  8 ++++++++
 kernel/time_namespace.c        | 14 ++++++++++++--
 4 files changed, 22 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/timens_offsets.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ce6ff88f7efd..b58c49d331eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12837,6 +12837,7 @@ S:	Maintained
 F:	fs/timerfd.c
 F:	include/linux/timer*
 F:	include/linux/time_namespace.h
+F:	include/linux/timens_offsets.h
 F:	kernel/time_namespace.c
 F:	kernel/time/*timer*
 
diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 9507ed7072fe..b6985aa87479 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -8,6 +8,7 @@
 #include <linux/nsproxy.h>
 #include <linux/ns_common.h>
 #include <linux/err.h>
+#include <linux/timens_offsets.h>
 
 struct user_namespace;
 extern struct user_namespace init_user_ns;
diff --git a/include/linux/timens_offsets.h b/include/linux/timens_offsets.h
new file mode 100644
index 000000000000..7d7cb68ea778
--- /dev/null
+++ b/include/linux/timens_offsets.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_TIME_OFFSETS_H
+#define _LINUX_TIME_OFFSETS_H
+
+struct timens_offsets {
+};
+
+#endif
diff --git a/kernel/time_namespace.c b/kernel/time_namespace.c
index 7ee6be0647bc..f849c59f1108 100644
--- a/kernel/time_namespace.c
+++ b/kernel/time_namespace.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/cred.h>
 #include <linux/err.h>
+#include <linux/mm.h>
 
 static struct ucounts *inc_time_namespaces(struct user_namespace *ns)
 {
@@ -47,6 +48,7 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
 {
 	struct time_namespace *ns;
 	struct ucounts *ucounts;
+	struct page *page;
 	int err;
 
 	err = -ENOSPC;
@@ -59,15 +61,22 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
 	if (!ns)
 		goto fail_dec;
 
+	page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (!page)
+		goto fail_free;
+	ns->offsets = page_address(page);
+	BUILD_BUG_ON(sizeof(*ns->offsets) > PAGE_SIZE);
+
 	err = ns_alloc_inum(&ns->ns);
 	if (err)
-		goto fail_free;
+		goto fail_page;
 
 	ns->ucounts = ucounts;
 	ns->ns.ops = &timens_operations;
 	ns->user_ns = get_user_ns(user_ns);
 	return ns;
-
+fail_page:
+	free_page((unsigned long)ns->offsets);
 fail_free:
 	kfree(ns);
 fail_dec:
@@ -95,6 +104,7 @@ void free_time_ns(struct kref *kref)
 	struct time_namespace *ns;
 
 	ns = container_of(kref, struct time_namespace, kref);
+	free_page((unsigned long)ns->offsets);
 	dec_time_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
 	ns_free_inum(&ns->ns);
-- 
2.22.0

