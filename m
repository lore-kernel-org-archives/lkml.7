Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0832BC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5AE92053B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567076085;
	bh=C5qgsHSwT0BNcLYizj5BAj5PZSIIeN+HYK0eZy4vm6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EMBuDBsEk1l7XV3Eu+TQYwYVLvvBnbhfWORezHznCrBNaneCIzwrFGwxpdhhtreWj
	 PdKknCO1ooJt1XIXAbbYhl6Nymw6BdLxlSwgmsn46PaMlDixrb5m9VPwTlG4pjxfbU
	 TQkMr5UyFgtk2K/EQG3v624+tUGOPpZz4axbjCg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfH2Ku1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 06:50:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727746AbfH2KuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 06:50:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91E6F23426;
        Thu, 29 Aug 2019 10:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567075819;
        bh=C5qgsHSwT0BNcLYizj5BAj5PZSIIeN+HYK0eZy4vm6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CZkAo4YDa+Xc5CyA32K0M3Ror0TdM2RQ5cYshSz5p7g5F5EIqKLBQ5v1OXCB1rPWl
         mnIjGGpBrBKY/UdQKrSZXHSPBFA28QxOljKnHFifZ0/vFesNKbRh6TS3hW2IZCycv4
         letjrSPsM6RAXOgO/Bm+K6pQaLliXre2ds9vR5e0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 08/29] timekeeping: Use proper ktime_add when adding nsecs in coarse offset
Date:   Thu, 29 Aug 2019 06:49:48 -0400
Message-Id: <20190829105009.2265-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829105009.2265-1-sashal@kernel.org>
References: <20190829105009.2265-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jason A. Donenfeld" <Jason@zx2c4.com>

[ Upstream commit 0354c1a3cdf31f44b035cfad14d32282e815a572 ]

While this doesn't actually amount to a real difference, since the macro
evaluates to the same thing, every place else operates on ktime_t using
these functions, so let's not break the pattern.

Fixes: e3ff9c3678b4 ("timekeeping: Repair ktime_get_coarse*() granularity")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lkml.kernel.org/r/20190621203249.3909-1-Jason@zx2c4.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/timekeeping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 443edcddac8ab..c2708e1f0c69f 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -823,7 +823,7 @@ ktime_t ktime_get_coarse_with_offset(enum tk_offsets offs)
 
 	} while (read_seqcount_retry(&tk_core.seq, seq));
 
-	return base + nsecs;
+	return ktime_add_ns(base, nsecs);
 }
 EXPORT_SYMBOL_GPL(ktime_get_coarse_with_offset);
 
-- 
2.20.1

