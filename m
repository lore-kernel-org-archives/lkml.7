Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A37C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C612077B
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpBNNZt3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbfKPPod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:44:33 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45222 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728969AbfKPPo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:44:27 -0500
Received: by mail-pl1-f194.google.com with SMTP id w7so6805214plz.12;
        Sat, 16 Nov 2019 07:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WnvmRD6ZDU2PlgS2OgMDPMW99DMkDnT5Nicaq9xaRVQ=;
        b=LpBNNZt3Jm05bbw8HoNK2SAm9Xpy31GRwHQQXSZ+v3eYIJAnw2O3albN2ikQKCYRoB
         zAl6lFR3Ok1VyDqRhV6FxUTdIWanQdEzO/UcfeT9FmJrPPIIOr137DcCUMHus1ot1kgx
         3iQ6TJQbCgHAsv7AiCHYpC5OPCoviKev0hhjOvAPdnTt8tN+8y/IDLNkTvoA5ljDRq/M
         OR5yPfz7oHn5okKYPKIgAPciL7L0aorvCzk0iQVDcADOumuD9qCX7AtfnzlDQlFLSS4Q
         TIdo0Qrh03y3Yn8X4QAWFXJal08aAu2UWi4RuTjtGJf6QecR+aICzyZmoqpm7ILnPl4n
         KSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WnvmRD6ZDU2PlgS2OgMDPMW99DMkDnT5Nicaq9xaRVQ=;
        b=pMm6RvAPBlTLpjQ+Yin6FD2QaL0m58Ntd4CWkQHDHuff/yCpL3GQvDzYBYRVqqReX9
         VEOU2XTkbvIYKBC3RWOsrqq1MqM8dKHrYjqNj9LuQvvdqlUDCof2VsUvx3uRI3JvzWek
         fMQvDZqU8doM5tAtUh/Gh9nJplffzUJHHxGoyrlFIGoQmnp7xwNETRudRilChDCS46NY
         aa9rrQzLIesQvPbrRn8eDC/13pdn9Z2rC4r6RnokoSM+KHPy9wzIdMs/tGccXWM7EKtv
         6yW4/yhu1uyWxJAFpa2XpuZPjgYzdGgGsUl7Q+Wsw3V4luh4gSCgenKrqsrrCoQ6b3Zj
         +aKw==
X-Gm-Message-State: APjAAAVB5+3B/QGJxzsn6/SFjHC9kyqR5ueeToTCZ4TqFnLQFqwAoac1
        JlMns4giGOcgwWPEYc9+7Rs=
X-Google-Smtp-Source: APXvYqxk3rWsL025XsJDd7R3JFwPwf78EUZFbORx+GvXHfQxAI3D8GG9l9evRVq16ywqnzyxDRPvOQ==
X-Received: by 2002:a17:902:5988:: with SMTP id p8mr20737410pli.131.1573919066482;
        Sat, 16 Nov 2019 07:44:26 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id i2sm14306327pgt.34.2019.11.16.07.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2019 07:44:25 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Jaya Kumar <jayalk@intworks.biz>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] video: fbdev: arcfb: add missed free_irq
Date:   Sat, 16 Nov 2019 23:44:16 +0800
Message-Id: <20191116154416.19390-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver forgets to free irq in remove which is requested in
probe.
Add the missed call to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/video/fbdev/arcfb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/arcfb.c b/drivers/video/fbdev/arcfb.c
index a48741aab240..7aed01f001a4 100644
--- a/drivers/video/fbdev/arcfb.c
+++ b/drivers/video/fbdev/arcfb.c
@@ -590,8 +590,11 @@ static int arcfb_probe(struct platform_device *dev)
 static int arcfb_remove(struct platform_device *dev)
 {
 	struct fb_info *info = platform_get_drvdata(dev);
+	struct arcfb_par *par = info->par;
 
 	if (info) {
+		if (irq)
+			free_irq(par->irq, info);
 		unregister_framebuffer(info);
 		vfree((void __force *)info->screen_base);
 		framebuffer_release(info);
-- 
2.24.0

