Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54900C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B1E206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GB2hYv37"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732164AbfFTOMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 10:12:31 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:46513 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbfFTOMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 10:12:30 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 6070bff6;
        Thu, 20 Jun 2019 13:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=mail; bh=59+R4/Fx/t8SyqprWAb/cnYmq
        hU=; b=GB2hYv37Ue9iey2fY1DbB5LsOHqqz0ANLpJt42JcEZSVrEwehdSKuLPJg
        FWrKqI4tPX7/Is8WAMF6inDpNj4JIphdUl9hynwbwcLk+rSLuDqO6qCayt/n0/kA
        HFt+tZgVK5qRCTLzzk8+f2fa0h/6/5QBCG77gjaQVynyuo3rlzB8SzJv431MDUUv
        DrsQhfNWcliCGJo6loT4O9PD+vwSvsoVQkBJhJ1OiJ/uYOfYNTaQgvTfDnoDZMII
        u+3jyEVz8awx400YNIMtg5Ov51sril7HNcrnYhMDwaN0/lulvdU5V9pLOhD7cfB3
        +0+Xx0HQVrrONA5yS8Wt4EHhT0b8w==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ec5a4d62 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Thu, 20 Jun 2019 13:39:11 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 2/3] timekeeping: use proper ktime_add when adding nsecs in coarse offset
Date:   Thu, 20 Jun 2019 16:11:58 +0200
Message-Id: <20190620141159.15965-2-Jason@zx2c4.com>
In-Reply-To: <20190620141159.15965-1-Jason@zx2c4.com>
References: <CAHmME9pyf1AmjWOFFdJFXV9-OBv-ChpKZ130733+x=BtjF62mA@mail.gmail.com>
 <20190620141159.15965-1-Jason@zx2c4.com>
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

