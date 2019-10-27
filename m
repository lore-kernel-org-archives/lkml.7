Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336AACA9EBC
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025B420717
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572211232;
	bh=dpkgng9xeRaRt0F4oNfxz4++ewDMoAlP1wKnaRG1FoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vgw8n61JghUnIvBapsxLE1R3gdCF8tG5iI4kj3vZn3vm8PumuMQHjJBrzKFr4p8o7
	 Ixs/uirUwJu3G3FUIkxsVGxoCYOZfW38WO2Juz1l0QWaduqbYrA+elcm03e1BnqCDz
	 AJCRwB4xEzROz8rQGZdp/iujEdhmmlg6vpiibySk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731721AbfJ0VUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:20:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730775AbfJ0VU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:20:26 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A78B0205C9;
        Sun, 27 Oct 2019 21:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572211226;
        bh=dpkgng9xeRaRt0F4oNfxz4++ewDMoAlP1wKnaRG1FoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EvZlq41bOGu+ilB+rGnzKHdrNtQdzn13f9vbwvHdJxVAwob8tBCU9b8mkYq5aoduH
         d8NfaYjXQ5RcavXBp28VwwSkpQ4nhmGc6TWtLxiY4SR5ZBwRx1X2HFPqc7Nt8JFeZO
         o80cT69L4y5Q2RGuTPQSBFOhFiVa6izfd1RgvfH0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.3 075/197] net/ibmvnic: Fix EOI when running in XIVE mode.
Date:   Sun, 27 Oct 2019 21:59:53 +0100
Message-Id: <20191027203355.692991500@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203351.684916567@linuxfoundation.org>
References: <20191027203351.684916567@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Cédric Le Goater" <clg@kaod.org>

[ Upstream commit 11d49ce9f7946dfed4dcf5dbde865c78058b50ab ]

pSeries machines on POWER9 processors can run with the XICS (legacy)
interrupt mode or with the XIVE exploitation interrupt mode. These
interrupt contollers have different interfaces for interrupt
management : XICS uses hcalls and XIVE loads and stores on a page.
H_EOI being a XICS interface the enable_scrq_irq() routine can fail
when the machine runs in XIVE mode.

Fix that by calling the EOI handler of the interrupt chip.

Fixes: f23e0643cd0b ("ibmvnic: Clear pending interrupt after device reset")
Signed-off-by: CÃ©dric Le Goater <clg@kaod.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2772,12 +2772,10 @@ static int enable_scrq_irq(struct ibmvni
 
 	if (adapter->resetting &&
 	    adapter->reset_reason == VNIC_RESET_MOBILITY) {
-		u64 val = (0xff000000) | scrq->hw_irq;
+		struct irq_desc *desc = irq_to_desc(scrq->irq);
+		struct irq_chip *chip = irq_desc_get_chip(desc);
 
-		rc = plpar_hcall_norets(H_EOI, val);
-		if (rc)
-			dev_err(dev, "H_EOI FAILED irq 0x%llx. rc=%ld\n",
-				val, rc);
+		chip->irq_eoi(&desc->irq_data);
 	}
 
 	rc = plpar_hcall_norets(H_VIOCTL, adapter->vdev->unit_address,


