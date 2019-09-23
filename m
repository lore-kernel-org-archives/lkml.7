Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2015C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2CED20867
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439388AbfIWKPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 06:15:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57820 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407636AbfIWKPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 06:15:34 -0400
Received: from [5.158.153.52] (helo=kurt.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt@linutronix.de>)
        id 1iCLNS-0001oR-9t; Mon, 23 Sep 2019 12:15:30 +0200
From:   Kurt Kanzenbach <kurt@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        devicetree@vger.kernel.org, Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH v6 0/2] Add support for Layerscape external interrupt lines
Date:   Mon, 23 Sep 2019 12:15:11 +0200
Message-Id: <20190923101513.32719-1-kurt@linutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is a respin of getting the support for the Layerscape's external interrupt
lines. The last version from Rasmus Villemoes can be found here:

 https://lkml.kernel.org/r/20180223210901.23480-1-rasmus.villemoes@prevas.dk/

Rasmus Villemoes ran out of time, so I prepared v6.

Changes since v5:

 - Rebase to v5.3.0
 - Integrated Thomas Gleixner comments:
   - Adjust order of local variables
   - Use irq_chip_set_type_parent()
   - Cleanup of irq headers
 - Integrated Rob Herring comments:
   - Add #address-cells and #size-cells to parent
 - Use ARCH_LAYERSCAPE, as this feature is not LS1021A specific

It is tested on a Layerscape LS2088A.

Thanks,
Kurt

Rasmus Villemoes (2):
  irqchip: Add support for Layerscape external interrupt lines
  dt/bindings: Add bindings for Layerscape external irqs

 .../interrupt-controller/fsl,ls-extirq.txt    |  47 +++++
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-ls-extirq.c               | 174 ++++++++++++++++++
 3 files changed, 222 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
 create mode 100644 drivers/irqchip/irq-ls-extirq.c

-- 
2.20.1

