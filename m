Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDB3C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B46320665
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="H1eCY9lx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbfFXJQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:16:01 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:53757 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbfFXJQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:16:00 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 040f07c6;
        Mon, 24 Jun 2019 08:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=mail; bh=q1U9OoSlHv9k61z1xQoaw0awhSk=; b=H1eCY9lx/QIj93Jb95VZ
        XpDRIx96Q3LNl8F/mXhcuSYVGj0Hi9RnCaAIl1erhkES8PN7MIM5yitIMdpZWK0O
        JTyyb6tGtid7EZrFx5eDAuXm0dQZ/D3KJV94glNTk61QR99n/MzbqtZ17aCCDaA1
        HfbQMj52n+TBVf9zAptYcBr9OeKAHDCmRMlXoogSZ1QXbb5A0IavVOuG502LPFHF
        pqmNRf9csBreN2dAbPFtIuYtpohXM1HxwiJlOYUt5+BgMZPfcKb4NiH97HzAPxlO
        vOQoDSyCoNY0yvrN5uhM7/7kLl/cgd4lO7VKLe+iId2ekNZjWy4LWFhL0yFA9wO0
        mg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d9dba3fd (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Mon, 24 Jun 2019 08:42:12 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] timekeeping: boot should be boottime for coarse ns accessor
Date:   Mon, 24 Jun 2019 11:15:39 +0200
Message-Id: <20190624091539.13512-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Somewhere in all the patchsets before, this cleanup got lost.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 Documentation/core-api/timekeeping.rst | 2 +-
 include/linux/timekeeping.h            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/core-api/timekeeping.rst b/Documentation/core-api/timekeeping.rst
index 15fc58e85ef9..20ee447a50f3 100644
--- a/Documentation/core-api/timekeeping.rst
+++ b/Documentation/core-api/timekeeping.rst
@@ -105,7 +105,7 @@ Some additional variants exist for more specialized cases:
 		ktime_t ktime_get_coarse_clocktai( void )
 
 .. c:function:: u64 ktime_get_coarse_ns( void )
-		u64 ktime_get_coarse_boot_ns( void )
+		u64 ktime_get_coarse_boottime_ns( void )
 		u64 ktime_get_coarse_real_ns( void )
 		u64 ktime_get_coarse_clocktai_ns( void )
 
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 1435d928fcbf..edbc5f4d7ea3 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -130,7 +130,7 @@ static inline u64 ktime_get_coarse_real_ns(void)
 	return ktime_to_ns(ktime_get_coarse_real());
 }
 
-static inline u64 ktime_get_coarse_boot_ns(void)
+static inline u64 ktime_get_coarse_boottime_ns(void)
 {
 	return ktime_to_ns(ktime_get_coarse_boottime());
 }
-- 
2.21.0

