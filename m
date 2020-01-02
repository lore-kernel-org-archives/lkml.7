Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35480C3276E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 23:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F02F021655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 23:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="a5oi1fAk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgABXLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 18:11:22 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:43119 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgABXLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 18:11:21 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 144F423059;
        Fri,  3 Jan 2020 00:11:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1578006678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5hS5ZmlU1acowh0gEanYHXKQPayofiBzA9sNdaIkQPc=;
        b=a5oi1fAkv5ByGDQvNZoPIUIOAlAQtqPR8kXNKIAQcQ35sWNufS0MhAFbcSzWph4Tzb7r9/
        sNwnSYvJuNj7qKEnn5hMzG/Wu4Y9weGcQ10dK9oEPvJcextUTYjB65k2TaJzIgL75D6RUU
        Ax4pT6MRFx3RBW0sgWEDjchPdmdAUWg=
From:   Michael Walle <michael@walle.cc>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v3 1/3] clk: composite: add _register_composite_pdata() variants
Date:   Fri,  3 Jan 2020 00:10:59 +0100
Message-Id: <20200102231101.11834-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 144F423059
X-Spamd-Result: default: False [6.40 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[8];
         MID_CONTAINS_FROM(1.00)[];
         NEURAL_HAM(-0.00)[-0.519];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c::/31, country:DE];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the new way of specifying the clock parents. Add the
two new functions
    clk_hw_register_composite_pdata()
    clk_register_composite_pdata()
to let the driver provide parent_data instead of the parent_names.

Signed-off-by: Michael Walle <michael@walle.cc>
---
New patch in v3 of this series. Thus no changelog.

 drivers/clk/clk-composite.c  | 56 ++++++++++++++++++++++++++++++++++--
 include/linux/clk-provider.h | 13 +++++++++
 2 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index 3e9c3e608769..7376f573bfdb 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -199,8 +199,9 @@ static void clk_composite_disable(struct clk_hw *hw)
 	gate_ops->disable(gate_hw);
 }
 
-struct clk_hw *clk_hw_register_composite(struct device *dev, const char *name,
-			const char * const *parent_names, int num_parents,
+static struct clk_hw *__clk_hw_register_composite(struct device *dev,
+			const char *name, const char * const *parent_names,
+			const struct clk_parent_data *pdata, int num_parents,
 			struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
 			struct clk_hw *rate_hw, const struct clk_ops *rate_ops,
 			struct clk_hw *gate_hw, const struct clk_ops *gate_ops,
@@ -218,7 +219,10 @@ struct clk_hw *clk_hw_register_composite(struct device *dev, const char *name,
 
 	init.name = name;
 	init.flags = flags;
-	init.parent_names = parent_names;
+	if (parent_names)
+		init.parent_names = parent_names;
+	else
+		init.parent_data = pdata;
 	init.num_parents = num_parents;
 	hw = &composite->hw;
 
@@ -312,6 +316,34 @@ struct clk_hw *clk_hw_register_composite(struct device *dev, const char *name,
 	return hw;
 }
 
+struct clk_hw *clk_hw_register_composite(struct device *dev, const char *name,
+			const char * const *parent_names, int num_parents,
+			struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
+			struct clk_hw *rate_hw, const struct clk_ops *rate_ops,
+			struct clk_hw *gate_hw, const struct clk_ops *gate_ops,
+			unsigned long flags)
+{
+	return __clk_hw_register_composite(dev, name, parent_names, NULL,
+					   num_parents, mux_hw, mux_ops,
+					   rate_hw, rate_ops, gate_hw,
+					   gate_ops, flags);
+}
+
+struct clk_hw *clk_hw_register_composite_pdata(struct device *dev,
+			const char *name,
+			const struct clk_parent_data *parent_data,
+			int num_parents,
+			struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
+			struct clk_hw *rate_hw, const struct clk_ops *rate_ops,
+			struct clk_hw *gate_hw, const struct clk_ops *gate_ops,
+			unsigned long flags)
+{
+	return __clk_hw_register_composite(dev, name, NULL, parent_data,
+					   num_parents, mux_hw, mux_ops,
+					   rate_hw, rate_ops, gate_hw,
+					   gate_ops, flags);
+}
+
 struct clk *clk_register_composite(struct device *dev, const char *name,
 			const char * const *parent_names, int num_parents,
 			struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
@@ -329,6 +361,24 @@ struct clk *clk_register_composite(struct device *dev, const char *name,
 	return hw->clk;
 }
 
+struct clk *clk_register_composite_pdata(struct device *dev, const char *name,
+			const struct clk_parent_data *parent_data,
+			int num_parents,
+			struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
+			struct clk_hw *rate_hw, const struct clk_ops *rate_ops,
+			struct clk_hw *gate_hw, const struct clk_ops *gate_ops,
+			unsigned long flags)
+{
+	struct clk_hw *hw;
+
+	hw = clk_hw_register_composite_pdata(dev, name, parent_data,
+			num_parents, mux_hw, mux_ops, rate_hw, rate_ops,
+			gate_hw, gate_ops, flags);
+	if (IS_ERR(hw))
+		return ERR_CAST(hw);
+	return hw->clk;
+}
+
 void clk_unregister_composite(struct clk *clk)
 {
 	struct clk_composite *composite;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index caf4b9df16eb..e2e9d867df36 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -743,6 +743,12 @@ struct clk *clk_register_composite(struct device *dev, const char *name,
 		struct clk_hw *rate_hw, const struct clk_ops *rate_ops,
 		struct clk_hw *gate_hw, const struct clk_ops *gate_ops,
 		unsigned long flags);
+struct clk *clk_register_composite_pdata(struct device *dev, const char *name,
+		const struct clk_parent_data *parent_data, int num_parents,
+		struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
+		struct clk_hw *rate_hw, const struct clk_ops *rate_ops,
+		struct clk_hw *gate_hw, const struct clk_ops *gate_ops,
+		unsigned long flags);
 void clk_unregister_composite(struct clk *clk);
 struct clk_hw *clk_hw_register_composite(struct device *dev, const char *name,
 		const char * const *parent_names, int num_parents,
@@ -750,6 +756,13 @@ struct clk_hw *clk_hw_register_composite(struct device *dev, const char *name,
 		struct clk_hw *rate_hw, const struct clk_ops *rate_ops,
 		struct clk_hw *gate_hw, const struct clk_ops *gate_ops,
 		unsigned long flags);
+struct clk_hw *clk_hw_register_composite_pdata(struct device *dev,
+		const char *name,
+		const struct clk_parent_data *parent_data, int num_parents,
+		struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
+		struct clk_hw *rate_hw, const struct clk_ops *rate_ops,
+		struct clk_hw *gate_hw, const struct clk_ops *gate_ops,
+		unsigned long flags);
 void clk_hw_unregister_composite(struct clk_hw *hw);
 
 /**
-- 
2.20.1

