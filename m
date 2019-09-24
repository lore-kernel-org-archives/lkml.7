Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B31AC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F34E21D7A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569344026;
	bh=qZqosOSUUlTXfXsVZzM32UlffubIg+RK4k30EBeBTFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jqs6lr8Z6QEREaw38XLL3NWot3Em7HXck620gnZuQ71CUq//V3FUQ53Qp3JMnHPKz
	 6v7OVsc5nREXIOMmVMtbu8ZKtW9KK9SmS1/a2hnnf+Z3wrBfxBHW9j7TnzbQvDqNqb
	 69R1n5vFaTQrEI18xXMarB9MOgPGUQZIrc00RmSM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441781AbfIXQxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:53:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441699AbfIXQwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:52:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BA1121D80;
        Tue, 24 Sep 2019 16:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569343955;
        bh=qZqosOSUUlTXfXsVZzM32UlffubIg+RK4k30EBeBTFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S6jnNeaYM7mO9F2lVeoCVuLJsJ9xS7ONKrhafbu7JurnPF5Wi24mvke/SkuRscC9H
         JbazRAJgyNNK+kgBb3q1XlDLtPFIVUFn++l1xb6UTNQEEMCkTIU95ZXw6vQYryW3V4
         KlxegmsKJ+0wmZPDC9equv+pHMOLnOBgeOIef0bA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sam Bobroff <sbobroff@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.4 10/14] powerpc/eeh: Clear stale EEH_DEV_NO_HANDLER flag
Date:   Tue, 24 Sep 2019 12:52:08 -0400
Message-Id: <20190924165214.28857-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924165214.28857-1-sashal@kernel.org>
References: <20190924165214.28857-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Bobroff <sbobroff@linux.ibm.com>

[ Upstream commit aa06e3d60e245284d1e55497eb3108828092818d ]

The EEH_DEV_NO_HANDLER flag is used by the EEH system to prevent the
use of driver callbacks in drivers that have been bound part way
through the recovery process. This is necessary to prevent later stage
handlers from being called when the earlier stage handlers haven't,
which can be confusing for drivers.

However, the flag is set for all devices that are added after boot
time and only cleared at the end of the EEH recovery process. This
results in hot plugged devices erroneously having the flag set during
the first recovery after they are added (causing their driver's
handlers to be incorrectly ignored).

To remedy this, clear the flag at the beginning of recovery
processing. The flag is still cleared at the end of recovery
processing, although it is no longer really necessary.

Also clear the flag during eeh_handle_special_event(), for the same
reasons.

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/b8ca5629d27de74c957d4f4b250177d1b6fc4bbd.1565930772.git.sbobroff@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/eeh_driver.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 9837c98caabe9..045038469295d 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -675,6 +675,10 @@ static bool eeh_handle_normal_event(struct eeh_pe *pe)
 	pr_warn("EEH: This PCI device has failed %d times in the last hour\n",
 		pe->freeze_count);
 
+	eeh_for_each_pe(pe, tmp_pe)
+		eeh_pe_for_each_dev(tmp_pe, edev, tmp)
+			edev->mode &= ~EEH_DEV_NO_HANDLER;
+
 	/* Walk the various device drivers attached to this slot through
 	 * a reset sequence, giving each an opportunity to do what it needs
 	 * to accomplish the reset.  Each child gets a report of the
@@ -840,7 +844,8 @@ static bool eeh_handle_normal_event(struct eeh_pe *pe)
 
 static void eeh_handle_special_event(void)
 {
-	struct eeh_pe *pe, *phb_pe;
+	struct eeh_pe *pe, *phb_pe, *tmp_pe;
+	struct eeh_dev *edev, *tmp_edev;
 	struct pci_bus *bus;
 	struct pci_controller *hose;
 	unsigned long flags;
@@ -919,6 +924,10 @@ static void eeh_handle_special_event(void)
 				    (phb_pe->state & EEH_PE_RECOVERING))
 					continue;
 
+				eeh_for_each_pe(pe, tmp_pe)
+					eeh_pe_for_each_dev(tmp_pe, edev, tmp_edev)
+						edev->mode &= ~EEH_DEV_NO_HANDLER;
+
 				/* Notify all devices to be down */
 				eeh_pe_state_clear(pe, EEH_PE_PRI_BUS);
 				bus = eeh_pe_bus_get(phb_pe);
-- 
2.20.1

