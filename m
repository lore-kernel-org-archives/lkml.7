Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F08AC73C63
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 03:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F078020656
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 03:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ux3zZpd+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfGJDOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 23:14:55 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43807 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfGJDOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 23:14:55 -0400
Received: by mail-qk1-f193.google.com with SMTP id m14so776187qka.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 20:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RzSaHRt9YdV/Z0CPLlqdmqFot058kVxhXHZRpl8J5VA=;
        b=Ux3zZpd+fG2z6B/QZu4LKUm4In7YWmJqrqttvmQyIeBn760fg2r7e/ADEmdWJJ0MmL
         zmz2cl85r3clHZhI7fqXJepTJUyiCqhuhq5RwHZ+GLlixVXIedXu8LCcNtxYbW6s9cv9
         hXjVL396ls2unsRS6sT+TpcrBbdII837nRxlkYveX3w62lx20fqOLXRkf8YGeyWhEVTo
         D/frC/lpYEAUfnVhpLC14BbFA9/zNUS7XLa9nHirKpm2YwHQJqMlt/9vnhbUcT9Isq+0
         xukyxGwiNmjzVI+bIZdIbcGCZ1erSsKR2MTZibTqX4c6iefEYBXy5b2Qy9pVLICsxvLq
         YWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RzSaHRt9YdV/Z0CPLlqdmqFot058kVxhXHZRpl8J5VA=;
        b=ix041kPeasM1TM5pjWLbWrVU6TLQhIDnYpecn2DmW5YlVeqjAx+SMm1qMqN1haCeKE
         IxIObiNqCaCQN7XbWGJa/OibQA59/UR900InvMXCxjJw6bhqm8Dnqpyj4CURxCLTUTvy
         WUDNfnXV4pkdoodQ5N5EVREgFenDbBKG59/9hy5G6n8uP0uSF/554gcD02HClf6wSssB
         I7XVop9PdYaGMlpBiiq96ZtTxSJV3DPnBhHGHKHbly5bjXuan09ma2me45+lOkxL3XyF
         AHLV3TH2leL+o3LouQEwOvXPzXZ5jGDhMtchHbaQoJVAA86uAkee2t2M+A21JK7zfplO
         iOAA==
X-Gm-Message-State: APjAAAVY6OfRTYrDdfGuy2XhBSjH/oCl92rVnmbGU0JD2Gsh+YwdkEoi
        OtpInloltNywHAchYqEbMg==
X-Google-Smtp-Source: APXvYqx+hMaH8eK0Zi5P4YgBKu0RbqOjL7UJ+skXDNFqItXK+8GYxPjciXOvOee6Fj9jZDETRW7XEg==
X-Received: by 2002:a05:620a:16cc:: with SMTP id a12mr20864484qkn.256.1562728494325;
        Tue, 09 Jul 2019 20:14:54 -0700 (PDT)
Received: from localhost.localdomain (modemcable148.230-83-70.mc.videotron.ca. [70.83.230.148])
        by smtp.googlemail.com with ESMTPSA id t76sm571675qke.79.2019.07.09.20.14.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 20:14:53 -0700 (PDT)
From:   Keyur Patel <iamkeyur96@gmail.com>
Cc:     iamkeyur96@gmail.com, Johan Hovold <johan@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gnss: core: added logging statement when kfifo_alloc fails
Date:   Tue,  9 Jul 2019 19:14:48 -0400
Message-Id: <20190709231448.30799-1-iamkeyur96@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added missing logging statement when kfifo_alloc fails, to improve
debugging.

Signed-off-by: Keyur Patel <iamkeyur96@gmail.com>
---
 drivers/gnss/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gnss/core.c b/drivers/gnss/core.c
index e6f94501cb28..4377adfa25b4 100644
--- a/drivers/gnss/core.c
+++ b/drivers/gnss/core.c
@@ -256,6 +256,7 @@ struct gnss_device *gnss_allocate_device(struct device *parent)
 
 	ret = kfifo_alloc(&gdev->read_fifo, GNSS_READ_FIFO_SIZE, GFP_KERNEL);
 	if (ret)
+		pr_err("kfifo_alloc failed\n");
 		goto err_put_device;
 
 	gdev->write_buf = kzalloc(GNSS_WRITE_BUF_SIZE, GFP_KERNEL);
-- 
2.22.0

