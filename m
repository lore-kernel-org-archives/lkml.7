Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28D7C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92BAE2166E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560806594;
	bh=JA+p7wrGBfD3DC0g1p9qRNUiBsLsU3ExILISMxqH+iM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jR6ht95h62kQ3cIpyMsAwYRTuL4ZXmTYNnys+TaS5Nc7PlVPHt93L06DZlm2N65dK
	 C0iLs36hfhpS/pHWNv/eBXUKrodnhmIMIt6RTkpLXY2G8nGYyFpMHJ4MfYfStOM5Wq
	 WwbA0SsB5Hp4gq+aSVUnU9gviLbFru/5tyXzX3Eo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbfFQVXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:23:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729663AbfFQVXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:23:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22EC920673;
        Mon, 17 Jun 2019 21:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560806588;
        bh=JA+p7wrGBfD3DC0g1p9qRNUiBsLsU3ExILISMxqH+iM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Zehl1di2IQktnyku2HnQAfgSISyC34D8YSfYu5t3Tl8d9SN7mXH/YIoWJYXfQ4zM
         G3W8kTH8f2LYTIR2TT4o4x0EYzljZbUAIvSvLsoNyIF6E6PBXb0tVKmtM5fT3ehCpb
         yQ8Lv0Gv87TkLH4qbm/UxQp48izm7JSao1nVLXqk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 5.1 105/115] timekeeping: Repair ktime_get_coarse*() granularity
Date:   Mon, 17 Jun 2019 23:10:05 +0200
Message-Id: <20190617210805.365201879@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617210759.929316339@linuxfoundation.org>
References: <20190617210759.929316339@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

commit e3ff9c3678b4d80e22d2557b68726174578eaf52 upstream.

Jason reported that the coarse ktime based time getters advance only once
per second and not once per tick as advertised.

The code reads only the monotonic base time, which advances once per
second. The nanoseconds are accumulated on every tick in xtime_nsec up to
a second and the regular time getters take this nanoseconds offset into
account, but the ktime_get_coarse*() implementation fails to do so.

Add the accumulated xtime_nsec value to the monotonic base time to get the
proper per tick advancing coarse tinme.

Fixes: b9ff604cff11 ("timekeeping: Add ktime_get_coarse_with_offset")
Reported-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: Sultan Alsawaf <sultan@kerneltoast.com>
Cc: Waiman Long <longman@redhat.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1906132136280.1791@nanos.tec.linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/time/timekeeping.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -807,17 +807,18 @@ ktime_t ktime_get_coarse_with_offset(enu
 	struct timekeeper *tk = &tk_core.timekeeper;
 	unsigned int seq;
 	ktime_t base, *offset = offsets[offs];
+	u64 nsecs;
 
 	WARN_ON(timekeeping_suspended);
 
 	do {
 		seq = read_seqcount_begin(&tk_core.seq);
 		base = ktime_add(tk->tkr_mono.base, *offset);
+		nsecs = tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
 
 	} while (read_seqcount_retry(&tk_core.seq, seq));
 
-	return base;
-
+	return base + nsecs;
 }
 EXPORT_SYMBOL_GPL(ktime_get_coarse_with_offset);
 


