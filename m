Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4E2C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD150216C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391557AbfGHQnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 12:43:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43216 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729501AbfGHQnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:43:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so17872022wru.10;
        Mon, 08 Jul 2019 09:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=55n7G117BbTzggJy8syt05qoj/N3+eOU6IXg7pRzqlo=;
        b=BKcBrw2+l9iWlUgCXrLJHpbZYdhOFxN3xPX42z3HozjLUFun9y/QBcXsoDKmoFy1u9
         fams8XC4zQU5aw4cH5N/n6oJUzj8XM+/NQ1+GyHwiYWjAAmo0W96YLI6mFtXIPddDezc
         OQA0lFCao3Wzzzlp/ecE8q+Tc99I0B6VcUB215fAeR0RweIVjICmK7V6iYZ9RJfpnu0y
         CpeGTVVgY653NBxDfI7KAitB1qSjzsYAiMBVmUiTlZXHifO41Z8/ub08dVSi9D1fZ2wf
         hp9ai54lSam0obb3+g7M0LNOwC/8Lc2f+E74CFgcSVYhgnSfsHyk5Ilr+MTaQUXuKU1z
         SXAw==
X-Gm-Message-State: APjAAAXJGqWr3XM4ooaKRpY+kFz11AZpveQIbNvGNbYGwwzZITrO8SkK
        mr0vFNLjyXpmw0QACC1Lezs=
X-Google-Smtp-Source: APXvYqxctTfQvixNbyMXLQSrlWoZEJrhJKEa1O4GxKAwi4a2ab5A+EjIv/dBF5FDgdU54tlHJY1TxA==
X-Received: by 2002:adf:ce8d:: with SMTP id r13mr5113159wrn.37.1562604227213;
        Mon, 08 Jul 2019 09:43:47 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id x24sm147920wmh.5.2019.07.08.09.43.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 09:43:46 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Denis Efremov <efremov@linux.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: libsas: remove the exporting of sas_wait_eh
Date:   Mon,  8 Jul 2019 19:43:39 +0300
Message-Id: <20190708164339.14465-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function sas_wait_eh is declared static and marked
EXPORT_SYMBOL, which is at best an odd combination. Because the
function is not used outside of the drivers/scsi/libsas/sas_scsi_host.c
file it is defined in, this commit removes the EXPORT_SYMBOL() marking.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/scsi/libsas/sas_scsi_host.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index ede0674d8399..5564d3f1243a 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -414,7 +414,6 @@ static void sas_wait_eh(struct domain_device *dev)
 		goto retry;
 	}
 }
-EXPORT_SYMBOL(sas_wait_eh);
 
 static int sas_queue_reset(struct domain_device *dev, int reset_type,
 			   u64 lun, int wait)
-- 
2.21.0

