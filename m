Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85243C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FDB720866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MH1ZRE7X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407041AbfFKSWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:22:36 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46305 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405802AbfFKSWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:22:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id v9so5706731pgr.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 11:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=BjqXD/m5PG7/DLaEwX43f1YffKfL3QpgfkJmrcRE+ls=;
        b=MH1ZRE7Xg7MVcQ9tT2WxdjMWgsd+Krlz8NzJ7gNvkGpv6wU9nG+0iSuvQ3hZCIGGd5
         8gexrMRj7EapmQccHzchJhNlIlwT1Vdh5k3g5mILOOpz1KmO5m1PYtbXu0QxqesKV5EM
         u7CAXxCewqQjHo8xH8JeVZwTUKAle8kXqijoW2MgINDzmHHP3+u7547k/h6A/9nFf7aF
         P3uqp6xcD1rA1ADh/KkvnjrcBksS2TsS/gPalXMrRlpoRlpPFnXeivm+bl1n+ht/w4cM
         KCFdbCoBVvfyTWc4e0h0xsnrQczPuY0VFryI6/BsMCm3jR28fmNXTqy5OL2/RnJ+rzbh
         nHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=BjqXD/m5PG7/DLaEwX43f1YffKfL3QpgfkJmrcRE+ls=;
        b=EFR7M41KRJkWhanpqu7GT38oXvpJVBW45A43w2uHv820AEp7H2GU5HDGfRxOSRGC1/
         PUp800cqOCJVpRho+0QBxiRiVDNjwDZYnVoqRL0v0+ihokftUdq7aTNUGqbdyyIYfBm4
         fSudjmWV7jCOsI6rABHFtXXjDi+hHR4keKLN/vgnXYjZONUpHj0Tb3i8ouOlE4i7uUw1
         IB7zNV4TQFmV8R1Wc1JcLuDdnyo4UqSRPgyNy34gOq67RWMWWyVDXjUu1cZYEnTXF4KM
         o+l+vTnjx2gsNH1rG/9xZUKpZgj/j6wmMQNwQZa/XCxYoLZyvi75QrQDxjf7et1OO2kJ
         y1YQ==
X-Gm-Message-State: APjAAAV5WjS4uisExpJnBafQsTJLsIFAYGIw7Wm39yfQremzzZmuMLF8
        9uaqnp6hrCjhOMNFseRqg10=
X-Google-Smtp-Source: APXvYqyg9ioyIb6FvYiYW4hd1g5lD11XX2CCMfrWZMOJfnMwXDr72iw6gI+ydRtdO+osgzbd/rwS/w==
X-Received: by 2002:aa7:8b12:: with SMTP id f18mr80797549pfd.178.1560277355944;
        Tue, 11 Jun 2019 11:22:35 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id x17sm14885916pgk.72.2019.06.11.11.22.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 11:22:35 -0700 (PDT)
Date:   Tue, 11 Jun 2019 23:52:30 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Nishka Dasgupta <nishka.dasgupta@yahoo.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] staging: rtl8723bs: hal: sdio_ops: fix  braces {} are
 not necessary for single statement blocks
Message-ID: <20190611182230.GA7208@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below issue reported by checkpatch

WARNING: braces {} are not necessary for single statement blocks

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/sdio_ops.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index ebd2ab8..22bbcb7 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -1045,13 +1045,11 @@ void sd_int_dpc(struct adapter *adapter)
 		}
 	}
 
-	if (hal->sdio_hisr & SDIO_HISR_TXBCNOK) {
+	if (hal->sdio_hisr & SDIO_HISR_TXBCNOK)
 		DBG_8192C("%s: SDIO_HISR_TXBCNOK\n", __func__);
-	}
 
-	if (hal->sdio_hisr & SDIO_HISR_TXBCNERR) {
+	if (hal->sdio_hisr & SDIO_HISR_TXBCNERR)
 		DBG_8192C("%s: SDIO_HISR_TXBCNERR\n", __func__);
-	}
 #ifndef CONFIG_C2H_PACKET_EN
 	if (hal->sdio_hisr & SDIO_HISR_C2HCMD) {
 		struct c2h_evt_hdr_88xx *c2h_evt;
@@ -1077,13 +1075,12 @@ void sd_int_dpc(struct adapter *adapter)
 	}
 #endif
 
-	if (hal->sdio_hisr & SDIO_HISR_RXFOVW) {
+	if (hal->sdio_hisr & SDIO_HISR_RXFOVW)
 		DBG_8192C("%s: Rx Overflow\n", __func__);
-	}
 
-	if (hal->sdio_hisr & SDIO_HISR_RXERR) {
+	if (hal->sdio_hisr & SDIO_HISR_RXERR)
 		DBG_8192C("%s: Rx Error\n", __func__);
-	}
+
 
 	if (hal->sdio_hisr & SDIO_HISR_RX_REQUEST) {
 		struct recv_buf *recvbuf;
@@ -1143,9 +1140,8 @@ void sd_int_hdl(struct adapter *adapter)
 
 		/*  clear HISR */
 		v32 = hal->sdio_hisr & MASK_SDIO_HISR_CLEAR;
-		if (v32) {
+		if (v32)
 			SdioLocalCmd52Write4Byte(adapter, SDIO_REG_HISR, v32);
-		}
 
 		sd_int_dpc(adapter);
 	} else {
-- 
2.7.4

