Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15792CA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70AD222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="LNjzhGzW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441973AbfJRFAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:00:24 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:57008 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441963AbfJRFAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:00:22 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Oct 2019 01:00:21 EDT
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 6C39CB5E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 04:41:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4RnzG78ndPZU for <linux-kernel@vger.kernel.org>;
        Thu, 17 Oct 2019 23:41:57 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 436B6B53
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 23:41:57 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id w8so6931782iol.20
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 21:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KZJ0qgGHHAivbnxIOZfhWtlIHuWG04Vj3FxHQ3w/GEE=;
        b=LNjzhGzWitDO6Aa3bHfiAIwrG2rfKBT+UuuKAqLWwQm9ZoUQBg/dJQlS+sbtMORRxa
         QLu+0EGyNHvfahcj4E5lZBPcYiQeACpKJETL3bb1hsWZjgcDjONw8wofFojapCsbneaC
         ULB9gI3Il9/kfr5+o8P39xuoixmebvksqeWje76HFyiQ0g0Br6H8VZykRZcOqRaTNOIG
         h7qRv1ptesw4P5E4PaW+nlmq9splbvENohVJpFPRat3KB2/gZxXc4o+BG3oGInvbnQJ0
         lmcGmT4wOWpSiJoR8UlRP3zZYkYoGllHW7vJor/uZZRincMS4LUiDd2Pb6ljf1C34SM8
         H1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KZJ0qgGHHAivbnxIOZfhWtlIHuWG04Vj3FxHQ3w/GEE=;
        b=ZzBelZRRhLDfzrl/EwI+9skcikFzaxCOtXy89Kjrjnq/1XmemmeAq3lDMmWiWSaq8x
         JcTuN4zDzlXwtgCCpJM2piSQD0RDTyBQxpxegYpDXnMwn0BBX8Owv4Y2GQ2h3x/LeXNN
         IIr5TZhs8T0/Ew/trbBHq5opGYLyEGwjXkyGsaW5g63j5ek3QICE0AuaCPF9GOjw744a
         fCHDEeet7L2QmR8U0jzr3d9aLCDf3eWyLnJYidFAnWUWhCMxh23qzoZEsyM3/EbZjFO/
         u25vNvG08Lc3q5swooa6gR/kMOVZNVq74BBIAzWJtbPTTDom4S7gYjMXgaXEmmTQcC9a
         kCQg==
X-Gm-Message-State: APjAAAVkTEaBI43ciI0h8MqjoIo2O4j3CC46gTHItSJyW5hGC1MEUs+n
        DvIOe4Wjz4fTjf4Nrfb/o316twkBnmcwlVWSK+rv3es7gjPbNBIxll8gA1QuYcGeWx7klPD9G4m
        NjythhEGHmY8U8FPTXUp/qdx21sKB
X-Received: by 2002:a92:8941:: with SMTP id n62mr7842855ild.20.1571373716852;
        Thu, 17 Oct 2019 21:41:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyoJ/tH4b5jxVJp8nBGw2QY5zm9BMxuCAeD6/be5zL/8OGhFhhi/R6r6p196AViBR8ZnBWC9Q==
X-Received: by 2002:a92:8941:: with SMTP id n62mr7842836ild.20.1571373716551;
        Thu, 17 Oct 2019 21:41:56 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id w68sm2042093ili.59.2019.10.17.21.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 21:41:55 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/gma500: fix memory disclosures due to uninitialized bytes
Date:   Thu, 17 Oct 2019 23:41:50 -0500
Message-Id: <20191018044150.1899-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"clock" may be copied to "best_clock". Initializing best_clock
is not sufficient. The fix initializes clock as well to avoid
memory disclosures and informaiton leaks.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/gpu/drm/gma500/oaktrail_crtc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/gma500/oaktrail_crtc.c b/drivers/gpu/drm/gma500/oaktrail_crtc.c
index 167c10767dd4..900e5499249d 100644
--- a/drivers/gpu/drm/gma500/oaktrail_crtc.c
+++ b/drivers/gpu/drm/gma500/oaktrail_crtc.c
@@ -129,6 +129,7 @@ static bool mrst_sdvo_find_best_pll(const struct gma_limit_t *limit,
 	s32 freq_error, min_error = 100000;
 
 	memset(best_clock, 0, sizeof(*best_clock));
+	memset(&clock, 0, sizeof(clock));
 
 	for (clock.m = limit->m.min; clock.m <= limit->m.max; clock.m++) {
 		for (clock.n = limit->n.min; clock.n <= limit->n.max;
@@ -185,6 +186,7 @@ static bool mrst_lvds_find_best_pll(const struct gma_limit_t *limit,
 	int err = target;
 
 	memset(best_clock, 0, sizeof(*best_clock));
+	memset(&clock, 0, sizeof(clock));
 
 	for (clock.m = limit->m.min; clock.m <= limit->m.max; clock.m++) {
 		for (clock.p1 = limit->p1.min; clock.p1 <= limit->p1.max;
-- 
2.17.1

