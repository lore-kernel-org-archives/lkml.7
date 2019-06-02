Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4C6C28CC6
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 10:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67F5278CC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 10:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRGds1t7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfFBK0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 06:26:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35575 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbfFBK0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 06:26:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id s27so956487pgl.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 03:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YwCCxRSn7S+aZ89GrQp9eL9ZxtaUz94owFWdDgVxvXo=;
        b=BRGds1t71Zlf2NmHwUvUCTBC0J706Ff9CcGFCjU8MLZmmEn/kGiNyD0t3Y//QoRMZJ
         5vMyfF73z/Wq7nBD2oa6ze0RitZx4RYCUOXNanZuBYH+5bUdbwIhrIp1uGjSv2ZiypVk
         j4SfQS8GKRZqSp7gqJ5pkVKaVNysQwNrmXcb83qB/jAgc8YuoEp+g9bbtuDXY2Cnr1jP
         LH+XrNOqvCnGfqOuBS6mFRdUCPehddrKX6MWGxZUb4O7ENXhYHmejT2gNW2oyAZWqh80
         xgSYPMfqf4+pwDhZvtufDUj6giXMroZKcD61X/MrJGjDRKIBEK5vI+oVB8j+AC0q8//r
         +pvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YwCCxRSn7S+aZ89GrQp9eL9ZxtaUz94owFWdDgVxvXo=;
        b=uVDFwPJ0tsup3iC47QL6dkA+vnykXRX4H8TJ2wm+4pQ/iVdkyKI0n36xQfw/RpUydX
         OT4ijd2FYe3Xjt/CHiRMRaW1IHOXGRF+4PUtbatE3FGcIr3/8soDb/wpWxfzr7p4tmKI
         yNjH8mvpnDgVU3H9zfs/3KKZmkDY0RsGhB+dSKSEwYeD5pro157WfIKbfp7ybGZjyzkg
         HRTjmrCAUfbayRw6imHpxKj0aGvn6xatJJ3teFKq6LkjlCKNpMAmUrTrnhAgPjqZIt55
         aX6mpiwV2j1oL7iaNqStl6z+ied52nl3fZ+jWGE7ZHZSwYFvhu4U51NpNxcKypTrUCZh
         UOuw==
X-Gm-Message-State: APjAAAXsTwQQpU6E9SHwcejvIfjen7u6X1pv+CUiCKhi8uifGMWN7XM4
        pR4oifIFsp40J3Cx0YpYPX5rgbSg
X-Google-Smtp-Source: APXvYqyj2JinnP927okx6TcvGGcQjGD03bbR01o5e96QOqq0fpex0rM5mmTW209jJa3bC2FRH1i9cA==
X-Received: by 2002:a63:224a:: with SMTP id t10mr20433393pgm.27.1559471207675;
        Sun, 02 Jun 2019 03:26:47 -0700 (PDT)
Received: from localhost.localdomain ([117.192.23.157])
        by smtp.googlemail.com with ESMTPSA id j13sm12221099pfh.13.2019.06.02.03.26.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 03:26:47 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, joe@perches.com, wlanfae@realtek.com,
        Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux.dkm@gmail.com, himadri18.07@gmail.com,
        straube.linux@gmail.com
Subject: [PATCH v2 6/9] staging: rtl8712: Fixed CamelCase renames xmitThread and recvThread
Date:   Sun,  2 Jun 2019 15:55:35 +0530
Message-Id: <bd1a47583876c33a3a6a087c085f958ffdf406f3.1559470738.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1559470737.git.linux.dkm@gmail.com>
References: <cover.1559470737.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes CamelCase as reported by checkpatch.pl
xmitThread renamed to xmit_thread
recvThread renamed to recv_thread

Signed-off-by: Deepak Mishra <linux.dkm@gmail.com>
---
 drivers/staging/rtl8712/drv_types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
index a5060a020b2b..1f8aa0358b77 100644
--- a/drivers/staging/rtl8712/drv_types.h
+++ b/drivers/staging/rtl8712/drv_types.h
@@ -154,8 +154,8 @@ struct _adapter {
 	u8	hw_init_completed;
 	struct task_struct *cmd_thread;
 	pid_t evt_thread;
-	struct task_struct *xmitThread;
-	pid_t recvThread;
+	struct task_struct *xmit_thread;
+	pid_t recv_thread;
 	uint (*dvobj_init)(struct _adapter *adapter);
 	void (*dvobj_deinit)(struct _adapter *adapter);
 	struct net_device *pnetdev;
-- 
2.19.1

