Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F82C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32A1217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710506;
	bh=6709uOp69RMOUkuyrJ3Y7ObzWXNAD4dFwy6QQibu5kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZwRbWJSWH0e1mw1gd7qVZa7qg+vZi/+S7V+V8AoR/+ceo2sQYG4xENtASElxIXGzr
	 LwZzGJpVAzVwm4V5gpiYX7oOtEWVmzTS/lsh5LfFdtU6yAJGzOcHIiWe7QVHuKqiWS
	 H9YrO9nFc1Jh3PVHzRrrE7PSEt3NAq92HcP1Hvlc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389104AbfC0SPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:15:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:58412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389735AbfC0SPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:15:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22B392087C;
        Wed, 27 Mar 2019 18:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710501;
        bh=6709uOp69RMOUkuyrJ3Y7ObzWXNAD4dFwy6QQibu5kc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v7y29M3xga+XrnRi7F72MG9UsIAfgGLFJgQOqKvrz36oWiqYZaLheg7anJmR28lIt
         URc0ETbNIRqMUbuv5BpcmxVNGvfmYNyXH3fbi1OxtobFmz67HdYnT2znZIi1xacdEk
         V40laqeNdw5J34NRG5iRBKGCgSi3D3+tfVOybrx8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 147/192] selftests/bpf: skip verifier tests for unsupported program types
Date:   Wed, 27 Mar 2019 14:09:39 -0400
Message-Id: <20190327181025.13507-147-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stanislav Fomichev <sdf@google.com>

[ Upstream commit 8184d44c9a577a2f1842ed6cc844bfd4a9981d8e ]

Use recently introduced bpf_probe_prog_type() to skip tests in the
test_verifier() if bpf_verify_program() fails. The skipped test is
indicated in the output.

Example:

...
679/p bpf_get_stack return R0 within range SKIP (unsupported program
type 5)
680/p ld_abs: invalid op 1 OK
...
Summary: 863 PASSED, 165 SKIPPED, 3 FAILED

Signed-off-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/test_verifier.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 9db5a7378f40..294fc18aba2a 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -32,6 +32,7 @@
 #include <linux/if_ether.h>
 
 #include <bpf/bpf.h>
+#include <bpf/libbpf.h>
 
 #ifdef HAVE_GENHDR
 # include "autoconf.h"
@@ -56,6 +57,7 @@
 
 #define UNPRIV_SYSCTL "kernel/unprivileged_bpf_disabled"
 static bool unpriv_disabled = false;
+static int skips;
 
 struct bpf_test {
 	const char *descr;
@@ -12770,6 +12772,11 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 	fd_prog = bpf_verify_program(prog_type ? : BPF_PROG_TYPE_SOCKET_FILTER,
 				     prog, prog_len, test->flags & F_LOAD_WITH_STRICT_ALIGNMENT,
 				     "GPL", 0, bpf_vlog, sizeof(bpf_vlog), 1);
+	if (fd_prog < 0 && !bpf_probe_prog_type(prog_type, 0)) {
+		printf("SKIP (unsupported program type %d)\n", prog_type);
+		skips++;
+		goto close_fds;
+	}
 
 	expected_ret = unpriv && test->result_unpriv != UNDEF ?
 		       test->result_unpriv : test->result;
@@ -12905,7 +12912,7 @@ static void get_unpriv_disabled()
 
 static int do_test(bool unpriv, unsigned int from, unsigned int to)
 {
-	int i, passes = 0, errors = 0, skips = 0;
+	int i, passes = 0, errors = 0;
 
 	for (i = from; i < to; i++) {
 		struct bpf_test *test = &tests[i];
-- 
2.19.1

