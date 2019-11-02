Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C899CA9ECF
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 00:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F5221897
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 00:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmxNSfpY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfKBAPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 20:15:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50940 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfKBAPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 20:15:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id 11so10933572wmk.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 17:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=73xsCJrCBga/qtyHqXYQW2cwHZFXOa/8X2wvDsMm9aY=;
        b=nmxNSfpYIyq0ljP6nZQiSmeN7bkfFARpnsHy4alURYjZMgCQ6gRjKQPVEFeEd7doT+
         hTRH0KZv+n6Te4JiwqlkIOzXZOrUcIlX50TrIh6L4X5ur2saRHLoK5YP3BTCk1eeim7G
         Sg4tRY+4+qSjEzel7fygvZy6TN6MPYjHLjo9cKsvchmSXJfXgmJ2oAP/9wo7v6kJs6EK
         lDtNbNsc94yKm6EXwRNZIABZWSglGoinVqhdgiTw+QjVPQoIRPpl44pWLE/hXgUIf5F7
         trQ6/CNL6SdiCtN4JRanSjlBL/ZhRlGjqQV0mZJ7w1CIbiyrzCwg/Izx8FG0KCeOXW0F
         hS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=73xsCJrCBga/qtyHqXYQW2cwHZFXOa/8X2wvDsMm9aY=;
        b=lhqe1kMgd/b6BlrXo3Hk0f3j7zaHraBEuGYVcEcW/eCgNYa/L4junyXt9VB3LcOosd
         7Fi1baOepKqAzwgn6PLYHdV+SWS7/RddNwPFcauqeXGMhKq+LbckqlFQt/lItyIgGOHc
         OBg0qcuuoD0xtvGJisT4Kq9Gj0y6XnmdySvNemfh0hyiHRvHIQ82r2PqugfBSFZh/FIJ
         mFVkRE/SA/0XEiGfAiI+UEjingBxwfDgdH1LXXFXoE/gbLyd8MqDRX6kR/HuoGNh3I+m
         FpqQ3zLJjngcXZ54B52mf3g7u1XtidwArS5bQXdmnDNK3UG7lwBEp5OiN2WdvILkK8fW
         x+8Q==
X-Gm-Message-State: APjAAAVcs+ZCQrTCgxr+tDatvSpHSpJGE5B4jOo1ebGlz5E/yKjAi+HV
        k8dV6nBYUOIGYwH4w9yeYw==
X-Google-Smtp-Source: APXvYqwMm743Vx7mC8KCcbM9HeGgPOll6TAZ/Qeb0eek7G7AV0QzWY16/MGLUXvvOk/r5IIRMFneDA==
X-Received: by 2002:a1c:7d47:: with SMTP id y68mr12274820wmc.157.1572653715528;
        Fri, 01 Nov 2019 17:15:15 -0700 (PDT)
Received: from ninjahub.lan (79-73-36-243.dynamic.dsl.as9105.com. [79.73.36.243])
        by smtp.googlemail.com with ESMTPSA id s21sm12885934wrb.31.2019.11.01.17.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 17:15:15 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     jerome.pouiller@silabs.com, gregkh@linuxfoundation.com,
        Boqun.Feng@microsoft.com, linux-kernel@vger.kernel.org,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH] staging: wfx: fix warning of using plain integer
Date:   Sat,  2 Nov 2019 00:14:57 +0000
Message-Id: <20191102001457.23369-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix warning of using plain integer as NULL pointer.
Issue reported by sparse tool.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/staging/wfx/queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wfx/queue.c b/drivers/staging/wfx/queue.c
index ef3ee55cf621..5d29bce65f71 100644
--- a/drivers/staging/wfx/queue.c
+++ b/drivers/staging/wfx/queue.c
@@ -565,7 +565,7 @@ struct hif_msg *wfx_tx_queues_get(struct wfx_dev *wdev)
 		}
 
 		if (ret)
-			return 0;
+			return NULL;
 
 		queue_num = queue - wdev->tx_queue;
 
-- 
2.21.0

