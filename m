Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8272C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 22:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0046206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 22:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cxphENNd";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cxphENNd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390400AbfIMV7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 17:59:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59698 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390268AbfIMV7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 17:59:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A686B60A60; Fri, 13 Sep 2019 21:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568411986;
        bh=Nma9mWXyYVp2E0wi8Zqshh5FM0cWL4gvjEG+g+1UyeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cxphENNdwsUDWvQuIOiqIc4JWPFSWkaGsuRImOb9XIuVtKg/Fs7xzokdrGyS74xnV
         MXJr57gCG6whBnAjGq5pvgiVejWJXwqvT9iRk7hLQzPjML3JtneFCtSjeb1IWxQTob
         D3G/VePO0vz3G6VZi1BTrHhqn1wsNe3JdTORylxA=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6DF0560C72;
        Fri, 13 Sep 2019 21:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568411986;
        bh=Nma9mWXyYVp2E0wi8Zqshh5FM0cWL4gvjEG+g+1UyeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cxphENNdwsUDWvQuIOiqIc4JWPFSWkaGsuRImOb9XIuVtKg/Fs7xzokdrGyS74xnV
         MXJr57gCG6whBnAjGq5pvgiVejWJXwqvT9iRk7hLQzPjML3JtneFCtSjeb1IWxQTob
         D3G/VePO0vz3G6VZi1BTrHhqn1wsNe3JdTORylxA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6DF0560C72
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     swboyd@chromium.org, evgreen@chromium.org, maz@kernel.org,
        linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, mkshah@codeaurora.org,
        linux-gpio@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>,
        devicetree@vger.kernel.org
Subject: [PATCH RFC v2 05/14] of: irq: document properties for wakeup interrupt parent
Date:   Fri, 13 Sep 2019 15:59:13 -0600
Message-Id: <1568411962-1022-6-git-send-email-ilina@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568411962-1022-1-git-send-email-ilina@codeaurora.org>
References: <1568411962-1022-1-git-send-email-ilina@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some interrupt controllers in a SoC, are always powered on and have a
select interrupts routed to them, so that they can wakeup the SoC from
suspend. Add wakeup-parent DT property to refer to these interrupt
controllers.

Cc: devicetree@vger.kernel.org
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/interrupt-controller/interrupts.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt b/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
index 8a3c408..c10e310 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
@@ -108,3 +108,16 @@ commonly used:
 			sensitivity = <7>;
 		};
 	};
+
+3) Interrupt wakeup parent
+--------------------------
+
+Some interrupt controllers in a SoC, are always powered on and have a select
+interrupts routed to them, so that they can wakeup the SoC from suspend. These
+interrupt controllers do not fall into the category of a parent interrupt
+controller and can be specified by the "wakeup-parent" property and contain a
+single phandle referring to the wakeup capable interrupt controller.
+
+   Example:
+	wakeup-parent = <&pdc_intc>;
+
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

