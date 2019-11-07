Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABF8C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873BE21D79
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="b6yYq+8M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388341AbfKGMVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 07:21:21 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35083 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfKGMVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 07:21:20 -0500
Received: by mail-lf1-f67.google.com with SMTP id y6so1452331lfj.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 04:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u1D/jMUPBggm7fKyOw8z+Z0IZWc9etepWNLlodOjDWo=;
        b=b6yYq+8MUVaj25CBZlpZHQ/DP8sDzm+IMMu+r01ltxON5VGSKcn5JWC4Xyr6diA/ms
         pFbRqFX1FIpEv5r34PRAJbdeakoIaYN+cvJBKwgUOhlKQNBYNK+C5QM3ou/maSITDOkg
         bo5oryduhQTU6OKzYsmmU8q/CkUMTLl6QiR8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u1D/jMUPBggm7fKyOw8z+Z0IZWc9etepWNLlodOjDWo=;
        b=RnfgTljIa+vzuvQ3hXbL805gvifV5A1uFoaT2OdV6VI3rbY502qfPMqyoXnbfB79/z
         nlEZ/YMlyrHjJegbiUy4E9X8vjyI6Nlha6eamy2l4cYXTtVwIGpd1gUQ1/0eok/Zzu8j
         sNRMy5iuWElF3dDeoP3blRNByMS+UfBckW0CnFtBPCbWKB1OISMq0YfBcQjXlm7OGuCZ
         6iLNDPL+9zAzQB4EzgwxEU4jbHiIZo7L6El3MrJvSqqKO7Px08IdlYGA8MV27rxV6owW
         JS9qMINxEwwButPWg6pLCDE/Qh3UU0YLHuacS0M9I2dZiXcZXYYpRp4PMMlzrnuk5JA7
         PGhg==
X-Gm-Message-State: APjAAAUTZ6EbS4YhF9ayIWLSgNg1MXPpcqdnl9UadDqftjLARr+FQmDS
        M7tQvCrNp3XMSHb4HbAyMLrt5Q==
X-Google-Smtp-Source: APXvYqwk/rFsFllBSvX2svytPOgkp/+5UQ6iaW4NM0ejEhAb/FHdMdB6UWMFOZwXsR2tmftQxBem1g==
X-Received: by 2002:ac2:5195:: with SMTP id u21mr2189413lfi.97.1573129278458;
        Thu, 07 Nov 2019 04:21:18 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id x1sm1937325lff.90.2019.11.07.04.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 04:21:17 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH v7 0/2] Add support for Layerscape external interrupt lines
Date:   Thu,  7 Nov 2019 13:21:13 +0100
Message-Id: <20191107122115.6244-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In v7, I've tried to change from a custom binding to use
interrupt-map, modelled on the recent addition of the
renesas,rza1-irqc (commits a644ccb819bc and 5e27a314a11f). It's
possible that the interrupt-map parsing code can be factored to a
common helper, but it's a bit hard to generalize from two examples to
know what a good interface would look like.

The interrupt-map-mask is a bit arbitrary. 0xff would likely work just
as well (but I think the ls2088a has 32 external lines, so it has to
be a least 0x1f).

Also, this drops the fsl,bit-reverse property and instead reads the
SCFGREVCR register to determine if bit-reversing is needed.

The dt/bindings patch now comes first in accordance with
Documentation/devicetree/bindings/submitting-patches.txt.

Earlier versions can be found here:

v6: https://lore.kernel.org/lkml/20190923101513.32719-1-kurt@linutronix.de/
v5: https://lore.kernel.org/lkml/20180223210901.23480-1-rasmus.villemoes@prevas.dk/

Rasmus Villemoes (2):
  dt/bindings: Add bindings for Layerscape external irqs
  irqchip: add support for Layerscape external interrupt lines

 .../interrupt-controller/fsl,ls-extirq.txt    |  49 +++++
 drivers/irqchip/Kconfig                       |   4 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-ls-extirq.c               | 197 ++++++++++++++++++
 4 files changed, 251 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
 create mode 100644 drivers/irqchip/irq-ls-extirq.c

-- 
2.23.0

