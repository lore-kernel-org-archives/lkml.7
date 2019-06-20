Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE35C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65EB4206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hbhNRQit"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732172AbfFTOMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 10:12:34 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:46513 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbfFTOMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 10:12:31 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id c9fd27a9;
        Thu, 20 Jun 2019 13:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=mail; bh=0Fdw7HaeEiZuqMq3Bs3OcHBPs
        N0=; b=hbhNRQitEi35VPDhVdSARikBsNjSpCOZKRHHkg/49LlfcVyv8LE14FOzU
        ChmQ8BRHTOOyigdk/yC8uOBmd0EhyF9a+duR4yMv+c6mA59r1FaZWw1iDJ+9/+Fl
        KZthbGFb6PC32d4B/AG0ZW4jDN7cEwLNTQ9gL8G/YGFDtavPRsM6JEoUdtSVDL0Q
        hmKsb/s2VmllMwc3D1t1SCE5YMlHSy2uJCGw5uFJIOViXWGB/Z7KfyiPccJ/mAHh
        yaHHbZh6JYEyb0QtvjHLPW/V/cUczO8kQzh9Yt0fTea+qYJJc0gO3G7KeX1X/D8c
        185/RebJKwBYvfdeXsnyrpkOW+WYQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2e56fd00 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Thu, 20 Jun 2019 13:39:13 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 3/3] timekeeping: add missing _ns functions for coarse accessors
Date:   Thu, 20 Jun 2019 16:11:59 +0200
Message-Id: <20190620141159.15965-3-Jason@zx2c4.com>
In-Reply-To: <20190620141159.15965-1-Jason@zx2c4.com>
References: <CAHmME9pyf1AmjWOFFdJFXV9-OBv-ChpKZ130733+x=BtjF62mA@mail.gmail.com>
 <20190620141159.15965-1-Jason@zx2c4.com>
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
index ad32085174f8..d5e88f0e06a4 100644
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

