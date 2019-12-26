Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA9AC2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 22:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D74F620828
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 22:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577398437;
	bh=90pnlG/obJZXLtPlvtggqp56usNEZuHeb/P54sr5v80=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=IMJfiPqnxpIVMaUCBMFZwkyW78yZcuFRminosNkYFPH/26dVMqGMNs1eeVydu/6Qj
	 gYFpwInO2177qhsjz9hnZ0TG8XcwCCoSDF5BLil49S/JTy2zJqZ34NrfjFQuMuPREM
	 6oQcks8V8AUEYazQih8nJmv1XSbqWvFhV04vHoCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfLZWNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 17:13:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:33846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfLZWNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 17:13:55 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4DAB20740;
        Thu, 26 Dec 2019 22:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577398434;
        bh=90pnlG/obJZXLtPlvtggqp56usNEZuHeb/P54sr5v80=;
        h=From:To:Cc:Subject:Date:From;
        b=z8i51ZYDgmGWuNGdcLm1xmTfdOWeV09OS9PNzq4VaZ+1XMp5vx0Tq72Y2Pok7hk+5
         ZRe5VmCkExDPFjAlt69RBgU0YugcjXm20wPG+OfOIsFvTdIUNdQcPCHVI4qfJrPzG3
         ohIDKdA1sPYFjFNBbVe2Ry1fOOaVPSCfhU1sQqnE=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] clk: Warn about critical clks that fail to enable
Date:   Thu, 26 Dec 2019 14:13:54 -0800
Message-Id: <20191226221354.11957-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we don't warn here users of the CLK_IS_CRITICAL flag may not know
that their clk isn't actually enabled because it silently fails to
enable. Let's drop a big WARN_ON in that case so developers find these
problems faster.

Suggested-by: Jerome Brunet <jbrunet@baylibre.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---

I suspect that this may start warning for other users. Let's see
and revert in case it doesn't work.

 drivers/clk/clk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 772258de2d1f..6a9a66dfdeaa 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3427,13 +3427,13 @@ static int __clk_core_init(struct clk_core *core)
 		unsigned long flags;
 
 		ret = clk_core_prepare(core);
-		if (ret)
+		if (WARN_ON(ret))
 			goto out;
 
 		flags = clk_enable_lock();
 		ret = clk_core_enable(core);
 		clk_enable_unlock(flags);
-		if (ret) {
+		if (WARN_ON(ret)) {
 			clk_core_unprepare(core);
 			goto out;
 		}

base-commit: 12ead77432f2ce32dea797742316d15c5800cb32
-- 
Sent by a computer, using git, on the internet

