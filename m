Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF01C43141
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 21:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B881206D4
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 21:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfKWVkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 16:40:46 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36413 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfKWVkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 16:40:46 -0500
Received: by mail-qk1-f196.google.com with SMTP id d13so9472040qko.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 13:40:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rYFSQLQUePhEzpBCVJ4C9SU6P0f+WttzJ5CloUXrqVU=;
        b=XLHIuHjnWkQQNopbp97l2GmpYDfz23g/qyuuFpd81ELOwGJ4zeH+PtW1uwveUSre0t
         AwfDfWZa/x0BCJ6jDg7GICxqb9cbWmnxBHuOdmRlKzjetpNzVLAROz90o4qmUwuN+RaD
         +8PfEGHgDRfJk+L91Pv2FhxOtoGkCMBNgik0O0qexdwJfhnflxN76a0tOb6A3Rqfv+vd
         KGqeYljktCt4L9pd2+SfvqepwPndhZ9D3pJeOkjfzonFsMJcWRZA8KiP0w1kAtdyk2iW
         F99dqSoUNF931Na7kUKwMIT2MjYGM3Uv6Br61+bGtCBTI9I39SS44zM09OelmqaFU9Hm
         Vmdg==
X-Gm-Message-State: APjAAAVF2B9pVM1fcuGZ2kmf2mtKtcbt2B4nuIfHK3IG+odEMCgU+WBT
        JjRUxLpScb6Zk9abgCxpEsOxA07lrBk=
X-Google-Smtp-Source: APXvYqwN084UPRVlYkOJlpg9xsv2NQWKVCuK0qAqjbdQWOeVh2rTlXpbsqCw5X1zcUDlSKOSixEGrA==
X-Received: by 2002:a05:620a:149b:: with SMTP id w27mr4084950qkj.387.1574545243445;
        Sat, 23 Nov 2019 13:40:43 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v189sm933208qkc.37.2019.11.23.13.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 13:40:42 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 3/3] init/main.c: fix quoted value handling in unknown_bootoption
Date:   Sat, 23 Nov 2019 16:40:39 -0500
Message-Id: <20191123214039.139275-4-nivedita@alum.mit.edu>
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

Commit a99cd1125189 ("init: fix bug where environment vars can't be
passed via boot args") introduced two minor bugs in unknown_bootoption
by factoring out the quoted value handling into a separate function.

When value is quoted, repair_env_string will move the value up 1 byte to
strip the quotes, so val in unknown_bootoption no longer points to the
actual location of the value.

The result is that an argument of the form param=".value" is mistakenly
treated as a potential module parameter and is not placed in init's
environment, and an argument of the form param="value" can result in a
duplicate environment variable: eg TERM="vt100" on the command line will
result in both TERM=linux and TERM=vt100 being placed into init's
environment.

Fix this by recording the length of the param before calling
repair_env_string instead of relying on val.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 init/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/init/main.c b/init/main.c
index a2008e7a797f..1ee92517c515 100644
--- a/init/main.c
+++ b/init/main.c
@@ -289,6 +289,8 @@ static int __init set_init_arg(char *param, char *val,
 static int __init unknown_bootoption(char *param, char *val,
 				     const char *unused, void *arg)
 {
+	size_t len = strlen(param);
+
 	repair_env_string(param, val);
 
 	/* Handle obsolete-style parameters */
@@ -296,7 +298,7 @@ static int __init unknown_bootoption(char *param, char *val,
 		return 0;
 
 	/* Unused module parameter. */
-	if (strchr(param, '.') && (!val || strchr(param, '.') < val))
+	if (strnchr(param, len, '.'))
 		return 0;
 
 	if (panic_later)
@@ -310,7 +312,7 @@ static int __init unknown_bootoption(char *param, char *val,
 				panic_later = "env";
 				panic_param = param;
 			}
-			if (!strncmp(param, envp_init[i], val - param))
+			if (!strncmp(param, envp_init[i], len+1))
 				break;
 		}
 		envp_init[i] = param;
-- 
2.23.0

