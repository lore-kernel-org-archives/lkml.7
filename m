Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE73BC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 11:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE2F206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 11:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfLJLoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 06:44:19 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:39004 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727329AbfLJLoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 06:44:18 -0500
Received: from faui04g.informatik.uni-erlangen.de (faui04g.informatik.uni-erlangen.de [131.188.30.137])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 59B5624183C;
        Tue, 10 Dec 2019 12:44:16 +0100 (CET)
Received: by faui04g.informatik.uni-erlangen.de (Postfix, from userid 66991)
        id 4E5DB843353; Tue, 10 Dec 2019 12:44:16 +0100 (CET)
From:   Simon Geis <simon.geis@fau.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Simon Geis <simon.geis@fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Adam Zerella <adam.zerella@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Lukas Panzer <lukas.panzer@fau.de>
Subject: [PATCH v2 06/10] PCMCIA/i82092: move assignment out of if condition
Date:   Tue, 10 Dec 2019 12:43:31 +0100
Message-Id: <20191210114333.12239-7-simon.geis@fau.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210114333.12239-1-simon.geis@fau.de>
References: <20191210114333.12239-1-simon.geis@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve readability by moving the assignment out of if conditions.

Co-developed-by: Lukas Panzer <lukas.panzer@fau.de>
Signed-off-by: Lukas Panzer <lukas.panzer@fau.de>
Signed-off-by: Simon Geis <simon.geis@fau.de>

---
 drivers/pcmcia/i82092.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pcmcia/i82092.c b/drivers/pcmcia/i82092.c
index a2be520bc3d3..33c242f06e0a 100644
--- a/drivers/pcmcia/i82092.c
+++ b/drivers/pcmcia/i82092.c
@@ -77,7 +77,8 @@ static int i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *i
 
 	enter("i82092aa_pci_probe");
 
-	if ((ret = pci_enable_device(dev)))
+	ret = pci_enable_device(dev);
+	if (ret)
 		return ret;
 
 	pci_read_config_byte(dev, 0x40, &configbyte);  /* PCI Configuration Control */
@@ -133,7 +134,9 @@ static int i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *i
 
 	/* Register the interrupt handler */
 	dev_dbg(&dev->dev, "Requesting interrupt %i\n", dev->irq);
-	if ((ret = request_irq(dev->irq, i82092aa_interrupt, IRQF_SHARED, "i82092aa", i82092aa_interrupt))) {
+	ret = request_irq(dev->irq, i82092aa_interrupt, IRQF_SHARED,
+			  "i82092aa", i82092aa_interrupt);
+	if (ret) {
 		dev_err(&dev->dev,
 			"i82092aa: Failed to register IRQ %d, aborting\n",
 			dev->irq);
-- 
2.20.1

