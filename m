Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB94C10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5393E2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lv/FPdRA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732876AbfCZS2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:28:53 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:52857 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732806AbfCZS2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:28:51 -0400
Received: by mail-oi1-f201.google.com with SMTP id s133so5720130oif.19
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/UVUOH/6siV2b/2LDB8wDIhEmSTMU547j99QGLitSA4=;
        b=lv/FPdRA1RfB3vLPLo6Ht+4Uq/7S0A/5brocYyTzI3Cf2VUnSQ0RmEPSquMVKX6uD/
         zrJp1bviYSiy6SZJcrSi/SnU87S//a3xTTx7d70ujTGBa19BZ9d9eIyQ09yXI5ydGDm3
         smeM5uI0HkkoRudgW/7BwSzvYdn15I5Yz2VcXUuI/bHa1I+JU653xnazjSzECXoneTPe
         v1cOzCuVgxkyoJ9o43anec390AhCSqaQ43q4Y/AlB4htB/+T7rAzeG+CKI6r+eVG7ng+
         iYwL4rTtcFO/MU3+KOdZahY6L4QxGGU3QfQMGKQiCJGn8N0OSOLJy8xVW6rUeAIuOxsx
         c/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/UVUOH/6siV2b/2LDB8wDIhEmSTMU547j99QGLitSA4=;
        b=Z/TW9gCZ9EnI0VKIseh2pTWvrX0WGrJvR7PyO3u/THI/Y8oE9taNmJtcYlLeMdoyOn
         bbfQYjlD557gNBOk8xfameJldV4LVM1RFl1oNHgMVVq4SmE3RlYupAw3/OvDBzY/Jc12
         88gC2O3ARez6Bw6+SZUjfS5zTO6aQhFyaUeXUZpLZE6CV1RHnB0/EnW5jiJWc43k+Nn6
         h43i+Y/zBHGD5wh2sqLPWwk5EKXANTmvLLoxkEBIa5sPoVvMeQrpk0MGriuwLfVsR7bv
         ZF/dFuDeTPXNic7rA0B0pCnybVRETRi/5rV4nqIi2SA/lZYTjV85iAoly2vuQvxddgud
         4jPA==
X-Gm-Message-State: APjAAAUYBfBPQ/pN4yrJ3z+afKAIwm6GZ8UCrKNjmfNKDLeK78KAzUhi
        ZoyX2XYC72m8AGM7SnH8wv46K6xB9r+RreJbmqzf7w==
X-Google-Smtp-Source: APXvYqyAbat3PPV8AUkDGHHq4kmMbVqdPiRxqPB9rTmjyAlQ7tu5Vz3fAT5SgF1mWOwG5CrW9kJuVlZEyPz2qkjecy/Upg==
X-Received: by 2002:aca:558d:: with SMTP id j135mr16551138oib.49.1553624930168;
 Tue, 26 Mar 2019 11:28:50 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:27:38 -0700
In-Reply-To: <20190326182742.16950-1-matthewgarrett@google.com>
Message-Id: <20190326182742.16950-23-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V31 22/25] bpf: Restrict bpf when kernel lockdown is in
 confidentiality mode
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
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
 kernel/trace/bpf_trace.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 8b068adb9da1..9e8eda605b5e 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -137,6 +137,9 @@ BPF_CALL_3(bpf_probe_read, void *, dst, u32, size, const void *, unsafe_ptr)
 {
 	int ret;
 
+	if (kernel_is_locked_down("BPF", LOCKDOWN_CONFIDENTIALITY))
+		return -EINVAL;
+
 	ret = probe_kernel_read(dst, unsafe_ptr, size);
 	if (unlikely(ret < 0))
 		memset(dst, 0, size);
@@ -156,6 +159,8 @@ static const struct bpf_func_proto bpf_probe_read_proto = {
 BPF_CALL_3(bpf_probe_write_user, void *, unsafe_ptr, const void *, src,
 	   u32, size)
 {
+	if (kernel_is_locked_down("BPF", LOCKDOWN_CONFIDENTIALITY))
+		return -EINVAL;
 	/*
 	 * Ensure we're in user context which is safe for the helper to
 	 * run. This helper has no business in a kthread.
@@ -207,6 +212,9 @@ BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
 	char buf[64];
 	int i;
 
+	if (kernel_is_locked_down("BPF", LOCKDOWN_CONFIDENTIALITY))
+		return -EINVAL;
+
 	/*
 	 * bpf_check()->check_func_arg()->check_stack_boundary()
 	 * guarantees that fmt points to bpf program stack,
@@ -535,6 +543,9 @@ BPF_CALL_3(bpf_probe_read_str, void *, dst, u32, size,
 {
 	int ret;
 
+	if (kernel_is_locked_down("BPF", LOCKDOWN_CONFIDENTIALITY))
+		return -EINVAL;
+
 	/*
 	 * The strncpy_from_unsafe() call will likely not fill the entire
 	 * buffer, but that's okay in this circumstance as we're probing
-- 
2.21.0.392.gf8f6787159e-goog

