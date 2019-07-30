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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55498C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A0E20679
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tj0gXvOU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731262AbfG3CoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:44:12 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35643 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730921AbfG3CoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:44:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id u14so29031168pfn.2;
        Mon, 29 Jul 2019 19:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P/oAL9ofxFqbhCpen6x+V4iB48WMRp4QBpRHUGHCpmA=;
        b=Tj0gXvOUsDfjz4D5pRbR819A6O5NQZT+M5zPLp0+B66zRGysFaReydFyhXsh7lNNCr
         wiafLBNNfPElcZQtSF70CKp0ubFEITO9XJpZ9YF4yFayQz8RC+GQeSSrj4+05iiPLmuK
         2gr8rq3y18K+qg6MHC6RLmWEL6BxlELZNBZD7P+JaIgoahtkxbdK5uy7yxlERaZ2c1mO
         om7/94MFbTVVazRljk0SsOm7z0brUjSuEdnDwjk2gp/7jNUQ1500q8bn3bPpp2fkmMvZ
         SvszVfAxvpTD4qOf85rb7g4FV4m/VmMrw5qrrRZlLeTkpi7iCZWnKdRHNJZyMjY5YO6h
         pwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P/oAL9ofxFqbhCpen6x+V4iB48WMRp4QBpRHUGHCpmA=;
        b=qH553bvBGismMwr9vJ1pePcaePA6L/CALKkEBjK5UUHKc01iiUeN+et6YT+dbHn//L
         GwowlDXUILyYO5zQTZCdxx8jP5SWq1GDg+z/1bQGoXy76I+sJLHbRuqStCe21yDVRufD
         NkdKn4KOs+XtKuyWwT+dhzNspWRY7WT0QNh9F+046Qz+L09H56fEG7L0a+l4CyXgHmab
         ymGlltEkgprP4guuym4Tb77NluwC2piU+3QAd2uz/vxXLpJU6kcil9jLCPOzG3FWLr8f
         IwlLMNMswqvnE3Ldcu5skGf2YXvd2tUhp/VddQEW4YwltyifqGJIKz4j5+T22wMvikmd
         Gvng==
X-Gm-Message-State: APjAAAW49hgxbxBZro6OFf/lcOKW9OkTQyJMKrvZ7wj9SsNUnjTr2I0K
        93SVUbTO3RePwUc26Gn+JWU=
X-Google-Smtp-Source: APXvYqwCB7fPp1uuBktnCHfexv2TXgUVmtZxuoXTALSVRgKw9qhLBJ+hqNmOyzqZ8R6oPIJ21rQ03A==
X-Received: by 2002:a17:90b:d82:: with SMTP id bg2mr72812664pjb.87.1564454648564;
        Mon, 29 Jul 2019 19:44:08 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id 67sm29330228pfd.177.2019.07.29.19.44.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 19:44:07 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] alpha: Replace strncmp with str_has_prefix
Date:   Tue, 30 Jul 2019 10:44:01 +0800
Message-Id: <20190730024401.17152-1-hslester96@gmail.com>
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
 arch/alpha/boot/tools/objstrip.c | 3 ++-
 arch/alpha/kernel/setup.c        | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/boot/tools/objstrip.c b/arch/alpha/boot/tools/objstrip.c
index 825a16f5f622..4738aaf76c3d 100644
--- a/arch/alpha/boot/tools/objstrip.c
+++ b/arch/alpha/boot/tools/objstrip.c
@@ -148,7 +148,8 @@ main (int argc, char *argv[])
 #ifdef __ELF__
     elf = (struct elfhdr *) buf;
 
-    if (elf->e_ident[0] == 0x7f && strncmp((char *)elf->e_ident + 1, "ELF", 3) == 0) {
+	if (elf->e_ident[0] == 0x7f &&
+		str_has_prefix((char *)elf->e_ident + 1, "ELF")) {
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

