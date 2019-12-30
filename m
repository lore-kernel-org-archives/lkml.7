Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA87C2D0CE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2366420658
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577732698;
	bh=p8M2OEtkcPThYS4Ece3U5r41flQ/iN5brOD0ybpPheo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=GlPS8fhmZ/kTE9xmPylPcWnVy9Vm1zrmhvjGYN+YZPDJGHh5Ls7VU5ES2JN032WvG
	 YD6oeJaj8uCEzrj5rR6NiH7ZLGZ+NrklkSfrm5dBdhDeZ7ULEhu63LuIDDTdDOSrgk
	 yreYtzKPtP69m82USHojERFMy6oeRG/ADs9OIr+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfL3TE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 14:04:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:38082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727278AbfL3TE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 14:04:56 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE5C020658;
        Mon, 30 Dec 2019 19:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577732696;
        bh=p8M2OEtkcPThYS4Ece3U5r41flQ/iN5brOD0ybpPheo=;
        h=From:To:Cc:Subject:Date:From;
        b=VXfAVnfX0pCF4+EO8/FpwofMi0eLyIWyodRALEdQx6v7TeZNY68sIShz3MXJhkLvd
         Z7B+pXBb+IGbUV+FfUwrVblf+KMh/SYY0vpB7Uh+oNTKkJlNcwD9ryhU9S4jzK8TaS
         +CmCwoh7G4Xb/r2RPuki2ehFpGcsjh7Q9uWFEk9s=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: [PATCH] clk: Use parent node pointer during registration if necessary
Date:   Mon, 30 Dec 2019 11:04:55 -0800
Message-Id: <20191230190455.141339-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes clk drivers are attached to devices which are children of a
parent device that is connected to a node in DT. This happens when
devices are MFD-ish and the parent device driver mostly registers child
devices to match against drivers placed in their respective subsystem
directories like drivers/clk, drivers/regulator, etc. When the clk
driver calls clk_register() with a device pointer, that struct device
pointer won't have a device_node associated with it because it was
created purely in software as a way to partition logic to a subsystem.

This causes problems for the way we find parent clks for the clks
registered by these child devices because we look at the registering
device's device_node pointer to lookup 'clocks' and 'clock-names'
properties. Let's use the parent device's device_node pointer if the
registering device doesn't have a device_node but the parent does. This
simplifies clk registration code by avoiding the need to assign some
device_node to the device registering the clk.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Reported-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---

I decided to introduce a new function instead of trying to jam it all
in the one line where we assign np. This way the function gets the 
true 'np' as an argument all the time.

 drivers/clk/clk.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index b68e200829f2..a743fffe8e46 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3719,6 +3719,28 @@ __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
 	return ERR_PTR(ret);
 }
 
+/**
+ * dev_or_parent_of_node - Get device node of @dev or @dev's parent
+ * @dev: Device to get device node of
+ *
+ * Returns: device node pointer of @dev, or the device node pointer of
+ * @dev->parent if dev doesn't have a device node, or NULL if neither
+ * @dev or @dev->parent have a device node.
+ */
+static struct device_node *dev_or_parent_of_node(struct device *dev)
+{
+	struct device_node *np;
+
+	if (!dev)
+		return NULL;
+
+	np = dev_of_node(dev);
+	if (!np)
+		np = dev_of_node(dev->parent);
+
+	return np;
+}
+
 /**
  * clk_register - allocate a new clock, register it and return an opaque cookie
  * @dev: device that is registering this clock
@@ -3734,7 +3756,7 @@ __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
  */
 struct clk *clk_register(struct device *dev, struct clk_hw *hw)
 {
-	return __clk_register(dev, dev_of_node(dev), hw);
+	return __clk_register(dev, dev_or_parent_of_node(dev), hw);
 }
 EXPORT_SYMBOL_GPL(clk_register);
 
@@ -3750,7 +3772,8 @@ EXPORT_SYMBOL_GPL(clk_register);
  */
 int clk_hw_register(struct device *dev, struct clk_hw *hw)
 {
-	return PTR_ERR_OR_ZERO(__clk_register(dev, dev_of_node(dev), hw));
+	return PTR_ERR_OR_ZERO(__clk_register(dev, dev_or_parent_of_node(dev),
+			       hw));
 }
 EXPORT_SYMBOL_GPL(clk_hw_register);
 

base-commit: e42617b825f8073569da76dc4510bfa019b1c35a
-- 
Sent by a computer, using git, on the internet

