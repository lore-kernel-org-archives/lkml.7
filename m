Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3873C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A142145D
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQDh3Gzb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbfFIMcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 08:32:14 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35987 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728671AbfFIMcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 08:32:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id u22so3714039pfm.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 05:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UPQkdox7T3QaNw+s/5ZqCu7JaG/o8yombi+YevOGoko=;
        b=WQDh3GzbtNkjF02ifba450kvaV0upnsi5o236p2KCWe7c7DSOA8MOwn+VEWm4YRrdK
         rCUU5a1Kpzb/ZrUrj451k1SLB3oZxDHZS7gqu5YCtX3dcdTRLIcOwu0Bl4BEhYOqhXmE
         dU5zu5+/gBwlyhHfnJ08mKx0dQ4nE+YuAqfGO0OahlG/0MCCEbMSMMXf50TXTeSOq7mE
         Z40ueXdtnjNt+Hi6adqSmQbuIzTvp4uc7ukKajCpJiPqZ/kZxjz3rGzx+3m0IB6SjmcI
         GcSCXxETea5sChj+YakiyU7kv7FrPdS/1utdV+fVFBTbgBntuHlBArdZIWT5MsKpz5R7
         mawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UPQkdox7T3QaNw+s/5ZqCu7JaG/o8yombi+YevOGoko=;
        b=CCjd4gkNobJ/RJhovV6Ruv5/p+kKftp9s4dxuHXlezckVCZm23GieSzCA8v2H3eNWt
         jPj73GUCsjjcrP+Pj/eDMZpSQSbBAXyeAfH58LrPxbnCA+uW9gHbPTZSPDbI/stKdz33
         8SchL0z5scWpE48C3e5fOfUUCmyPlh0KZeSjDaaXoHh6sns8ak4YnHCvipu+rWWBFQh7
         9DPh5LOMnEe24Zxo+up9c+dmUWHaE3d9DEackM6DJwBYOijKiTlsUeBoOSJmqKeZ8AfX
         AhRnDJYbdPeSBuxx2A8rEdwe6+QpghraBOcpk6Zw+sFM7pTibojccMrF98uoVgu8DFRm
         xaqQ==
X-Gm-Message-State: APjAAAXalfTqRjJvQELPmZN8T8rYdPCywCAJT3e7XJQt1cMMzyRUHYnu
        d8MuJHtAd0QlYY7haqQoHJjugF45
X-Google-Smtp-Source: APXvYqxurr40ZOWsEIcRQcOoI54WkhaZ7feMPHHUYwzpGXl+iWGpOwss0M0UnHWHZfcvo4DMvNPrIA==
X-Received: by 2002:a63:ee0b:: with SMTP id e11mr11656605pgi.453.1560083530370;
        Sun, 09 Jun 2019 05:32:10 -0700 (PDT)
Received: from localhost.localdomain ([117.192.26.87])
        by smtp.googlemail.com with ESMTPSA id c142sm10209982pfb.171.2019.06.09.05.32.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 09 Jun 2019 05:32:09 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux.dkm@gmail.com, straube.linux@gmail.com
Subject: [PATCH v5 4/6] staging: rtl8712: removed unused variables from struct _adapter
Date:   Sun,  9 Jun 2019 18:01:43 +0530
Message-Id: <118b2ec274c14521dffac3771cf26e1cc8af789b.1560081972.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1560081971.git.linux.dkm@gmail.com>
References: <cover.1560081971.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removed following unused member variables from struct _adapter

IsrContent, xmitThread, evtThread, recvThread

Signed-off-by: Deepak Mishra <linux.dkm@gmail.com>
---
 drivers/staging/rtl8712/drv_types.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
index 0c722e9c2410..c36a5ef3ee5d 100644
--- a/drivers/staging/rtl8712/drv_types.h
+++ b/drivers/staging/rtl8712/drv_types.h
@@ -148,13 +148,9 @@ struct _adapter {
 	bool	driver_stopped;
 	bool	surprise_removed;
 	bool	suspended;
-	u32	IsrContent;
 	u8	eeprom_address_size;
 	u8	hw_init_completed;
 	struct task_struct *cmd_thread;
-	pid_t evtThread;
-	struct task_struct *xmitThread;
-	pid_t recvThread;
 	uint (*dvobj_init)(struct _adapter *adapter);
 	void (*dvobj_deinit)(struct _adapter *adapter);
 	struct net_device *pnetdev;
-- 
2.19.1

