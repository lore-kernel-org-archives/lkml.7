Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EADEC5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 06:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C5D20881
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 06:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfGBGYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 02:24:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43362 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfGBGYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 02:24:11 -0400
Received: from mail-pg1-f197.google.com ([209.85.215.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1hiCD2-0001z5-GD
        for linux-kernel@vger.kernel.org; Tue, 02 Jul 2019 06:24:08 +0000
Received: by mail-pg1-f197.google.com with SMTP id m4so3519936pgs.17
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 23:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yDzSSlzz68xbYUEa8P0cxC2ju66W5gHLv670zzKjJew=;
        b=nqnu0oT62excbLHVocWhHtjzi5un5sVxPCkzuesFBpnIBG54/B1N37uBnc6BuRV3Mv
         rsXwzLr91cOr/fue86Crn+dirm5jM4eQXBYzxbaYjcvwT3z9ZJM+1WVMwhQhKa33POWU
         9kERpLwS3Z/CFHUGvTr+Jii3YyS330p6yYXv/xHmqBHivjulK3KdVRxI/k9rxksqFfA2
         aIjr6Gyke7/1FkUCmsKCpBrTjhnMTXlkTsZ/+sHMUS5Ma/KLGxddnXZeJeuaT7pNF9Sn
         wAtyax1RkXBUtcgsZdxJRW7vRd8PF4JDy8uaxNePdIn+CqIDLbHYyqTDURafN0+YKkAh
         6OxA==
X-Gm-Message-State: APjAAAWQH/+kN8sqOInQCSeZ15BR8u0Fm6dJ1+dyG/CI6SeDbWcAe/sI
        XrQeSb+NdKZ6PRWpzAwTTxCxsCacdr8G2f5qNi27f8n9mwPBTBQuc9JxilaL/oSOZ7xfdy4LeEt
        CV0PEnGz/CoL2BOG71dzhN8DKdpkEGq5ETGsxOm3Q
X-Received: by 2002:a63:6fc9:: with SMTP id k192mr15683736pgc.20.1562048647067;
        Mon, 01 Jul 2019 23:24:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwUpzq2O1mJvjQuO/WoeUFhiR35393YmkG+4pab7PCu9wdkXJehbwSHHo5dvrDOFonRuGu1Ew==
X-Received: by 2002:a63:6fc9:: with SMTP id k192mr15683711pgc.20.1562048646698;
        Mon, 01 Jul 2019 23:24:06 -0700 (PDT)
Received: from Leggiero.taipei.internal (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id l68sm2569488pjb.8.2019.07.01.23.24.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 23:24:06 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     rostedt@goodmis.org, mingo@redhat.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/ftrace: skip ftrace test if FTRACE was not enabled
Date:   Tue,  2 Jul 2019 14:23:58 +0800
Message-Id: <20190702062358.7330-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ftrace test will need to have CONFIG_FTRACE enabled to make the
ftrace directory available.

Add an additional check to skip this test if the CONFIG_FTRACE was not
enabled.

This will be helpful to avoid a false-positive test result when testing
it directly with the following commad against a kernel that does not
have CONFIG_FTRACE enabled:
    make -C tools/testing/selftests TARGETS=ftrace run_tests

The test result on an Ubuntu KVM kernel will be changed from:
    selftests: ftrace: ftracetest
    ========================================
    Error: No ftrace directory found
    not ok 1..1 selftests: ftrace: ftracetest [FAIL]
To:
    selftests: ftrace: ftracetest
    ========================================
    CONFIG_FTRACE was not enabled, test skipped.
    not ok 1..1 selftests: ftrace: ftracetest [SKIP]

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/ftrace/ftracetest | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index 6d5e9e8..6c8322e 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -7,6 +7,9 @@
 #  Written by Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
 #
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 usage() { # errno [message]
 [ ! -z "$2" ] && echo $2
 echo "Usage: ftracetest [options] [testcase(s)] [testcase-directory(s)]"
@@ -139,7 +142,13 @@ parse_opts $*
 
 # Verify parameters
 if [ -z "$TRACING_DIR" -o ! -d "$TRACING_DIR" ]; then
-  errexit "No ftrace directory found"
+  ftrace_enabled=`grep "^CONFIG_FTRACE=y" /lib/modules/$(uname -r)/build/.config`
+  if [ -z "$ftrace_enabled" ]; then
+    echo "CONFIG_FTRACE was not enabled, test skipped."
+    exit $ksft_skip
+  else
+    errexit "No ftrace directory found"
+  fi
 fi
 
 # Preparing logs
-- 
2.7.4

