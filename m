Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94058C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B6322309
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141083;
	bh=BPACXaFVQTm9exWl0MhTgT5qlYmiPd+LkRsxeBV1D1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WsAL+lutZXHAq9Gw9mnlCifJM1dzpUwcFN+9807p0OCwprdxBH1u3O3ujKJMiIE5F
	 ex10xF92GVxT/kFkEKLL1StQPwQZQ9IGzQKEgQys5NTZr5n7kYWGip5b0OR5+rVcYB
	 VE6NuwPgIM5ku80NEX8WhQzzD+9Q9QQswrrtCB/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfKSFYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:24:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:40920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728230AbfKSFYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:24:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 206CB2230F;
        Tue, 19 Nov 2019 05:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141077;
        bh=BPACXaFVQTm9exWl0MhTgT5qlYmiPd+LkRsxeBV1D1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=domZy7MI8StpR0mj7iP1Wj7HO0sHYIcllZiP7n2/3FirBfQv3kYAZ1fq5S8KR1XGn
         7T4oPqNTokd2oH/z5SRnt73aYkqRmtqqAefLd86HfRj+yKW9mY64qKSpnMpR+TZdec
         uyrilR3n0bOW9anxF/jx/QNSwUpL93qHatIQk4oI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rongyi Chen <chenyi@tt-cool.com>,
        Icenowy Zheng <icenowy@aosc.io>, Chen-Yu Tsai <wens@csie.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 037/422] clk: sunxi-ng: h6: fix PWM gate/reset offset
Date:   Tue, 19 Nov 2019 06:13:54 +0100
Message-Id: <20191119051402.386696523@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rongyi Chen <chenyi@tt-cool.com>

[ Upstream commit 58c0f79887d5e425fe6a9fd542778e50df69e9c6 ]

Currently the register offset of the PWM bus gate in Allwinner H6 clock
driver is wrong.

Fix this issue.

Fixes: 542353ea ("clk: sunxi-ng: add support for the Allwinner H6 CCU")
Signed-off-by: Rongyi Chen <chenyi@tt-cool.com>
[Icenowy: refactor commit message]
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
index 0f7a0ffd3f706..d425b47cef179 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
@@ -352,7 +352,7 @@ static SUNXI_CCU_GATE(bus_dbg_clk, "bus-dbg", "psi-ahb1-ahb2",
 static SUNXI_CCU_GATE(bus_psi_clk, "bus-psi", "psi-ahb1-ahb2",
 		      0x79c, BIT(0), 0);
 
-static SUNXI_CCU_GATE(bus_pwm_clk, "bus-pwm", "apb1", 0x79c, BIT(0), 0);
+static SUNXI_CCU_GATE(bus_pwm_clk, "bus-pwm", "apb1", 0x7ac, BIT(0), 0);
 
 static SUNXI_CCU_GATE(bus_iommu_clk, "bus-iommu", "apb1", 0x7bc, BIT(0), 0);
 
-- 
2.20.1



