Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C637C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4176620659
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TtALnbKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732853AbfGOUBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 16:01:53 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:42270 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732601AbfGOUAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 16:00:50 -0400
Received: by mail-pg1-f201.google.com with SMTP id d3so11095423pgc.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 13:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=27bG30v551PCUw49w0IhwfwVjWUxHkMd+OR3VLoSFAQ=;
        b=TtALnbKpnTpmzFXbZcyThBpPXUD2vVMXHLz9/K8WCJZcT3sMigJcUb/tqieCDmJYOh
         LKx1gN0TYA3+pZ4/kF+qHhWNB06etdiDXdmEYNb/MtNPes8oGYvUJlPhfR4z8qXd4ldc
         q3cHPE6KMeWpAwlHSonpn/7Li7o6pH7n3SRDWVXWy0KDhxAewWkmSChbNmDmbAwsy+OO
         m/KF6f0nDfVKtyBESrNNS6tPtxph9XndwqSrxe5fJU3pbkhLrN14ZuxLHqMZ6DVhzq3x
         Ll+p9sRpyRcNcxXNlcvQmuSwnxf+IIPUZzC2PZ56UEdGVoIGdscmmb0Tqyh/yQPbDJ0N
         HL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=27bG30v551PCUw49w0IhwfwVjWUxHkMd+OR3VLoSFAQ=;
        b=N6WSd/JDggobGUkTdu0awGVXEZG48NI93PV0XUgdHnVTbcNAesPUHoupyoDHZB/lbu
         ZiawLShhTOGpNAmzM7tken5qdjp7KxTHaQrmznb7XjyFg6oZG23PXzHWUtv4cnI2QJ9J
         34dmIoE+QAeBlOrg454wLOZmTC+3MAs2T4SWCluV0SFACOv+XeZOrFKc3rTlNlCYC3t3
         BHyS0ptv09tzV02LQplUcd4lXYXCn4cHEzLkRS3uQ13QS0J0SsD13wokqFe3QhdSilU7
         AEUCDzAfp7vBDEk9R8EEJtBPQC8AgY1HGjjUCBQfiuhh+Ib1o41bWsMZSPR4N+ZF/Sot
         Jorg==
X-Gm-Message-State: APjAAAU2YJC2KGA8mEYmEcHvU5XcB/tQWis5jiPO185fTq2nADd32Zu9
        F8ZH+6sXcUdkFUuhFxJetOvntXowxJ+9O0gZLi5gUg==
X-Google-Smtp-Source: APXvYqzkGmLJbJxcjs2hj9aWPl3QD/H1QcvcXF5PeHJYQdVT4P2+EUPV+l8kcWG1CRmP7Y/ux0sv82HRaOS4eeckdgZiew==
X-Received: by 2002:a63:4522:: with SMTP id s34mr28567890pga.362.1563220849269;
 Mon, 15 Jul 2019 13:00:49 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:59:38 -0700
In-Reply-To: <20190715195946.223443-1-matthewgarrett@google.com>
Message-Id: <20190715195946.223443-22-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V35 21/29] Lock down /proc/kcore
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>
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
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 fs/proc/kcore.c              | 5 +++++
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 7 insertions(+)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index f5834488b67d..ee2c576cc94e 100644
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
index 3f7b6a4cd65a..f0cffd0977d3 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -116,6 +116,7 @@ enum lockdown_reason {
 	LOCKDOWN_MODULE_PARAMETERS,
 	LOCKDOWN_MMIOTRACE,
 	LOCKDOWN_INTEGRITY_MAX,
+	LOCKDOWN_KCORE,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index e725f63c29d2..9c097240a3a6 100644
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
2.22.0.510.g264f2c817a-goog

