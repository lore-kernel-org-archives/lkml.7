Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25DFC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928AF21582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H62fJvyd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfLRJWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 04:22:10 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43488 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfLRJWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 04:22:10 -0500
Received: by mail-pf1-f195.google.com with SMTP id h14so865520pfe.10;
        Wed, 18 Dec 2019 01:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pM1qXop/PoC0sEV0RB5zbkScR7IGdTIvAdEtSE45QfY=;
        b=H62fJvyd5y2t3TgS1HNAfZDkrKcq/AV1/IB4vL7B59uneUVCZTwae9p2QeZSH958uP
         4W2IZt/2r2EXz4/MthcjmOIS6OJY0geOV7ZB5YsrCFnQ/8LmAls/YXwjNiG9cpwWVM7D
         /WFPfIOQoG59MpOc61kgkO3yyXc8X7MUk+jYmmmWQ621z9GyrX6ucf4qSbxoV5eXTuXi
         gN0S4n4Dv93y7z9S0Nz0Wa+lDHwacCpm2HfnUmYYdhi3ge+cmtiCuuyXmXfZjOoTUqO/
         0AwF0VvxCq9u7sxowYHvqysjfDsF0Hode1vWi2K5ZkjMcfaN179hDd4zOfJ3wo2eFRBe
         1Maw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pM1qXop/PoC0sEV0RB5zbkScR7IGdTIvAdEtSE45QfY=;
        b=CH3YroQJup+2/TjEGRQcOct+bZS2i0UToM2yOg5clszuNfi8pYN80x2DFeQ5hBw8lm
         J4WgbZgVo+7Y7tM0CsiB80EKnco6s+I03s/9vp1/uFt5th7AtRgFkBxQMaQkynwmBAOs
         4I7WykXSnZybdlMNCFCLcG6CEHI6AD/B9T+xADBm7Fcf2ToiFrPUQj2X1LncNOSi/JKV
         k+TQbCffXiw2YcsRK65sfTcM0dTbJOOenXWF3gFBFgMgGm9JtK0qBdh+vUqDia9cIFrx
         2ZpymSc6skVBzPItxAtNlSLzhJc0Zp9DT5VTk1iVujpGDm/IWcxFX2NQQfqpQ3z7I5pZ
         YY6Q==
X-Gm-Message-State: APjAAAV975gMUFvDJA8aWo3tUihRRVkE1dvAyyW42mKOqGv+UippOwj4
        5r2XW02WeuMWEvWQmKfxaFY=
X-Google-Smtp-Source: APXvYqz0ZyCAJcqBD5q1TowmXPojeOkedvwBM0Dkqz/EeWgBCWB3rD9GXdcZVYa0nxFvi8mWzlCyOQ==
X-Received: by 2002:a63:a34b:: with SMTP id v11mr1829976pgn.229.1576660929292;
        Wed, 18 Dec 2019 01:22:09 -0800 (PST)
Received: from oslab.tsinghua.edu.cn ([166.111.139.172])
        by smtp.gmail.com with ESMTPSA id v29sm2167295pgl.88.2019.12.18.01.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 01:22:08 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     davem@davemloft.net, gregkh@linuxfoundation.org,
        tglx@linutronix.de, allison@lohutok.net, alexios.zavras@intel.com,
        alexandru.ardelean@analog.com, albin_yang@163.com,
        dan.carpenter@oracle.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] net: nfc: nci: fix a possible sleep-in-atomic-context bug in nci_uart_tty_receive()
Date:   Wed, 18 Dec 2019 17:21:55 +0800
Message-Id: <20191218092155.5030-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel may sleep while holding a spinlock.
The function call path (from bottom to top) in Linux 4.19 is:

net/nfc/nci/uart.c, 349: 
	nci_skb_alloc in nci_uart_default_recv_buf
net/nfc/nci/uart.c, 255: 
	(FUNC_PTR)nci_uart_default_recv_buf in nci_uart_tty_receive
net/nfc/nci/uart.c, 254: 
	spin_lock in nci_uart_tty_receive

nci_skb_alloc(GFP_KERNEL) can sleep at runtime.
(FUNC_PTR) means a function pointer is called.

To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC for
nci_skb_alloc().

This bug is found by a static analysis tool STCheck written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 net/nfc/nci/uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/nfc/nci/uart.c b/net/nfc/nci/uart.c
index 78fe622eba65..11b554ce07ff 100644
--- a/net/nfc/nci/uart.c
+++ b/net/nfc/nci/uart.c
@@ -346,7 +346,7 @@ static int nci_uart_default_recv_buf(struct nci_uart *nu, const u8 *data,
 			nu->rx_packet_len = -1;
 			nu->rx_skb = nci_skb_alloc(nu->ndev,
 						   NCI_MAX_PACKET_SIZE,
-						   GFP_KERNEL);
+						   GFP_ATOMIC);
 			if (!nu->rx_skb)
 				return -ENOMEM;
 		}
-- 
2.17.1

