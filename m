Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3C0C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD5A20732
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JRDqK4gJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="C2WEG4IP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfKOWRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 17:17:51 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:47346 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbfKOWRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 17:17:49 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 70FE96119E; Fri, 15 Nov 2019 22:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573856268;
        bh=XhcTDR2gaQVtD8sQoO/Q38U8s3YqqcSActxZfPvDRNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JRDqK4gJA2KF26bjEL5sTndALhzKgx90hU913YeTA2ueA+BAQsQRdHcx/GsOHTdY5
         f7+lUb1tPUUtJ+Vyw2j0jnRvUaXp3T+7S+73Y2t8nS9/r3iqsTD6VVAi03WZ++3gur
         W3LN477VXTBb/H6YrH18nmopKR/SI3XfeFNdxXqA=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A44586110B;
        Fri, 15 Nov 2019 22:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573856267;
        bh=XhcTDR2gaQVtD8sQoO/Q38U8s3YqqcSActxZfPvDRNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C2WEG4IP1dqEJYTg1VWBMA8QjLebTBQY66KyAbz8OGIomEEFYQ+5i/jiVz3sICmMy
         hh64LgEaoTJrQrhwLiJPbFSA4hyvTb3bt9DpRRgqOHKo1rgx51f13VLrNU2fjIBcTl
         b4u3QZE28+DNaukEoTXgPgrXbailW6nZZDnLHisg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A44586110B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     swboyd@chromium.org, maz@kernel.org, linus.walleij@linaro.org,
        bjorn.andersson@linaro.org
Cc:     evgreen@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mkshah@codeaurora.org,
        linux-gpio@vger.kernel.org, agross@kernel.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 05/12] of: irq: document properties for wakeup interrupt parent
Date:   Fri, 15 Nov 2019 15:11:48 -0700
Message-Id: <1573855915-9841-6-git-send-email-ilina@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573855915-9841-1-git-send-email-ilina@codeaurora.org>
References: <1573855915-9841-1-git-send-email-ilina@codeaurora.org>
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
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
Changes in v1:
	- Remove whitespace at end of patch
---
 .../devicetree/bindings/interrupt-controller/interrupts.txt  | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt b/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
index 4a3ee25..4ebfa00 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
@@ -108,3 +108,15 @@ commonly used:
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
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

