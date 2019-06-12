Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54FDC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C45215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="oGuYhpnr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbfFLT0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 15:26:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53317 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbfFLT0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:26:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id x15so7718296wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 12:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q56szzhx2AE9dZCpkI34NJHt0RlEy4uSIw0ceHqdiRg=;
        b=oGuYhpnrJRGU3h4rHrFnJkocDvvxqZ2QnT30Y0upmR+j32aUIK3Dy52orblgrRgxt6
         GH4TjFjnQ64LQSxypmUwr4a0fPhBVg7yiT42iADWrt9pGUwPoGlPsyk3u30fAW3MOToq
         VMDrVBBG/MHE8/wC5DWWLXQ2zVPlT6LR4Fw8fBcN0fGDxBTqV61KP1P5l+N9+IEaeFRt
         FoRHfrIKwrMd0n1pZf0KC5MpEGZTsr/yOHXhiY9EsI0U8+HqtveiFfEaWirB2AVlKBlN
         yAgBfV33rf1hqlsuCa7Jltk2bq33IO430uzXaMchiS1gpe9lzlNtBxjlAGjIPnrxIwoP
         Idpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q56szzhx2AE9dZCpkI34NJHt0RlEy4uSIw0ceHqdiRg=;
        b=rUHz+NSdUbMabeY01rSn/PKfOD+XueTwDfJM6RTPJQfFXJ3fekHKgel+zg4YfRlGr4
         kZKFrkyaBZTP+RhIYM16cMFmu4wYiuW7tojkctepDGs+sjYRcEBKnQ5Ch1noec+UtAdQ
         XXyWh1mRnreph/aIzuhv+JcO9zo2qsORqHYTzCldsl5crkGv7LWyjcJI5bp7uwcDdvFt
         8Du6zQnGIJbfc9gY2QPdyPVYplwY8XCJttxCPdkK5uE6oyp/e0Sbhlq3sHbjhyiJX5T0
         6OhgVVgFzyYokcXdbgoXLRMZccLn0pgRerLqoDCqVc6/hSUrW02AAUJUpnMftO05l7yJ
         zebg==
X-Gm-Message-State: APjAAAUFQz81VMS78N+oP5rtqAdLHcZMng/eaKK8e9r8FoJOF8ppIDkA
        4cStcE46YbEab9rtJxRh5eLppvBOApQ=
X-Google-Smtp-Source: APXvYqxiTaKgLkjh5iz+jShv00xNWQicX8DHThVkCLyOMPNThzrS/nm+YcAjtc1JU4CwP1HPugonLw==
X-Received: by 2002:a1c:7f96:: with SMTP id a144mr533265wmd.124.1560367592918;
        Wed, 12 Jun 2019 12:26:32 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r5sm612526wrg.10.2019.06.12.12.26.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:26:32 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@openvz.org>, Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
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
Subject: [PATCHv4 02/28] timens: Add timens_offsets
Date:   Wed, 12 Jun 2019 20:26:01 +0100
Message-Id: <20190612192628.23797-3-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612192628.23797-1-dima@arista.com>
References: <20190612192628.23797-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 323ab92b963b..bf55aec42f2d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12590,6 +12590,7 @@ S:	Maintained
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
index 8c600df9771d..4828447721ec 100644
--- a/kernel/time_namespace.c
+++ b/kernel/time_namespace.c
@@ -13,6 +13,7 @@
 #include <linux/user_namespace.h>
 #include <linux/proc_ns.h>
 #include <linux/sched/task.h>
+#include <linux/mm.h>
 
 static struct ucounts *inc_time_namespaces(struct user_namespace *ns)
 {
@@ -46,6 +47,7 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
 {
 	struct time_namespace *ns;
 	struct ucounts *ucounts;
+	struct page *page;
 	int err;
 
 	err = -ENOSPC;
@@ -58,15 +60,22 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
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
@@ -94,6 +103,7 @@ void free_time_ns(struct kref *kref)
 	struct time_namespace *ns;
 
 	ns = container_of(kref, struct time_namespace, kref);
+	free_page((unsigned long)ns->offsets);
 	dec_time_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
 	ns_free_inum(&ns->ns);
-- 
2.22.0

