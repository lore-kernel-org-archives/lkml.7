Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AFBC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 20:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAAF2206B6
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 20:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="aMRu4mL3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfCBUjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 15:39:11 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:33338 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfCBUjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 15:39:11 -0500
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Mar 2019 15:39:09 EST
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 24465D1F
        for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2019 20:31:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qxTm0NktI4WZ for <linux-kernel@vger.kernel.org>;
        Sat,  2 Mar 2019 14:31:33 -0600 (CST)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id EEC60C2B
        for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2019 14:31:32 -0600 (CST)
Received: by mail-io1-f71.google.com with SMTP id p17so1229017ios.8
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2019 12:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ZtO3KVKZ6PJf0yc97/RDd9q8ExnseZtD6Ih5Vi4KdUY=;
        b=aMRu4mL3DsgrswlVo8Wl/bfR3ts3md+xOHx/x4uklLEpIgJ93FuxF0oG57tNInVsB5
         4js1I7O2tBhQkOg03fMkXGptMCs7J2UUGGLr0kvWkDOT7ewDPz6UMYANrohTRji+nssp
         bTDTnnXvjiZCdSu/pvjvFvJnxRb0QTVqyj4jAL+/qzqYSbfPS0LpTBXoK26O/GRfldY7
         ipCRh/Oo2Vaetzy8sf3fbbz3hWtGG3i8I8NPiRlEmutPrbtz5N+UW55a3Nxr0zC1UUvh
         un3D9c20hUAg/d+uJH5u0stlUKdHXxoHzdIhecnu7bfuzktPb+O1zTT3hCAD9uXIpJdZ
         rwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZtO3KVKZ6PJf0yc97/RDd9q8ExnseZtD6Ih5Vi4KdUY=;
        b=VyT4rM1Fo7hjeQyjuQd8voIxCmhHqb4/hMxXgSPyAJ1jEIfzVoM0IW0fuWIsLzFpL4
         tq3TTosvPaevXjY9XRcCNvVGX31pfU81wuVHbp8ndbbmzqbgb6fq9io9WAUpx7biDVgP
         zhj4DBpJcyGuC4QZcwYp/72oB7qB9Xi2CjTYwv8yz16UU2oaEQ9plhXrsZYOCEGEdWda
         I3BST1LAuZXRaSuZUnz1aXpOQi0e6euhxeT43R4hSnEzsAW9ldXZJwDKFDzgOXAw6TG/
         mevWx7iRw0s7e7k5gdclaRtOQi4//1l8m8PIS5Dxpt45ZQysohhdGSQpRUeVw5otpsQp
         DLyA==
X-Gm-Message-State: APjAAAUrx815oEAUpthoQ2TtomsDff6tq0wvwGjTq1P0NNzhNuRgQRrL
        IlvUbHFIZ7gTnN00u0PYL72s3xCsaXMfQaZSs7YfUL/9HIG2xWbuakNYZfPWCkasZnoSy5hwBNv
        fskx2koxeL/CzN1V9/T2i0vpVu9Nt
X-Received: by 2002:a5d:8893:: with SMTP id d19mr5811301ioo.277.1551558692635;
        Sat, 02 Mar 2019 12:31:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqxzDofBlKkimOF1FcnHMLT1rFVFPkx+EPGv64bVeGitGB+iyfi4i7+n5aoAPh6Q3Oow0ePySQ==
X-Received: by 2002:a5d:8893:: with SMTP id d19mr5811293ioo.277.1551558692438;
        Sat, 02 Mar 2019 12:31:32 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id 81sm606358iou.78.2019.03.02.12.31.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 12:31:32 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Amitkumar Karwar <amitkarwar@gmail.com>,
        Siva Rebbagondla <siva8118@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rsi: Fix NULL pointer dereference in kmalloc
Date:   Sat,  2 Mar 2019 14:31:22 -0600
Message-Id: <20190302203123.9182-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmalloc can fail in rsi_register_rates_channels but memcpy still attempts
to write to channels. The patch checks and avoids such a situation.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/net/wireless/rsi/rsi_91x_mac80211.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/rsi/rsi_91x_mac80211.c b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
index e56fc83faf0e..59eb1f533d0e 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mac80211.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
@@ -197,6 +197,11 @@ static void rsi_register_rates_channels(struct rsi_hw *adapter, int band)
 
 	if (band == NL80211_BAND_2GHZ) {
 		channels = kmalloc(sizeof(rsi_2ghz_channels), GFP_KERNEL);
+		if (!channels) {
+			rsi_dbg(ERR_ZONE, "Failed to allocate memory\n");
+			return;
+		}
+
 		memcpy(channels,
 		       rsi_2ghz_channels,
 		       sizeof(rsi_2ghz_channels));
@@ -206,6 +211,11 @@ static void rsi_register_rates_channels(struct rsi_hw *adapter, int band)
 		sbands->n_bitrates = ARRAY_SIZE(rsi_rates);
 	} else {
 		channels = kmalloc(sizeof(rsi_5ghz_channels), GFP_KERNEL);
+		if (!channels) {
+			rsi_dbg(ERR_ZONE, "Failed to allocate memory\n");
+			return;
+		}
+
 		memcpy(channels,
 		       rsi_5ghz_channels,
 		       sizeof(rsi_5ghz_channels));
-- 
2.17.1

