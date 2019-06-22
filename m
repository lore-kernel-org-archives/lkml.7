Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60FCC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D840206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="x0bB0RcO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfFVKHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 06:07:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37093 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfFVKHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 06:07:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5MA6tQI2096033
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 22 Jun 2019 03:06:55 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5MA6tQI2096033
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561198015;
        bh=ggow0bmMjMVkEEmAaUWndDinrMpea4Ej0FNVo4xhXx4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=x0bB0RcOpcrluLIR4bJZZQ2L0bH1Zb2THzaIXNw4OoW19GscSwT+0p6dXxbdnhO+6
         xfyNPKhRyph9NAdkKJbMZfu3QwW47BFDJoLZRktzyu48fp2gLnjqmPZ0z63PgoXquu
         llEp0VA6yA147OYYWRcF8Cw2SpG8auJOkvXDfON77QJO3oSSQ8tHLiQFF+wNMm+xtT
         FoCcuasWDMQ9Bukrt2rFqkxxBpZ4pjF1fzJHoXYHgVhEMrxZoJrvvHZKxRdPGjOA7d
         HhlX0/XINvKGZT2IjI6qrn2TPmP/F0dWx5fFixvys6JoSDjrwNr4YjeCIfkfDKybov
         Q8SbWGadQ0/hA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5MA6sxC2096030;
        Sat, 22 Jun 2019 03:06:54 -0700
Date:   Sat, 22 Jun 2019 03:06:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-8b71340d702ec5d587443b38a852671c4fb6a723@git.kernel.org>
Cc:     mingo@kernel.org, ak@linux.intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com, tglx@linutronix.de, hpa@zytor.com,
        luto@kernel.org, ravi.v.shankar@intel.com
Reply-To: tglx@linutronix.de, luto@kernel.org, ravi.v.shankar@intel.com,
          hpa@zytor.com, linux-kernel@vger.kernel.org,
          chang.seok.bae@intel.com, mingo@kernel.org, ak@linux.intel.com
In-Reply-To: <1557309753-24073-6-git-send-email-chang.seok.bae@intel.com>
References: <1557309753-24073-6-git-send-email-chang.seok.bae@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/fsgsbase/64: Add intrinsics for FSGSBASE
 instructions
Git-Commit-ID: 8b71340d702ec5d587443b38a852671c4fb6a723
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  8b71340d702ec5d587443b38a852671c4fb6a723
Gitweb:     https://git.kernel.org/tip/8b71340d702ec5d587443b38a852671c4fb6a723
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Wed, 8 May 2019 03:02:20 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 11:38:52 +0200

x86/fsgsbase/64: Add intrinsics for FSGSBASE instructions

[ luto: Rename the variables from FS and GS to FSBASE and GSBASE and
  make <asm/fsgsbase.h> safe to include on 32-bit kernels. ]

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Link: https://lkml.kernel.org/r/1557309753-24073-6-git-send-email-chang.seok.bae@intel.com

---
 arch/x86/include/asm/fsgsbase.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
index bca4c743de77..fdd1177499b4 100644
--- a/arch/x86/include/asm/fsgsbase.h
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -19,6 +19,36 @@ extern unsigned long x86_gsbase_read_task(struct task_struct *task);
 extern void x86_fsbase_write_task(struct task_struct *task, unsigned long fsbase);
 extern void x86_gsbase_write_task(struct task_struct *task, unsigned long gsbase);
 
+/* Must be protected by X86_FEATURE_FSGSBASE check. */
+
+static __always_inline unsigned long rdfsbase(void)
+{
+	unsigned long fsbase;
+
+	asm volatile("rdfsbase %0" : "=r" (fsbase) :: "memory");
+
+	return fsbase;
+}
+
+static __always_inline unsigned long rdgsbase(void)
+{
+	unsigned long gsbase;
+
+	asm volatile("rdgsbase %0" : "=r" (gsbase) :: "memory");
+
+	return gsbase;
+}
+
+static __always_inline void wrfsbase(unsigned long fsbase)
+{
+	asm volatile("wrfsbase %0" :: "r" (fsbase) : "memory");
+}
+
+static __always_inline void wrgsbase(unsigned long gsbase)
+{
+	asm volatile("wrgsbase %0" :: "r" (gsbase) : "memory");
+}
+
 /* Helper functions for reading/writing FS/GS base */
 
 static inline unsigned long x86_fsbase_read_cpu(void)
