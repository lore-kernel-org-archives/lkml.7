Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478A0C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 18:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204DB217D4
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 18:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfHKSdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 14:33:15 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:44874 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfHKSdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 14:33:15 -0400
Received: by mail-yb1-f193.google.com with SMTP id y21so1411325ybi.11
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 11:33:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ch+rXpu4FEjXRcLVZJZ1wzxNcCLlNLjg4OF4veGTZaE=;
        b=PLv1C7MJ0MF2MyJAjKWePs5Vm4uk5PvGbWYzn0LDTH5lRz166a+NXvX3pmjaSmjhVC
         9faNDCiK2CTpEZNXlH1X4lPwGzGNFq4L0sSTJamKodX290i5i0WOySLMmwIgBydE288f
         4JgsOLSRMB/MhxFbQusKw7lu6meDjvZKYPTSS1DJgGJhcJWX7uZMm9ujpju2iJ8hhqJS
         kZuOHeSqJVt60gBtHYTF3BGQeyfyAiPPtmUYYt05vami2g3YY0F1SiGLTBE630R4wGFz
         Jh5xHXMqPg5XeoFEpwZCjwTNqjlGEqBy9ROBELr7Rj5X53qgHa0DmJlSKQvU4kzc5yzZ
         IXtQ==
X-Gm-Message-State: APjAAAXP/Um/v4awWBKtHzoVElSBuIGOImvktdyH599ZpcIGxfkqqzo1
        kTBC/MLnI78c030UyjPs+gg=
X-Google-Smtp-Source: APXvYqyn//AFRNoWF1IJQh7tPm29GkwK4Jn+wbaWQaVwzSix5jqDcgDb8XYCLTcrCCIrsw3gqBsyMw==
X-Received: by 2002:a25:9d09:: with SMTP id i9mr21373793ybp.103.1565548394282;
        Sun, 11 Aug 2019 11:33:14 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id v203sm23315484ywa.99.2019.08.11.11.33.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 11 Aug 2019 11:33:13 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        linux-i3c@lists.infradead.org (open list:I3C SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] i3c: master: fix a memory leak bug
Date:   Sun, 11 Aug 2019 13:33:06 -0500
Message-Id: <1565548386-4485-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In i3c_master_getmwl_locked(), the buffer used for the dest payload data is
allocated using kzalloc() in i3c_ccc_cmd_dest_init(). Later on, the length
of the dest payload data is checked against 'sizeof(*mwl)'. If they are not
equal, -EIO is returned to indicate the error. However, the allocated
buffer is not deallocated on this path, leading to a memory leak.

To fix the above issue, free the buffer before returning the error.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 drivers/i3c/master.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index d6f8b03..562f69f 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1084,8 +1084,10 @@ static int i3c_master_getmwl_locked(struct i3c_master_controller *master,
 	if (ret)
 		goto out;
 
-	if (dest.payload.len != sizeof(*mwl))
-		return -EIO;
+	if (dest.payload.len != sizeof(*mwl)) {
+		ret = -EIO;
+		goto out;
+	}
 
 	info->max_write_len = be16_to_cpu(mwl->len);
 
-- 
2.7.4

