Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595EBC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB95205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="xsjryigW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfFUPFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 11:05:52 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:40599 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfFUPFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 11:05:52 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 651ff04c;
        Fri, 21 Jun 2019 14:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=mail; bh=wgxcqaEpc5Cj5n/ndmwgTvDT9
        vE=; b=xsjryigWlVcK7sXgiP7ABxtgCzBywMndAJEObIT0im2mXSZoVUElKWONH
        Relzk/vH/vyxoq8a43Fn6zMCXaq4X5tpMGh+/uJAKo+k3Ec1aRMOtvZaHGMaxQ2b
        mXTR+rtwjWjjQlXN7MCmfxY1IHAJgpujOXtSTZjMSeXznVjZXwFNPcBpeYElL6s2
        VJSAxUmJfJvwn10BGF3Tv6W9NdhM/lrYcaHeZ+t4Q37IZtmlMTCoWDdntiohZtZw
        JFStW3qhNpmUSCP9PFk12DjiVXdYhfm+LSXsfkjhYwd9dKYlNMKA4fcjOoqZFftE
        rKUR3ylQS8MUtfRfvoUQQs9eXfodg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 83a3c10e (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 21 Jun 2019 14:32:25 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3 3/4] timekeeping: add missing _ns functions for coarse accessors
Date:   Fri, 21 Jun 2019 17:05:20 +0200
Message-Id: <20190621150521.17687-3-Jason@zx2c4.com>
In-Reply-To: <20190621150521.17687-1-Jason@zx2c4.com>
References: <20190621150521.17687-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This further unifies the accessors for the fast and coarse functions, so
that the same types of functions are available for each. There was also
a bit of confusion with the documentation, which prior advertised a
function that has never existed. Finally, the vanilla ktime_get_coarse()
was omitted from the API originally, so this fills this oversight.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 Documentation/core-api/timekeeping.rst | 10 +++++++---
 include/linux/timekeeping.h            | 27 ++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/Documentation/core-api/timekeeping.rst b/Documentation/core-api/timekeeping.rst
index 47b41e948459..0d4019fcaa87 100644
--- a/Documentation/core-api/timekeeping.rst
+++ b/Documentation/core-api/timekeeping.rst
@@ -99,16 +99,20 @@ Coarse and fast access
 
 Some additional variants exist for more specialized cases:
 
-.. c:function:: ktime_t ktime_get_coarse_boottime( void )
+.. c:function:: ktime_t ktime_get_coarse( void )
+		ktime_t ktime_get_coarse_boottime( void )
 		ktime_t ktime_get_coarse_real( void )
 		ktime_t ktime_get_coarse_clocktai( void )
-		ktime_t ktime_get_coarse_raw( void )
+
+.. c:function:: u64 ktime_get_coarse_ns( void )
+		u64 ktime_get_boot_coarse_ns( void )
+		u64 ktime_get_real_coarse_ns( void )
+		u64 ktime_get_tai_coarse_ns( void )
 
 .. c:function:: void ktime_get_coarse_ts64( struct timespec64 * )
 		void ktime_get_coarse_boottime_ts64( struct timespec64 * )
 		void ktime_get_coarse_real_ts64( struct timespec64 * )
 		void ktime_get_coarse_clocktai_ts64( struct timespec64 * )
-		void ktime_get_coarse_raw_ts64( struct timespec64 * )
 
 	These are quicker than the non-coarse versions, but less accurate,
 	corresponding to CLOCK_MONONOTNIC_COARSE and CLOCK_REALTIME_COARSE
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index c5d360779fab..3df8e63c704b 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -113,6 +113,33 @@ static inline ktime_t ktime_get_coarse_clocktai(void)
 	return ktime_get_coarse_with_offset(TK_OFFS_TAI);
 }
 
+static inline ktime_t ktime_get_coarse(void)
+{
+	struct timespec64 ts;
+	ktime_get_coarse_ts64(&ts);
+	return timespec64_to_ktime(ts);
+}
+
+static inline u64 ktime_get_coarse_ns(void)
+{
+	return ktime_to_ns(ktime_get_coarse());
+}
+
+static inline u64 ktime_get_real_coarse_ns(void)
+{
+	return ktime_to_ns(ktime_get_coarse_real());
+}
+
+static inline u64 ktime_get_boot_coarse_ns(void)
+{
+	return ktime_to_ns(ktime_get_coarse_boottime());
+}
+
+static inline u64 ktime_get_tai_coarse_ns(void)
+{
+	return ktime_to_ns(ktime_get_coarse_clocktai());
+}
+
 /**
  * ktime_mono_to_real - Convert monotonic time to clock realtime
  */
-- 
2.21.0

