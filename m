Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195EFC352A9
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 17:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E566B21A4A
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 17:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569778588;
	bh=/PUV6/gLISDR5QzXmZ1W1d7c2RECLlOac0UTFTta2Hg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xw260nHcCevv+nygcnNG1FTXIXZRGcmuZSTVJeZSazYgiFMGD6jUnSFyrrEEx03In
	 x2jiDHunALAjVWqm7Omcw2FkCieOqamQiy/luMDwHQzveo5JDoDpVvTXpUOWFmFVrq
	 +k95B091eU5eCvPpXXbp7TDKL1YQm1XUKI0eiCuE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730832AbfI2Rg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 13:36:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730790AbfI2RgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 13:36:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3544E21906;
        Sun, 29 Sep 2019 17:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569778583;
        bh=/PUV6/gLISDR5QzXmZ1W1d7c2RECLlOac0UTFTta2Hg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rdnw0VgCofl99Fr0qQUjn5j5f3Ca21LkzIdoNED2xwH2UYoJBzoXPfkmQfSsANgfE
         KCWdGa+Wt3m5ynO262O3pd3JeQvSScCa5eA0P2wD6KN3zi/7BooRxDrnRtXbI5gh/v
         VOUfYLp3nv4RrMcuT0zGQPgUIQpoBwilBBZkohX0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 23/23] kmemleak: increase DEBUG_KMEMLEAK_EARLY_LOG_SIZE default to 16K
Date:   Sun, 29 Sep 2019 13:35:33 -0400
Message-Id: <20190929173535.9744-23-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190929173535.9744-1-sashal@kernel.org>
References: <20190929173535.9744-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Boichat <drinkcat@chromium.org>

[ Upstream commit b751c52bb587ae66f773b15204ef7a147467f4c7 ]

The current default value (400) is too low on many systems (e.g.  some
ARM64 platform takes up 1000+ entries).

syzbot uses 16000 as default value, and has proved to be enough on beefy
configurations, so let's pick that value.

This consumes more RAM on boot (each entry is 160 bytes, so in total
~2.5MB of RAM), but the memory would later be freed (early_log is
__initdata).

Link: http://lkml.kernel.org/r/20190730154027.101525-1-drinkcat@chromium.org
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Suggested-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 131d5871f8c98..e1df563cdfe7e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -570,7 +570,7 @@ config DEBUG_KMEMLEAK_EARLY_LOG_SIZE
 	int "Maximum kmemleak early log entries"
 	depends on DEBUG_KMEMLEAK
 	range 200 40000
-	default 400
+	default 16000
 	help
 	  Kmemleak must track all the memory allocations to avoid
 	  reporting false positives. Since memory may be allocated or
-- 
2.20.1

