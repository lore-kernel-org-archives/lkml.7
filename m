Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12710C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 16:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEDF7216C4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 16:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsmBerrW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfEQQxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 12:53:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41475 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfEQQxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 12:53:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id g12so7572392wro.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 09:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eOFVUmpMlxT1rgTfcNFqTqJD4K4q18GK946ds9N3qFU=;
        b=dsmBerrW0KEWYy8Sd4HFLOergaCVUedn0iM/0tpAMDcku9/23tuGzzqYbJXeCQvMPA
         jvaYH1a7anzSWWcy+3m7pYYf936uN+DbiE6uMFJIc4GJOOwJ2uCiALJYsRk3R4XEUC2A
         TX8nC83r+ypCSkA0txqWgOLXwT1yoTIY3rvXmw2bocEOPYR2RKNV7L9b9LfIVEloV6Nb
         Pl63NU9wi2nEej7cLLykKKZ8Ar1Ty1c0L4JnXRSRp5Jd9qpv+e0EXAKoPiGUwMx8ICWu
         ofnh+RwSqw9Mi5cr7fqVUUYrMqviHPyvzg9+MxNN7x9NFCsYb/ijwltwIlTIlcofguV1
         nl6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eOFVUmpMlxT1rgTfcNFqTqJD4K4q18GK946ds9N3qFU=;
        b=LL3MeL8/+qALDh3OYzKhg3PQHf0YnMhhm25cHawpmRUealtVQ7rGgK0K1vSI9nDnEp
         1priLpdLDeuK1wWsp6/zMhSnyGQ5CVq78bq5MlEwkjZMuiwB1cmD1YA13t4sS5BzMpIS
         vghJ2UwgWZirvETZzvverx0ww4mOjqCL4bxy6/ttIedxfuArhxMIxEgBC0w21CW62IFG
         yTEwlMPysUCxd6KcwRXJBT8tj7iF3PO1nRmrgXK5WXvlqiOCFXe4j2rjJLpyL9YWykYK
         4U/MMowhRQw7OAoU2gzbl6a+Hyj3mEAsVGbckFJFtkZ/JQstYQXsywtL5Zm6ofxcjOAA
         vvAA==
X-Gm-Message-State: APjAAAVYrzzwzDKJNomwLjrGdamp/UiMYdcQKCQkvFYAJvG4ZkKZhXth
        oPOLIb5h1EmB2PltI1ca2T4=
X-Google-Smtp-Source: APXvYqxzwPBkio6lC+ydvkXLCUu+2O2QUexsyscQ50xgHeMpsARvymCIsU28JwUsJd9FhtdDJzY2jA==
X-Received: by 2002:adf:e344:: with SMTP id n4mr12363332wrj.192.1558111997983;
        Fri, 17 May 2019 09:53:17 -0700 (PDT)
Received: from luna.home (2.154.17.217.dyn.user.ono.com. [2.154.17.217])
        by smtp.gmail.com with ESMTPSA id w185sm12701690wma.39.2019.05.17.09.53.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 May 2019 09:53:16 -0700 (PDT)
From:   Oscar Gomez Fuente <oscargomezf@gmail.com>
To:     oscargomezf@gmail.com
Cc:     gregkh@linuxfoundation.org, thesven73@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: fieldbus: solve warning incorrect type dev_core.c
Date:   Fri, 17 May 2019 18:53:11 +0200
Message-Id: <1558111991-30751-1-git-send-email-oscargomezf@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Oscar Gomez Fuente <oscargomezf@gmail.com>
---
 drivers/staging/fieldbus/dev_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fieldbus/dev_core.c b/drivers/staging/fieldbus/dev_core.c
index 60b851406..f6f5b92 100644
--- a/drivers/staging/fieldbus/dev_core.c
+++ b/drivers/staging/fieldbus/dev_core.c
@@ -211,16 +211,16 @@ static ssize_t fieldbus_write(struct file *filp, const char __user *buf,
 	return fbdev->write_area(fbdev, buf, size, offset);
 }
 
-static unsigned int fieldbus_poll(struct file *filp, poll_table *wait)
+static __poll_t fieldbus_poll(struct file *filp, poll_table *wait)
 {
 	struct fb_open_file *of = filp->private_data;
 	struct fieldbus_dev *fbdev = of->fbdev;
-	unsigned int mask = POLLIN | POLLRDNORM | POLLOUT | POLLWRNORM;
+	__poll_t mask = EPOLLIN | EPOLLRDNORM | EPOLLOUT | EPOLLWRNORM;
 
 	poll_wait(filp, &fbdev->dc_wq, wait);
 	/* data changed ? */
 	if (fbdev->dc_event != of->dc_event)
-		mask |= POLLPRI | POLLERR;
+		mask |= EPOLLPRI | EPOLLERR;
 	return mask;
 }
 
-- 
2.7.4

