Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D467FC4CEC4
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 12:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8C0208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 12:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569069788;
	bh=qM5WdTFXJeQeXfLrLrJt53J8P8+c9SxFrwRah2/0kPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tau/mcWF6QK3T1sZJBeythht09GMSvmx7URP8ww5iWpcuUUBXLmCPUmu5/J+J9W5U
	 Q+ibO2XhYgXortgKqXW9+rIPFoYkw3Hyu1kpb6IKOJ8U3rAwQ4jWO9oToCywUtLH4I
	 wyoPpr4Il5p+5frEG0EIVDYURdtEGHFv8Z6slbHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407678AbfIUMnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 08:43:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407642AbfIUMnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 08:43:02 -0400
Received: from quaco.ghostprotocols.net (user.186-235-137-39.acesso10.net.br [186.235.137.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A191E20665;
        Sat, 21 Sep 2019 12:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569069781;
        bh=qM5WdTFXJeQeXfLrLrJt53J8P8+c9SxFrwRah2/0kPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1rQIfB61t6uI9OtQ7m6JoPktP93WDDSEalFOWgd/XQMy1csQjCLePYQ9s49OGM+WF
         cf9EylbsjatXu/WwhLbq9NYNAJCUlTcNb1d7+lkWsNe3EiF6NGD1TJ4LkfKzkfbVOA
         tq5HQeb+2P5NZqaaMP/ZJhTuIHzVjhxEa/MFJMpQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 04/10] tools arch x86 uapi: Synch asm/unistd.h with the kernel sources
Date:   Sat, 21 Sep 2019 09:42:34 -0300
Message-Id: <20190921124240.15741-5-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190921124240.15741-1-acme@kernel.org>
References: <20190921124240.15741-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the change in:

  45e29d119e99 ("x86/syscalls: Make __X32_SYSCALL_BIT be unsigned long")

That doesn't trigger any changes in tooling and silences this perf build
warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/unistd.h' differs from latest version at 'arch/x86/include/uapi/asm/unistd.h'
  diff -u tools/arch/x86/include/uapi/asm/unistd.h arch/x86/include/uapi/asm/unistd.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/uapi/asm/unistd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/arch/x86/include/uapi/asm/unistd.h b/tools/arch/x86/include/uapi/asm/unistd.h
index 30d7d04d72d6..196fdd02b8b1 100644
--- a/tools/arch/x86/include/uapi/asm/unistd.h
+++ b/tools/arch/x86/include/uapi/asm/unistd.h
@@ -3,7 +3,7 @@
 #define _UAPI_ASM_X86_UNISTD_H
 
 /* x32 syscall flag bit */
-#define __X32_SYSCALL_BIT	0x40000000
+#define __X32_SYSCALL_BIT	0x40000000UL
 
 #ifndef __KERNEL__
 # ifdef __i386__
-- 
2.21.0

