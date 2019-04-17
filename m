Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1573AC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D697A2183F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555544057;
	bh=rfnWL55mamHqM1Vo6SQp4BzNdCAAQTPWuMcoEa45m+A=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=sRAouXRJhoYYEQM12qDmbmpVCc2AthmgBd74jNd3D2WCsGz3MJARUd+wnxcfz244X
	 KtXO/3cNBJsm3uWDOEmSTaZoYqT/k65p3/rBBZPZNAcv5ZH5UOGJ5ts8TEBO6Rehby
	 XtqkpY+UV/UHqzcVMll4TyMNx75Tyl6xQjMx1Mwg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387730AbfDQXeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 19:34:17 -0400
Received: from mail-it1-f173.google.com ([209.85.166.173]:36027 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729099AbfDQXeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 19:34:16 -0400
Received: by mail-it1-f173.google.com with SMTP id y10so582801itc.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 16:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R8SmQcSi/rBWqV5smuVUOWL/SDeQKjTiFEEbbX6rNPo=;
        b=bYDIlc7H3MtBMY0JRSIH45qLoxFjZZ+x+xjXTc9pp1PSGqKO4pJpOW79cfi+fpaJ6y
         Lyz2njPLQSYaKUvPecYXHOPcJ2AZiSn6kj/gKJ8wd94vIIG8vb6WgntgtZzM1+e86rP2
         x5K2iqRoYLQo3cKOENzlEYB6jeWfd5khEu9TM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R8SmQcSi/rBWqV5smuVUOWL/SDeQKjTiFEEbbX6rNPo=;
        b=oc/7BwA9IRP5W6UZHKQicqU6OoBJxj1Z1I7TeRQwwtnYJlvYwZdtdrzUBKED/IrutL
         oOSIgnnRGR/1kux5d4u7zJ36YumXdwM0SmCsRUhCv0yMwox2FoQtQfjIklj89M6QWASr
         WRDNvBJnQMM5aZruK2DHawFuDb9Q98k6MY1lZPrj7xIh9qiNVQ+Ac4tHJTv5TfsULcfa
         aZH23SCRUxXI+jP2wvYGQ8hMOXpbczgsasyTuOU4GX1yhqsVVm0/Xlc3p5ao/9L8IfEH
         V4uv05Y46zQTTilGQq2usLzCde3J4iChmw/GOgs5hCJVC6+ChNuLF/8BWqJgMJpgu7Xf
         XKnQ==
X-Gm-Message-State: APjAAAWb/lf98ZKP9b4KsRoKFJjNMYkZKVP0gqMlxJg/CjX8Y9JeW74Z
        rsoMogVOCmd87d1NdzV971udnQ==
X-Google-Smtp-Source: APXvYqykG/KV4M086pa6e7OCuMQg/kUfoJ+6zuyDojMsNrVEphgyTA2rz896BJ7Qed9PdMQjVTgO+w==
X-Received: by 2002:a24:2808:: with SMTP id h8mr1076090ith.85.1555544055529;
        Wed, 17 Apr 2019 16:34:15 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r191sm254306ita.0.2019.04.17.16.34.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 16:34:14 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, corbet@lwn.net
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] doc: kselftest: Fix KBUILD_OUTPUT usage instructions
Date:   Wed, 17 Apr 2019 17:34:03 -0600
Message-Id: <20190417233403.29854-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix KBUILD_OUTPUT usage instructions. The current documentation is
incorrect. Update and fix outdated information about summary option.
Add a reference to kselftest wiki for additional information on the
framework and tips on writing new tests.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
Changes since v1:
-- Fixed the confusing language about output directory
-- Updated outdated instructions on summary option.
-- Regenerated patch with current email address.

 Documentation/dev-tools/kselftest.rst | 42 ++++++++++++++++++---------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index c8c03388b9de..25604904fa6e 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -7,6 +7,11 @@ directory. These are intended to be small tests to exercise individual code
 paths in the kernel. Tests are intended to be run after building, installing
 and booting a kernel.
 
+You can find additional information on Kselftest framework, how to
+write new tests using the framework on Kselftest wiki:
+
+https://kselftest.wiki.kernel.org/
+
 On some systems, hot-plug tests could hang forever waiting for cpu and
 memory to be ready to be offlined. A special hot-plug target is created
 to run the full range of hot-plug tests. In default mode, hot-plug tests run
@@ -35,17 +40,32 @@ To build and run the tests with a single command, use::
 
 Note that some tests will require root privileges.
 
-Build and run from user specific object directory (make O=dir)::
+Kselftest supports saving output files in a separate directory and then
+running tests. To locate output files in a separate directory two syntaxes
+are supported. In both cases the working directory must be the root of the
+kernel src. This is applicable to "Running a subset of selftests" section
+below.
+
+To build, save output files in a separate directory with O= ::
 
   $ make O=/tmp/kselftest kselftest
 
-Build and run KBUILD_OUTPUT directory (make KBUILD_OUTPUT=)::
+To build, save output files in a separate directory with KBUILD_OUTPUT ::
+
+  $ export KBUILD_OUTPUT=/tmp/kselftest; make kselftest
 
-  $ make KBUILD_OUTPUT=/tmp/kselftest kselftest
+The O= assignment takes precedence over the KBUILD_OUTPUT environment
+variable.
 
-The above commands run the tests and print pass/fail summary to make it
-easier to understand the test results. Please find the detailed individual
-test results for each test in /tmp/testname file(s).
+The above commands by default run the tests and print full pass/fail report.
+Kselftest supports "summary" option to make it easier to understand the test
+results. Please find the detailed individual test results for each test in
+/tmp/testname file(s) when summary option is specified. This is applicable
+to "Running a subset of selftests" section below.
+
+To run kselftest with summary option enabled ::
+
+  $ make summary=1 kselftest
 
 Running a subset of selftests
 =============================
@@ -61,17 +81,13 @@ You can specify multiple tests to build and run::
 
   $  make TARGETS="size timers" kselftest
 
-Build and run from user specific object directory (make O=dir)::
+To build, save output files in a separate directory with O= ::
 
   $ make O=/tmp/kselftest TARGETS="size timers" kselftest
 
-Build and run KBUILD_OUTPUT directory (make KBUILD_OUTPUT=)::
-
-  $ make KBUILD_OUTPUT=/tmp/kselftest TARGETS="size timers" kselftest
+To build, save output files in a separate directory with KBUILD_OUTPUT ::
 
-The above commands run the tests and print pass/fail summary to make it
-easier to understand the test results. Please find the detailed individual
-test results for each test in /tmp/testname file(s).
+  $ export KBUILD_OUTPUT=/tmp/kselftest; make TARGETS="size timers" kselftest
 
 See the top-level tools/testing/selftests/Makefile for the list of all
 possible targets.
-- 
2.17.1

