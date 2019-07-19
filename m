Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE6BC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7040420693
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HO8zPHQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfGSHg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 03:36:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36802 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfGSHg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 03:36:57 -0400
Received: by mail-pf1-f194.google.com with SMTP id r7so13798757pfl.3;
        Fri, 19 Jul 2019 00:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7+fNM12/nljLUHg+OWnuw+9Qm4IaKfoKesEI410bL8g=;
        b=HO8zPHQL1iASaJUNxgEeHKBCHWNwgbpSook1NIo35yhm5Jbyi013Exkt2AkRoq6tyr
         RMuDwCkMJmgamWuDVGEslmeNCzRG9mSn8vVw47pk+6mgdsor9XF7HnTs9BgQ5y5HrQRK
         U1s3FgEeqnOmqyT1DcFwHuGcnRKkwfCXM/1S1SnmwlebCac1O/7WumlfbBL4+Rl9nSip
         74GyT/TL53a5qFwp7N4KFGEoJ+iFTfjJ06JMj86W4uDy731wtWJEfhzZwdM8gMWD0lvI
         uLkZ99EiDvtHrZaDeSd8S2YZb+/vfKZEJmB8lPWL2dI1oT/7vk1cvCp8VMR6Vh4Isk2o
         xS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7+fNM12/nljLUHg+OWnuw+9Qm4IaKfoKesEI410bL8g=;
        b=hB9u4DccS8kyb7bDxp1B4P6efw20yfnpIeWW4lo7mN7TQHo++NJXHxFWmB1qmKyfCj
         SB+5mLv0LHqSEa3hO4sHDGPQx+CXJr/mPCvGBKwfgnByartJlOpQwlOVZSxlO8PTjQbX
         /IvqtdBJmgcIewTmSBK/LDRDcI+fnk39GdbgC8oTKKQMm6Wp6WnusWiJb6/JTS1n3GoU
         VL1gvswA3BVsFmRFY4cMuS/1vOZqL+C4x+buHeyYZ7T6XIT8Ws233D6gZLHKeL8WyDng
         gsHAoRHjUaNXW3S35bHjVRGrvoO0GkjxbY12QGQPWNN3H5QqT1V/KtVN0EvNZl8vurar
         s//A==
X-Gm-Message-State: APjAAAXqPWQMU3tXPEvo4bAF0tu/iTpVgkVylj6NMd83wJUdAOF8rs9l
        gnnOpaGrIPlkQgohsXghsFA=
X-Google-Smtp-Source: APXvYqyJP1loJXy3J8DMh9em8LSA2Gqoo6xLOWUhOPOXJp3sso3+MNFrDf2reEr93tW0jl++UOFiiQ==
X-Received: by 2002:a65:6815:: with SMTP id l21mr6135736pgt.146.1563521817101;
        Fri, 19 Jul 2019 00:36:57 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id x9sm8929978pgp.75.2019.07.19.00.36.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 00:36:56 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] net: lan78xx: Merge memcpy + lexx_to_cpus to get_unaligned_lexx
Date:   Fri, 19 Jul 2019 15:36:15 +0800
Message-Id: <20190719073614.1850-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge the combo use of memcpy and lexx_to_cpus.
Use get_unaligned_lexx instead.
This simplifies the code.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/net/usb/lan78xx.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 3d92ea6fcc02..9c33b35bd155 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1258,8 +1258,7 @@ static void lan78xx_status(struct lan78xx_net *dev, struct urb *urb)
 		return;
 	}
 
-	memcpy(&intdata, urb->transfer_buffer, 4);
-	le32_to_cpus(&intdata);
+	intdata = get_unaligned_le32(urb->transfer_buffer);
 
 	if (intdata & INT_ENP_PHY_INT) {
 		netif_dbg(dev, link, dev->net, "PHY INTR: 0x%08x\n", intdata);
@@ -3105,16 +3104,13 @@ static int lan78xx_rx(struct lan78xx_net *dev, struct sk_buff *skb)
 		struct sk_buff *skb2;
 		unsigned char *packet;
 
-		memcpy(&rx_cmd_a, skb->data, sizeof(rx_cmd_a));
-		le32_to_cpus(&rx_cmd_a);
+		rx_cmd_a = get_unaligned_le32(skb->data);
 		skb_pull(skb, sizeof(rx_cmd_a));
 
-		memcpy(&rx_cmd_b, skb->data, sizeof(rx_cmd_b));
-		le32_to_cpus(&rx_cmd_b);
+		rx_cmd_b = get_unaligned_le32(skb->data);
 		skb_pull(skb, sizeof(rx_cmd_b));
 
-		memcpy(&rx_cmd_c, skb->data, sizeof(rx_cmd_c));
-		le16_to_cpus(&rx_cmd_c);
+		rx_cmd_c = get_unaligned_le16(skb->data);
 		skb_pull(skb, sizeof(rx_cmd_c));
 
 		packet = skb->data;
-- 
2.20.1

