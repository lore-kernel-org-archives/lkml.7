Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5750DC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22BFA21851
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563509596;
	bh=TqdL7f/PqMNcy5u2uewEklBWw4dH4clfQc1IDLslypA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oSivwp3I0V6oEhS0OF/iygwIU2uJpdcnRC8rL9r4JNBhsXuc7uEscEDXPULeVMnXy
	 N48DI8HStRTPDPofKTOieYfBnZ9OXV5K+8duOxgwrDCeuACIchuRPpJJQSTixD2Lc+
	 C5vuxK7GFBrYiOrtabPhOfCRZNVO4n+OR5dIFFt0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389096AbfGSENP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:13:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:48966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389065AbfGSENL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:13:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29ADE21851;
        Fri, 19 Jul 2019 04:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509591;
        bh=TqdL7f/PqMNcy5u2uewEklBWw4dH4clfQc1IDLslypA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KzTAYCmBMU80aoKb9MXfe+/YYvLPAJEq2pBRMmMx8XQI3UCNReRYRjDD9dkEQgPKZ
         PZLRYAFXfbnUrtbvZnJe3QorRYlbWDOfNwFKxmVSJLL4iQUvyK0+WziFaPcNdfeo6v
         YNZR9O5Z3Z6TnlGYyjAxJ12lKQeGLn7Ef0nThwq4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wen Yang <wen.yang99@zte.com.cn>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-gpio@vger.kernel.org,
        linux-rockchip@lists.infradead.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 04/45] pinctrl: rockchip: fix leaked of_node references
Date:   Fri, 19 Jul 2019 00:12:23 -0400
Message-Id: <20190719041304.18849-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719041304.18849-1-sashal@kernel.org>
References: <20190719041304.18849-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wen.yang99@zte.com.cn>

[ Upstream commit 3c89c70634bb0b6f48512de873e7a45c7e1fbaa5 ]

The call to of_parse_phandle returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./drivers/pinctrl/pinctrl-rockchip.c:3221:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 3196, but without a corresponding object release within this function.
./drivers/pinctrl/pinctrl-rockchip.c:3223:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 3196, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-gpio@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-rockchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index f826793e972c..417cd3bd7e0c 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -2208,6 +2208,7 @@ static int rockchip_get_bank_data(struct rockchip_pin_bank *bank,
 						    base,
 						    &rockchip_regmap_config);
 		}
+		of_node_put(node);
 	}
 
 	bank->irq = irq_of_parse_and_map(bank->of_node, 0);
-- 
2.20.1

