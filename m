Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79253C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 16:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344D620722
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 16:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C/H/9VQ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfL2Qsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 11:48:36 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:55698 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfL2Qsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 11:48:36 -0500
Received: by mail-pj1-f73.google.com with SMTP id bg6so10674521pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Dec 2019 08:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=G2EAa5QdJG1X2s38OI2Ndje11N5B4/Yby2K/2bfNOiY=;
        b=C/H/9VQ7ZNg8f2sw+U4qk1c9SVUehLJ6VS/qlJbMff1SHVKvNqK9fn0X1FDqHYaPyj
         YcLwaaHra5lc5FoPp8EVUzqxvgSEGsk6du/2FDcyVYWPQt6J0c2y5eauTjvtP3HsO0Zh
         jzcWshUO5ji5J092ncEmstw/KfFg/njqIOdhDwxGD/bl5KI0Jx7KergLr8XWCWpX/5JI
         tOYeCCzizETf3DYZONmzaT8jSLbDb43Fhe6zsrEbVJK0xk7tkANl1z7lhzl+XypdSH+c
         y5C+5a3QwWNzVWd16X4yNdfLcRoODJ6R09L1hps3S9E70i6Vx+fKYIpPeOimE07cBx1G
         BVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=G2EAa5QdJG1X2s38OI2Ndje11N5B4/Yby2K/2bfNOiY=;
        b=gocgjqtS2wpcjBUkLWnyjQgu8Zd3tNWQCDBEQ6ed3Hj3PqSMO2GKmZebA2GRGQik5E
         v358lt9UwjSjQ++/IUK15MivPz0r4ze2/xGlZTlxsAdLQfKnEZCaIDOqS3+4LJ1VJFnf
         XxcoMP4aT76OLdMr01LwrSDamvldLkahaxWTnh8ebioAJVxvGXpV372UNMhTvBey9DTv
         TFHqvI4Yf9eIfMu8zVtV0NgwKoDADWkevL51eIAz8VvKKxw90B+IcDcffhcBfzHh7F4R
         iAPXV+WhzuqQy3cjRpBMuHx+1XpimcHQXnbHUMGe8CdjtXoSdQV6n58PnyIWSVoYl1ZO
         ArzA==
X-Gm-Message-State: APjAAAW8njRx+Cm8aVQ7bDS4Z4A1TSDne1earApXJWJPMpJ7/rdUzzeQ
        Sun2xavQQqxFBDsbq8eojDCVBNoQKJzOqizvSIs4sNipR3CJkx7OkwV2n3deNuC0XI/UFvXP23D
        XnlQI6cTeHMvoUog1Pzh2P4PGk5UBw6s/ai2OCTx18TiTweEZ12z8cdHVY8rKp+CqHk2gufCUeL
        mF77PE8s9+
X-Google-Smtp-Source: APXvYqzNn2GrkUfZEjhR7jsMIExXD1RM93OMu63n7lT7lnp+mnvB2aj7QcV3EB1wb67NHg6h8PR63ae4znB8sK7OTz0=
X-Received: by 2002:a63:4e0e:: with SMTP id c14mr66892846pgb.237.1577638115094;
 Sun, 29 Dec 2019 08:48:35 -0800 (PST)
Date:   Sun, 29 Dec 2019 08:48:30 -0800
Message-Id: <20191229164830.62144-1-asteinhauser@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH] Return ENXIO instead of EPERM when speculation control is unimplemented
From:   Anthony Steinhauser <asteinhauser@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, bp@alien8.de, tglx@linutronix.de,
        Anthony Steinhauser <asteinhauser@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the documentation, the PR_GET_SPECULATION_CTRL call should
return ENXIO when the control of the selected speculation misfeature is
not possible. EPERM should be returned only when the speculation was
disabled with PR_SPEC_FORCE_DISABLE and caller tried to enable it again.

Instead, the current implementation returns EPERM when the control of
indirect branch speculation is not possible because it is unimplemented by
the CPU. This behavior is obviously not compatible with the current
documentation. ENXIO should be returned in this case.

This change is:
1) Explicitly document that the EPERM return value applies also to cases
when the speculative behavior is forced from the boot command line and the
caller tries to change it.
2) Distinguishing between the speculation control being unimplemented and
being disabled, returning ENXIO in the first case and EPERM in the second
case.

Signed-off-by: Anthony Steinhauser <asteinhauser@google.com>
---
 Documentation/userspace-api/spec_ctrl.rst |  6 +++--
 arch/x86/include/asm/nospec-branch.h      |  3 ++-
 arch/x86/kernel/cpu/bugs.c                | 29 +++++++++++++++--------
 3 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/Documentation/userspace-api/spec_ctrl.rst b/Documentation/userspace-api/spec_ctrl.rst
index 7ddd8f667459..3ff6316207f1 100644
--- a/Documentation/userspace-api/spec_ctrl.rst
+++ b/Documentation/userspace-api/spec_ctrl.rst
@@ -83,8 +83,10 @@ ERANGE  arg3 is incorrect, i.e. it's neither PR_SPEC_ENABLE nor
 ENXIO   Control of the selected speculation misfeature is not possible.
         See PR_GET_SPECULATION_CTRL.
 
-EPERM   Speculation was disabled with PR_SPEC_FORCE_DISABLE and caller
-        tried to enable it again.
+EPERM   Caller tried to enable speculation when it was disabled with
+        PR_SPEC_FORCE_DISABLE or force-disabled on the boot command line.
+        Caller tried to disable speculation when it was force-enabled on
+        the boot command line.
 ======= =================================================================
 
 Speculation misfeature controls
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 5c24a7b35166..1e2caccac89e 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -220,7 +220,8 @@ enum spectre_v2_mitigation {
 
 /* The indirect branch speculation control variants */
 enum spectre_v2_user_mitigation {
-	SPECTRE_V2_USER_NONE,
+	SPECTRE_V2_USER_UNAVAILABLE,
+	SPECTRE_V2_USER_DISABLED,
 	SPECTRE_V2_USER_STRICT,
 	SPECTRE_V2_USER_STRICT_PREFERRED,
 	SPECTRE_V2_USER_PRCTL,
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 8bf64899f56a..a6556483b136 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -489,7 +489,7 @@ static enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init =
 	SPECTRE_V2_NONE;
 
 static enum spectre_v2_user_mitigation spectre_v2_user __ro_after_init =
-	SPECTRE_V2_USER_NONE;
+	SPECTRE_V2_USER_UNAVAILABLE;
 
 #ifdef CONFIG_RETPOLINE
 static bool spectre_v2_bad_module;
@@ -540,7 +540,8 @@ enum spectre_v2_user_cmd {
 };
 
 static const char * const spectre_v2_user_strings[] = {
-	[SPECTRE_V2_USER_NONE]			= "User space: Vulnerable",
+	[SPECTRE_V2_USER_UNAVAILABLE]		= "User space: Vulnerable: STIBP unavailable",
+	[SPECTRE_V2_USER_DISABLED]		= "User space: Vulnerable: STIBP disabled",
 	[SPECTRE_V2_USER_STRICT]		= "User space: Mitigation: STIBP protection",
 	[SPECTRE_V2_USER_STRICT_PREFERRED]	= "User space: Mitigation: STIBP always-on protection",
 	[SPECTRE_V2_USER_PRCTL]			= "User space: Mitigation: STIBP via prctl",
@@ -602,7 +603,7 @@ spectre_v2_parse_user_cmdline(enum spectre_v2_mitigation_cmd v2_cmd)
 static void __init
 spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
 {
-	enum spectre_v2_user_mitigation mode = SPECTRE_V2_USER_NONE;
+	enum spectre_v2_user_mitigation mode = SPECTRE_V2_USER_UNAVAILABLE;
 	bool smt_possible = IS_ENABLED(CONFIG_SMP);
 	enum spectre_v2_user_cmd cmd;
 
@@ -616,6 +617,7 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
 	cmd = spectre_v2_parse_user_cmdline(v2_cmd);
 	switch (cmd) {
 	case SPECTRE_V2_USER_CMD_NONE:
+		mode = SPECTRE_V2_USER_DISABLED;
 		goto set_mode;
 	case SPECTRE_V2_USER_CMD_FORCE:
 		mode = SPECTRE_V2_USER_STRICT;
@@ -676,7 +678,7 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
 	 * mode.
 	 */
 	if (!smt_possible || !boot_cpu_has(X86_FEATURE_STIBP))
-		mode = SPECTRE_V2_USER_NONE;
+		mode = SPECTRE_V2_USER_UNAVAILABLE;
 set_mode:
 	spectre_v2_user = mode;
 	/* Only print the STIBP mode when SMT possible */
@@ -915,7 +917,8 @@ void cpu_bugs_smt_update(void)
 	mutex_lock(&spec_ctrl_mutex);
 
 	switch (spectre_v2_user) {
-	case SPECTRE_V2_USER_NONE:
+	case SPECTRE_V2_USER_DISABLED:
+	case SPECTRE_V2_USER_UNAVAILABLE:
 		break;
 	case SPECTRE_V2_USER_STRICT:
 	case SPECTRE_V2_USER_STRICT_PREFERRED:
@@ -1157,7 +1160,8 @@ static int ib_prctl_set(struct task_struct *task, unsigned long ctrl)
 {
 	switch (ctrl) {
 	case PR_SPEC_ENABLE:
-		if (spectre_v2_user == SPECTRE_V2_USER_NONE)
+		if (spectre_v2_user == SPECTRE_V2_USER_UNAVAILABLE ||
+		    spectre_v2_user == SPECTRE_V2_USER_DISABLED)
 			return 0;
 		/*
 		 * Indirect branch speculation is always disabled in strict
@@ -1173,9 +1177,11 @@ static int ib_prctl_set(struct task_struct *task, unsigned long ctrl)
 	case PR_SPEC_FORCE_DISABLE:
 		/*
 		 * Indirect branch speculation is always allowed when
-		 * mitigation is force disabled.
+		 * mitigation is unavailable or force disabled.
 		 */
-		if (spectre_v2_user == SPECTRE_V2_USER_NONE)
+		if (spectre_v2_user == SPECTRE_V2_USER_UNAVAILABLE)
+			return -ENXIO;
+		if (spectre_v2_user == SPECTRE_V2_USER_DISABLED)
 			return -EPERM;
 		if (spectre_v2_user == SPECTRE_V2_USER_STRICT ||
 		    spectre_v2_user == SPECTRE_V2_USER_STRICT_PREFERRED)
@@ -1241,7 +1247,8 @@ static int ib_prctl_get(struct task_struct *task)
 		return PR_SPEC_NOT_AFFECTED;
 
 	switch (spectre_v2_user) {
-	case SPECTRE_V2_USER_NONE:
+	case SPECTRE_V2_USER_UNAVAILABLE:
+	case SPECTRE_V2_USER_DISABLED:
 		return PR_SPEC_ENABLE;
 	case SPECTRE_V2_USER_PRCTL:
 	case SPECTRE_V2_USER_SECCOMP:
@@ -1495,7 +1502,9 @@ static char *stibp_state(void)
 		return "";
 
 	switch (spectre_v2_user) {
-	case SPECTRE_V2_USER_NONE:
+	case SPECTRE_V2_USER_UNAVAILABLE:
+		return ", STIBP: unavailable";
+	case SPECTRE_V2_USER_DISABLED:
 		return ", STIBP: disabled";
 	case SPECTRE_V2_USER_STRICT:
 		return ", STIBP: forced";
-- 
2.24.1.735.g03f4e72817-goog

