Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C25EC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5727E20851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMbYaryN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfCGQVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:21:43 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42369 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCGQVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 11:21:42 -0500
Received: by mail-ed1-f66.google.com with SMTP id j89so13953291edb.9;
        Thu, 07 Mar 2019 08:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rlDTcfv3csepodlYrre4dFCFdorwXLXQR8bO/MmR6JY=;
        b=mMbYaryNXSzofJDG81JYpz85I0NQuIrYrxgUH1crYQSlJVTmcUEE/qX2jw5Evftlh2
         s1DQVHvW601DjHoCTHEWa9r190MP6VMOcaN9OlgH/7W+wyIgkGvQa6yAHWI5v6R+xtb4
         Fi5I1pWTOzIZ4j2UfHz7Vnhtl58Kq9xQGBCJvb6hHhwdZuPHYHztuULAVfVEkS2j6Po1
         axjlMDw77Aq0n7bX7HMK3uMBhtAyUaAcseVUQwUkJiU6Lwq2Swy6fAu/tVQQbqTiuMzS
         4GTmrdh68HiX+/VgWRITh+imLyqTkPDXu50OyVZz8t9uYQbWPDHa6yU0hSkKWSUIZ6NT
         LKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rlDTcfv3csepodlYrre4dFCFdorwXLXQR8bO/MmR6JY=;
        b=b8wSL/wZ061hJkSygIuGYFrtGCGS7fcM2VOzyb54pcjz0hntEwUiyu4TP1cf5tv3E7
         HDlF/wtR35qDlRJZlxmCu/9/MFiV1vvv3XPmjdQTDfZMnHRHI1r2DcyWt5IhIzkhhU8o
         iWgQ5wGzEuOGycoDOol9VSkVC1OFjSIXklC7DokzMuMZu3rf/MEorjaTAckahtJ7joCN
         xG/yhQSbmbXDObSQHs+G21I1TkZQKclni7rWtmh6djrUD8bLlPqLpCop/YShTLSNEXA7
         1JU5o0MWH0GgZnYJz0A7wgD/UiA5IDH/+c7a+cuYYA23QxOenU/xmR7Hkt8eAF45vDDa
         eUNA==
X-Gm-Message-State: APjAAAVCWhImrwGvL//RztCRHomEcqBp+Cz4JE1uFzQ8kkpNGIOW94rA
        +1F8kVKEg5Hqvc+l/SyotrjzdPeCE2kdXQ==
X-Google-Smtp-Source: APXvYqx9nR8crH7gc55TOWqoBJNQmtLoywosInHY6XwbDFcXrkmNbcJ/e2Kx7vllre3vCBGX9HPYsQ==
X-Received: by 2002:a17:906:7f88:: with SMTP id f8mr8539919ejr.108.1551975700631;
        Thu, 07 Mar 2019 08:21:40 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id y45sm1413360edd.33.2019.03.07.08.21.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 08:21:39 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH] net: stmmac: Avoid sometimes uninitialized Clang warnings
Date:   Thu,  7 Mar 2019 09:21:01 -0700
Message-Id: <20190307162101.29204-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with -Wsometimes-uninitialized, Clang warns:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:495:3: warning: variable 'ns' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:495:3: warning: variable 'ns' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]
drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:532:3: warning: variable 'ns' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:532:3: warning: variable 'ns' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]
drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:741:3: warning: variable 'sec_inc' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:741:3: warning: variable 'sec_inc' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]

Clang is concerned with the use of stmmac_do_void_callback (which
stmmac_get_timestamp and stmmac_config_sub_second_increment wrap),
as it may fail to initialize these values if the if condition was ever
false (meaning the callbacks don't exist). It's not wrong because the
callbacks (get_timestamp and config_sub_second_increment respectively)
are the ones that initialize the variables. While it's unlikely that the
callbacks are ever going to disappear and make that condition false, we
can easily avoid this warning by zero initialize the variables.

Link: https://github.com/ClangBuiltLinux/linux/issues/384
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index e2a13ec2e30b..001a45aed273 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -480,7 +480,7 @@ static void stmmac_get_tx_hwtstamp(struct stmmac_priv *priv,
 				   struct dma_desc *p, struct sk_buff *skb)
 {
 	struct skb_shared_hwtstamps shhwtstamp;
-	u64 ns;
+	u64 ns = 0;
 
 	if (!priv->hwts_tx_en)
 		return;
@@ -519,7 +519,7 @@ static void stmmac_get_rx_hwtstamp(struct stmmac_priv *priv, struct dma_desc *p,
 {
 	struct skb_shared_hwtstamps *shhwtstamp = NULL;
 	struct dma_desc *desc = p;
-	u64 ns;
+	u64 ns = 0;
 
 	if (!priv->hwts_rx_en)
 		return;
@@ -565,7 +565,7 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 	u32 ts_master_en = 0;
 	u32 ts_event_en = 0;
 	u32 value = 0;
-	u32 sec_inc;
+	u32 sec_inc = 0;
 	bool xmac;
 
 	xmac = priv->plat->has_gmac4 || priv->plat->has_xgmac;
-- 
2.21.0

