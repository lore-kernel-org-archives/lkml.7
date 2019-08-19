Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7F7C3A5A1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 22:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C44622CE8
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 22:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566253759;
	bh=qRp6AJPvv4Wh3DJ4B0feuOTNFDZUxNlcl0ADw5l5TZ4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=poaXw6rsMypysmnxonzFm4pPMmtZwWCxviw/Y+Yp/h1Ci23NJCvnCjGo+/UPLarhq
	 9cG0hcZEciOF8LXgCgAUHwT8Vb6GGp7ssGsO8Hc18h+Em68sIaIiF1mw94SPTzxl+T
	 dTEgV1TEnU/XBKSh4z5HnIJk76XnfW0Pe4jwqaEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbfHSW3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 18:29:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728438AbfHSW3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 18:29:17 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DEF522CE8;
        Mon, 19 Aug 2019 22:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566253756;
        bh=qRp6AJPvv4Wh3DJ4B0feuOTNFDZUxNlcl0ADw5l5TZ4=;
        h=From:To:Cc:Subject:Date:From;
        b=HuxHOCrdGAUwtyumiCiG3WexxMpHYGBxqq0sKHUzMfCqjOofif5P+uax+JaFK826g
         L3taMJV1sgfUFe7osYLTX+PmGgBnjLaXcSPrTSf6dgdEOc6ql+7V6miilGuZThfnIJ
         oBV9ClNSV0VTrEreAPTv2+K+gwMD5Qi1tQeCDZ78=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH] clk: Make of_parse_clkspec() return -ENOENT on errors
Date:   Mon, 19 Aug 2019 15:29:15 -0700
Message-Id: <20190819222915.56150-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
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
index bea50eee9e8c..4649e036eed2 100644
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

