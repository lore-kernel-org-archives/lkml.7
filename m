Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D47C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 22:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC4B2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 22:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfDBWBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 18:01:16 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:59730 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfDBWBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 18:01:16 -0400
Received: from cpe-2606-a000-111b-405a-9816-2c85-c514-8f7a.dyn6.twc.com ([2606:a000:111b:405a:9816:2c85:c514:8f7a] helo=localhost)
        by smtp.tuxdriver.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.63)
        (envelope-from <nhorman@tuxdriver.com>)
        id 1hBRSs-0000uC-PW; Tue, 02 Apr 2019 18:01:12 -0400
From:   Neil Horman <nhorman@tuxdriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     Neil Horman <nhorman@tuxdriver.com>,
        Steve Grubb <sgrubb@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] Fix xoring of arch_get_random_long into crng->state array
Date:   Tue,  2 Apr 2019 18:00:25 -0400
Message-Id: <20190402220025.14499-1-nhorman@tuxdriver.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When _crng_extract is called, any arch that has a registered
arch_get_random_long method, attempts to mix an unsigned long value into
the crng->state buffer, it only mixes in 32 of the 64 bits available,
because the state buffer is an array of u32 values, even though 2 u32
are expected to be filled (owing to the fact that it expects indexes 14
and 15 to be filled).

Bring the expected behavior into alignment by casting index 14 to an
unsignled long pointer, and xoring that in instead.

Tested successfully by myself

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
Reported-by: Steve Grubb <sgrubb@redhat.com>
CC: "Theodore Ts'o" <tytso@mit.edu>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/random.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 38c6d1af6d1c..8178618458ac 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -975,14 +975,16 @@ static void _extract_crng(struct crng_state *crng,
 			  __u8 out[CHACHA_BLOCK_SIZE])
 {
 	unsigned long v, flags;
-
+	unsigned long *archrnd;
 	if (crng_ready() &&
 	    (time_after(crng_global_init_time, crng->init_time) ||
 	     time_after(jiffies, crng->init_time + CRNG_RESEED_INTERVAL)))
 		crng_reseed(crng, crng == &primary_crng ? &input_pool : NULL);
 	spin_lock_irqsave(&crng->lock, flags);
-	if (arch_get_random_long(&v))
-		crng->state[14] ^= v;
+	if (arch_get_random_long(&v)) {
+		archrnd = (unsigned long *)&crng->state[14];
+		*archrnd ^= v;
+	}
 	chacha20_block(&crng->state[0], out);
 	if (crng->state[12] == 0)
 		crng->state[13]++;
-- 
2.20.1

