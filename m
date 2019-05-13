Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A02C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 13:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCCB82146F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 13:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GslG7+cZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbfEMNHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 09:07:00 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54311 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730063AbfEMNG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 09:06:59 -0400
Received: by mail-wm1-f66.google.com with SMTP id i3so7983730wml.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 06:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=CXM/sAS6gtztrX2ItBHaQh/rCG7OOeN6BL0gyVWj5Hs=;
        b=GslG7+cZPvOdOZdTWehD3qyjIhEDcW2T5HIFyOCJTkkfLxc+l2hF9kWZo9gGxKg4Vr
         YQOKf4PSb4ovF9se5btS2Jix6wf/siXTKB4yos83DlZOxnHPh2PzMbJMct/NZU/4NUkm
         MPi+6cotGwhzHe7X2TycUvGBfdwS9wWD1n391CFVkHQ/A6JdBJOysmr5ofHJEkX2rts/
         5OhlR7r+1fvMZ/So59hGa3lgmD2Jo8zuRhVf/oBoQjiEpa7cji8C9JGEzAzJyhIEhbkx
         aLEeaeEKTpBTRvmL5eASQeQCBPGQvECRfhHzD7Bz+pJWAbTtVwu0Ft8rFek8NP1ULEB2
         /d/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CXM/sAS6gtztrX2ItBHaQh/rCG7OOeN6BL0gyVWj5Hs=;
        b=kCGK+uIl4vpMVIc7IYpkACRDEPfT2iN5pFThEmGfxQdkdFkQPub5NMbwOm4IZXp6u+
         wR/MXEP3E1XpkKpY3UVJ4sQA+UBSUfidzamz6Ypl68M1IyN/j5XedSmMID81UiNGCUsj
         0Q1PxwYL44IVhiul2muSmjyILf4IM3DiNelnYMWHWxN6mILZPhajjco7RwJXh806FWRO
         bXp2YRQS9LrDD4ibKasakmpsj2Gq0Jw9+tH4b7CwmOUOrFSmazqEmV50bJ1qwALA8bXk
         0EzZcoUJtY1GOPvShd/PUtnT8I3ZiASGX2F1c55PEiIjLZenFe60CHp0CX8oXYMSpNbq
         6ZhQ==
X-Gm-Message-State: APjAAAWSgpCRm7nFRx0Bb9jOEh6NPhyih7AuSGlfr/c+YV9vAjApznXq
        n75JOXQii/3A6fuqU4K3XfTHF/Dsa+k=
X-Google-Smtp-Source: APXvYqzBz5EitlkDpf/Id1MzoeK9OnY9qfX/brhrBMq59YPXLx9oj7yX4jc4dlI7NopLVr++jeUGwg==
X-Received: by 2002:a1c:4083:: with SMTP id n125mr11793765wma.54.1557752817725;
        Mon, 13 May 2019 06:06:57 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id m17sm15699206wmc.6.2019.05.13.06.06.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 May 2019 06:06:56 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     alexandre.torgue@st.com, davem@davemloft.net, joabreu@synopsys.com,
        maxime.ripard@bootlin.com, peppe.cavallaro@st.com, wens@csie.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-sunxi@googlegroups.com, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] net: ethernet: stmmac: dwmac-sun8i: enable support of unicast filtering
Date:   Mon, 13 May 2019 13:06:39 +0000
Message-Id: <1557752799-9989-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding more MAC address to a dwmac-sun8i interface, the device goes
directly in promiscuous mode.
This is due to IFF_UNICAST_FLT missing flag.

So since the hardware support unicast filtering, let's add IFF_UNICAST_FLT.

Fixes: 9f93ac8d4085 ("net-next: stmmac: Add dwmac-sun8i")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index ac19bf62db70..9d3112beb19f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -1018,6 +1018,8 @@ static struct mac_device_info *sun8i_dwmac_setup(void *ppriv)
 	mac->mac = &sun8i_dwmac_ops;
 	mac->dma = &sun8i_dwmac_dma_ops;
 
+	priv->dev->priv_flags |= IFF_UNICAST_FLT;
+
 	/* The loopback bit seems to be re-set when link change
 	 * Simply mask it each time
 	 * Speed 10/100/1000 are set in BIT(2)/BIT(3)
-- 
2.21.0

