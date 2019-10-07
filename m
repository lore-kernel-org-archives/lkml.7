Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA1EECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E682070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570461043;
	bh=tDjT88ehXn17T4Z8Un3YkEcUnFAmU6vDClRr1XSP4eU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mJEb2c+lqbMsbsCf6RdnyNs9+ST6UWKnrdArV3tbqbxH4EadNgHWehcrjbnXVqS4v
	 8F6waL2wSRDsP7kdWuN/g7FLYmN9fbgNMJC7rnUPkABvKZXqXZ0oJfYa3J2BgC4OWA
	 R+tQsynp+xBpEma9usG0Hfs9i+P6sX4KiNO3lTc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbfJGPKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:10:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbfJGPKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:10:40 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63C712070B;
        Mon,  7 Oct 2019 15:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570461039;
        bh=tDjT88ehXn17T4Z8Un3YkEcUnFAmU6vDClRr1XSP4eU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RbY4A44UDgdgxyBHp7zYLnqHeWFOtKZbWXyxtxUMDBybpt6eEoVq+bnAp1pSdkfDK
         Sm8Sdb/d+SVIx4YBPrfOxtFOZ2vI0g4p9qatFeonj/Lb+B0Gwl1GfsxRhoX/U5gH+P
         dHNvUbsndyDI5iDbaVGIG3t3TRk1DWDgWz751onQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        jaswinder.singh@linaro.org,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [BUGFIX PATCH 2/5] selftests: vm: Build/Run 64bit tests only on 64bit arch
Date:   Tue,  8 Oct 2019 00:10:36 +0900
Message-Id: <157046103602.20724.2137257179743632576.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157046101671.20724.9561877942986463668.stgit@devnote2>
References: <157046101671.20724.9561877942986463668.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some virtual address range tests requires 64bit address space,
and we can not build and run those tests on the 32bit machine.

Filter the 64bit architectures in Makefile and run_vmtests,
so that those tests are built/run only on 64bit archs.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 tools/testing/selftests/vm/Makefile    |    5 +++++
 tools/testing/selftests/vm/run_vmtests |   10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 9534dc2bc929..7f9a8a8c31da 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for vm selftests
+uname_M := $(shell uname -m 2>/dev/null || echo not)
+ARCH ?= $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/')
 
 CFLAGS = -Wall -I ../../../../usr/include $(EXTRA_CFLAGS)
 LDLIBS = -lrt
@@ -16,8 +18,11 @@ TEST_GEN_FILES += on-fault-limit
 TEST_GEN_FILES += thuge-gen
 TEST_GEN_FILES += transhuge-stress
 TEST_GEN_FILES += userfaultfd
+
+ifneq (,$(filter $(ARCH),arm64 ia64 mips64 parisc64 ppc64 riscv64 s390x sh64 sparc64 x86_64))
 TEST_GEN_FILES += va_128TBswitch
 TEST_GEN_FILES += virtual_address_range
+endif
 
 TEST_PROGS := run_vmtests
 
diff --git a/tools/testing/selftests/vm/run_vmtests b/tools/testing/selftests/vm/run_vmtests
index 951c507a27f7..a692ea828317 100755
--- a/tools/testing/selftests/vm/run_vmtests
+++ b/tools/testing/selftests/vm/run_vmtests
@@ -58,6 +58,14 @@ else
 	exit 1
 fi
 
+#filter 64bit architectures
+ARCH64STR="arm64 ia64 mips64 parisc64 ppc64 riscv64 s390x sh64 sparc64 x86_64"
+if [ -z $ARCH ]; then
+  ARCH=`uname -m 2>/dev/null | sed -e 's/aarch64.*/arm64/'`
+fi
+VADDR64=0
+echo "$ARCH64STR" | grep $ARCH && VADDR64=1
+
 mkdir $mnt
 mount -t hugetlbfs none $mnt
 
@@ -189,6 +197,7 @@ else
 	echo "[PASS]"
 fi
 
+if [ $VADDR64 -ne 0 ]; then
 echo "-----------------------------"
 echo "running virtual_address_range"
 echo "-----------------------------"
@@ -210,6 +219,7 @@ if [ $? -ne 0 ]; then
 else
     echo "[PASS]"
 fi
+fi # VADDR64
 
 echo "------------------------------------"
 echo "running vmalloc stability smoke test"

