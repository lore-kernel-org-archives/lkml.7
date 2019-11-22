Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264E4C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3AE22071C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420042;
	bh=SGlEMGtMG096loXgaMD0JkGrovumKL9ByZfXDWAIQkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ML/OdZniMWPoexn4QvKckoX+yV9nPO4jxXlM3OQFws+eNBAOmt+5OxdsEJhZS9lbZ
	 h3UiaYdckez/x3CzyZnCTMaEZKjhR8YKqljvpGL5235wN5bqfXZzs9m2oNG6YqBF4Y
	 3cVYbTFY6hxArWeui6HD9mKKZm/zgHznh1H/wVRc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbfKVKyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:54:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:39036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730274AbfKVKx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:53:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29F3620637;
        Fri, 22 Nov 2019 10:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420036;
        bh=SGlEMGtMG096loXgaMD0JkGrovumKL9ByZfXDWAIQkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EHoWWMvBBlcl5rr7QYPp24Y3pvVt+Na/a0CCayUDCM+4zmhopBCR8kcz4VIFQgdWc
         iDlxFutvlcMnphNWnRIKXJhAMPtvYI/da2f+dOJDIaEn20WWlpsgeWH81j7ErO92VP
         aQcWR3mFu/+jCWbTuYjgGScBNalvjnUKCQ0D//QA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 094/122] s390/kasan: avoid vdso instrumentation
Date:   Fri, 22 Nov 2019 11:29:07 +0100
Message-Id: <20191122100829.698641186@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100722.177052205@linuxfoundation.org>
References: <20191122100722.177052205@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



