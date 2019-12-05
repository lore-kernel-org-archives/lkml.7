Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6696AC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 00:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39B5E2077B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 00:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sysclose.org header.i=@sysclose.org header.b="EX3JyqgY";
	dkim=pass (2048-bit key) header.d=sysclose.org header.i=@sysclose.org header.b="tsIjByNP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbfLEAo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 19:44:56 -0500
Received: from smtp.sysclose.org ([69.164.214.230]:44946 "EHLO sysclose.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728011AbfLEAoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 19:44:55 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Dec 2019 19:44:55 EST
Received: by sysclose.org (Postfix, from userid 5001)
        id 455883E52; Thu,  5 Dec 2019 00:40:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 sysclose.org 455883E52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sysclose.org;
        s=201903; t=1575506411;
        bh=/CC29oPu67Q/tmNtvrlijkJ86gIb9KAxAYPLtSeV3Ds=;
        h=From:To:Cc:Subject:Date:From;
        b=EX3JyqgYnsA2SCLr8r3BkBqfLpL8BZqMoqcbG00VLlhPoWsSpLP83FTjr9WWBh++w
         R7bJx6S8MvGZreMtEC06clKGmkaU3K6yKt5capiYKtaO9/TZiFfVw/U3ZhfyVSqaop
         9iBPX1KuzKloCJkzS3KmzH1J16fScUaJWCWc3BuzBiCfCMm1jTG2Skm55Hf6GYMryC
         ZwSdSyW7gFSMOWWh64ToHnV9QhbbDIGpJWuIEkEwqsFfOme8s88TzdsYL3hYM2OR9k
         UVsKWeSiHM3Nt8xirUGjzK2TtckOtloDweBySBncZEvejnhKWEyZar3+X473edyksv
         mnqFJI2DXydvw==
Received: from localhost (unknown [45.71.104.69])
        by sysclose.org (Postfix) with ESMTPSA id 2735130A6;
        Thu,  5 Dec 2019 00:40:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 sysclose.org 2735130A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sysclose.org;
        s=201903; t=1575506409;
        bh=/CC29oPu67Q/tmNtvrlijkJ86gIb9KAxAYPLtSeV3Ds=;
        h=From:To:Cc:Subject:Date:From;
        b=tsIjByNPh6g6GQphQt/cG7qg43mVOa8wUS+rZzXZqzmS96oHfBIkumckvlHIpVrDS
         m5rneD+NOgLP1UgFVWdYWuFbGfjd0q2uHSjdsENT0rnj+udNDIkENDcytN3GvhDpXf
         OU8j+x5XBQ5sHKn5XWMEnljgFfN9HOxVmXI7pD24jb+sLPV9ogRBfFbZdS77YAMG/d
         +k4WdQAy4/nLx4pRsDUJGB/AAyOymN7YqwhW3BSn9EI6YrvTEHpQ+YqDOMdfpUY4t6
         dRFvbhu1dQJblexHFINXELljXZRtCmgrrqbECcy6o4wIJZ+bNWDVcUZsQ9If3jhftb
         WWCAAHDOFG+Iw==
From:   Flavio Leitner <fbl@sysclose.org>
To:     linux-kernel@vger.kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH] /proc/stat: fix wrong cpustat gnice value
Date:   Wed,  4 Dec 2019 21:39:36 -0300
Message-Id: <20191205003936.2635315-1-fbl@sysclose.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value being used for guest_nice should be CPUTIME_GUEST_NICE
and not CPUTIME_USER.

Fixes: 26dae145a76c "procfs: Use all-in-one vtime aware kcpustat accessor"
Signed-off-by: Flavio Leitner <fbl@sysclose.org>
---
 fs/proc/stat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 37bdbec5b402..fd931d3e77be 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -134,7 +134,7 @@ static int show_stat(struct seq_file *p, void *v)
 		softirq		+= cpustat[CPUTIME_SOFTIRQ];
 		steal		+= cpustat[CPUTIME_STEAL];
 		guest		+= cpustat[CPUTIME_GUEST];
-		guest_nice	+= cpustat[CPUTIME_USER];
+		guest_nice	+= cpustat[CPUTIME_GUEST_NICE];
 		sum		+= kstat_cpu_irqs_sum(i);
 		sum		+= arch_irq_stat_cpu(i);
 
@@ -175,7 +175,7 @@ static int show_stat(struct seq_file *p, void *v)
 		softirq		= cpustat[CPUTIME_SOFTIRQ];
 		steal		= cpustat[CPUTIME_STEAL];
 		guest		= cpustat[CPUTIME_GUEST];
-		guest_nice	= cpustat[CPUTIME_USER];
+		guest_nice	= cpustat[CPUTIME_GUEST_NICE];
 		seq_printf(p, "cpu%d", i);
 		seq_put_decimal_ull(p, " ", nsec_to_clock_t(user));
 		seq_put_decimal_ull(p, " ", nsec_to_clock_t(nice));
-- 
2.23.0

