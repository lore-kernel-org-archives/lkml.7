Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7E1C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08EB218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cxnaaYgB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfCOUIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 16:08:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42166 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbfCOUIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 16:08:02 -0400
Received: by mail-pg1-f194.google.com with SMTP id b2so7164428pgl.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 13:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zJTJtCHTW4gN40l0qZRJ+gEBkunAEWcQrIjrIGSaUec=;
        b=cxnaaYgBBcKpejC5EFkzlUM5OuzOz5131423UVGdwAgD518MUgEA/on76nZbVOceFQ
         qNXxj534HxlKOQz90jV/fCWSzlyW2DoBY61YBvb8dhaHnmQSQbgasNkxkZmE+HmzDe5U
         NhUCujCDkUPF0TwHVXJ0MLDF6qNpxoBBJF1qY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zJTJtCHTW4gN40l0qZRJ+gEBkunAEWcQrIjrIGSaUec=;
        b=SO/+QzDTl0zwhTa57yjMpOjGSA20hxLshRXzK97Mkq/RRqhzQQyshKMwx0Oal5E6mw
         0KD1Xt1JezTbrnynmxQUP0xz8QzsG9un7SnvQV9pqt9b8d7E1okw5qhjEbjBYVw1sNRQ
         CH5Ps0ZcIBMCLbfo+xCJsW+btVITWKb2bMiksl8nUSdxEHyM76aK/WKePCl1XTlmxbFY
         DlEoc6FG7h4MEa5Av0k82CoGxw+m0CdkB1PAC58rIAkWAxC+gZQ3WPaeCPaP+raFb2V+
         UsplK5BteX2uYdZMi2DR6M2QpsVpQL7f2Hx9TSHPfHsJbViMhfbCn3btJ1CZ+bYh8ST+
         Zt3g==
X-Gm-Message-State: APjAAAUZki9ef7iveo98OA+5TkjJWRFVLNzzxFdzpsqwl/3FRFY3oPXa
        +RN5gIJMXzvmlY5MFUQ3fWz7YA==
X-Google-Smtp-Source: APXvYqx+uoTEcnILylmeJLMr0tqgnbguvI2GmOKclhq14KKCLYHWbEqAEqlg1sERc0negByM3xU8Vw==
X-Received: by 2002:a63:2a82:: with SMTP id q124mr5139459pgq.402.1552680481392;
        Fri, 15 Mar 2019 13:08:01 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id f15sm3758376pfa.11.2019.03.15.13.08.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 13:08:00 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH] genirq: Respect IRQCHIP_SKIP_SET_WAKE in irq_chip_set_wake_parent()
Date:   Fri, 15 Mar 2019 13:07:59 -0700
Message-Id: <20190315200759.139479-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function returns an error if a child interrupt controller calls
irq_chip_set_wake_parent() but that parent interrupt controller has the
IRQCHIP_SKIP_SET_WAKE flag. Let's return 0 for success instead because
there isn't anything to do.

There's also the possibility that a parent indicates that we should skip
it, but the grandparent has an .irq_set_wake callback. Let's iterate
through the parent chain as long as the IRQCHIP_SKIP_SET_WAKE flag isn't
set so we can find the first parent that needs to handle the wake
configuration. This fixes a problem on my Qualcomm sdm845 device where
I'm trying to enable wake on an irq from the gpio controller that's a
child of the qcom pdc interrupt controller. The qcom pdc interrupt
controller has the IRQCHIP_SKIP_SET_WAKE flag set, and so does the
grandparent (ARM GIC), causing this function to return a failure because
the parent controller doesn't have the .irq_set_wake callback set.

Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 kernel/irq/chip.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 3faef4a77f71..280d612ba71b 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1448,7 +1448,13 @@ int irq_chip_set_vcpu_affinity_parent(struct irq_data *data, void *vcpu_info)
  */
 int irq_chip_set_wake_parent(struct irq_data *data, unsigned int on)
 {
-	data = data->parent_data;
+	for (data = data->parent_data; data; data = data->parent_data)
+		if (!(data->chip->flags & IRQCHIP_SKIP_SET_WAKE))
+			break;
+
+	if (!data)
+		return 0;
+
 	if (data->chip->irq_set_wake)
 		return data->chip->irq_set_wake(data, on);
 
-- 
Sent by a computer through tubes

