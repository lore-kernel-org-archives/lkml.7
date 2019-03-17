Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DC2C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 03:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34B7218D0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 03:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4Q+ivyF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfCQDnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 23:43:07 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:36928 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfCQDnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 23:43:07 -0400
Received: by mail-wm1-f41.google.com with SMTP id v14so890180wmf.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 20:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zCFeCo9jfyzbFu9on12SSuPHmbccO4YKVoxxZUjoebM=;
        b=e4Q+ivyFEjJYWH3r0ODhhHSb/tzXyMdCrNlayCevlkr7VFUK0vvc1hoctdhpIKDJDs
         XDqC3ImI5sMlLVpLoPAzGnqaJd4QXzw0uXc/e5VgXz3McyKE0t/PWZ1oGMJfsSXjP1nb
         iR5aWvWPbzFJcFwf4SD2m+vFw11DdjKkm7lDgPjFAUqGBrVuvEKnrzY64xJoc90jg4wR
         EiWJ5XtSpp2z4azepzL69EzcIJE9rwhkS7ZQ7gMq0BXl7iRmr8fxf1TYGXNNjPPGT0eQ
         mV0h9nAlTYogk1M1yK3yNWRzPDAvSMUNJ6JRmyuiHNbqrIk9eAHNpzzXlVDIWjYHDkBv
         J5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zCFeCo9jfyzbFu9on12SSuPHmbccO4YKVoxxZUjoebM=;
        b=eNgRGqS3KKjWwRq1MtWH6bVOVw1/k+nOFqsp9YzEDOWK2S9xlOZllHrjN2RUCh44fR
         6khtWKt77EYQK82DMDHxj/frvbyKjiCoEtwaG2FCNq4+nB6QJtRd57qzWiHqHMs65MIJ
         8Dedyhs0c3c3Vo1CVwYVr2SDqSjiWNQT6cf+SM2UHo7umICZdhtHLEW32AuqbUKLr8lD
         Q5M4KdEhOY71cjPv7uZjufSL0iQuwbBnlIsYT7oOn/L4WRhITl2N7/0Lk1Nxt2N7M/8g
         ts47FT2uxhALeRMZbsxX3jPzI6N9dqkaLMlKHQwk1EPYZyM2nwIiBRnDR3w8uz5BHBIV
         Un2g==
X-Gm-Message-State: APjAAAX2su0gSnDfmpEcT2aHt2sTlTy7P009+H2xvadl8eBbJCPLswWy
        zsxDQBPprnN1COumzvHzdZJFxSE=
X-Google-Smtp-Source: APXvYqzpAnulDh0s2VIYNKwL4BfGfTyi5UVNRHR1fZuh13e7abg2gyCeNtk5etd3p1Jn7UlXSHT1+w==
X-Received: by 2002:a7b:cd82:: with SMTP id y2mr6363962wmj.121.1552794184839;
        Sat, 16 Mar 2019 20:43:04 -0700 (PDT)
Received: from localhost.localdomain (cpc102034-bagu16-2-0-cust471.1-3.cable.virginm.net. [81.97.71.216])
        by smtp.gmail.com with ESMTPSA id w10sm6398386wrn.32.2019.03.16.20.43.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Mar 2019 20:43:04 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org
Subject: [PATCH] staging: speakup: fix line over 80 characters.
Date:   Sun, 17 Mar 2019 03:39:46 +0000
Message-Id: <20190317033946.12585-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix coding style issues, which solves checkpatch.pl warning:
    "WARNING: line over 80 characters".
---
 drivers/staging/speakup/kobjects.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/speakup/kobjects.c b/drivers/staging/speakup/kobjects.c
index 2eb5af3debb3..abeab64899db 100644
--- a/drivers/staging/speakup/kobjects.c
+++ b/drivers/staging/speakup/kobjects.c
@@ -154,7 +154,7 @@ static ssize_t chars_chartab_store(struct kobject *kobj,
 			continue;
 		}
 
-		/* Do not replace with kstrtoul: here we need temp to be updated */
+/* Do not replace with kstrtoul: here we need temp to be updated */
 		index = simple_strtoul(cp, &temp, 10);
 		if (index > 255) {
 			rejected++;
@@ -788,7 +788,7 @@ static ssize_t message_store_helper(const char *buf, size_t count,
 			continue;
 		}
 
-		/* Do not replace with kstrtoul: here we need temp to be updated */
+/* Do not replace with kstrtoul: here we need temp to be updated */
 		index = simple_strtoul(cp, &temp, 10);
 
 		while ((temp < linefeed) && (*temp == ' ' || *temp == '\t'))
-- 
2.20.1

