Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F28BC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7032054F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557154588;
	bh=wSF1rZpdzAqgbTHCypVuZXS9cGeEhisqDgsiN6qgusU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mFFiGtOPDeV2N1+R8B4IRJmwd8VpuzbviQLPvzccQn78Fl5OLkol8mY2KVrVzqqHS
	 wBL4FkPUrWstLPThHXZ56Eg4B+1vU32taTKlQlqfEnUht12JU69mAxT5eb6DghPNY5
	 r4t53lOMGCz04hSchuWSrWCUdAp+7mjUEBLBUX34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbfEFOpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:45:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728322AbfEFOpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:45:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CF872053B;
        Mon,  6 May 2019 14:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153904;
        bh=wSF1rZpdzAqgbTHCypVuZXS9cGeEhisqDgsiN6qgusU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=baFHLNX81uP8QvuMDRKzb9Taa96OhrT+oTX310atOI0y7hsPUYef9pgLufvVth3zL
         SrBj7RPKkOE9YMXuhxdAPygAWLnYj+OHEjsWyZ90PtuC62g0Xt89st+yn4GJMW6d72
         nL2+ubcVWgZs0KRC+7vugSe8czVybrocArxN6BZU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@nokia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 39/75] net: stmmac: dont log oversized frames
Date:   Mon,  6 May 2019 16:32:47 +0200
Message-Id: <20190506143056.761302074@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143053.287515952@linuxfoundation.org>
References: <20190506143053.287515952@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 057a0c5642a2ff2db7c421cdcde34294a23bf37b ]

This is log is harmful as it can trigger multiple times per packet. Delete
it.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
index db4cee57bb24..66c17bab5997 100644
--- a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
@@ -91,8 +91,6 @@ static int ndesc_get_rx_status(void *data, struct stmmac_extra_stats *x,
 		return dma_own;
 
 	if (unlikely(!(rdes0 & RDES0_LAST_DESCRIPTOR))) {
-		pr_warn("%s: Oversized frame spanned multiple buffers\n",
-			__func__);
 		stats->rx_length_errors++;
 		return discard_frame;
 	}
-- 
2.20.1



