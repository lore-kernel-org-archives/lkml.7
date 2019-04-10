Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8282BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535A82133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="nAn+V0M7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfDJT51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:57:27 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40010 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfDJT51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:57:27 -0400
Received: by mail-pl1-f194.google.com with SMTP id b3so2043954plr.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 12:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T6Rg88aOAsFuASkW0lngbtXxdztNb7Uj9gIPChv2xDg=;
        b=nAn+V0M7OY8g5dMyOPn2KXwLUWbVvngXjTZPfTTw/OhT+KFSM+gOxxgAWsYZGEFP1D
         8ppImtf7O9RckICqlzErXj0E83HGy3uNv7TDeGZHmSuJMKZhCQVld02N4VDxYx8IdYVw
         YVZATb+BlZAzUOBrC+GHiiNniV2bBuTQD784I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T6Rg88aOAsFuASkW0lngbtXxdztNb7Uj9gIPChv2xDg=;
        b=UQpgfmuAkxvegqPC2dEfSNB06RPvLo35M9/VnD8/Y4VcDOgkj/GbZadQIOPrkiTeSS
         CxbwLyb+MT+9HD0imGKwBl9ffWzSXpnc1C9Ml448l2nj0F7UZquBR9l26+f5NoNjKQwC
         VM970+1Bff77TunHHZrpAtPwY45M9ntvPGqJFlNuPjiwjDtYzPE9yHHuSUbJpYCO/XJL
         NjyUbC1XDazNbvrK4UFwu1PL6SEbpyhY2L4yQ/8/1DtUoVzlH+sktX4BsZGInGc5NP2N
         X2ggk5sI1Oh6pE28VS7sQmrSsUEvW/2/r9TGqEUHLWxWpY4VlCrUW4ccznmhf5A9R/eU
         59lg==
X-Gm-Message-State: APjAAAXb/EdXH+pOHx4+4lJLF01G007jDTcMsbmO+4+IabyKYyVGfiNG
        rXdJ+qbrC7sl0BuwoPIQvAXME1/Z64Q=
X-Google-Smtp-Source: APXvYqwEGOZh3DKCeXW9Mrc2BfiT6pVyeSVviNSCnQ5uqobOWsQrmxEkf741BqO8AzuTS7XkBu0KLQ==
X-Received: by 2002:a17:902:a9c7:: with SMTP id b7mr43911944plr.145.1554926246076;
        Wed, 10 Apr 2019 12:57:26 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v12sm48703375pfe.148.2019.04.10.12.57.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 12:57:25 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        paulmck@linux.vnet.ibm.com, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        keescook@chromium.org, Jessica Yu <jeyu@kernel.org>
Subject: [PATCH v3 1/3] module: Prepare for addition of new ro_after_init sections
Date:   Wed, 10 Apr 2019 15:57:06 -0400
Message-Id: <20190410195708.162185-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the purposes of hardening modules by adding sections to
ro_after_init sections, prepare for addition of new ro_after_init
entries which we do in future patches. Create a table to which new
entries could be added later. This makes it less error prone and reduce
code duplication.

Cc: paulmck@linux.vnet.ibm.com
Cc: rostedt@goodmis.org
Cc: mathieu.desnoyers@efficios.com
Cc: rcu@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com
Cc: kernel-team@android.com
Suggested-by: keescook@chromium.org
Reviewed-by: keescook@chromium.org
Acked-by: rostedt@goodmis.org
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
 kernel/module.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 524da609c884..42e4e289d6c7 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3300,11 +3300,27 @@ static bool blacklisted(const char *module_name)
 }
 core_param(module_blacklist, module_blacklist, charp, 0400);
 
+/*
+ * Mark ro_after_init section with SHF_RO_AFTER_INIT so that
+ * layout_sections() can put it in the right place.
+ * Note: ro_after_init sections also have SHF_{WRITE,ALLOC} set.
+ */
+static const char * const ro_after_init_sections[] = {
+	".data..ro_after_init",
+
+	/*
+	 * __jump_table structures are never modified, with the exception of
+	 * entries that refer to code in the __init section, which are
+	 * annotated as such at module load time.
+	 */
+	"__jump_table",
+};
+
 static struct module *layout_and_allocate(struct load_info *info, int flags)
 {
 	struct module *mod;
 	unsigned int ndx;
-	int err;
+	int err, i;
 
 	err = check_modinfo(info->mod, info, flags);
 	if (err)
@@ -3319,23 +3335,12 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
 	/* We will do a special allocation for per-cpu sections later. */
 	info->sechdrs[info->index.pcpu].sh_flags &= ~(unsigned long)SHF_ALLOC;
 
-	/*
-	 * Mark ro_after_init section with SHF_RO_AFTER_INIT so that
-	 * layout_sections() can put it in the right place.
-	 * Note: ro_after_init sections also have SHF_{WRITE,ALLOC} set.
-	 */
-	ndx = find_sec(info, ".data..ro_after_init");
-	if (ndx)
-		info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
-	/*
-	 * Mark the __jump_table section as ro_after_init as well: these data
-	 * structures are never modified, with the exception of entries that
-	 * refer to code in the __init section, which are annotated as such
-	 * at module load time.
-	 */
-	ndx = find_sec(info, "__jump_table");
-	if (ndx)
-		info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
+	/* Set sh_flags for read-only after init sections */
+	for (i = 0; i < ARRAY_SIZE(ro_after_init_sections); i++) {
+		ndx = find_sec(info, ro_after_init_sections[i]);
+		if (ndx)
+			info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
+	}
 
 	/* Determine total sizes, and put offsets in sh_entsize.  For now
 	   this is done generically; there doesn't appear to be any
-- 
2.21.0.392.gf8f6787159e-goog

