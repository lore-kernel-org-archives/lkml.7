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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59728C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2299C20851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dsda7h2/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfCGSAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:00:45 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39870 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfCGSAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 13:00:45 -0500
Received: by mail-ed1-f67.google.com with SMTP id p27so14235592edc.6;
        Thu, 07 Mar 2019 10:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=80PbBrlLVjNDnkbdPPlTlo4rmy0Dx+45IEhmeAmWXDY=;
        b=Dsda7h2/CPiv7QuZI5alniBrtiXASBhNWAvKcJvTkeDUq9ApCSvAdQbyhj/LIoYcDH
         NGyX6Gn4IXl3liA9NaqG1zkN0QFtYkR+bswL6k+j6647CxuxS2Dy9b6AE3S349y7u0ej
         xr3FTpBYZy+d3yF2U5xa5xNHL16RikYISVh6taIKX3dmxVJzOkGQPUNZORNOfM2pvyEy
         bYefUPqdXllbr1xATwi1hYFO+q9GBAMkgCgnwWh1ZzqSzUc8CeAXb8mc4wz4qM5rSlRA
         THFAoDURYJ7A0PeYCIsx0sj4NEUeadvaUnO2i0pIes6Z5V0xfuK6UDQw2M4B618DrEEd
         5b0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=80PbBrlLVjNDnkbdPPlTlo4rmy0Dx+45IEhmeAmWXDY=;
        b=eZNtGtB8IoQvoHOl9A9h+hK/bdCnH+VxtYdcwqEpsHgXstY8wQpOkGp/Wxb+V8T4DU
         g8jtzzaw62b0McCMl0ciRyZROt9arUDZ/Z3+vYB934HlZ4YQo+AriV3pEzfDhp0rjPmO
         WfLtjHC17gC/2OWrifPwepl0kUfip3gRReR/Va2ViagD6j4P8xSEmGcR2U9THA9Ugf1L
         fJnFJmgDVnesW8uCkaNcIaPG24BDEaU0evTCoQ7F7oRnXqufT+syLlWw1bwF60V52PHu
         YFuSqwUCONaopJLjCgHJ6gerIc9QZSwCSCteT5/PvxBc/SZUrb6Vj534iCHwAQINVTW4
         LOuQ==
X-Gm-Message-State: APjAAAV3LIXhwKqt9w/Jds5hAr9+Z+ihkHbo3AT/gcbevrq8cdRnC0pX
        6iYdofKZwklGSgBTgjrFHZE=
X-Google-Smtp-Source: APXvYqzbxwDlNucMfu962ZRy3qrgQay23arYXt0G41hpmzMBTCKJoQi9biOatWyIGBRCQr/WQkJJ1w==
X-Received: by 2002:a17:906:70d6:: with SMTP id g22mr8806152ejk.215.1551981642787;
        Thu, 07 Mar 2019 10:00:42 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id y21sm1501108edb.54.2019.03.07.10.00.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 10:00:42 -0800 (PST)
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
Subject: [PATCH v2] net: stmmac: Avoid sometimes uninitialized Clang warnings
Date:   Thu,  7 Mar 2019 11:00:28 -0700
Message-Id: <20190307180027.6226-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190307162101.29204-1-natechancellor@gmail.com>
References: <20190307162101.29204-1-natechancellor@gmail.com>
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
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Respect reverse Christmas tree variable ordering in
  stmmac_hwtstamp_set.

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index e2a13ec2e30b..97c5e1aad88f 100644
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
@@ -564,8 +564,8 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 	u32 snap_type_sel = 0;
 	u32 ts_master_en = 0;
 	u32 ts_event_en = 0;
+	u32 sec_inc = 0;
 	u32 value = 0;
-	u32 sec_inc;
 	bool xmac;
 
 	xmac = priv->plat->has_gmac4 || priv->plat->has_xgmac;
-- 
2.21.0

