Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04843C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE9AC21743
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565291240;
	bh=++uSOrt4tDaGmr2p+dUS8dFJOIhmbjsJLzIaummuA+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EPDbEVIwmH1Wzq6P4pXixi6K1DfT6isqvvrsnizrO7Bi0sQpbczUCQBYCzsS2Gmg2
	 5HAlSHi2qZKoBWs8Oq+PhWKXJDCj4MPJNJgJ/fpcwSAc5c9Da6I6oxcWGZXq2Dph0w
	 QJEzMBsEQzYRBruK8mLk06F7bFHIbMyd1wVubrb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404646AbfHHTHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:07:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404609AbfHHTHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:07:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 751D52173E;
        Thu,  8 Aug 2019 19:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565291231;
        bh=++uSOrt4tDaGmr2p+dUS8dFJOIhmbjsJLzIaummuA+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x9t44HgaV4rRZtslFxBdKEkP+DRxrN67r51CMjJiiORCy61gRxA+JH81XUEbZhLPo
         NuefPNn24jgSq6FDACZJQYbNSjxdYjXMXXJAgO74O8IiZec94OdCQq8CnyeM17mRMC
         yZ5dW0db5KWhLi3Sq6GvYe7MNBnLR5Yj4bs4wl3g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 35/56] ocelot: Cancel delayed work before wq destruction
Date:   Thu,  8 Aug 2019 21:05:01 +0200
Message-Id: <20190808190454.431401177@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808190452.867062037@linuxfoundation.org>
References: <20190808190452.867062037@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Manoil <claudiu.manoil@nxp.com>

[ Upstream commit c5d139697d5d9ecf9c7cd92d7d7838a173508900 ]

Make sure the delayed work for stats update is not pending before
wq destruction.
This fixes the module unload path.
The issue is there since day 1.

Fixes: a556c76adc05 ("net: mscc: Add initial Ocelot switch support")

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mscc/ocelot.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -1797,6 +1797,7 @@ EXPORT_SYMBOL(ocelot_init);
 
 void ocelot_deinit(struct ocelot *ocelot)
 {
+	cancel_delayed_work(&ocelot->stats_work);
 	destroy_workqueue(ocelot->stats_queue);
 	mutex_destroy(&ocelot->stats_lock);
 }


