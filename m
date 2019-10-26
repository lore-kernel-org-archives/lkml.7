Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99644CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605CA206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572096849;
	bh=2IDKfjUQ8KiFiVXJR6D3b6GiSh0OQrxFdYB8PP8LW4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JbikuZjz65D0buQcPHoiRHKbsxwnBIyAZ7lQA5uuaLrhgcsBYsNvJjNChqEHWBwdZ
	 F71UfmyHNY7zadH0Ui6HGwl3bxHt7z19iFwQgovbSw9ncbridHHc0URxdVUoWplD25
	 jCwV7ILrJT0FaMnog3w0rwhLQmO8RpzQNZN3pno0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfJZNeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 09:34:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727465AbfJZNRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 09:17:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2BB221D81;
        Sat, 26 Oct 2019 13:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572095868;
        bh=2IDKfjUQ8KiFiVXJR6D3b6GiSh0OQrxFdYB8PP8LW4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s6YAPDEO0ZW4N2k5me8ENYQnVlJoBNno1ULYzEpPFoPNkS4S5pTJaeas8eu/RuTRX
         qQYqo5vzcBiBgHR6bJnLuPT9Bg/q66YtAoM+IiZ5H+LeXZb2uVLO8b+y3kIeFqWxXz
         iXAjYfCkPwGRiuMrW5gari29RbyEeY0/D0y5+5YQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 58/99] net/ibmvnic: Fix EOI when running in XIVE mode.
Date:   Sat, 26 Oct 2019 09:15:19 -0400
Message-Id: <20191026131600.2507-58-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191026131600.2507-1-sashal@kernel.org>
References: <20191026131600.2507-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cédric Le Goater <clg@kaod.org>

[ Upstream commit 11d49ce9f7946dfed4dcf5dbde865c78058b50ab ]

pSeries machines on POWER9 processors can run with the XICS (legacy)
interrupt mode or with the XIVE exploitation interrupt mode. These
interrupt contollers have different interfaces for interrupt
management : XICS uses hcalls and XIVE loads and stores on a page.
H_EOI being a XICS interface the enable_scrq_irq() routine can fail
when the machine runs in XIVE mode.

Fix that by calling the EOI handler of the interrupt chip.

Fixes: f23e0643cd0b ("ibmvnic: Clear pending interrupt after device reset")
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 5cb55ea671e35..964e7d62f4b13 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2772,12 +2772,10 @@ static int enable_scrq_irq(struct ibmvnic_adapter *adapter,
 
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
-- 
2.20.1

