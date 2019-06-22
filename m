Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B693C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FFEB20881
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cpBykRhd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfFVAE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 20:04:59 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:47403 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbfFVAEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 20:04:55 -0400
Received: by mail-vs1-f73.google.com with SMTP id d139so2862667vsc.14
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 17:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=E6ROmks1YP8CwMOFQbw770isN8mKFQ6O3PhJWfaTMq0=;
        b=cpBykRhdrV9WvWOUQ0h1bdHdihLaySqHs97UUlYGQjYPCfnQENBajs/VWwRncZdWQJ
         x3qp4dXdCHuLvr0Mp9gBg782SJ3QvOmtlMNNdGpXLWvphNDNK0JImHSRoWKx2+Acm19p
         g/ua8GzrquOQvXhYsRy0aBLAk5lrgayhBjNpvyBXlqdfAauipEGwI0ELTVNh+Y4hnp/T
         azc+iqLbvc0ObICwB2E/JKUSQJQEvpYBDmbLnn0W+yOQNMrspXNt9MaRhDRXIAJ1i2kx
         Ue/EZgQQhMcAruOAHGrXEeDsgIwOVf9cSnt7HPqH6YwJy6llXY6OkWVOn+911ox4eb2F
         q7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=E6ROmks1YP8CwMOFQbw770isN8mKFQ6O3PhJWfaTMq0=;
        b=slSEPR9fJRiesHmkIdwZ12W4DbeXA6uC+DJ2/ByetQ4Cee0Vz7K/0IqqgxrNohRPgz
         u5hfJjV3jS8CI3QGMBU5qQTK4rrT/279sH13WEfNB3cr7XzdsBmjaWJ3X3ay/fQR+4hA
         ipIQsSQJrL9O34f6CBRKgc757rvvtePCx0v/F7CvjOnliITaala9ZIRp2b4kY3VBQs7E
         TvNtJvwATU0R1AvVSuCB+dWbCJTUquA3qUH41tljtJ570WF/SwA1o/wKwvnI87VeW7AY
         02Y1JMPxTz75/IsSqmARYGRrhMezpY+hjP/qeoC/H8kKiqoKngRMSOuR3DaakcLmIdFM
         zumA==
X-Gm-Message-State: APjAAAUrD5LWZ03WXJofvnmdAFuQwA7dMgKHWvpsNO2Gk4mtIBMtElJd
        HzxOE3HGhuJJZ0ncFHr+fQ7bIpWH4gyil8F6oNE1bA==
X-Google-Smtp-Source: APXvYqw+u/Eu3DXZ9kV8rsq9HGa/mUShM0pFU+LKsox84T0C57wKcFXQ5hrwtrEFi/oEfemF3cbnfzDA0KSHSaaITTC+qw==
X-Received: by 2002:a1f:8bc4:: with SMTP id n187mr930984vkd.32.1561161894624;
 Fri, 21 Jun 2019 17:04:54 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:50 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-22-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 21/29] Lock down /proc/kcore
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Disallow access to /proc/kcore when the kernel is locked down to prevent
access to cryptographic data. This is limited to lockdown
confidentiality mode and is still permitted in integrity mode.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 fs/proc/kcore.c              | 5 +++++
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 7 insertions(+)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index d29d869abec1..4e95edb1e282 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -31,6 +31,7 @@
 #include <linux/ioport.h>
 #include <linux/memory.h>
 #include <linux/sched/task.h>
+#include <linux/security.h>
 #include <asm/sections.h>
 #include "internal.h"
 
@@ -545,6 +546,10 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 
 static int open_kcore(struct inode *inode, struct file *filp)
 {
+	int ret = security_locked_down(LOCKDOWN_KCORE);
+
+	if (ret)
+		return ret;
 	if (!capable(CAP_SYS_RAWIO))
 		return -EPERM;
 
diff --git a/include/linux/security.h b/include/linux/security.h
index c649cb91e762..3875f6df2ecc 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -95,6 +95,7 @@ enum lockdown_reason {
 	LOCKDOWN_MODULE_PARAMETERS,
 	LOCKDOWN_MMIOTRACE,
 	LOCKDOWN_INTEGRITY_MAX,
+	LOCKDOWN_KCORE,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index cd86ed9f4d4b..4c9b324dfc55 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -31,6 +31,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_MODULE_PARAMETERS] = "unsafe module parameters",
 	[LOCKDOWN_MMIOTRACE] = "unsafe mmio",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
+	[LOCKDOWN_KCORE] = "/proc/kcore access",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
-- 
2.22.0.410.gd8fdbe21b5-goog

