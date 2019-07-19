Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080B4C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D652421882
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563508828;
	bh=1sTBx+nVYEYy5Fk2KfWlMcNkjbOoZeRjEIvyULIGil4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s35Sx0PGOCgV2rB7VReqfvLk8vEWus+YApvPsnZfZB4hsGPdGGMV8nYxnNtJaIjKX
	 xWWSPYJ6WWFxC8KhCV38LDwMwS9QlIm5D13pVJYvXLRjv7I/4pb9mC0lMVcyekfXCc
	 94juEyJgUb/+HWbegZUCFHtc26l6P7k4AFdDB0T0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbfGSEA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:00:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727876AbfGSEAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:00:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42AA821882;
        Fri, 19 Jul 2019 04:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563508815;
        bh=1sTBx+nVYEYy5Fk2KfWlMcNkjbOoZeRjEIvyULIGil4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QJ61WwOzPpYINwe8EeezNyKj64l0w3nWhrxIY5ZiKIEpOLMoILc9QVsvClBBG9ueW
         c5wnrEryTpqg3su/g9f0qRaJ/Dq+BZUPhz7f/9DKQHfmUVm+UQJVkxfxa004I/5RR9
         iSDHiSdzZwNHwtnYE+l+shKVzIqVxcJVln8pVKKs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mathieu Malaterre <malat@debian.org>,
        Christoph Hellwig <hch@infradead.org>,
        Michael Neuling <mikey@neuling.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.2 105/171] powerpc: silence a -Wcast-function-type warning in dawr_write_file_bool
Date:   Thu, 18 Jul 2019 23:55:36 -0400
Message-Id: <20190719035643.14300-105-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719035643.14300-1-sashal@kernel.org>
References: <20190719035643.14300-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Malaterre <malat@debian.org>

[ Upstream commit 548c54acba5bd1388d50727a9a126a42d0cd4ad0 ]

In commit c1fe190c0672 ("powerpc: Add force enable of DAWR on P9
option") the following piece of code was added:

   smp_call_function((smp_call_func_t)set_dawr, &null_brk, 0);

Since GCC 8 this triggers the following warning about incompatible
function types:

  arch/powerpc/kernel/hw_breakpoint.c:408:21: error: cast between incompatible function types from 'int (*)(struct arch_hw_breakpoint *)' to 'void (*)(void *)' [-Werror=cast-function-type]

Since the warning is there for a reason, and should not be hidden behind
a cast, provide an intermediate callback function to avoid the warning.

Fixes: c1fe190c0672 ("powerpc: Add force enable of DAWR on P9 option")
Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/hw_breakpoint.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index a293a53b4365..50262597c222 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -370,6 +370,11 @@ void hw_breakpoint_pmu_read(struct perf_event *bp)
 bool dawr_force_enable;
 EXPORT_SYMBOL_GPL(dawr_force_enable);
 
+static void set_dawr_cb(void *info)
+{
+	set_dawr(info);
+}
+
 static ssize_t dawr_write_file_bool(struct file *file,
 				    const char __user *user_buf,
 				    size_t count, loff_t *ppos)
@@ -389,7 +394,7 @@ static ssize_t dawr_write_file_bool(struct file *file,
 
 	/* If we are clearing, make sure all CPUs have the DAWR cleared */
 	if (!dawr_force_enable)
-		smp_call_function((smp_call_func_t)set_dawr, &null_brk, 0);
+		smp_call_function(set_dawr_cb, &null_brk, 0);
 
 	return rc;
 }
-- 
2.20.1

