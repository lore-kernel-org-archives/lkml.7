Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DACCA9EBD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173C120867
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572097062;
	bh=Qx5Mwi+ZX7G4BJNl1HaOQ3XGU6C1kwNJVmzWlWuN+8U=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=CHfDJKKAqKmlfFHH/hjy75wwDG9vNIfN4KvOXMtEvM9uh9HlVreBZtgC0i0Bqjoq7
	 r/F0s+vhclyaQoDJFTe/7TIBt/B8k0ruwm82MtnnXhKEEWh0SRn/GrHL9q9vTlL1KX
	 NwvUePDQ02Lj5XxODK//80mVzMdBt/m01w2WQkh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfJZNQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 09:16:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfJZNQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 09:16:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A219B2070B;
        Sat, 26 Oct 2019 13:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572095762;
        bh=Qx5Mwi+ZX7G4BJNl1HaOQ3XGU6C1kwNJVmzWlWuN+8U=;
        h=From:To:Cc:Subject:Date:From;
        b=IfUMJKm1yyQAa1pYDb3Wx4BbSGBd6FbBzVBiADMeLCWzSCLdeBHN0My1xoOf5kHHF
         hHJ8Wami0zaHUfwPEMlhQd16mNTbSF2aCmkkvZBspU8Bm5hJmifS4k7pf4RgaxI6/4
         YyLq4FvVfig89qBuzKZgfbjYHssInKXU+4DRxIgs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 01/99] tools: bpf: Use !building_out_of_srctree to determine srctree
Date:   Sat, 26 Oct 2019 09:14:22 -0400
Message-Id: <20191026131600.2507-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuah Khan <skhan@linuxfoundation.org>

[ Upstream commit 55d554f5d14071f7c2c5dbd88d0a2eb695c97d16 ]

make TARGETS=bpf kselftest fails with:

Makefile:127: tools/build/Makefile.include: No such file or directory

When the bpf tool make is invoked from tools Makefile, srctree is
cleared and the current logic check for srctree equals to empty
string to determine srctree location from CURDIR.

When the build in invoked from selftests/bpf Makefile, the srctree
is set to "." and the same logic used for srctree equals to empty is
needed to determine srctree.

Check building_out_of_srctree undefined as the condition for both
cases to fix "make TARGETS=bpf kselftest" build failure.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Song Liu <songliubraving@fb.com>
Link: https://lore.kernel.org/bpf/20190927011344.4695-1-skhan@linuxfoundation.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/Makefile     | 6 +++++-
 tools/lib/bpf/Makefile | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/Makefile b/tools/bpf/Makefile
index 53b60ad452f5d..93a84965345dc 100644
--- a/tools/bpf/Makefile
+++ b/tools/bpf/Makefile
@@ -12,7 +12,11 @@ INSTALL ?= install
 CFLAGS += -Wall -O2
 CFLAGS += -D__EXPORTED_HEADERS__ -I$(srctree)/include/uapi -I$(srctree)/include
 
-ifeq ($(srctree),)
+# This will work when bpf is built in tools env. where srctree
+# isn't set and when invoked from selftests build, where srctree
+# is set to ".". building_out_of_srctree is undefined for in srctree
+# builds
+ifndef building_out_of_srctree
 srctree := $(patsubst %/,%,$(dir $(CURDIR)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
 endif
diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 9312066a1ae38..f23e5e285541d 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -7,7 +7,11 @@ BPF_EXTRAVERSION = 4
 
 MAKEFLAGS += --no-print-directory
 
-ifeq ($(srctree),)
+# This will work when bpf is built in tools env. where srctree
+# isn't set and when invoked from selftests build, where srctree
+# is a ".". building_out_of_srctree is undefined for in srctree
+# builds
+ifndef building_out_of_srctree
 srctree := $(patsubst %/,%,$(dir $(CURDIR)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
-- 
2.20.1

