Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB029C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D042208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="YYYfzH1Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732416AbfFLM3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:29:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43111 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbfFLM3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:29:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5CCT5LP685282
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 12 Jun 2019 05:29:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5CCT5LP685282
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560342546;
        bh=EzlFuzgzk7utdYQPDK7adJsHAl+Zhv92on0+5cRVOts=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=YYYfzH1ZJWatgO8mUijXWZeyv0SFJEL1VDK6dYM+tHot6NJmXyZY4T8JdExJLdq3B
         wGh1Hh+5baVtd+17HLmBX8mb1eAYZUJ01k1fVFYTWcB23E5IdQgEFvZlUOGfcE1JcA
         FRoVlKcgZkpAAjIWCzxy8xhy+c7rndLsvuVE1KR7lMOo8vUY7Y8Dr+aH4h4yr4PIJD
         btTunDAhrVAYpDk5w8WGUhFUBSv3rbTzPk4X6HVo2dYSYIyw2tNO9JtIbIjybZ51Sv
         YB0X0Eh5FFDLYS3vkTdk1gLqMfzbjxONPnMHZ2A8Syx93216032/5Ggfu3Ru2cNJH0
         z1tDe79xtwoGQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5CCT5Xe685279;
        Wed, 12 Jun 2019 05:29:05 -0700
Date:   Wed, 12 Jun 2019 05:29:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Daniel Lezcano <tipbot@zytor.com>
Message-ID: <tip-3c2e79f4cef7938125b356e7f5c8fd038212619a@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com
Reply-To: mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org
In-Reply-To: <20190527205521.12091-4-daniel.lezcano@linaro.org>
References: <20190527205521.12091-4-daniel.lezcano@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq/timings: Optimize the period detection speed
Git-Commit-ID: 3c2e79f4cef7938125b356e7f5c8fd038212619a
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

Commit-ID:  3c2e79f4cef7938125b356e7f5c8fd038212619a
Gitweb:     https://git.kernel.org/tip/3c2e79f4cef7938125b356e7f5c8fd038212619a
Author:     Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate: Mon, 27 May 2019 22:55:16 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 12 Jun 2019 10:47:03 +0200

genirq/timings: Optimize the period detection speed

With a minimal period and if there is a period which is a multiple of it
but lesser than the max period then it will be detected before and the
minimal period will be never reached.

 1 2 1 2 1 2 1 2 1 2 1 2
 <-----> <-----> <----->
 <-> <-> <-> <-> <-> <->

In that case, the minimum period is 2 and the maximum period is 5. That
means all repeating pattern of 2 will be detected as repeating pattern of
4, it is pointless to go up to 2 when searching for the period as it will
always fail.

Remove one loop iteration by increasing the minimal period to 3.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: andriy.shevchenko@linux.intel.com
Link: https://lkml.kernel.org/r/20190527205521.12091-4-daniel.lezcano@linaro.org

---
 kernel/irq/timings.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
index 19d2fad379ee..1d1c411d4cae 100644
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -261,7 +261,7 @@ void irq_timings_disable(void)
 #define EMA_ALPHA_VAL		64
 #define EMA_ALPHA_SHIFT		7
 
-#define PREDICTION_PERIOD_MIN	2
+#define PREDICTION_PERIOD_MIN	3
 #define PREDICTION_PERIOD_MAX	5
 #define PREDICTION_FACTOR	4
 #define PREDICTION_MAX		10 /* 2 ^ PREDICTION_MAX useconds */
