Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00665C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 12:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41352075D
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 12:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hf25TWWS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbfI3Mtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 08:49:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36861 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbfI3Mtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 08:49:31 -0400
Received: by mail-pf1-f196.google.com with SMTP id y22so5569689pfr.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 05:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xP8KqcbssPu7x+4Rrj4+JuoXYTZ+7+3z0iC4pOtKBNM=;
        b=hf25TWWS+jQlHG4+MqTuA6SsveImD6DgCTp+W0K/5qXpHGou/SArlj6ZU51VmPUMXI
         ndO9xL+gGduC6zNqg4mxBJSgoHHG8smZhqcawqt0kiS2VY/mh0utdNkvEEhGh6SLjetP
         Vz8BqEnjYOa0kZoV+v6Jt5IWPSbZ1CJtupIalY6RzQQqtmQBWkgAnjnv+HdVP6wnULkG
         cRy+b4bzS1hWjzrNVDRR6HUoXcoxwxu/tabd0aX8Ur1XVb1kDcajuUAQePuIgwEEw1MN
         A7+LKuYxWqlhPjq41BinJTBHWN9GWlE6yq0HPPdZZ6GN8k96a4OsmgWlvAUPSylT+CHp
         1BXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xP8KqcbssPu7x+4Rrj4+JuoXYTZ+7+3z0iC4pOtKBNM=;
        b=XwHK6G05vhSI6JWA/DrPrWfAcNly+G2kTWfw+qr58h3dCmMiAao/erqNaRaq1zfM5B
         ZWJJC3/tZyZUZiUFeQ2xhYQ0elrs816Caigj1gqHLV4OComHu65m9P+yl1NcV2atObOJ
         OoLegsaPz+0AivHiTOMcVPirZwWvSMT8YSyEJESBCo/Cr+M4LNUqWo3mVCr2DzXErwLJ
         zjnBerk+Y82Dm16MU/dqe2pIxt17uYmPky/2O3d6wmNR9aKcFLllP8HMxMkXEkly1A1Y
         2ftiO4a+jGK6RMyNr1t4E9n0M/oniw4YnIR5T/OP17EKW7DpkvtoepUKBymMzW8KP0U0
         kQRg==
X-Gm-Message-State: APjAAAXI2tGfBYCeUX1+odEPVaV3zSUKFyGh/u8fNK6VPaQxuMFoiyNQ
        UVxDETAS1A2fIsO1Ck6gmhM=
X-Google-Smtp-Source: APXvYqzfrGfwoyf3ej5K4Rs5EFjYkcJFiSG5H5fKnkHpbHZzgUsvDECUYQDFJwl4qLPWQHql1uzRcw==
X-Received: by 2002:a65:5544:: with SMTP id t4mr24711650pgr.119.1569847770610;
        Mon, 30 Sep 2019 05:49:30 -0700 (PDT)
Received: from masabert ([210.161.134.36])
        by smtp.gmail.com with ESMTPSA id i1sm14151024pfg.2.2019.09.30.05.49.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 05:49:29 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id 8940720119E; Mon, 30 Sep 2019 21:49:27 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     rostedt@goodmis.org, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] ktest: Fix some typos in sample.conf
Date:   Mon, 30 Sep 2019 21:49:25 +0900
Message-Id: <20190930124925.20250-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.23.0.256.g4c86140027f4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes some spelling typo in sample.conf

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 tools/testing/ktest/sample.conf | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/ktest/sample.conf b/tools/testing/ktest/sample.conf
index c3bc933d437b..10af34819642 100644
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
@@ -972,7 +972,7 @@
 #
 #  PATCHCHECK_START is required and is the first patch to
 #   test (the SHA1 of the commit). You may also specify anything
-#   that git checkout allows (branch name, tage, HEAD~3).
+#   that git checkout allows (branch name, tag, HEAD~3).
 #
 #  PATCHCHECK_END is the last patch to check (default HEAD)
 #
@@ -994,7 +994,7 @@
 #     IGNORE_WARNINGS is set for the given commit's sha1
 #
 #   IGNORE_WARNINGS can be used to disable the failure of patchcheck
-#     on a particuler commit (SHA1). You can add more than one commit
+#     on a particular commit (SHA1). You can add more than one commit
 #     by adding a list of SHA1s that are space delimited.
 #
 #   If BUILD_NOCLEAN is set, then make mrproper will not be run on
@@ -1093,7 +1093,7 @@
 #   whatever reason. (Can't reboot, want to inspect each iteration)
 #   Doing a BISECT_MANUAL will have the test wait for you to
 #   tell it if the test passed or failed after each iteration.
-#   This is basicall the same as running git bisect yourself
+#   This is basically the same as running git bisect yourself
 #   but ktest will rebuild and install the kernel for you.
 #
 # BISECT_CHECK = 1 (optional, default 0)
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
2.23.0.256.g4c86140027f4

