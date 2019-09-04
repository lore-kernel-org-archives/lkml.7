Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D65EC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573C722CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567619882;
	bh=zoRprk2V8Tx3nRetmgk8Ms+4yAZgUhFm9LnvQgur+3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DzF/n20KHJUpTovMN6tKTTj7Os1mD1kQ10CQTskcvevoKYymmF46UDoJ5Rk/N58ad
	 y8w3Svc3LqY+RifnJPmMC9AbPHF2unIqTgaElSQM5k21aTWsxDL22msIb4c8Il9Uzm
	 UB13YlTazKiO4/hVkLFDWxeco8lrrczmraC6gVKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387973AbfIDR6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 13:58:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387966AbfIDR6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:58:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80495208E4;
        Wed,  4 Sep 2019 17:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567619879;
        bh=zoRprk2V8Tx3nRetmgk8Ms+4yAZgUhFm9LnvQgur+3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lzPAYsW0WUWbtB7JMCgQSDho5ry1gm3q2K0MU4o6uweFsJfvFSRRs8rWvKOnYeyD+
         rNA3BXMmKBW4KoXait0NsWTWwQZ6AR+Z2tyAgK/RXPPm6SOECutSZRL1vhaTW6ZHe4
         UeyY8VuAJJeEyQg2uSHHOLPssx+onVaBIVsHj7Ec=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        ricardo.neri@intel.com, Adrian Hunter <adrian.hunter@intel.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Huang Rui <ray.huang@amd.com>,
        Qiaowei Ren <qiaowei.ren@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, Jiri Slaby <jslaby@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Brian Gerst <brgerst@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Chen Yucong <slaoub@gmail.com>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Garnier <thgarnie@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 69/77] ptrace,x86: Make user_64bit_mode() available to 32-bit builds
Date:   Wed,  4 Sep 2019 19:53:56 +0200
Message-Id: <20190904175309.806860827@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175303.317468926@linuxfoundation.org>
References: <20190904175303.317468926@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit e27c310af5c05cf876d9cad006928076c27f54d4 ]

In its current form, user_64bit_mode() can only be used when CONFIG_X86_64
is selected. This implies that code built with CONFIG_X86_64=n cannot use
it. If a piece of code needs to be built for both CONFIG_X86_64=y and
CONFIG_X86_64=n and wants to use this function, it needs to wrap it in
an #ifdef/#endif; potentially, in multiple places.

This can be easily avoided with a single #ifdef/#endif pair within
user_64bit_mode() itself.

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: ricardo.neri@intel.com
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Qiaowei Ren <qiaowei.ren@intel.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: Chen Yucong <slaoub@gmail.com>
Cc: Adam Buchbinder <adam.buchbinder@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Garnier <thgarnie@google.com>
Link: https://lkml.kernel.org/r/1509135945-13762-4-git-send-email-ricardo.neri-calderon@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/ptrace.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 6271281f947d8..0d8e0831b1a07 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -121,9 +121,9 @@ static inline int v8086_mode(struct pt_regs *regs)
 #endif
 }
 
-#ifdef CONFIG_X86_64
 static inline bool user_64bit_mode(struct pt_regs *regs)
 {
+#ifdef CONFIG_X86_64
 #ifndef CONFIG_PARAVIRT
 	/*
 	 * On non-paravirt systems, this is the only long mode CPL 3
@@ -134,8 +134,12 @@ static inline bool user_64bit_mode(struct pt_regs *regs)
 	/* Headers are too twisted for this to go in paravirt.h. */
 	return regs->cs == __USER_CS || regs->cs == pv_info.extra_user_64bit_cs;
 #endif
+#else /* !CONFIG_X86_64 */
+	return false;
+#endif
 }
 
+#ifdef CONFIG_X86_64
 #define current_user_stack_pointer()	current_pt_regs()->sp
 #define compat_user_stack_pointer()	current_pt_regs()->sp
 #endif
-- 
2.20.1



