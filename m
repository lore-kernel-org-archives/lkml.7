Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B5FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DEC72075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewBcJ8z8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfDCRHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:07:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38427 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCRHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:07:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id k11so22444914wro.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 10:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oSlZkgRrpHo5HaGsvW+Fh4OUaZj+iL7A8kN76w4G7NI=;
        b=ewBcJ8z8Zs4OTyc5SQ5+ztnLxuM4neGpdkGPB7sFiytfR0Ag4tGpCI37xoMOCPXU8V
         2quaIUrriFnPxZN2KO56OtQJ+EjoQJ5o9QoT5TXkccSwDdCfthW5SGqtjpLQVKKV4BkN
         lOI7KO3JoD0+KjhCTTVtcPA07PDIxLNC91Nee8m6uwI6q2hh8yMsQPmYLq17ssyP5SCQ
         i7eltXITXrVNdAa7QshRHm3Jtz7vRV2XpZJ8sn3FOB0ZSsZvxyDBWnRs9BAuCW2msbf7
         x+0NnwNCUpPD0wJW6L/d62fOetG7eThB5zAP3UH0cYcyp3mkn10dzf4KnJaEUkOZdTRt
         x78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oSlZkgRrpHo5HaGsvW+Fh4OUaZj+iL7A8kN76w4G7NI=;
        b=GnDg6p1rX9I+vyy3JGIzLNh+r1wsD+1WR+5gglcWhHz0hz2B+WObkc1sgWjAicJEh2
         EJn1HBrlbyhvKeUmyCSDcmTk8F1Tfd7GdggIb8NBchF4on6w9cKjU5vK0hiBN5LtL4W4
         jXT7NEccXXDoc0amZr8cEEJQaHHcn/a3746FpvzkSeHev9JRnibFTs8k0PetWynXt46x
         gimVERpzZscikNxBrFBqYVc61NHcvOIvcKtMjd4JrO0N9ZZk8ZyWvN7tuIOQTvVAn+2O
         0WulpRGnrkxGLTbtvB2s2xesIj9wph/E2Y8JOKflk1jjEilzRcTNkqqpqkRpokX9Xa4X
         3dIQ==
X-Gm-Message-State: APjAAAUCe8HIWXYS4g0uMkh9ydMiRTsth8H1wpfGnyj0QTEB2hZJUEMQ
        sx2Qi9j6YWjGdcOz8wi7DaHJScuV
X-Google-Smtp-Source: APXvYqzYVvfNU/SGAw5AVgAsAam09prtDR7Mdw5nEIwKGznV0/UTvNe1P/q1VBox7o8zpWyUsex6HA==
X-Received: by 2002:a5d:4f07:: with SMTP id c7mr507243wru.104.1554311238976;
        Wed, 03 Apr 2019 10:07:18 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb9a.dynamic.kabel-deutschland.de. [95.90.187.154])
        by smtp.gmail.com with ESMTPSA id a126sm21953306wmh.4.2019.04.03.10.07.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 10:07:18 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: rtl8188eu: remove unnecessary declaration
Date:   Wed,  3 Apr 2019 19:07:08 +0200
Message-Id: <20190403170709.22088-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The declaration of sta2sta_data_frame() is directly above
the function definition. Remove the unnecessary declaration.

This also clears a checkpatch issue.
CHECK: Lines should not end with a '('

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_recv.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
index b7abe8c7c8cd..3a621d58e53d 100644
--- a/drivers/staging/rtl8188eu/core/rtw_recv.c
+++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
@@ -632,12 +632,6 @@ static void count_rx_stats(struct adapter *padapter,
 	}
 }
 
-int sta2sta_data_frame(
-	struct adapter *adapter,
-	struct recv_frame *precv_frame,
-	struct sta_info **psta
-);
-
 int sta2sta_data_frame(struct adapter *adapter, struct recv_frame *precv_frame,
 		       struct sta_info **psta)
 {
-- 
2.21.0

