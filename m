Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518D8C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A362089C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NugahSiL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfFUBVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 21:21:03 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:47672 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfFUBUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 21:20:49 -0400
Received: by mail-vs1-f74.google.com with SMTP id d139so1580352vsc.14
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 18:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=X+spaxNTDtzOavXCOZulSz3gCHiK1Z4KEx0/1FYpsLk=;
        b=NugahSiL2+bnOfMwUtvTk1vSDUneqRD5E8fRNkev54yO8MjHUAYtCZcXnwDXRco4La
         UFl5CnSb5dD8DD4U789xI0KNrSSQje+FVCx45vSBOz3vTlYXTKM6BwsgWYIk1ETyJuvN
         EynNdlcRb3NSOJwAQliPiGGQy28uDvhZoX/7+No9Tzsy9HKIMLUO7HllrePlbiUX4VW+
         eD9xwTf1I1qO2cGjk4TdJy0C23Z+amOWALITnlzcXREgAmSUY2Ze7ULEF99fEgW8Hfl8
         VAz1jm7oMRaOO2y3Svh5KYQaulmBVXFwUdgxDxCiuqDewNPMOzJvL//l84t5T1Gy5XGb
         L80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=X+spaxNTDtzOavXCOZulSz3gCHiK1Z4KEx0/1FYpsLk=;
        b=htC+WKnAn+MJSxG8OcVC6XYnAnXrEkNYK3rRxVMcSBQUhg+ntK2zXQKZ2rCvCJ/aOB
         AvPNlCkThen+yI4fcrbNb1fCNp3yQfzEH24QdPmFuCd+e1IkiDRlqoqEUEljPrvd/lQQ
         0mf/P6yBrLkPwXD2jk2vYgagQjqGNBAxVpr0iB4AM+e5FK3HtWObIUcDVnlhvM9weQP9
         8r7aYTO/o9OHGC8yt/pVlssZ38vb4xiM9azcG7IuC5rSlLp5dNv1NYeR4AvoEocFgWm+
         RtSQigEtKMv1e77xmO5xI+6XvZxEPbKV9c4KGxwckql5dV1bM00y/HT/WG4+iVP2soyw
         wrjQ==
X-Gm-Message-State: APjAAAXVObH48m3RnaEN3Ip1QQzLmVuCSQGThdWG9i1AafFt5WhPZvMH
        Q/GUKS0CkhqmA+RsV+S0PpvULYTBCY7hVER4PeuIgg==
X-Google-Smtp-Source: APXvYqz7/NyB5Bpb1MhjrsX/EgPgT30NqAjjYQ0wa371R9qc7apPIh2E50x4AdbbuF+LN/gv42YCUtCqKf7SOI+rw/5rnA==
X-Received: by 2002:a67:f6d4:: with SMTP id v20mr58900267vso.174.1561080048229;
 Thu, 20 Jun 2019 18:20:48 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:35 -0700
In-Reply-To: <20190621011941.186255-1-matthewgarrett@google.com>
Message-Id: <20190621011941.186255-25-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 24/30] bpf: Restrict bpf when kernel lockdown is in
 confidentiality mode
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, David Howells <dhowells@redhat.com>,
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
 kernel/trace/bpf_trace.c     | 11 +++++++++++
 security/lockdown/lockdown.c |  1 +
 3 files changed, 13 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index dae4aa83352c..8bf426cdd151 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -97,6 +97,7 @@ enum lockdown_reason {
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_KCORE,
 	LOCKDOWN_KPROBES,
+	LOCKDOWN_BPF,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d64c00afceb5..6f57485df840 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -137,6 +137,9 @@ BPF_CALL_3(bpf_probe_read, void *, dst, u32, size, const void *, unsafe_ptr)
 {
 	int ret;
 
+	if (security_is_locked_down(LOCKDOWN_BPF))
+		return -EINVAL;
+
 	ret = probe_kernel_read(dst, unsafe_ptr, size);
 	if (unlikely(ret < 0))
 		memset(dst, 0, size);
@@ -156,6 +159,8 @@ static const struct bpf_func_proto bpf_probe_read_proto = {
 BPF_CALL_3(bpf_probe_write_user, void *, unsafe_ptr, const void *, src,
 	   u32, size)
 {
+	if (security_is_locked_down(LOCKDOWN_BPF))
+		return -EINVAL;
 	/*
 	 * Ensure we're in user context which is safe for the helper to
 	 * run. This helper has no business in a kthread.
@@ -207,6 +212,9 @@ BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
 	char buf[64];
 	int i;
 
+	if (security_is_locked_down(LOCKDOWN_BPF))
+		return -EINVAL;
+
 	/*
 	 * bpf_check()->check_func_arg()->check_stack_boundary()
 	 * guarantees that fmt points to bpf program stack,
@@ -534,6 +542,9 @@ BPF_CALL_3(bpf_probe_read_str, void *, dst, u32, size,
 {
 	int ret;
 
+	if (security_is_locked_down(LOCKDOWN_BPF))
+		return -EINVAL;
+
 	/*
 	 * The strncpy_from_unsafe() call will likely not fill the entire
 	 * buffer, but that's okay in this circumstance as we're probing
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 89ad853daec2..0a3bbf1ba01d 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -33,6 +33,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_KCORE] = "/proc/kcore access",
 	[LOCKDOWN_KPROBES] = "use of kprobes",
+	[LOCKDOWN_BPF] = "use of bpf",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
-- 
2.22.0.410.gd8fdbe21b5-goog

