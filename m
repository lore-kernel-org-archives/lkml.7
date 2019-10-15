Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C10FECE59D
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706462067B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dYXNPokI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733268AbfJOWqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 18:46:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34813 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728835AbfJOWqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 18:46:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id b128so13426768pfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 15:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FOMQpcJx9WLEQcHzJj2vCQvumfDCntLeUlPVA5hJqrQ=;
        b=dYXNPokICSJIdpzlnwflztTsqQBC4kNfuc+VmWx4wKj1PkHyDjkK5TL9Wuvtm1jDE8
         1ub/6CL5SaziCg3EIexfzRmFwjR8hn/ig42+Doi5BIoOmV+rlU/t93TUgxMYEykOJxq5
         1TM2U1BcI8/xFKewkS1FCGwFtEP1ZZcExlksM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FOMQpcJx9WLEQcHzJj2vCQvumfDCntLeUlPVA5hJqrQ=;
        b=Go7bdBM0CEQkDMcGmNtKXqMppyQ63O9wts67PBnIxf7vyg9/Pshb2qbfFRtWoChjtM
         FVSxMA8LlFibVTi2NOa3ZHwIY0q/esY/FKDTMRrsXql47WNxhqpRwWejneIk2h4Tj3qc
         ySTtRpNeM67aVEfTOti9MsACvu6SvWvYIUbxibzcgEAttP6iKQ/vUsQMl5c2sWClMD5S
         Ufa9DKjwQqZpoFuUhqAZWoGq+gw9+qfkmbAhtxvR0SVe3nQ/4hGE5xB1EO8qp678DUM+
         7GSTnqonT7YfV8n3iATXg1+whK9SbCQzh0t9CLpGYWCImdmz6/Ta7keDEX/CsCgalOuE
         wGtg==
X-Gm-Message-State: APjAAAWUUJf5oqAapZY/vvJeMu+TRY2hvMtl2pjpI8p7V/Kq4BxcL/ZS
        pwhxnk/gJa1E5aJTvDKOjXBrvbdma3ff4g==
X-Google-Smtp-Source: APXvYqyeU+5PF0rfqF0aya2jb88UqawwNLErMx5GDxFdrR9mfGt8Aujh/8Fv0HuVyL4JsjEl1rXhOw==
X-Received: by 2002:a62:1c82:: with SMTP id c124mr42377410pfc.163.1571179607065;
        Tue, 15 Oct 2019 15:46:47 -0700 (PDT)
Received: from lbrmn-mmayer.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id e127sm23019837pfe.37.2019.10.15.15.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 15:46:46 -0700 (PDT)
From:   Markus Mayer <mmayer@broadcom.com>
To:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/8] memory: brcmstb: dpfe: support for deferred firmware download
Date:   Tue, 15 Oct 2019 15:45:11 -0700
Message-Id: <20191015224513.16969-7-mmayer@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191015224513.16969-1-mmayer@broadcom.com>
References: <20191015224513.16969-1-mmayer@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add support for deferred downloading of the DPFE firmware. It may be
necessary to do this if the root file system containing the firmware
image is not yet available at the time the driver's probe function is
being called.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 drivers/memory/brcmstb_dpfe.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index f905a0076db7..cf320302d2c0 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -614,10 +614,13 @@ static int brcmstb_dpfe_download_firmware(struct brcmstb_dpfe_priv *priv)
 	if (!priv->dpfe_api->fw_name)
 		return -ENODEV;
 
-	ret = request_firmware(&fw, priv->dpfe_api->fw_name, dev);
-	/* request_firmware() prints its own error messages. */
+	ret = firmware_request_nowarn(&fw, priv->dpfe_api->fw_name, dev);
+	/*
+	 * Defer the firmware download if the firmware file couldn't be found.
+	 * The root file system may not be available yet.
+	 */
 	if (ret)
-		return ret;
+		return (ret == -ENOENT) ? -EPROBE_DEFER : ret;
 
 	ret = __verify_firmware(&init, fw);
 	if (ret)
@@ -862,7 +865,8 @@ static int brcmstb_dpfe_probe(struct platform_device *pdev)
 
 	ret = brcmstb_dpfe_download_firmware(priv);
 	if (ret) {
-		dev_err(dev, "Couldn't download firmware -- %d\n", ret);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "Couldn't download firmware -- %d\n", ret);
 		return ret;
 	}
 
-- 
2.17.1

