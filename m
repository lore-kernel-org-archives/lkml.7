Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6038C606CF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 21:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8856216FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 21:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="XkNfo7Ng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405305AbfGHVPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 17:15:37 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39417 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405289AbfGHVPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 17:15:36 -0400
Received: by mail-qt1-f195.google.com with SMTP id l9so11257353qtu.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 14:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vxweX2U2+Z856CcsxOG088urab10u3d6VzbrdBwUe6o=;
        b=XkNfo7Ng1869ovdwpudNrw0wlKf9MA92JwTYiEJph+VGQaPDhIC8ozhsHnT3ZFniLu
         xX5baRnstpeEOucyVITA9Xz9gppuLf27+QYgMNoyyfvQQhbQm0IkYXSD4wudfvFtmWdc
         ft6PJVK9OseR8BeKy0amPm4xmQjutbUoow+0G2TPi/J3Zv8+jT9lkM9bUP73Sk0FgLFe
         Zo2AHEwA/8MQzVRxCMMmTV55f20IHgKxNhU3CGLLk4SdrOP78pSafOWNNt8ATwroaJWg
         DKiMOy0AoBI25TfdY+Ua4a0SXfP583XcfX5hcBjYLwNKKBDiq2qpD/Jk0nTyIcH5vILI
         mg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vxweX2U2+Z856CcsxOG088urab10u3d6VzbrdBwUe6o=;
        b=cS3fdjUYFe/ftChPtIxOt5nRAmuVX7RFqiT5D/K3uVswG3rLllO2THs4tXo86B7+od
         jCxKEaoQSZ11kkRHyQrb+kapqDMwWOA0+DQWM+lHvDW5hcrDxgcW9f8IJloeyc9zuXA5
         LTfF10ImA9x5JO1KQOwN5QvVcdX5B/HB1+2EgjlnAVQ9jNnGyW3Vcr5YMgBjuPlNUjnh
         +GEDzEZU9SuYxjx+JckKiMgg86TXS4tH5QlHh1tO2r1XNPfYsQ1bioB4YcfjmdCZWxub
         MZp7wbzmsiRyVbdfJSwUxbhR+lgD1sA6JZVSAy5/h4ICEw6VjvQ17p+maSmYGYKR7OnG
         SQww==
X-Gm-Message-State: APjAAAUGBia2x75dKqYujGMSl2B9HfROT8MDEDGT88MRgqrbSFGaRWUR
        UUvE5BIhvDtgPNH6FUyyd1Fi+w==
X-Google-Smtp-Source: APXvYqzOynfC/xBCJVtVyeRdCM0qBpL/RmjpG/GqV9GNhFtfJLujygjgPzG6SCWKgrGRU8fAmuANkw==
X-Received: by 2002:ac8:368a:: with SMTP id a10mr15795831qtc.143.1562620535026;
        Mon, 08 Jul 2019 14:15:35 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id b67sm8335620qkd.82.2019.07.08.14.15.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 14:15:34 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [v1 3/5] kexec: export common crashkernel/kexeckernel parser
Date:   Mon,  8 Jul 2019 17:15:26 -0400
Message-Id: <20190708211528.12392-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708211528.12392-1-pasha.tatashin@soleen.com>
References: <20190708211528.12392-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To reserve memory for normal kexec reboot, the new parameter:
kexeckernel=size[KMG][@offset[KMG]] is used. Its syntax is the
same as craskernel=, therefore they can use the same function to
parse parameter settings.

Rename: __parse_crashkernel() to parse_crash_or_kexec_kernel(), and
make it public.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 .../admin-guide/kernel-parameters.txt         |  7 +++++
 include/linux/crash_core.h                    |  6 +++++
 kernel/crash_core.c                           | 27 ++++++++++---------
 3 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 5c7a0f5b0a2f..0f5ce665c7f5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -739,6 +739,13 @@
 			It will be ignored when crashkernel=X,high is not used
 			or memory reserved is below 4G.
 
+	kexeckernel=size[KMG][@offset[KMG]]
+			[KNL] Using kexec, Linux can reboot to a new kernel.
+			This parameter reserves the physical memory region
+			[offset, offset + size] for that kernel. If '@offset' is
+			omitted, then a suitable offset is selected
+			automatically.
+
 	cryptomgr.notests
 			[KNL] Disable crypto self-tests
 
diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 525510a9f965..e90789ff0bec 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -74,5 +74,11 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
+int parse_crash_or_kexec_kernel(char *cmdline,
+				unsigned long long system_ram,
+				unsigned long long *crash_size,
+				unsigned long long *crash_base,
+				const char *name,
+				const char *suffix);
 
 #endif /* LINUX_CRASH_CORE_H */
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 9f1557b98468..11e0f9837a32 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -224,12 +224,12 @@ static __init char *get_last_crashkernel(char *cmdline,
 	return ck_cmdline;
 }
 
-static int __init __parse_crashkernel(char *cmdline,
-			     unsigned long long system_ram,
-			     unsigned long long *crash_size,
-			     unsigned long long *crash_base,
-			     const char *name,
-			     const char *suffix)
+int __init parse_crash_or_kexec_kernel(char *cmdline,
+				       unsigned long long system_ram,
+				       unsigned long long *crash_size,
+				       unsigned long long *crash_base,
+				       const char *name,
+				       const char *suffix)
 {
 	char	*first_colon, *first_space;
 	char	*ck_cmdline;
@@ -270,8 +270,9 @@ int __init parse_crashkernel(char *cmdline,
 			     unsigned long long *crash_size,
 			     unsigned long long *crash_base)
 {
-	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
-					"crashkernel=", NULL);
+	return parse_crash_or_kexec_kernel(cmdline, system_ram, crash_size,
+					   crash_base, "crashkernel=",
+					   NULL);
 }
 
 int __init parse_crashkernel_high(char *cmdline,
@@ -279,8 +280,9 @@ int __init parse_crashkernel_high(char *cmdline,
 			     unsigned long long *crash_size,
 			     unsigned long long *crash_base)
 {
-	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
-				"crashkernel=", suffix_tbl[SUFFIX_HIGH]);
+	return parse_crash_or_kexec_kernel(cmdline, system_ram, crash_size,
+					   crash_base, "crashkernel=",
+					   suffix_tbl[SUFFIX_HIGH]);
 }
 
 int __init parse_crashkernel_low(char *cmdline,
@@ -288,8 +290,9 @@ int __init parse_crashkernel_low(char *cmdline,
 			     unsigned long long *crash_size,
 			     unsigned long long *crash_base)
 {
-	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
-				"crashkernel=", suffix_tbl[SUFFIX_LOW]);
+	return parse_crash_or_kexec_kernel(cmdline, system_ram, crash_size,
+					   crash_base, "crashkernel=",
+					   suffix_tbl[SUFFIX_LOW]);
 }
 
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
-- 
2.22.0

