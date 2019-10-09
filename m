Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4612BECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 23:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23710206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 23:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1Wrsd2O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732402AbfJIX0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 19:26:55 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40348 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730815AbfJIX0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 19:26:55 -0400
Received: by mail-io1-f68.google.com with SMTP id h144so9379642iof.7;
        Wed, 09 Oct 2019 16:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cuZx9RP/Z6zGQW6F5i1QUaqw4xzxwrwMbDsySq/JWK8=;
        b=h1Wrsd2Ovnm+i9lUFgexhIjnqKzCMoGjbrQFLRN2t+CKoEACRrNnQMWzDYrduxF15G
         +5J3EEG1VKVSZ2Jtzt8P8jCvyL8im8hr+thoGq+jhJ6tcUPqaXQuf/spbgKriPtCyoCA
         D+M1c+OExkEeJfPwW2eMUb3TwyXcfIvArdQ+ZcrIyENCFiZObv+8SpTRqDcbiiU3gwr4
         SWdsc9H1g6CcDVYUt2LYCAbbgKcIRjJxlrlVC7yanqjqU1F00/6NnUYTI/a4QK7BRrJ3
         eKdk6UPgC2nLdoo2lmhNQyHKyEjzLANSyrG0oaVNx6Jp1d8QkrALorMWiAg51pStjumx
         wKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cuZx9RP/Z6zGQW6F5i1QUaqw4xzxwrwMbDsySq/JWK8=;
        b=jY+5gge9eK4h3JYsEdhz/INyuKeSoSPKhCJZyYX5a31SVp9mFwrUNJ6zS2CMahROgu
         6gxESVLx2hP6QlUd9+K4ap/l1WuO+Qbvcxa8OhE9xyMRJlvj+URNg5jkDR04ls/rdYuW
         H6f3cVKCJa6EAbKt+rl3NJlys/Gg6wxidl4vxyrfn12EoMA9ia19lLuULQ5aqUvbuYyV
         p56pHbABQ9CONSN6AreCjTiDNy3pZs8cWcP+e3d+kG9Yr3l2rnXlY1XK4tQ3KrCs2bsX
         F2yZiptICjDfhQytthxyHw/g/uzMV3Ol4TEhbPPyahFYliV9gB9siAghd4IVlJLc9zu2
         PtDw==
X-Gm-Message-State: APjAAAVlBPLQspzIHfw/yyIFu+GLu+gpoN+XeUnxGiOtNnLW2mYt9ZWH
        EWM7OkPBLyUYZ56ToUdrubYUPr7aQqw=
X-Google-Smtp-Source: APXvYqyDOI3fJ+Ic0Otb3zXX9izzJREPTdGeMIsHs2hq629IvbPg+pE+OGxvCxk5sGcGR8StaNMmhQ==
X-Received: by 2002:a02:741a:: with SMTP id o26mr6492816jac.48.1570663614527;
        Wed, 09 Oct 2019 16:26:54 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id s201sm3286852ios.83.2019.10.09.16.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 16:26:53 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq/cpufreq_governor: Fix memory leak in cpufreq_dbs_governor_init
Date:   Wed,  9 Oct 2019 18:26:42 -0500
Message-Id: <20191009232643.20427-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the implementation of cpufreq_dbs_governor_init(), dbs_data is
allocated and later is assigned to governor_data. But before that
assignment, if gov->init() fails this allocation is not released.
dbs_data should be released in case if gov->init() failure.

Fixes: 714a2d9c8792 ("cpufreq: governor: split cpufreq_governor_dbs()")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/cpufreq/cpufreq_governor.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 4bb054d0cb43..deb099d36266 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -428,8 +428,10 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
 	gov_attr_set_init(&dbs_data->attr_set, &policy_dbs->list);
 
 	ret = gov->init(dbs_data);
-	if (ret)
+	if (ret) {
+		kfree(dbs_data);
 		goto free_policy_dbs_info;
+	}
 
 	/*
 	 * The sampling interval should not be less than the transition latency
-- 
2.17.1

