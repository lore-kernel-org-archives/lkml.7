Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C36CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514E4205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572905439;
	bh=XRJhMZLFukaSWSE6KfLdlTZkNQnshra3dKvIQaYoG6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0XkhUJrvQr/B6iPlIRWMdEjzgU2NmM2NczL2A8onAbI0Dtq9PQ5LKLw72wvWY847w
	 aVI4gM4fd86XKsDINakgjswJPmyK3hg7cK1RkVUSn6neLjjOFgiKGfNjCenAdEluin
	 AOB1bgveUVQhCg1nXrIdR5wa/1ebrzZj20JcqrsQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390196AbfKDWKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:10:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:43782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390552AbfKDWKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:10:34 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B62AB20650;
        Mon,  4 Nov 2019 22:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572905433;
        bh=XRJhMZLFukaSWSE6KfLdlTZkNQnshra3dKvIQaYoG6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jv4tVeTQ0KO1kVKNeYWt2LUkpzigS3dnDtAqh6j0JfpMvR0XLhLGwRQxFUW1dp8E+
         OEqxgOPiTH6Zp+ZvNQcBrqcD74rqcRmIpc17T9PgnqafyyMy+1Wm9lGC3GEIrBZD3R
         iEPB9ofBxBdXnw9d83g9DrGvJzgqj8iilSi/zwzU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sebastian Ott <sebott@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>,
        Alexander Schmidt <alexs@linux.ibm.com>
Subject: [PATCH 5.3 091/163] s390/pci: fix MSI message data
Date:   Mon,  4 Nov 2019 22:44:41 +0100
Message-Id: <20191104212146.786936467@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212140.046021995@linuxfoundation.org>
References: <20191104212140.046021995@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Ott <sebott@linux.ibm.com>

[ Upstream commit cf2c4a3f35b75d38cebb4afbd578f1594f068d1e ]

After recent changes the MSI message data needs to specify the
function-relative IRQ number.

Reported-and-tested-by: Alexander Schmidt <alexs@linux.ibm.com>
Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/pci/pci_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index d80616ae8dd8a..fbe97ab2e2286 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -284,7 +284,7 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 			return rc;
 		irq_set_chip_and_handler(irq, &zpci_irq_chip,
 					 handle_percpu_irq);
-		msg.data = hwirq;
+		msg.data = hwirq - bit;
 		if (irq_delivery == DIRECTED) {
 			msg.address_lo = zdev->msi_addr & 0xff0000ff;
 			msg.address_lo |= msi->affinity ?
-- 
2.20.1



