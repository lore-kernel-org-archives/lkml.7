Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E79C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 14:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3CFD21849
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 14:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaGGrty7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390547AbfGWOQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 10:16:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44895 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfGWOQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 10:16:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so19510624pgl.11;
        Tue, 23 Jul 2019 07:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jL79MKKpyd6Fku1WytrYtvGRkeN4L/bqteh5RYd+ObI=;
        b=gaGGrty7Q38mV3cX5qdpZRqoa9g3twpyGCn2idTeWJ1MPlaA2Bo2yASaEFUJs5Gcpq
         Lso3HMOOntihZxxUT7E/qzQIPcfMSO6ocQc92vuj3rNIXJ937eFXY4yMuFTfUkkOOL+J
         3ZMQjA9WlsvxB2cTKdjd/XOEo6ijTei4BIieQL5IbgdapF431Fe20NcSHiOXJRC8Dkk2
         hgt+xN55eU+lYmHFWwxxLXbM7LT537iVo2FvFVPxa09FaKmPW4umz3JvxP3FBgVOVjYg
         WkUv5jsJHvBZ3lARk9R7j5Ly/7/pkhflCG8D/jg25DdIW+J3iXdcajU7m98RAhh/VCPj
         fP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jL79MKKpyd6Fku1WytrYtvGRkeN4L/bqteh5RYd+ObI=;
        b=p/06HhIq2jfnljKBuPTjuC6iaeHqaT98q8XibLR+pV8p1SJfM6Z/mXYC+ctoRHrN/5
         OQK87tB9ZVhAx21Y07hpJ84wuSSOyOwlOsTriXbu8UqZQQmF4ISQeCRkoRbH2AQm/G9t
         SZLME4uVPN3MLacwi/DfOd9DyaKJ8WnN7/Dq79c/qesFMnWLpCGWPFn1+52ffAM7yHRH
         oWKMPogztnTLaO6flpuLG79DWZu5nn/P6QuOT6SMZOh4WPASHsT3TB26jcpLGjtv/Azl
         Bad6mQ7Ecrff/Z32yHAjPMJFzBnr8LRMqrHpJX8r8XGgv/f6BnLwZMPuhWjMLjdtm01F
         +4LA==
X-Gm-Message-State: APjAAAV4DtxrX/N9eMRm8DfHsFuk6+vhzRM33MwvnYYSeA52DIg0PIG/
        QS4hbyupCHCv1XEv1nmxu93GxqR6PeA=
X-Google-Smtp-Source: APXvYqxCIeivB9x4n+SUGOjA1ek9EQNIwM0d2lDaEwdJ5juxWCHfY6wHgBXP1veP4lMOCE+ToTKWJw==
X-Received: by 2002:a62:303:: with SMTP id 3mr5994321pfd.118.1563891407675;
        Tue, 23 Jul 2019 07:16:47 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id c98sm42072593pje.1.2019.07.23.07.16.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 07:16:47 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Guo-Fu Tseng <cooldavid@cooldavid.org>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] net: jme: Use dev_get_drvdata
Date:   Tue, 23 Jul 2019 22:16:42 +0800
Message-Id: <20190723141642.5968-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/net/ethernet/jme.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
index 0b668357db4d..db7e10e23310 100644
--- a/drivers/net/ethernet/jme.c
+++ b/drivers/net/ethernet/jme.c
@@ -3193,8 +3193,7 @@ jme_shutdown(struct pci_dev *pdev)
 static int
 jme_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct net_device *netdev = dev_get_drvdata(dev);
 	struct jme_adapter *jme = netdev_priv(netdev);
 
 	if (!netif_running(netdev))
@@ -3236,8 +3235,7 @@ jme_suspend(struct device *dev)
 static int
 jme_resume(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct net_device *netdev = dev_get_drvdata(dev);
 	struct jme_adapter *jme = netdev_priv(netdev);
 
 	if (!netif_running(netdev))
-- 
2.20.1

