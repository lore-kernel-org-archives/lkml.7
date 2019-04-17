Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AB5C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF0322173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOAWLP+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732396AbfDQOwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:52:42 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41704 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730463AbfDQOwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:52:42 -0400
Received: by mail-lf1-f65.google.com with SMTP id t30so19095751lfd.8;
        Wed, 17 Apr 2019 07:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9nw/YK2zJ58Ci60J7XUCFlBEGHNW1WY/eWuxgJxN48E=;
        b=MOAWLP+oVF13oVbQKCqJNZCj0rPLe6oVjHHqNl/hcUt+7843hetUTORZslrCY2PHfa
         35T3UnVsRfB3dOZV4MqbSrnXanbh9q2dRaQvtk4eAruZ0s3fp/8a3punwYrhzXjuI2kR
         jvb0kVfaGKj9AZg9+UTX7aa8oYt+bp5TnKFmS2vFHicsBDWn36H1URJ/LpBn6ROAL73N
         j4Qd3v1oJ3NhpxsQ8K0YqeRqpPYbluR6eaJIKjPbBqyqSeEK1RkWDSzGtpS/W4hGwQK+
         6WpptlslivEjbvGX3yrees2EVY5mP0VDEzX66ayhekw/3ExgNi+9EEn6kJYrFRSBCHC2
         AnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9nw/YK2zJ58Ci60J7XUCFlBEGHNW1WY/eWuxgJxN48E=;
        b=ZRSxqHN42qvlFBSKd3wYt2Bu9dV8PE3PrJkgIu2HrW6ROQrx/KKX1gvaFpChqLpc3z
         svfiekHFNI4PAnWEi5ByZekkQ6HZPAGyIxGXDd2EIymVJYtRbUh7xJK797Kk1jpAPO0b
         +Xq9gwJrR/wddcZixjVicmyG9GfuHsp73fiCGnimQtERouwWco35eaeIY6WcKJsFV3F5
         VmbmzHCSCq3j7f5Knvr/90UoT2RJnU25vk6pnP1+NsTkOsigjOltTNj7lFptHvs5s91v
         CMiaS0EsZuafQdIm+HN12ghBdz7IUlJfw51GACfjS/sM7CzbgvhAKZXH85CeYaDH3h4J
         dtnw==
X-Gm-Message-State: APjAAAUu5ovbtNmQ2moy4QeVc9n4jmVcuLPcPJUkEdI/yuPkYgD5MQO3
        IxaQhBGsLZ0YxTW+K4RGkgg=
X-Google-Smtp-Source: APXvYqxp9farvHtIdCO6ULBc84FlV+QVJbJ0w8usdf1jsQV2DkmHlzQ3AwOGsE/KHFT7WiuXO5J2xA==
X-Received: by 2002:ac2:41d8:: with SMTP id d24mr32478657lfi.56.1555512760453;
        Wed, 17 Apr 2019 07:52:40 -0700 (PDT)
Received: from localhost.localdomain (62-167-31.netrun.cytanet.com.cy. [62.228.167.31])
        by smtp.gmail.com with ESMTPSA id d16sm5490407lfi.75.2019.04.17.07.52.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Apr 2019 07:52:39 -0700 (PDT)
From:   Mohan Kumar <mohankumar718@gmail.com>
To:     rjw@rjwysocki.net
Cc:     daniel.lezcano@linaro.org, benh@kernel.crashing.org,
        linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: cpuidle: This patch fix the following checkpatch warning.
Date:   Wed, 17 Apr 2019 17:52:34 +0300
Message-Id: <1555512754-6450-1-git-send-email-mohankumar718@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use pr_debug instead of printk

WARNING: Prefer [subsystem eg: netdev]_dbg([subsystem]dev, ... then
dev_dbg(dev, ... then pr_debug(...  to printk(KERN_DEBUG ...

Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
---
 drivers/cpuidle/cpuidle-powernv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 84b1ebe..7cf9835 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -401,7 +401,7 @@ static int __init powernv_processor_idle_init(void)
 	powernv_cpuidle_driver_init();
 	retval = cpuidle_register(&powernv_idle_driver, NULL);
 	if (retval) {
-		printk(KERN_DEBUG "Registration of powernv driver failed.\n");
+		pr_debug("Registration of powernv driver failed.\n");
 		return retval;
 	}
 
@@ -413,7 +413,7 @@ static int __init powernv_processor_idle_init(void)
 					   "cpuidle/powernv:dead", NULL,
 					   powernv_cpuidle_cpu_dead);
 	WARN_ON(retval < 0);
-	printk(KERN_DEBUG "powernv_idle_driver registered\n");
+	pr_debug("powernv_idle_driver registered\n");
 	return 0;
 }
 
-- 
2.7.4

