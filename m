Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2762C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 17:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B627F218D4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 17:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sMfhZE2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfCPR6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 13:58:22 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:45691 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfCPR6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 13:58:19 -0400
Received: by mail-pf1-f177.google.com with SMTP id v21so8481640pfm.12;
        Sat, 16 Mar 2019 10:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=suU4k9iE7Md/KfJ4CfzvKVa4/9QAyJfSEidhnmW/+G4=;
        b=sMfhZE2HYwy+yueBhnuoSr/wiAVF4MM6u+dHdrfM4Abcf4gFsKX60mRZvbXKNMa2pq
         72+yRoRLP54Vf7RBKlSqwhSKbnjL47CsAJ8peKlfBdRuitPGOZ7hRTDoIRDCdaqNPmQo
         2XIVnBUdrLXRfmlCUR5V/4h6BWEmtcewrv04AZPWyiq2XZ0c1VwMZ/vbJhEtdQiNPa1y
         Zz3MmsAeLzMi7j1ema9eFL1FlZUfNSiDNj9VMQV8yQicH9LDo+GqdKZfYOOP55ffeERs
         0IC+bmzr5SDmouZx3jFTwdV+Co5Bmk6NJz0O0UW9U83fYN1abpVNovPBP5QFRVoUs+Ij
         qo+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=suU4k9iE7Md/KfJ4CfzvKVa4/9QAyJfSEidhnmW/+G4=;
        b=TdUDrt50vvoMMFTCWCgzKNHObNRyUwHFSVq3/xGzKSicwb0U4HHPIZnJjEGMR5DZqw
         ePsrYkenicOd3yW3HZY+AD90RvrnxmLsbP+soQf6EdMlGdfO/CeGzNdqD2RGixkjqIA6
         btRceFx8sqLc5xQYszcpn6lMPCE2K+ht1cnKFC+KIFSi2rErK+UelzJh+DmGHxqu3kti
         LAl2vkwPBrW2jwkRwkU1R4nsgkYsWZo6CSlKMBdnrt6ZNGDkXfopM3Q4SXlb44hNyMj5
         jP8r1m7uWk8ksKd+1R1T1miydRlkaghRYpJCmCeZ/nOmZs8Kpg1rAaovlfzRfwIdlMdp
         mD4g==
X-Gm-Message-State: APjAAAWklFurzgXH+UWBxhqFp4/3izzrK2iRjbLLIY8jLrWtbCAf0asF
        tvBbFdBmX8Li16K4/7yNSSdGcWrjCfI=
X-Google-Smtp-Source: APXvYqzm+4M+Jdd7oWOf6kAeBM/xSSPwC8DH2/jV68MIidmhLih/I1hDttsAN5P2voNuR4elLdu4kg==
X-Received: by 2002:a63:5d14:: with SMTP id r20mr6456520pgb.351.1552759099152;
        Sat, 16 Mar 2019 10:58:19 -0700 (PDT)
Received: from castle.hsd1.ca.comcast.net ([2603:3024:1704:3e00::d657])
        by smtp.gmail.com with ESMTPSA id p86sm11025638pfa.104.2019.03.16.10.58.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Mar 2019 10:58:17 -0700 (PDT)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     Roman Gushchin <guro@fb.com>, kernel-team@fb.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 1/9] cgroup: rename freezer.c into legacy_freezer.c
Date:   Sat, 16 Mar 2019 10:58:04 -0700
Message-Id: <20190316175812.6787-2-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190316175812.6787-1-guro@fb.com>
References: <20190316175812.6787-1-guro@fb.com>
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

