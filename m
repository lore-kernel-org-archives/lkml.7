Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A41C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC06204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556811856;
	bh=9cfkjKJhKFyg+kUI5gYHuFHBzIfYZ/2LtqZ2CTwKTI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RkMhQKlfAXI4Chht1rUwCRgKjeNCrntEV5LnnYYWSI1b0p+8m4ZmpZnx570lfVkkU
	 37RVEj8XNPU6vlSi5xZBVo6tHg0UkB8PD9Sm5/pRDecCF4smuQKgTDGoT5CnGYQZwr
	 C+y+VaV9DN1lcKzvXr08zfSjdye0gy0E4pVTGw/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfEBP0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:26:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:43426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727793AbfEBP0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:26:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35CD720449;
        Thu,  2 May 2019 15:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556810801;
        bh=9cfkjKJhKFyg+kUI5gYHuFHBzIfYZ/2LtqZ2CTwKTI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2SndJlxrIYn8L20HFvaGGAJ8tMQGECcrkCgxs662DGwI69CHdmR3yuNohytAFtQaV
         wwHekmqR8Hkb6cHFEs/IUTqfw299ZPMLEswyoS+UZNPazgZEd3HqImNvYGvBzHDGe0
         d7tAlgVR61/nPUc8VlWorgpM+Haim213mvFuNe5w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Frank Pavlic <f.pavlic@kunbus.de>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Nishanth Menon <nm@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 4.19 34/72] net: ks8851: Reassert reset pin if chip ID check fails
Date:   Thu,  2 May 2019 17:20:56 +0200
Message-Id: <20190502143336.216832866@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143333.437607839@linuxfoundation.org>
References: <20190502143333.437607839@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index a93f8e842c07..1633fa5c709c 100644
--- a/drivers/net/ethernet/micrel/ks8851.c
+++ b/drivers/net/ethernet/micrel/ks8851.c
@@ -1554,9 +1554,9 @@ static int ks8851_probe(struct spi_device *spi)
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



