Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDCDC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA3220673
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="scFEGd1n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfFUPiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 11:38:03 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:55159 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbfFUPhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 11:37:55 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 0bec5a0f;
        Fri, 21 Jun 2019 15:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=mail; bh=BCgOtPxwBhFl9ERxKMkR8S0mK
        lU=; b=scFEGd1ncq6oir8sEIde021C2HPhWfwq7473ZlhPnucCEzV7ylcKoG4J2
        XE9+gwK1qVAWrrlz/9Q0xnkXhq2KJid2412C2qKdL3mnmQwrBG7i4QKUq1cme9z6
        1z0lcPkkO12WxDs1jD1+OcCbbnBELzc8YvvzhpLdo2Hkce5b4LhffG5awobUUPYk
        S9JwTfNTsTQWMEDlTEjsi19IzMYIo0K6XobnNoE4gQ2fMfG2iSWt5LqrivOkRCWt
        0GilGlC9DYPqjD5rfxnLFbvTjz3f3ccoGy8graOt1EL9GsQy+2wgWDGqn7FUOAlB
        sxrYP4S3pcnEfFq4i8oYHlk/3Nvfw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5c4f79f2 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 21 Jun 2019 15:04:28 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v4 2/4] timekeeping: use proper ktime_add when adding nsecs in coarse offset
Date:   Fri, 21 Jun 2019 17:37:39 +0200
Message-Id: <20190621153741.20159-2-Jason@zx2c4.com>
In-Reply-To: <20190621153741.20159-1-Jason@zx2c4.com>
References: <20190621153741.20159-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While this doesn't actually amount to a real difference, since the macro
evaluates to the same thing, every place else operates on ktime_t using
these functions, so let's not break the pattern.

Fixes: e3ff9c3678b4 ("timekeeping: Repair ktime_get_coarse*() granularity")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/time/timekeeping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 4c97c9c8c217..db0081a14b90 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -817,7 +817,7 @@ ktime_t ktime_get_coarse_with_offset(enum tk_offsets offs)
 
 	} while (read_seqcount_retry(&tk_core.seq, seq));
 
-	return base + nsecs;
+	return ktime_add_ns(base, nsecs);
 }
 EXPORT_SYMBOL_GPL(ktime_get_coarse_with_offset);
 
-- 
2.21.0

