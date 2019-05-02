Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6163FC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BE9206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pe194CRa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfEBI7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 04:59:41 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36692 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfEBI7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 04:59:39 -0400
Received: by mail-pl1-f193.google.com with SMTP id w20so723108plq.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 01:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wImb9CVB4GpKwFy3KJ9W0eoEvKw0F8sKUcEl8Dq86qE=;
        b=Pe194CRa2me3Ghu8Yu/zv3y+hAl4SMpjEVeenRNYgMHMHQcT+CIAECk8cTTi/MXGMb
         cLc0WWUnGRJ2Xdz7LMrvy0jYgM298w6ByzFtPn1DN0ZHYDJ3EjMLPzaLXobNAXlAbwWH
         5wVdgyyR2LoGOzs9//qw7ExIrb/gijuwSpk1iRk7Kl4+w5MUrSAzjSoigSQIk7H1Z6HC
         Qy3FMAPmCa5DZ5Q/FqKSeYm5AySYILmJ+IQyabQe7Al5oOHfj+uAV+NCrDbWBfBTZQeD
         prmOOfpQM+fDlRdotLooWaaPLvvai8kirQmdq3YV16fIi6et4pE7QSDKz3n5z2eogtNc
         Strw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wImb9CVB4GpKwFy3KJ9W0eoEvKw0F8sKUcEl8Dq86qE=;
        b=Xuqv11f0+R40HdLAo2Qdl1VmynUaXs4NH6Vq21+/7kcNGxNAyH8LsXOOOuBiPYcASc
         mdS4OHK4Ga4E6DlxpcvlJz5erbW/y0QW+Dx5SSiuIVgmGg3/W3/PFHjiYE+JrxTvPyNx
         OsNfz5RvZB9vR5cAOyUqSPMMclgUEnnDvhlFV06ZIC+YcE34x2Sq3EkLj0AuMb5d4pjX
         Y8o0eWrSPz70gCJBjAdUHR0aazOGeF2aq9YOToXHHhE1s4AMHKNTFV+NTPXj4efNKGCA
         xfZLZ0EsBo2dI/0Ak6X7SNHMJrIlWyvqHZDtf9P22RlpspU4SzqBQ4a3k6YrnpLc6PGO
         IIjA==
X-Gm-Message-State: APjAAAWNcJixW/oAS3ECi2URJAH4kfiz7Jkq/zEsZVfbdBVPTjXb1ggF
        Q61YFvT6BmAF63ZCDhu0wWo=
X-Google-Smtp-Source: APXvYqxIQ29qxZR0+mT0u+86fJergDHo0If85mcV2/WYaiVy1J7IWdKdwrwEccSrFaEqyG9gJWsnnw==
X-Received: by 2002:a17:902:b20f:: with SMTP id t15mr2501576plr.341.1556787579352;
        Thu, 02 May 2019 01:59:39 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:1b24:991b:df50:ea3f])
        by smtp.gmail.com with ESMTPSA id z7sm74960831pgh.81.2019.05.02.01.59.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 May 2019 01:59:38 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 1/4] devcoredump: use memory_read_from_buffer
Date:   Thu,  2 May 2019 17:59:18 +0900
Message-Id: <1556787561-5113-2-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556787561-5113-1-git-send-email-akinobu.mita@gmail.com>
References: <1556787561-5113-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use memory_read_from_buffer() to simplify devcd_readv().

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/base/devcoredump.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index f1a3353..3c960a6 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -164,16 +164,7 @@ static struct class devcd_class = {
 static ssize_t devcd_readv(char *buffer, loff_t offset, size_t count,
 			   void *data, size_t datalen)
 {
-	if (offset > datalen)
-		return -EINVAL;
-
-	if (offset + count > datalen)
-		count = datalen - offset;
-
-	if (count)
-		memcpy(buffer, ((u8 *)data) + offset, count);
-
-	return count;
+	return memory_read_from_buffer(buffer, count, &offset, data, datalen);
 }
 
 static void devcd_freev(void *data)
-- 
2.7.4

