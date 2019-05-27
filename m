Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D80C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 07:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B1F2173B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 07:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5ZYJlcH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfE0HX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 03:23:27 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44589 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfE0HX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 03:23:27 -0400
Received: by mail-pl1-f193.google.com with SMTP id c5so6700889pll.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 00:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=prh0uJ2ftxqZOsyUAZqlgIZvwK7HkfsesW5zVqF193Q=;
        b=G5ZYJlcHmbyc9z6HMPlqXQNOSYOSSZIP8I5jOB1MlGLTbCDk8GSoZ7BSKV9RYcinac
         f2DhjeRU0gt2VC3B1jXc3H16bSj70OtXP8JJ8eAdrjvcsGV3y9S/CU7qVCM5uqoio1nX
         bzqeFLb1RDP3k35EpPPgp05EUuKiCSCN8cQJpGAOXbiGvqclEgtNBd+ke6Y7WCzhC7yq
         i+6I651do9j5P9Reh4v1L2gvdPiWonKs+fPGN33Llmelrm0xuicCVLa/T3xgengMr9U4
         NOTTB4H1ReZP/SLrswwG6/GSUpMEdWp+uWrsOJDbo564w90XrId5YuDPTtlIMAToJfxN
         bF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=prh0uJ2ftxqZOsyUAZqlgIZvwK7HkfsesW5zVqF193Q=;
        b=pzdRkZVqQBi3Wd425gMcNoq6sq5i6bapnsJJSdVWQa0xoysAnQtDx/bCXvOKjvs02Z
         jHH4wh3Wm1DeXsR1sT66JSCHojndNqVZ/cWyWCTCHOVefjJLRqgzBkjaDYQqtbDTqcll
         9YA0iL+fTqYBEUz0yxbEeIl1IetpeDiLsXpmmhT2ptnnZ2sqdvdKhfqzydE3NC+2f3jU
         DG3GKt2abc6QdeajyCNK9xdYq0JXIwtVGyHr7bjTYsaczpacGl6u55GvVJHnEMQeG5jC
         azHK7oQSCbNuaoKwUmM/rD83oHahpiXgAnhmY/+yKQhy/XlZhe3k/CzwwN/Y70Rvre4K
         x3zQ==
X-Gm-Message-State: APjAAAVtVtFhA1AXCvKS+hRfstrQ3YMLSRatdsKVX3D1B4JmBEhzkxD5
        Hwvq0J/WecTa2CxJtExySA4=
X-Google-Smtp-Source: APXvYqzGrZC9Z7tvPQ4SeApZPDy6fXQevcayk63ebbL+RZmSAOOqrJ7XOIaJihC6ZNN7BLY7/WLuRg==
X-Received: by 2002:a17:902:2883:: with SMTP id f3mr18555036plb.111.1558941806917;
        Mon, 27 May 2019 00:23:26 -0700 (PDT)
Received: from tom-pc.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id v16sm12010373pfc.26.2019.05.27.00.23.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 00:23:26 -0700 (PDT)
From:   Dianzhang Chen <dianzhangchen0@gmail.com>
To:     akpm@linux-foundation.org
Cc:     gorcunov@gmail.com, kristina.martsenko@arm.com,
        ebiederm@xmission.com, j.neuschaefer@gmx.net, jannh@google.com,
        mortonm@chromium.org, yang.shi@linux.alibaba.com,
        linux-kernel@vger.kernel.org,
        Dianzhang Chen <dianzhangchen0@gmail.com>
Subject: [PATCH] kernel/sys.c: fix possible spectre-v1 in do_prlimit()
Date:   Mon, 27 May 2019 15:23:08 +0800
Message-Id: <1558941788-969-1-git-send-email-dianzhangchen0@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `resource` in do_prlimit() is controlled by userspace via syscall: setrlimit(defined in kernel/sys.c), hence leading to a potential exploitation of the Spectre variant 1 vulnerability.
The relevant code in do_prlimit() is as below：

if (resource >= RLIM_NLIMITS)
        return -EINVAL;
...
rlim = tsk->signal->rlim + resource;    // use resource as index
...
            *old_rlim = *rlim;

Fix this by sanitizing resource before using it to index tsk->signal->rlim.

Signed-off-by: Dianzhang Chen <dianzhangchen0@gmail.com>
---
 kernel/sys.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sys.c b/kernel/sys.c
index bdbfe8d..7eba1ca 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1532,6 +1532,8 @@ int do_prlimit(struct task_struct *tsk, unsigned int resource,
 
 	if (resource >= RLIM_NLIMITS)
 		return -EINVAL;
+
+	resource = array_index_nospec(resource, RLIM_NLIMITS);
 	if (new_rlim) {
 		if (new_rlim->rlim_cur > new_rlim->rlim_max)
 			return -EINVAL;
-- 
2.7.4

