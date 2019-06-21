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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1875C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53B72084A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NC6cvFMG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfFUBVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 21:21:35 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:44534 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfFUBUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 21:20:51 -0400
Received: by mail-pf1-f202.google.com with SMTP id 5so3244800pff.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 18:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=C6hPbD+Iite9Yd/m2NEQoViniv+GetSpL6U00OfqPQs=;
        b=NC6cvFMGa8LejGjE8bJbN1AjDuFigoPl9T5orQwUKoq5IHOK8TozHCyvx0pPD2Rm8e
         bAyYl6xX/9Gy6Ipt42VzJZAyzi+X8rwrGgyiJX2wO4FJoIAAshNER1I5g7DXlyexK9si
         XMGS9K5vDj3tcpUbP2jAxzxgnc44GP4nj6CujSLV5K8B0mf6TsN8S+Umh0dIYpi+cKUv
         TeeJWfiWg32yGsZouUCqeP0hIShv+te6wXoeV8hILDOXlVOqLKbveOi4H6TW1Z22WtK8
         PdG1aRyg2ehyWgENrRcZiD1V78WlJpvC7CHV81NGewkkT8mPY/5rO5kwlttQr8GOIH8v
         cfwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C6hPbD+Iite9Yd/m2NEQoViniv+GetSpL6U00OfqPQs=;
        b=SwfgDiUtqgodg/NVXGdH7GrQ5O2QSif++gysVHsFbWW2VsWWiF3Wr/HsOgu0De9ple
         BfcegiKBjuR9tS7mVurvNPlAx27zesmW2LTBA0ufP9upUkfA1JC6o67b4pB3wjpT6t6M
         TgcspDcn5PG1ysW70C29S4lKiTJpcEV5WVNg0tzmUC4rSo9m0vhKdP3vTRQYOcTd7NO8
         lPSJgQXHSfH76H6EaqDcJLiycPauBrxUhMvWjNEcvPs+0qcODDkvCOmyj+uLKyUaGhh4
         GQOZoQCSOjJwWLLWDMSM6uDZDsy7qjUKM1tbwWWU/HbhzO/UGCC5RwNSohZCLubyiBAC
         bYuQ==
X-Gm-Message-State: APjAAAUJ6cvspzc399rV7hpBND2VgZ1mRIPop9xTc5OOB49lnR5Mad3f
        DcYvsOfINRNh1HLWniKn6/Gx6kWHOhn3QmbmwzhClA==
X-Google-Smtp-Source: APXvYqxY8KgyzR/E7rGtXtVWwMwLdjH8s+X06tcYPkPHRkAcJ+3cLw9bjREqZyBYZWv/RvvI6zuPEKjeSTS4RGxN0sM41Q==
X-Received: by 2002:a63:5a02:: with SMTP id o2mr14952617pgb.93.1561080050519;
 Thu, 20 Jun 2019 18:20:50 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:36 -0700
In-Reply-To: <20190621011941.186255-1-matthewgarrett@google.com>
Message-Id: <20190621011941.186255-26-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 25/30] Lock down perf when in confidentiality mode
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, David Howells <dhowells@redhat.com>,
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
 kernel/events/core.c         | 5 +++++
 security/lockdown/lockdown.c | 1 +
 3 files changed, 7 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 8bf426cdd151..36a9daa13bb0 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -98,6 +98,7 @@ enum lockdown_reason {
 	LOCKDOWN_KCORE,
 	LOCKDOWN_KPROBES,
 	LOCKDOWN_BPF,
+	LOCKDOWN_PERF,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 72d06e302e99..ac1045caa44d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10731,6 +10731,11 @@ SYSCALL_DEFINE5(perf_event_open,
 			return -EINVAL;
 	}
 
+	if ((attr.sample_type & PERF_SAMPLE_REGS_INTR) &&
+	    security_is_locked_down(LOCKDOWN_PERF))
+		/* REGS_INTR can leak data, lockdown must prevent this */
+		return -EPERM;
+
 	/* Only privileged users can get physical addresses */
 	if ((attr.sample_type & PERF_SAMPLE_PHYS_ADDR) &&
 	    perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 0a3bbf1ba01d..14edc475d75c 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -34,6 +34,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_KCORE] = "/proc/kcore access",
 	[LOCKDOWN_KPROBES] = "use of kprobes",
 	[LOCKDOWN_BPF] = "use of bpf",
+	[LOCKDOWN_PERF] = "unsafe use of perf",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
-- 
2.22.0.410.gd8fdbe21b5-goog

