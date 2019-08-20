Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A6EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE3222D37
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EHQV+bc9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbfHTATR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 20:19:17 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:36193 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729160AbfHTATN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 20:19:13 -0400
Received: by mail-pl1-f201.google.com with SMTP id a5so2944516pla.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 17:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SWzpT147tCKuH/oJTsJ3VrcaxfdUFKv8ds0JG4GiFSY=;
        b=EHQV+bc9TXTCrfRPG8bkkaSnOFigWkj9dXi1eDR7rjHTlRlucdTw/UFKyyxdsYbmAC
         FQckkCxclwBYXwS7LW0xVdfnDOjrk4D8osCtDmyLWja8qVv39kB771nlwhKy0fcM8G/d
         YmZ0EcFswmBwf2D5bwT5q/y9xDL5m/FPXF68lP7fmzaNksewzCj6csVrGoZjsRGf+qXb
         5CzOT8Q54XyNEh1X2eapAkOy4RbNi7IpKt4UDNssbJ3JWTcRfIrAEZLPnC0/oy9YKtV7
         wuN0W8Y/EgFaVlLlFRDlgYNHXkJJyKjRZWlwPzuoLE+OmyVyAyz9gZFzMZUq5X3duq8X
         nhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SWzpT147tCKuH/oJTsJ3VrcaxfdUFKv8ds0JG4GiFSY=;
        b=L1pylRScY4lfrkeKT/7pCSnl94Ihedn9R2/nk0BdkbKEd5vYEmCfbrF1QW2AtKbwA0
         GGabHV2oNiIJ9RInTUqiKGNIM/JOH9PkzbOXpdIwT0LoNDSBp8dQQqs4SobYJm4krsaS
         hZGUsANU0tSAGPLxdkb/ut5kPsCjUskaGRAdgZPJqZQyMM72ATxrWxlWA9JMhCdEKJ9U
         GrNX2ubkAfThq53FZP6JOza1SFasGXk5b29JJO2HupdV9UVUHYs/B+bWiw/EGWgAl1hT
         CxDk96EbhzSy4e0AzIb3OmKxGGG3JOJ4zV48iIf6aAY1CWaX1wBk00P+e4jkLpo9nK12
         rSZg==
X-Gm-Message-State: APjAAAX/tVP1wm6fuznOudXogCDWgYLYeA9GikAUzrrinMXYF2nXebWk
        PTC+icRqOJe9yXIXk6uluMBD0zv48SD9vy5fm2BfOg==
X-Google-Smtp-Source: APXvYqy3T3xOZ3OC9eye1W57qGnc5hILVQiaU7tjW3elKXxqq/A6iItV6wLMZTnHlNr4EkOli22l+AoNki42WA9FP9tppw==
X-Received: by 2002:a63:7709:: with SMTP id s9mr21692152pgc.296.1566260352401;
 Mon, 19 Aug 2019 17:19:12 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:18:00 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-25-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 24/29] lockdown: Lock down perf when in confidentiality mode
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>,
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
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: James Morris <jmorris@namei.org>
---
 include/linux/security.h     | 1 +
 kernel/events/core.c         | 7 +++++++
 security/lockdown/lockdown.c | 1 +
 3 files changed, 9 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index e604f4c67f03..b94f1e697537 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -119,6 +119,7 @@ enum lockdown_reason {
 	LOCKDOWN_KCORE,
 	LOCKDOWN_KPROBES,
 	LOCKDOWN_BPF_READ,
+	LOCKDOWN_PERF,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index f85929ce13be..8732f980a4fc 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10798,6 +10798,13 @@ SYSCALL_DEFINE5(perf_event_open,
 	    perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
+	err = security_locked_down(LOCKDOWN_PERF);
+	if (err && (attr.sample_type & PERF_SAMPLE_REGS_INTR))
+		/* REGS_INTR can leak data, lockdown must prevent this */
+		return err;
+
+	err = 0;
+
 	/*
 	 * In cgroup mode, the pid argument is used to pass the fd
 	 * opened to the cgroup directory in cgroupfs. The cpu argument
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 2397772c56bd..3d7b1039457b 100644
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
2.23.0.rc1.153.gdeed80330f-goog

