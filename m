Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73CBC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E14222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576782356;
	bh=PV0xUFIbqSUM/QVO5CU1Hx7+eOyNGkb2FSCxaY8XQJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V/Ucn99d9LIq3GWf9K8RCo3/anEI9FLW15FW5ChPOCVm4a5hsMd2xQCYQO9tkInqf
	 pL69b47/qeSqFwc9/phWDb/tHW/YfBpicJVUbquYtf/P0eMSTQ65hB3sQGFx/VOh3L
	 dr7TNIeIAvN2wF9708vsplPjSAURtWBP3yWfap6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfLSSpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:45:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:37470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727647AbfLSSpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:45:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5138C222C2;
        Thu, 19 Dec 2019 18:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781111;
        bh=PV0xUFIbqSUM/QVO5CU1Hx7+eOyNGkb2FSCxaY8XQJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uxoJRJz7TES6xgj3nv/YFcwXm/VHxHeYffzo8fs4juAQKhvN0IMEUOGZhrnaUedzg
         oiqGnKq7Atm48P5YSYNfA43NSvmxYRDeJ57p1RvmKvkeDGUsrR0Dn6ayRWTnMKV34s
         VAqOhbtsRNYmHUHvJJXZkPzNgEWVqLq7I4adihPs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 038/199] dmaengine: coh901318: Fix a double-lock bug
Date:   Thu, 19 Dec 2019 19:32:00 +0100
Message-Id: <20191219183217.027211912@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183214.629503389@linuxfoundation.org>
References: <20191219183214.629503389@linuxfoundation.org>
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
@@ -1802,8 +1802,6 @@ static int coh901318_config(struct coh90
 	int channel = cohc->id;
 	void __iomem *virtbase = cohc->base->virtbase;
 
-	spin_lock_irqsave(&cohc->lock, flags);
-
 	if (param)
 		p = param;
 	else
@@ -1823,8 +1821,6 @@ static int coh901318_config(struct coh90
 	coh901318_set_conf(cohc, p->config);
 	coh901318_set_ctrl(cohc, p->ctrl_lli_last);
 
-	spin_unlock_irqrestore(&cohc->lock, flags);
-
 	return 0;
 }
 


