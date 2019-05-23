Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E86FC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690CC206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639768;
	bh=8T1Tvz0pFoNbcqa2xr0vtm5OazC3Ix2HGzZSZ/OhBEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AEG2EVGuwhXYjQ+3Mutv/Br6Z3twH3KTcLOtrJS8wfJ1mV/tqPYl2iL1EieGnXMm1
	 +ZdfdlTUnbh5rMafXLRIeIBiPfUiVrpk2XMHYOyjiATQTjgaY8hzXXe51XBAeUtZq/
	 TRAS5MuXEt0hZ6f2ZM885m3gVz6nLc2npaNGKa2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391963AbfEWT31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:29:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391949AbfEWT3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:29:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA890206BA;
        Thu, 23 May 2019 19:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639764;
        bh=8T1Tvz0pFoNbcqa2xr0vtm5OazC3Ix2HGzZSZ/OhBEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u12mV0+dlASrBHmBpfcTR9tDNpCnOMR2o2XqvyontkCRg85TaspXNGpRtWfOMycU5
         78T/lkxRazqmZ2xz9dzTd9DxJ1W2uKnm6KoUu3g0e3KKE7po3SX/tdFj/rikUDDpoN
         0r0v1iDRzKxmdhKvUKlH7SZTcJrXXaS9FDDmrK0c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH 5.1 078/122] memory: tegra: Fix integer overflow on tick value calculation
Date:   Thu, 23 May 2019 21:06:40 +0200
Message-Id: <20190523181715.094872429@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181705.091418060@linuxfoundation.org>
References: <20190523181705.091418060@linuxfoundation.org>
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
@@ -282,7 +282,7 @@ static int tegra_mc_setup_latency_allowa
 	u32 value;
 
 	/* compute the number of MC clock cycles per tick */
-	tick = mc->tick * clk_get_rate(mc->clk);
+	tick = (unsigned long long)mc->tick * clk_get_rate(mc->clk);
 	do_div(tick, NSEC_PER_SEC);
 
 	value = readl(mc->regs + MC_EMEM_ARB_CFG);


