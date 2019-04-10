Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516A5C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB062133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554936142;
	bh=8WK860sKSnflj0EGOs8UxQFwZKdjz5fHNUUwbVx4ve0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=n17/AlZlJbwBQstjwDtBLm6nrv80tMilKoyBoDXjaDXCPOgxHWepGMkb2hlM3Gn06
	 Khs6qSo0xwL2MeOzB7KQ5hHjHd9qnquoiiKHCyaJWn6FMgYMFNOMnLV0EDGIKThRVQ
	 jK6VYhP22J2zqkmpIGfmq9RmORmWZVseRnBblbiM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfDJWmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:42:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbfDJWmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 18:42:20 -0400
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [23.96.42.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E603120830;
        Wed, 10 Apr 2019 22:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554936139;
        bh=8WK860sKSnflj0EGOs8UxQFwZKdjz5fHNUUwbVx4ve0=;
        h=From:To:Cc:Subject:Date:From;
        b=Z/wR9PDC+uj4VgiHX+OXbu6GM/ou1xVWPCkCpOL3QHio4dl/IRq4cjB6QcoERRjTf
         TXKlGjiWruVBw6zmzi8DNphDJRxIBanPjFD4NLHcXfxkrZ++HjFKukPan+lmzBqkLO
         mH7aZbS9XJXJG4gheuf07HiSqGcAWBMftWTJmbZs=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Changbin Du <changbin.du@intel.com>
Subject: [PATCH v2] init: Do not select DEBUG_KERNEL by default
Date:   Wed, 10 Apr 2019 22:42:10 +0000
Message-Id: <20190410224213.20651-1-okaya@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can't seem to have a kernel with CONFIG_EXPERT set but
CONFIG_DEBUG_KERNEL unset these days.

While some of the features under the CONFIG_EXPERT require
CONFIG_DEBUG_KERNEL, it doesn't apply for all features.

It looks like CONFIG_KALLSYMS_ALL is the only feature that
requires CONFIG_DEBUG_KERNEL.

Select CONFIG_EXPERT when CONFIG_DEBUG is chosen but you can
still choose CONFIG_EXPERT without CONFIG_DEBUG.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 init/Kconfig      | 2 --
 lib/Kconfig.debug | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 4592bf7997c0..37e10a8391a3 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1206,8 +1206,6 @@ config BPF
 
 menuconfig EXPERT
 	bool "Configure standard kernel features (expert users)"
-	# Unhide debug options, to make the on-by-default options visible
-	select DEBUG_KERNEL
 	help
 	  This option allows certain base kernel options and settings
           to be disabled or tweaked. This is for specialized
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 0d9e81779e37..9fbf3499ec8d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -434,6 +434,7 @@ config MAGIC_SYSRQ_SERIAL
 
 config DEBUG_KERNEL
 	bool "Kernel debugging"
+	default EXPERT
 	help
 	  Say Y here if you are developing drivers or trying to debug and
 	  identify kernel problems.
-- 
2.21.0

