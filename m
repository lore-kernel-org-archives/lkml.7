Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10CFC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 20:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AACD020657
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 20:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bQ6vwyPA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfFVUS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 16:18:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43035 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfFVUS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 16:18:26 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so4981464pgv.10
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 13:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=/WIbOvsDTrvLDC24fOdBypJujyaPK50sharDOv05+xk=;
        b=bQ6vwyPA8TSaeUDHXO9rfx8mTkQhLSPllV+26CPitqfsLj0rha4R5bzbjhWv6zsQuB
         +TWoG20kr1i4IdfZ7zwFFuVvnuZYGI3/jnaLEx570/d4V3jP6UjcymNk7llvvwLsRCJ6
         oA3tFZmmYkJRCyfGSEOXnU37J5NXdEKw0Ue2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=/WIbOvsDTrvLDC24fOdBypJujyaPK50sharDOv05+xk=;
        b=uQ5tT/SBayMVu0M7iZ2D9eLFSuTHNPxLqUPzL26pcbHzuVXKEF1lMMsgWIrfP8s1Io
         bxyx6SVJKE49cIN/5lczGLWHKWealcGcmjOKwTKXecIvh038JQOX/YdGQyTrTKi4FcH5
         SwRhPnHTPKCX9jlzwOYofHi4iE9wc6qAwZXh3McTsWWl04+VVyBI6UNl2jrzx7pf6oEI
         s0OVSKxe1O3P2brD2CDGtBZ4WxxP8gPmr/nxZQVqw02laMKcA4MPmVfc/gVrszYOvzdY
         jvmKxBRzB5NSid/cmlzjepa4XeRqErLsZmYzw32yTc/DaDqJPCQSbmOBr5yLylP/HN9G
         fjSQ==
X-Gm-Message-State: APjAAAUlsh99CEj8Pd9+1Tm6lZHoRAg/mEOVtNMQvYgNrRjba7ffVxai
        sGdnDbpm6aYtjXZM9CKdx3TLDxfiFEQ=
X-Google-Smtp-Source: APXvYqy1EBEsNVqtj9oQBrrMEkl2E6RAxENgf8llfWep7RtL1AaVzsryPcOkgX6KcrbzhhapeTbN9Q==
X-Received: by 2002:a63:f346:: with SMTP id t6mr13859873pgj.203.1561234705618;
        Sat, 22 Jun 2019 13:18:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y8sm1344665pfn.52.2019.06.22.13.18.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 13:18:24 -0700 (PDT)
Date:   Sat, 22 Jun 2019 13:18:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] lkdtm: Check for SMEP clearing protections
Message-ID: <201906221315.8B1121B4@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an x86-specific test for pinned cr4 bits. A successful test
will validate pinning and check the ROP-style call-middle-of-function
defense, if needed. For example, in the case of native_write_cr4()
looking like this:

ffffffff8171bce0 <native_write_cr4>:
ffffffff8171bce0:       48 8b 35 79 46 f2 00    mov    0xf24679(%rip),%rsi
ffffffff8171bce7:       48 09 f7                or     %rsi,%rdi
ffffffff8171bcea:       0f 22 e7                mov    %rdi,%cr4
...
ffffffff8171bd5a:       c3                      retq

The UNSET_SMEP test will jump to ffffffff8171bcea (the mov to cr4)
instead of ffffffff8171bce0 (native_write_cr4() entry) to simulate a
direct-call bypass attempt.

Expected successful results:

  # echo UNSET_SMEP > /sys/kernel/debug/provoke-crash/DIRECT
  # dmesg
  [   79.594433] lkdtm: Performing direct entry UNSET_SMEP
  [   79.596459] lkdtm: trying to clear SMEP normally
  [   79.598406] lkdtm: ok: SMEP did not get cleared
  [   79.599981] lkdtm: trying to clear SMEP with call gadget
  [   79.601810] ------------[ cut here ]------------
  [   79.603421] Attempt to unpin cr4 bits: 100000; bypass attack?!
  ...
  [   79.650170] ---[ end trace 2452ca0f6126242e ]---
  [   79.650937] lkdtm: ok: SMEP removal was reverted

Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2:
- rebase to linux-next
---
 drivers/misc/lkdtm/bugs.c  | 66 ++++++++++++++++++++++++++++++++++++++
 drivers/misc/lkdtm/core.c  |  1 +
 drivers/misc/lkdtm/lkdtm.h |  1 +
 3 files changed, 68 insertions(+)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index d9fcfd3b5af0..99a2dce1625b 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -266,3 +266,69 @@ void lkdtm_STACK_GUARD_PAGE_TRAILING(void)
 
 	pr_err("FAIL: accessed page after stack!\n");
 }
+
+void lkdtm_UNSET_SMEP(void)
+{
+#ifdef CONFIG_X86_64
+#define MOV_CR4_DEPTH	64
+	void (*direct_write_cr4)(unsigned long val);
+	unsigned char *insn;
+	unsigned long cr4;
+	int i;
+
+	cr4 = native_read_cr4();
+
+	if ((cr4 & X86_CR4_SMEP) != X86_CR4_SMEP) {
+		pr_err("FAIL: SMEP not in use\n");
+		return;
+	}
+	cr4 &= ~(X86_CR4_SMEP);
+
+	pr_info("trying to clear SMEP normally\n");
+	native_write_cr4(cr4);
+	if (cr4 == native_read_cr4()) {
+		pr_err("FAIL: pinning SMEP failed!\n");
+		cr4 |= X86_CR4_SMEP;
+		pr_info("restoring SMEP\n");
+		native_write_cr4(cr4);
+		return;
+	}
+	pr_info("ok: SMEP did not get cleared\n");
+
+	/*
+	 * To test the post-write pinning verification we need to call
+	 * directly into the middle of native_write_cr4() where the
+	 * cr4 write happens, skipping any pinning. This searches for
+	 * the cr4 writing instruction.
+	 */
+	insn = (unsigned char *)native_write_cr4;
+	for (i = 0; i < MOV_CR4_DEPTH; i++) {
+		/* mov %rdi, %cr4 */
+		if (insn[i] == 0x0f && insn[i+1] == 0x22 && insn[i+2] == 0xe7)
+			break;
+		/* mov %rdi,%rax; mov %rax, %cr4 */
+		if (insn[i]   == 0x48 && insn[i+1] == 0x89 &&
+		    insn[i+2] == 0xf8 && insn[i+3] == 0x0f &&
+		    insn[i+4] == 0x22 && insn[i+5] == 0xe0)
+			break;
+	}
+	if (i >= MOV_CR4_DEPTH) {
+		pr_info("ok: cannot locate cr4 writing call gadget\n");
+		return;
+	}
+	direct_write_cr4 = (void *)(insn + i);
+
+	pr_info("trying to clear SMEP with call gadget\n");
+	direct_write_cr4(cr4);
+	if (native_read_cr4() & X86_CR4_SMEP) {
+		pr_info("ok: SMEP removal was reverted\n");
+	} else {
+		pr_err("FAIL: cleared SMEP not detected!\n");
+		cr4 |= X86_CR4_SMEP;
+		pr_info("restoring SMEP\n");
+		native_write_cr4(cr4);
+	}
+#else
+	pr_err("FAIL: this test is x86_64-only\n");
+#endif
+}
diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index 945f2059d423..52e99ab9cedc 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -114,6 +114,7 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(CORRUPT_USER_DS),
 	CRASHTYPE(STACK_GUARD_PAGE_LEADING),
 	CRASHTYPE(STACK_GUARD_PAGE_TRAILING),
+	CRASHTYPE(UNSET_SMEP),
 	CRASHTYPE(UNALIGNED_LOAD_STORE_WRITE),
 	CRASHTYPE(OVERWRITE_ALLOCATION),
 	CRASHTYPE(WRITE_AFTER_FREE),
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index c5ae0b37587d..6a284a87a037 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -26,6 +26,7 @@ void lkdtm_CORRUPT_LIST_DEL(void);
 void lkdtm_CORRUPT_USER_DS(void);
 void lkdtm_STACK_GUARD_PAGE_LEADING(void);
 void lkdtm_STACK_GUARD_PAGE_TRAILING(void);
+void lkdtm_UNSET_SMEP(void);
 
 /* lkdtm_heap.c */
 void __init lkdtm_heap_init(void);
-- 
2.17.1


-- 
Kees Cook
