Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6A6C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B7421556
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbfLLSAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 13:00:33 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43079 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730310AbfLLSA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:00:28 -0500
Received: by mail-qk1-f194.google.com with SMTP id t129so2329485qke.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 10:00:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=atIQIs7dUB80addC2OXNtRGB9vn8GNEImvyJYL7Xn7U=;
        b=oJjNvcjmMFzhW6eH8FRzAxpSimDJAgQMMY7zgPtn1H1Gmm6amAz9E8rwZfdLf2Q3MH
         tZGHj2KgYfzy298SvlFNEvzRWxSTawsJX5ZEaeLf0Ya+ggxbYgNGciPBagDk82JmT7wp
         KAQ9bs5Pmx3KQg8WFQ01mKxwcAnoKd0cRnQ5L+Q+R7rYSA9NN/h50mIOyAhYYtc1LWZM
         jgmRpdbCv9gs3oRAXsCrgVlC4OCKcZiguHgT/Nz863oiFEw03L1kE79bxQ/pPpiSbrz8
         L01fcD43tFDBflES6a5Mo5JFws0GN98YMa0rjy8P2bxAZRobM0NeKnhk6NDe1yrhY/z/
         H55g==
X-Gm-Message-State: APjAAAWKEcCInuST1YouLmPT9nvqyrREJvn+r93YdDdXQ6LocWFhPycZ
        E9kTfivHwokSthoFt0jrLbJNWpWc
X-Google-Smtp-Source: APXvYqyFT78emF53MgbrNnufj+AE3rNRwybW+wDb/imr/DXsfmjqYwlzSidOHHc78y154qCVmVB0jQ==
X-Received: by 2002:a05:620a:15af:: with SMTP id f15mr9385035qkk.225.1576173627338;
        Thu, 12 Dec 2019 10:00:27 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id j7sm1946037qkd.46.2019.12.12.10.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 10:00:26 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] init/main.c: fix quoted value handling in unknown_bootoption
Date:   Thu, 12 Dec 2019 13:00:23 -0500
Message-Id: <20191212180023.24339-4-nivedita@alum.mit.edu>
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
 init/main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/init/main.c b/init/main.c
index a1febc3de582..efece9fe988e 100644
--- a/init/main.c
+++ b/init/main.c
@@ -255,7 +255,6 @@ static void __init repair_env_string(char *param, char *val)
 		else if (val == param+strlen(param)+2) {
 			val[-2] = '=';
 			memmove(val-1, val, strlen(val)+1);
-			val--;
 		} else
 			BUG();
 	}
@@ -290,6 +289,8 @@ static int __init set_init_arg(char *param, char *val,
 static int __init unknown_bootoption(char *param, char *val,
 				     const char *unused, void *arg)
 {
+	size_t len = strlen(param);
+
 	repair_env_string(param, val);
 
 	/* Handle obsolete-style parameters */
@@ -297,7 +298,7 @@ static int __init unknown_bootoption(char *param, char *val,
 		return 0;
 
 	/* Unused module parameter. */
-	if (strchr(param, '.') && (!val || strchr(param, '.') < val))
+	if (strnchr(param, len, '.'))
 		return 0;
 
 	if (panic_later)
@@ -311,7 +312,7 @@ static int __init unknown_bootoption(char *param, char *val,
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

