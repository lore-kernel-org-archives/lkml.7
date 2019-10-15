Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924D0C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB322089C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itYb0Pr5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbfJOIrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 04:47:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33122 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfJOIrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 04:47:47 -0400
Received: by mail-pg1-f194.google.com with SMTP id i76so11720529pgc.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 01:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=foXBwHD68GqDpUhv12UgOg8h2hieUZu0Au1qNClUQfg=;
        b=itYb0Pr55NgMcqQx6PCxeFCUijsujjxt4Xa9C+B6w/WQu/k70+T2xEw6xvOrC77P6c
         cJSKaWJB7Bbh9MLylt84yJrtMZZttJpAp/oWTMLhILPTTNSuJLP046BDtp+bPUMObFSx
         B849ISYsz31Ka2/bvu2IBiMmcfKpIoRE3BGz/dL7Mw4Hmd8siEg28dlMjQ6RLolrNk/Q
         qbX5lI8eBrfWQG+6tXr4jNKZYdVINbF/hAtMiZmwdGQcLUmPeent50/Pr9NSyThz0kSG
         ny95g9M3SfyDLkoOSnVJACzPCqjK+CU2A95XN3DPF2QipNGU3sDjcqlLZDEb/llCBxKg
         WUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=foXBwHD68GqDpUhv12UgOg8h2hieUZu0Au1qNClUQfg=;
        b=SgbZ7RMgOlgaLe9XPluZEvwYibBTP85LYN+nCb2EontqOsgl2PqYaytmhKnTmvfV07
         dAuwrpY9p0+oKn0V6xo73gGeEDP4yScaCQUDu8e7KFVAoCzbElvCxPmrpU/jfd//3FyI
         SQDwsNk/4ajnxChWGKZLYXQ25eOSNwVYxHyQcskP07i7Z4EL84jq2cNFKJ/9H7XegJgo
         2od5ZHs0J35ZYMtz/nN95Q8TwwvGD8ykAF65pyiauJ6vk18sXizw9WEPyn85dTr+h4D1
         jnldqdnaxn5OeRSDXAFfDMn2200YGLGMKlN5Vlx54XSiGUfIRM/uhTl3Fp5SvJgV79Y0
         toSQ==
X-Gm-Message-State: APjAAAU3EwH3d4WhnJDQG+sCISXehYTkMrobw51f8Ao71NZStitZ5WVS
        U04nmabPla2capmpbhTbQik=
X-Google-Smtp-Source: APXvYqzFiaidRvS9nRto9ZR7SKPKdsNG9SDmKYmIk8L04Q50e8zzXVBjfUZiXhWf8wuZIbxYm4otYQ==
X-Received: by 2002:a63:1242:: with SMTP id 2mr14383081pgs.288.1571129266064;
        Tue, 15 Oct 2019 01:47:46 -0700 (PDT)
Received: from wambui.brck.local ([197.254.95.158])
        by smtp.googlemail.com with ESMTPSA id h68sm25239210pfb.149.2019.10.15.01.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 01:47:45 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: octeon: fix restricted __be16 degrades to integer
Date:   Tue, 15 Oct 2019 11:47:31 +0300
Message-Id: <20191015084731.8514-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cast to fix the following sparse warning:
warning: restricted __be16 degrades to integer

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/staging/octeon/ethernet-tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/octeon/ethernet-tx.c b/drivers/staging/octeon/ethernet-tx.c
index 5114273826ec..b334cf89794e 100644
--- a/drivers/staging/octeon/ethernet-tx.c
+++ b/drivers/staging/octeon/ethernet-tx.c
@@ -598,7 +598,7 @@ int cvm_oct_xmit_pow(struct sk_buff *skb, struct net_device *dev)
 #endif
 		work->word2.s.is_frag = !((ip_hdr(skb)->frag_off == 0) ||
 					  (ip_hdr(skb)->frag_off ==
-					      1 << 14));
+					      cpu_to_be16(1 << 14)));
 #if 0
 		/* Assume Linux is sending a good packet */
 		work->word2.s.IP_exc = 0;
-- 
2.23.0

