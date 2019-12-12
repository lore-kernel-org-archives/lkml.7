Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CFBC00454
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF40A206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbfLLSA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 13:00:29 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:46983 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730023AbfLLSA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:00:27 -0500
Received: by mail-qv1-f66.google.com with SMTP id t9so1293250qvh.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 10:00:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LIz5NrqH1ej4Iy+bT6fVc5ps2O6rp6v/Upl0mdghbT8=;
        b=oSoasHRuDqiE7PFiDZ9EIKccIjUqhwVNIx2nAMSwgNlTKCu8zGLwNDWMGhQs6Wix+q
         B3IExuHFRxouYc64S0y5Pp7fhAKu+7q1kYcD2E+IKFeWmvQCZt2is4xh71b4tJkFJcSJ
         8yRXBBpLwBaCKLoppEcVNZJx43kl7Tq6hsx/XWU3YEaZ6IZFfu2AXXL8GM7qiybsPpux
         1cjFgzjp4pdyzudtlgm6ol7cY+PyRxtvuFl44MzKB61t9jegwQZJW6By4OBt9VHaZVjq
         ihr/udlovkzxxkIo8AVmTuONokEsPmdYMHME5loT/CyJpIf8uY0WFY3o03Wt8z9B7f75
         iuFQ==
X-Gm-Message-State: APjAAAV9UG8JYRzCn1mbvJOnUF7S5ZbKUvyflb9Z+x01Ujd+MaYboele
        mHoZOwNNnmZ/kW3K2x6rJIb1RCVZ
X-Google-Smtp-Source: APXvYqyaJx9jcYtwhfPl9kpmtH6O3bQyko435seWWnvNLifKTXqhg+5g8gjB/Srw2mpYuLJY7+tg/A==
X-Received: by 2002:a0c:b502:: with SMTP id d2mr7995940qve.110.1576173626502;
        Thu, 12 Dec 2019 10:00:26 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id j7sm1946037qkd.46.2019.12.12.10.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 10:00:25 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] init/main.c: remove unnecessary repair_env_string in do_initcall_level
Date:   Thu, 12 Dec 2019 13:00:22 -0500
Message-Id: <20191212180023.24339-3-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191212180023.24339-1-nivedita@alum.mit.edu>
References: <20191123214039.139275-1-nivedita@alum.mit.edu>
 <20191212180023.24339-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 08746a65c296 ("init: fix in-place parameter modification
regression"), parse_args in do_initcall_level is called on a copy of
saved_command_line. It is unnecessary to call repair_env_string during
this parsing, as this copy is not used for anything later.

Remove the now unnecessary arguments from repair_env_string as well.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 init/main.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/init/main.c b/init/main.c
index 4ebf4346a44c..a1febc3de582 100644
--- a/init/main.c
+++ b/init/main.c
@@ -246,8 +246,7 @@ static int __init loglevel(char *str)
 early_param("loglevel", loglevel);
 
 /* Change NUL term back to "=", to make "param" the whole string. */
-static int __init repair_env_string(char *param, char *val,
-				    const char *unused, void *arg)
+static void __init repair_env_string(char *param, char *val)
 {
 	if (val) {
 		/* param=val or param="val"? */
@@ -260,7 +259,6 @@ static int __init repair_env_string(char *param, char *val,
 		} else
 			BUG();
 	}
-	return 0;
 }
 
 /* Anything after -- gets handed straight to init. */
@@ -272,7 +270,7 @@ static int __init set_init_arg(char *param, char *val,
 	if (panic_later)
 		return 0;
 
-	repair_env_string(param, val, unused, NULL);
+	repair_env_string(param, val);
 
 	for (i = 0; argv_init[i]; i++) {
 		if (i == MAX_INIT_ARGS) {
@@ -292,7 +290,7 @@ static int __init set_init_arg(char *param, char *val,
 static int __init unknown_bootoption(char *param, char *val,
 				     const char *unused, void *arg)
 {
-	repair_env_string(param, val, unused, NULL);
+	repair_env_string(param, val);
 
 	/* Handle obsolete-style parameters */
 	if (obsolete_checksetup(param))
@@ -990,6 +988,12 @@ static const char *initcall_level_names[] __initdata = {
 	"late",
 };
 
+static int __init ignore_unknown_bootoption(char *param, char *val,
+			       const char *unused, void *arg)
+{
+	return 0;
+}
+
 static void __init do_initcall_level(int level)
 {
 	initcall_entry_t *fn;
@@ -999,7 +1003,7 @@ static void __init do_initcall_level(int level)
 		   initcall_command_line, __start___param,
 		   __stop___param - __start___param,
 		   level, level,
-		   NULL, &repair_env_string);
+		   NULL, ignore_unknown_bootoption);
 
 	trace_initcall_level(initcall_level_names[level]);
 	for (fn = initcall_levels[level]; fn < initcall_levels[level+1]; fn++)
-- 
2.23.0

