Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AE9C43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 15:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0E9206D3
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 15:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="pTBjmvig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfLOPeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 10:34:15 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:60834 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfLOPeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 10:34:15 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 47bT396r0Cz9vZ5y
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 15:34:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sRzJweORFK_7 for <linux-kernel@vger.kernel.org>;
        Sun, 15 Dec 2019 09:34:13 -0600 (CST)
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com [209.85.219.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 47bT395Xt6z9vZ5l
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 09:34:13 -0600 (CST)
Received: by mail-yb1-f199.google.com with SMTP id d131so4542183ybb.9
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 07:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i1SA+jg2gGa3dwFVvbbudYqmdZ+Mqv92RS/q1DFUgTQ=;
        b=pTBjmvigNCVOvqSiZs1hBHOH1Kzfu4TiQaO2S0qrEPHn1tHHhGT49FjrQ+SeQL63xn
         K0tFGUreLj+YUsPDcK+tM3zOZR3BywZb6PDe9JJcJLvfT1KwxuvchO5lb4pLSMpiiznS
         8TUTnerRlDIURs3zOt3ocKL5nuhR6/SNLM9XWdOzC/bafAio9kdR9YXZvxBkF28YeSXm
         RQS8xlzhDSTfSyQfXu49fMu21CD1m34o/H1AEJpDkdjXpwgqDL+URwLcMGHhIHIsgoWB
         4rrKboRDWUWdZjflcMybZhKxTxKejLNUliPLFFpn+GTYSSslJBMcGVC2UW8aW4XfNt8q
         aCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i1SA+jg2gGa3dwFVvbbudYqmdZ+Mqv92RS/q1DFUgTQ=;
        b=Ial0MCRxtWm1xH1OCT6PANHA6abVbwJflQr1gZ5ywlP5qnUu18szPoMgCbMyTWedC3
         753Xjj/uF40CmU72jDHY5x2ZOj4ww+FenqxrY9rlS98zMJfTY9a4kFzy/G65X4VKEB05
         Q3ZCvyS9FFMvnnk3apZqsnjPdz4NqGDf7RpMkmOhPQRXkaLAnbPTZaCRd0h7IhJavqfc
         YZxweuEArPYFiD1+AUlqsSmLNseco3gDK3yUpnNkCJKgSnaXDAAfLsNlqqdQiwcag2tz
         jXnVXbHBbcSvcuc7eN/ZBfiHRWgpdzYl4qzzAbkzLYrLUOS/JUI1mZwuf7mxZuDZ8CGe
         4yUA==
X-Gm-Message-State: APjAAAXFwuzOtlaCXz8tttuFefxpVv+dPMtgF2J2D2EvunWoc0UMyDxh
        9WCV+fpKqERanF5VWze7pAgNArV2e1J7uMpmiPphiCpXCT9qS1UvUUJ2L++ppCQ5iMcy+m4VwdT
        RZjYNvR04VwC4Lw+SQoycrVnyXSu3
X-Received: by 2002:a25:c203:: with SMTP id s3mr10302773ybf.248.1576424053207;
        Sun, 15 Dec 2019 07:34:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqzWR0ABIY4j4gOHYOR/m/1iY5qE/oV04KBsDfR0PSl9Tz4QWfFmO9sfezqVLhY/DQiBQmeiKg==
X-Received: by 2002:a25:c203:: with SMTP id s3mr10302762ybf.248.1576424052990;
        Sun, 15 Dec 2019 07:34:12 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id d126sm776365ywf.28.2019.12.15.07.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 07:34:12 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rfkill: Fix incorrect check to avoid NULL pointer dereference
Date:   Sun, 15 Dec 2019 09:34:08 -0600
Message-Id: <20191215153409.21696-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In rfkill_register, the struct rfkill pointer is first derefernced
and then checked for NULL. This patch removes the BUG_ON and returns
an error to the caller in case rfkill is NULL.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 net/rfkill/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/rfkill/core.c b/net/rfkill/core.c
index 461d75274fb3..971c73c7d34c 100644
--- a/net/rfkill/core.c
+++ b/net/rfkill/core.c
@@ -1002,10 +1002,13 @@ static void rfkill_sync_work(struct work_struct *work)
 int __must_check rfkill_register(struct rfkill *rfkill)
 {
 	static unsigned long rfkill_no;
-	struct device *dev = &rfkill->dev;
+	struct device *dev;
 	int error;
 
-	BUG_ON(!rfkill);
+	if (!rfkill)
+		return -EINVAL;
+
+	dev = &rfkill->dev;
 
 	mutex_lock(&rfkill_global_mutex);
 
-- 
2.20.1

