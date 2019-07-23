Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A66C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B2821903
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bblXs8Ir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389786AbfGWMqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 08:46:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37589 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbfGWMqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 08:46:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id 19so19099822pfa.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 05:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3W2vUCM0wvNgzTeL3WR1yMUrLTtodWyEHuD05I9UfiE=;
        b=bblXs8Iryxe4c9QnYmHEWzU0wgtJEPjhtXzTIT05gFLVDkuqYn06uMXR2zZDNmHm51
         ziiq8BqH4W39jL+XXl/3e1IXB2Hnq/DV7/IAmZ22UouIDHQuV7YmM5g7ArwLxo174Ap6
         R5U9THVfkBrBycrrpc9hlyotyPe+HI7kcUEbd21WVmgM4ZwIW2tJp27WTJX7/o8uuB8t
         9NOgOShWkv31HN1DjAGEGTIQ8WNUUSg7pUxo4gv0ngcH6oTqCZhBZzklv732CFrMjn7H
         7tRDDwd9QgQmBiLJ4GCHIVM7dfMJmK9fOUk563eKrFipd0IGgQiOXo7swuuzNFIfFcJf
         8eoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3W2vUCM0wvNgzTeL3WR1yMUrLTtodWyEHuD05I9UfiE=;
        b=lkiOVK2E/hBSAWh5fTh8RRL+MsqE4bBcbEL9smQISm/SnVQg7aiH8jP6UgIhox2YiA
         hddJb82FQbkO0Cj7WDxK54IK24pm4TgCTPCV4it6pSFj/mHj51+v8kIBwolMXGDi9Mz0
         VEfmnkvtkEjbNZ93qPtXLHsrfRQPz0hHwHX/6Pnw+0PeYX0+7o8bnxBVb5QjSsWvBGzP
         KY8xvTyjglvATv6cYf+9k00SbJ0LQdkLGd7glBXbmmPfDD47OhqblLvKA8Fqkkz5NwEd
         PuNNGDE7jGxlsyz7EfzPbK0bPwkTy6MVuOJTrqkMyyTO/v8jNEjay8uoTM9NcIpPDCS6
         denA==
X-Gm-Message-State: APjAAAW4BDHg0TV8WU+9hmIjBAZwR/j3chFC+Js/EoapQjC7EWdiAFdT
        g0ZhvI3w3RPesHaDZFjvObtTVAp7hok=
X-Google-Smtp-Source: APXvYqyIjPDzX1Qi2TEbGFlRK/Gr/NN2lw0TRG+D2XwP2M/V58xoTRmmoymkbMCCeYCGBcVMgSTPVA==
X-Received: by 2002:aa7:8641:: with SMTP id a1mr5631326pfo.177.1563886014151;
        Tue, 23 Jul 2019 05:46:54 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id o11sm72746953pfh.114.2019.07.23.05.46.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 05:46:53 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2] misc: alcor_pci: Use dev_get_drvdata
Date:   Tue, 23 Jul 2019 20:46:49 +0800
Message-Id: <20190723124649.24728-1-hslester96@gmail.com>
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
  - Split v1 into different subsystems

 drivers/misc/cardreader/alcor_pci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/cardreader/alcor_pci.c b/drivers/misc/cardreader/alcor_pci.c
index bcb10fa4bc3a..259fe1dfec03 100644
--- a/drivers/misc/cardreader/alcor_pci.c
+++ b/drivers/misc/cardreader/alcor_pci.c
@@ -334,8 +334,7 @@ static void alcor_pci_remove(struct pci_dev *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int alcor_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct alcor_pci_priv *priv = pci_get_drvdata(pdev);
+	struct alcor_pci_priv *priv = dev_get_drvdata(dev);
 
 	alcor_pci_aspm_ctrl(priv, 1);
 	return 0;
@@ -344,8 +343,7 @@ static int alcor_suspend(struct device *dev)
 static int alcor_resume(struct device *dev)
 {
 
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct alcor_pci_priv *priv = pci_get_drvdata(pdev);
+	struct alcor_pci_priv *priv = dev_get_drvdata(dev);
 
 	alcor_pci_aspm_ctrl(priv, 0);
 	return 0;
-- 
2.20.1

