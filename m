Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780C4C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E35E20675
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558355217;
	bh=Z2GfKcHpVHwXI4/sFoV0Z1BGczs685S2OFmpzrq1tw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W6vpXhMN7DdBgvMhb+PvuprV+hqQ4/ZdCZpfXpQ6zcZAArOP245ZaBPvZ9ifPYs+W
	 Vl9u9tBbi+mCvss/uDt0X90hRWJ3BiYcscgHmxHKJfl0DIcxiSmxIii8PtULKCEaSU
	 8Y7yDimlxgk2AZM9ExHcOiWdQh24EVRzB0ouMp4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389431AbfETM0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:26:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388327AbfETM0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:26:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 414A520815;
        Mon, 20 May 2019 12:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558355212;
        bh=Z2GfKcHpVHwXI4/sFoV0Z1BGczs685S2OFmpzrq1tw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ahCD3iuQC8oNhjBc1ibXtzaGRyUwsk4cc0kYZObGMXEsKmUsfKZVPxYmicJvKGWjl
         C3eZ7+7rXjVhPwCyj73zE9z3F3UG3T7Cjr6a0b+8TrDq1TK3W0sY68nkgLlA26tN9K
         fLk8eokAVX5F0VNPpyvMOG9OAV0I7YYaKDKoWY2Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jann Horn <jannh@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH 5.0 016/123] arm64: compat: Reduce address limit
Date:   Mon, 20 May 2019 14:13:16 +0200
Message-Id: <20190520115246.082431052@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115245.439864225@linuxfoundation.org>
References: <20190520115245.439864225@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

commit d263119387de9975d2acba1dfd3392f7c5979c18 upstream.

Currently, compat tasks running on arm64 can allocate memory up to
TASK_SIZE_32 (UL(0x100000000)).

This means that mmap() allocations, if we treat them as returning an
array, are not compliant with the sections 6.5.8 of the C standard
(C99) which states that: "If the expression P points to an element of
an array object and the expression Q points to the last element of the
same array object, the pointer expression Q+1 compares greater than P".

Redefine TASK_SIZE_32 to address the issue.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Jann Horn <jannh@google.com>
Cc: <stable@vger.kernel.org>
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
[will: fixed typo in comment]
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/include/asm/processor.h |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -57,7 +57,15 @@
 #define TASK_SIZE_64		(UL(1) << vabits_user)
 
 #ifdef CONFIG_COMPAT
+#ifdef CONFIG_ARM64_64K_PAGES
+/*
+ * With CONFIG_ARM64_64K_PAGES enabled, the last page is occupied
+ * by the compat vectors page.
+ */
 #define TASK_SIZE_32		UL(0x100000000)
+#else
+#define TASK_SIZE_32		(UL(0x100000000) - PAGE_SIZE)
+#endif /* CONFIG_ARM64_64K_PAGES */
 #define TASK_SIZE		(test_thread_flag(TIF_32BIT) ? \
 				TASK_SIZE_32 : TASK_SIZE_64)
 #define TASK_SIZE_OF(tsk)	(test_tsk_thread_flag(tsk, TIF_32BIT) ? \


