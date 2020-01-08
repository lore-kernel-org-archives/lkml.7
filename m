Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577D8C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 21:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B5D72072A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 21:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="VLIoJRoL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbgAHVH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 16:07:58 -0500
Received: from o1.b.az.sendgrid.net ([208.117.55.133]:33506 "EHLO
        o1.b.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbgAHVHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 16:07:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:in-reply-to:references:to:cc:content-type:
        content-transfer-encoding;
        s=001; bh=l+ozEXcAcbxudZpKacgFo3ceEpSnl6xSv3pANc4ozyU=;
        b=VLIoJRoLLX6vp+0o/gTni8uvzBtky3Is0xxi4tlzNnK7kUf/Ae49zVMQ2jgR4BHUbHJS
        MZPiuf30fuSmtQqqvfKNHJ5bw2rzqTN/2gtlu/3eDMAX1xAwebb1sIqCRnr8daACy6/VZE
        euzThXCkZxiwuPgxZNITbJsQQDJwnw7G8=
Received: by filterdrecv-p3mdw1-56c97568b5-xjbx9 with SMTP id filterdrecv-p3mdw1-56c97568b5-xjbx9-19-5E1644A6-39
        2020-01-08 21:07:50.55100434 +0000 UTC m=+1974283.600906199
Received: from bionic.localdomain (unknown [98.128.173.80])
        by ismtpd0005p1lon1.sendgrid.net (SG) with ESMTP id 2iKuRjWuSoGvt9DqI_9m9w
        Wed, 08 Jan 2020 21:07:50.352 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 08/14] clk: rockchip: set parent rate for DCLK_VOP clock on
 rk3228
Date:   Wed, 08 Jan 2020 21:07:50 +0000 (UTC)
Message-Id: <20200108210740.28769-9-jonas@kwiboo.se>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200108210740.28769-1-jonas@kwiboo.se>
References: <20200108210740.28769-1-jonas@kwiboo.se>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h338FT8hLbQuZn3EF?=
 =?us-ascii?Q?h3noMqyfEkSUfLuG04rziUH9YtKqSQPgd3OlYiQ?=
 =?us-ascii?Q?bBtqVjSu834dHYTOnUcRfTOS81p7D21L6lvRaGD?=
 =?us-ascii?Q?Ik2Cv2MFNHStbP1jOJyWPRnAs28TI6XvCTq1+9F?=
 =?us-ascii?Q?apK42MKuLfCoIVPhabyqPSW2kFtlhbqGQ+sMzpr?=
 =?us-ascii?Q?guhf6X=2FT5tPETwGOhGCpQ=3D=3D?=
To:     Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>
Cc:     Jonas Karlman <jonas@kwiboo.se>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Zheng Yang <zhengyang@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/clk/rockchip/clk-rk3228.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3228.c b/drivers/clk/rockchip/clk-rk3228.c
index d17cfb7a3ff4..25f79af22cb8 100644
--- a/drivers/clk/rockchip/clk-rk3228.c
+++ b/drivers/clk/rockchip/clk-rk3228.c
@@ -410,7 +410,7 @@ static struct rockchip_clk_branch rk3228_clk_branches[] __initdata = {
 			RK2928_CLKSEL_CON(29), 0, 3, DFLAGS),
 	DIV(0, "sclk_vop_pre", "sclk_vop_src", 0,
 			RK2928_CLKSEL_CON(27), 8, 8, DFLAGS),
-	MUX(DCLK_VOP, "dclk_vop", mux_dclk_vop_p, 0,
+	MUX(DCLK_VOP, "dclk_vop", mux_dclk_vop_p, CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 			RK2928_CLKSEL_CON(27), 1, 1, MFLAGS),
 
 	FACTOR(0, "xin12m", "xin24m", 0, 1, 2),
-- 
2.17.1

