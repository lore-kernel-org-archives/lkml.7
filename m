Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E40C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 05:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714B2206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 05:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="AJ8v781E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfCKFqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 01:46:44 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:41220 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfCKFqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 01:46:43 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 23DE3A84
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 05:46:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Gjy5vptP8sQX for <linux-kernel@vger.kernel.org>;
        Mon, 11 Mar 2019 00:46:42 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id E5D8A977
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 00:46:41 -0500 (CDT)
Received: by mail-io1-f70.google.com with SMTP id z22so3372911iog.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 22:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=F2mjjiZfPiUEidWB1BypXaFyyuScwQzmmEeCWyaquRg=;
        b=AJ8v781EluWCr1OeFJ21jYiN0Kcgrm26GWiuJzt595dSI8PidMpZbQjwFgyZ+HdOmd
         6W5bR8C0KFlh57hLMVda03dYmvSn9DdQLagXoutwgWGrAAmoUgGf7xfKVgUxrXpT6KTz
         ZGr2OgD81XVTPWliiZvrLX2l9SJ6iJqTdn9va/RNCWS9uDE/VC5F6dHf7M4aFE6PWhpN
         ubRygFeDcWGynBXsRIImX5BW2tCsLnurQFtsXf1NLPH8NI8NgmgEVLnuXuyE6jIGbFZ0
         3CRgLnkTDzPeBCDuNA51ySkOToRYNw7Q1BxCNhYfWstrM5SUHAbCuUbAIKaENA0cZECB
         wJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F2mjjiZfPiUEidWB1BypXaFyyuScwQzmmEeCWyaquRg=;
        b=D13QKg/DhU7luAHpZOT+XAiqYHJKLLb9sFe0wRUZcWHIUwyazOniVsDWrfGOoivVrg
         SkPYlN7AYUIABHSvUJq5B2eVCQS7QnDNi83oVqNchAi4tTyM3htoorrqZaWkkb16F5H9
         GrSUWJq/tOqmH/7kRSmU6m3SDK7R+Rkq/2p+B933cg9youpgyvFWDmS6bM4OqY9tKr4h
         DPr4D83qnEl9mtcUJa0Gk/KecQfwguz1Hs5PO5QbE9y3iF7uh0UxtQZw7rA9jes4lbyN
         n1oQMo48RrJE70S3SB0Y1vqWLeSBIsWCRBtmANzKGEPL5Gn6yaLa0qQJ7UTlVKixSAFR
         mBpw==
X-Gm-Message-State: APjAAAWoKXMR/+pKF5vZ6nrUSZhZtDWAHvmzxWtrnbp+9ncnN8MQCsDI
        GFGkiWjj2jvuPHh0S3b4wCBoRlt654l2z49SVJAfObtEt1rj1OkAbG2oEbLzwhENygOZc76zL3a
        GKFdzUoBbQF0hAwyM8H9wfEPyn+Dq
X-Received: by 2002:a24:1394:: with SMTP id 142mr3066886itz.54.1552283201523;
        Sun, 10 Mar 2019 22:46:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqybyx1ivjkIbqjCyQYzwS3lRzOKp/lPJ1ojI+ik8v1t81kPcPRrl/w/XvocTEs3iBJPa8Zurg==
X-Received: by 2002:a24:1394:: with SMTP id 142mr3066874itz.54.1552283201264;
        Sun, 10 Mar 2019 22:46:41 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id l5sm7519483itb.11.2019.03.10.22.46.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 22:46:40 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Derek Chickles <dchickles@marvell.com>,
        Satanand Burla <sburla@marvell.com>,
        Felix Manlunas <fmanlunas@marvell.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: liquidio: fix NULL pointer dereferences
Date:   Mon, 11 Mar 2019 00:46:15 -0500
Message-Id: <20190311054615.11760-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case octeon_alloc_soft_command fails, the fix reports the
error and returns to avoid NULL pointer dereferences.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
index 54b245797d2e..cc081cda847c 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
@@ -611,6 +611,12 @@ static void send_rx_ctrl_cmd(struct lio *lio, int start_stop)
 	sc = (struct octeon_soft_command *)
 		octeon_alloc_soft_command(oct, OCTNET_CMD_SIZE,
 					  16, 0);
+	if (!sc) {
+		netif_info(lio, rx_err, lio->netdev,
+			   "Failed to allocate octeon_soft_command\n");
+		return;
+	}
+
 
 	ncmd = (union octnet_cmd *)sc->virtdptr;
 
@@ -1960,6 +1966,12 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
 		sc = (struct octeon_soft_command *)
 			octeon_alloc_soft_command(octeon_dev, data_size,
 						  resp_size, 0);
+		if (!sc) {
+			dev_err(&octeon_dev->pci_dev->dev,
+				"Failed to allocate octeon_soft_command\n");
+			return -ENOMEM;
+		}
+
 		resp = (struct liquidio_if_cfg_resp *)sc->virtrptr;
 		vdata = (struct lio_version *)sc->virtdptr;
 
-- 
2.17.1

