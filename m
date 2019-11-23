Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA1CC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 21:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5E220679
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 21:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfKWVko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 16:40:44 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42380 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfKWVkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 16:40:43 -0500
Received: by mail-qk1-f194.google.com with SMTP id i3so9438376qkk.9
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 13:40:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U73ogPu5oQ0nNykSJGRun0NX2DnBSnxUQ+74Mv45tWo=;
        b=umcVATRDE+1DuqK8+qvpgcqYB8p89xuQuj/1Pw4iqFKxpHaFN3UKnT2oG9RQl/z0tJ
         EpckfQ61m5fR93nZ18j1OCwRMLXSlUq0zcdpUKi6/YkdtXiU23bkBjyEQ7NeZMHN2Jc2
         tdlzUvbolI14GKGNZ7ynISQndqrme9sjMEQrTjigykyBm1CSPkA4vGiUMXWKpk9zLTc8
         PC2rI2bjnuGTMOfwIaYaCrYFJXi+SkM7umT9kZyJ/Op81MUe1FuxxSbMVKQKfl8w9Ua7
         QBtIVKypSDDi/sB483Sy6p7msGEuhJutlZtvMxKUwHCc0uxDsPb76dY9plJVRasm7BQv
         FxnA==
X-Gm-Message-State: APjAAAUVrurpe7MMLATOywoqt3C7ZgyISJ+ryvwmcnGgF3LUBpUg94b9
        55rkDTLUejyPnPv/vy3a/DuUrf+0Xds=
X-Google-Smtp-Source: APXvYqxKy7+fcK4Yzm+GpcI5pG+/xJxb+MEUPuX8eJm1ql7cY02TgeRuwtZ5SL0jGbT87Td+IQ5j0Q==
X-Received: by 2002:a37:6c01:: with SMTP id h1mr9586009qkc.484.1574545242508;
        Sat, 23 Nov 2019 13:40:42 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v189sm933208qkc.37.2019.11.23.13.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 13:40:41 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 2/3] init/main.c: remove unnecessary repair_env_string in do_initcall_level
Date:   Sat, 23 Nov 2019 16:40:38 -0500
Message-Id: <20191123214039.139275-3-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191123214039.139275-1-nivedita@alum.mit.edu>
References: <20191123210808.107904-1-nivedita@alum.mit.edu>
 <20191123214039.139275-1-nivedita@alum.mit.edu>
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
 init/main.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/init/main.c b/init/main.c
index c92f0376b1bc..a2008e7a797f 100644
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
@@ -256,11 +255,9 @@ static int __init repair_env_string(char *param, char *val,
 		else if (val == param+strlen(param)+2) {
 			val[-2] = '=';
 			memmove(val-1, val, strlen(val)+1);
-			val--;
 		} else
 			BUG();
 	}
-	return 0;
 }
 
 /* Anything after -- gets handed straight to init. */
@@ -272,7 +269,7 @@ static int __init set_init_arg(char *param, char *val,
 	if (panic_later)
 		return 0;
 
-	repair_env_string(param, val, unused, NULL);
+	repair_env_string(param, val);
 
 	for (i = 0; argv_init[i]; i++) {
 		if (i == MAX_INIT_ARGS) {
@@ -292,7 +289,7 @@ static int __init set_init_arg(char *param, char *val,
 static int __init unknown_bootoption(char *param, char *val,
 				     const char *unused, void *arg)
 {
-	repair_env_string(param, val, unused, NULL);
+	repair_env_string(param, val);
 
 	/* Handle obsolete-style parameters */
 	if (obsolete_checksetup(param))
@@ -990,6 +987,12 @@ static const char *initcall_level_names[] __initdata = {
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
@@ -999,7 +1002,7 @@ static void __init do_initcall_level(int level)
 		   initcall_command_line, __start___param,
 		   __stop___param - __start___param,
 		   level, level,
-		   NULL, &repair_env_string);
+		   NULL, ignore_unknown_bootoption);
 
 	trace_initcall_level(initcall_level_names[level]);
 	for (fn = initcall_levels[level]; fn < initcall_levels[level+1]; fn++)
-- 
2.23.0

