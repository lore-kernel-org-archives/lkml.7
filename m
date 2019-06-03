Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052DFC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6DC272B3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbfFCN37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:29:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50034 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728559AbfFCN36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:29:58 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 60661C05D3E4;
        Mon,  3 Jun 2019 13:29:58 +0000 (UTC)
Received: from xz-x1.redhat.com (ovpn-12-86.pek2.redhat.com [10.72.12.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0BF821001DE4;
        Mon,  3 Jun 2019 13:29:50 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH] timers: Fix up get_target_base() to use old base properly
Date:   Mon,  3 Jun 2019 21:29:44 +0800
Message-Id: <20190603132944.9726-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 03 Jun 2019 13:29:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_target_base() in the timer code is not using the "base" parameter
at all.  My gut feeling is that instead of removing that extra
parameter, what we really want to do is "return the old base if it
does not suite for a new one".

CC: Thomas Gleixner <tglx@linutronix.de>
CC: John Stultz <john.stultz@linaro.org>
CC: Stephen Boyd <sboyd@kernel.org>
CC: Luiz Capitulino <lcapitulino@redhat.com>
CC: Marcelo Tosatti <mtosatti@redhat.com>
CC: linux-kernel@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 kernel/time/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 343c7ba33b1c..6ff6ffd2c719 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -868,7 +868,7 @@ get_target_base(struct timer_base *base, unsigned tflags)
 	    !(tflags & TIMER_PINNED))
 		return get_timer_cpu_base(tflags, get_nohz_timer_target());
 #endif
-	return get_timer_this_cpu_base(tflags);
+	return base;
 }
 
 static inline void forward_timer_base(struct timer_base *base)
-- 
2.17.1

