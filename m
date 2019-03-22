Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EEFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32642082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255310;
	bh=LpFt8lyuvV1ikTSLTVQUiIKgZGuzDDVg2RVwEYC2r1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gSg0t15J9cFN0lMPADn9SCaipdu8X0hIHxqMpuMexvf+hGJXtlAwuxiI/r82NJ8vY
	 M3gCaeLM0bFT7Qn2pozz13qnN2PImLJrCCDu83HdpV058F8ajmDrmNxJrfsjJVhNf0
	 3ELUakPTIg1PIbrN7y6ex6z9IVmaRuYkfP6C+kRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731985AbfCVLs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:48:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732309AbfCVLs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:48:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F0AB218B0;
        Fri, 22 Mar 2019 11:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255305;
        bh=LpFt8lyuvV1ikTSLTVQUiIKgZGuzDDVg2RVwEYC2r1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m/ySbL9T6+Nho0UWGfs7lrELaMdcypjDn6zXPv2sedR27BKe3DcTYHlS8lkmzUz30
         Q+gkg6RPymdFGc8S5qI8BgT/pz/hQnnzFTrl4m9jlHUXrjtQyyPRM8wxal7/h9zku3
         RcKbUn5n0i8mZjjj56AINOsjgJu0R9XCFm3kf2kE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 049/183] mailbox: bcm-flexrm-mailbox: Fix FlexRM ring flush timeout issue
Date:   Fri, 22 Mar 2019 12:14:37 +0100
Message-Id: <20190322111245.263961741@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit d7bf31a0f85faaf63c63c39d55154825a1eaaea9 ]

RING_CONTROL reg was not written due to wrong address, hence all
the subsequent ring flush was timing out.

Fixes: a371c10ea4b3 ("mailbox: bcm-flexrm-mailbox: Fix FlexRM ring flush sequence")

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/bcm-flexrm-mailbox.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index f052a3eb2098..7e3ed2714630 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -1381,9 +1381,9 @@ static void flexrm_shutdown(struct mbox_chan *chan)
 
 	/* Clear ring flush state */
 	timeout = 1000; /* timeout of 1s */
-	writel_relaxed(0x0, ring + RING_CONTROL);
+	writel_relaxed(0x0, ring->regs + RING_CONTROL);
 	do {
-		if (!(readl_relaxed(ring + RING_FLUSH_DONE) &
+		if (!(readl_relaxed(ring->regs + RING_FLUSH_DONE) &
 		      FLUSH_DONE_MASK))
 			break;
 		mdelay(1);
-- 
2.19.1



