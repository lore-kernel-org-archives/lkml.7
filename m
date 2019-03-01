Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA94C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 03:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3B220850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 03:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TrUYSuHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731241AbfCADMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 22:12:32 -0500
Received: from mail-oi1-f201.google.com ([209.85.167.201]:55566 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfCADMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 22:12:32 -0500
Received: by mail-oi1-f201.google.com with SMTP id i67so7539684oia.22
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 19:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hMuz8j9XixUzcJvX0z8nUg4Sq1ac3+nfj2XuL+HY2V4=;
        b=TrUYSuHUCl3uKhVR7ZbV/Q4/CCSUVyNQGxrdl8+tmAvG8klNbrpqOdG5peMwcsduKt
         e0Q0WtF7CnULR6b9/93d+2iVnM+VarfcIirY+Jy7Mg/x0M368p3xQ9BHxC2cXYvrQCvv
         F/Tp9RNlxO/Dg6fbhAgZsL/U5JLGZxzpaY6xA+P5Hhlnl773EY/eZa2u/icRMfx61LDW
         mMq5iC+1AaWP+USSSnKlMCMe5sL7OBejJcTZlMPKjRKcSnwSycqOKLYqj5Xwg8l/H3D/
         kwSVi6HUyXJkeCWraKOvA2PalGdsCy26pxDrFlJ7Mu0R8XoUUlfI6owX835rJKSEIK1B
         pvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hMuz8j9XixUzcJvX0z8nUg4Sq1ac3+nfj2XuL+HY2V4=;
        b=flBFdXRyEM24jYjsvxYMLCzhLXaHWfLeZfQ2609X8UKqPMrHNhmTmsvLfepfpQOzmY
         qc4NioUUGpfGPCKCdgCfSYHSvAZ79AWRy7FolQldeyynunYeUqWoBXjcGSSQJ7FGaPR7
         vSXEkHtwdmQceuG/rFLnrOYps0ATs1950agxmHJDGtfqem2D7xDgkaVyPlVbHYokKlbA
         dzetWa0MfRwLVUbFu2RR6Kme2TmeRKlEGbV0dyj+bkS1VW71OPOfDQguBHPQozxMwwq7
         DAqnVH5fBEuF5xJu8pNfxBJeWdZfH5a6wnRwVoeXo74STkG4pLCFcQ27QUtIZJ6ziRaA
         7/BA==
X-Gm-Message-State: APjAAAWedE1WCRemb3sz6rreQ+L8hFeLP6soiV8ZNBiuTV0LJ3DRCCf3
        cAkLqArxyuIsWtYQkjXXJkIeXMgmZg==
X-Google-Smtp-Source: APXvYqw6maUBSysTvwm6SV+PE/30VdvGuFkN36ozLAszM2/1+/oFumlBkxLFMBg5HdhLSqOzfwU2GVl6cQ==
X-Received: by 2002:a05:6830:1205:: with SMTP id r5mr1740472otp.62.1551409951508;
 Thu, 28 Feb 2019 19:12:31 -0800 (PST)
Date:   Fri,  1 Mar 2019 04:12:01 +0100
In-Reply-To: <20190301031201.7416-1-jannh@google.com>
Message-Id: <20190301031201.7416-2-jannh@google.com>
Mime-Version: 1.0
References: <20190301031201.7416-1-jannh@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 2/2] x86/unwind: add hardcoded ORC entry for NULL
From:   Jann Horn <jannh@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        jannh@google.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        syzbot <syzbot+ca95b2b7aef9e7cbd6ab@syzkaller.appspotmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the ORC unwinder is invoked for an oops caused by IP==0,
it currently has no idea what to do because there is no debug information
for the stack frame of NULL.

But if RIP is NULL, it is very likely that the last successfully executed
instruction was an indirect CALL/JMP, and it is possible to unwind out in
the same way as for the first instruction of a normal function. Hardcode
a corresponding ORC entry.


With an artificially-added NULL call in prctl_set_seccomp(), before this
patch, the trace is:

Call Trace:
 ? __x64_sys_prctl+0x402/0x680
 ? __ia32_sys_prctl+0x6e0/0x6e0
 ? __do_page_fault+0x457/0x620
 ? do_syscall_64+0x6d/0x160
 ? entry_SYSCALL_64_after_hwframe+0x44/0xa9

After this patch, the trace looks like this:

Call Trace:
 __x64_sys_prctl+0x402/0x680
 ? __ia32_sys_prctl+0x6e0/0x6e0
 ? __do_page_fault+0x457/0x620
 do_syscall_64+0x6d/0x160
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

prctl_set_seccomp() still doesn't show up in the trace because for some
reason, tail call optimization is only disabled in builds that use the
frame pointer unwinder.

Signed-off-by: Jann Horn <jannh@google.com>
---
Is there a reason why the top-level Makefile only sets
-fno-optimize-sibling-calls if CONFIG_FRAME_POINTER is set?
I suspect that this is just a historical thing, because reliable
unwinding didn't work without frame pointers until ORC came along.
I'm not quite sure how best to express "don't do tail optimization if
either frame pointers are used or ORC is used" in a Makefile, and
whether we want an indirection through Kconfig for that, so I'm not
doing anything about it in this series.
Can someone send a patch to deal with it properly?


 arch/x86/kernel/unwind_orc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 26038eacf74a..89be1be1790c 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -113,6 +113,20 @@ static struct orc_entry *orc_ftrace_find(unsigned long ip)
 }
 #endif
 
+/*
+ * If we crash with IP==0, the last successfully executed instruction
+ * was probably an indirect function call with a NULL function pointer,
+ * and we don't have unwind information for NULL.
+ * This hardcoded ORC entry for IP==0 allows us to unwind from a NULL function
+ * pointer into its parent and then continue normally from there.
+ */
+static struct orc_entry null_orc_entry = {
+	.sp_offset = sizeof(long),
+	.sp_reg = ORC_REG_SP,
+	.bp_reg = ORC_REG_UNDEFINED,
+	.type = ORC_TYPE_CALL
+};
+
 static struct orc_entry *orc_find(unsigned long ip)
 {
 	static struct orc_entry *orc;
@@ -120,6 +134,9 @@ static struct orc_entry *orc_find(unsigned long ip)
 	if (!orc_init)
 		return NULL;
 
+	if (ip == 0)
+		return &null_orc_entry;
+
 	/* For non-init vmlinux addresses, use the fast lookup table: */
 	if (ip >= LOOKUP_START_IP && ip < LOOKUP_STOP_IP) {
 		unsigned int idx, start, stop;
-- 
2.21.0.352.gf09ad66450-goog

