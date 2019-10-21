Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEC6CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2B22067B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+RcRdC/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbfJUUS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 16:18:59 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41843 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJUUS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 16:18:58 -0400
Received: by mail-io1-f65.google.com with SMTP id r144so5694770iod.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 13:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=41sPlzPXwgbu7RVNQLT0Hyb+2XAax4ZfqY6sIsxCZBg=;
        b=f+RcRdC/dfUjDR9i9fcjXRiSoSRTEbKDszo1gkd/miZbOitkyIjk7ZV4IhZrO123Rx
         hs7sFOhOr85Gg78P83gcbPfOdAXHFDlfb5dtp1/tMbgtVpk2YB8Ht3ToJPmGREksWyQq
         RPrLjVv8uqIaTZfzdfZPBXlie0Bx/b3RPKXWZD2+Z604NtIUrGx7IvFsBWMjqVK2UHP4
         3k4e3rzI+laHqvvDVxxyfltTe7L8W1r6doLaIyjcjXbODkseCWI6e5AMx0qewrcHZUcH
         YdTgFGbDyM/6QWw9RSAFG2gwTg8Oen63WuyMfBJ3H+JzgrNaNm2J0UF/l/CeopuSaNkb
         1JJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=41sPlzPXwgbu7RVNQLT0Hyb+2XAax4ZfqY6sIsxCZBg=;
        b=HCyOYGSHno8bHbakiOYLw/iJB8oC946NOK+a2swKls2pbKvf0oTODII9kXigrHtDzY
         IXRjCB7yWkBgWRugRyRMBafYpoVMnzPh4x1Qs6Rdy+QjoC8n4c+Mpap4E6TwqNJYXN5S
         M+xt6tnINxCCz/nAbINQqYaelvUa5+1CzSx52FeErwOypcext4PU2kR0rUXI942HdR0d
         Kkkbkv6cQNV+3m6lShfbFSlQXa9qNIN/lhsOx2FteWXi6Dsyr5HSG6i9aiJ+Z6rZh2iB
         4uVfBE+t53HUCTgxy4gf6xXQuRVFlLleLE4nCnMJJWZAAdDRuUFG/IQ3PoRVigFNPxjl
         kblg==
X-Gm-Message-State: APjAAAXfPOFGgO7wltfSmEV5Dx/2DYXMkLolOey37znDoZSHVXqeUQaE
        o7U+gztLJCSIC4oVjKdPU2s=
X-Google-Smtp-Source: APXvYqzMp1w4t60E66YkFH488jk3/NEx6cWKPuFdmuiQW273dcyKd9XO/qIMhz069BX4xQZIHeFnIQ==
X-Received: by 2002:a6b:d812:: with SMTP id y18mr12058iob.151.1571689137744;
        Mon, 21 Oct 2019 13:18:57 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id b7sm4689726iod.42.2019.10.21.13.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 13:18:57 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clocksource/drivers: Fix memory leak in ttc_setup_clockevent
Date:   Mon, 21 Oct 2019 15:18:47 -0500
Message-Id: <20191021201848.4231-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the impelementation of ttc_setup_clockevent() the allocated memory
for ttcce should be released if clk_notifier_register() fails.

Fixes: 70504f311d4b ("clocksource/drivers/cadence_ttc: Convert init function to return error")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/clocksource/timer-cadence-ttc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
index 88fe2e9ba9a3..b40fc6581389 100644
--- a/drivers/clocksource/timer-cadence-ttc.c
+++ b/drivers/clocksource/timer-cadence-ttc.c
@@ -424,6 +424,7 @@ static int __init ttc_setup_clockevent(struct clk *clk,
 				    &ttcce->ttc.clk_rate_change_nb);
 	if (err) {
 		pr_warn("Unable to register clock notifier.\n");
+		kfree(ttcce);
 		return err;
 	}
 
-- 
2.17.1

