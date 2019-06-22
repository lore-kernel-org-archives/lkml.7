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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADC9C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FFE020656
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K2FFJ1aP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfFVAFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 20:05:03 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:46150 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfFVAFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 20:05:00 -0400
Received: by mail-pg1-f202.google.com with SMTP id s195so4990522pgs.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 17:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lADF/69hujBGq/iJl0D88rT6I3VHPhuR9iVW3LJP1Jc=;
        b=K2FFJ1aP76BMQ/E5sjviwmlSMKVguU8Jr9csKRbGwRxxh3nWMY6MyYVqtdU1Y5Tfnz
         kOF1/pHQYbqBdNndYLAjlR/a1h6lC7UO9m1imOdoyh0ZmiimhMR9K+KXByKIbOyAYuTL
         8P7pZ5SMACUx1f1dLXQ5MhV4J1xa5/HWxsAb2KzcrRWt0/RWhNIX9vFd+Mfg968LkruV
         +n7aJru5R/ypJAmgB+dlauue8cjhksN0Q8pYBeX3j2pKv0GmQ3ZP/gXy2miLx12cmXzm
         YVB7owkrEhwP1oKB7hJyXRS4DC8M71NStLEFOUKFEXIuK9cuRslA5UAuX3LoTN67HRfM
         1O7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lADF/69hujBGq/iJl0D88rT6I3VHPhuR9iVW3LJP1Jc=;
        b=dPCscYO8HbiBtGqHQ5sMhM+bm/vRKN97K9yg4UNI+4Swogha2Hk5tULfmLqu14qlxL
         6vvWZ/jaQzprArI1LUpcNuNX1OdfjSiA/XZyC9OXBtBMgURyhDnr7fQI+ljSyKhX4MgR
         VyiIlHkbeMdZHPDQ0xvZehpxHKEc+Ye8Y2L7f++ZrSrfFE57hPP71tuF9ZewISncF2Vy
         Ujo2Z0UgTJEUIcyJC5K/NstdO3T8nJcFngfTfOrz1S2cBu8O65a8bShNyblTRxR79GdH
         YSix5DCfPgeSJV5KgH1Pdn4Lq9rdujsSbZh2IY6hpX1aMcjAq/edWoDLFk0F+qJQXVIk
         nOFw==
X-Gm-Message-State: APjAAAVssliLV6TptYhgBPeYXzkVxLL79YNglPfhsqWLDJLU/Mh9eVWB
        F+swkOQimdmR/ebasGA4nBWpg75PId+mYm/Rg8eqvw==
X-Google-Smtp-Source: APXvYqx26XubluRiPF2yLoG9HE9+5mboNjL4ADSV+ZJwFXoINToQgWAE+0lEy7Bqd5a/KReOfJnU7lPdOVbv1JFC0/yfZQ==
X-Received: by 2002:a63:545c:: with SMTP id e28mr4246306pgm.374.1561161899618;
 Fri, 21 Jun 2019 17:04:59 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:52 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-24-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 23/29] bpf: Restrict bpf when kernel lockdown is in
 confidentiality mode
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matthew Garrett <mjg59@google.com>, netdev@vger.kernel.org,
        Chun-Yi Lee <jlee@suse.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

There are some bpf functions can be used to read kernel memory:
bpf_probe_read, bpf_probe_write_user and bpf_trace_printk.  These allow
private keys in kernel memory (e.g. the hibernation image signing key) to
be read by an eBPF program and kernel memory to be altered without
restriction. Disable them if the kernel has been locked down in
confidentiality mode.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
cc: netdev@vger.kernel.org
cc: Chun-Yi Lee <jlee@suse.com>
cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/security.h     |  1 +
 kernel/trace/bpf_trace.c     | 20 +++++++++++++++++++-
 security/lockdown/lockdown.c |  1 +
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index e6e3e2403474..de0d37b1fe79 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -97,6 +97,7 @@ enum lockdown_reason {
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_KCORE,
 	LOCKDOWN_KPROBES,
+	LOCKDOWN_BPF_READ,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d64c00afceb5..638f9b00a8df 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -137,6 +137,10 @@ BPF_CALL_3(bpf_probe_read, void *, dst, u32, size, const void *, unsafe_ptr)
 {
 	int ret;
 
+	ret = security_locked_down(LOCKDOWN_BPF_READ);
+	if (ret)
+		return ret;
+
 	ret = probe_kernel_read(dst, unsafe_ptr, size);
 	if (unlikely(ret < 0))
 		memset(dst, 0, size);
@@ -156,6 +160,12 @@ static const struct bpf_func_proto bpf_probe_read_proto = {
 BPF_CALL_3(bpf_probe_write_user, void *, unsafe_ptr, const void *, src,
 	   u32, size)
 {
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_BPF_READ);
+	if (ret)
+		return ret;
+
 	/*
 	 * Ensure we're in user context which is safe for the helper to
 	 * run. This helper has no business in a kthread.
@@ -205,7 +215,11 @@ BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
 	int fmt_cnt = 0;
 	u64 unsafe_addr;
 	char buf[64];
-	int i;
+	int i, ret;
+
+	ret = security_locked_down(LOCKDOWN_BPF_READ);
+	if (ret)
+		return ret;
 
 	/*
 	 * bpf_check()->check_func_arg()->check_stack_boundary()
@@ -534,6 +548,10 @@ BPF_CALL_3(bpf_probe_read_str, void *, dst, u32, size,
 {
 	int ret;
 
+	ret = security_locked_down(LOCKDOWN_BPF_READ);
+	if (ret)
+		return ret;
+
 	/*
 	 * The strncpy_from_unsafe() call will likely not fill the entire
 	 * buffer, but that's okay in this circumstance as we're probing
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 5a08c17f224d..2eea2cc13117 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -33,6 +33,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_KCORE] = "/proc/kcore access",
 	[LOCKDOWN_KPROBES] = "use of kprobes",
+	[LOCKDOWN_BPF_READ] = "use of bpf to read kernel RAM",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
-- 
2.22.0.410.gd8fdbe21b5-goog

