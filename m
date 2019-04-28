Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53FBC43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 10:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D1D2075D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 10:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ub76poIb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfD1KlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 06:41:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40619 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfD1KlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 06:41:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so11262666wre.7;
        Sun, 28 Apr 2019 03:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Aq6KZKXYshsYr6wQQa5JDaIk1iwAj4PjtcG2teOpu38=;
        b=Ub76poIb4dSrREQS7HWOnhTZ6HEAayTxJnVzjnIS8uqYOqdhLvBcSpYWODtq8thFv0
         pLQxvKaDxXX6iUB9N0vQBetxFxRDn+Clz9OTWVhgGUaNKe0tTRypRFM59EoxVNqlRlgb
         woGtSBc1NpXdj+66h+GDuZp25duF27LeiDJBtReycrTR1zvJVLfXNJrVyXFc3BjockLO
         ys75dGDkt5jt4p7iH+WMDCmNY7s0cV8eLk7uQO0Ds7q3ZfBER5+Fj8e1kCYEKtXG3nI0
         c65UfzpwaeDcJTLOUnauf903+m9l+9z+f5Oz5OCkgBfMfCmToAQjPhnsMLZNIzGMLqxO
         jYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Aq6KZKXYshsYr6wQQa5JDaIk1iwAj4PjtcG2teOpu38=;
        b=q55wbJy8xRaCJGEGmhnFdz7Y7NxNCc30tGT/g0CrZNnr/Djo5UDqyIbsrdtRSh9Wrc
         GcgKnXk66As0kPgxVIVT9MEP1hIhLlOA62y9uXbJ2GehfMxkabTUPN8c8XSZDmbNWXN/
         jVk7C1vDva/N55M7QNnabHw9eY2myxVpar7Aj6GF0lXZtes5GzFglQ5DCV81UvEsGLdn
         megga39MTwkiv+YlET42dYvuolj5OH12yz5Hp0bOMG4MfFBfdVSSevCFZWM7bMT9Sbuu
         joex4LUb+hbufDRpj+CayRrYJT9RgjR3FdL65xUWE7OZluqJlLIiYuyqU0LUDeowx1Zd
         hC7w==
X-Gm-Message-State: APjAAAXwtvO2+JTjCyzx2Wjzouruzcku2RVqjtk3kRR7tQNkGYIIM5zX
        Q44NzMHcE2dX6M5qM1f+s5Y=
X-Google-Smtp-Source: APXvYqzJXCDBMZpSX51c0rY7j9QFCYoCttdhjUVj7uaan2hgh4ct2FFnZAF2xaULbDdPrxWXsp6DBg==
X-Received: by 2002:a5d:624d:: with SMTP id m13mr13063359wrv.305.1556448061196;
        Sun, 28 Apr 2019 03:41:01 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d1d:6500:d144:1911:67c7:5b22])
        by smtp.gmail.com with ESMTPSA id e5sm1860032wrh.79.2019.04.28.03.40.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 03:41:00 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Shaohua Li <shli@kernel.org>, Neil Brown <neilb@suse.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Himanshu Jha <himanshujha199639@gmail.com>
Cc:     clang-built-linux@googlegroups.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] md: properly lock and unlock in rdev_attr_store()
Date:   Sun, 28 Apr 2019 12:40:41 +0200
Message-Id: <20190428104041.11262-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rdev_attr_store() should lock and unlock mddev->reconfig_mutex in a
balanced way with mddev_lock() and mddev_unlock().

But when rdev->mddev is NULL, rdev_attr_store() would try to unlock
without locking before. Resolve this locking issue..

This locking issue was detected with Clang Thread Safety Analyser:

drivers/md/md.c:3393:3: warning: releasing mutex 'mddev->reconfig_mutex' that was not held [-Wthread-safety-analysis]
                mddev_unlock(mddev);
                ^

This warning was reported after annotating mutex functions and
mddev_lock() and mddev_unlock().

Fixes: 27c529bb8e90 ("md: lock access to rdev attributes properly")
Link: https://groups.google.com/d/topic/clang-built-linux/CvBiiQLB0H4/discussion
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Arnd, Neil, here a proposal to fix lock and unlocking asymmetry.

I quite sure that if mddev is NULL, it should just return.

I am still puzzled if the return value from mddev_lock() should be really
return by rdev_attr_store() when it is not 0. But that was the behaviour
before, so I will keep it that way.

 drivers/md/md.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 05ffffb8b769..a9735d8f1e70 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -3384,7 +3384,9 @@ rdev_attr_store(struct kobject *kobj, struct attribute *attr,
 		return -EIO;
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
-	rv = mddev ? mddev_lock(mddev): -EBUSY;
+	if (!mddev)
+		return -EBUSY;
+	rv = mddev_lock(mddev);
 	if (!rv) {
 		if (rdev->mddev == NULL)
 			rv = -EBUSY;
-- 
2.17.1

