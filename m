Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA94CC04AAB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 01:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7825D20675
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 01:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MO+HvV0m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfEHBhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 21:37:17 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43914 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfEHBhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 21:37:15 -0400
Received: by mail-pl1-f193.google.com with SMTP id n8so9062125plp.10;
        Tue, 07 May 2019 18:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DqAU2fl7ueh+wLGHmgeFPur6b2NKTLFLwgdDnl0iz7o=;
        b=MO+HvV0myiMPsHmpG3R2AIO0a3ZjFX0eCgbEt6mY4qSuagccBK32t5inIuHDp9HFau
         3p1q/GJkcpn62Ccf7MA1VwZ6I0uHB1LNvYxaXZmC6Od9HpLqBPl8Y8B53PecBxQdf1TC
         SvAvq57b08Y9shL+gxIr9X+Lqaq8d4q2NsBVKYbbblcCwAeu5RLnNCqNJw1Vpu8RzjOo
         SiPsJbfzVV1m/AcoDT0/sRUSMcIxCVeWBPMoaCx5DgX9nUooi5560wQ1cJ4zrdDfPnMF
         G2tXkla2LgKOhfbYOgOCHx/N14q4d3tN+53bG+JM0cI5rv4HxRxJVX2ZuplN6CF4vsC+
         Qp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DqAU2fl7ueh+wLGHmgeFPur6b2NKTLFLwgdDnl0iz7o=;
        b=FxostBw1L2IKmxmkh0Qu9gyut9uumVZnSmr+O8PrSiLuLARL/xUWuBItkvmVOTTM4K
         WqsaQooikojXmp0100Yp+m23KQKifZrSQvBdwV1Xw6/X/wCmyBLptGqHWQrKkt+wDhBN
         jYLabUrtmO90RTH7F5j28Fdt148t+T61LRdNwN6niFCts1Q6r5KRxMObg2YS9mvOVfM9
         rBB5hq2D6OU7Cq/zW0Cm+EPUCfgR+UV+zbCfMzfZ+IuxzFWvmPB2yYmZBi+k3oKlXQEv
         mytcEC0TjtjikhXYkXxxw2sa+cF4ZY/GQ8Xmhxs1xIbWPJF7jjpidHXndhGlcGxGLW2n
         /pNw==
X-Gm-Message-State: APjAAAWwJLZTHliFlVHAVf8oA9VF2oEs/hG+IszD0u/FO/d5oywTV3xm
        1iD+dmP3JyJjXgW1f8CxmMU=
X-Google-Smtp-Source: APXvYqyUb0Zmhd6QOZaIAZ1uHr+F8sup+B/g7gW4L0X9wJOGH/nvbm32RrjiveT9B5wJlOp9LvrHAg==
X-Received: by 2002:a17:902:4681:: with SMTP id p1mr44007659pld.139.1557279435001;
        Tue, 07 May 2019 18:37:15 -0700 (PDT)
Received: from localhost.localdomain (ec2-52-192-173-191.ap-northeast-1.compute.amazonaws.com. [52.192.173.191])
        by smtp.gmail.com with ESMTPSA id n26sm28235547pfi.165.2019.05.07.18.37.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 18:37:14 -0700 (PDT)
From:   Cheng Han <hancheng2009@gmail.com>
To:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cheng Han <hancheng2009@gmail.com>
Subject: [PATCH] dwmac4_prog_mtl_tx_algorithms() missing write operation
Date:   Wed,  8 May 2019 09:36:57 +0800
Message-Id: <20190508013657.14766-1-hancheng2009@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Cheng Han <hancheng2009@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 7e5d5db..b4bb562 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -192,6 +192,8 @@ static void dwmac4_prog_mtl_tx_algorithms(struct mac_device_info *hw,
 	default:
 		break;
 	}
+
+	writel(value, ioaddr + MTL_OPERATION_MODE);
 }
 
 static void dwmac4_set_mtl_tx_queue_weight(struct mac_device_info *hw,
-- 
1.9.1

