Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862FEC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 05:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DAE22081C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 05:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AY/0k4r8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388579AbfEXF4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 01:56:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45340 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387622AbfEXF4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 01:56:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id s11so4623587pfm.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 22:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AoxtaitWGEKFSZOEKz/v/lg67nbZ3fMxSFB5YHzG0Zk=;
        b=AY/0k4r8s0g1pZ0kq+WyGw30gp9iBBM6N/4oGMC4X8ToyKe1a+5qbj4F2mJa54l+ba
         sRvxKw+ypCdS9FwSiPQfbK/3PoRxwGNROKxcUc4wjuo9+Qeh+1sLJCpcvlXR/X/dlQ2d
         SjJw4SA/crQN57zKdk8Ep14IMaaxVVryF/+CinzK1ymLYOFwJveNSs6GDq1I1QB3lYZ+
         p6bbw+J5vjsQyDUWimuZMqZpVvHRlr1UzhEw60PI2pbuVdVIW2D9r1aUOtvMwE+BlUsr
         LsSABLfs72VwRdWoRK0uPaYugFGYrdWfPvKaklCSU+zjlv8CqLq/NzYuTH1JFVuY1Tnz
         9r1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AoxtaitWGEKFSZOEKz/v/lg67nbZ3fMxSFB5YHzG0Zk=;
        b=nDTlpHtDLa2v5eqBGDziEz6uJwF5Ykwwa/shqTuq9NSirb+M+AXeKvSSs4dI1sLP5d
         HKSBwE+U4ouGc5sd1fS5qrQyZ4Afd7b0KtbG/HtKHeKAPlxVojBy+WDHO7NW1SwDXaxT
         i1tA2WV/MYcLZyY57UgTX2+bexkggieNFR6Zrj+9I1kevDdLxxqN9wsniwonRtzQI0t+
         +4rrPBfKUWuAO89i/T7zCOTPB2HFi1juiPK74Vzvhx2B966XnCVgjBnXtY4UL0INmroA
         O7shZipJNU94DLeP8T05JRP3KYh67KkH4tIZMXd/dmp6gcbrfkevJ60Wggr2v/862/hR
         tkVw==
X-Gm-Message-State: APjAAAVK6wpdxEah14DpvaJGApxJBD5VBKL1H/OAAVTzRz0shbApojmM
        dlmvgkAbhwG7NdHoZGgP3kKLzFxuRzM=
X-Google-Smtp-Source: APXvYqzui1RlsbgsXSuGOMkUiXJP91mqSn9EV/ojt8Fi8wiX31QqbqmpC429LfG3fikeBVMYKIMA1w==
X-Received: by 2002:a63:c64a:: with SMTP id x10mr101968551pgg.195.1558677381296;
        Thu, 23 May 2019 22:56:21 -0700 (PDT)
Received: from localhost.localdomain ([110.225.17.212])
        by smtp.gmail.com with ESMTPSA id x18sm1907129pfj.17.2019.05.23.22.56.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 22:56:20 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] staging: ks7010: Remove initialisation
Date:   Fri, 24 May 2019 11:26:02 +0530
Message-Id: <20190524055602.3694-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the initial value of the return variable result is never used, it can
be removed.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/staging/ks7010/ks7010_sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks7010_sdio.c b/drivers/staging/ks7010/ks7010_sdio.c
index 74551eb717fc..4b379542ecd5 100644
--- a/drivers/staging/ks7010/ks7010_sdio.c
+++ b/drivers/staging/ks7010/ks7010_sdio.c
@@ -380,7 +380,7 @@ int ks_wlan_hw_tx(struct ks_wlan_private *priv, void *p, unsigned long size,
 					   struct sk_buff *skb),
 		  struct sk_buff *skb)
 {
-	int result = 0;
+	int result;
 	struct hostif_hdr *hdr;
 
 	hdr = (struct hostif_hdr *)p;
-- 
2.19.1

