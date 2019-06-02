Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E92C46470
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 10:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D46278C7
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 10:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTyzS8jS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfFBK0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 06:26:45 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46151 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfFBK0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 06:26:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id v9so6545944pgr.13
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 03:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f+umcMKa+r6Ca6FAPU2kaAKeDDe1pl33+1WzuzGjt8I=;
        b=fTyzS8jSGsXowmnvIrsvtd9oLBg0b20iphN7lXxqMGAVq4IQ1sSzsvrkSWuKz++HiA
         vom6SR6b7+p9X0MdM9e5QELVDPa4bTP6PwE2jJee3brY1XlsM50XJFQiO6Rvm9VG8bvg
         wlICqHwXqGjS+zyGZuDwDEadSGDzR/irAzZVsuq1SMEcf9HQlA29gIHRbRtL3PBiSToQ
         Id7L8NJHLJKWUtJhTbfo/e7+dlDUfmV3u0xqgtXdNa9pdlMo+PSYMANZYIx1P/+1jlEF
         rzXHtfCuyDt54vh0w0/uQH3PzReJgqM3C19X1sxa7046NKynLsoRxM+sowdMi5SsVf3S
         0RGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f+umcMKa+r6Ca6FAPU2kaAKeDDe1pl33+1WzuzGjt8I=;
        b=PYvKmtmwtLvdr9Ff7F9a4hh4LXAShocblCbe/hp8E6plopLjwEqLPz35oGFK0if9tu
         bNxDOZhs8uz/JCnlZKlfoaBzI2lloDp4W9NiOo7VLb47IpQrrlpAQtMnHIPcuJ29v6zC
         vWpDsc+acDK1uzWzfSeS9SInSZuoYBqTtEhwaW3x5CNsVgX6BAPfqRx/4HqdS21/0v6a
         hviSoUashvHbwjfsep2ydpEBYkDj0VZEhGUrDtJ63AoAxV0P4on9vfeJFzowENQrXZbW
         w1XAqAXnTKOLPzLIC8wSYSRnRX7g8UyKRUaDNv8m+qaSjG6UoRH1DCDoL4p6PdHdBx4X
         4bIg==
X-Gm-Message-State: APjAAAUNwtWEcwZKwyNHBz6a/6ndG0Ho3bJNRDc3FkIUk++QY1uM3Ppo
        v96x0onHvwxaAD8odpcirPbMjmxO
X-Google-Smtp-Source: APXvYqyzkjTWMWlOdaRiyB4z3Ov2qoQ1kzskDGKEmgm2bLcX+Xhnir0AnWE0vXNz0avKSYfbGHIZng==
X-Received: by 2002:a65:60cd:: with SMTP id r13mr20997332pgv.58.1559471201320;
        Sun, 02 Jun 2019 03:26:41 -0700 (PDT)
Received: from localhost.localdomain ([117.192.23.157])
        by smtp.googlemail.com with ESMTPSA id j13sm12221099pfh.13.2019.06.02.03.26.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 03:26:40 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, joe@perches.com, wlanfae@realtek.com,
        Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux.dkm@gmail.com, himadri18.07@gmail.com,
        straube.linux@gmail.com
Subject: [PATCH v2 4/9] staging: rtl8712: Fixed CamelCase renames evtThread to evt_thread
Date:   Sun,  2 Jun 2019 15:55:33 +0530
Message-Id: <7f7b0e38b7f10f187ac4ad6eff8e0c1b47698258.1559470738.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1559470737.git.linux.dkm@gmail.com>
References: <cover.1559470737.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes CamelCase renames evtThread to evt_thread in struct _adapter as reported by
checkpatch.pl
CHECK: Avoid CamelCase: <evtThread>

Signed-off-by: Deepak Mishra <linux.dkm@gmail.com>
---
 drivers/staging/rtl8712/drv_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
index c6faafb13bdf..5360f049088a 100644
--- a/drivers/staging/rtl8712/drv_types.h
+++ b/drivers/staging/rtl8712/drv_types.h
@@ -153,7 +153,7 @@ struct _adapter {
 	u8	eeprom_address_size;
 	u8	hw_init_completed;
 	struct task_struct *cmd_thread;
-	pid_t evtThread;
+	pid_t evt_thread;
 	struct task_struct *xmitThread;
 	pid_t recvThread;
 	uint (*dvobj_init)(struct _adapter *adapter);
-- 
2.19.1

