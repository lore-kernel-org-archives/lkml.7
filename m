Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F5FC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752922084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554246086;
	bh=ika+YHmoT4jAgJRbgCbCoU1jdSzMtuxcYEI3U6nSG5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ODW6n9xEzqXO9ICag7ji+/FwjheXzzZt/MkMquc1gDM4LTMVt+Oq3avotJx+FMV/7
	 KY32Uh9Jb+mpbDq5d+oAxY+RnbLY02gQEFVQqZP2ZkrL5YZDXe65YEin1x9tiYqv66
	 OD6WmpLDsVT+tBRMJBvszSjFoXDKptlwTwEvDj7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfDBXBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 19:01:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbfDBXBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 19:01:07 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 765022146E;
        Tue,  2 Apr 2019 23:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554246067;
        bh=ika+YHmoT4jAgJRbgCbCoU1jdSzMtuxcYEI3U6nSG5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ehsrfy23LLNw/A8uoQITRbDA2GL+Yq0W4vxuWZ0KcBfz2Jtx3LiuBfGC81B1mAbA2
         ml/uh4Ia8ox6cvIOTW1wPwvikXcpTAfXm+T4bLk/D2yABHF16OyocOZF/4qBoY8QY/
         iNqZHixrhDmgZiG4KZOGxzuwU4MN4o0iehZ0NPwQ=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH 7/8] clk: Document and simplify clk_core_get_rate_nolock()
Date:   Tue,  2 Apr 2019 16:01:03 -0700
Message-Id: <20190402230104.105845-8-sboyd@kernel.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190402230104.105845-1-sboyd@kernel.org>
References: <20190402230104.105845-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function uses a few gotos and doesn't explain why parents and
numbers of parents are being checked before returning different values
for the clk's rate. Document and simplify this function somewhat to make
this better.

Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index c9860074899b..79d0466cd180 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -345,23 +345,18 @@ unsigned int __clk_get_enable_count(struct clk *clk)
 
 static unsigned long clk_core_get_rate_nolock(struct clk_core *core)
 {
-	unsigned long ret;
-
-	if (!core) {
-		ret = 0;
-		goto out;
-	}
-
-	ret = core->rate;
-
-	if (!core->num_parents)
-		goto out;
+	if (!core)
+		return 0;
 
-	if (!core->parent)
-		ret = 0;
+	if (!core->num_parents || core->parent)
+		return core->rate;
 
-out:
-	return ret;
+	/*
+	 * Clk must have a parent because num_parents > 0 but the parent isn't
+	 * known yet. Best to return 0 as the rate of this clk until we can
+	 * properly recalc the rate based on the parent's rate.
+	 */
+	return 0;
 }
 
 unsigned long clk_hw_get_rate(const struct clk_hw *hw)
-- 
Sent by a computer through tubes

