Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BA0C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 12:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AE32168B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 12:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="geVjrp9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436658AbfIXMkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 08:40:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32806 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395292AbfIXMkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 08:40:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id b9so1782903wrs.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 05:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rUdTMX0LV19a/cAOPF7U+URSV6+2wG5VEFj80ZdTTHM=;
        b=geVjrp9r/hIUNuo0vP2rVZicZuqtqycilc5JWitdZhYLvbk3F8QM87WCpD9Jv5WdL5
         5+bCNCqBRLoRuhkuItaW1xAw2Pl2b6KISeC1S3Et2HNOy1Ug9tLhRJDpqUAzly90H6dK
         BUEX5UYm6DCF1zZXitjjl89KDevLAoQHiYCFMg1k4bA7lEzLLeyM4IwzYEplmCgJxZWP
         WZywanPjVo6vKp7B+m08RfbvNZTb38PKNr8bbl+BK8kTMJGeu9MgKJiRhD4ee7DlO2Qx
         gPcgsPzeU0Stk7SI6VxqWolmR4aMBYFTjgK9KRcv8MC8IJQSBaJ2IPQ/fETSw+Ns75Qu
         ekFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rUdTMX0LV19a/cAOPF7U+URSV6+2wG5VEFj80ZdTTHM=;
        b=eNP5gGhKab3Z4j4B0HxoIkU7Lo401yZErc6XC7gnVNlYqm/WEUNzGoTDMvSy3yqq/f
         Hs1cVIJdiQwpZ523hOXWzgiW/BTcBWDRwDy+kU7kUe+1WCjNFv+mtD3xUOKmH4HLPHuP
         SwvKaRHD6tkRRGZAaew1EsjCQpBUuxJPuKOQJ/Ne5H1d2FC2bQkc3bCfT8gxg+Si3jde
         4RFLWKJTgszTdh/lqXYxeLVTmosYFPY8bhlVY46J0VmwNbi1TnEgPJDo2XNR8S+V4rHG
         2H5j0UfXxsCayQZfpqxYV1XUSU8X53PEVxxt4KloEFY6QbeCcRE1U/q67dWqup5JU3MZ
         +s+Q==
X-Gm-Message-State: APjAAAUy1bdniC7W0UdkjNwkUPDfElH16qsOORv5T/vJR9HkCSYUALB4
        st38kxNVDVybmqMNDvmFgz+YiA==
X-Google-Smtp-Source: APXvYqzwerfHRQEyJHbY5+rTHUqQNOr5JHizI7qufMfJPAK96VEw4y+E3DkhnHaBl6xc+Xjo3KdzGA==
X-Received: by 2002:a5d:660c:: with SMTP id n12mr615084wru.286.1569328805014;
        Tue, 24 Sep 2019 05:40:05 -0700 (PDT)
Received: from starbuck.baylibre.local (uluru.liltaz.com. [163.172.81.188])
        by smtp.googlemail.com with ESMTPSA id u83sm2888165wme.0.2019.09.24.05.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 05:40:04 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] clk: actually call the clock init before any other callback of the clock
Date:   Tue, 24 Sep 2019 14:39:52 +0200
Message-Id: <20190924123954.31561-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190924123954.31561-1-jbrunet@baylibre.com>
References: <20190924123954.31561-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 __clk_init_parent() will call the .get_parent() callback of the clock
 so .init() must run before.

Fixes: 541debae0adf ("clk: call the clock init() callback before any other ops callback")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/clk.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 1c677d7f7f53..232144cca6cf 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3294,6 +3294,21 @@ static int __clk_core_init(struct clk_core *core)
 		goto out;
 	}
 
+	/*
+	 * optional platform-specific magic
+	 *
+	 * The .init callback is not used by any of the basic clock types, but
+	 * exists for weird hardware that must perform initialization magic.
+	 * Please consider other ways of solving initialization problems before
+	 * using this callback, as its use is discouraged.
+	 *
+	 * If it exist, this callback should called before any other callback of
+	 * the clock
+	 */
+	if (core->ops->init)
+		core->ops->init(core->hw);
+
+
 	core->parent = __clk_init_parent(core);
 
 	/*
@@ -3318,17 +3333,6 @@ static int __clk_core_init(struct clk_core *core)
 		core->orphan = true;
 	}
 
-	/*
-	 * optional platform-specific magic
-	 *
-	 * The .init callback is not used by any of the basic clock types, but
-	 * exists for weird hardware that must perform initialization magic.
-	 * Please consider other ways of solving initialization problems before
-	 * using this callback, as its use is discouraged.
-	 */
-	if (core->ops->init)
-		core->ops->init(core->hw);
-
 	/*
 	 * Set clk's accuracy.  The preferred method is to use
 	 * .recalc_accuracy. For simple clocks and lazy developers the default
-- 
2.21.0

