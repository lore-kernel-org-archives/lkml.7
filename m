Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BABC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16581208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ACSqKMI7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfFUBUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 21:20:06 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:43860 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbfFUBUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 21:20:02 -0400
Received: by mail-pg1-f201.google.com with SMTP id p7so2971112pgr.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 18:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NgELRMteSmX1KpxuaMDKOBuc0VBFM90Hd4coc/TmqVU=;
        b=ACSqKMI7rVvJrlydZWykRsEZ0OCQUb++cj7uLN+4lQThNhHP3k3PG9zYi37SyH9Dpn
         rd2VqHFnVXRkQl9OcOSg70pc13+aZIlScD9U8dcWo2cnsffi9SMnRtCCLkwSJ0mOuUL7
         HxS13GpMnI1s5UUVef6KmTow2HmUvlz+z2/jwv6EB2+Vd+0o+rxbiAQ7aKx0ceJZlWUx
         08Bf4/6Jk9EOtgPklFeXx8UuKWqzGkRSE0Bi3XuuN4S6b9RjFN4tCcO2oRFCm8p1OFSu
         JrFkr9Y8BMSFxcV1Zw74qQw28i5Vn+1ZzPo8Kme5IKT7/nwJUbJ5w2XPDlwhLIPqRESj
         ANTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NgELRMteSmX1KpxuaMDKOBuc0VBFM90Hd4coc/TmqVU=;
        b=Zo1Br3+rl9H+QXxY220oyhFnhRlzPYVCzTohlIm6glAZlXF9lTBLOmxXn+FabZyVJF
         ync7FOPWlaaHg2E50yGSZrq/z82AamZ+5tZqBfHjpxGUeoHiwyHxQbjSp5HtDZ0V+du7
         eC5utB/mKmdRvmH3BuRMhpPDEN/gRUhQHPy5XDU7eVIJ2gljEE8u3caJR8n05uMV7t/D
         vSFc2fGvU+9E2rtvFFiSSdRCEx34Px7HzuQwsj5ui2atBt1gk+bP1Yr+L8Rt8aEDKhRe
         svuzPUSh8/HKcn5kEf0OvFVOITsa4JbyqRxMl0DSl+gXYHK83tcnkFKtMu+91mf9HUpL
         vVvw==
X-Gm-Message-State: APjAAAW0kYXcv1dECspyIT3JEqbrJKzaxQcsuXITQ4woF+NtmC5TPZn+
        fkD+Q8HIE+JeGDt87vc7AyOA6EhGwzsDEdbJnH+21g==
X-Google-Smtp-Source: APXvYqzIeCMdr3ffaDQRIeVOvllR4sI3try+R35YojEX1TgCv8N6wazXrBjdBnNKX1W9SaKleY/gXbi5H41fVDmPoCOqhA==
X-Received: by 2002:a63:5a4b:: with SMTP id k11mr15535306pgm.143.1561080001656;
 Thu, 20 Jun 2019 18:20:01 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:17 -0700
In-Reply-To: <20190621011941.186255-1-matthewgarrett@google.com>
Message-Id: <20190621011941.186255-7-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 06/30] kexec_load: Disable at runtime if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Garrett <mjg59@srcf.ucam.org>

The kexec_load() syscall permits the loading and execution of arbitrary
code in ring 0, which is something that lock-down is meant to prevent. It
makes sense to disable kexec_load() in this situation.

This does not affect kexec_file_load() syscall which can check for a
signature on the image to be booted.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Dave Young <dyoung@redhat.com>
cc: kexec@lists.infradead.org
---
 include/linux/security.h     | 1 +
 kernel/kexec.c               | 7 +++++++
 security/lockdown/lockdown.c | 1 +
 3 files changed, 9 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 034a8d54687f..2d3c69b9fd04 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -84,6 +84,7 @@ enum lockdown_reason {
 	LOCKDOWN_NONE,
 	LOCKDOWN_MODULE_SIGNATURE,
 	LOCKDOWN_DEV_MEM,
+	LOCKDOWN_KEXEC,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 68559808fdfa..040819d7b11b 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -207,6 +207,13 @@ static inline int kexec_load_check(unsigned long nr_segments,
 	if (result < 0)
 		return result;
 
+	/*
+	 * kexec can be used to circumvent module loading restrictions, so
+	 * prevent loading in that case
+	 */
+	if (security_is_locked_down(LOCKDOWN_KEXEC))
+		return -EPERM;
+
 	/*
 	 * Verify we have a legal set of flags
 	 * This leaves us room for future extensions.
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 43a049b3b66a..94af1c3583d8 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -20,6 +20,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_NONE] = "none",
 	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
 	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
+	[LOCKDOWN_KEXEC] = "kexec of unsigned images",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.410.gd8fdbe21b5-goog

