Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C28C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1B62085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJv0jEpt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfCSQMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:12:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41014 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfCSQMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:12:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id k11so14166715pgb.8;
        Tue, 19 Mar 2019 09:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RkN43YXASvxNV4AGGWiA3z/xXIWpybddoKdSjGJiHwo=;
        b=RJv0jEptpPL6IX+y4Fjohrm1viavXwUopLxZomzKhU6OgIkiPXMcRjvlYMcECUvxn5
         WChz+1VDMZn2t2MiL7jglJsH8MSsK8TGUlKNNLUWooV2hkXjT2O33J462mBM4McZv2bm
         eVs2aaGcg2CoRpR/8oHqgME2Eo+X0FcdmKo1/iUCsg1sWK37qlmweBPTXNbQ6Kx5Vdc+
         JMhLAb9OaVKkn5Nbe/Eze9Rr2D5qcOty61dKJICASMTpp8FHzpk1ENFl4EOAMY4GQlfM
         vFzM8md8VmKO4rCKPwRmGEN9Sl+ENQHyVjhmj7cx0UOZPzFxKHGpsuqlIl4o81oLdbk2
         Kn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RkN43YXASvxNV4AGGWiA3z/xXIWpybddoKdSjGJiHwo=;
        b=DMt/T4XpClHqOOMgaIAKPKvzILzxg4cxEurexIR7MisdAzLicyvT5uRnkSUfiHY1w3
         h1hf9gYqwadyy4nnt+3mc8vAWtDcj0ZOcItH6ZLGUjvSUFAZPbtrDX5GMRFYEhrWQiTQ
         IrcZz0YsxnebjrtjVq1cB7mM8Kz3U3HSvmMD4zkqrQNbpJCAcqHYxoag6Lk5UqD0s1nB
         4bI7uuP9vtyw5/8AeeNGuLbNzqlA0Py0VR1C4iJNM8reAeJC5XGxVxvpyzXiDSPE5I/z
         9guAYIT87AS2sKpMvqYFFEtpP4gK4j2d1i4EVZnHt3BFgxmq/CN+R8Im4es+Pzh3YB/k
         7r6w==
X-Gm-Message-State: APjAAAUrU3RCXkJpPgfiOZ5Sy6Jh6BVDXhZUADpmzMcHEmRpM47WThAz
        Lj12yx2nyXHcud4NfTuxKus=
X-Google-Smtp-Source: APXvYqzSffzTChDRFzjaJ/065QyCtIuKXFTSkz9APiYc3ebB/ZG+m3R6QbUuW6z1pYT8rB74DCRhKg==
X-Received: by 2002:a62:ee13:: with SMTP id e19mr2741277pfi.224.1553011967014;
        Tue, 19 Mar 2019 09:12:47 -0700 (PDT)
Received: from localhost.localdomain ([47.91.249.165])
        by smtp.gmail.com with ESMTPSA id v4sm19233635pff.181.2019.03.19.09.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Mar 2019 09:12:46 -0700 (PDT)
From:   Jeff Xie <chongguiguzi@gmail.com>
To:     chwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     rppt@linux.vnet.ibm.com, akpm@linux-foundation.org,
        mhocko@suse.com, keescook@chromium.org, chongguiguzi@gmail.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390:tty3270:move spin_lock_bh to spin_lock in tasklet
Date:   Wed, 20 Mar 2019 00:12:36 +0800
Message-Id: <1553011956-28747-1-git-send-email-chongguiguzi@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is unnecessary to call spin_lock_bh in a tasklet.

Signed-off-by: Jeff Xie <chongguiguzi@gmail.com>
---
 drivers/s390/char/tty3270.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
index 2b0c36c2..2963396 100644
--- a/drivers/s390/char/tty3270.c
+++ b/drivers/s390/char/tty3270.c
@@ -563,7 +563,7 @@ tty3270_read_tasklet(struct raw3270_request *rrq)
 	char *input;
 	int len;
 
-	spin_lock_bh(&tp->view.lock);
+	spin_lock(&tp->view.lock);
 	/*
 	 * Two AID keys are special: For 0x7d (enter) the input line
 	 * has to be emitted to the tty and for 0x6d the screen
@@ -590,7 +590,7 @@ tty3270_read_tasklet(struct raw3270_request *rrq)
 		tp->update_flags = TTY_UPDATE_ALL;
 		tty3270_set_timer(tp, 1);
 	}
-	spin_unlock_bh(&tp->view.lock);
+	spin_unlock(&tp->view.lock);
 
 	/* Start keyboard reset command. */
 	raw3270_request_reset(tp->kreset);
-- 
2.7.4

