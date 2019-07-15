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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083F2C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA65720659
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YWFTU9Hc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732244AbfGOUBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 16:01:44 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:53772 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732643AbfGOUAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 16:00:55 -0400
Received: by mail-pl1-f201.google.com with SMTP id y22so8807155plr.20
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 13:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CbwHWoXyGcnhOVZUnM7OMDg0cwOUL6ogIm2Fr7FvovA=;
        b=YWFTU9HcoYgzmu9wA7LmGLEFRoVQk/di4jeMQIvZ5i7etSuzudqbvAeHEU23fHCjEJ
         Twn+lgELlaBebCAm10iQk2sO045aRCwc7jzNL4FLw+c5zZae9Z6C8DPkyoCe4llfLpZV
         L1J5bBHV80K9V7jH3s+soISD4N05L5Efrvta23P4J94jyVY9D+b7TK9tpmjPAiX+1JN3
         IUWRqtlamp89QR8N0D1GwnZAED3Yk8HGsV4cTnTOP7IwtWH0zTY7OMkKcGRaD9PzXlto
         FeMyVXGYrflmG3XVDIhTRhYrxxi12jB4usPg7nxkGif/9CqLQ4GqCXoVU9ejb2SoDgjQ
         a/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CbwHWoXyGcnhOVZUnM7OMDg0cwOUL6ogIm2Fr7FvovA=;
        b=EUP+8QPGYf70/EWmHbXvU5FXU9gSKPXjecR6CfNFoNvJL55uxvGV93vL5NBDuZf1x+
         OO8GHjfF+osOPf0yxXledDH/9B5DSzYnu9pGvaNrzoDWR3fb0bbA399ZoDSoZlTGDyrb
         slITO46wm+1EroqK5lW0enXcMlgE/UmoayzglEsp/LTSOnlzYh02iHMAI/j7wFEKfmV8
         YWBnEr7XOrOLahuS8dj6GUBKRwaFYhNHGrN38cbzIxmncKODi4/Fl74LYOTdseZOq55f
         Nyidt5hXTZ5qlN2+QV1csR0ReuMVamKUsW6Ndefqd4fqwuYxf9q17pVur26x0oSmYkX6
         1GQg==
X-Gm-Message-State: APjAAAV+9YzzpW0g9pBsdjGz6Qvk//qZHVwdOdvOZEv7cEFdpGpcfNBf
        gpsHvp/QW0LbGas3Le0M8L8eFkuSezUkbOKKHKryow==
X-Google-Smtp-Source: APXvYqzXTWM8o+p7eNl5c1FE2vi3gFcd7/ND3U/Yw29Ulc0bTGkU6g6c2KrmDwiVmSg1X43rJT0t1FZI3F4FiNKwMFJgvQ==
X-Received: by 2002:a63:6f41:: with SMTP id k62mr28980026pgc.32.1563220854296;
 Mon, 15 Jul 2019 13:00:54 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:59:40 -0700
In-Reply-To: <20190715195946.223443-1-matthewgarrett@google.com>
Message-Id: <20190715195946.223443-24-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V35 23/29] bpf: Restrict bpf when kernel lockdown is in
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

bpf_read() and bpf_read_str() could potentially be abused to (eg) allow
private keys in kernel memory to be leaked. Disable them if the kernel
has been locked down in confidentiality mode.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
cc: netdev@vger.kernel.org
cc: Chun-Yi Lee <jlee@suse.com>
cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/security.h     |  1 +
 kernel/trace/bpf_trace.c     | 10 ++++++++++
 security/lockdown/lockdown.c |  1 +
 3 files changed, 12 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 987d8427f091..8dd1741a52cd 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -118,6 +118,7 @@ enum lockdown_reason {
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_KCORE,
 	LOCKDOWN_KPROBES,
+	LOCKDOWN_BPF_READ,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index ca1255d14576..605908da61c5 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -142,7 +142,12 @@ BPF_CALL_3(bpf_probe_read, void *, dst, u32, size, const void *, unsafe_ptr)
 {
 	int ret;
 
+	ret = security_locked_down(LOCKDOWN_BPF_READ);
+	if (ret)
+		goto out;
+
 	ret = probe_kernel_read(dst, unsafe_ptr, size);
+out:
 	if (unlikely(ret < 0))
 		memset(dst, 0, size);
 
@@ -569,6 +574,10 @@ BPF_CALL_3(bpf_probe_read_str, void *, dst, u32, size,
 {
 	int ret;
 
+	ret = security_locked_down(LOCKDOWN_BPF_READ);
+	if (ret)
+		goto out;
+
 	/*
 	 * The strncpy_from_unsafe() call will likely not fill the entire
 	 * buffer, but that's okay in this circumstance as we're probing
@@ -579,6 +588,7 @@ BPF_CALL_3(bpf_probe_read_str, void *, dst, u32, size,
 	 * is returned that can be used for bpf_perf_event_output() et al.
 	 */
 	ret = strncpy_from_unsafe(dst, unsafe_ptr, size);
+out:
 	if (unlikely(ret < 0))
 		memset(dst, 0, size);
 
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index ccb3e9a2a47c..d14b89784412 100644
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
2.22.0.510.g264f2c817a-goog

