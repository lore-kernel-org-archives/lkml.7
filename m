Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B347C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A79621783
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573611086;
	bh=SGlEMGtMG096loXgaMD0JkGrovumKL9ByZfXDWAIQkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i1KbG9EXMdFaQTTx1lFWcbOFgKHWhAgIRmV0RzuCT2sb5SXN57TbbxdfM5VfQUeFf
	 x0Kzl4UzBHEHUvKjhsk121o0cL192WoYIggd3TkwipwtG+gQATwsroYqkktMQApLex
	 zOx+6DmkQMqLjsAy+kKqlZ7Uf0v3keFrCUwFz934=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbfKMCLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:11:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:52816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730123AbfKMB6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:58:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A67B32053B;
        Wed, 13 Nov 2019 01:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610328;
        bh=SGlEMGtMG096loXgaMD0JkGrovumKL9ByZfXDWAIQkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UbQSqM5bcs0h9vN7LsyOBs6J+fHmquRML/5UEV2YEP10E7V8kSWCxdDM8ExVtiGvB
         2DSrMM1z/2v3YUpVSoc9GQOBbg4WVcO4uCNW0snPQJOV7mMAwfC+i62X9VvgkIbzmT
         aMYrUB3eQ+LCUm9vMy2RS9fIzDJaDonvDiUqAEts=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 087/115] s390/kasan: avoid vdso instrumentation
Date:   Tue, 12 Nov 2019 20:55:54 -0500
Message-Id: <20191113015622.11592-87-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015622.11592-1-sashal@kernel.org>
References: <20191113015622.11592-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit 348498458505e202df41b6b9a78da448d39298b7 ]

vdso is mapped into user space processes, which won't have kasan
shodow mapped.

Reviewed-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/vdso32/Makefile | 3 ++-
 arch/s390/kernel/vdso64/Makefile | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/vdso32/Makefile b/arch/s390/kernel/vdso32/Makefile
index 101cadabfc89e..6d87f800b4f2c 100644
--- a/arch/s390/kernel/vdso32/Makefile
+++ b/arch/s390/kernel/vdso32/Makefile
@@ -25,9 +25,10 @@ obj-y += vdso32_wrapper.o
 extra-y += vdso32.lds
 CPPFLAGS_vdso32.lds += -P -C -U$(ARCH)
 
-# Disable gcov profiling and ubsan for VDSO code
+# Disable gcov profiling, ubsan and kasan for VDSO code
 GCOV_PROFILE := n
 UBSAN_SANITIZE := n
+KASAN_SANITIZE := n
 
 # Force dependency (incbin is bad)
 $(obj)/vdso32_wrapper.o : $(obj)/vdso32.so
diff --git a/arch/s390/kernel/vdso64/Makefile b/arch/s390/kernel/vdso64/Makefile
index 36bbafcf4a770..4bc166b8c0cbd 100644
--- a/arch/s390/kernel/vdso64/Makefile
+++ b/arch/s390/kernel/vdso64/Makefile
@@ -25,9 +25,10 @@ obj-y += vdso64_wrapper.o
 extra-y += vdso64.lds
 CPPFLAGS_vdso64.lds += -P -C -U$(ARCH)
 
-# Disable gcov profiling and ubsan for VDSO code
+# Disable gcov profiling, ubsan and kasan for VDSO code
 GCOV_PROFILE := n
 UBSAN_SANITIZE := n
+KASAN_SANITIZE := n
 
 # Force dependency (incbin is bad)
 $(obj)/vdso64_wrapper.o : $(obj)/vdso64.so
-- 
2.20.1

