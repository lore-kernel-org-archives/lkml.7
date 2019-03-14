Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCD1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07BF4217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="XRYUAOBi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfCNGzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 02:55:40 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:49846 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfCNGzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 02:55:39 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 6687EC4F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 06:55:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id p007qJI1OT7I for <linux-kernel@vger.kernel.org>;
        Thu, 14 Mar 2019 01:55:38 -0500 (CDT)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 347B4BF0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 01:55:38 -0500 (CDT)
Received: by mail-it1-f197.google.com with SMTP id y6so1273352itj.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 23:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0wysLjVZTWrkN4pEpW8FoQb9oTPXdHUHYTODbADcuFw=;
        b=XRYUAOBitTxGUW47TpCvTzJ/g4J35KjBLJL2fq+l1ZW5gXFgLuXXdx/Fpcy69ZbuLq
         YcSGc4/TqxePRcFGPK5TLdcjZiQfxKO/vByZFzkHgpowyqjc5d5r+YNhoJusr+4fDRH2
         tdJUzKglfhUXvvemu9c5Tfk0Sk7dntocyY7z11pzMIxcocjAq01M5Q9FT+qzh2hVctri
         PYDCbOcJQiXcdR+TxCTAQSAeK+xHW9sd0CncxlGRopCBxHp/9pSetj0QiX5gbteSpCxJ
         lfduewSCR7/b7HUrTdvUi4gijYJiuD2KLziEQCmRCEekUQRm3sjZmyScawcInxPWjE3j
         gBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0wysLjVZTWrkN4pEpW8FoQb9oTPXdHUHYTODbADcuFw=;
        b=XXx/Z5bBv/MDgRVtG9F5F0Fjw6hvsbLZMjCm6l4rGOVXL1V8G4FG8RoVxvxYsp6JiF
         +FYyHeeQnxNtGnT1zzvG2vbUMQCsD44OkMb4x7nuYKN+DI6uVtpM7qSU0VZSZyzRSLJc
         GXyvbigJ+Pi64SwcYEWlq3CdZ3jAHxKQFJCV8QZxt3wHImELQGOjXOmdEIme/c8ZpTew
         OBSwk9bbAJRcU9Z7Foi6UAzRVhtsG1ASbfbZKq60vd3QxTHzzVR3+Hz9/A7KHbl4eLxJ
         yqnPbw8EWnZVIP+Elp0LLPv9pI5Yml+6mA2QZPPNDZu+7x6qNlzGOjkK2STU6Bx2nC8+
         yVYQ==
X-Gm-Message-State: APjAAAVk90TQXTPQpKUH2BUf1Fc/jYuOfa8qtLcbHs4EMtm0X1h633CC
        /6Mci4yUDbXeNP9Pe7S3TEmQlL/lLoVEbvNTfIzk/dLzhboXXpIltWn2l9BohJ1hmVDdsn4B/Ht
        ymY1uguQrPItHE2k/galcG0AOzlWo
X-Received: by 2002:a5d:9a8d:: with SMTP id c13mr178664iom.195.1552546537821;
        Wed, 13 Mar 2019 23:55:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxca02iLz7CKzuBBVdOM4AbjL+hLQDHebyBiP4XjE56JVa8eWhGE53k+wKstdtw+gThNIKwGg==
X-Received: by 2002:a5d:9a8d:: with SMTP id c13mr178656iom.195.1552546537589;
        Wed, 13 Mar 2019 23:55:37 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id i5sm733983itb.3.2019.03.13.23.55.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 23:55:36 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] thunderbolt: fix a missing check of kmemdup
Date:   Thu, 14 Mar 2019 01:55:31 -0500
Message-Id: <20190314065531.16776-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup may fail and return NULL. The fix adds a check and returns
NULL in case it fails to avoid NULL pointer dereferecen.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/thunderbolt/property.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thunderbolt/property.c b/drivers/thunderbolt/property.c
index ee76449524a3..841314deb446 100644
--- a/drivers/thunderbolt/property.c
+++ b/drivers/thunderbolt/property.c
@@ -176,6 +176,10 @@ static struct tb_property_dir *__tb_property_parse_dir(const u32 *block,
 	} else {
 		dir->uuid = kmemdup(&block[dir_offset], sizeof(*dir->uuid),
 				    GFP_KERNEL);
+		if (!dir->uuid) {
+			tb_property_free_dir(dir);
+			return NULL;
+		}
 		content_offset = dir_offset + 4;
 		content_len = dir_len - 4; /* Length includes UUID */
 	}
-- 
2.17.1

