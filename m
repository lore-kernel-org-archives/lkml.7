Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887FDC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5928520659
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ChqgzH2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731651AbfGOUBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 16:01:03 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:38306 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732689AbfGOUA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 16:00:58 -0400
Received: by mail-pl1-f201.google.com with SMTP id s22so8829714plp.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 13:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6flDTB2cc+idlYkETJxAjqgCPIisACHtzrHaM3jrXOY=;
        b=ChqgzH2zFDK3tT4H5IhQ4S8ryxEnULmECSos4ucFSEGrnmOhH4smTTrqP3rLmwJ6bm
         nHqApST8qhDWjUtUcr05S+8nZlo1vwWRNXWvAH5yUG7B1wschRgRPDG81Xmrt0cTjm6s
         7rqClyqIOA12viOU8/hoPxZYow/PEP4KU1BVkH7NLkKaDTPJZ+EEy2X+6KtwhHhSjpY7
         /azlbfPRNT+YYiwAd0qDqEvJpgwfUi+gsZUtQoQnBN1qPg+us7qlLqvddyD4IpPC3m6C
         5cSUD3Klw3rDnkU7p39B7KGLg28nfmarFbFKQ2a2psShO56Euq2nph1i5SHHvAcsrVz1
         QFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6flDTB2cc+idlYkETJxAjqgCPIisACHtzrHaM3jrXOY=;
        b=OsQCJmCaG8k/+pWMfDS/UHkQmUpfm+mf3aG77Kh6OjMSX2eO70Dekwy4FUTgjSs0/B
         HQJG6kaw7Tyd+HjtYCL1u3k20tb+Ar0NkgBQJ+Y3RP/vxp6rMLvfW4fUBW7l01HkmYid
         ax321d1bgt52fHgf8nOkY8BM+7X7ksY8a9+XG7eSEMviNAcePbhcca6KiFSC/1/xodEk
         YHB2hDi78GPgo8TmdFaPdr5gYSNnbEZ4yMdIp73kps1GTHP2WWDtUamLQfi86RU8ccTK
         PiAcT6eG28mbK+itGKRVBwaDsdfoAm9rxZZhSIE0heDsKitiQ4QRcKhnbE6u+C2Cr9hC
         xC9g==
X-Gm-Message-State: APjAAAXgfQ0h39JBfRPutU/dhsM1PlcYSga416vAoshvP7tHZG7g7xuN
        bSoKxGNfoBh1leADh1KcGJj+GtgD/Yb/wdLCACDxFw==
X-Google-Smtp-Source: APXvYqxg52NsoxTabPM1Dv5rjomAok9LsWGgpqy0K2qiQR90JV7TUbpE8F353AcRIJ8oasv5d+Jl4wW0ZOgZMy7Slf0MLQ==
X-Received: by 2002:a63:1a03:: with SMTP id a3mr27318096pga.397.1563220857095;
 Mon, 15 Jul 2019 13:00:57 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:59:41 -0700
In-Reply-To: <20190715195946.223443-1-matthewgarrett@google.com>
Message-Id: <20190715195946.223443-25-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V35 24/29] Lock down perf when in confidentiality mode
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
---
 include/linux/security.h     | 1 +
 kernel/events/core.c         | 7 +++++++
 security/lockdown/lockdown.c | 1 +
 3 files changed, 9 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 8dd1741a52cd..8ef366de70b0 100644
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
index 785d708f8553..738d6f1cf5ec 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10806,6 +10806,13 @@ SYSCALL_DEFINE5(perf_event_open,
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
index d14b89784412..e43c9d001e49 100644
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
2.22.0.510.g264f2c817a-goog

