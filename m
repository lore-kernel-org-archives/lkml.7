Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8889C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A007520854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjQzDxiP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388855AbfJORgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 13:36:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36290 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388836AbfJORgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:36:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id y22so12932749pfr.3;
        Tue, 15 Oct 2019 10:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=To+5mvjtNy/jMYleBFHXKjhUExVrM0NZ5EvyzLV5MkQ=;
        b=BjQzDxiPDtU3NR0tZj7iCSqGzNSHrR/pxuX1wlb9wsgOUqD2KMxfwKcZZ+SoUWPVmo
         wb/4UPChSGRx6dWWnAn6xZuYqZsaoPhLiJgN+u3z6b8tC2xSmqGn4ZCnTS1hLE0kikPP
         EybIe+wcrMXZOQHOjvx72UvIYSo1fLnny0AuLMmMsNN1vsnzVR6XeXP43h86EjYsSy5H
         v1kikJs3gf0cb1XLC2/fk/nQGk+wrDovY35FBNZ3eP1kaZpZ7ic2enXAfpLDxC/6C4ax
         ESY3qnCqlqeOUCg8ak/8DsbqTO3fmbnZfUWdGMkjsMJWsXj3jhasQDIYtNElAUtSo8IY
         j+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=To+5mvjtNy/jMYleBFHXKjhUExVrM0NZ5EvyzLV5MkQ=;
        b=fD1UaRmRXIJVZSBStAShT4/RVIdc37DvaRqJWZ0yQIAPlohwThUrX5c/O9/jONBE7s
         eNW0ryQsXd80U1nqSWfg/oTz8sJWnEpAUZbmo6Q7dTEOk/E2DnY9GVwiflYc22i4VkwR
         g8j9AkGYv9SQbbvpX3pRFvN2bVeMUy2G1xzw4ZH0u5rvUhQCarkud334tcYYYKt1F4jm
         gOK47n2ZYgcVL+ilVN3MX4Iq/frfk50XZ2qMG08pvhqmpkZ8iZ5qjt0VhY/nNPsgnyjQ
         Ft1n9oVjyEfYmbHikdDM0R1RHLFNhAoCykUt4cXRshZzfWW1D6ZYRH+CClZQ1qAITqz8
         ezIw==
X-Gm-Message-State: APjAAAWPf1khM5d/5flLMSPaT4dnlx+Fjhpo3X55Vm3Q3kt3OSYBmEQU
        c3l1xfYjDHtws6PAVyJU/TNiBbhe
X-Google-Smtp-Source: APXvYqycjfZiDYrtnWLlJsgkb1wZoSRv5cwdsYppZAq4qzhc31He3gsGKZR8WUpaoPhZNdI7B+vENA==
X-Received: by 2002:a62:fc12:: with SMTP id e18mr22168905pfh.111.1571161005731;
        Tue, 15 Oct 2019 10:36:45 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id u65sm18603075pgb.36.2019.10.15.10.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 10:36:44 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM GENET
        ETHERNET DRIVER), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: bcmgenet: Add a shutdown callback
Date:   Tue, 15 Oct 2019 10:36:24 -0700
Message-Id: <20191015173624.10452-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that we completely quiesce the network device, including its
DMA to avoid having it continue to receive packets while there is no
software alive to service those.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 12cb77ef1081..ecbb1e7353ba 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3597,6 +3597,11 @@ static int bcmgenet_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void bcmgenet_shutdown(struct platform_device *pdev)
+{
+	bcmgenet_remove(pdev);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int bcmgenet_resume(struct device *d)
 {
@@ -3715,6 +3720,7 @@ static SIMPLE_DEV_PM_OPS(bcmgenet_pm_ops, bcmgenet_suspend, bcmgenet_resume);
 static struct platform_driver bcmgenet_driver = {
 	.probe	= bcmgenet_probe,
 	.remove	= bcmgenet_remove,
+	.shutdown = bcmgenet_shutdown,
 	.driver	= {
 		.name	= "bcmgenet",
 		.of_match_table = bcmgenet_match,
-- 
2.17.1

