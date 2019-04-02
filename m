Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A205C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3907920882
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+ZluEoa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730647AbfDBMOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:14:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37046 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfDBMOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 08:14:45 -0400
Received: by mail-pf1-f193.google.com with SMTP id 8so6302271pfr.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 05:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fOTvj2CHNnElYQjxn2p/TjiU6IwYublLyO1UnfYA5/0=;
        b=J+ZluEoaLhaUy/COTvfTmPQZuKDuJVrnrFmCFXTsDeFFuHrN9lLl+lAlRcW4Ia1SlH
         610i8XcBtmqLYAI0ckIIS9cdkoX1o61p2HGQeyiwICtNHrYOQPp0b/uHmBbvP2pz8jGZ
         c7KNRMat7K2IQKeZtawXosumUDdbc7dPjzuPW/UKICje7BNzdXqAmx/dF3rM9/SalSrr
         mk3seFijgj4Qqr7l1n/O+GzXqBu7CIwXQ7ZUvhUEuaMt92sqabHAaNT/55Dg6TVmpZLY
         9LchCztu2TvpJExq7Z5zFeVy+EFTInGtZflRWs58hfqqhK6FjXg6UvGyinpceA/m8w7f
         4mLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fOTvj2CHNnElYQjxn2p/TjiU6IwYublLyO1UnfYA5/0=;
        b=fu86UQrOdra0K4xnLqlvMi3lYnqiIw/wMuljYo31IgGRkBSo89y0dbL1i4XY3qm7pJ
         jM/4db2n5QmmwY2u+vA28vAB3K7zOk7/mPpuFRuG9nObu4WR6GMJX6JFh0KjRTMtYw4B
         8ONywQPnrSA6VWZhCCD0jiLr+jcl9gPtpORLXF6QWeh6A6eRYgz/zTRzuNxM7aaEC29b
         aIE8aTjo9Gmi7SInuswoRzzbOVVSOCMgE1lq09Asverz5XNdvhqQQk0yBAZbK7vAHAf6
         F41Na1oIYRl9ssq3Km+LV1K+0INBldYQRxxEfZfOuqSMw1o9xHsO5k0lQd6LzAQ6aJBd
         0t2w==
X-Gm-Message-State: APjAAAUKsdeutiy3WoHcde+vEqd7sa55w2dtxD+fEZK9CoxgZ8/c06S7
        Ov58AtXJe7qVcAXmr2n/+AwSn6Z6
X-Google-Smtp-Source: APXvYqxMlyVYxODPcTtRhbPUgyA7gFEw4O3al+f5J9NQSm05eAluYahURQHTcPSuEI6DZAjTXeqcVg==
X-Received: by 2002:a62:1bc7:: with SMTP id b190mr41953848pfb.29.1554207284105;
        Tue, 02 Apr 2019 05:14:44 -0700 (PDT)
Received: from localhost.localdomain ([61.83.141.141])
        by smtp.gmail.com with ESMTPSA id x8sm877391pgp.48.2019.04.02.05.14.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 05:14:43 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sidong Yang <realwakka@gmail.com>,
        Michael Straube <straube.linux@gmail.com>,
        Hugo Lefeuvre <hle@owl.eu.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: pi433: Return thread immediately when kthread_should_stop() call.
Date:   Tue,  2 Apr 2019 12:14:31 +0000
Message-Id: <20190402121431.8070-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kthread_stop() called by removing module, running thread should
return immediately. Otherwise, It is very dangerous that thread may access
any released data like struct pi433_device.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 drivers/staging/pi433/pi433_if.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index ab90d6f80931..16dc380eb176 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -736,7 +736,7 @@ pi433_tx_thread(void *data)
 					 device->free_in_fifo == FIFO_SIZE ||
 					 kthread_should_stop());
 		if (kthread_should_stop())
-			dev_dbg(device->dev, "ABORT\n");
+			return 0;
 
 		/* STOP_TRANSMISSION */
 		dev_dbg(device->dev, "thread: Packet sent. Set mode to stby.");
-- 
2.11.0

