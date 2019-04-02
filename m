Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCA1C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55E72084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554246077;
	bh=cFHoZ0qooyyRKWWYFoL9kskxTOV856KIA6x49uFmMoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jgaN0HUS5ohacuWGH0WL4/fxmw/tuiNBtS4NVrjDIEQFezjynmoi82LT2ZNJ/vNNw
	 GRqHMu3rBcTrvVMRR9DDBYwaauXbDofhYKvvkQwsYgxHUC0h+Bx5GcWvUKsgZwxyLr
	 Li+Atu5xdZ63AwCURvmkhQqyw3EfG8FdJsAm7Qvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfDBXBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 19:01:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbfDBXBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 19:01:08 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7E4A20882;
        Tue,  2 Apr 2019 23:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554246068;
        bh=cFHoZ0qooyyRKWWYFoL9kskxTOV856KIA6x49uFmMoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HURoqVsKcPU6gXOrddrcOny9gq2Psbsfsq9bVzeUDaDBHhStLRuyb7P9gC9RILchi
         jpSsQxmPqzLE6kDTR5lh6FbQCWsnI4pPfH/bx7cgyoFy4jOLdlOLlXOUrLEMPed8D2
         5lIMTDIBkmLlYmXZ8eckF67YaQkeTI+4UAaAcl6I=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH 8/8] clk: Drop duplicate clk_register() documentation
Date:   Tue,  2 Apr 2019 16:01:04 -0700
Message-Id: <20190402230104.105845-9-sboyd@kernel.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190402230104.105845-1-sboyd@kernel.org>
References: <20190402230104.105845-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_register() isn't the main way to register a clk anymore. Developers
should use clk_hw_register() instead. Furthermore, this whole chunk of
documentation duplicates what's in the C file, so let's just use that.

Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 include/linux/clk-provider.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index a1705a0f08c7..677df7865ac8 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -751,17 +751,6 @@ struct clk_hw *clk_hw_register_gpio_mux(struct device *dev, const char *name,
 		unsigned long flags);
 void clk_hw_unregister_gpio_mux(struct clk_hw *hw);
 
-/**
- * clk_register - allocate a new clock, register it and return an opaque cookie
- * @dev: device that is registering this clock
- * @hw: link to hardware-specific clock data
- *
- * clk_register is the primary interface for populating the clock tree with new
- * clock nodes.  It returns a pointer to the newly allocated struct clk which
- * cannot be dereferenced by driver code but may be used in conjuction with the
- * rest of the clock API.  In the event of an error clk_register will return an
- * error code; drivers must test for an error code after calling clk_register.
- */
 struct clk *clk_register(struct device *dev, struct clk_hw *hw);
 struct clk *devm_clk_register(struct device *dev, struct clk_hw *hw);
 
-- 
Sent by a computer through tubes

