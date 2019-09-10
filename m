Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231A2C4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2DA8208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q0Kaw0aK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731908AbfIJL41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 07:56:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40791 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730510AbfIJL4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 07:56:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id w13so19613128wru.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 04:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lBurlrFx9NApN8HZXacuxACjRWwabjr3caQe3nHYfOw=;
        b=Q0Kaw0aKuZh6JKp4CnFHajfh/KoDL65xY1A3dfXqWnw4AllFop46Yyi667Eb31Yixz
         bUGKATekwkZveLZqkXzHMHfXMmuoLtvU5Z/qmCEajalJxZNZxUdU7CgoCDDEHtyZt+MT
         sBKDUrgZvW6oULiILCPpZZpiriwGuxI3E4fl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lBurlrFx9NApN8HZXacuxACjRWwabjr3caQe3nHYfOw=;
        b=n0XZYMYIFX1Kw1LoxLtuirgj5uRIiKXvgo/uINQhkE8pzJMc2GmIHJAq13bgsZqu6h
         KuCWJ0aGTvmr0vTj6kTUb90Z5JRRwEghFXw+XLp0fNjcW9LXQXfawTRQHLTAsNk9SfX2
         bji84zj139B0dS5ryD2V6sDtqDcpjtAZNeje2l/Xa4QruNUCys8VM7fcMilm7viVCS2I
         5lN2uH97nvaTZhKuUq+uO0X9hy37nDMMz7nQtd+UBxoQOkEbuwNZAM7gJiXidqxhgw5N
         ATM+tDk0IaHMhxtDC4AqOHfwB5Se0Neqn7d7jIoZmFBzASaNm1vpE5xx6i0j9zY4t6Cd
         3rZg==
X-Gm-Message-State: APjAAAWertLUSPfmgmxO79gp0j3iPnO2cQrnjBjr0Q3o1Ag1CCnfDPV/
        ujrk9/tLeo6zBWexi80fli/Hm1T7a+w=
X-Google-Smtp-Source: APXvYqwryehlOVJaXOszzD6q1im3sis23Rsk48FLKSO/q65Oy3onJ/O04Z3dY67MtlwB+Nif8ujPPw==
X-Received: by 2002:adf:e48f:: with SMTP id i15mr2908802wrm.26.1568116583227;
        Tue, 10 Sep 2019 04:56:23 -0700 (PDT)
Received: from kpsingh-kernel.c.hoisthospitality.com (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
        by smtp.gmail.com with ESMTPSA id q19sm23732935wra.89.2019.09.10.04.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 04:56:22 -0700 (PDT)
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
Subject: [RFC v1 01/14] krsi: Add a skeleton and config options for the KRSI LSM
Date:   Tue, 10 Sep 2019 13:55:14 +0200
Message-Id: <20190910115527.5235-2-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910115527.5235-1-kpsingh@chromium.org>
References: <20190910115527.5235-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KP Singh <kpsingh@google.com>

The LSM can be enabled by:

- Enabling CONFIG_SECURITY_KRSI.
- Adding "krsi" to the CONFIG_LSM string.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 MAINTAINERS            |  5 +++++
 security/Kconfig       |  1 +
 security/Makefile      |  2 ++
 security/krsi/Kconfig  | 22 ++++++++++++++++++++++
 security/krsi/Makefile |  1 +
 security/krsi/krsi.c   | 24 ++++++++++++++++++++++++
 6 files changed, 55 insertions(+)
 create mode 100644 security/krsi/Kconfig
 create mode 100644 security/krsi/Makefile
 create mode 100644 security/krsi/krsi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9cbcf167bdd0..8e0364391d8b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9002,6 +9002,11 @@ F:	include/linux/kprobes.h
 F:	include/asm-generic/kprobes.h
 F:	kernel/kprobes.c
 
+KRSI SECURITY MODULE
+M:	KP Singh <kpsingh@chromium.org>
+S:	Supported
+F:	security/krsi/
+
 KS0108 LCD CONTROLLER DRIVER
 M:	Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
 S:	Maintained
diff --git a/security/Kconfig b/security/Kconfig
index 0d65594b5196..febf7953803f 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -236,6 +236,7 @@ source "security/tomoyo/Kconfig"
 source "security/apparmor/Kconfig"
 source "security/loadpin/Kconfig"
 source "security/yama/Kconfig"
+source "security/krsi/Kconfig"
 source "security/safesetid/Kconfig"
 
 source "security/integrity/Kconfig"
diff --git a/security/Makefile b/security/Makefile
index c598b904938f..25779ce89bf2 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -9,6 +9,7 @@ subdir-$(CONFIG_SECURITY_SMACK)		+= smack
 subdir-$(CONFIG_SECURITY_TOMOYO)        += tomoyo
 subdir-$(CONFIG_SECURITY_APPARMOR)	+= apparmor
 subdir-$(CONFIG_SECURITY_YAMA)		+= yama
+subdir-$(CONFIG_SECURITY_KRSI)		+= krsi
 subdir-$(CONFIG_SECURITY_LOADPIN)	+= loadpin
 subdir-$(CONFIG_SECURITY_SAFESETID)    += safesetid
 
@@ -25,6 +26,7 @@ obj-$(CONFIG_AUDIT)			+= lsm_audit.o
 obj-$(CONFIG_SECURITY_TOMOYO)		+= tomoyo/
 obj-$(CONFIG_SECURITY_APPARMOR)		+= apparmor/
 obj-$(CONFIG_SECURITY_YAMA)		+= yama/
+obj-$(CONFIG_SECURITY_KRSI)		+= krsi/
 obj-$(CONFIG_SECURITY_LOADPIN)		+= loadpin/
 obj-$(CONFIG_SECURITY_SAFESETID)       += safesetid/
 obj-$(CONFIG_CGROUP_DEVICE)		+= device_cgroup.o
diff --git a/security/krsi/Kconfig b/security/krsi/Kconfig
new file mode 100644
index 000000000000..bf5eab4355af
--- /dev/null
+++ b/security/krsi/Kconfig
@@ -0,0 +1,22 @@
+config SECURITY_KRSI
+	bool "Runtime Security Instrumentation (BPF-based MAC and audit policy)"
+	depends on SECURITY
+	depends on SECURITYFS
+	depends on BPF
+	depends on BPF_SYSCALL
+	help
+	  This selects the Kernel Runtime Security Instrumentation
+	  LSM which allows dynamic instrumentation of the security hooks with
+	  eBPF programs. The LSM creates per-hook files in securityfs to which
+	  eBPF programs can be attached.
+
+	  If you are unsure how to answer this question, answer N.
+
+config SECURITY_KRSI_ENFORCE
+	bool "Deny operations based on the evaluation of the attached programs"
+	depends on SECURITY_KRSI
+	help
+	  eBPF programs attached to hooks can be used for both auditing and
+	  enforcement. Enabling enforcement implies that the evaluation result
+	  from the attached eBPF programs will allow and deny the operation
+	  guarded by the security hook.
diff --git a/security/krsi/Makefile b/security/krsi/Makefile
new file mode 100644
index 000000000000..73320e8d16f8
--- /dev/null
+++ b/security/krsi/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_SECURITY_KRSI) := krsi.o
diff --git a/security/krsi/krsi.c b/security/krsi/krsi.c
new file mode 100644
index 000000000000..9ce4f56fb78d
--- /dev/null
+++ b/security/krsi/krsi.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/lsm_hooks.h>
+
+static int krsi_process_execution(struct linux_binprm *bprm)
+{
+	return 0;
+}
+
+static struct security_hook_list krsi_hooks[] __lsm_ro_after_init = {
+	LSM_HOOK_INIT(bprm_check_security, krsi_process_execution),
+};
+
+static int __init krsi_init(void)
+{
+	security_add_hooks(krsi_hooks, ARRAY_SIZE(krsi_hooks), "krsi");
+	pr_info("eBPF and LSM are friends now.\n");
+	return 0;
+}
+
+DEFINE_LSM(krsi) = {
+	.name = "krsi",
+	.init = krsi_init,
+};
-- 
2.20.1

