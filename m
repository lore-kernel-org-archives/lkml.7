Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E80C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B6D20843
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560099598;
	bh=Wpgw0TDUGZYsGHzCIymzJWbj9GHxVRPuswZba+0s04s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fb7GwooVQsDByBsKR0x2rhtU3th6ulJwRDznto4sdSmPqxY26cfgs3GeJgB/7SiW/
	 sX4EfKhq28iLd+euT0MbvnBzJz4djS7i/n+PWMiS1xW0L+/o8J7z2wvO0VaLD0waUW
	 23cN8wrdQ+eMsjCFxovQ6G1MGNdXP+kkzencP5Vk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387759AbfFIQ74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:59:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:35946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733253AbfFIQ7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:59:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43901206DF;
        Sun,  9 Jun 2019 16:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099591;
        bh=Wpgw0TDUGZYsGHzCIymzJWbj9GHxVRPuswZba+0s04s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kNeLRf5o7JKeUDpYM9zRO7KMRqNUxR9Mweh8sr1ovkDeYZjiy0MnTK8FHvbdjMjqH
         2qQ/aQ2VzIgi/0zu5qLn2FZdsiutgIhOI34ci1dQb8HTo8h9znfG557AMcHvtpaoH6
         2dV3SWxyW9KBrtKD21T2jEfqBlz5T8nVmfxPilRM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH 4.4 050/241] memory: tegra: Fix integer overflow on tick value calculation
Date:   Sun,  9 Jun 2019 18:39:52 +0200
Message-Id: <20190609164149.219937643@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
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
@@ -72,7 +72,7 @@ static int tegra_mc_setup_latency_allowa
 	u32 value;
 
 	/* compute the number of MC clock cycles per tick */
-	tick = mc->tick * clk_get_rate(mc->clk);
+	tick = (unsigned long long)mc->tick * clk_get_rate(mc->clk);
 	do_div(tick, NSEC_PER_SEC);
 
 	value = readl(mc->regs + MC_EMEM_ARB_CFG);


