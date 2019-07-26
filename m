Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AFFC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0436122CE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564149513;
	bh=7RAidGglI7aphPYIWI0gFIpx2fMV/LHZrmurjZTT1Aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0yq/kc3IIQgZm3GgdUh2Moih3mELdRLIc96fl8A+2+RnSa88nhTqYJ+u8fZMrTHv3
	 4pCe2TagsuwnronEI7257NpXYyZIVmtMSQxT37GpCKfAmUpoADiwU5e4U2zfguTGbD
	 1aZvuiy/CXjd+GdwHjBSPvh/NtNdzab/xHEEqy+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387543AbfGZNkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:40:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:46772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387507AbfGZNkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:40:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF14C22CB9;
        Fri, 26 Jul 2019 13:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148438;
        bh=7RAidGglI7aphPYIWI0gFIpx2fMV/LHZrmurjZTT1Aw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TNrErPOUvGYQSamwaZvsRstU7CwjjeTtp0IyuRato71abI643fMQ73y/pFdsPd0zp
         XbKI4xasLHVs+ppzmqq9F+XjmbgnVlJCys0FT3wQmht1JgyWoPtdmkB5RublzNNWAG
         RNlZ1lnbFqcXMXm4NsZ4dEbvGizevykJeQJ+Gf+Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 5.2 39/85] selftests/bpf: do not ignore clang failures
Date:   Fri, 26 Jul 2019 09:38:49 -0400
Message-Id: <20190726133936.11177-39-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726133936.11177-1-sashal@kernel.org>
References: <20190726133936.11177-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilya Leoshkevich <iii@linux.ibm.com>

[ Upstream commit 9cae4ace80ef39005da106fbb89c952b27d7b89e ]

When compiling an eBPF prog fails, make still returns 0, because
failing clang command's output is piped to llc and therefore its
exit status is ignored.

When clang fails, pipe the string "clang failed" to llc. This will make
llc fail with an informative error message. This solution was chosen
over using pipefail, having separate targets or getting rid of llc
invocation due to its simplicity.

In addition, pull Kbuild.include in order to get .DELETE_ON_ERROR target,
which would cause partial .o files to be removed.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/Makefile | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index e36356e2377e..e375f399b7a6 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+include ../../../../scripts/Kbuild.include
 
 LIBDIR := ../../../lib
 BPFDIR := $(LIBDIR)/bpf
@@ -185,8 +186,8 @@ $(ALU32_BUILD_DIR)/test_progs_32: prog_tests/*.c
 
 $(ALU32_BUILD_DIR)/%.o: progs/%.c $(ALU32_BUILD_DIR) \
 					$(ALU32_BUILD_DIR)/test_progs_32
-	$(CLANG) $(CLANG_FLAGS) \
-		 -O2 -target bpf -emit-llvm -c $< -o - |      \
+	($(CLANG) $(CLANG_FLAGS) -O2 -target bpf -emit-llvm -c $< -o - || \
+		echo "clang failed") | \
 	$(LLC) -march=bpf -mattr=+alu32 -mcpu=$(CPU) $(LLC_FLAGS) \
 		-filetype=obj -o $@
 ifeq ($(DWARF2BTF),y)
@@ -197,16 +198,16 @@ endif
 # Have one program compiled without "-target bpf" to test whether libbpf loads
 # it successfully
 $(OUTPUT)/test_xdp.o: progs/test_xdp.c
-	$(CLANG) $(CLANG_FLAGS) \
-		-O2 -emit-llvm -c $< -o - | \
+	($(CLANG) $(CLANG_FLAGS) -O2 -emit-llvm -c $< -o - || \
+		echo "clang failed") | \
 	$(LLC) -march=bpf -mcpu=$(CPU) $(LLC_FLAGS) -filetype=obj -o $@
 ifeq ($(DWARF2BTF),y)
 	$(BTF_PAHOLE) -J $@
 endif
 
 $(OUTPUT)/%.o: progs/%.c
-	$(CLANG) $(CLANG_FLAGS) \
-		 -O2 -target bpf -emit-llvm -c $< -o - |      \
+	($(CLANG) $(CLANG_FLAGS) -O2 -target bpf -emit-llvm -c $< -o - || \
+		echo "clang failed") | \
 	$(LLC) -march=bpf -mcpu=$(CPU) $(LLC_FLAGS) -filetype=obj -o $@
 ifeq ($(DWARF2BTF),y)
 	$(BTF_PAHOLE) -J $@
-- 
2.20.1

