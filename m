Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA063C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3492084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="CXOdZ1qk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388699AbfCAOiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:38:02 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42276 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387418AbfCAOiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:38:02 -0500
Received: by mail-qt1-f193.google.com with SMTP id u7so18748856qtg.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 06:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=u8p6LEaICK87ZAl5dajNGBnd4suIRJImycTZiVBF6mk=;
        b=CXOdZ1qkJEFpDrXmIdbDFbUBBQDnKKwxBoNzQ/nl3UExKo92Qa5WMRtSjviMKpm2rv
         SFoAwTu2thb0beEIxDaXIYP7hZRt9TAWPTy3RW9m6utlnE/sNtmF3tBU7yr5biidOdS1
         CO0cgbA2BXHGnDZTJRrviplkxPAbjiz4PgAL9bneX/QvIEMs/unePVw0WOAz+mapodzN
         hQLgQxaYUNtpH4TrOzljElp03YViaHMFr/8yYAzXxLPhu5EnN72Fghckv+RmBkv8Fuxi
         59CTQYerYdDzTr/vEKgECB9mHb9kaPaFTTp4+PlThUbZlRvcN0BDSDjruZ7JdkjD04vv
         7yLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u8p6LEaICK87ZAl5dajNGBnd4suIRJImycTZiVBF6mk=;
        b=Szvj4f6wY/4oF8pn0lNO1/3AKwdyA8gsL9eN0i2A5SkpyMLtjWO7mcyNHyvH+BMhCY
         9x5e2J5usyHSNmVr5LRtcNdG5V/ykIXUtKSwWnwaENeN0jLja3bWW7QFwb9Bk270Rnpx
         XdmP+pIE37O0l/aZA3bzJJS7BvW2IEsjPbDCEcqe9SA+4w7YkbMImW8cuBScfcmXJKwM
         aJsjUc0ARtl/apRfpmc27nZsYVptPe26I7K4NDLP1EKpq33Hx+4E5Z6nU4zuvQxZ39o/
         mqw+y90XiYIdN8w/g5jEx+P4yXdGnxCvzRF78ra6+Q7mfLFmKg7JPZpZneN9Dnqj2WEA
         6QGQ==
X-Gm-Message-State: APjAAAWBycGrFthC5UBqeW1LkJkfsBcOQZx9UhPZPFJ/IZppn8e0qEZE
        g4tF99a4duAt1ktgMaj4Cghnkg==
X-Google-Smtp-Source: APXvYqx0h4cstO+ZyRZVh/m5x9n5LEmfz45jN+4/fx3DH9aqCGTQtRrGaf8xOiVauN2qra/2xB3BKA==
X-Received: by 2002:ac8:1a56:: with SMTP id q22mr4123143qtk.59.1551451081078;
        Fri, 01 Mar 2019 06:38:01 -0800 (PST)
Received: from ovpn-120-151.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id z126sm15936977qkz.8.2019.03.01.06.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 06:38:00 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com
Cc:     guro@fb.com, jrdr.linux@gmail.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH v2] memcg: fix a bad line
Date:   Fri,  1 Mar 2019 09:37:34 -0500
Message-Id: <20190301143734.94393-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 230671533d64 ("mm: memory.low hierarchical behavior") missed
an asterisk in one of the comments.

mm/memcontrol.c:5774: warning: bad line:                | 0, otherwise.

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>
Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: improve the commit message.

 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index af7f18b32389..d4b96dc4bd8a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5747,7 +5747,7 @@ struct cgroup_subsys memory_cgrp_subsys = {
  *
  *             | memory.current, if memory.current < memory.low
  * low_usage = |
-	       | 0, otherwise.
+ *	       | 0, otherwise.
  *
  *
  * Such definition of the effective memory.low provides the expected
-- 
2.17.2 (Apple Git-113)

