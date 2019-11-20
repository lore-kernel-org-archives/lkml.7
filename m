Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6507C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B512F206CC
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbfKTRut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:50:49 -0500
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:24604 "EHLO
        esa4.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbfKTRut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:50:49 -0500
IronPort-SDR: +wDC2CP+eM40tAwIr/wNoZWQYqSy+4tvcaxEAG4LQpSR5y90cn58biYEP7/6+IZCp4xFBkvmaS
 nM0ihcMF+XrN6BJHkB03A8FytuH1bFVsa3JD3G8y8sp2goN2IfGXTJ54oG9WB8qaVpPYpYI9Me
 PSvwOqwYkZEn2LACsMkpdwX8PM9jE8SUm9vFYKqFt+ek6gvzz7OYPvzBcV8GC4uQUGZKpf8yRW
 MUMfcU6n2Xl2tamL31b9lW4qD6tMQhdsueJY23mSp+7AjQ4iwDcFMjGN2n5Ha7Z5Bo2G9Xe11L
 XEc=
X-IronPort-AV: E=Sophos;i="5.69,222,1571731200"; 
   d="scan'208";a="43396802"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa4.mentor.iphmx.com with ESMTP; 20 Nov 2019 09:50:48 -0800
IronPort-SDR: qKUm6jxbPObVT9NCkSbPHyK0doNKfHXiPrtKIfFJrofr8o/eIDmDM/hgMve1PbXImAviiOb0yD
 ZZI9B0lSa/3cSDauxLv8Ph072jGC2SeMWlgHEK6p21bVxtyg9YhH6jtYAr3cly3vaqeTKxm7h0
 JJFwPcjgPipN9yfZPix4X+LmCc0GcZ60sDRT6L/ux7jsxGYUYygOD10qA0eHRju84jBQcsUlsF
 RPRuR4ad2AWZT+rTCSoSkzJnlV+p8S7kMJwSACgVUDrgkqbOmUwTPU7d27r6RfNHWbhosbnqae
 wsU=
From:   Andrew Gabbasov <andrew_gabbasov@mentor.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Timo Wischer <twischer@de.adit-jv.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH v5 1/7] ALSA: aloop: Describe units of variables
Date:   Wed, 20 Nov 2019 11:49:49 -0600
Message-ID: <20191120174955.6410-2-andrew_gabbasov@mentor.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191120174955.6410-1-andrew_gabbasov@mentor.com>
References: <20191120174955.6410-1-andrew_gabbasov@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
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

