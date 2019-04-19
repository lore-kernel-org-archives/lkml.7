Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4DAC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDCE3205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L86zc2b2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfDSTzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:55:44 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38390 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfDSTzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:55:43 -0400
Received: by mail-lj1-f195.google.com with SMTP id p14so5462840ljg.5;
        Fri, 19 Apr 2019 12:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wQu8wWmDvas9DO7USsEZEuYMILtEzUJoNSRphIL+GeU=;
        b=L86zc2b2EaY3AzRnQ4xEWF0KxJXV6AZY2bomXFvh5oFIVIvIL77HJkub+89r6vzps0
         tXkfeyKDIrhzbO3pqNCcR7kUx/gqn6QTJNCacdnwT0Hiep+qvf8xh+v9lsVnRG55AYoC
         QiPYuGt0FW15ofXPwsULcRxqboRsIXzWguX5rXDEdbUzX0G9ZpWl9F/AjnYVU70Y3PRw
         75h5eHv483uD6v4jpDwZx1CtmwCHb/X+cPYsOzu02LTNXayed2byN0GPWEw2t0jX5D19
         6YJ9ZlbcTi5H5F3t5Gsxs0CAYkbq/ykmyOynvhG8dep7gwtkKMFmryhPtOHSS/jgiyRd
         da5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wQu8wWmDvas9DO7USsEZEuYMILtEzUJoNSRphIL+GeU=;
        b=J43FGeAmij7PopAx8absMMe+aXZgJNouTwS8ismUdS29qmdqhvaEoKcV7hHU8LJvpl
         AEC6KHKz2aQsDpJdSbCvdgQY/weQUfKQphrv91hg9Ef29SMqzOyJe9mM4O859Vpog7Mf
         VU5Z/eiE3mM/fIOXPAkY2E/qjZH+ZQCXde5rlpRC5hb4OGUtjG/dfr+FS7cLND0gtd6L
         XCQ1Ycvt7Oi12MlEQxFD0Jqo4m3sF6GsvRaFDZt4NmckYsOYCSxAN09xMWrSkOa/OiV6
         iL/WojqNAl/3EdlFxYiHgW6qCP8tG6fZ2qhDGxnerihFTM7JQydCoK7mU2qmw59r1Q1R
         o4JA==
X-Gm-Message-State: APjAAAXXlYzP+NkfcsrBlqtBBWG37DjBKKe78cPdJZ365kZ1rzq/zofM
        KvnxkTKqlD0xJTou5DW5NYgnHjZuDdovDw==
X-Google-Smtp-Source: APXvYqw/Ndo9kUCntIKeITpXKqqyp9wMPQz0DVGfGYy2xXkcs1UBLNOTNcMJkx85I+mGiFFm9XvARg==
X-Received: by 2002:a2e:88c5:: with SMTP id a5mr1863463ljk.5.1555669746686;
        Fri, 19 Apr 2019 03:29:06 -0700 (PDT)
Received: from localhost.localdomain (93-96-157.netrun.cytanet.com.cy. [93.109.96.157])
        by smtp.gmail.com with ESMTPSA id i25sm1033363lfc.19.2019.04.19.03.29.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Apr 2019 03:29:05 -0700 (PDT)
From:   Mohan Kumar <mohankumar718@gmail.com>
To:     rjw@rjwysocki.net
Cc:     viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: cpufreq: use kstrtoul instead of obsolete simple_strtoul
Date:   Fri, 19 Apr 2019 13:28:58 +0300
Message-Id: <1555669738-3869-1-git-send-email-mohankumar718@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the obsolte simple_strtoul function with kstrtoul.

Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
---
 drivers/cpufreq/elanfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/elanfreq.c b/drivers/cpufreq/elanfreq.c
index 03419f0..bed76da 100644
--- a/drivers/cpufreq/elanfreq.c
+++ b/drivers/cpufreq/elanfreq.c
@@ -184,7 +184,7 @@ static int elanfreq_cpu_init(struct cpufreq_policy *policy)
  */
 static int __init elanfreq_setup(char *str)
 {
-	max_freq = simple_strtoul(str, &str, 0);
+	max_freq = kstrtoul(str, 0, (unsigned long *)&val);
 	pr_warn("You're using the deprecated elanfreq command line option. Use elanfreq.max_freq instead, please!\n");
 	return 1;
 }
-- 
2.7.4

