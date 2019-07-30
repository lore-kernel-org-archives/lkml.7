Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834AEC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5508C20578
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghT6fDpV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732871AbfG3DCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 23:02:49 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44470 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732730AbfG3DCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:02:47 -0400
Received: by mail-pl1-f196.google.com with SMTP id t14so28251248plr.11;
        Mon, 29 Jul 2019 20:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+wCRrWmIk4Nc0ISlty592sI89pc1yeuZmJCIRwRKr38=;
        b=ghT6fDpVNQ07/bhniKx+0CDugTQLh2JuWxcYh3Pb//LfguBMq+Gqu7hVYuz3aijLPn
         yWnIUQvZfjFLY6DTd3CazPQc+N5vQQhVfzWHDQNWSrEZRyTRJ9K4K9zcsJqqI7uAoakU
         b4hZTOP2udpN3kw7efV2bfANPqRPKCUt0ATxHzXtlddSyNZuTiHq3y+YUf4EREpqSCg6
         9cqK6u5eOem9eU25GHVttXUcSdqxcZzx1nBqkLMnEdTvzn5sWvJ6eI1plWCcCFlKlO4l
         o/YczNKWpyo5ACc2aBofLGx5MVnfyKEdeUxNqqXurvAF4Tox+sdngD8OwjBAXQepyUfa
         8Maw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+wCRrWmIk4Nc0ISlty592sI89pc1yeuZmJCIRwRKr38=;
        b=IFCs/W5xtvuXu96OaIAFFaSr2Bp+RZH4fHNNjRuPsV34n4sAm7Urx209leISa5WCGc
         U9rmTIVUAcUwDovlg3VG6+HESehFaHtlZF+H+/b8Db1DIqzyGVHhbLWn9rk7gHWiSR4I
         4Y/Cc/yonRNB8b6Ts838J9HPefUCuj0pucEs0D/QlDOMmMFn9WVS1O3lC2yjP43BpZuk
         v7gM297VEwzXMakBiYQlbX6TRxLsQkZQCPOe+ocHnAg3AwAmOzvvMeVefgJwANcI9Uw3
         4Xq/H3hAtxkdHQ2BrQ31xNXa8uPCJplk8EjfEM5LOq1u3h1BxIknjr3UAC0CIIcbtQLn
         t9RQ==
X-Gm-Message-State: APjAAAUxKZUbPZYwodRxe37WUzrVjMWidryivMLujZcRiMW0zORp6z5Z
        IioUgKsQdk9HAGkZRhIKxQU=
X-Google-Smtp-Source: APXvYqwtEg9oc+Ub8h8Ztki2a4IVL/OlCf+NImHZ83H+rMfXxdSJaWW1wJI9LMdfpoOlIOryu4ft3w==
X-Received: by 2002:a17:902:8bc1:: with SMTP id r1mr64301099plo.42.1564455766537;
        Mon, 29 Jul 2019 20:02:46 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id h26sm66277793pfq.64.2019.07.29.20.02.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 20:02:45 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2] alpha: Replace strncmp with str_has_prefix
Date:   Tue, 30 Jul 2019 11:02:39 +0800
Message-Id: <20190730030239.17983-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit b6b2735514bc
("tracing: Use str_has_prefix() instead of using fixed sizes")
the newly introduced str_has_prefix() was used
to replace error-prone strncmp(str, const, len).
Here fix codes with the same pattern.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
  - Revise the indent and aligning.

 arch/alpha/boot/tools/objstrip.c | 2 +-
 arch/alpha/kernel/setup.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/boot/tools/objstrip.c b/arch/alpha/boot/tools/objstrip.c
index 825a16f5f622..08b430d25a31 100644
--- a/arch/alpha/boot/tools/objstrip.c
+++ b/arch/alpha/boot/tools/objstrip.c
@@ -148,7 +148,7 @@ main (int argc, char *argv[])
 #ifdef __ELF__
     elf = (struct elfhdr *) buf;
 
-    if (elf->e_ident[0] == 0x7f && strncmp((char *)elf->e_ident + 1, "ELF", 3) == 0) {
+    if (elf->e_ident[0] == 0x7f && str_has_prefix((char *)elf->e_ident + 1, "ELF")) {
 	if (elf->e_type != ET_EXEC) {
 	    fprintf(stderr, "%s: %s is not an ELF executable\n",
 		    prog_name, inname);
diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index 5d4c76a77a9f..e82e45d5fd96 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -466,7 +466,7 @@ setup_arch(char **cmdline_p)
 #ifndef alpha_using_srm
 	/* Assume that we've booted from SRM if we haven't booted from MILO.
 	   Detect the later by looking for "MILO" in the system serial nr.  */
-	alpha_using_srm = strncmp((const char *)hwrpb->ssn, "MILO", 4) != 0;
+	alpha_using_srm = !str_has_prefix((const char *)hwrpb->ssn, "MILO");
 #endif
 #ifndef alpha_using_qemu
 	/* Similarly, look for QEMU.  */
-- 
2.20.1

