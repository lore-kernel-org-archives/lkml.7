Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF32C2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 162CF24689
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RJtIT+M7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfLTPmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 10:42:12 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51476 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbfLTPmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 10:42:09 -0500
Received: by mail-wm1-f67.google.com with SMTP id d73so9394862wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 07:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W3ikVYW2VHd7LIQCP37/NV9odo+wJGrACNZfFA7D07g=;
        b=RJtIT+M71DBSAz6HBmcqeDGoEFJnpaRfB3D1OWgMxlX6No49nBa97p0CrZRCeg+YmI
         EBf6iqD1S5sCoqauyOqOluyS9TZrzGwUnIrQ04zuz6icOhtJri7WSJB1z7AhuOx57PPa
         PTyNtY0+Na/YSdwN0shWHSYSW9CivxHkLwj6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W3ikVYW2VHd7LIQCP37/NV9odo+wJGrACNZfFA7D07g=;
        b=udfeAQ3aAOCLzsYzeN51yOb23/6zk0KwtO8G7GiVW3qwRhVvZRmqkVnkr9Wv8Qk8pk
         tp794zWsqu6u57LkPtNHbfY3CxjIXhFbwBIaHgv2AaTa20c499Lf7HRFo+Q60PR26ch7
         u4Q8ShRxxbbu351mdjPb9SLSI5zSVi1rXRoEIjoDQ4hwA4VrFf9zGV+lPcih666CAcaf
         nWjjzkZeSw2HRXMuoRLq+f+dmpxkXsCJ7cRl2mvxhwGCc2cYu2D3dehonCaAvii381NH
         Ku2AbvJ1xtlzZmhiA0ViOJv/cuP7wgmUCZPE+6zEUzkly8hGZrBg0j1GNHCuigj4f4pN
         wLeA==
X-Gm-Message-State: APjAAAUlh90azE+fmKQeelZ+2HFOUoyOy5ija19evYEoUt31RWkDZK3r
        MdBwPlknvh4D1F6rbwNxFkPRnelP200=
X-Google-Smtp-Source: APXvYqyVKsjtf80AQbpdWBOAeWsiNIXNCUAtx2pp1vsLceMqRMKQcroWanJ2rJpf4oA/3/lvTJTTZg==
X-Received: by 2002:a7b:c407:: with SMTP id k7mr17559393wmi.46.1576856527148;
        Fri, 20 Dec 2019 07:42:07 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2a00:79e1:abc:308:c46b:b838:66cf:6204])
        by smtp.gmail.com with ESMTPSA id x11sm10118062wmg.46.2019.12.20.07.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 07:42:06 -0800 (PST)
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
Subject: [PATCH bpf-next v1 03/13] bpf: lsm: Introduce types for eBPF based LSM
Date:   Fri, 20 Dec 2019 16:41:58 +0100
Message-Id: <20191220154208.15895-4-kpsingh@chromium.org>
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

A new eBPF program type BPF_PROG_TYPE_LSM with an
expected attach type of BPF_LSM_MAC. An -EINVAL error is returned if an
attachment is currently requested.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/linux/bpf_types.h      |  4 ++++
 include/uapi/linux/bpf.h       |  2 ++
 kernel/bpf/syscall.c           |  6 ++++++
 security/bpf/Makefile          |  2 +-
 security/bpf/ops.c             | 14 ++++++++++++++
 tools/include/uapi/linux/bpf.h |  2 ++
 6 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100644 security/bpf/ops.c

diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index 93740b3614d7..5f48161529b4 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -65,6 +65,10 @@ BPF_PROG_TYPE(BPF_PROG_TYPE_LIRC_MODE2, lirc_mode2,
 BPF_PROG_TYPE(BPF_PROG_TYPE_SK_REUSEPORT, sk_reuseport,
 	      struct sk_reuseport_md, struct sk_reuseport_kern)
 #endif
+#ifdef CONFIG_SECURITY_BPF
+BPF_PROG_TYPE(BPF_PROG_TYPE_LSM, lsm,
+	       void *, void *)
+#endif
 
 BPF_MAP_TYPE(BPF_MAP_TYPE_ARRAY, array_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_ARRAY, percpu_array_map_ops)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index dbbcf0b02970..fc64ae865526 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -174,6 +174,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE,
 	BPF_PROG_TYPE_CGROUP_SOCKOPT,
 	BPF_PROG_TYPE_TRACING,
+	BPF_PROG_TYPE_LSM,
 };
 
 enum bpf_attach_type {
@@ -203,6 +204,7 @@ enum bpf_attach_type {
 	BPF_TRACE_RAW_TP,
 	BPF_TRACE_FENTRY,
 	BPF_TRACE_FEXIT,
+	BPF_LSM_MAC,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e3461ec59570..5a773fc6f9f5 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2096,6 +2096,9 @@ static int bpf_prog_attach(const union bpf_attr *attr)
 	case BPF_LIRC_MODE2:
 		ptype = BPF_PROG_TYPE_LIRC_MODE2;
 		break;
+	case BPF_LSM_MAC:
+		ptype = BPF_PROG_TYPE_LSM;
+		break;
 	case BPF_FLOW_DISSECTOR:
 		ptype = BPF_PROG_TYPE_FLOW_DISSECTOR;
 		break;
@@ -2127,6 +2130,9 @@ static int bpf_prog_attach(const union bpf_attr *attr)
 	case BPF_PROG_TYPE_LIRC_MODE2:
 		ret = lirc_prog_attach(attr, prog);
 		break;
+	case BPF_PROG_TYPE_LSM:
+		ret = -EINVAL;
+		break;
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
 		ret = skb_flow_dissector_bpf_prog_attach(attr, prog);
 		break;
diff --git a/security/bpf/Makefile b/security/bpf/Makefile
index 26a0ab6f99b7..c78a8a056e7e 100644
--- a/security/bpf/Makefile
+++ b/security/bpf/Makefile
@@ -2,4 +2,4 @@
 #
 # Copyright 2019 Google LLC.
 
-obj-$(CONFIG_SECURITY_BPF) := lsm.o
+obj-$(CONFIG_SECURITY_BPF) := lsm.o ops.o
diff --git a/security/bpf/ops.c b/security/bpf/ops.c
new file mode 100644
index 000000000000..2fa3ebdf598d
--- /dev/null
+++ b/security/bpf/ops.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2019 Google LLC.
+ */
+
+#include <linux/filter.h>
+#include <linux/bpf.h>
+
+const struct bpf_prog_ops lsm_prog_ops = {
+};
+
+const struct bpf_verifier_ops lsm_verifier_ops = {
+};
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index dbbcf0b02970..fc64ae865526 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -174,6 +174,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE,
 	BPF_PROG_TYPE_CGROUP_SOCKOPT,
 	BPF_PROG_TYPE_TRACING,
+	BPF_PROG_TYPE_LSM,
 };
 
 enum bpf_attach_type {
@@ -203,6 +204,7 @@ enum bpf_attach_type {
 	BPF_TRACE_RAW_TP,
 	BPF_TRACE_FENTRY,
 	BPF_TRACE_FEXIT,
+	BPF_LSM_MAC,
 	__MAX_BPF_ATTACH_TYPE
 };
 
-- 
2.20.1

