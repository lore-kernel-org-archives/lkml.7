Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA055C10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A8A321900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553259725;
	bh=U+rzF4brWjxPDdRj4YAso5ND0OfLGnAzH6AqnF2c44s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gVHfprGtHCEmFfyXZ5JO/bu51p/g1b+R9uomnmuzZTWppZ7vDKI/6OgLkCU0FK7GS
	 qOK9Yb6H434vCQxkCkbUiVIJJkqZNJGlDKObAR2AETRacG6TpiWm6LyKMs/57cgCYJ
	 AEs6wzmPui4F6xICJgYvQLHIQb2PUXAfeYyo3N5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731522AbfCVLmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:42:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731511AbfCVLmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:42:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEF592195D;
        Fri, 22 Mar 2019 11:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254939;
        bh=U+rzF4brWjxPDdRj4YAso5ND0OfLGnAzH6AqnF2c44s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NEj1VD1JwiocbgBFkpJuUt1XDL29y2BVjS6tygbOyjSb8znepGH2s2uWlv6mIAuwK
         DorI9dX9N2NkG1zLrX5i/504VZg/iJeUMOIlPT8YvTAJ2kWJcGlQwVUOeA5g2kcd0a
         3j6/KKesH91/ltqn14wQOkwEly4WUlIaOV5MlHi4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Stuart Menefy <stuart.menefy@mathembedded.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 4.9 057/118] clocksource/drivers/exynos_mct: Move one-shot check from tick clear to ISR
Date:   Fri, 22 Mar 2019 12:15:29 +0100
Message-Id: <20190322111220.517969764@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
References: <20190322111215.873964544@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stuart Menefy <stuart.menefy@mathembedded.com>

commit a5719a40aef956ba704f2aa1c7b977224d60fa96 upstream.

When a timer tick occurs and the clock is in one-shot mode, the timer
needs to be stopped to prevent it triggering subsequent interrupts.
Currently this code is in exynos4_mct_tick_clear(), but as it is
only needed when an ISR occurs move it into exynos4_mct_tick_isr(),
leaving exynos4_mct_tick_clear() just doing what its name suggests it
should.

Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: stable@vger.kernel.org # v4.3+
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clocksource/exynos_mct.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -388,6 +388,13 @@ static void exynos4_mct_tick_start(unsig
 	exynos4_mct_write(tmp, mevt->base + MCT_L_TCON_OFFSET);
 }
 
+static void exynos4_mct_tick_clear(struct mct_clock_event_device *mevt)
+{
+	/* Clear the MCT tick interrupt */
+	if (readl_relaxed(reg_base + mevt->base + MCT_L_INT_CSTAT_OFFSET) & 1)
+		exynos4_mct_write(0x1, mevt->base + MCT_L_INT_CSTAT_OFFSET);
+}
+
 static int exynos4_tick_set_next_event(unsigned long cycles,
 				       struct clock_event_device *evt)
 {
@@ -420,8 +427,11 @@ static int set_state_periodic(struct clo
 	return 0;
 }
 
-static void exynos4_mct_tick_clear(struct mct_clock_event_device *mevt)
+static irqreturn_t exynos4_mct_tick_isr(int irq, void *dev_id)
 {
+	struct mct_clock_event_device *mevt = dev_id;
+	struct clock_event_device *evt = &mevt->evt;
+
 	/*
 	 * This is for supporting oneshot mode.
 	 * Mct would generate interrupt periodically
@@ -430,16 +440,6 @@ static void exynos4_mct_tick_clear(struc
 	if (!clockevent_state_periodic(&mevt->evt))
 		exynos4_mct_tick_stop(mevt);
 
-	/* Clear the MCT tick interrupt */
-	if (readl_relaxed(reg_base + mevt->base + MCT_L_INT_CSTAT_OFFSET) & 1)
-		exynos4_mct_write(0x1, mevt->base + MCT_L_INT_CSTAT_OFFSET);
-}
-
-static irqreturn_t exynos4_mct_tick_isr(int irq, void *dev_id)
-{
-	struct mct_clock_event_device *mevt = dev_id;
-	struct clock_event_device *evt = &mevt->evt;
-
 	exynos4_mct_tick_clear(mevt);
 
 	evt->event_handler(evt);


