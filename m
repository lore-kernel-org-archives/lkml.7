Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC16C10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B032E2080F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383326;
	bh=jujcImgHDYGHQ7uDDwkXOSgG2q4SgjbpIX6MY4h8sRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q7RVculUfWzYpxYAuL5sFVznKwFdU95dxw2W42FTB535iIRX3FKQUNY2X7wxW8S5B
	 GLUSEx3QtkOqApSZyI5LP7WNNOej6YXUeMWlhfZZohCYq2u/U+/dPIttWFD4a12fPG
	 xyVLI5IbAWCI3c2MUQR6XdJC4RYh2K1bwJatB2xw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbfJFRfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:35:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730087AbfJFRfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:35:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9537420700;
        Sun,  6 Oct 2019 17:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383322;
        bh=jujcImgHDYGHQ7uDDwkXOSgG2q4SgjbpIX6MY4h8sRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zHgqQDX3zJJul7W+7CY++Dhn4AXcbZDcP0cSOm5NDqdMJ/D3oto5hFiKYb4ihJFFK
         awwD1XF0Bg7upLDhYuSWUFiSZTW1JV8jbkMtvVG/ceiQHAK2sVVifCuK0Nfnh8HiJH
         gJQSGLTsuFMIV7mO6rCg/5NK/jFkNuvMJSM8THuk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sam Bobroff <sbobroff@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 061/137] powerpc/eeh: Clear stale EEH_DEV_NO_HANDLER flag
Date:   Sun,  6 Oct 2019 19:20:45 +0200
Message-Id: <20191006171213.631387675@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171209.403038733@linuxfoundation.org>
References: <20191006171209.403038733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 89623962c7275..1fbe541856f5e 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -793,6 +793,10 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 		result = PCI_ERS_RESULT_DISCONNECT;
 	}
 
+	eeh_for_each_pe(pe, tmp_pe)
+		eeh_pe_for_each_dev(tmp_pe, edev, tmp)
+			edev->mode &= ~EEH_DEV_NO_HANDLER;
+
 	/* Walk the various device drivers attached to this slot through
 	 * a reset sequence, giving each an opportunity to do what it needs
 	 * to accomplish the reset.  Each child gets a report of the
@@ -981,7 +985,8 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
  */
 void eeh_handle_special_event(void)
 {
-	struct eeh_pe *pe, *phb_pe;
+	struct eeh_pe *pe, *phb_pe, *tmp_pe;
+	struct eeh_dev *edev, *tmp_edev;
 	struct pci_bus *bus;
 	struct pci_controller *hose;
 	unsigned long flags;
@@ -1050,6 +1055,10 @@ void eeh_handle_special_event(void)
 				    (phb_pe->state & EEH_PE_RECOVERING))
 					continue;
 
+				eeh_for_each_pe(pe, tmp_pe)
+					eeh_pe_for_each_dev(tmp_pe, edev, tmp_edev)
+						edev->mode &= ~EEH_DEV_NO_HANDLER;
+
 				/* Notify all devices to be down */
 				eeh_pe_state_clear(pe, EEH_PE_PRI_BUS, true);
 				eeh_set_channel_state(pe, pci_channel_io_perm_failure);
-- 
2.20.1



