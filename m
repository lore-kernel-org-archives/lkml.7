Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574A0C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 06:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2982321738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 06:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWplJEeo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfGXGGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 02:06:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37738 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfGXGGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 02:06:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id 19so20359096pfa.4;
        Tue, 23 Jul 2019 23:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=31L/qG3uJMYvnLAjCarmZ4oT4ALMlS1kE3KgO5pog3g=;
        b=lWplJEeoBfrY353cEV/p5nOjvGIvJVBe59G1UDivAKDjp9N7Vx9h1QWFXs8uVnd5mE
         y2Ca0ZzHo0Y2Xld8sexXiBU/ASfW1KtiisdxnA6Fd77hdCLAwvXuajFvpmmQ3rVK8In2
         t2GA3Z7Blo6tlw2oEj5mNwaSOIXT/7NsYyv+enUc4bXQvQhUt5Yc8qS4/8/gSAGlC/A2
         f2rgndjiwbcRj8jBsKI4VP5AnKSoDht6oef6lGSewxs/wrlXUTl7RoQRs7yMIeLfG7fp
         RNV1JwDQReRgZVjwJzZiBIwBZOXZVIoyd0CWPFIIV0molb4KMcgvesEFoHSW4i340AGS
         Z7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=31L/qG3uJMYvnLAjCarmZ4oT4ALMlS1kE3KgO5pog3g=;
        b=rstH0CExMRt8dlVdwALRlsg8OuCvuli1W0OWyI3o8bOhousacOvZlbtxyF4pInMfaB
         RDXJZ2fRAZr7Z/t++BP4vH1ocaBDVh8MtXAlccLJdMB6lMqZIOKPxn19m2YqeQ+CQPJo
         64N1o81o6qEu4Emb9EGGdKV3Q35ll9CdaA4euvcnD2pmhZ3zp5a2EEyA3OYjK5x7gHHJ
         CNWHloF1jgufxIZ//aCQpJ9njvb1ReQrXg7VMe48nNHsaZkP+wFxaUeu4s43DZprkLip
         X0flXiDC1NElDN4uKnCXmH4hd29CAhJV5DAWOHZuUp/hUIs0DE8o1pcnJaS45BOxZnT4
         HGxA==
X-Gm-Message-State: APjAAAUH09NMKLmRGY71NbqGnyQto7/Kaq4gJJOrSwKKA9NO8lZ0ln9M
        v/GExf6Gfe7S3bFMlqGh8+U=
X-Google-Smtp-Source: APXvYqyPJ3BSLpDt4aRKGj8tCni/KPLWD/iSfVWWqh03RP+V5jqQCGaSpJF5CtsYHcWmiJK31+Mziw==
X-Received: by 2002:a63:1749:: with SMTP id 9mr27305810pgx.0.1563948382607;
        Tue, 23 Jul 2019 23:06:22 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id c23sm31908495pgj.62.2019.07.23.23.06.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 23:06:22 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH net-next v2 5/8] fm10k: Use dev_get_drvdata
Date:   Wed, 24 Jul 2019 14:06:17 +0800
Message-Id: <20190724060617.24170-1-hslester96@gmail.com>
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
Changes in v2:
  - Change pci_set_drvdata to dev_set_drvdata
    to keep consistency.

 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index e49fb51d3613..b4aa49b53c61 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -2144,7 +2144,7 @@ static int fm10k_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	SET_NETDEV_DEV(netdev, &pdev->dev);
 
 	interface = netdev_priv(netdev);
-	pci_set_drvdata(pdev, interface);
+	dev_set_drvdata(&pdev->dev, interface);
 
 	interface->netdev = netdev;
 	interface->pdev = pdev;
@@ -2352,7 +2352,7 @@ static int fm10k_handle_resume(struct fm10k_intfc *interface)
  **/
 static int __maybe_unused fm10k_resume(struct device *dev)
 {
-	struct fm10k_intfc *interface = pci_get_drvdata(to_pci_dev(dev));
+	struct fm10k_intfc *interface = dev_get_drvdata(dev);
 	struct net_device *netdev = interface->netdev;
 	struct fm10k_hw *hw = &interface->hw;
 	int err;
@@ -2379,7 +2379,7 @@ static int __maybe_unused fm10k_resume(struct device *dev)
  **/
 static int __maybe_unused fm10k_suspend(struct device *dev)
 {
-	struct fm10k_intfc *interface = pci_get_drvdata(to_pci_dev(dev));
+	struct fm10k_intfc *interface = dev_get_drvdata(dev);
 	struct net_device *netdev = interface->netdev;
 
 	netif_device_detach(netdev);
-- 
2.20.1

