Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAECC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 519312145D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s833uP+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732673AbfGOUA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 16:00:56 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:45464 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732577AbfGOUAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 16:00:48 -0400
Received: by mail-vs1-f73.google.com with SMTP id v20so3632407vsi.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 13:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Q3+BJ8wFVQ84xOQmot2tpofx7ZuUIMeG+qiO4R/dTeo=;
        b=s833uP+L4ndInqcO7GVUrtgYxpgQOxfcIAJuNg943dQtpHD4E7hXQVRZIOTd/uawj4
         oGrfRyVmCzlmicBOw8BCgIkPXsIDf+ypqYFhmPvrrMlqnNtGWmGgVwyZyOK1H6yJJrW/
         yxuUI5haFcN1zNzVHLsgTO40BkwD4a39tTybSR/DO6gs16AfVekX1ErS+jiAorl/zBgN
         yBfcVfvuEoWE0ID5D806uCdbO7eGnhgmI0FZtO8nm1o+inQ+qcg6HVifHrKKdy+TqkgZ
         zrixfylqxM4OOf22PAN+y2BHGtyZsmZOZchbtYK+107UyAgxlPT1NnZpHeBeHWgEXXcQ
         VPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Q3+BJ8wFVQ84xOQmot2tpofx7ZuUIMeG+qiO4R/dTeo=;
        b=h3iApMm/AsActgq95Oa0jMZbUaRAYrr3GC0Y8uGLLcVMVlY62G1tWOiKD3XFcjbPaf
         InLtSzZZWsGiPNT8NE7mCrJQ27e+DuXhI22X/EwnTBTauBDiS6KHafK3ppZklQ/QI632
         k7RG/JkznT/+RseI8fII30KOo4670KwjLzUpY64OjtD6f1s1MSf/NH0/pk0EcrfzAYoF
         fq5M8Ba8XnTvV0BrUWbT8IedVsh3oG7Hdk285KQHXLMFo7EhSiqUIaGO7vzefCWfGy1O
         dRMnVqndsFn+qItGXrwxXD54C6O1OFNRbzUyOPFV/sEaV4JAMt3YhkNm/NnKqmKCTyHJ
         YKeg==
X-Gm-Message-State: APjAAAUayv83+qSsNXIIfKLsaeCsC5w+kLOuXhwegGrcP+e5XinwAEwp
        Mc0J0xhG37cc3E9jyQ8WYv+3+81/BSnHrWfT71hbQA==
X-Google-Smtp-Source: APXvYqzrPvNGN/I7uy3eU578IGNHpPaFnCI2yCyyv/JO/KlFVh2mCOEzjvCze1/gjfsCrqwBlwaAgvlfBrtyCtyysV9DWA==
X-Received: by 2002:a1f:a887:: with SMTP id r129mr10860627vke.75.1563220846821;
 Mon, 15 Jul 2019 13:00:46 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:59:37 -0700
In-Reply-To: <20190715195946.223443-1-matthewgarrett@google.com>
Message-Id: <20190715195946.223443-21-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V35 20/29] x86/mmiotrace: Lock down the testmmiotrace module
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Garrett <mjg59@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

The testmmiotrace module shouldn't be permitted when the kernel is locked
down as it can be used to arbitrarily read and write MMIO space. This is
a runtime check rather than buildtime in order to allow configurations
where the same kernel may be run in both locked down or permissive modes
depending on local policy.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Howells <dhowells@redhat.com
Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
cc: Thomas Gleixner <tglx@linutronix.de>
cc: Steven Rostedt <rostedt@goodmis.org>
cc: Ingo Molnar <mingo@kernel.org>
cc: "H. Peter Anvin" <hpa@zytor.com>
cc: x86@kernel.org
---
 arch/x86/mm/testmmiotrace.c  | 5 +++++
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 7 insertions(+)

diff --git a/arch/x86/mm/testmmiotrace.c b/arch/x86/mm/testmmiotrace.c
index 0881e1ff1e58..a8bd952e136d 100644
--- a/arch/x86/mm/testmmiotrace.c
+++ b/arch/x86/mm/testmmiotrace.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/mmiotrace.h>
+#include <linux/security.h>
 
 static unsigned long mmio_address;
 module_param_hw(mmio_address, ulong, iomem, 0);
@@ -115,6 +116,10 @@ static void do_test_bulk_ioremapping(void)
 static int __init init(void)
 {
 	unsigned long size = (read_far) ? (8 << 20) : (16 << 10);
+	int ret = security_locked_down(LOCKDOWN_MMIOTRACE);
+
+	if (ret)
+		return ret;
 
 	if (mmio_address == 0) {
 		pr_err("you have to use the module argument mmio_address.\n");
diff --git a/include/linux/security.h b/include/linux/security.h
index 43fa3486522b..3f7b6a4cd65a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -114,6 +114,7 @@ enum lockdown_reason {
 	LOCKDOWN_PCMCIA_CIS,
 	LOCKDOWN_TIOCSSERIAL,
 	LOCKDOWN_MODULE_PARAMETERS,
+	LOCKDOWN_MMIOTRACE,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 065432f9e218..e725f63c29d2 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -29,6 +29,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
 	[LOCKDOWN_TIOCSSERIAL] = "reconfiguration of serial port IO",
 	[LOCKDOWN_MODULE_PARAMETERS] = "unsafe module parameters",
+	[LOCKDOWN_MMIOTRACE] = "unsafe mmio",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.510.g264f2c817a-goog

