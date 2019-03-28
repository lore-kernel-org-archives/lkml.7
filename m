Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA9AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1508B204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfC1Mn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:43:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59489 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfC1Mn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:43:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2SCh3WV3319930
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 28 Mar 2019 05:43:03 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2SCh2C43319927;
        Thu, 28 Mar 2019 05:43:02 -0700
Date:   Thu, 28 Mar 2019 05:43:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Daniel Borkmann <tipbot@zytor.com>
Message-ID: <tip-a9d57ef15cbe327fe54416dd194ee0ea66ae53a4@git.kernel.org>
Cc:     magnus.karlsson@intel.com, dwmw2@infradead.org, tglx@linutronix.de,
        mliska@suse.cz, torvalds@linux-foundation.org, ast@kernel.org,
        hpa@zytor.com, daniel@iogearbox.net, mingo@kernel.org,
        bjorn.topel@intel.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, hjl.tools@gmail.com,
        brouer@redhat.com
Reply-To: davem@davemloft.net, bjorn.topel@intel.com, mingo@kernel.org,
          daniel@iogearbox.net, hpa@zytor.com,
          torvalds@linux-foundation.org, ast@kernel.org, mliska@suse.cz,
          tglx@linutronix.de, dwmw2@infradead.org,
          magnus.karlsson@intel.com, brouer@redhat.com,
          hjl.tools@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <20190325135620.14882-1-daniel@iogearbox.net>
References: <20190325135620.14882-1-daniel@iogearbox.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/retpolines: Disable switch jump tables when
 retpolines are enabled
Git-Commit-ID: a9d57ef15cbe327fe54416dd194ee0ea66ae53a4
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

Commit-ID:  a9d57ef15cbe327fe54416dd194ee0ea66ae53a4
Gitweb:     https://git.kernel.org/tip/a9d57ef15cbe327fe54416dd194ee0ea66ae53a4
Author:     Daniel Borkmann <daniel@iogearbox.net>
AuthorDate: Mon, 25 Mar 2019 14:56:20 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 28 Mar 2019 13:39:48 +0100

x86/retpolines: Disable switch jump tables when retpolines are enabled

Commit ce02ef06fcf7 ("x86, retpolines: Raise limit for generating indirect
calls from switch-case") raised the limit under retpolines to 20 switch
cases where gcc would only then start to emit jump tables, and therefore
effectively disabling the emission of slow indirect calls in this area.

After this has been brought to attention to gcc folks [0], Martin Liska
has then fixed gcc to align with clang by avoiding to generate switch jump
tables entirely under retpolines. This is taking effect in gcc starting
from stable version 8.4.0. Given kernel supports compilation with older
versions of gcc where the fix is not being available or backported anymore,
we need to keep the extra KBUILD_CFLAGS around for some time and generally
set the -fno-jump-tables to align with what more recent gcc is doing
automatically today.

More than 20 switch cases are not expected to be fast-path critical, but
it would still be good to align with gcc behavior for versions < 8.4.0 in
order to have consistency across supported gcc versions. vmlinux size is
slightly growing by 0.27% for older gcc. This flag is only set to work
around affected gcc, no change for clang.

  [0] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=86952

Suggested-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Björn Töpel<bjorn.topel@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: H.J. Lu <hjl.tools@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: David S. Miller <davem@davemloft.net>
Link: https://lkml.kernel.org/r/20190325135620.14882-1-daniel@iogearbox.net
---
 arch/x86/Makefile | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 2d8b9d8ca4f8..a587805c6687 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -219,8 +219,12 @@ ifdef CONFIG_RETPOLINE
   # Additionally, avoid generating expensive indirect jumps which
   # are subject to retpolines for small number of switch cases.
   # clang turns off jump table generation by default when under
-  # retpoline builds, however, gcc does not for x86.
-  KBUILD_CFLAGS += $(call cc-option,--param=case-values-threshold=20)
+  # retpoline builds, however, gcc does not for x86. This has
+  # only been fixed starting from gcc stable version 8.4.0 and
+  # onwards, but not for older ones. See gcc bug #86952.
+  ifndef CONFIG_CC_IS_CLANG
+    KBUILD_CFLAGS += $(call cc-option,-fno-jump-tables)
+  endif
 endif
 
 archscripts: scripts_basic
