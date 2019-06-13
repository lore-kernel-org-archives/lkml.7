Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95ED5C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EFED20679
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560441891;
	bh=0BJ9BWZWGvCl48KDUGUcFoK6J8/arRVbphHRp2rdDD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m4dZByuMQ2oQZMVQrshp9oBvnHo34cvIXjicRBpOVeLOZPzx8Uu/80R8ETBUIArn8
	 IfuPdyPTrJdh5WGrSGzH4ozSDuD9SHbTAvIsUOgpSCx0OpIC7rWu8AbW2r7nNK773B
	 q9Bw8nOmAb4t7vXsx/dIFCsTVFNTtjzTnWd166E4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391195AbfFMQEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:04:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:35270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731352AbfFMIqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:46:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22F12215EA;
        Thu, 13 Jun 2019 08:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415612;
        bh=0BJ9BWZWGvCl48KDUGUcFoK6J8/arRVbphHRp2rdDD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YinS7oja59qugWI9+mzmemdInBs+u31hImWabxPip3MECcr3MtGWNdrL1/qSGFp7J
         jriDv1mXjrvY3csNqQoEuX+MW+WMlWmQ0O1sZ/nmsdWmVqs2xH0BMP41OrsH2f5k+d
         NHDi5RuAccTMkJzabvKvzHi4z/gA9pZ84lUEPzxg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ludovic Barre <ludovic.barre@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 063/155] mmc: mmci: Prevent polling for busy detection in IRQ context
Date:   Thu, 13 Jun 2019 10:32:55 +0200
Message-Id: <20190613075656.568242115@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075652.691765927@linuxfoundation.org>
References: <20190613075652.691765927@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 8520ce1e17799b220ff421d4f39438c9c572ade3 ]

The IRQ handler, mmci_irq(), loops until all status bits have been cleared.
However, the status bit signaling busy in variant->busy_detect_flag, may be
set even if busy detection isn't monitored for the current request.

This may be the case for the CMD11 when switching the I/O voltage, which
leads to that mmci_irq() busy loops in IRQ context. Fix this problem, by
clearing the status bit for busy, before continuing to validate the
condition for the loop. This is safe, because the busy status detection has
already been taken care of by mmci_cmd_irq().

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/mmci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 387ff14587b8..e27978c47db7 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1550,9 +1550,10 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 		}
 
 		/*
-		 * Don't poll for busy completion in irq context.
+		 * Busy detection has been handled by mmci_cmd_irq() above.
+		 * Clear the status bit to prevent polling in IRQ context.
 		 */
-		if (host->variant->busy_detect && host->busy_status)
+		if (host->variant->busy_detect_flag)
 			status &= ~host->variant->busy_detect_flag;
 
 		ret = 1;
-- 
2.20.1



