Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6506C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3FA20CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577469408;
	bh=kcmHPfgfUkUIZ9s19Gak9QvxgsL0fT1Ndp20b1yWJ/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y9sH/I9NFMVHWWhTXeTAce6ZH/eV8h9L9eyB1jjDpWOYY2+7ELCV2lZwWX/xhNEK7
	 xzS8Ix75yoQhkgK+tIWf5M0ZkEVrFLqRIhocAL2f/X0oJ8X6nLsdtqa6PVP2HKd2BQ
	 Li62h/2dH3ZOBQFADg5gqFoeNXS/aGRZP0oqJPac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfL0Rl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:41:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:38354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727494AbfL0Rlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:41:52 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B47A222C4;
        Fri, 27 Dec 2019 17:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468511;
        bh=kcmHPfgfUkUIZ9s19Gak9QvxgsL0fT1Ndp20b1yWJ/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K+OyNAE83Z5Zk2AdOh0dNi61Ffc07Oyj7v4A4/Qe/ddxxPgQMds8KjOBafppi/T6g
         L6j1GDYOoX48UqPe/HJSJEg+CoEm/zwce6nJoVJe1aPkBmkD9yAo4i3eG58/njj6if
         i+iVRo2nquHfl0cYVPBcLIwor3EK1o5mPmcn1NfU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 044/187] selftests: safesetid: Move link library to LDLIBS
Date:   Fri, 27 Dec 2019 12:38:32 -0500
Message-Id: <20191227174055.4923-44-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174055.4923-1-sashal@kernel.org>
References: <20191227174055.4923-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit be12252212fa3dfed6e75112865095c484c0ce87 ]

Move -lcap to LDLIBS from CFLAGS because it is a library
to be linked.

Without this, safesetid failed to build with link error
as below.

----
/usr/bin/ld: /tmp/ccL8rZHT.o: in function `drop_caps':
safesetid-test.c:(.text+0xe7): undefined reference to `cap_get_proc'
/usr/bin/ld: safesetid-test.c:(.text+0x107): undefined reference to `cap_set_flag'
/usr/bin/ld: safesetid-test.c:(.text+0x10f): undefined reference to `cap_set_proc'
/usr/bin/ld: safesetid-test.c:(.text+0x117): undefined reference to `cap_free'
/usr/bin/ld: safesetid-test.c:(.text+0x136): undefined reference to `cap_clear'
collect2: error: ld returned 1 exit status
----

Fixes: c67e8ec03f3f ("LSM: SafeSetID: add selftest")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/safesetid/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/safesetid/Makefile b/tools/testing/selftests/safesetid/Makefile
index 98da7a504737..cac42cd36a1b 100644
--- a/tools/testing/selftests/safesetid/Makefile
+++ b/tools/testing/selftests/safesetid/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for mount selftests.
-CFLAGS = -Wall -lcap -O2
+CFLAGS = -Wall -O2
+LDLIBS = -lcap
 
 TEST_PROGS := run_tests.sh
 TEST_GEN_FILES := safesetid-test
-- 
2.20.1

