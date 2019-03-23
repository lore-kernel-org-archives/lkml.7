Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F86C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 17:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6C920879
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 17:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbfCWRZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 13:25:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:53313 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727440AbfCWRZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 13:25:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Mar 2019 10:25:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="128030843"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 23 Mar 2019 10:25:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 10C5147; Sat, 23 Mar 2019 19:25:33 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Ray Jui <rjui@broadcom.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] lib/math: Move int_pow() from pwm_bl.c for wider use
Date:   Sat, 23 Mar 2019 20:25:31 +0300
Message-Id: <20190323172531.80025-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190323172531.80025-1-andriy.shevchenko@linux.intel.com>
References: <20190323172531.80025-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The integer exponentiation is used in few places and might be used
in the future by other call sites. Move it to wider use.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/video/backlight/pwm_bl.c | 15 ---------------
 include/linux/kernel.h           |  1 +
 lib/math/Makefile                |  2 +-
 lib/math/int_pow.c               | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 34 insertions(+), 16 deletions(-)
 create mode 100644 lib/math/int_pow.c

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 53b8ceea9bde..fb45f866b923 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -155,21 +155,6 @@ static const struct backlight_ops pwm_backlight_ops = {
 #ifdef CONFIG_OF
 #define PWM_LUMINANCE_SCALE	10000 /* luminance scale */
 
-/* An integer based power function */
-static u64 int_pow(u64 base, int exp)
-{
-	u64 result = 1;
-
-	while (exp) {
-		if (exp & 1)
-			result *= base;
-		exp >>= 1;
-		base *= base;
-	}
-
-	return result;
-}
-
 /*
  * CIE lightness to PWM conversion.
  *
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index bb8958690b69..d327fe835f2c 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -500,6 +500,7 @@ extern int __kernel_text_address(unsigned long addr);
 extern int kernel_text_address(unsigned long addr);
 extern int func_ptr_is_kernel_text(void *ptr);
 
+u64 int_pow(u64 base, unsigned int exp);
 unsigned long int_sqrt(unsigned long);
 
 #if BITS_PER_LONG < 64
diff --git a/lib/math/Makefile b/lib/math/Makefile
index b75878420da6..583bbfebfc09 100644
--- a/lib/math/Makefile
+++ b/lib/math/Makefile
@@ -1,4 +1,4 @@
-obj-y += div64.o gcd.o lcm.o int_sqrt.o reciprocal_div.o
+obj-y += div64.o gcd.o lcm.o int_pow.o int_sqrt.o reciprocal_div.o
 
 obj-$(CONFIG_CORDIC)		+= cordic.o
 obj-$(CONFIG_PRIME_NUMBERS)	+= prime_numbers.o
diff --git a/lib/math/int_pow.c b/lib/math/int_pow.c
new file mode 100644
index 000000000000..622fc1ab3c74
--- /dev/null
+++ b/lib/math/int_pow.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * An integer based power function
+ *
+ * Derived from drivers/video/backlight/pwm_bl.c
+ */
+
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+/**
+ * int_pow - computes the exponentiation of the given base and exponent
+ * @base: base which will be raised to the given power
+ * @exp: power to be raised to
+ *
+ * Computes: pow(base, exp), i.e. @base raised to the @exp power
+ */
+u64 int_pow(u64 base, unsigned int exp)
+{
+	u64 result = 1;
+
+	while (exp) {
+		if (exp & 1)
+			result *= base;
+		exp >>= 1;
+		base *= base;
+	}
+
+	return result;
+}
+EXPORT_SYMBOL_GPL(int_pow);
-- 
2.20.1

