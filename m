Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51692C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218912168B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fXPdtbJm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfFVAFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 20:05:06 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:36775 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbfFVAFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 20:05:03 -0400
Received: by mail-pf1-f202.google.com with SMTP id h15so5335771pfn.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 17:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MSE1dfKm6a4U6gWG+XXV/6IbZHfhkaYY6qykZ2fiyyA=;
        b=fXPdtbJmSfE8Q4WIQs2dmiKmnq4w8wPH44i8xF217pTQ0RnXb0fgs5rTReQYKwAFOt
         a45BB1kJLiVV3CiZFCq8P6HNcq5NJ8IAQDtyoswUv6yquzD3SntcGwcr/sDfQSxNRQin
         WqwIhqEP91O8JDsS/3Oczyt3jflEpGI5xj7uHsHdcdy1ULhHWcpsec3ntSNQmASPniis
         RrTw8AJIj0B/CSkFuSclsom2q4SOUahEDlV4cJL8BPdNDlx6MoY9MejEAssBYRifgYGa
         qgpysJEVpWPkUa6SA+iZLF4rWnfXt5zObKpaxukLwnpfsCdeUO5ywRflWBnWirymhIcP
         lHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MSE1dfKm6a4U6gWG+XXV/6IbZHfhkaYY6qykZ2fiyyA=;
        b=PCeowdF5maYpeOO6KhhHQIMGOMpIxmK9SG9ZDF8mMBEm271NI13h2S4t4NwU5T0FJl
         xPJDqW+gUloHADD5Ks8CVk4SpPHZULJ1AAAp9v08e5a5WWJicqFiNRm7yZaPWwuztp/x
         5aq/4/Kvh88vLNxUUVEW01EshSp/3eSRfc5OTR7MqYZpP76Iya7NRIaI6nyCJRAkC4g9
         5oKJMaFPfAmhbB6ORRKupOxCby82Uc17JTsoY/5+JS3rjd/4HrQesnasZST4l/j+GtLM
         43iutnOZDkDsJ5r8/QjjNASXYa/ivD5trvNI+KbP9wf/FQZ3zE538UZPM/VCMNck9WjE
         DQTA==
X-Gm-Message-State: APjAAAXk9J/lbH108jOOf7QzMs5DD8GZIl1XjH9IFYvbrnxLxLyKylxE
        3kZYlSG44EiVOcL5nN2hI0vW6usgAJiEaBDe8WbeDQ==
X-Google-Smtp-Source: APXvYqx/vgH+uSVeXTXtZ2WddOL7rELTwTjq7lwC1RqicEpV8YeZCyFdixYRa+ynnq7Uz2uCgOc618zkH1Wg8Rak2sj7UQ==
X-Received: by 2002:a63:e953:: with SMTP id q19mr21349257pgj.313.1561161902178;
 Fri, 21 Jun 2019 17:05:02 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:53 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-25-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 24/29] Lock down perf when in confidentiality mode
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Disallow the use of certain perf facilities that might allow userspace to
access kernel data.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
---
 include/linux/security.h     | 1 +
 kernel/events/core.c         | 7 +++++++
 security/lockdown/lockdown.c | 1 +
 3 files changed, 9 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index de0d37b1fe79..53ea85889a48 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -98,6 +98,7 @@ enum lockdown_reason {
 	LOCKDOWN_KCORE,
 	LOCKDOWN_KPROBES,
 	LOCKDOWN_BPF_READ,
+	LOCKDOWN_PERF,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 72d06e302e99..77f36551756e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10731,6 +10731,13 @@ SYSCALL_DEFINE5(perf_event_open,
 			return -EINVAL;
 	}
 
+	err = security_locked_down(LOCKDOWN_PERF);
+	if (err && (attr.sample_type & PERF_SAMPLE_REGS_INTR))
+		/* REGS_INTR can leak data, lockdown must prevent this */
+		return err;
+	else
+		err = 0;
+
 	/* Only privileged users can get physical addresses */
 	if ((attr.sample_type & PERF_SAMPLE_PHYS_ADDR) &&
 	    perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 2eea2cc13117..a7e75c614416 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -34,6 +34,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_KCORE] = "/proc/kcore access",
 	[LOCKDOWN_KPROBES] = "use of kprobes",
 	[LOCKDOWN_BPF_READ] = "use of bpf to read kernel RAM",
+	[LOCKDOWN_PERF] = "unsafe use of perf",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
-- 
2.22.0.410.gd8fdbe21b5-goog

