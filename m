Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CADC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CDBE2173E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcnZfCKV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbfIBHub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 03:50:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51138 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729396AbfIBHub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 03:50:31 -0400
Received: by mail-wm1-f67.google.com with SMTP id c10so1473880wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 00:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kcqdyPLZCov8q1Yc/4XKH+CQy/J5UB53PgtIuV1/9s0=;
        b=LcnZfCKVTpLMDSyTKoyPJioZnyoyxbApYpDcFohtdhF/N0yZ6NvcquB62kSyksYfiU
         RTJqnqILmxGftbwaKpi9NjKjvcrsskfRVgfbzUqeTCK8SzVVB/ao54259cpxN1ChkJuC
         Wj2iIBBzAOsDDASBRonvIl1Dt4WA9re47EEAklCsTF30eqGvz+mg1Uz3pcFqj/oYZI/n
         FCiEsDN10RupFNICm0sQ3c49zv40v4/c1J8M+C/GMtpT9gwgvend9KwyhAZ0Jme8s8C+
         bwTdZCBseNxE6MQ7qvG+M3q59N2HZZ6tG2fpZCrSsPIyKvGqdl2uQdqjEdj+owb/QA3f
         EGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kcqdyPLZCov8q1Yc/4XKH+CQy/J5UB53PgtIuV1/9s0=;
        b=cv+LSPtnhyf1St0ho+thkIEU476+C9Q6d9B2/Nz0jdN2XQfPajOq3pxc//cNTpyRFe
         nfvbc7S8+k34pBOkV66AlTQPsM+lp8HPWwih6Dkemo2cH0XBxq5VtujiQDaY5sWm85TO
         WBFWZRF0+cN2TMo+zeKkvUG1JsNN51FjkWKvpBHfQhh5JyMzjqRnnuudlddhz75JSRtZ
         c6gSh0QR3vlpLYs5Z1GglBYrUp+5o9TS1BfrzobzQ4Cst24L/XI5jj4QbgtW5dZNHj2h
         WyLDv2lLwM2pOAiikNMdqEHrW9fLhuHK9B0yIgrpYmKx+ozgpXZiWkNKYVCGp8ODbNJe
         yDOw==
X-Gm-Message-State: APjAAAVGMq7zpus9IV715cNv9qHTkoN9u4l+7c/Iead9EQlspRQlasBj
        Fr7p6PEPV7y4sHlckLjfgHP7G5Vb
X-Google-Smtp-Source: APXvYqwLQDx/lQ1qN6zWmmYoDCzQvVTFBTDd2UhevqKQzB1zBoeJVcXZmLwJHHeVEIxu5Uk1Nf0Agw==
X-Received: by 2002:a1c:2bc1:: with SMTP id r184mr8601187wmr.40.1567410628597;
        Mon, 02 Sep 2019 00:50:28 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id f6sm27460510wrh.30.2019.09.02.00.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 00:50:28 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 2/2] habanalabs: show correct id in error print
Date:   Mon,  2 Sep 2019 10:50:24 +0300
Message-Id: <20190902075024.27302-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190902075024.27302-1-oded.gabbay@gmail.com>
References: <20190902075024.27302-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the initialization of a device failed, the driver prints an error
message with the id of the device. The device index on the file system is
that id divided by 2.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index bc98032cc4ec..e9f5a0e45183 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -1290,10 +1290,10 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 	if (hdev->pdev)
 		dev_err(&hdev->pdev->dev,
 			"Failed to initialize hl%d. Device is NOT usable !\n",
-			hdev->id);
+			hdev->id / 2);
 	else
 		pr_err("Failed to initialize hl%d. Device is NOT usable !\n",
-			hdev->id);
+			hdev->id / 2);
 
 	return rc;
 }
-- 
2.17.1

