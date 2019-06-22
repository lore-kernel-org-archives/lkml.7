Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B14C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 19:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5530A20657
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 19:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="HVMpj5CG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbfFVT2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 15:28:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56327 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfFVT2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 15:28:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5MJSIEd2308378
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 22 Jun 2019 12:28:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5MJSIEd2308378
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561231699;
        bh=rFmbJBMjTzUowKgd+9hCaeVSbDPJxwfaMwhowtO2OZU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=HVMpj5CG9jACpKS06ujeUSfgfxLOu7Ry05q1MTsFRPafztKGqd184+PQB/x0G4+ZD
         KJy9ChNx5p3bpOfmBFvpplgQlXNGIxdQDlb63zjCC0X54lWhprtK+EI1oKV8iTS+WC
         fRIj4YPkoItHvf6UyZ359HNCrRHcwRZQJLPk0rr6poy2+biAUZDjh0YY9aoLJocdWj
         q2GJPX2ooUn/biXd2JMyCZBDfxPM8ICPsgrbDGne++EEgKPpc33Meh+iZgXE6+129J
         B8NrhJ3z0PPkBekoabaSYJ+Sx+rtFb3OZPdNWMHyNyegicD3B0TkWylJSOdYeyHMhy
         5ZBzsY4JPIH7w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5MJSH1X2308374;
        Sat, 22 Jun 2019 12:28:17 -0700
Date:   Sat, 22 Jun 2019 12:28:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Jason A. Donenfeld" <tipbot@zytor.com>
Message-ID: <tip-0354c1a3cdf31f44b035cfad14d32282e815a572@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, arnd@arndb.de,
        mingo@kernel.org, hpa@zytor.com, Jason@zx2c4.com
Reply-To: Jason@zx2c4.com, hpa@zytor.com, mingo@kernel.org, arnd@arndb.de,
          tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <20190621203249.3909-1-Jason@zx2c4.com>
References: <20190621203249.3909-1-Jason@zx2c4.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] timekeeping: Use proper ktime_add when adding
 nsecs in coarse offset
Git-Commit-ID: 0354c1a3cdf31f44b035cfad14d32282e815a572
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

Commit-ID:  0354c1a3cdf31f44b035cfad14d32282e815a572
Gitweb:     https://git.kernel.org/tip/0354c1a3cdf31f44b035cfad14d32282e815a572
Author:     Jason A. Donenfeld <Jason@zx2c4.com>
AuthorDate: Fri, 21 Jun 2019 22:32:47 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 12:11:27 +0200

timekeeping: Use proper ktime_add when adding nsecs in coarse offset

While this doesn't actually amount to a real difference, since the macro
evaluates to the same thing, every place else operates on ktime_t using
these functions, so let's not break the pattern.

Fixes: e3ff9c3678b4 ("timekeeping: Repair ktime_get_coarse*() granularity")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lkml.kernel.org/r/20190621203249.3909-1-Jason@zx2c4.com

---
 kernel/time/timekeeping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 44b726bab4bd..d911c8470149 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -819,7 +819,7 @@ ktime_t ktime_get_coarse_with_offset(enum tk_offsets offs)
 
 	} while (read_seqcount_retry(&tk_core.seq, seq));
 
-	return base + nsecs;
+	return ktime_add_ns(base, nsecs);
 }
 EXPORT_SYMBOL_GPL(ktime_get_coarse_with_offset);
 
