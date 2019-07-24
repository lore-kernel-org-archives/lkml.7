Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25270C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F6420665
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563999224;
	bh=PAXPEwO2rUh1sVRSm5DvD0MwnfOcHcoH7M6v3dcmo0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ews34JLBuS0pZyQSc6vjwRTUg4+zbGiHo0V8cPLjloe7pS7cpoO44LKWe0M88X04y
	 ucvEL5PKKNvN7IMAIIXZvYc3kPgrWnfMxAa92OqLugR9ke4vPQNQNcNZGYVKKUIpTS
	 rZk3jLwT7/WzyItldVU6SDZzgodX1Rl1zGglw7Gw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392116AbfGXUNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:13:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40227 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404589AbfGXT4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:56:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9129E217D4;
        Wed, 24 Jul 2019 19:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998165;
        bh=PAXPEwO2rUh1sVRSm5DvD0MwnfOcHcoH7M6v3dcmo0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X+vFkkL4/tQITYQk2V2cbaXZGhu1uz3s4kZVeqkQxdbNcf/pxvyFZHMtEo2nZzSbr
         /O+lnO9/Fw7WTnRD+2DNeqO4D8CHhkDTR0Ppi05zy88fRLSiLpBvIhvRnTzIi3/fh6
         1TyEuR3FrfqnLBZpn8i+1iIK0AH1yZ9EzkluVwR0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 5.1 270/371] iwlwifi: pcie: dont service an interrupt that was masked
Date:   Wed, 24 Jul 2019 21:20:22 +0200
Message-Id: <20190724191744.625291835@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

commit 3b57a10ca14c619707398dc58fe5ece18c95b20b upstream.

Sometimes the register status can include interrupts that
were masked. We can, for example, get the RF-Kill bit set
in the interrupt status register although this interrupt
was masked. Then if we get the ALIVE interrupt (for example)
that was not masked, we need to *not* service the RF-Kill
interrupt.
Fix this in the MSI-X interrupt handler.

Cc: stable@vger.kernel.org
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c |   27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -2113,10 +2113,18 @@ irqreturn_t iwl_pcie_irq_msix_handler(in
 		return IRQ_NONE;
 	}
 
-	if (iwl_have_debug_level(IWL_DL_ISR))
-		IWL_DEBUG_ISR(trans, "ISR inta_fh 0x%08x, enabled 0x%08x\n",
-			      inta_fh,
+	if (iwl_have_debug_level(IWL_DL_ISR)) {
+		IWL_DEBUG_ISR(trans,
+			      "ISR inta_fh 0x%08x, enabled (sw) 0x%08x (hw) 0x%08x\n",
+			      inta_fh, trans_pcie->fh_mask,
 			      iwl_read32(trans, CSR_MSIX_FH_INT_MASK_AD));
+		if (inta_fh & ~trans_pcie->fh_mask)
+			IWL_DEBUG_ISR(trans,
+				      "We got a masked interrupt (0x%08x)\n",
+				      inta_fh & ~trans_pcie->fh_mask);
+	}
+
+	inta_fh &= trans_pcie->fh_mask;
 
 	if ((trans_pcie->shared_vec_mask & IWL_SHARED_IRQ_NON_RX) &&
 	    inta_fh & MSIX_FH_INT_CAUSES_Q0) {
@@ -2156,11 +2164,18 @@ irqreturn_t iwl_pcie_irq_msix_handler(in
 	}
 
 	/* After checking FH register check HW register */
-	if (iwl_have_debug_level(IWL_DL_ISR))
+	if (iwl_have_debug_level(IWL_DL_ISR)) {
 		IWL_DEBUG_ISR(trans,
-			      "ISR inta_hw 0x%08x, enabled 0x%08x\n",
-			      inta_hw,
+			      "ISR inta_hw 0x%08x, enabled (sw) 0x%08x (hw) 0x%08x\n",
+			      inta_hw, trans_pcie->hw_mask,
 			      iwl_read32(trans, CSR_MSIX_HW_INT_MASK_AD));
+		if (inta_hw & ~trans_pcie->hw_mask)
+			IWL_DEBUG_ISR(trans,
+				      "We got a masked interrupt 0x%08x\n",
+				      inta_hw & ~trans_pcie->hw_mask);
+	}
+
+	inta_hw &= trans_pcie->hw_mask;
 
 	/* Alive notification via Rx interrupt will do the real work */
 	if (inta_hw & MSIX_HW_INT_CAUSES_REG_ALIVE) {


