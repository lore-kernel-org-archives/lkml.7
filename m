Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF664C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D12C208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380292;
	bh=1mChLguwNvmsTCWxCMHukNMunGzA705l+b8oIxjE6ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cFoZUYgtggybWIcZuXD8sKfsH7KyNfG2xVX4QiBtngWe91/u8BtQ7q84lfHMsApJy
	 vp3rbLpfJgNz7a3p9X8nRTY7ku8O3H0kU4brSmigjeF00hPtmJqHc/YMuSaYV77Bgv
	 nobXyqfLKHN+HyVcbmYKzM31qWwScehogUwCqza4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388982AbfIMNLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:11:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388969AbfIMNL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:11:29 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79BD9208C2;
        Fri, 13 Sep 2019 13:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380289;
        bh=1mChLguwNvmsTCWxCMHukNMunGzA705l+b8oIxjE6ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HdAGFfjkQpv5XR90UrJaR0gOgqQmb5CgahLHhxwMS/zpx0CGuCzOk13qMBIq960mb
         tRDFNEfBfbbHqVorxi/NStFnsfCYdVpTPgWf9A3FU19X6KzrNPlgjkmGWV/oCuldAd
         thFZvJDjPVcL7RCHOOkm99KSZ2009PUq+gctul+o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 017/190] timekeeping: Use proper ktime_add when adding nsecs in coarse offset
Date:   Fri, 13 Sep 2019 14:04:32 +0100
Message-Id: <20190913130600.943205156@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130559.669563815@linuxfoundation.org>
References: <20190913130559.669563815@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



