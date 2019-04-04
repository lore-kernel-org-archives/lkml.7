Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B68C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C294F217D4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554414857;
	bh=LZEUR8eiDUJq7nEmBI5Ou+kM+A9lWl2yePObSye2+60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=whJwPiyXRJn0b46XL2N6qWg9eIxDfZERLucf1em40zS9AoruMQ14C5RmFXlPQj1n/
	 nbTHyVt3BcIVnmY3ZGhEMDOagHhDCzSckXnr85xN2T2LiFUx5cc3/q3CmOBZZkgnXs
	 Bxgmx1oJ0kFj9CCaqU9z/VpzdR36I4mtQAqonM94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbfDDVyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 17:54:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730331AbfDDVxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 17:53:47 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31B022183E;
        Thu,  4 Apr 2019 21:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554414826;
        bh=LZEUR8eiDUJq7nEmBI5Ou+kM+A9lWl2yePObSye2+60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FRmkiNeJ78w5JRnu3caP81vw6IEgTQ7+eNkxYJ10oWOtpMsDZoeiXqNVvjDK3myei
         7Yu0irXIKR99kG/xEsiso3KBs3Q789p+/AxxwFYS328VukkV/yQX34NnQMc1CyYFN2
         WZUo91JBipB6Eg4+ip9nCPJgn/k/q6NL56a85Hlc=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 2/7] clk: Prepare for clk registration API that uses DT nodes
Date:   Thu,  4 Apr 2019 14:53:39 -0700
Message-Id: <20190404215344.6330-3-sboyd@kernel.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190404215344.6330-1-sboyd@kernel.org>
References: <20190404215344.6330-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split out the body of the clk_register() function so it can be shared
between the different types of registration APIs (DT, device).

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 96053a96fe2f..d27775a73e67 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3313,18 +3313,7 @@ struct clk *clk_hw_create_clk(struct device *dev, struct clk_hw *hw,
 	return clk;
 }
 
-/**
- * clk_register - allocate a new clock, register it and return an opaque cookie
- * @dev: device that is registering this clock
- * @hw: link to hardware-specific clock data
- *
- * clk_register is the primary interface for populating the clock tree with new
- * clock nodes.  It returns a pointer to the newly allocated struct clk which
- * cannot be dereferenced by driver code but may be used in conjunction with the
- * rest of the clock API.  In the event of an error clk_register will return an
- * error code; drivers must test for an error code after calling clk_register.
- */
-struct clk *clk_register(struct device *dev, struct clk_hw *hw)
+static struct clk *__clk_register(struct device *dev, struct clk_hw *hw)
 {
 	int i, ret;
 	struct clk_core *core;
@@ -3426,6 +3415,22 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
 fail_out:
 	return ERR_PTR(ret);
 }
+
+/**
+ * clk_register - allocate a new clock, register it and return an opaque cookie
+ * @dev: device that is registering this clock
+ * @hw: link to hardware-specific clock data
+ *
+ * clk_register is the primary interface for populating the clock tree with new
+ * clock nodes.  It returns a pointer to the newly allocated struct clk which
+ * cannot be dereferenced by driver code but may be used in conjunction with the
+ * rest of the clock API.  In the event of an error clk_register will return an
+ * error code; drivers must test for an error code after calling clk_register.
+ */
+struct clk *clk_register(struct device *dev, struct clk_hw *hw)
+{
+	return __clk_register(dev, hw);
+}
 EXPORT_SYMBOL_GPL(clk_register);
 
 /**
@@ -3440,7 +3445,7 @@ EXPORT_SYMBOL_GPL(clk_register);
  */
 int clk_hw_register(struct device *dev, struct clk_hw *hw)
 {
-	return PTR_ERR_OR_ZERO(clk_register(dev, hw));
+	return PTR_ERR_OR_ZERO(__clk_register(dev, hw));
 }
 EXPORT_SYMBOL_GPL(clk_hw_register);
 
-- 
Sent by a computer through tubes

