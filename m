Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48887C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E72920651
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="dCYJ/nKn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfDYQO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:14:26 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45289 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbfDYQOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:14:24 -0400
Received: by mail-ed1-f67.google.com with SMTP id k92so356865edc.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 09:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H6Lue2fs7EPgALS/pp1oegphEcm3E73zVKwrzX/cgPI=;
        b=dCYJ/nKnKpbfI1Mmm4siEnuKpdgi3yylvOrWRRgGvqQcGZk46luPE03HG1r3Iat977
         mgA3DoKgLqTWrAHjTF6XrMM5RTGJ06G1B43ZUgZ3zBTjdEsDNoPr5QVQBT8GqUROFzhA
         qRwFQYIRm0OgQgHgEszhDWkpvaOBrQB8BBbjR/DgGfLFTW9M2wXRIlKfQIBHzDT/Rdtw
         s3pTbHAPK4we8BcrSCcNBE/Qr/z2foyBMLngJFezFqmYEBYL5Wsz9XM5ZtBBMaJXysgj
         guqRBZuPz84fwAA4y7/u1trCmxQF9pbqADMWAMt9UH/mXWNBg6/tJoJizQyzCgTpbOxN
         xBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H6Lue2fs7EPgALS/pp1oegphEcm3E73zVKwrzX/cgPI=;
        b=B9MFQgkdqjyDTtPwwIXcsoEtMO96ttLa6C2kiOklYw4sY74mbYNbNGJWe4E6pmo1DV
         c9hGjNz4BB+20LNRPVosCEcd1SA+TieyCHWF5n8GR9p/XVOnhXXL/YitNq0Jwp8zKh4y
         4LDBxiXLQJ62CK1jCFArz660QwwsIfo8DzEdCBPsGYKHPoZ/UZpkl7uqHqqN3XGPA+E0
         rDxC3WF7o6HN12NWVbzkIj37obKjNU0/2YIIpD9GAZ+JzZDcgDin57T69xeokDpksUGL
         dBpokt+3BpPyVFXdXYNLR6/sDwx8pKiYKsdMv1HqHJPmn1qJtxmAq3wk4iiSR2qG3IzO
         c2hQ==
X-Gm-Message-State: APjAAAUfVz1Q7jm+sdIb/kLES6X4YukDwdebLaVixBXEqjutJBElSVTN
        vw8onoRcTtnVljlmlN4OTtiQMqhZDjg=
X-Google-Smtp-Source: APXvYqzVFn3+Uc8mfzA13lYwGm8UYSDJSL5Go8Uznpq5Kkgu0gVf0uXaKsfMtmKiTTVcahuScj8G9w==
X-Received: by 2002:a17:906:3641:: with SMTP id r1mr9055199ejb.155.1556208861645;
        Thu, 25 Apr 2019 09:14:21 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id br19sm4147042ejb.48.2019.04.25.09.14.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Apr 2019 09:14:21 -0700 (PDT)
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
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv3 02/27] timens: Add timens_offsets
Date:   Thu, 25 Apr 2019 17:13:51 +0100
Message-Id: <20190425161416.26600-3-dima@arista.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190425161416.26600-1-dima@arista.com>
References: <20190425161416.26600-1-dima@arista.com>
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
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 MAINTAINERS                    |  1 +
 include/linux/time_namespace.h |  1 +
 include/linux/timens_offsets.h |  8 ++++++++
 kernel/time_namespace.c        | 14 ++++++++++++--
 4 files changed, 22 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/timens_offsets.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b50720361de7..6a57d94963f6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12397,6 +12397,7 @@ S:	Maintained
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
2.21.0

