Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4538C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91BA321881
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="G4742H6+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfIQNTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 09:19:13 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35969 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfIQNTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 09:19:12 -0400
Received: by mail-qk1-f195.google.com with SMTP id s18so3950938qkj.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 06:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=y9WGLrKKo8Mkmz25tH5PKr+ryw2VCq/9Rb24CinmnPc=;
        b=G4742H6+c5HXp7NKayVefS8q9iEn3EZcdnSAYjvT9MLpnzHJKBAEHq7dSd2tiGREvn
         QxbQUPEHbiWMJVtV1rzefcVnQJeRC+12Ciys2cR2qNVuAqtBuQIZSme9J6lojTxsxZcs
         WmGUA/gGbhxE17e2YsL069WNjJcUuPoYQ+UigYJ0gJQcp+7v0HxFiTDXsnDNwpsRK2ow
         EPTb3ZQ58M8MCWD5wghHSLIbHWWLc+dqg0b+GkEfrTWuuhviSs/4IHuLfInYXsIFsvWm
         y0PkI+J3kSAjPyWi9yE/2JjfssmqlSyQIL+rW0JHmwDZvSlQhCekDlhbk5MH8D2u0Zms
         75Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y9WGLrKKo8Mkmz25tH5PKr+ryw2VCq/9Rb24CinmnPc=;
        b=VPcuJFtkRZNWpL4hS8y1SJnWcPvD1oaxi6PIcv+ZTb2Gy+HKz5JrcBqknoqF0tmeoh
         upq0fOKrSI3wu1l/ZxXzlJC/3/odyl9DY03ZPEJzXUpr1SdQcn/QdAedInbteungRajN
         KPaBT2BZYDoH7QhIYXV8Aa7973YwuHWWzjVzDaEEFoPmyfNV9Hsuf96vTw6AZHSayOsb
         ifjbiUq7w1cGX/SaXDwacs1PJCpLUb1A6g870PvKiFmjo8PMz9/H4U+co/FpoOqiuf8n
         I4OwtvAxy/U7oq66vL8YJ8Dpn9jUzIidAhcl6NPNg5eBnh2S3JqrHfOUZvpSLBvU01X/
         +UuA==
X-Gm-Message-State: APjAAAXGk51s3/LZaBuAmZFIR5FwuiqSQ3TgKEHnnJTsGteU9c94pT/H
        tAh6OxOCujea4sYIzJucgasfb/1yFEg=
X-Google-Smtp-Source: APXvYqxrJy4rG5OBkjx64ujR31ERVUX+Ep+FcVymYk+DtsTFlFvsmfXl3LXDJ4xE/5Uhk7FWLrNA+g==
X-Received: by 2002:ae9:d885:: with SMTP id u127mr3575112qkf.109.1568726351778;
        Tue, 17 Sep 2019 06:19:11 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id m19sm1074152qke.22.2019.09.17.06.19.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 06:19:10 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     linux@armlinux.org.uk, gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] tty/amba-pl011: fix a -Wunused-function warning
Date:   Tue, 17 Sep 2019 09:19:00 -0400
Message-Id: <1568726340-4518-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pl011_dma_probe() is only used in pl011_dma_startup() which does only
exist when CONFIG_DMA_ENGINE=y, so remove the unused dummy version to
silence the warning.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/tty/serial/amba-pl011.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 5921a33b2a07..91b59f1cd3e6 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1236,10 +1236,6 @@ static inline bool pl011_dma_rx_running(struct uart_amba_port *uap)
 
 #else
 /* Blank functions if the DMA engine is not available */
-static inline void pl011_dma_probe(struct uart_amba_port *uap)
-{
-}
-
 static inline void pl011_dma_remove(struct uart_amba_port *uap)
 {
 }
-- 
1.8.3.1

