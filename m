Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC6CC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED14120866
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413921;
	bh=2t/IrvB4eJyhojy7MPif2j02JqHk+eNwDHMPvDXIcdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O+xdNEBUyIJOpEyfLeQzgunGYJYc4TUCRjJRWJBqqfACR8v2hWDcVF/B3cnwT4pas
	 8EcMDon/xdICMy+ynlIFaRTacOwdufX8ajprBSRkokOsPY6m5vBhCcKSPgayrWXPsN
	 i3Ye2DOG5sIYNgHQP+a1ahwJ0Iv76cR2luYg/zzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730682AbfLCW6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:58:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:55100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730668AbfLCW6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:58:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8AC220863;
        Tue,  3 Dec 2019 22:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413917;
        bh=2t/IrvB4eJyhojy7MPif2j02JqHk+eNwDHMPvDXIcdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xRd3cCmWvitA0YHxmiVhCN8OB1XAoVIhVguuVSdl1XkFTCjLCTsBPLAUvkwyZiZMw
         FYXNNgRM7ovX8tsw1OAKOeNN79JAQuiMjLkHwrYhtWuh84mrY90Wdyh+Y2udBp1ltE
         dXEm0plcMiXL8ixnzTiMVmcHBroPs9DbPpCStTYg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ludovic Barre <ludovic.barre@st.com>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 4.19 313/321] mailbox: mailbox-test: fix null pointer if no mmio
Date:   Tue,  3 Dec 2019 23:36:19 +0100
Message-Id: <20191203223443.430018552@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Dessenne <fabien.dessenne@st.com>

commit 6899b4f7c99c72968e58e502f96084f74f6e5e86 upstream.

Fix null pointer issue if resource_size is called with no ioresource.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mailbox/mailbox-test.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/drivers/mailbox/mailbox-test.c
+++ b/drivers/mailbox/mailbox-test.c
@@ -363,22 +363,24 @@ static int mbox_test_probe(struct platfo
 
 	/* It's okay for MMIO to be NULL */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	size = resource_size(res);
 	tdev->tx_mmio = devm_ioremap_resource(&pdev->dev, res);
-	if (PTR_ERR(tdev->tx_mmio) == -EBUSY)
+	if (PTR_ERR(tdev->tx_mmio) == -EBUSY) {
 		/* if reserved area in SRAM, try just ioremap */
+		size = resource_size(res);
 		tdev->tx_mmio = devm_ioremap(&pdev->dev, res->start, size);
-	else if (IS_ERR(tdev->tx_mmio))
+	} else if (IS_ERR(tdev->tx_mmio)) {
 		tdev->tx_mmio = NULL;
+	}
 
 	/* If specified, second reg entry is Rx MMIO */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	size = resource_size(res);
 	tdev->rx_mmio = devm_ioremap_resource(&pdev->dev, res);
-	if (PTR_ERR(tdev->rx_mmio) == -EBUSY)
+	if (PTR_ERR(tdev->rx_mmio) == -EBUSY) {
+		size = resource_size(res);
 		tdev->rx_mmio = devm_ioremap(&pdev->dev, res->start, size);
-	else if (IS_ERR(tdev->rx_mmio))
+	} else if (IS_ERR(tdev->rx_mmio)) {
 		tdev->rx_mmio = tdev->tx_mmio;
+	}
 
 	tdev->tx_channel = mbox_test_request_channel(pdev, "tx");
 	tdev->rx_channel = mbox_test_request_channel(pdev, "rx");


