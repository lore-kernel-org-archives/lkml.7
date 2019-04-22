Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E503C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CEC021909
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962481;
	bh=dnc9wD2Cy4yMYXxKdrioOHdVeV/ZWTqT1D4Xfvgfc7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=afYNktMoNgwk/JpyuQBGO/JTBBI0ndcMzruvdagHOYYvGTSUHRQphEd2hKIt9GRyP
	 dVXdYrENZ8HFGPNm211CFKbyVWVJdowaIL6IZ55aa7SLJ1BniWygWrlyhQYZyo4Oxo
	 Jr8MHIZ2utZoSNBNl2l7+yU/QkAE59TtW33u3nig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbfDVTsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:48:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730414AbfDVTr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:47:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 350F521904;
        Mon, 22 Apr 2019 19:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962476;
        bh=dnc9wD2Cy4yMYXxKdrioOHdVeV/ZWTqT1D4Xfvgfc7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eGYTGVT2bJqrHZ1nZtoYjjtqfK+u5ebHInLJ3TMq3Yp7mpp1kD3KpLdbbAqC3kw6V
         FuPPj70jJI0N5R/UI9LFgUzvzCecPkT3idvqSTh1rVXPW4vod05/ltiycneFbkWi4P
         kSXWE3djxLxVBuD5XCkFACwmC1qlIEBPW0P0D2Lc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lukas Wunner <lukas@wunner.de>, Frank Pavlic <f.pavlic@kunbus.de>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Nishanth Menon <nm@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 15/43] net: ks8851: Reassert reset pin if chip ID check fails
Date:   Mon, 22 Apr 2019 15:46:59 -0400
Message-Id: <20190422194727.12495-15-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194727.12495-1-sashal@kernel.org>
References: <20190422194727.12495-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lukas Wunner <lukas@wunner.de>

[ Upstream commit 761cfa979a0c177d6c2d93ef5585cd79ae49a7d5 ]

Commit 73fdeb82e963 ("net: ks8851: Add optional vdd_io regulator and
reset gpio") amended the ks8851 driver to briefly assert the chip's
reset pin on probe. It also amended the probe routine's error path to
reassert the reset pin if a subsequent initialization step fails.

However the commit misplaced reassertion of the reset pin in the error
path such that it is not performed if the check of the Chip ID and
Enable Register (CIDER) fails. The error path is therefore slightly
asymmetrical to the probe routine's body. Fix it.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Frank Pavlic <f.pavlic@kunbus.de>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Nishanth Menon <nm@ti.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/net/ethernet/micrel/ks8851.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/micrel/ks8851.c b/drivers/net/ethernet/micrel/ks8851.c
index 556666b0d756..546a79b9cb15 100644
--- a/drivers/net/ethernet/micrel/ks8851.c
+++ b/drivers/net/ethernet/micrel/ks8851.c
@@ -1545,9 +1545,9 @@ static int ks8851_probe(struct spi_device *spi)
 	free_irq(ndev->irq, ks);
 
 err_irq:
+err_id:
 	if (gpio_is_valid(gpio))
 		gpio_set_value(gpio, 0);
-err_id:
 	regulator_disable(ks->vdd_reg);
 err_reg:
 	regulator_disable(ks->vdd_io);
-- 
2.19.1

