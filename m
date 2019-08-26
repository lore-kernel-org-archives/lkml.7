Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18CEC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 21:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E8721872
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 21:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566854446;
	bh=T0JD8qnI+1dYLW2ehX5/L9s6yP8c59bF7QrrvgHwOqk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=V4eFgtCTjnRNcV1satbD6j4KKvFkDROPdLjgA9tNAxbCBhfNPDzZJQw1k7LsxiPwb
	 WJIZDj9dXgkveF8BrjGG5GX2f49Z3ur+eWpsx3t099xCOui9hoV6gUnc5mx6cJRQew
	 Wa0P65eEXPLCaMgUJ0uAcVzJiwU7Y2PXV4VlKkYU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfHZVUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 17:20:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbfHZVUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 17:20:44 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F9D620850;
        Mon, 26 Aug 2019 21:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566854443;
        bh=T0JD8qnI+1dYLW2ehX5/L9s6yP8c59bF7QrrvgHwOqk=;
        h=From:To:Cc:Subject:Date:From;
        b=WUYTOWgHppyB/BswRdS0DFRR1o3k9ofrSF27KtjH+NIJYMe5zaYJ54v5BbnrNfhdf
         kMNHH7En6RqGUfnK/ADf8ZI2CNOH4zjBjrGK3bmnRQAyDQ+6wrWwWJ2+8Kz+m4O/pZ
         jGsewM4Cc5vasiPUe7FruSKOwEmJLXlNg2muIa9Q=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH v2] clk: Document of_parse_clkspec() some more
Date:   Mon, 26 Aug 2019 14:20:42 -0700
Message-Id: <20190826212042.48642-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of of_parse_clkspec() is peculiar. If the function is
called with a NULL argument for 'name' it will return -ENOENT, but if
it's called with a non-NULL argument for 'name' it will return -EINVAL.
This peculiarity is documented by commit 5c56dfe63b6e ("clk: Add comment
about __of_clk_get_by_name() error values").

Let's further document this function so that it's clear what the return
value is and how to use the arguments to parse clk specifiers.

Cc: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk.c | 43 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index c0990703ce54..5c6585eb35d4 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4316,12 +4316,43 @@ void devm_of_clk_del_provider(struct device *dev)
 }
 EXPORT_SYMBOL(devm_of_clk_del_provider);
 
-/*
- * Beware the return values when np is valid, but no clock provider is found.
- * If name == NULL, the function returns -ENOENT.
- * If name != NULL, the function returns -EINVAL. This is because
- * of_parse_phandle_with_args() is called even if of_property_match_string()
- * returns an error.
+/**
+ * of_parse_clkspec() - Parse a DT clock specifier for a given device node
+ * @np: device node to parse clock specifier from
+ * @index: index of phandle to parse clock out of. If index < 0, @name is used
+ * @name: clock name to find and parse. If name is NULL, the index is used
+ * @out_args: Result of parsing the clock specifier
+ *
+ * Parses a device node's "clocks" and "clock-names" properties to find the
+ * phandle and cells for the index or name that is desired. The resulting clock
+ * specifier is placed into @out_args, or an errno is returned when there's a
+ * parsing error. The @index argument is ignored if @name is non-NULL.
+ *
+ * Example:
+ *
+ * phandle1: clock-controller@1 {
+ *	#clock-cells = <2>;
+ * }
+ *
+ * phandle2: clock-controller@2 {
+ *	#clock-cells = <1>;
+ * }
+ *
+ * clock-consumer@3 {
+ *	clocks = <&phandle1 1 2 &phandle2 3>;
+ *	clock-names = "name1", "name2";
+ * }
+ *
+ * To get a device_node for `clock-controller@2' node you may call this
+ * function a few different ways:
+ *
+ *   of_parse_clkspec(clock-consumer@3, -1, "name2", &args);
+ *   of_parse_clkspec(clock-consumer@3, 1, NULL, &args);
+ *   of_parse_clkspec(clock-consumer@3, 1, "name2", &args);
+ *
+ * Return: 0 upon successfully parsing the clock specifier. Otherwise, -ENOENT
+ * if @name is NULL or -EINVAL if @name is non-NULL and it can't be found in
+ * the "clock-names" property of @np.
  */
 static int of_parse_clkspec(const struct device_node *np, int index,
 			    const char *name, struct of_phandle_args *out_args)
-- 
Sent by a computer through tubes

