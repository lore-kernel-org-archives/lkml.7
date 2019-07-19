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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C383C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 08:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5293D21849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 08:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qN+wKk3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfGSI2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 04:28:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40025 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfGSI2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 04:28:49 -0400
Received: by mail-pf1-f193.google.com with SMTP id p184so13848828pfp.7;
        Fri, 19 Jul 2019 01:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LVGzUddFUDDTd3XNu9CaLaSeJBDagIzKEuUQ6S8/s64=;
        b=qN+wKk3BWFLjRh9ab2e6MyK9FKz8VnKuCBk/inm6CAhxWcF6tuiUlSD3Vw6ZSQWfih
         +nOgLhtQp22wCw/LyvjpD93gPJNonWeMlCIk5zaf0VqxSFvpr6sj4ydfKHdVbeBFgeSV
         GO0LzpkpnRa7iZ54liIdH2CtzkRkqF+iDyK9GLSD7suwEr06ER97sL7V37d6ElDNi1dG
         ybtqo1YZlLg5aR2/SryKOmY5sI4UW29biCd5t3Zur+BsV3dFivwA57qAUXo8e2jvNpr+
         T75HuSNFsCNgIqCvHp4PII4uU7fsrnqstRaP5TkoR8ibPFbgmcYOKKy2l6lJBeZHO2oG
         uhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LVGzUddFUDDTd3XNu9CaLaSeJBDagIzKEuUQ6S8/s64=;
        b=ib4740gZ1c3vQ+XteXKvAozvxN11d9S8kJasPm7pSPW7vZDgMgJkJxQZbUuas+nVTq
         P1zy9N5ZcciKM0pVPN4JG9iUzxh4b/6fqmbRWQXRBLzzage+Na8nWQVS6HpdTyIdOCMc
         K28fCEX+GQdmF+oj9L3ecVfFWVjs52QdUR7+7wdzwjz/d8xFTPjjVT8YbcmsTzD70PJD
         7Jytak4o+zvZyp30LRKeYKLZKW9Dn4atJItj89BtrCv/7BMMDzw0VnwoObkXmrGdl+hz
         ohb3btFL79AB9YAtMXJnUfII6yr4gnYnBpBdP2KiKNN8T7RDtmP/yriZ5ShlLHc/o1/c
         1JRA==
X-Gm-Message-State: APjAAAU/mN/xRWb+RrhZ0us55ZLCkllnbeb1gvynhwKtGO0TYe2KvRfd
        G4x4KqCI23MBLiNv2f44RB4joBSHWWg=
X-Google-Smtp-Source: APXvYqwSJYJRDkiPvTx+U2mHyK7domPC9FfXywft7CFvpQJ7ZlWy5IN+8l64JYP/oblGlRkxzGAdUw==
X-Received: by 2002:a63:5920:: with SMTP id n32mr51055663pgb.352.1563524928589;
        Fri, 19 Jul 2019 01:28:48 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id f197sm30023348pfa.161.2019.07.19.01.28.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 01:28:47 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Steve Glendinning <steve.glendinning@shawell.net>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] usbnet: smsc75xx: Merge memcpy + le32_to_cpus to get_unaligned_le32
Date:   Fri, 19 Jul 2019 16:27:31 +0800
Message-Id: <20190719082730.6378-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge the combo use of memcpy and le32_to_cpus.
Use get_unaligned_le32 instead.
This simplifies the code.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/net/usb/smsc75xx.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/usb/smsc75xx.c b/drivers/net/usb/smsc75xx.c
index 1417a22962a1..7fac9db5380d 100644
--- a/drivers/net/usb/smsc75xx.c
+++ b/drivers/net/usb/smsc75xx.c
@@ -661,8 +661,7 @@ static void smsc75xx_status(struct usbnet *dev, struct urb *urb)
 		return;
 	}
 
-	memcpy(&intdata, urb->transfer_buffer, 4);
-	le32_to_cpus(&intdata);
+	intdata = get_unaligned_le32(urb->transfer_buffer);
 
 	netif_dbg(dev, link, dev->net, "intdata: 0x%08X\n", intdata);
 
@@ -2181,12 +2180,10 @@ static int smsc75xx_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 		struct sk_buff *ax_skb;
 		unsigned char *packet;
 
-		memcpy(&rx_cmd_a, skb->data, sizeof(rx_cmd_a));
-		le32_to_cpus(&rx_cmd_a);
+		rx_cmd_a = get_unaligned_le32(skb->data);
 		skb_pull(skb, 4);
 
-		memcpy(&rx_cmd_b, skb->data, sizeof(rx_cmd_b));
-		le32_to_cpus(&rx_cmd_b);
+		rx_cmd_b = get_unaligned_le32(skb->data);
 		skb_pull(skb, 4 + RXW_PADDING);
 
 		packet = skb->data;
-- 
2.20.1

