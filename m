Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751ECCA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 06:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A842085B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 06:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzn/rwXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfKBGXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 02:23:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46332 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKBGW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 02:22:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id b3so5869299wrs.13;
        Fri, 01 Nov 2019 23:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DnZE3w7CCpcMCHJ+iwQEUcQqE2nSKRrJMboCP3KTQFY=;
        b=gzn/rwXqJRcCt1bE63KrnbWrGThu6dSsxNrSdOxHXNMzoWQuG34U4G8FwVOQy+KXNi
         2r6MRhmJnhigebh2twlSWo4Tsw5RarmpKSiMgSRE+CPgzxGhz8YJLqCxkBV84PEuw0BE
         sD5M9GMVwhUsnnp0JwsGygnkEfYIPrYPjWgaTuMNDVG4tfHERbwcH2HjkaOVbVgZ7Myy
         8TyIcW/SPuwuhHg3cb+y7p11ZDkpDSEF2MoMDtCCO9GYGQPp9QpZraLahlZDOu965mtB
         buRoevjobAyRXdsrHCixxYmJwsmglmWRtn3KEpi/YtYBZNKlgnpEij1ZdJoHmCX218SU
         O8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DnZE3w7CCpcMCHJ+iwQEUcQqE2nSKRrJMboCP3KTQFY=;
        b=QfBnFOon5/ALC2G96KHi365XaccnYKLYWruaLU4VDiwdaEYNPKy2dJUDE0bZwva/pW
         ajFtrt9aAbDZIZgBvk0YCW1ONSDQ5YSDvISNpuJuMu3lrBNC5RhOZCbk+d/1tTZRQcNx
         NoLJPI7P/vWKAIFG/gb15efMvCmBerPAjz894v16XQV/73XUr79R/XSc7VEcp0hpV+da
         SZl6O90eUWpxLLj7ia35ipNyZh0lRkEp1GzStVFjjPGlkxIJWt/BWRNfLape7pABXbt4
         GXOz6myZshpKh/Zl03LWDAbI78sd7txSzyPo6mS70u3I6sGs4u9vgX9xZOGiNd18nsTU
         F+Kg==
X-Gm-Message-State: APjAAAUyzmjhQ9srSWUCyGm84rmCWtN77aQ9POyaizZzVZu0o3HyDUSK
        N8QulXFQO4Y0v0X9j+MzOLVKBzhO8LE=
X-Google-Smtp-Source: APXvYqx4COqSgTZachBr5uNbIjy9sIhMhq07HGD74ExGQfsHvrVHnROwXefzKiaVHqCizyBR0rd7eg==
X-Received: by 2002:adf:bc91:: with SMTP id g17mr13253833wrh.71.1572675777478;
        Fri, 01 Nov 2019 23:22:57 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id i3sm9621147wrw.69.2019.11.01.23.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 23:22:57 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] usb: host: fotg210: add missed clk_put calls
Date:   Sat,  2 Nov 2019 14:22:45 +0800
Message-Id: <20191102062245.4014-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver forgets to call clk_put when probe fails and remove.
Add the calls to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/usb/host/fotg210-hcd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/fotg210-hcd.c b/drivers/usb/host/fotg210-hcd.c
index 9e0c98d6bdb0..f967adf2d8df 100644
--- a/drivers/usb/host/fotg210-hcd.c
+++ b/drivers/usb/host/fotg210-hcd.c
@@ -5646,8 +5646,10 @@ static int fotg210_hcd_probe(struct platform_device *pdev)
 	return retval;
 
 failed_dis_clk:
-	if (!IS_ERR(fotg210->pclk))
+	if (!IS_ERR(fotg210->pclk)) {
 		clk_disable_unprepare(fotg210->pclk);
+		clk_put(fotg210->pclk);
+	}
 failed_put_hcd:
 	usb_put_hcd(hcd);
 fail_create_hcd:
@@ -5665,8 +5667,10 @@ static int fotg210_hcd_remove(struct platform_device *pdev)
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 	struct fotg210_hcd *fotg210 = hcd_to_fotg210(hcd);
 
-	if (!IS_ERR(fotg210->pclk))
+	if (!IS_ERR(fotg210->pclk)) {
 		clk_disable_unprepare(fotg210->pclk);
+		clk_put(fotg210->pclk);
+	}
 
 	usb_remove_hcd(hcd);
 	usb_put_hcd(hcd);
-- 
2.23.0

