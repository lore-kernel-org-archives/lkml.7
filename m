Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E44CC2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5675324672
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576782743;
	bh=56QFzUMWtQU8kUR0DlruehlljdgnFAi9DLsxSd8O3Hc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zup9SvTZ4W3H6+B7WJFVkp/+Y7C05h7bpwrJ1ZEiNyHAA2XSSVWBUYxiRwKrl3nu/
	 HDm47a0TJWjBK/beNHjtRCQQaAEOLyvODQZPV3XIugFoU23Gr1Y8eybWmU2VsfoCn9
	 ZsU4na+5X5JMjH3Z2WKMhvnVV/FUAsT9plEDQg2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfLSTMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 14:12:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:54238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727733AbfLSSg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:36:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9087F24672;
        Thu, 19 Dec 2019 18:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576780618;
        bh=56QFzUMWtQU8kUR0DlruehlljdgnFAi9DLsxSd8O3Hc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Sstw86Jj6m7145POuvcQlKK30bUEvTo8/mmlcOaAFN9qTQq8M2RaVBG4wiLwC7mD
         Ura/hZy45TaS/3AYrRok89FuftvSkJvtc/3xRHHIldDV+EERV2VvfpSrPru4BmNqrH
         /iX+d02+z56fBqzuTLrccf3kJ0mIkJDf1AjE+F6Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 030/162] dmaengine: coh901318: Fix a double-lock bug
Date:   Thu, 19 Dec 2019 19:32:18 +0100
Message-Id: <20191219183209.489314295@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183150.477687052@linuxfoundation.org>
References: <20191219183150.477687052@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>

[ Upstream commit 627469e4445b9b12e0229b3bdf8564d5ce384dd7 ]

The function coh901318_alloc_chan_resources() calls spin_lock_irqsave()
before calling coh901318_config().
But coh901318_config() calls spin_lock_irqsave() again in its
definition, which may cause a double-lock bug.

Because coh901318_config() is only called by
coh901318_alloc_chan_resources(), the bug fix is to remove the
calls to spin-lock and -unlock functions in coh901318_config().

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/coh901318.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/drivers/dma/coh901318.c
+++ b/drivers/dma/coh901318.c
@@ -1815,8 +1815,6 @@ static int coh901318_config(struct coh90
 	int channel = cohc->id;
 	void __iomem *virtbase = cohc->base->virtbase;
 
-	spin_lock_irqsave(&cohc->lock, flags);
-
 	if (param)
 		p = param;
 	else
@@ -1836,8 +1834,6 @@ static int coh901318_config(struct coh90
 	coh901318_set_conf(cohc, p->config);
 	coh901318_set_ctrl(cohc, p->ctrl_lli_last);
 
-	spin_unlock_irqrestore(&cohc->lock, flags);
-
 	return 0;
 }
 


