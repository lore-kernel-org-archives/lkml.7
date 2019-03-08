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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B355C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 06:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091AE2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 06:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oium6+NZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfCHGp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 01:45:59 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:39449 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfCHGp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 01:45:59 -0500
Received: by mail-yw1-f68.google.com with SMTP id z191so15502998ywa.6;
        Thu, 07 Mar 2019 22:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=N/qtDf5fnqM9VoWDcwIOX2JbfjPFNVEEncbZjpulgtI=;
        b=Oium6+NZkouHu57X10Chbvt6YdngPWL0x8Non/LDqmpvO699UxmHknIpfkvVUCr0H7
         fMVEAmWGrTxB9tE23eiLXH0bPoWHEYnJolSI8V6g4hOLKo2JC3nXmnN/TiP46ah6pF8Z
         /kjz7SRy0YopGqK3+5T5Z++gHnIglpPmkssBNlBssZi2+DSvkLcP+MzVyni51wdlnOYg
         MoBf4vO5c/ttkfSRmyvIdewMP0OBnfJwE9T5hp2bsJnen4/1zl39JcLppeT57sTYOAJc
         HrfhM/CPhGU84oq/6Ro6OnQnWlzDt7KRGQ+3J5fWp4wzUaRfGZw+/305/pUi4FhJL9n6
         VuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N/qtDf5fnqM9VoWDcwIOX2JbfjPFNVEEncbZjpulgtI=;
        b=dqAQqG98zge6mG9guPDof1L0PWmkGsZujtOjtSGEB0nDp3mYJhdGQcTMDwNTGPINL9
         tPx58u4NwDMHfkuXUpJ8j4py0cgTI+yyu4FR56YkJ+2dPmPjKsNH8BDs9Z9gWoooq0GG
         Y+gY0qZWod8wJZw+h67T2qSrbxIrdvxLm4PRsxYtJFFo6KIOy0PLogX9E/oCR2MgAYVx
         0VpvG2v/KyQb4htU8GsJ1cVk0Ggl4AYUdlaV7xwoAzVJAsaI5t0N/SJzetjWY4y235U9
         S7HRb0daLFNhFy071gu14JF78wyGCUsrWYIq+iASQnvg3oTLi53uwVXzPv1pDOcOMK3U
         JH5w==
X-Gm-Message-State: APjAAAXYhf6WGMbFOCTWbvn91Y8rZXkzbCknsgeJdaY+d91bBNfEufo7
        Qb57cdp4xrN2mEK5ab8GQ2Q=
X-Google-Smtp-Source: APXvYqyqOikmrYlfDVaQmwSdBbpLljoHYEu4OR6dibvJ7d05mmOJCDS6q9hD/Xg9KmnAOwICPotAVg==
X-Received: by 2002:a5b:42:: with SMTP id e2mr9964922ybp.141.1552027557907;
        Thu, 07 Mar 2019 22:45:57 -0800 (PST)
Received: from localhost.localdomain ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id 186sm2408540ywi.104.2019.03.07.22.45.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 22:45:57 -0800 (PST)
From:   Bo YU <tsu.yubo@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        ongliubraving@fb.com, yhs@fb.com, davem@davemloft.net
Cc:     Bo YU <tsu.yubo@gmail.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org, yuzibode@126.com
Subject: [PATCH V3] bpf: fix warning about using plain integer as NULL
Date:   Fri,  8 Mar 2019 01:45:51 -0500
Message-Id: <20190308064551.17437-1-tsu.yubo@gmail.com>
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

Fixes: 8bad74f9840f ("bpf: extend cgroup bpf core to allow multiple cgroup storage types")
Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Bo YU <tsu.yubo@gmail.com>
---
V3: put fix tag all in a line
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

