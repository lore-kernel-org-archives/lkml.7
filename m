Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE4DC5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 22:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F11521871
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 22:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H8zqVcsg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfGCWZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 18:25:37 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:54468 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbfGCWZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 18:25:36 -0400
Received: by mail-qt1-f201.google.com with SMTP id r57so4934253qtj.21
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 15:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=AKpJpkTl2cZB+v5fYJnelCT7s3SLBs0CdEPPFShxrX4=;
        b=H8zqVcsgWf28F4AlRCR5eyy79j0rgfGdsIOUxA+Om/J9Hwm/6YCqwfiXPsXrMGviFH
         xjfMjuGeWMgHOTh8K3F8/RFbAox+VOnCQJOAbZ4QHYmDUirvcHrD1zKzHfL78QQdw+JP
         xhpyYR4g/b57gfSrigjRtdx+i1uMjR1tOMMpSf8GBffqyRjWm3su11MvN7kKCg4BJAl/
         NA8F/soBdyCu99vKl7AXdMc7m/SV3xhRAylW6BMUZ2Qbe1g+rFPtPpGJw9L9Wof9+779
         4LsJFyd7hrzA5PC6jZYPsTUJv8A2RM956J7gePdmG4iKH7fB3faW0dwWbM1wtygUm+Xi
         0mYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=AKpJpkTl2cZB+v5fYJnelCT7s3SLBs0CdEPPFShxrX4=;
        b=qczQyoc2sXDIciznxv2eVQbwVy3c6JH0lryGLecUKD5OEcLgqI25DQ5oeUySj0BI3L
         Iw79Yu6v1rQKlfBbusMOZA5j1xylAKH5xVVJwGaxht/b/nyJezWzkow6lLZkibLEPGl2
         sLL3IgirykmdakJGamEWoXTKYdyJwSg34zzjxGOm8+gKLssDXLCqWa5zneGjtF20HHBs
         P3Xq8S0AlP0qttuTf2d+NkLwz6/GsY/mREP92i2EU8EmN1LfXwkdRYtZcDnDszn3xK9f
         ctXVFYIxBkaiVWPMQiHB3cwaAmjLsqkhZ4OPa3o+687E/rEtDIvX9LtCJcXL06UGfOC2
         ihLA==
X-Gm-Message-State: APjAAAUOlHnR9XbLOJxdPqnEw/HRHRFZKMdaSwhEeX51hHzzqlUyH5/N
        ve2qz31qOttiJl4C29BBAouo8SAre5obTrq9
X-Google-Smtp-Source: APXvYqyYwPE9/36fI207Bh8G4ARADUxHEHP9V0JBoEb2R9jHuUddUGrjQfjDff0X9BaQ1Yr8K3xjBr5JYJnPCEXZ
X-Received: by 2002:ac8:2b01:: with SMTP id 1mr33042053qtu.177.1562192735915;
 Wed, 03 Jul 2019 15:25:35 -0700 (PDT)
Date:   Wed,  3 Jul 2019 15:25:08 -0700
Message-Id: <20190703222509.109616-1-lukemujica@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] perf parse-events: Remove unused variable i
From:   Luke Mujica <lukemujica@google.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, irogers@google.com,
        eranian@google.com, Luke Mujica <lukemujica@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove int i because it is declared but not used in parse-events.y or in
the generated parse-events.c.

Signed-off-by: Luke Mujica <lukemujica@google.com>
---
 tools/perf/util/parse-events.y | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 6ad8d4914969..172dbb73941f 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -626,7 +626,6 @@ PE_TERM
 PE_NAME array '=' PE_NAME
 {
 	struct parse_events_term *term;
-	int i;
 
 	ABORT_ON(parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_USER,
 					$1, $4, &@1, &@4));
-- 
2.22.0.410.gd8fdbe21b5-goog

