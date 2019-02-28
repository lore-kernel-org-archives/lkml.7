Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAFDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D216C2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551357088;
	bh=0moKi9ZDADvDamp5b4cHz81e+NQhJ8w3MIPUXyiDZQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=idCQYj2olSWuadHoQjCH59aL+PipHbU4irwDSlRCmUPY/DvaWZ1s7/ctIbWuYn8Il
	 u2gkVmBAXxfgts/UWRzU62G+RGrrGp1tQbJzOWn/I7RVsMexZetkLeAOKrjP/Ox2ke
	 E5bNNfYKHP5eHuHl4y3aJUjx++s237CUd8Jk3HYo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732114AbfB1Mb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:31:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:37574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbfB1Mb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:31:27 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42CA72083D;
        Thu, 28 Feb 2019 12:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551357086;
        bh=0moKi9ZDADvDamp5b4cHz81e+NQhJ8w3MIPUXyiDZQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W/zpcoeQ9pERZkk2QJVUNc3Oxzs66wkb5ri7NNXLiKKeXk3XD0EQgnetPHKP4SV60
         8nRaouLDsD9GNABW8ezdxPTp38RYrAIoiIGOxFOzjMTNPFou6B5+bU1YdJfaQQwrdl
         nTXEZ2ylIj/9tnx7e2OE1mCe1Z92CXBCGD4bCHHg=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v4 2/6] uaccess: Use user_access_ok() in user_access_begin()
Date:   Thu, 28 Feb 2019 21:31:02 +0900
Message-Id: <155135706227.438.3395927496953086242.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <155135700242.438.12930250099644500209.stgit@devbox>
References: <155135700242.438.12930250099644500209.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use user_access_ok() instead of access_ok() in user_access_begin()
to validate the access context is user. This also allow us to
use (generic) strncpy_from_user() and strnlen_user() in atomic
state with setting USER_DS and disable pagefaults.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/include/asm/uaccess.h |    2 +-
 include/linux/uaccess.h        |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 3125d129d3b6..3b7502a34114 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -715,7 +715,7 @@ extern struct movsl_mask {
  */
 static __must_check inline bool user_access_begin(const void __user *ptr, size_t len)
 {
-	if (unlikely(!access_ok(ptr,len)))
+	if (unlikely(!user_access_ok(ptr, len)))
 		return 0;
 	__uaccess_begin_nospec();
 	return 1;
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index bf762689658b..1afd9dfabe67 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -282,7 +282,7 @@ extern long strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count);
 	probe_kernel_read(&retval, addr, sizeof(retval))
 
 #ifndef user_access_begin
-#define user_access_begin(ptr,len) access_ok(ptr, len)
+#define user_access_begin(ptr, len) user_access_ok(ptr, len)
 #define user_access_end() do { } while (0)
 #define unsafe_get_user(x, ptr, err) do { if (unlikely(__get_user(x, ptr))) goto err; } while (0)
 #define unsafe_put_user(x, ptr, err) do { if (unlikely(__put_user(x, ptr))) goto err; } while (0)

