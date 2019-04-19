Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45148C282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 016ED21736
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcZ2hTL+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfDSVLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 17:11:35 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36612 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfDSVLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 17:11:35 -0400
Received: by mail-ot1-f66.google.com with SMTP id o74so5237747ota.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 14:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=N5hBzafsRfXAvzCA0D7CsKO86YAIh3TkOzWyNWd7kuA=;
        b=BcZ2hTL+9bk2IyUMKdNeQ4rHLeyXbpenSKXd2r8TnS4qIIeCfp88PxC38bZa+/AiLw
         qTKpdlBza4WVyo5k0SZ4hBY9/vVL7VMV3FvCcRymx4kbv0K0cHC3FF6JFH9lqiOKRaF8
         0PaZPOO42Pu6NYnn6wmzPfhPznmbadwdfubdQC5KA107CEVzR980AaQ7CGoLdltmabQy
         GmbohL2HJTbZhswS+EAdZ9LAo0t6kGd+uRqUoWqXqIVwJmV96jpk7ltzaHKXKt+rpDW5
         ld2SyKVyc7lhalhBfOr8HWyKGLZu2ViDsUIoApGdhUYSLNhigqhTch1XR6jM9HgqOm3S
         NJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N5hBzafsRfXAvzCA0D7CsKO86YAIh3TkOzWyNWd7kuA=;
        b=Cfbz3pGiXijD6oeqS7Sy8ko2cRfX56gZZQSaztC0nvgb/xtyRDMMuTMZRbJxmN/pCg
         Dv5BYJEnMljfiU+XjdG/HoGOK6byYrc1JcvEPbciVsrwcmeF0FExYcnDTvzuFuZY1yuY
         r2DnZ2tEn2jhrZMASP5mUqUrKX/aXK5RiB2aGPf8jzKGIs73cULKeKebpPvJ3PO37IQq
         nKAnep+cpBmf3PtCGOo7j6h6bAJrT3r6cEgprSPVzFE1BiYAIm5OL0AdMBhrFGMWuHJi
         gVKoE+P52HlZiHtlja69AdtVCJ7m9iWxS5+n+wowR2phViu/5Wv2btSvKCbrSEEwt4tr
         EIbw==
X-Gm-Message-State: APjAAAXKF+07EjyvsFTpKy6WaYu4Hp/ZLXE8F3e8vzSVzWSGWJto0GLe
        KehsfKseIH/t9S6Nd6Iv9WULYa5XH9aWaw==
X-Google-Smtp-Source: APXvYqzO4PWDFW8sdd8W2peVTPEGN5d3a0Cyswfh6k3o2Bm/L6v8p+zg10L3/MaGLJv+crP9R6g+GQ==
X-Received: by 2002:a05:6830:16c3:: with SMTP id l3mr3663480otr.359.1555708294175;
        Fri, 19 Apr 2019 14:11:34 -0700 (PDT)
Received: from madhuleo ([2605:6000:1023:606d:151b:11be:d797:d50])
        by smtp.gmail.com with ESMTPSA id d70sm4469150oih.18.2019.04.19.14.11.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 14:11:33 -0700 (PDT)
From:   Madhumitha Prabakaran <madhumithabiw@gmail.com>
To:     gregkh@linuxfoundation.org, matthias.bgg@gmail.com,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Subject: [PATCH] Staging: mt7621-mmc: Cleanup in msdc_app_cmd()
Date:   Fri, 19 Apr 2019 16:11:30 -0500
Message-Id: <20190419211130.25284-1-madhumithabiw@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unwanted variable and replace the respective return type.

Issue suggested by Coccinelle.

Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
---
 drivers/staging/mt7621-mmc/sd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index b12ed2c988fd..2b327fde7145 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -752,7 +752,6 @@ static int msdc_app_cmd(struct mmc_host *mmc, struct msdc_host *host)
 {
 	struct mmc_command cmd;
 	struct mmc_request mrq;
-	u32 err;
 
 	memset(&cmd, 0, sizeof(struct mmc_command));
 	cmd.opcode = MMC_APP_CMD;
@@ -763,8 +762,7 @@ static int msdc_app_cmd(struct mmc_host *mmc, struct msdc_host *host)
 	mrq.cmd = &cmd; cmd.mrq = &mrq;
 	cmd.data = NULL;
 
-	err = msdc_do_command(host, &cmd, 0, CMD_TIMEOUT);
-	return err;
+	return msdc_do_command(host, &cmd, 0, CMD_TIMEOUT);
 }
 
 static int msdc_tune_cmdrsp(struct msdc_host *host, struct mmc_command *cmd)
-- 
2.17.1

