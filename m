Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A06DC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37AD520675
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHE7LSfV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730978AbfDQHGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 03:06:21 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45888 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfDQHGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 03:06:21 -0400
Received: by mail-lf1-f66.google.com with SMTP id t11so13517622lfl.12;
        Wed, 17 Apr 2019 00:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=S9RZFSRW57VtsUIcux9hVk8YIz9I5oYSs8c9bBSdg8g=;
        b=HHE7LSfV4rSk2kILbi/if22pdx/SlNLunq42CQlsSh168S5KFwBeWJOkGSqv9EbNrv
         R7lsPltWYy7DNqCorCn8eKcE3v/JIMJygLav3BSGz34VfvpbJ9Gw6rc0BLyUxnBds0Xv
         AHWhwufsv58ZjLXO0PYoD3Y3F6TRTsuxGcaVrqHViqFjd2vqNT8hGJeL7lPpjAuvERD2
         ITOPXvPME6uBgoINtz0yUWxn7Rtv41z0y8bkJxnCYDHAdSXAaWV0qQ+B44uuelZ7IvJq
         v73Hvjx7stq/5Nh5X3xaEbHjI6+VVcCWeM3zNE7a7QVsAOgaEf21lNTooKi4HueKkfpD
         jSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=S9RZFSRW57VtsUIcux9hVk8YIz9I5oYSs8c9bBSdg8g=;
        b=lZKEilaq5HPYOrcCnKoHo21f2ubTgnXj1Z/Y1U2Glv4GXmas/+SnzuOo2AOknusyvw
         H0Zu9JgDfa+06j2nXM0IBlPa3hacWJI3I/XDcMOLKA5n2xa/6J90aHpIqaujW1Lp2Eq+
         Tq4b8RvUpQGHGbMUlo5p2r26aOLrFnQ+davS+lP9IeDrermXYuAhGCKAYXQpaKjyaeps
         CRynPZRXaGTfUYOzaXUQobfuSDysFo7FvbRpntIJGeyKK+SHuqJ6kyhWF9ttCYgLhY4Y
         k0cA88d6nsAkWsVg1hr+u87dRZlHoZ+t1tpFvRe0iyRTSWhzxi4AicVhg59lqqXPDLRE
         ZSEA==
X-Gm-Message-State: APjAAAWXI2ceTewzpbM8xhUJqNDkG8bWAplzweGECv+iUY4nV4oMO0HO
        22Q+ttipdD5beE+46U697Yc=
X-Google-Smtp-Source: APXvYqyuP5rXH0JLj607qwgN67cxW27wWX7j+d+b3g+XCZewDC5wYCfmJahpksBJP5FEqacMnyjPPw==
X-Received: by 2002:ac2:44b2:: with SMTP id c18mr3882546lfm.86.1555484780022;
        Wed, 17 Apr 2019 00:06:20 -0700 (PDT)
Received: from localhost.localdomain (62-167-31.netrun.cytanet.com.cy. [62.228.167.31])
        by smtp.gmail.com with ESMTPSA id z15sm10492236ljz.55.2019.04.17.00.06.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Apr 2019 00:06:19 -0700 (PDT)
From:   Mohan Kumar <mohankumar718@gmail.com>
To:     rjw@rjwysocki.net
Cc:     daniel.lezcano@linaro.org, benh@kernel.crashing.org,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: cpuidle: This patch fix the following checkpatch warning.
Date:   Wed, 17 Apr 2019 10:06:14 +0300
Message-Id: <1555484774-5866-1-git-send-email-mohankumar718@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use pr_debug instead of printk

WARNING: Prefer [subsystem eg: netdev]_dbg([subsystem]dev, ...
then dev_dbg(dev, ... then pr_debug(...  to printk(KERN_DEBUG ...

Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
---
 drivers/cpuidle/cpuidle-pseries.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index 74c2479..a9c1db8 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -282,7 +282,7 @@ static int __init pseries_processor_idle_init(void)
 	pseries_cpuidle_driver_init();
 	retval = cpuidle_register(&pseries_idle_driver, NULL);
 	if (retval) {
-		printk(KERN_DEBUG "Registration of pseries driver failed.\n");
+		pr_debug("Registration of pseries driver failed.\n");
 		return retval;
 	}
 
@@ -294,7 +294,7 @@ static int __init pseries_processor_idle_init(void)
 					   "cpuidle/pseries:DEAD", NULL,
 					   pseries_cpuidle_cpu_dead);
 	WARN_ON(retval < 0);
-	printk(KERN_DEBUG "pseries_idle_driver registered\n");
+	pr_debug("pseries_idle_driver registered\n");
 	return 0;
 }
 
-- 
2.7.4

