Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7B8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33DBA2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfCYN5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:57:05 -0400
Received: from www62.your-server.de ([213.133.104.62]:40188 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbfCYN5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:57:05 -0400
Received: from [178.197.248.24] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h8Q5p-00063d-6w; Mon, 25 Mar 2019 14:56:49 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, mliska@suse.cz,
        Daniel Borkmann <daniel@iogearbox.net>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH] x86, retpolines: entirely disable switch jump tables when retpolines are enabled
Date:   Mon, 25 Mar 2019 14:56:20 +0100
Message-Id: <20190325135620.14882-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25399/Mon Mar 25 08:46:48 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Cc: H.J. Lu <hjl.tools@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Björn Töpel <bjorn.topel@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: David S. Miller <davem@davemloft.net>
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
-- 
2.17.1

