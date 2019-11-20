Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77751C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5609E22444
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbfKTL7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 06:59:34 -0500
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:53924 "EHLO
        esa2.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbfKTL7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 06:59:32 -0500
IronPort-SDR: E3dYoa1GHc7rqqdB9HvFfpACp5dIPsiN9UajUTrm/C/wikvnLbb19j8WDLfzaYb7HDFjvmeTZW
 hH5LrHMW4ys6/BS2g6XYXneMj17OmU3FYCQbod0+ptHsjTvrNdDFxF8Cnux2TO0fqPXI7FyxF9
 yzUz4S9vs7MMikw0XkEHW2tpgviyjDhEsVLzwCAyn6k2auDHN2aC6aOQsNxs56acAF67BzC9ir
 5bAFzeIkOD0B6dOO4+1FP6L46hfnFQtp0xlhxg2pigA0ol1tM4zuTYjPMA9cA9N4Q9onJi2bAC
 EKo=
X-IronPort-AV: E=Sophos;i="5.69,221,1571731200"; 
   d="scan'208";a="43282926"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa2.mentor.iphmx.com with ESMTP; 20 Nov 2019 03:59:31 -0800
IronPort-SDR: 7yMYWojQMMkoRD8ElqrDdLnDTuAyTtWTooEofI/KqCiQxKMmESwrwHe0hlXGV/RqDX6LDrMTQz
 k75VSt+DODR6olCbVbr4FZ7lWUYZKwU7HGXiHSoE2BoamoOB/lDxbfwhXjqxrmMNWYDVhQCFBS
 7hLRoeT2ImPlzz0/66c8cmrefBMUgjxQ7bR0NBjuv6fHfnUWYWSNcruC6a6+NLxJRn81H3I0SX
 987ZC1IfiNSay7sy454QvJeZmCmr/4Kwsdzz7EMv8d0VvnkX9BJGbHiOHigHVMW/4dOOGaa2/C
 M+A=
From:   Andrew Gabbasov <andrew_gabbasov@mentor.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Timo Wischer <twischer@de.adit-jv.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH v4 1/7] ALSA: aloop: Describe units of variables
Date:   Wed, 20 Nov 2019 05:58:50 -0600
Message-ID: <20191120115856.4125-2-andrew_gabbasov@mentor.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191120115856.4125-1-andrew_gabbasov@mentor.com>
References: <20191120115856.4125-1-andrew_gabbasov@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Timo Wischer <twischer@de.adit-jv.com>

Describe the unit of the variables used to calculate the hw pointer
depending on jiffies ticks.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
---
 sound/drivers/aloop.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 54f8b17476a1..573b06cf7cf5 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -102,8 +102,10 @@ struct loopback_pcm {
 	/* flags */
 	unsigned int period_update_pending :1;
 	/* timer stuff */
-	unsigned int irq_pos;		/* fractional IRQ position */
-	unsigned int period_size_frac;
+	unsigned int irq_pos;		/* fractional IRQ position in jiffies
+					 * ticks
+					 */
+	unsigned int period_size_frac;	/* period size in jiffies ticks */
 	unsigned int last_drift;
 	unsigned long last_jiffies;
 	struct timer_list timer;
-- 
2.21.0

