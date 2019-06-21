Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B78C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6885F2084A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pg7CAs8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbfFUBUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 21:20:51 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:51257 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfFUBUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 21:20:41 -0400
Received: by mail-pg1-f201.google.com with SMTP id i35so1795118pgi.18
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 18:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=C2HEat8ChWdY0hmQrNdX6y9AIaltC2qHKe9IgXVBgg0=;
        b=Pg7CAs8Y51TZZLF1Lrf1EzgZZxAIfmpAgkg435aK19YQWb2C1HEcQS/IA5NONe5F1y
         Ob+ZzvlKygwjW5U9HoeoPUvj+ZQTVz4KTWE9brl/hTU7bpg2WRFHbtsL3RFZHXcCCD44
         Umo5dJEwJPaaGUejehg1qSwqxZx6iu83RfpN/QMRxgiIpStb3VimfRc3/SsvvajRR8lK
         dWBlC/n58vr22GR9zDV7ockIGy/PDlXgyh+QAD4lrJlM6xPfisbmyM/PzywgA6/w2EGW
         mQCqo4qAZHk6V9TOc/zjjk76CPbO5M0+OPZ046QVHhSKHw8iNbWNlA3MGsO8M+7TgyDU
         Xmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C2HEat8ChWdY0hmQrNdX6y9AIaltC2qHKe9IgXVBgg0=;
        b=OwIAt9liho/lw7uf9l8Zogo8m5p50/Jlc1FemiDSAX3TNCVqiZbkwJ/RsCwACD2yx3
         rrD9sHJCuLQzvCk1rwEET1eyJLWPy6o4zOU0Zk/OBbhR+t5ZyiDNXgQAoh8C0jGjP53J
         7VZSQrXgs7BuyRjfVtPPzzJOCMNdiMKWgHgjklJG9s/Iv8vYa/Ux/tkMIVhM6yoLhcBp
         zhHetmrU12d3EvSzM038AczBgcT94UGwIb8oIXfh4HiYIp4x9NZUGCnBl2+ExAiYUIsG
         MwAtUZrg+g7W5OcvJiGgrs8D6yzCQZZ1J60Rl5rfPLXXQgLpfrs/AIGDKwXyg49iqWYm
         NbbQ==
X-Gm-Message-State: APjAAAXY1t36ZH0J8duzRLNAFwoh95OGuij+RQSu+OTfLclPkWjBQZ2g
        pSXFhykmOq6F6yoxgVrTEu8eIe7PJS8gYvuAplMiNQ==
X-Google-Smtp-Source: APXvYqxyataIkh+ap8K2JvEB/ca0/aiWCzaTig0BuKoGz7gKugC7XCne7U3GNnARDTq/vXeaug9TpJl6DuP0wXxCYU2v3Q==
X-Received: by 2002:a63:5a02:: with SMTP id o2mr14951958pgb.93.1561080040579;
 Thu, 20 Jun 2019 18:20:40 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:32 -0700
In-Reply-To: <20190621011941.186255-1-matthewgarrett@google.com>
Message-Id: <20190621011941.186255-22-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 21/30] x86/mmiotrace: Lock down the testmmiotrace module
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, David Howells <dhowells@redhat.com>,
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
cc: Thomas Gleixner <tglx@linutronix.de>
cc: Steven Rostedt <rostedt@goodmis.org>
cc: Ingo Molnar <mingo@kernel.org>
cc: "H. Peter Anvin" <hpa@zytor.com>
cc: x86@kernel.org
---
 arch/x86/mm/testmmiotrace.c  | 3 +++
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 5 insertions(+)

diff --git a/arch/x86/mm/testmmiotrace.c b/arch/x86/mm/testmmiotrace.c
index f6ae6830b341..a6b204f9f505 100644
--- a/arch/x86/mm/testmmiotrace.c
+++ b/arch/x86/mm/testmmiotrace.c
@@ -115,6 +115,9 @@ static int __init init(void)
 {
 	unsigned long size = (read_far) ? (8 << 20) : (16 << 10);
 
+	if (security_is_locked_down(LOCKDOWN_MMIOTRACE))
+		return -EPERM;
+
 	if (mmio_address == 0) {
 		pr_err("you have to use the module argument mmio_address.\n");
 		pr_err("DO NOT LOAD THIS MODULE UNLESS YOU REALLY KNOW WHAT YOU ARE DOING!\n");
diff --git a/include/linux/security.h b/include/linux/security.h
index 47ca04ac00f6..89b7adfae525 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -93,6 +93,7 @@ enum lockdown_reason {
 	LOCKDOWN_PCMCIA_CIS,
 	LOCKDOWN_TIOCSSERIAL,
 	LOCKDOWN_MODULE_PARAMETERS,
+	LOCKDOWN_MMIOTRACE,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 0788d4805449..215615e67237 100644
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
2.22.0.410.gd8fdbe21b5-goog

