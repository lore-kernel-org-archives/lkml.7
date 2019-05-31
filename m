Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F29C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 18:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C0226E28
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 18:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGTETKfe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfEaSxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 14:53:22 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35937 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfEaSxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 14:53:22 -0400
Received: by mail-ed1-f68.google.com with SMTP id a8so15992193edx.3;
        Fri, 31 May 2019 11:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=piCJ6jEF6MBc4EJPMFsudzP7NRZDnr1GSlVWfPmBoUQ=;
        b=pGTETKfe1tTLLxY/NozLw5pRvA556SpSsWvFQ/zFFBI68rKKDwsQl2SCdYv+30I17T
         4d1GZKf5SUaDUAi+D48E3fBGZjv5XACgWmfCtfq3iZF50PJoGmkaxwxqy6YTeOy4wmLw
         roa21TEQ12TNacClYrWZtAS+15Qi5OYX+pPK8yMm6XDZCo68CfbQCrs49GVjQ8O9ufdX
         EPFJbArhE81aIUqwAuj0ZyOBWgO3ClwISo7P77bGK3R+blXcZuxdIWp//mPioP7SQ8rP
         0qKOpTzJnIQZPrtZOyW9haCplftEH1/a7vRbz9Lmad3fOP8PFP4zBgF19XpG8tVxF3IH
         kzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=piCJ6jEF6MBc4EJPMFsudzP7NRZDnr1GSlVWfPmBoUQ=;
        b=oNwO0cwP/sDdjTRB5i1I1aJNDniVWatc13zs3BF4hfY2ZTwUekY5/7RVd2KDm22J4I
         C8C9/QKoAsdiplYOii09mDqMrOU4isxbAHZ7/izCFXjrAgbA/4FpJQecJWtQZZKmahW1
         /nDlfPyHe7ahbTmuzCrGTDEnbU3Gx4m6/iFt3pXmI3JP1x9dRLBo1v4rKg1uYu59q/ee
         PfIhWk3fZspqfbqSe0pXBGXmtrPya2AVjKc0PH0ZSAoy2bY+Aa7QOF3H7G4v7xvXMBdU
         NHmJsha+f+1+Nlb3WKBrleRTE/c/u8XlLl+iIBClZVlem0YlJI/s3tNzlvgptInQoP8M
         uqHA==
X-Gm-Message-State: APjAAAUnP2p6r6hCEGoh4QTcFLOxq+cNeU8/dDzpHXZyMiYfkZv+8oc6
        6IOrgq1wneHtpXwpuU++2sY=
X-Google-Smtp-Source: APXvYqx535alRqStLg3CPU1+Fg/qXZIQbrvAUQDh4QWyvu8dpjY3mMQzRz94s9OTk3JQBudJj9leNQ==
X-Received: by 2002:a05:6402:1819:: with SMTP id g25mr3576488edy.56.1559328799792;
        Fri, 31 May 2019 11:53:19 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id j3sm1789080edh.82.2019.05.31.11.53.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 11:53:19 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] scsi: ibmvscsi: Don't use rc uninitialized in ibmvscsi_do_work
Date:   Fri, 31 May 2019 11:53:06 -0700
Message-Id: <20190531185306.41290-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.22.0.rc2
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang warns:

drivers/scsi/ibmvscsi/ibmvscsi.c:2126:7: warning: variable 'rc' is used
uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
        case IBMVSCSI_HOST_ACTION_NONE:
             ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/ibmvscsi/ibmvscsi.c:2151:6: note: uninitialized use occurs
here
        if (rc) {
            ^~

Initialize rc to zero so that the atomic_set and dev_err statement don't
trigger for the cases that just break.

Fixes: 035a3c4046b5 ("scsi: ibmvscsi: redo driver work thread to use enum action states")
Link: https://github.com/ClangBuiltLinux/linux/issues/502
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/scsi/ibmvscsi/ibmvscsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index 727c31dc11a0..6714d8043e62 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -2118,7 +2118,7 @@ static unsigned long ibmvscsi_get_desired_dma(struct vio_dev *vdev)
 static void ibmvscsi_do_work(struct ibmvscsi_host_data *hostdata)
 {
 	unsigned long flags;
-	int rc;
+	int rc = 0;
 	char *action = "reset";
 
 	spin_lock_irqsave(hostdata->host->host_lock, flags);
-- 
2.22.0.rc2

