Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5C5C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC2B20854
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420674;
	bh=WNzOcSDtG5/ZzPIRNc452Bw+G3KZ9d2AoXandGQy9MM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zH1nLt8TRruoWEpkJKNiFFqlzUbNQpby7bFK8Mnd9At6qBVxBSELdJwOfVWL5LrY7
	 nVa1L56LovY+WBtdPJ1BJPeYVN9GnGg7lHlT2wqVVfIChZXCR7JW9yw6avYSpB0wOK
	 Q3kaC9Z/v+S1dDaP8ns3Hqd8ufwtHhpkz5tlqTVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbfKVLEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:04:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:59488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731563AbfKVLEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:04:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1588207FC;
        Fri, 22 Nov 2019 11:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420670;
        bh=WNzOcSDtG5/ZzPIRNc452Bw+G3KZ9d2AoXandGQy9MM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1T/31Wj2VRkukB8wemW1hd8GbXwOlWC5XCrztXKgPlSJ3pVCRMfWaLg3UkA1Q5U/K
         Dp2c6htyutCYf4eyKgenljcjylw18VEbPBsKZ5H3OVzvHBz1ZZyRIM13tsKizGE2hi
         WOHYvVWkRipTFxzArK23jJwWo9WMJBJTiSjS9w4g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 169/220] s390/kasan: avoid user access code instrumentation
Date:   Fri, 22 Nov 2019 11:28:54 +0100
Message-Id: <20191122100924.963763508@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit b6cbe3e8bdff6f21f1b58b08a55f479cdcf98282 ]

Kasan instrumentation adds "store" check for variables marked as
modified by inline assembly. With user pointers containing addresses
from another address space this produces false positives.

static inline unsigned long clear_user_xc(void __user *to, ...)
{
	asm volatile(
	...
	: "+a" (to) ...

User space access functions are wrapped by manually instrumented
functions in kasan common code, which should be sufficient to catch
errors. So, we just disable uaccess.o instrumentation altogether.

Reviewed-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/lib/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/s390/lib/Makefile b/arch/s390/lib/Makefile
index 57ab40188d4bd..5418d10dc2a81 100644
--- a/arch/s390/lib/Makefile
+++ b/arch/s390/lib/Makefile
@@ -9,5 +9,9 @@ lib-$(CONFIG_SMP) += spinlock.o
 lib-$(CONFIG_KPROBES) += probes.o
 lib-$(CONFIG_UPROBES) += probes.o
 
+# Instrumenting memory accesses to __user data (in different address space)
+# produce false positives
+KASAN_SANITIZE_uaccess.o := n
+
 chkbss := mem.o
 include $(srctree)/arch/s390/scripts/Makefile.chkbss
-- 
2.20.1



