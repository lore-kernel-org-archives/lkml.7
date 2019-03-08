Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA98C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 06:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0A820854
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 06:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GT5lBK7j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfCHGJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 01:09:47 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39223 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfCHGJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 01:09:46 -0500
Received: by mail-yw1-f65.google.com with SMTP id z191so15452840ywa.6;
        Thu, 07 Mar 2019 22:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EoYCz66ft2NTt/PnS2Fszn3JHSWf44OPbEFuS+P6CWA=;
        b=GT5lBK7jcxiBo1mdUIhPLQ77v+xpOIRYaRVJP23+lECYhMWp4+EUK5XeTW5gL+CWi2
         yViBkvp+NI2+//OTDorQeDrlhoRmze15rF1X7gTNDxUV5cbcSKsUty2sgc3py9NGmF7v
         z3lsA87yrsuRmIXYDwABWwbbZiKLR95TnALBZW+srnX4kFISQWxGVRXWxw43KO7LnN91
         tecvml5XX3RkWYUrKI+2sbmDwWwF6ejdEQCtcaABmoyH9xCtKqzlUnhJX8djyrqKPWdT
         qkU/jRh0ubk3/DGwjP9GMiWl9ECluKzZS4pxxiNaR/9i36Kg21WQjwdNN2/gtV4tmUUR
         owFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EoYCz66ft2NTt/PnS2Fszn3JHSWf44OPbEFuS+P6CWA=;
        b=PRIcY9Nkv2EmHZdF4BbBHBROS1XWg0bSsD19K4DWw3W/MNsuIahltBp7AOjPz+pSu8
         4Ujz+pnHlLeg1bMk7xFbDzazSkQ726tJB9t53Nd/j5GpcSJfxEwwdL/4Fa2/yQHJsbK7
         QSM+qSTkAf1b+2O/mGl5scTWJ0dGL59Xtcb3ME8qudVKQaJW9zjyfXlC8hDmdz1ryUtN
         +nJHvzh9BJYclXg83zGVeJVLb3YCEAEicJKBzAcduk+Ug6TKETB+SNhYI6qwYxWMLI+l
         Y2leBVssYaPCMsqLXvZyiQPrQ43a1oF/AEueaMPVog87citKMek2+2/IMPWT03oNKnKE
         cXQA==
X-Gm-Message-State: APjAAAX4L9Co1G0W/+ORHgawHxVCgSF60L9lBXYTc5U25M0G+QJIH6WJ
        5LhgWEG2Y5Q2ClYDBwHbF/4=
X-Google-Smtp-Source: APXvYqzO38qgvPeJVyZfA8tFK6M9Vil7cgMK4Rvz2vIxSNSxyAQmxzt14FvBrdeYfHntvPMy871IgA==
X-Received: by 2002:a0d:c544:: with SMTP id h65mr13252955ywd.35.1552025385446;
        Thu, 07 Mar 2019 22:09:45 -0800 (PST)
Received: from localhost.localdomain ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id s5sm2436205ywg.108.2019.03.07.22.09.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 22:09:45 -0800 (PST)
From:   Bo YU <tsu.yubo@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        ongliubraving@fb.com, yhs@fb.com, davem@davemloft.net
Cc:     Bo YU <tsu.yubo@gmail.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org, yuzibode@126.com
Subject: [PATCH V2] bpf: fix warning about using plain integer as NULL
Date:   Fri,  8 Mar 2019 01:09:38 -0500
Message-Id: <20190308060938.17305-1-tsu.yubo@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse warning below:

sudo make C=2 CF=-D__CHECK_ENDIAN__ M=net/bpf/
CHECK   net/bpf//test_run.c
net/bpf//test_run.c:19:77: warning: Using plain integer as NULL pointer
./include/linux/bpf-cgroup.h:295:77: warning: Using plain integer as NULL pointer

Fixes: 8bad74f9840f ("bpf: extend cgroup bpf core to allow multiple
cgroup storage types")

Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Bo YU <tsu.yubo@gmail.com>
---
V2: Add fix-up tag from Yonghong
---
 include/linux/bpf-cgroup.h | 2 +-
 net/bpf/test_run.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 695b2a880d9a..a4c644c1c091 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -292,7 +292,7 @@ static inline int bpf_cgroup_storage_assign(struct bpf_prog *prog,
 static inline void bpf_cgroup_storage_release(struct bpf_prog *prog,
 					      struct bpf_map *map) {}
 static inline struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(
-	struct bpf_prog *prog, enum bpf_cgroup_storage_type stype) { return 0; }
+	struct bpf_prog *prog, enum bpf_cgroup_storage_type stype) { return NULL; }
 static inline void bpf_cgroup_storage_free(
 	struct bpf_cgroup_storage *storage) {}
 static inline int bpf_percpu_cgroup_storage_copy(struct bpf_map *map, void *key,
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index da7051d62727..fab142b796ef 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -16,7 +16,7 @@
 static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat,
 			u32 *retval, u32 *time)
 {
-	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] = { 0 };
+	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] = { NULL };
 	enum bpf_cgroup_storage_type stype;
 	u64 time_start, time_spent = 0;
 	int ret = 0;
-- 
2.11.0

