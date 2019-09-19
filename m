Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6BBC49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44115208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568932370;
	bh=G/uRdqFkHn7/5EBZ7Enh1oxM91e/mho9qyCW+FhVgXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fh5U5+OAHDly9PAt0y7+qf8cTnC1SzgIQiK8lXLRcDmIfpwdrfqWDw5aZHqPDTsON
	 k8nOoUlKhgnKmq1LNqk/IkCpAv86N5XA7kPGhIsBNGb2feTKHVkcGBTmmJRQgju1qt
	 UvMivVuojS8qbQ4nyb8CksPTxfpt5VfVFld2He40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406630AbfISWct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:32:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbfISWMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:12:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA77121907;
        Thu, 19 Sep 2019 22:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931157;
        bh=G/uRdqFkHn7/5EBZ7Enh1oxM91e/mho9qyCW+FhVgXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fkUXE+yCuyEQwVQrOuiBrtyeihWHDymMT7WZ8q6+u/DdCmrbUZ5U22oFhHFqJunYP
         s2Woz2sxDBeIE3KdKtVeiqFVF2JRvi37hM+1g9scIH2jjU0XQrqKS1QWEcZDIFvFP1
         NpdbATLLHHH2LVK09ZdnFGCs2GSslQItMz5tCEk8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Keerthy <j-keerthy@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 23/79] bus: ti-sysc: Fix using configured sysc mask value
Date:   Fri, 20 Sep 2019 00:03:08 +0200
Message-Id: <20190919214810.050154383@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214807.612593061@linuxfoundation.org>
References: <20190919214807.612593061@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit e212abd452a4af3174fcd469d46656f83e135a19 ]

We have cases where there are no softreset bits like with am335x lcdc.
In that case ti,sysc-mask = <0> needs to be handled properly.

Tested-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/ti-sysc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index e4fe954e63a9b..4ca006e2137f7 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1022,10 +1022,7 @@ static int sysc_init_sysc_mask(struct sysc *ddata)
 	if (error)
 		return 0;
 
-	if (val)
-		ddata->cfg.sysc_val = val & ddata->cap->sysc_mask;
-	else
-		ddata->cfg.sysc_val = ddata->cap->sysc_mask;
+	ddata->cfg.sysc_val = val & ddata->cap->sysc_mask;
 
 	return 0;
 }
-- 
2.20.1



