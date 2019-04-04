Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB7FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C1C2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369394;
	bh=Cz5WuxSBot8x1zeWrt9oRtAJz6yH264/qZ4vtTyPjrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OsF4IjjOU5BApCG/Wh7dB3jLhorLFJuq4uQm2EWZlJpD0Q5oYTFyua60DQM5U6JGy
	 JzeY8GgnzGw6ptgSIX8ePFFfy0hUlM/HzLqf8dfw4CAGcNmpJtaKb2kn0EpKqzzCfi
	 P0yH2GkTo640aXbRIKfsmPr/RZuWomhsMwNXX72Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388079AbfDDJQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:16:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388057AbfDDJQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:16:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11B1120652;
        Thu,  4 Apr 2019 09:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369387;
        bh=Cz5WuxSBot8x1zeWrt9oRtAJz6yH264/qZ4vtTyPjrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2ah1OFbc9fnHEBMvoQtiunXuqodoN6wQE0qJ6XssoxuVlTdDmtININ5kT41lcaSRD
         aqDid1y7wNrF0ZOFu3YyeKLH7Z/PwIJUB8oqqqSv1EmcDx43ukGL5rgQVNO8Gq1v5f
         7iF0DUsDy/07ilrcgReZDSgBNVN+c1MJN1Oy47BM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 189/246] selftests/bpf: skip verifier tests for unsupported program types
Date:   Thu,  4 Apr 2019 10:48:09 +0200
Message-Id: <20190404084625.803917351@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 2fd90d456892..9a967983abed 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -34,6 +34,7 @@
 #include <linux/if_ether.h>
 
 #include <bpf/bpf.h>
+#include <bpf/libbpf.h>
 
 #ifdef HAVE_GENHDR
 # include "autoconf.h"
@@ -59,6 +60,7 @@
 
 #define UNPRIV_SYSCTL "kernel/unprivileged_bpf_disabled"
 static bool unpriv_disabled = false;
+static int skips;
 
 struct bpf_test {
 	const char *descr;
@@ -15946,6 +15948,11 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 		pflags |= BPF_F_ANY_ALIGNMENT;
 	fd_prog = bpf_verify_program(prog_type, prog, prog_len, pflags,
 				     "GPL", 0, bpf_vlog, sizeof(bpf_vlog), 1);
+	if (fd_prog < 0 && !bpf_probe_prog_type(prog_type, 0)) {
+		printf("SKIP (unsupported program type %d)\n", prog_type);
+		skips++;
+		goto close_fds;
+	}
 
 	expected_ret = unpriv && test->result_unpriv != UNDEF ?
 		       test->result_unpriv : test->result;
@@ -16099,7 +16106,7 @@ static bool test_as_unpriv(struct bpf_test *test)
 
 static int do_test(bool unpriv, unsigned int from, unsigned int to)
 {
-	int i, passes = 0, errors = 0, skips = 0;
+	int i, passes = 0, errors = 0;
 
 	for (i = from; i < to; i++) {
 		struct bpf_test *test = &tests[i];
-- 
2.19.1



