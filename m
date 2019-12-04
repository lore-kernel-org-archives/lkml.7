Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4D5C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29CF205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EBNFBxZc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbfLDSV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:21:57 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40730 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730953AbfLDSV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:21:56 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so781588wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 10:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=O1blPjx9x99MiiLfjxwhHnHMTLmyX0LeLrELqmkHUxg=;
        b=EBNFBxZclvqEXx+kgjbgUf82b6Dk0QfLsMFv4yqvKmYqBIOorbg/wsInCFHB7/t9vE
         YGf9NRVtF/vps6eoJGPUeEkw7i3qXIW3hkWCd6LRJMgFpiFife8vZKR6uLy0Ns0logVQ
         eptsyjCGBfUhiMDqorIXk7sdmeFIkudfLjURrZnMSBmChfbEE2V0PfbeJhbPB59gfEmU
         uosJtm0/RUJROoFp3490v9PjJJ9uLnzsXIpSvwea8z0wBNVpDBk9AVII5atL26Ykratw
         E6cflhP/2PJ4no6PXawHAWyQn6tCbZER8KBSkR+3bV6qlg770OzYSXIXZi9afD9x8TeR
         Ryiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O1blPjx9x99MiiLfjxwhHnHMTLmyX0LeLrELqmkHUxg=;
        b=LmNqsJgfOgXedRBEsS0yzJlc+fKe7sneAUfud8PpCJg+pQ4DI1PyfuX31O6qlNGSsx
         +HsEJ+/4JBYvBZeYG4g+3SWo3vwEVEnzITifHe8cE3Tz1kExTl0J1RHHA1SJaDzUKtJD
         Zu9WUn19cjwgGsruALp7PkfWb0CDP7x6lPRo3/20Duwc2Hy1s8dMfEYwxZJXqJ3xU617
         Flrqv7GQcrVT42gvjDQ6BmIgcg3eDNxELUOVPDjy6n2tIS7kMss2gC4oBAxWT66vmiKn
         fvxm+KI9JGIgjq1fXl3KxH9BH+8GgUjeWn7Mfu2W96JvgecxpapAQYAfbEsUYimmd4bl
         D0LQ==
X-Gm-Message-State: APjAAAUaNc9wXcgLKCrkno0FPGCvLagLHVtCwK0N939B+Sh7a/33WiOl
        cl1YWjOclIuJagx/o5Nss9AbgA==
X-Google-Smtp-Source: APXvYqz2S2oM/iFvPMHeT1UyeFVCcOz5iQSKa7dYgCbdTDsXu9gApSm1l9c8JHnf3SN6oDdRs8Berw==
X-Received: by 2002:a05:600c:24b:: with SMTP id 11mr910624wmj.19.1575483714055;
        Wed, 04 Dec 2019 10:21:54 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:9:2aff:cf14:6ce2])
        by smtp.gmail.com with ESMTPSA id d9sm8608658wrj.10.2019.12.04.10.21.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Dec 2019 10:21:52 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     john.stultz@linaro.org, valentin.schneider@arm.com,
        qais.yousef@arm.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair: fix find_idlest_group() to handle CPU affinity
Date:   Wed,  4 Dec 2019 19:21:40 +0100
Message-Id: <1575483700-22153-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because of CPU affinity, the local group can be skipped which breaks the
assumption that statistics are always collected for local group. With
uninitialized local_sgs, the comparison is meaningless and the behavior
unpredictable. This can even end up to use local pointer which is to
NULL in this case.

If the local group has been skipped because of CPU affinity, we return
the idlest group.

Fixes: 57abff067a08 ("sched/fair: Rework find_idlest_group()")
Reported-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: John Stultz <john.stultz@linaro.org>
---
 kernel/sched/fair.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 08a233e..146b6c8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8417,6 +8417,10 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
 	if (!idlest)
 		return NULL;
 
+	/* The local group has been skipped because of CPU affinity */
+	if (!local)
+		return idlest;
+
 	/*
 	 * If the local group is idler than the selected idlest group
 	 * don't try and push the task.
-- 
2.7.4

