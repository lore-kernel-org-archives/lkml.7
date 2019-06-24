Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C304AC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB4E2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561371465;
	bh=s5a9uuW1oRpZyOUMrHNb36epUClYyXDFss5hfro8qpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iv2jec35kDjKsFUxsMxRs4z55XQOvXxj+w2OZAtguL5qrSxr2tOvHpJeRtU3+l2n9
	 H9smFQ/7SHCToz1vrOoLYQViePGzzv7MIVdDsqjB7oMId0TbDOhFchhnPrHGcfIGUG
	 JpSHJGBRIsT6Oz+LYt47yvXzex09jjsA/KoSWog4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbfFXKRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:17:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730926AbfFXKRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:17:19 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFD15205C9;
        Mon, 24 Jun 2019 10:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561371438;
        bh=s5a9uuW1oRpZyOUMrHNb36epUClYyXDFss5hfro8qpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1vUXopQ056/h59cEV1IXUmHtAvsXl7gxeBFVav9Cthp/DuGdoknDJEJrS6zfz9ygn
         GdhjnJh0u5KE28oceT/0yquDV4LSEeUTtY+/k+X+3wG9hgA9/4qSRASkLeSFNZFCOq
         uHIRc64xnQvYmyfY86xU8SrGJrUF2o0yZyX6/aTI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Anisse Astier <aastier@freebox.fr>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 5.1 102/121] arm64/sve: <uapi/asm/ptrace.h> should not depend on <uapi/linux/prctl.h>
Date:   Mon, 24 Jun 2019 17:57:14 +0800
Message-Id: <20190624092325.925302207@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092320.652599624@linuxfoundation.org>
References: <20190624092320.652599624@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anisse Astier <aastier@freebox.fr>

commit 35341ca0614ab13e1ef34ad4f29a39e15ef31fa8 upstream.

Pulling linux/prctl.h into asm/ptrace.h in the arm64 UAPI headers causes
userspace build issues for any program (e.g. strace and qemu) that
includes both <sys/prctl.h> and <linux/ptrace.h> when using musl libc:

  | error: redefinition of 'struct prctl_mm_map'
  |  struct prctl_mm_map {

See https://github.com/foundriesio/meta-lmp/commit/6d4a106e191b5d79c41b9ac78fd321316d3013c0
for a public example of people working around this issue.

Although it's a bit grotty, fix this breakage by duplicating the prctl
constant definitions. Since these are part of the kernel ABI, they
cannot be changed in future and so it's not the end of the world to have
them open-coded.

Fixes: 43d4da2c45b2 ("arm64/sve: ptrace and ELF coredump support")
Cc: stable@vger.kernel.org
Acked-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Anisse Astier <aastier@freebox.fr>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/include/uapi/asm/ptrace.h |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -65,8 +65,6 @@
 
 #ifndef __ASSEMBLY__
 
-#include <linux/prctl.h>
-
 /*
  * User structures for general purpose, floating point and debug registers.
  */
@@ -113,10 +111,10 @@ struct user_sve_header {
 
 /*
  * Common SVE_PT_* flags:
- * These must be kept in sync with prctl interface in <linux/ptrace.h>
+ * These must be kept in sync with prctl interface in <linux/prctl.h>
  */
-#define SVE_PT_VL_INHERIT		(PR_SVE_VL_INHERIT >> 16)
-#define SVE_PT_VL_ONEXEC		(PR_SVE_SET_VL_ONEXEC >> 16)
+#define SVE_PT_VL_INHERIT		((1 << 17) /* PR_SVE_VL_INHERIT */ >> 16)
+#define SVE_PT_VL_ONEXEC		((1 << 18) /* PR_SVE_SET_VL_ONEXEC */ >> 16)
 
 
 /*


