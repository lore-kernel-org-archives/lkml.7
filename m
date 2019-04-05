Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7402C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7FBF2171F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BugrLjyB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731653AbfDERrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:47:36 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33586 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731611AbfDERrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:47:33 -0400
Received: by mail-pl1-f195.google.com with SMTP id t16so3417150plo.0;
        Fri, 05 Apr 2019 10:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=suU4k9iE7Md/KfJ4CfzvKVa4/9QAyJfSEidhnmW/+G4=;
        b=BugrLjyBKWj237HaLZhmd0b3erplta9gtTzJ4llVQZAr6aObUFEF/fyTNgN9kLKo6H
         FxP53TFCmPPP89OLwHbkjs9GX66HI1k9ZQgJW44s6s69R0H+UwstNKqui9JpWqCiVv3L
         NrvVC6W+BKJ3HVBIWEdKhr38Q2jgDewI82X8hUZ1kkbrTW0sr2JMx0yUhWIb4S5Tkm+1
         s0uvhsNYjj0sqZkre/nN0MsSWDbMpn+jegzh12NEyKo4GS7s4mb9a9BEfgFsLMZc0lQT
         qZZnnEorQOMD+tZ/TL2QKR/f84SFydZ7dh1S38gb4F+8O6JBg2hN7d7bfjwpleWaS7Dv
         x5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=suU4k9iE7Md/KfJ4CfzvKVa4/9QAyJfSEidhnmW/+G4=;
        b=HFiVPB3nivH+cFZAErbipjKhzEUHT3mr5k00BUiSP2EkDNq3GSb20KbNUGLt68fOF9
         uuvaqnd7gCxa2p4gcGGl8d7VOGqEtCvFTgk1wDiF96m4S4KuQDAWeZRudeTcPtddi4FM
         koHuszJ+uplOrEMjcuQGOewkQbjZQbeb1qmO0jGJextE98of/RXhxiMdLdrUgyMnL65c
         J7+uejkk4qcRx1bqBVKaNKVFGIFo8P0plhWkORA5P8jryW/l65VnMH8xvaBIuy6JQ5ad
         UTGyoF1+VZ/23aVCZaMj2Z6MR5x89Iet3H8XQx8eq/PY/amMcCp4ui/DCSyOIseiBp+N
         xenA==
X-Gm-Message-State: APjAAAUb0cvmYv5/wipYjflo6/SR2n05s8R6IqctZJ4f6quF9wWaIoAT
        O8IZ1LcDBF+6UCLuqAgiM5s=
X-Google-Smtp-Source: APXvYqzPYy2gXl8tqsqkvpLeamuFY20lQXYMhJyd48mpcMGtwXLZHsoqshwceWsJY6f9JI7FEJJXFQ==
X-Received: by 2002:a17:902:be0a:: with SMTP id r10mr13861713pls.4.1554486452499;
        Fri, 05 Apr 2019 10:47:32 -0700 (PDT)
Received: from tower.thefacebook.com ([2620:10d:c090:200::1:ad20])
        by smtp.gmail.com with ESMTPSA id m2sm33169135pgr.74.2019.04.05.10.47.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 10:47:31 -0700 (PDT)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     kernel-team@fb.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>
Subject: [PATCH v10 1/9] cgroup: rename freezer.c into legacy_freezer.c
Date:   Fri,  5 Apr 2019 10:47:00 -0700
Message-Id: <20190405174708.1010-2-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190405174708.1010-1-guro@fb.com>
References: <20190405174708.1010-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Freezer.c will contain an implementation of cgroup v2 freezer,
so let's rename the v1 freezer to avoid naming conflicts.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: kernel-team@fb.com
---
 kernel/cgroup/Makefile                        | 2 +-
 kernel/cgroup/{freezer.c => legacy_freezer.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename kernel/cgroup/{freezer.c => legacy_freezer.c} (100%)

diff --git a/kernel/cgroup/Makefile b/kernel/cgroup/Makefile
index bfcdae896122..8d5689ca94b9 100644
--- a/kernel/cgroup/Makefile
+++ b/kernel/cgroup/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y := cgroup.o rstat.o namespace.o cgroup-v1.o
 
-obj-$(CONFIG_CGROUP_FREEZER) += freezer.o
+obj-$(CONFIG_CGROUP_FREEZER) += legacy_freezer.o
 obj-$(CONFIG_CGROUP_PIDS) += pids.o
 obj-$(CONFIG_CGROUP_RDMA) += rdma.o
 obj-$(CONFIG_CPUSETS) += cpuset.o
diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/legacy_freezer.c
similarity index 100%
rename from kernel/cgroup/freezer.c
rename to kernel/cgroup/legacy_freezer.c
-- 
2.20.1

