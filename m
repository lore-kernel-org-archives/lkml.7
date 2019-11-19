Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2627C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9461821823
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141581;
	bh=9Z9PeVMgmbJrx/z7THVYJryxPwx40uyoJ4isNwdXKNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zj1T0lKkpBCiTL4v8UjtVhnptQ415ZbUOLsd+zMDY8Kxa039SyJ56qYS9nK3cVxDs
	 9ZqnuHQfo+MpWowl2tD6HTh3Zoa3NR6t+OOH0Zr7VI9+y2prssQIbhUuTVtJRqr9le
	 JESwFB/QjdWDk4kPDO4v7NOx2KEjEGiyjnVTGNl4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbfKSFdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:33:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:53386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729471AbfKSFc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:32:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E155A21783;
        Tue, 19 Nov 2019 05:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141577;
        bh=9Z9PeVMgmbJrx/z7THVYJryxPwx40uyoJ4isNwdXKNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=frEI5skBDKKNnSDL1LV5aUy1Kq+MpIJt6dlW0nXwmK0gExdh/C7HY/sn2G+i8zpjd
         dWFhJRRkDgU2CZ7EcDw18/kbsJbcTieN2fn+G2TyttJtL2ls5ZH6klvBvuV+e6KII0
         nxMdQylQ6YCIVZjMBIOIr4KR6Dj92AApB62D7NxU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 208/422] drivers: qcom: rpmh-rsc: clear wait_for_compl after use
Date:   Tue, 19 Nov 2019 06:16:45 +0100
Message-Id: <20191119051412.070295360@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lina Iyer <ilina@codeaurora.org>

[ Upstream commit 09e97b6c8754c91470455e69ebd827b741f80af5 ]

The wait_for_compl register ensures the request sequence is maintained
when sending requests from the TCS. Clear the register after sending
active request and during invalidate of the sleep and wake TCS.

Reported-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/qcom/rpmh-rsc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index ee75da66d64bf..75bd9a83aef00 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -121,6 +121,7 @@ static int tcs_invalidate(struct rsc_drv *drv, int type)
 			return -EAGAIN;
 		}
 		write_tcs_reg_sync(drv, RSC_DRV_CMD_ENABLE, m, 0);
+		write_tcs_reg_sync(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, m, 0);
 	}
 	bitmap_zero(tcs->slots, MAX_TCS_SLOTS);
 	spin_unlock(&tcs->lock);
@@ -239,6 +240,7 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
 skip:
 		/* Reclaim the TCS */
 		write_tcs_reg(drv, RSC_DRV_CMD_ENABLE, i, 0);
+		write_tcs_reg(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, i, 0);
 		write_tcs_reg(drv, RSC_DRV_IRQ_CLEAR, 0, BIT(i));
 		spin_lock(&drv->lock);
 		clear_bit(i, drv->tcs_in_use);
-- 
2.20.1



