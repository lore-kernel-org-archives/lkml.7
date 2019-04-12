Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740A0C10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2D521850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555031908;
	bh=PNUh/sVn0+vhKZAHXNYBRQiF2ESh8r459MjcPO4gsKs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=bRKKaAW3HkHTwdwnF8pYwxFy/Uyk8bzoGd6qZZjch7EYBpE/0LT6VoMI6U0h7f0qD
	 TpECIZXG57M8ZE/e1RGmaaE4ElFZIHsi/4c+s1YSZ0dx9JKQboDyyq3e+bfZLEUFNc
	 YDf/YWxF3onlwQWTWL1lPJfLng2sLXdWd5ndgdDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfDLBS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 21:18:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbfDLBS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 21:18:26 -0400
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61F8520869;
        Fri, 12 Apr 2019 01:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555031905;
        bh=PNUh/sVn0+vhKZAHXNYBRQiF2ESh8r459MjcPO4gsKs=;
        h=From:To:Cc:Subject:Date:From;
        b=Zz+P4T5dK5YQ/ReUDLVM7Cb7492i4bnf2BXkeO1bC4hvjtRRaqc6ewwRS7xGejMeW
         cR0FvuHsD6fpcbvSojRKnoly/FS1z9pisjeYAiW8DfSme7OU6BjYNMPt1f3TiomqRB
         pKzEolLQ6S86emxzbjeoo/ce96jXIjKtR00uy0s0=
From:   Shuah Khan <shuah@kernel.org>
To:     jpoimboe@redhat.com, jikos@kernel.org, mbenes@suse.cz,
        pmladek@suse.com, joe.lawrence@redhat.com, shuah@kernel.org
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: livepatch use TEST_PROGS for test shell scripts
Date:   Thu, 11 Apr 2019 19:18:23 -0600
Message-Id: <20190412011823.26884-1-shuah@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TEST_PROGS variable is for test shell scripts and common clean target
in lib.mk doesn't touch them. TEST_GEN_PROGS are removed by it.

Fix it to use TEST_PROGS for test shell scripts and TEST_PROGS_EXTENDED
for common functions.sh.

Signed-off-by: Shuah Khan <shuah@kernel.org>
---
 tools/testing/selftests/livepatch/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/selftests/livepatch/Makefile
index af4aee79bebb..fd405402c3ff 100644
--- a/tools/testing/selftests/livepatch/Makefile
+++ b/tools/testing/selftests/livepatch/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
-TEST_GEN_PROGS := \
+TEST_PROGS_EXTENDED := functions.sh
+TEST_PROGS := \
 	test-livepatch.sh \
 	test-callbacks.sh \
 	test-shadow-vars.sh
-- 
2.17.1

