Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2845CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B7620657
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbfDDSo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:44:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:51958 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728934AbfDDSo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:44:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8B69BAF19;
        Thu,  4 Apr 2019 18:44:27 +0000 (UTC)
From:   Miroslav Benes <mbenes@suse.cz>
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        jpoimboe@redhat.com, pmladek@suse.com, jikos@kernel.org
Cc:     joe.lawrence@redhat.com, ggherdovich@suse.cz,
        linux-kbuild@vger.kernel.org, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2] kbuild: use -flive-patching when CONFIG_LIVEPATCH is enabled
Date:   Thu,  4 Apr 2019 20:44:11 +0200
Message-Id: <20190404184411.1392-1-mbenes@suse.cz>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 9 introduces a new option, -flive-patching. It disables certain
optimizations which could make a compilation unsafe for later live
patching of the running kernel.

The option is used only if CONFIG_LIVEPATCH is enabled and $(CC)
supports it.

Performance impact of the option was measured on three different
Intel machines - two bigger NUMA boxes and one smaller UMA box. Kernel
intensive (IO, scheduling, networking) benchmarks were selected, plus a
set of HPC workloads from NAS Parallel Benchmark. The tests were done on
upstream kernel 5.0-rc8 with openSUSE Leap 15.0 userspace.

The majority of the tests is unaffected. The only significant exception
is the scheduler section which suffers 1-3% degradation.

Evaluated-by: Giovanni Gherdovich <ggherdovich@suse.cz>
Signed-off-by: Miroslav Benes <mbenes@suse.cz>
---
The patch is based on master branch of the livepatching tree on
git.kernel.org.

Many thanks to Giovanni who ran the whole testing campaign and analyzed
the results. I archived the dashboard and detailed data. If anyone is
interested, we could probably set up a public website somewhere.

 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index f070e0d65186..464a693a22e9 100644
--- a/Makefile
+++ b/Makefile
@@ -789,6 +789,10 @@ KBUILD_CFLAGS_KERNEL += -ffunction-sections -fdata-sections
 LDFLAGS_vmlinux += --gc-sections
 endif
 
+ifdef CONFIG_LIVEPATCH
+KBUILD_CFLAGS += $(call cc-option, -flive-patching=inline-clone)
+endif
+
 # arch Makefile may override CC so keep this after arch Makefile is included
 NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
 
-- 
2.21.0

