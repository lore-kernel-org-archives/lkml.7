Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7554C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A7A2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CMfIJ1N9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbfCYSK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:10:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45657 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbfCYSK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:10:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id e24so5956450pfi.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 11:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yb28Rwinu3HSqUzQsmebPya8geO3DXE7wlrC3tIKi+s=;
        b=CMfIJ1N9fYf2S1BxTbN4KcumvqcrzuIgYkVaX0/qwf8DdFzO2V16CBFRGqPs8NkwEq
         cvyHSnLWI+3VcH5p72b1kuGwk6T59e01GxI391CQRY9eHLgVkmJktjU6Fn6ejA1rmWx1
         vVsdfYucRwc14TpWfcsK/4Ee21n9w5Kz7yb0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yb28Rwinu3HSqUzQsmebPya8geO3DXE7wlrC3tIKi+s=;
        b=odOi6OPsNARly6CcRevSeJfP2WrBeBkdWA1s2ESRIzO9poIZuglzff19rfu3z9jnsd
         loH8i+J0ZGvr6NFNSKkaU12S0WQHLUcoDvVwEKwebEClUIEzYb1776GiK7JUlv6sYgnl
         wucxVWpxGAc5af3kbcPmjhsm74MICUWmjxD14q54TafEBzq3i6w18rogjfg1MC7ev5Uv
         ks3l4Igqx1ldh97910ota43DCDyynjFioK+C3Md59CDZGngF0vrgX68NWR5msDeSPZnn
         WDDTydOwOiFZZmu74RqQUvvEnCog6KJU9pLfDf3YRGLbF38ByZbiy1HKDPyeMuyi9Fih
         rheQ==
X-Gm-Message-State: APjAAAUdPv0cKqUO1Gud4/+emFgWgBzMV+HDDfeovRBLcrm4yVf8ww/7
        rkTEgY14rtmAu1PMMY5jcEonIA==
X-Google-Smtp-Source: APXvYqwkovfcoPcSEStWz2FRXMwRJX+XjUasMbEGVKVM2bN53Im7S0mIm9RI4tNg9tSejg2aVCv98g==
X-Received: by 2002:a63:c804:: with SMTP id z4mr23633612pgg.228.1553537427975;
        Mon, 25 Mar 2019 11:10:27 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g2sm37882575pfm.144.2019.03.25.11.10.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 11:10:27 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v2] genirq: Respect IRQCHIP_SKIP_SET_WAKE in irq_chip_set_wake_parent()
Date:   Mon, 25 Mar 2019 11:10:26 -0700
Message-Id: <20190325181026.247796-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function returns an error if a child irqchip calls
irq_chip_set_wake_parent() but its parent irqchip has the
IRQCHIP_SKIP_SET_WAKE flag set. Let's return 0 for success here instead
because there isn't anything to do.

This keeps the behavior consistent with how set_irq_wake_real() is
implemented. That function returns 0 when the irqchip has the
IRQCHIP_SKIP_SET_WAKE flag set. It doesn't attempt to walk the chain of
parents and set irq wake on any chips that don't have the flag set
either. If the intent is to call the .irq_set_wake() callback of the
parent irqchip, then we expect irqchip implementations to omit the
IRQCHIP_SKIP_SET_WAKE flag and implement an .irq_set_wake() function
that calls irq_chip_set_wake_parent().

This fixes a problem on my Qualcomm sdm845 device where I can't set wake
on any GPIO interrupts after I apply work in progress wakeup irq patches
to the GPIO driver. The chain of chips looks like this:

 ARM GIC (skip) -> QCOM PDC (skip) -> QCOM GPIO

The GPIO controller is a child of the QCOM PDC irqchip which is a child
of the ARM GIC irqchip. The QCOM PDC irqchip has the
IRQCHIP_SKIP_SET_WAKE flag set, and so does the grandparent ARM GIC.

The GPIO driver doesn't know if the parent needs to set wake or not, so
it unconditionally calls irq_chip_set_wake_parent() causing this
function to return a failure because the parent irqchip (PDC) doesn't
have the .irq_set_wake() callback set. Returning 0 instead makes
everything work and irqs from the GPIO controller can be configured for
wakeup.

Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v1:
 - Rewrote commit text
 - Changed to only look at parent flags instead of walking parent chain

 kernel/irq/chip.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 3faef4a77f71..51128bea3846 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1449,6 +1449,10 @@ int irq_chip_set_vcpu_affinity_parent(struct irq_data *data, void *vcpu_info)
 int irq_chip_set_wake_parent(struct irq_data *data, unsigned int on)
 {
 	data = data->parent_data;
+
+	if (data->chip->flags & IRQCHIP_SKIP_SET_WAKE)
+		return 0;
+
 	if (data->chip->irq_set_wake)
 		return data->chip->irq_set_wake(data, on);
 
-- 
Sent by a computer through tubes

