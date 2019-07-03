Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4722C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0FB82187F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ok+LeUJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfGCQ0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:26:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40925 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfGCQ0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:26:50 -0400
Received: by mail-pf1-f194.google.com with SMTP id p184so1525194pfp.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 09:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DwXdZfH7NtLLJZOhwaToNs2kvQsm5dpc9ZEnlVZ81ao=;
        b=Ok+LeUJj2lPf1HsKeEyTtdlTldW4e0txkESxkbuSYB163yEsIDqSTAjhXayR0fD+EV
         GSWfdpWdLoK82PwY4L0mzZNY0PpCDMA6eCUBmfBIRniDac+LWG9SfOVk9rhotc+aR6Oq
         yRUdGgy1VGRdyCublNV2ShM4jgfv+xI9tCNGkeOfjCmphfwltFq9oPGH11mzRRPWwCrI
         p2A9YXmD7TrU74ECiF1mzVYEz7RyBs19P29Kd2pETHGHtz34vZld+rQ04Ma9zCzJ0Y9t
         gzqKDUMbSLW/CNGgSEs5Ph40dW67pmcEWHIr1OUo14D2JXc5FRwsSz66uiGxqtMu7cky
         BMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DwXdZfH7NtLLJZOhwaToNs2kvQsm5dpc9ZEnlVZ81ao=;
        b=Uc+2OGw53d8TSQbg+yK9O4fROkvJT445jOH4+D/R/3Pr1xC67WQa5j7EDQgBvNJRun
         QJgq03FTil08cMNqRiulxtYP/ljNlJq3DzeCdgyWYHfMH0fdVrW+W9r/RY4Z7m3GgXfF
         MwVWZRv1FLdDEFkqODjTuPZybOluojzHP5somDQlj9ufcFNMSqGNOoTxOo8a5LAabw6W
         xfP59DOX9ly3C29H3/BkYQmQoulZQFZblU3K4sA4spGQ+1KpVWKoNXTTxK+9Pr4B9ZpC
         fXKl0w54Y/GKJtTcWm7HRsXPkRJ5fv2ScDv70FJR6rRsW9Di5SgtEKvNjUtOyUO6JGS3
         xlaA==
X-Gm-Message-State: APjAAAXqhwM8C3ACvtFtg5sknqYy+XZhplO+rXnfZhO6hEKgZ4Eto9dL
        oc1qpwBo/bZRFmHG3vzEEHo=
X-Google-Smtp-Source: APXvYqwODgYtzkQrbBeDgDwBdaBOya0MZqxSr7qbHRHEnITOO4v8vuOS3u+VX9rs+L9DNlIsMYiSqQ==
X-Received: by 2002:a63:e251:: with SMTP id y17mr6999992pgj.8.1562171209687;
        Wed, 03 Jul 2019 09:26:49 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id 191sm3148943pfu.177.2019.07.03.09.26.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 09:26:49 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v2 03/35] powerpc: Use kmemdup rather than duplicating its implementation
Date:   Thu,  4 Jul 2019 00:26:43 +0800
Message-Id: <20190703162643.31999-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memcpy, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memcpy.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v2:
  - Fix a typo in commit message (memset -> memcpy)

 arch/powerpc/platforms/pseries/dlpar.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 7488e40f5e47..20fe7b79e09e 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -383,11 +383,10 @@ void queue_hotplug_event(struct pseries_hp_errorlog *hp_errlog)
 	struct pseries_hp_work *work;
 	struct pseries_hp_errorlog *hp_errlog_copy;
 
-	hp_errlog_copy = kmalloc(sizeof(struct pseries_hp_errorlog),
+	hp_errlog_copy = kmemdup(hp_errlog, sizeof(struct pseries_hp_errorlog),
 				 GFP_KERNEL);
 	if (!hp_errlog_copy)
 	      return;
-	memcpy(hp_errlog_copy, hp_errlog, sizeof(struct pseries_hp_errorlog));
 
 	work = kmalloc(sizeof(struct pseries_hp_work), GFP_KERNEL);
 	if (work) {
-- 
2.11.0

