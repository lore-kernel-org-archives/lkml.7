Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E932C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7540E21872
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639039;
	bh=/ooMEr3sMXswUrQXLTg5AgIOva1OMjNOZyVecNJhe0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vN9u/mPXrtLXEcdLvCB1ecEHeGQ8DrG4Z0sJWsJCoS2F7ZCYn1JQSFjHENJgn+8Z2
	 GpqL/sU2b0UN2rmPWnN3jnoGNVjDQ79VWUKX9tO+AZ3/3rJHkKhpm+qTwgrKQBA0Zi
	 h76pzVjtRDj9iLMQZSAeuuJgjpOzg1dHrY7bZyAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388954AbfEWTRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:17:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389375AbfEWTRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:17:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EF7C21850;
        Thu, 23 May 2019 19:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639035;
        bh=/ooMEr3sMXswUrQXLTg5AgIOva1OMjNOZyVecNJhe0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OVlkoLw9yZCdz9k8aIR493ujs+Hv9BMKp+voEcNxHwu+BWKy53maUugHLTuMeFQao
         MFKYNKrEBCFHOIPF2OqKCl4m1B5/xTXwNQ+sktIPXpdNjZfSwGaJqzB4jj7xzcGMIG
         42/esXhUUDmg+QN7Rs09/EHu9A/m5YHB1tbnMod4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH 4.19 055/114] memory: tegra: Fix integer overflow on tick value calculation
Date:   Thu, 23 May 2019 21:05:54 +0200
Message-Id: <20190523181736.617188244@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181731.372074275@linuxfoundation.org>
References: <20190523181731.372074275@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

commit b906c056b6023c390f18347169071193fda57dde upstream.

Multiplying the Memory Controller clock rate by the tick count results
in an integer overflow and in result the truncated tick value is being
programmed into hardware, such that the GR3D memory client performance is
reduced by two times.

Cc: stable <stable@vger.kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/memory/tegra/mc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -280,7 +280,7 @@ static int tegra_mc_setup_latency_allowa
 	u32 value;
 
 	/* compute the number of MC clock cycles per tick */
-	tick = mc->tick * clk_get_rate(mc->clk);
+	tick = (unsigned long long)mc->tick * clk_get_rate(mc->clk);
 	do_div(tick, NSEC_PER_SEC);
 
 	value = readl(mc->regs + MC_EMEM_ARB_CFG);


