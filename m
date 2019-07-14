Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C8EC74A4B
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 21:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F010920C01
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 21:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="nS5j/U1P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbfGNV5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 17:57:30 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:49526 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbfGNV5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 17:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1563141447; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=dPOm8I730gA/0sINnA0L6oohypk1gj9aTrJkuB11/84=;
        b=nS5j/U1Pdw4Qlbv6XPY5FD4tctE2+SBQ1gAR1urnVp7eYcISwPFqK/b6OSr+c2NTPShYE5
        Ddo73wZm2Xc3EMsjt4vFrIy/KwTWxcXDm9myCFUxpfd7HX4oYWdMeODpqNNho70DoSnEUp
        Am+DoF31Wh8jnmqe4+zy6nsOJ9iMX+0=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     od@zcrc.me, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] clk: ingenic: Remove OF_POPULATED flag to probe children
Date:   Sun, 14 Jul 2019 17:57:15 -0400
Message-Id: <20190714215715.11412-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the OF_POPULATED flag, in order to probe children when the
device node is compatible with "simple-mfd".

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/clk/ingenic/cgu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
index 6e963031cd87..bf2a86cf1dbf 100644
--- a/drivers/clk/ingenic/cgu.c
+++ b/drivers/clk/ingenic/cgu.c
@@ -759,6 +759,12 @@ ingenic_cgu_new(const struct ingenic_cgu_clk_info *clock_info,
 
 	spin_lock_init(&cgu->lock);
 
+	/*
+	 * Remove the OF_POPULATED flag, in order to probe children when the
+	 * device node is compatible with "simple-mfd".
+	 */
+	of_node_clear_flag(np, OF_POPULATED);
+
 	return cgu;
 
 err_out_free:
-- 
2.21.0.593.g511ec345e18

