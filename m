Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C242CC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8674B2084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554246072;
	bh=otocyZ8EE5uT+/ItK2KIBynGeViv0DJrRj3jkb2Xq2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2ZoJgIeTB3BLJQ+ayo15ll6wIswMbnwda5QlIh97A0oEQexvrSPiwtG4ZsVIKkXz6
	 dLXcF9d5aSnSoTPbyh629TE8liFGYEToX3IES+Mw8uXfdlsGVRPLZ+4PM+X+tC9est
	 YzA6JdO8N9YVnNhvLPjNq0zgASzFPkwrHkIJHvEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfDBXBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 19:01:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:49934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726471AbfDBXBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 19:01:07 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B2F521473;
        Tue,  2 Apr 2019 23:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554246066;
        bh=otocyZ8EE5uT+/ItK2KIBynGeViv0DJrRj3jkb2Xq2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kXQNXfh3ghlpTIyAb4vKjoy1Ch0uQ16aMz5BNTElzRHYEJIJFKsUhG0uuqJ0VSt/K
         7KBxkEig8fYAaOy65OFLzyHSDgWwjwUakERKMdZvEk8VAg8GCf+WcE/9nkHpMGIpOS
         EwkVQri69QvwJGiyUhGAD15j6rUKGAJLTPra9xps=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH 4/8] clk: Document __clk_mux_determine_rate()
Date:   Tue,  2 Apr 2019 16:01:00 -0700
Message-Id: <20190402230104.105845-5-sboyd@kernel.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190402230104.105845-1-sboyd@kernel.org>
References: <20190402230104.105845-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It had some documentation, but not kerneldoc style so it wasn't getting
picked up. Add some docs so scripts can pick this function out.

Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 592e315f7cfd..c9860074899b 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -519,9 +519,15 @@ void clk_hw_set_rate_range(struct clk_hw *hw, unsigned long min_rate,
 EXPORT_SYMBOL_GPL(clk_hw_set_rate_range);
 
 /*
+ * __clk_mux_determine_rate - clk_ops::determine_rate implementation for a mux type clk
+ * @hw: mux type clk to determine rate on
+ * @req: rate request, also used to return preferred parent and frequencies
+ *
  * Helper for finding best parent to provide a given frequency. This can be used
  * directly as a determine_rate callback (e.g. for a mux), or from a more
  * complex clock that may combine a mux with other operations.
+ *
+ * Returns: 0 on success, -EERROR value on error
  */
 int __clk_mux_determine_rate(struct clk_hw *hw,
 			     struct clk_rate_request *req)
-- 
Sent by a computer through tubes

