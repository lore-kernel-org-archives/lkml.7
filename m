Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DC6C2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 12:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4608D24648
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 12:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575548481;
	bh=nQdhrd7aELhldb/xa20PECJL2oSRA7hAdzZouMGzijw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pM8Lj6Ezb7fxH1zfgQd0D8LkVyptzacWW6CCRu8idASuK72y42qZXNLqpiANJUWGZ
	 2f2eaSDx5mht2Pitl6dCtnmQ76l3qNnB/kZY+MltTcoBpJiZkKHc2P2TgY9omGoMK6
	 2bKI7OdV+e3Zh9PlMsaSL6hSnAMPYUMQnr/DyIfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbfLEMVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 07:21:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:37732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729096AbfLEMVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 07:21:20 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FD2024648;
        Thu,  5 Dec 2019 12:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575548479;
        bh=nQdhrd7aELhldb/xa20PECJL2oSRA7hAdzZouMGzijw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zp/6DQPD5+nmSamf0+WXxxGdYksR3KTlW0NPjzgvNaiaBFZYEhflzIbAkYH0FfjJ0
         s62LqD1Ap59hDC8WJjjWzI9YsIy9JgwWiCsQ+CjelffHtj3DI24ku1x2KWNNP+ql+W
         SUKYP2wgCDBSVEhnc3bIbHfobwCw0WT+G+3CJp8I=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Micah Morton <mortonm@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        jaswinder.singh@linaro.org
Subject: [BUGFIX PATCH v2 3/3] selftests: safesetid: Fix Makefile to set correct test program
Date:   Thu,  5 Dec 2019 21:21:16 +0900
Message-Id: <157554847591.11018.5631502480695471273.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157554844882.11018.13436399905210284553.stgit@devnote2>
References: <157554844882.11018.13436399905210284553.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix Makefile to set safesetid-test.sh to TEST_PROGS instead
of non existing run_tests.sh.

Without this fix, I got following error.
  ----
  TAP version 13
  1..1
  # selftests: safesetid: run_tests.sh
  # Warning: file run_tests.sh is missing!
  not ok 1 selftests: safesetid: run_tests.sh
  ----

Fixes: c67e8ec03f3f ("LSM: SafeSetID: add selftest")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/testing/selftests/safesetid/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/safesetid/Makefile b/tools/testing/selftests/safesetid/Makefile
index cac42cd36a1b..fa02c4d5ec13 100644
--- a/tools/testing/selftests/safesetid/Makefile
+++ b/tools/testing/selftests/safesetid/Makefile
@@ -3,7 +3,7 @@
 CFLAGS = -Wall -O2
 LDLIBS = -lcap
 
-TEST_PROGS := run_tests.sh
+TEST_PROGS := safesetid-test.sh
 TEST_GEN_FILES := safesetid-test
 
 include ../lib.mk

