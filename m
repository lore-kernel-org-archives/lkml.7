Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE36C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD199213F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8gaMIEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfCTQul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:50:41 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44573 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbfCTQui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:50:38 -0400
Received: by mail-ed1-f68.google.com with SMTP id x10so2570511edh.11;
        Wed, 20 Mar 2019 09:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EJK4SI3rcQBttHs6/NW8odmC7txCmuUAl2muEupVnNM=;
        b=j8gaMIEvkaKX2msvQUybgBnEGRLrRfPAnTeJi/5+QQ0vt6vklzNvzZPvNxpBlB3qrn
         j33LcHyX1ItvCImQRx05bObtca5X6Mc9w9OTNyD8Bw10/MihlmbdHlKT1gXuAiw9yJ/g
         LeZhUcUriLMbYjCaFkwUTxOj7cDhyom/98ow8Mn+2rSNmDMY70F6zpFpnXB93KR6pkHb
         tgs9V/J+WtP2ODpmcheW6Dhuem4aH8Ts5nUUv2YHAc1vlB0W5LxPTwVjMif76mfJam3q
         fDu1ZdlkaA7zft6jlepjTlilHXKmsqWFg/2U+rj5kkZxFrOaReaWT6/Aec9ZlGo8DnVV
         L0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EJK4SI3rcQBttHs6/NW8odmC7txCmuUAl2muEupVnNM=;
        b=kdIfpgxvOVoS1YIq8KqrBlucj2oLJ41hExE5g3OGhfGnk8IhHXz2DJCPM+9q6jmZ+u
         +FJI/AjXF7QU8oyyKuI6PaEP/dUSQBdl3BlHWLBEnXi+Net9gBFkIa7/ofi9FgvqNjRm
         I7L53lAoZijboHwBR2TzGyPWCYOXaimJJjbR+d6pZ7jAy5jn73wCbOcOM33zCsIywhrR
         8f/4PnXm7UWLQQqD+KYQMMndiGJi/4AWrs2pc0+vR7Dc9TOeHhsM1kE4+48qEq2oOZDH
         Jn4TOsd4dKrPIrV0JSv6/E37ibUZ67ozIk6JmBE3o3RLw/yN7AEfnNk8dsQqFy7Gbfva
         s9QA==
X-Gm-Message-State: APjAAAWp6aTbmR3FiDU5I1jT2c81ggXdPv6zzdqZy6EusuWnh+QRvGK4
        1sIs5bBZuupMwMxZ10yuI/96KAw/
X-Google-Smtp-Source: APXvYqz6jvKKGJTohwW4VuIrPOpeuprOFrC56jE+CJ68REEOyXeOIDOACj9cvagtNZ++6BbjWhrFTA==
X-Received: by 2002:a50:baab:: with SMTP id x40mr20301317ede.244.1553100636443;
        Wed, 20 Mar 2019 09:50:36 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id f5sm808254ede.94.2019.03.20.09.50.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 09:50:35 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 2/3] net: dsa: bcm_sf2:  Remove print of base address
Date:   Wed, 20 Mar 2019 09:45:16 -0700
Message-Id: <20190320164517.29608-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190320164517.29608-1-f.fainelli@gmail.com>
References: <20190320164517.29608-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
pointers are being hashed when printed. Displaying the virtual memory at
bootup time is not helpful, we use a dev_info() print which already
displays the platform device's address.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/dsa/bcm_sf2.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index c8e3f05e1d72..4ccb3239f5f7 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -1188,10 +1188,11 @@ static int bcm_sf2_sw_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_mdio;
 
-	pr_info("Starfighter 2 top: %x.%02x, core: %x.%02x base: 0x%p, IRQs: %d, %d\n",
-		priv->hw_params.top_rev >> 8, priv->hw_params.top_rev & 0xff,
-		priv->hw_params.core_rev >> 8, priv->hw_params.core_rev & 0xff,
-		priv->core, priv->irq0, priv->irq1);
+	dev_info(&pdev->dev,
+		 "Starfighter 2 top: %x.%02x, core: %x.%02x, IRQs: %d, %d\n",
+		 priv->hw_params.top_rev >> 8, priv->hw_params.top_rev & 0xff,
+		 priv->hw_params.core_rev >> 8, priv->hw_params.core_rev & 0xff,
+		 priv->irq0, priv->irq1);
 
 	return 0;
 
-- 
2.17.1

