Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8DAC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D7A2196E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="E+UHiJSG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389257AbfISKZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 06:25:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39064 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389208AbfISKZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 06:25:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id r3so2494945wrj.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 03:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RQH3sxdCSDhIfGdbCjdRoLM/sLLm5iODyAbQ5C/Ltw0=;
        b=E+UHiJSGEVWW51Mla00YaqY1xV4mU3Y+5rJsa4CDkZOUugcHeGYU8NUsvjyGdh1Y9W
         6ARRrK0ebicbUwvDp1hlZN1n7QfctXKyAu4DzKH5+41QbuAvDnrH33FdTGNAFkSJvfLy
         QM3+A4NxjDFI/AEFwzPmTTBsJZuL/7hvlJu+Vf8r89v9tYTyaECETWLTqQFVOI9fDTz6
         jp3aKuYmkkDyi97/DKgrXUPLbOji6zSqzZFO5bhxbSC7m+BZtVgnQ7VgA2ecK075aFiW
         fC7vMa1LtUIZ2tLG8H1NDl9Y2sjMBKz05YG90pNkgwuuimMWh0mQX+blFA/9c8gYS99O
         ce4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RQH3sxdCSDhIfGdbCjdRoLM/sLLm5iODyAbQ5C/Ltw0=;
        b=EX4vbQbkQtb4slmX2aw6g7V6Y3km6B2FiQWEvv4J4oW7czDt0NqIrvm3B4NY4d6Oii
         rrK7E1xF5ec29bxDOrPgq+V4M4WVSgZMnRZby/g3v0gFKeUXOyJlFRMxuEMOvE8aDM9A
         A/E1pZmNGD0aTEdulY3C301Ojpzmyq6AlU6VFId6uY72iEtH1bgscQS/DhRwWXy7pb4J
         svXV8gmRpzy4LOxzePFd0UPf4gPer7C3LatOjjuDn01cmMBChUbkhjzkxrRoBMgnwAj6
         bE6VJChcPUdHsS7akgmofn3G+CDIIln6DG2FA1XNLV7HNQpNeKc7r4LgBX9W06Y92yTd
         0zpQ==
X-Gm-Message-State: APjAAAU29NtU00siMXRGg46I/JNpdOlxp7NAHCbmePhdSJYcu/8f2DYL
        2kM8hWNRSc55IuYyvEICYKWCFA==
X-Google-Smtp-Source: APXvYqzSCZ+aZ9oAmix9jsUH1YYSrCs7/6e+ESB8ntGfVta/Je5txD9GnmfCeBCpuCV6nDG/Eavdjg==
X-Received: by 2002:adf:eccd:: with SMTP id s13mr6749982wro.288.1568888723655;
        Thu, 19 Sep 2019 03:25:23 -0700 (PDT)
Received: from bender.baylibre.local (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id a18sm19542000wrh.25.2019.09.19.03.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 03:25:23 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     sboyd@kernel.org, jbrunet@baylibre.com, mturquette@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 1/2] clk: introduce clk_invalidate_rate()
Date:   Thu, 19 Sep 2019 12:25:17 +0200
Message-Id: <20190919102518.25126-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190919102518.25126-1-narmstrong@baylibre.com>
References: <20190919102518.25126-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces the clk_invalidate_rate() call used to recalculate the
rate and parent tree of a particular clock if it's known that the
underlying registers set has been altered by the firmware, like from
a suspend/resume handler running in trusted cpu mode.

The call refreshes the actual parent and when changed, instructs CCF
the parent has changed. Finally the call will recalculate the rate of
each part of the tree to make sure the CCF cached tree is in sync with
the hardware.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/clk.c   | 70 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk.h | 13 +++++++++
 2 files changed, 83 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index ca99e9db6575..8acf38ce3cc4 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2557,6 +2557,76 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 }
 EXPORT_SYMBOL_GPL(clk_set_parent);
 
+/**
+ * __clk_invalidate_tree
+ * @core: first clk in the subtree
+ *
+ * Walks the subtree of clks starting with clk and recalculates the parents,
+ * then accuracies and rates as it goes.
+ */
+static int __clk_invalidate_tree(struct clk_core *core)
+{
+	struct clk_core *parent, *old_parent;
+	int ret, i, num_parents;
+
+	num_parents = core->num_parents;
+
+	for (i = 0; i < num_parents; i++) {
+		parent = clk_core_get_parent_by_index(core, i);
+		if (!parent)
+			continue;
+
+		ret = __clk_invalidate_tree(parent);
+		if (ret)
+			return ret;
+	}
+
+	parent = __clk_init_parent(core);
+
+	if (parent != core->parent) {
+		old_parent = __clk_set_parent_before(core, parent);
+		__clk_set_parent_after(core, parent, old_parent);
+	}
+
+	__clk_recalc_accuracies(core);
+	__clk_recalc_rates(core, 0);
+
+	return 0;
+}
+
+static int clk_core_invalidate_rate(struct clk_core *core)
+{
+	int ret;
+
+	clk_prepare_lock();
+
+	ret = __clk_invalidate_tree(core);
+
+	clk_prepare_unlock();
+
+	return ret;
+}
+
+/**
+ * clk_invalidate_rate - invalidate and recalc rate of the clock and it's tree
+ * @clk: the clk whose rate is too be invalidated
+ *
+ * If it's known the actual hardware state of a clock tree has changed,
+ * this call will invalidate the cached rate of the clk and it's possible
+ * parents tree to permit recalculation of the actual rate.
+ *
+ * Returns 0 on success, -EERROR otherwise.
+ * If clk is NULL then returns 0.
+ */
+int clk_invalidate_rate(struct clk *clk)
+{
+	if (!clk)
+		return 0;
+
+	return clk_core_invalidate_rate(clk->core);
+}
+EXPORT_SYMBOL_GPL(clk_invalidate_rate);
+
 static int clk_core_set_phase_nolock(struct clk_core *core, int degrees)
 {
 	int ret = -EINVAL;
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 853a8f181394..46db47ffb7b2 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -629,6 +629,19 @@ long clk_round_rate(struct clk *clk, unsigned long rate);
  */
 int clk_set_rate(struct clk *clk, unsigned long rate);
 
+/**
+ * clk_invalidate_rate - invalidate and recalc rate of the clock and it's tree
+ * @clk: the clk whose rate is too be invalidated
+ *
+ * If it's known the actual hardware state of a clock tree has changed,
+ * this call will invalidate the cached rate of the clk and it's possible
+ * parents tree to permit recalculation of the actual rate.
+ *
+ * Returns 0 on success, -EERROR otherwise.
+ * If clk is NULL then returns 0.
+ */
+int clk_invalidate_rate(struct clk *clk);
+
 /**
  * clk_set_rate_exclusive- set the clock rate and claim exclusivity over
  *                         clock source
-- 
2.22.0

