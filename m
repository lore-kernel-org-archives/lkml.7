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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC42CC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 18:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B579F2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 18:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vINiyOn6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731245AbfGSSMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 14:12:19 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42233 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728995AbfGSSMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 14:12:19 -0400
Received: by mail-io1-f68.google.com with SMTP id e20so29898607iob.9;
        Fri, 19 Jul 2019 11:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dsDZYqBz2B/9szRhH3WeBnpIjRQIOUerQGzQ6PdSv0s=;
        b=vINiyOn65BtuiilQEPOADyKF/2NzWgOlsxJ6gm1J03DtRd70+E93QXxbpyltQigisu
         u15MHTBH4/6W+hboUxo7JAg1mXQ4hooE2hsAnLxC+4OFcpIzQqfEy2MsaQap3kTM0u2t
         KG9SbBbabOr7UzQv0RFDgRnLGAhEZEb7qkbYpt5bmjPqEHejCz4bkedb7EaMtXS58sV+
         IS/Dx6NbyW/odeAg59pvYUMIdkgl5b3JK9lxvPsrWH76hIu4MhQrgj06BYWsbRvjO8vL
         9kwfTg1GrKxcfObykPFC6tp0Cf3TjimFnwA9ClW+s/RB9Z4lLrL9wuIm5qdqrMZ+F5z8
         JfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dsDZYqBz2B/9szRhH3WeBnpIjRQIOUerQGzQ6PdSv0s=;
        b=O7++Ko4+YaEnUP4xYKXTJ6eeU03Snpk4NXzTdqXPvte2rYCPBG0hob1NIpb72eQeqI
         HaNq3xg+DR/DoFx/VFt1ti+ubfVAXaVTOYw6eXWjQakda26Wxh90YxDA9R5NoH0RRhHO
         apYQY4CyWXKzrydiGXeQWXOoBck5lxi/6Sb4PjB2Aggld5IyamDH14VVcsCs7GkdXAbj
         LDaoQMMezxDFICSJt5TfXmRy7KDFKm/sww7oRVX2Ycbxbwj2zfbmvLwrIkRpIm3if9Gw
         Cio3nKOHONUx8xZXXA85sN++kcCBboVgptvBv3sbjov0b73vspl1wDvgO/8nYeaMfVZB
         u9Vw==
X-Gm-Message-State: APjAAAX3fOKimAZbk4Iuz8nyZoq9A/RJ/BXNusOjdhIVMldtegG4aA3m
        exWQfDQDZv8bvXjIaTmeAgw=
X-Google-Smtp-Source: APXvYqztUCtieRhnonxnVrZbtr/8FiR1A3c0S7cx7eL+5FpFvKsex9Rujqj/YerjZxXoQ0tXgX2deg==
X-Received: by 2002:a02:c519:: with SMTP id s25mr54933428jam.11.1563559938082;
        Fri, 19 Jul 2019 11:12:18 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id h18sm25343254iob.80.2019.07.19.11.12.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 11:12:17 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lpss8250_dma_setup: there is memory leak when second allocation fails
Date:   Fri, 19 Jul 2019 13:11:58 -0500
Message-Id: <20190719181200.25607-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in lpss8250_dma_setup, we need to release the first dma slave object
allocated in case of the second allocation failure.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/tty/serial/8250/8250_lpss.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index d07e431110d9..6e1f86db88b2 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -259,8 +259,10 @@ static int lpss8250_dma_setup(struct lpss8250 *lpss, struct uart_8250_port *port
 		return -ENOMEM;
 
 	tx_param = devm_kzalloc(dev, sizeof(*tx_param), GFP_KERNEL);
-	if (!tx_param)
+	if (!tx_param) {
+		kfree(rx_param);
 		return -ENOMEM;
+	}
 
 	*rx_param = lpss->dma_param;
 	dma->rxconf.src_maxburst = lpss->dma_maxburst;
-- 
2.17.1

