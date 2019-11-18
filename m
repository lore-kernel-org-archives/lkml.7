Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01CFC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 02:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5121206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 02:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJ3uOU3F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfKRCsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 21:48:42 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38975 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfKRCsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 21:48:42 -0500
Received: by mail-pj1-f67.google.com with SMTP id t103so1033823pjb.6;
        Sun, 17 Nov 2019 18:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R6TiJnoCZMVB94Jb1OinOc0NFo4+1L3OR+Z9/bchwqM=;
        b=bJ3uOU3FStjRGKfXMD0IgiIHyIHaHeOsqDzYk+eOwu9ZnIZmR87tv5m5kvq0Q6Uvpg
         huY/FO82GK1T52tznbKfM/qZnz8qsJyowmri8F4ErYOAQH2g/8rJNXh8Fc/J0+5t7NbH
         lmfQsVsM2Po8ujf/PW6IN7rc+VhY49XQEeLp3GXIFmwLYzo1lwB/vn3u8/7Tch1/TCns
         DwwJX4dAqOlGTlDgzBAZejzUlmkJWNC4ooSUArppyyMLLLHLa8HTlZyIi/WqwlA88NuS
         JKdjwBt4SWZqDN0b9XbqfwwIZ6SzjpiC5TMtz5myVKaOwieoXENJf+/+bpljVpesGnUT
         OAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R6TiJnoCZMVB94Jb1OinOc0NFo4+1L3OR+Z9/bchwqM=;
        b=DA3tLEK08FUBEfT72j6Ej85TJGtTb8xtoOuxGvEiE6YEFforSZLtC1SU+OFCIFC2vw
         jOS+BfxmGgKRhP8eLofDqJLmJwqoCex7GTH4YgbjJED3mjo05f03Gz/kEDY/qLZWl3I5
         3By0tUpn64yAzpcSSxRBPKfyfSEwhlFCCOeQ4BdnVAjLtKjvATiYaIdoR7x4lHlMYX3o
         42LL6fDBqLiu9LOUnn5OFZA12PGD5TEImMhjDrhjlya7yD7XruTIyeAby5FqX14zZZoC
         kjXDAwuWGVWrpYjv4Mo6LlB+SCykpi4J+YSHepLYsGybyLyYaNhD0daFK4kMsX+woMFl
         j1Tg==
X-Gm-Message-State: APjAAAVy6GnM6dp3Nv4GFAnNkPIznjTt9bmofMHGlJOf+Jpefe3x/DfD
        s9Fptxkrftq3+YRF3SDXd90=
X-Google-Smtp-Source: APXvYqzfon0Icl2/hJ9cVmBewveNRNDkUAlslVU/A+fF8FXFnaA5pyJIxr9wfFYHU6EJXCija+CpdA==
X-Received: by 2002:a17:90a:9b87:: with SMTP id g7mr36305892pjp.64.1574045321552;
        Sun, 17 Nov 2019 18:48:41 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id x10sm18991935pfn.36.2019.11.17.18.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 18:48:40 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] serial: ifx6x60: add missed pm_runtime_disable
Date:   Mon, 18 Nov 2019 10:48:33 +0800
Message-Id: <20191118024833.21587-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver forgets to call pm_runtime_disable in remove.
Add the missed calls to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/tty/serial/ifx6x60.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index ffefd218761e..31033d517e82 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -1230,6 +1230,9 @@ static int ifx_spi_spi_remove(struct spi_device *spi)
 	struct ifx_spi_device *ifx_dev = spi_get_drvdata(spi);
 	/* stop activity */
 	tasklet_kill(&ifx_dev->io_work_tasklet);
+
+	pm_runtime_disable(&spi->dev);
+
 	/* free irq */
 	free_irq(gpio_to_irq(ifx_dev->gpio.reset_out), ifx_dev);
 	free_irq(gpio_to_irq(ifx_dev->gpio.srdy), ifx_dev);
-- 
2.24.0

