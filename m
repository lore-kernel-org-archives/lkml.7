Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3FBC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3DD218EA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563996187;
	bh=wANQe52zrBRb4Xw+3bw6crTD8mEUNcXjq3SEyZdmO1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YcagSdW1rJAc8OIsbYac1hdTa7NcL526+MfS2+2E5WVFVtQOzJEfYbN8lpm9kNJX2
	 Fv1cRHPQP4mZ/HHLJ9wfgv6646yZ2IVc7tvZUEnTdaxJ0mjJ0OGl1g48MojR2nEgOL
	 eInud8G+vx6XAStJlZWr9WxFA4sPLxZZSE7YoOVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfGXTXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:23:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbfGXTXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:23:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 116E5218EA;
        Wed, 24 Jul 2019 19:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996182;
        bh=wANQe52zrBRb4Xw+3bw6crTD8mEUNcXjq3SEyZdmO1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DuArbXtUJahLN1vB6bceWEiB9ZeipT3YuQcxJD+SNJhy5ToIVViqJKB6LN4lU0KFV
         CT0Zeg9DdPmQqqbrjqnWZtCPgehNROPht/dfJnEFS8+HkDFAnnk+4c82p/q56PKoVi
         VkgzUmiNujSOREFkf261MkCaZN+lPCG0blFHXg8I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maya Erez <merez@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 010/413] wil6210: fix missed MISC mbox interrupt
Date:   Wed, 24 Jul 2019 21:15:01 +0200
Message-Id: <20190724191736.061205210@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 7441be71ba7e07791fd4fa2b07c932dff14ff4d9 ]

When MISC interrupt is triggered due to HALP bit, in parallel
to mbox events handling by the MISC threaded IRQ, new mbox
interrupt can be missed in the following scenario:
1. MISC ICR is read in the IRQ handler
2. Threaded IRQ is completed and all MISC interrupts are unmasked
3. mbox interrupt is set by FW
4. HALP is masked
The mbox interrupt in step 3 can be missed due to constant high level
of ICM.
Masking all MISC IRQs instead of masking only HALP bit in step 4
will guarantee that ICM will drop to 0 and interrupt will be triggered
once MISC interrupts will be unmasked.

Signed-off-by: Maya Erez <merez@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/wil6210/interrupt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wil6210/interrupt.c b/drivers/net/wireless/ath/wil6210/interrupt.c
index 3f5bd177d55f..e41ba24011d8 100644
--- a/drivers/net/wireless/ath/wil6210/interrupt.c
+++ b/drivers/net/wireless/ath/wil6210/interrupt.c
@@ -580,7 +580,7 @@ static irqreturn_t wil6210_irq_misc(int irq, void *cookie)
 			/* no need to handle HALP ICRs until next vote */
 			wil->halp.handle_icr = false;
 			wil_dbg_irq(wil, "irq_misc: HALP IRQ invoked\n");
-			wil6210_mask_halp(wil);
+			wil6210_mask_irq_misc(wil, true);
 			complete(&wil->halp.comp);
 		}
 	}
-- 
2.20.1



