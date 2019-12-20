Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8B6C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB2624682
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VETjIrwl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfLTPmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 10:42:16 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35778 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbfLTPmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 10:42:10 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so9712217wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 07:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lGbC4jtkbenMhpDKup9C3+jqzXEqt+dJgjev6KEIOek=;
        b=VETjIrwlgBW+OUmHFNDHX0Zw88OSzly/p7nHYWblLY6Sa7Mb0z/OHhmgj8gGVu3ziR
         NZiUBuYscoE9SQixKMWe+y5BYzC+o9rLeenQZY0PJ7YFdIMGpxEcVg1r43b2O2w9+q0u
         0sNNIQWuzU9puQcbjPYK83aY2M9InywGj1AgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lGbC4jtkbenMhpDKup9C3+jqzXEqt+dJgjev6KEIOek=;
        b=IbZs2JuW1R4G7UnLoY7ujeJkisLBKg5xtaU7uc4zBcMzoEeNjk8o6gfmJiUD5+iKfP
         c+3ZehdPC3kreZ9QWTc7atHI+toWZoKtruu6Hot/zDejDIywV9m/pJv7JNgFFLCu+dCg
         l3GMatLNgpKGh26VTf+oYkV/S2DGCgGhixnecHqSImg9QbGqWtGPQc4DHKlBtpuGcNQH
         L6iltrGOLbG+cpRUu19Vo/nhRpI0qDuwo3bLWxy2EW554P4rJGcZybNTUMbpr8iyTw6I
         ialA1+MwA//FbRdBz9SdI845esy0iWFANjcgiZSjZwHRR4hsQWpwDOtfAZ/q66njah+t
         zK9g==
X-Gm-Message-State: APjAAAV/828I46slkscy/CV70TjN4fHp9Xt4vtVuOSk3854RaVrbP2mi
        38Nb42eUzgbrGRRqEiv7eBGMjwLEZJ8=
X-Google-Smtp-Source: APXvYqwtrwTRJzANfCKqBfDMYFXH9/CapY3ImHpG/kCN7tNJtEhkLmU9gs6jlTYpwZFGZgFqOD9DQA==
X-Received: by 2002:a1c:6809:: with SMTP id d9mr17402626wmc.70.1576856528490;
        Fri, 20 Dec 2019 07:42:08 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2a00:79e1:abc:308:c46b:b838:66cf:6204])
        by smtp.gmail.com with ESMTPSA id x11sm10118062wmg.46.2019.12.20.07.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 07:42:08 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: [PATCH bpf-next v1 04/13] bpf: lsm: Allow btf_id based attachment for LSM hooks
Date:   Fri, 20 Dec 2019 16:41:59 +0100
Message-Id: <20191220154208.15895-5-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220154208.15895-1-kpsingh@chromium.org>
References: <20191220154208.15895-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Refactor and re-use most of the logic for BPF_PROG_TYPE_TRACING with a few
changes.

- The LSM hook BTF types are prefixed with "lsm_btf_"
- These types do not need the first (void *) pointer argument. The verifier
  only looks for this argument if prod->aux->attach_btf_trace is set.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 kernel/bpf/syscall.c  |  1 +
 kernel/bpf/verifier.c | 83 ++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 80 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 5a773fc6f9f5..4fcaf6042c07 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1642,6 +1642,7 @@ bpf_prog_load_check_attach(enum bpf_prog_type prog_type,
 {
 	switch (prog_type) {
 	case BPF_PROG_TYPE_TRACING:
+	case BPF_PROG_TYPE_LSM:
 		if (btf_id > BTF_MAX_TYPE)
 			return -EINVAL;
 		break;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a0482e1c4a77..0d1231d9c1ef 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9504,7 +9504,71 @@ static void print_verification_stats(struct bpf_verifier_env *env)
 		env->peak_states, env->longest_mark_read_walk);
 }
 
-static int check_attach_btf_id(struct bpf_verifier_env *env)
+/*
+ * LSM hooks have a typedef associated with them. The BTF information for this
+ * type is used by the verifier to validate memory accesses made by the
+ * attached information.
+ *
+ * For example the:
+ *
+ *	int bprm_check_security(struct linux_binprm *brpm)
+ *
+ * has the following typedef:
+ *
+ *	typedef int (*lsm_btf_bprm_check_security)(struct linux_binprm *bprm);
+ */
+#define BTF_LSM_PREFIX "lsm_btf_"
+
+static inline int check_attach_btf_id_lsm(struct bpf_verifier_env *env)
+{
+	struct bpf_prog *prog = env->prog;
+	u32 btf_id = prog->aux->attach_btf_id;
+	const struct btf_type *t;
+	const char *tname;
+
+	if (!btf_id) {
+		verbose(env, "LSM programs must provide btf_id\n");
+		return -EINVAL;
+	}
+
+	t = btf_type_by_id(btf_vmlinux, btf_id);
+	if (!t) {
+		verbose(env, "attach_btf_id %u is invalid\n", btf_id);
+		return -EINVAL;
+	}
+
+	tname = btf_name_by_offset(btf_vmlinux, t->name_off);
+	if (!tname) {
+		verbose(env, "attach_btf_id %u doesn't have a name\n", btf_id);
+		return -EINVAL;
+	}
+
+	if (!btf_type_is_typedef(t)) {
+		verbose(env, "attach_btf_id %u is not a typedef\n", btf_id);
+		return -EINVAL;
+	}
+	if (strncmp(BTF_LSM_PREFIX, tname, sizeof(BTF_LSM_PREFIX) - 1)) {
+		verbose(env, "attach_btf_id %u points to wrong type name %s\n",
+			btf_id, tname);
+		return -EINVAL;
+	}
+
+	t = btf_type_by_id(btf_vmlinux, t->type);
+	/* should never happen in valid vmlinux build */
+	if (!btf_type_is_ptr(t))
+		return -EINVAL;
+	t = btf_type_by_id(btf_vmlinux, t->type);
+	/* should never happen in valid vmlinux build */
+	if (!btf_type_is_func_proto(t))
+		return -EINVAL;
+
+	tname += sizeof(BTF_LSM_PREFIX) - 1;
+	prog->aux->attach_func_name = tname;
+	prog->aux->attach_func_proto = t;
+	return 0;
+}
+
+static int check_attach_btf_id_tracing(struct bpf_verifier_env *env)
 {
 	struct bpf_prog *prog = env->prog;
 	struct bpf_prog *tgt_prog = prog->aux->linked_prog;
@@ -9519,9 +9583,6 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	long addr;
 	u64 key;
 
-	if (prog->type != BPF_PROG_TYPE_TRACING)
-		return 0;
-
 	if (!btf_id) {
 		verbose(env, "Tracing programs must provide btf_id\n");
 		return -EINVAL;
@@ -9659,6 +9720,20 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	}
 }
 
+static int check_attach_btf_id(struct bpf_verifier_env *env)
+{
+	struct bpf_prog *prog = env->prog;
+
+	switch (prog->type) {
+	case BPF_PROG_TYPE_TRACING:
+		return check_attach_btf_id_tracing(env);
+	case BPF_PROG_TYPE_LSM:
+		return check_attach_btf_id_lsm(env);
+	default:
+		return 0;
+	}
+}
+
 int bpf_check(struct bpf_prog **prog, union bpf_attr *attr,
 	      union bpf_attr __user *uattr)
 {
-- 
2.20.1

