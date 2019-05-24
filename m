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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767FDC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A022175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2xv1OoP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389969AbfEXI66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:58:58 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38248 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389281AbfEXI66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:58:58 -0400
Received: by mail-pl1-f196.google.com with SMTP id f97so3918383plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JWACF3SIPoHGy5EkRZoqUNZ3AjzJ3mymMn0aw/d37Uk=;
        b=g2xv1OoPAO5xli3xO7oBgaNvngcVXWrFOWU+s2iAMJ6mauapv25jjOTC4bkryNgiLf
         UATKBOk4EjF27bJCf47K2U82fiK54MXBpy9mgzlVLOs5JLF8aYTpsvelmce8HqOd3XEf
         Tn2qWxLxtsmwupSRz8d4d/RGBlGrCWiHIUGhFnUMWOcCBJIpQG++kxW4LGc0k3xrwCnR
         yR2ru+JG/pf2Svttek2pjS8TWjyIKTseP6tE6z3H+bC2KUmeioYvHP24MTF+lqVFdRp/
         NWYUmSpp//MOma3OuNav/Fg27M58rI8MpinOOLDr+Hs0fv6fNeYTDliLKP3w8pxxcVw9
         72CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JWACF3SIPoHGy5EkRZoqUNZ3AjzJ3mymMn0aw/d37Uk=;
        b=oBmIQtZJWnfRp4JE2L+oppZUt8wCzs214J6UNPvVRuIAl6o60jwq9iwqi9mUmUUovM
         ECUdDHH2Bb1StqZF/V/H2o81V/Pb7jLAOPCznxk6Wy8VAGq3uSBL60jw4opKlV3M94Hi
         3EU1WR2Y1CLpc8QAid6OefST2tywnzSf3Ze0WSqhFL0+popnrSDsYLpAOv5gPsz/0j7J
         Fx+kK6+e33PoTqBMcNUKhmHikRr/1dxzvJAIpLsxIwM41Jp8anXn70+PKDrQczfRixbv
         d0UYEWYdp411N/KurAxigwQdHoGX/vIwgXgXV8sqU7461SBqmDVl36swD+eXZUG0C0PE
         f5Cg==
X-Gm-Message-State: APjAAAVbMXRUlGVAcJNREvmwQMqKZAWdsRwU0G0AChOIMOzQlwykZga1
        xPQL3WlrnY1uq58ZwhOZePQ=
X-Google-Smtp-Source: APXvYqxd0j3L5+yAIsyKGXeQQVEfGbfAXSc6Rua6tZ0I2R7hm3Clg/aYloU0p4HMiTN+J9CnT7b+2w==
X-Received: by 2002:a17:902:2d:: with SMTP id 42mr105677421pla.34.1558688337271;
        Fri, 24 May 2019 01:58:57 -0700 (PDT)
Received: from localhost.localdomain ([110.225.17.212])
        by smtp.gmail.com with ESMTPSA id z14sm3236286pfk.73.2019.05.24.01.58.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 01:58:56 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH v3] staging: ks7010: Remove initialisation in ks7010_sdio.c
Date:   Fri, 24 May 2019 14:28:42 +0530
Message-Id: <20190524085842.6515-1-nishkadg.linux@gmail.com>
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
Changes in v3:
- Edited subject line and commit message

Changes in v2:
- Clarified subject line

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

