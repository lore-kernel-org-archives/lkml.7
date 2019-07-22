Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7BEC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B76521955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTyO37bc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733063AbfGVWRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 18:17:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34561 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733057AbfGVWRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 18:17:40 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so12100775pgc.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 15:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xGxNUbmf6wURXwMOUzHevWg+OmVBPXK2utvAZZQtCsE=;
        b=BTyO37bcI7h+0oeavfaSzBEWhwqBPyESTzvhj1VipVMhNMgOvzMnDId60XTUOpxzhQ
         34ugE6+iAtBx8a2ITfVrcP8cpwn4rLXs6fn+qQvLGNIDXFSG21JUxBrn0oBUK6oMxivf
         GfLBkSiL8Iubagx5o0X+YvBIXEAxRoIp1fDzepAnFalQ7y5LxVeeJNJXDr9Q/GMJBkvc
         VADM67GXWMH22nb+Jb8BCrI98uxyGHUF9htwvZcyplPejK/YFmA5n9dWEj5gAPtCCJyf
         NuLE4HV5G5FCJpSSwzXQX6yvvKyyYzf7D6J8JR1WktAKsHlFGHqYaSFQosVVah9nr0cR
         TjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xGxNUbmf6wURXwMOUzHevWg+OmVBPXK2utvAZZQtCsE=;
        b=SJ9ypIKxm0fzRP3J+ysPqDQD8up8tAfLKGSnGB1Wv4kroouJ4syoL8jEeMI62pJf4m
         rPYJ7RLGzP5T4HLZ6wMkvk3aYiAT8yr9JDC6sRINrBKj+8Sooj/EN60K1oFdX/pDgHpk
         2IUIJnIQE/8aReAM1asjD1sQQT8+tggzqUaTPTZqE+xKdRlWh+VcdiJFEQ9lnuPaPKds
         Qr62IitDFifJlDAWC+LQ9ODLfTtEaADzUFbHz52Bwceqz26u2M0m5JAJIamIyfAFt0dd
         XURxCB/zD/+p246Fod8jFDPTRbd0mI7X9C/5IevosjrfimpVmYbz5uXHawvIPus9FWhc
         CQRg==
X-Gm-Message-State: APjAAAUiXqYKc5LG36i3/tt+val6QSaqM7z6cxW2obkY4yf2K8z0rkb9
        RVW+9BRB7D+ZE400plxeMdY=
X-Google-Smtp-Source: APXvYqxq2bcG9xd19LcAylk2YjaR2Y9jwLuXdEN/nw7sGw4bg6PUFmH2n6JdB/i+l4UBQ4yh4pTNOw==
X-Received: by 2002:a17:90a:7d04:: with SMTP id g4mr79723782pjl.41.1563833859785;
        Mon, 22 Jul 2019 15:17:39 -0700 (PDT)
Received: from masabert (i118-21-156-233.s30.a048.ap.plala.or.jp. [118.21.156.233])
        by smtp.gmail.com with ESMTPSA id b19sm37656971pgh.57.2019.07.22.15.17.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 15:17:39 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id 236E8201372; Tue, 23 Jul 2019 07:17:37 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: Resend: [PATCH] ktest: Fix typos in sample.conf
Date:   Tue, 23 Jul 2019 07:17:34 +0900
Message-Id: <20190722221734.28122-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.22.0.454.g9d418600f4d1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes some spelling typos in sample.conf.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 tools/testing/ktest/sample.conf | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/ktest/sample.conf b/tools/testing/ktest/sample.conf
index c3bc933d437b..f31d6dcf2f99 100644
--- a/tools/testing/ktest/sample.conf
+++ b/tools/testing/ktest/sample.conf
@@ -10,7 +10,7 @@
 #
 
 # Options set in the beginning of the file are considered to be
-# default options. These options can be overriden by test specific
+# default options. These options can be overridden by test specific
 # options, with the following exceptions:
 #
 #  LOG_FILE
@@ -204,7 +204,7 @@
 #
 # This config file can also contain "config variables".
 # These are assigned with ":=" instead of the ktest option
-# assigment "=".
+# assignment "=".
 #
 # The difference between ktest options and config variables
 # is that config variables can be used multiple times,
@@ -263,7 +263,7 @@
 #### Using options in other options ####
 #
 # Options that are defined in the config file may also be used
-# by other options. All options are evaulated at time of
+# by other options. All options are evaluated at time of
 # use (except that config variables are evaluated at config
 # processing time).
 #
@@ -707,7 +707,7 @@
 
 # Line to define a successful boot up in console output.
 # This is what the line contains, not the entire line. If you need
-# the entire line to match, then use regural expression syntax like:
+# the entire line to match, then use regular expression syntax like:
 #  (do not add any quotes around it)
 #
 #  SUCCESS_LINE = ^MyBox Login:$
@@ -839,7 +839,7 @@
 # (ignored if POWEROFF_ON_SUCCESS is set)
 #REBOOT_ON_SUCCESS = 1
 
-# In case there are isses with rebooting, you can specify this
+# In case there are issues with rebooting, you can specify this
 # to always powercycle after this amount of time after calling
 # reboot.
 # Note, POWERCYCLE_AFTER_REBOOT = 0 does NOT disable it. It just
@@ -848,7 +848,7 @@
 # (default undefined)
 #POWERCYCLE_AFTER_REBOOT = 5
 
-# In case there's isses with halting, you can specify this
+# In case there's issues with halting, you can specify this
 # to always poweroff after this amount of time after calling
 # halt.
 # Note, POWEROFF_AFTER_HALT = 0 does NOT disable it. It just
@@ -1093,7 +1093,7 @@
 #   whatever reason. (Can't reboot, want to inspect each iteration)
 #   Doing a BISECT_MANUAL will have the test wait for you to
 #   tell it if the test passed or failed after each iteration.
-#   This is basicall the same as running git bisect yourself
+#   This is basically the same as running git bisect yourself
 #   but ktest will rebuild and install the kernel for you.
 #
 # BISECT_CHECK = 1 (optional, default 0)
@@ -1124,13 +1124,13 @@
 #
 # BISECT_RET_GOOD = 0 (optional, default undefined)
 #
-#   In case the specificed test returns something other than just
+#   In case the specified test returns something other than just
 #   0 for good, and non-zero for bad, you can override 0 being
 #   good by defining BISECT_RET_GOOD.
 #
 # BISECT_RET_BAD = 1 (optional, default undefined)
 #
-#   In case the specificed test returns something other than just
+#   In case the specified test returns something other than just
 #   0 for good, and non-zero for bad, you can override non-zero being
 #   bad by defining BISECT_RET_BAD.
 #
@@ -1239,7 +1239,7 @@
 #
 # CONFIG_BISECT_EXEC (optional)
 #  The config bisect is a separate program that comes with ktest.pl.
-#  By befault, it will look for:
+#  By default, it will look for:
 #    `pwd`/config-bisect.pl # the location ktest.pl was executed from.
 #  If it does not find it there, it will look for:
 #    `dirname <ktest.pl>`/config-bisect.pl # The directory that holds ktest.pl
-- 
2.22.0.454.g9d418600f4d1

