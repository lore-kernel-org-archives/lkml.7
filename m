Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3ACC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC3EB20836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576080427;
	bh=JTsTVhsy3zqt1vTyRg8yc3o1dJloENyZSI0v+uOIwYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EducKMpT5l5WF4QB8TV1TWojE9odGZbk2/rGyu1fb0pWxygpqhJ+zWAABMn7+z7Lr
	 DeF0Qoz9KqMPJyWdNpe5k7EjGmq0DajfOxpPam7qr1/wBQU2HbuMUP2PmZi6JwtcyJ
	 WnbcItAvBp9V3qi+AiTe3nrND8Futw7dabwYvcbs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388779AbfLKQHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:07:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:34332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731158AbfLKPMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:12:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D301222C4;
        Wed, 11 Dec 2019 15:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077151;
        bh=JTsTVhsy3zqt1vTyRg8yc3o1dJloENyZSI0v+uOIwYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YC9de2q1X4n4uZtwfb+egEwTr7gSXTfrP0FvriM7TaAYdCtORBAuQIdP0aTfhpwXF
         RYMQl+/fbcXsQZhtpZvxPk0kazMOAx6CMzwSer1y6WdjdLGClDBDtGG23XapfgBCnr
         PiJhkLz6LOfDEjntb9/E/y0ACm8CShNmrhUOfeTY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linux-api@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 038/134] selftests/powerpc: Skip tm-signal-sigreturn-nt if TM not available
Date:   Wed, 11 Dec 2019 10:10:14 -0500
Message-Id: <20191211151150.19073-38-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211151150.19073-1-sashal@kernel.org>
References: <20191211151150.19073-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 505127068d9b705a6cf335143239db91bfe7bbe2 ]

On systems where TM (Transactional Memory) is disabled the
tm-signal-sigreturn-nt test causes a SIGILL:

  test: tm_signal_sigreturn_nt
  tags: git_version:7c202575ef63
  !! child died by signal 4
  failure: tm_signal_sigreturn_nt

We should skip the test if TM is not available.

Fixes: 34642d70ac7e ("selftests/powerpc: Add checks for transactional sigreturn")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20191104233524.24348-1-mpe@ellerman.id.au
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/powerpc/tm/tm-signal-sigreturn-nt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-sigreturn-nt.c b/tools/testing/selftests/powerpc/tm/tm-signal-sigreturn-nt.c
index 56fbf9f6bbf30..07c388147b75e 100644
--- a/tools/testing/selftests/powerpc/tm/tm-signal-sigreturn-nt.c
+++ b/tools/testing/selftests/powerpc/tm/tm-signal-sigreturn-nt.c
@@ -10,10 +10,12 @@
  */
 
 #define _GNU_SOURCE
+#include <stdio.h>
 #include <stdlib.h>
 #include <signal.h>
 
 #include "utils.h"
+#include "tm.h"
 
 void trap_signal_handler(int signo, siginfo_t *si, void *uc)
 {
@@ -29,6 +31,8 @@ int tm_signal_sigreturn_nt(void)
 {
 	struct sigaction trap_sa;
 
+	SKIP_IF(!have_htm());
+
 	trap_sa.sa_flags = SA_SIGINFO;
 	trap_sa.sa_sigaction = trap_signal_handler;
 
-- 
2.20.1

