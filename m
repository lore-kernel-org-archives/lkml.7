Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888DEFC6197
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6557620674
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731911AbfKHUfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 15:35:34 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:46863 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfKHUfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 15:35:34 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M890H-1iXpoO1zD1-005LFy; Fri, 08 Nov 2019 21:35:23 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH 2/8] timekeeping: optimize ns_to_timespec64
Date:   Fri,  8 Nov 2019 21:34:25 +0100
Message-Id: <20191108203435.112759-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191108203435.112759-1-arnd@arndb.de>
References: <20191108203435.112759-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:p1S8Vm5S9mOTgTtbXxcpOxF1EXzFZzdK9j2/O1Ee3fyzg6An3tR
 lBZ66pgI6iZBdXJ54mOxMj2nung87BghhEiWfxdG2ow0YQZe3LBxlQHQnjDZSxBjyPP6tsx
 bfA1fPNf8Y/POpr6MTYVPhxSUZOUYGbIQoes/LWQ9akDbcZ0iPTgN3lULhrc1E8aUwlXJcD
 AIBfjtmvDO9y5gP5/i1Cw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JDO+ITcPMoo=:KOb3c4dgHZm81zl2vb18eF
 pWebkyKHxGEifiJWZ54rdWO4EDw6xCHtWkieKB+x9+7D8OmHsVfjvpETrYQo2wUdAaE0h1h4+
 T3+uLnkIkn8wzgp1MBhgy3BtZeAZevrpFrOLa9ymq7Z3Y99Lw1q5dW0OHip+eQCXlsnsBeFlH
 yTyW9a1FcIopKY5/zJ7SLS6l1CGA/1Y998Zt8dwvZcZYml2lX4lbi5dxrUiAOo6u2u9e82MEg
 tjY2bZRJuW5F1nGc4q42bxLjo8cJvir56AzHSTuHq1XlPERNu7iaQ4tdBSNx4J4SIkwryAgpU
 2cwHhCGxgVwwUfFRwi3XnVA9PSaz8xSEGT7NV6rdZF8+ljVrwb6zwis5Q74WN3EcPbqpyFfH5
 QafBvgDWytSz/Yz0kNvhi2zOb32YQul2P4/tvNRxuWvYPwHg0QFaxPjmCVV66ZEJQPjlFN3w7
 9TjH0JFkW1xK6IJ3jo9ceK5oPk30o8Rlww+3GNPmAVWKrnsJmGOcwbquhV4hsl8PSG75KwGL2
 cZ9sAynyBuBuxxylD0UoPCZYtwDPWgpvNT0xyh2SSWYimErGmmou0gB405flo+sxy3r8b0F+C
 3ebXI8xwQRI85xU7NzPN0kVqiKIoYJG5HG7AD3lsRJ5LFRLJ3lScJZlQee69Fd40hBZYariIS
 ufxBamy4nk5xIjnf3Xx4iuHQDoTcYpcFM5LYYRmgk9Cc3F9T+FMfetnIf5EBA/llIjoJSx2mn
 wKx4qlGfFdKr7qy/zBQ+x/mLHhPmupOBOEcaZqCiaq0SBvr8YVTjaBYpjxAFQARuNRyGF4DRk
 NkKFlRRjatiBtoBOQsS1ta16lpSGOxoTm+AFIERp8O+8nHI6DSSACAYjUWZzy3lhltKMIVVWv
 +Ff45mQWVHAVLgeUCWOQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that ns_to_timespec64() calls div_s64_rem(), which is
a rather slow function on 32-bit architectures, as it cannot take
advantage of the do_div() optimizations for constant arguments.

This open-codes the div_s64_rem() function here, so we can pass
a constant divider into the optimized div_u64_rem() function.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/time/time.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/kernel/time/time.c b/kernel/time/time.c
index 5c54ca632d08..45a358953f09 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -550,18 +550,21 @@ EXPORT_SYMBOL(set_normalized_timespec64);
  */
 struct timespec64 ns_to_timespec64(const s64 nsec)
 {
-	struct timespec64 ts;
+	struct timespec64 ts = { 0, 0 };
 	s32 rem;
 
-	if (!nsec)
-		return (struct timespec64) {0, 0};
-
-	ts.tv_sec = div_s64_rem(nsec, NSEC_PER_SEC, &rem);
-	if (unlikely(rem < 0)) {
-		ts.tv_sec--;
-		rem += NSEC_PER_SEC;
+	if (likely(nsec > 0)) {
+		ts.tv_sec = div_u64_rem(nsec, NSEC_PER_SEC, &rem);
+		ts.tv_nsec = rem;
+	} else if (nsec < 0) {
+		/*
+		 * With negative times, tv_sec points to the earlier
+		 * second, and tv_nsec counts the nanoseconds since
+		 * then, so tv_nsec is always a positive number.
+		 */
+		ts.tv_sec = -div_u64_rem(-nsec - 1, NSEC_PER_SEC, &rem) - 1;
+		ts.tv_nsec = NSEC_PER_SEC - rem - 1;
 	}
-	ts.tv_nsec = rem;
 
 	return ts;
 }
-- 
2.20.0

