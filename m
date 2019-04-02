Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C644C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6565420856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554246101;
	bh=mtOhSACUkKmGbH0M8QNgAFkjuCtDEJwQy80mdxplswI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=15dL/qwD1c7n/z8qby5rqBaz93zryrNisClyzWnJhEZYIp/c18G+wCmjPmsnzmSdT
	 jN2sEgCkzJr6ONAyjqqz3CQ0AVlQ40H/z0p+rYvQmLWzoZju7Eg/aUwQHdPZptenXg
	 hODvcP6YaNS+qJXpbDMeFVQQp2b2JO6LnGSlAQOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfDBXBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 19:01:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbfDBXBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 19:01:06 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC1812146E;
        Tue,  2 Apr 2019 23:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554246065;
        bh=mtOhSACUkKmGbH0M8QNgAFkjuCtDEJwQy80mdxplswI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bCX6nxLGL6fOqQ51vWXnpBBSwPCrtGQI9/lVSknLa2j4shoP+pLXdyRJSl2HeVT2n
         AAmfZxEm6EMytqPygbxNe49R20wWpTVcx3u1/S5R5W8h0mraIyIikP0yK3pZhGoG9t
         2dTrirzljsRHAxD8QgvPLca2ZnDwGvp7QAPb5Iwo=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH 2/8] clk: Document deprecated things
Date:   Tue,  2 Apr 2019 16:00:58 -0700
Message-Id: <20190402230104.105845-3-sboyd@kernel.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190402230104.105845-1-sboyd@kernel.org>
References: <20190402230104.105845-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't want driver authors to use the struct clk based registration
and provider APIs. Instead, they should use the clk_hw based APIs. Add
some notes in the kerneldoc to this effect.

Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk.c            | 15 ++++++++++-----
 include/linux/clk-provider.h |  2 +-
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 75d13c0eff12..592e315f7cfd 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3240,8 +3240,10 @@ void __clk_free_clk(struct clk *clk)
  * @dev: device that is registering this clock
  * @hw: link to hardware-specific clock data
  *
- * clk_register is the primary interface for populating the clock tree with new
- * clock nodes.  It returns a pointer to the newly allocated struct clk which
+ * clk_register is the *deprecated* interface for populating the clock tree with
+ * new clock nodes. Use clk_hw_register() instead.
+ *
+ * Returns: a pointer to the newly allocated struct clk which
  * cannot be dereferenced by driver code but may be used in conjunction with the
  * rest of the clock API.  In the event of an error clk_register will return an
  * error code; drivers must test for an error code after calling clk_register.
@@ -3486,9 +3488,10 @@ static void devm_clk_hw_release(struct device *dev, void *res)
  * @dev: device that is registering this clock
  * @hw: link to hardware-specific clock data
  *
- * Managed clk_register(). Clocks returned from this function are
- * automatically clk_unregister()ed on driver detach. See clk_register() for
- * more information.
+ * Managed clk_register(). This function is *deprecated*, use devm_clk_hw_register() instead.
+ *
+ * Clocks returned from this function are automatically clk_unregister()ed on
+ * driver detach. See clk_register() for more information.
  */
 struct clk *devm_clk_register(struct device *dev, struct clk_hw *hw)
 {
@@ -3820,6 +3823,8 @@ EXPORT_SYMBOL_GPL(of_clk_hw_onecell_get);
  * @np: Device node pointer associated with clock provider
  * @clk_src_get: callback for decoding clock
  * @data: context pointer for @clk_src_get callback.
+ *
+ * This function is *deprecated*. Use of_clk_add_hw_provider() instead.
  */
 int of_clk_add_provider(struct device_node *np,
 			struct clk *(*clk_src_get)(struct of_phandle_args *clkspec,
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index b65b48cc31f1..adb8a58e213c 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -24,7 +24,7 @@
 #define CLK_SET_RATE_PARENT	BIT(2) /* propagate rate change up one level */
 #define CLK_IGNORE_UNUSED	BIT(3) /* do not gate even if unused */
 				/* unused */
-#define CLK_IS_BASIC		BIT(5) /* Basic clk, can't do a to_clk_foo() */
+#define CLK_IS_BASIC		BIT(5) /* deprecated, don't use */
 #define CLK_GET_RATE_NOCACHE	BIT(6) /* do not use the cached clk rate */
 #define CLK_SET_RATE_NO_REPARENT BIT(7) /* don't re-parent on rate change */
 #define CLK_GET_ACCURACY_NOCACHE BIT(8) /* do not use the cached clk accuracy */
-- 
Sent by a computer through tubes

