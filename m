Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE38C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 04:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3404120811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 04:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itIEC1hP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbfCHEkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 23:40:18 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33109 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfCHEkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 23:40:17 -0500
Received: by mail-yw1-f66.google.com with SMTP id i204so15361492ywb.0;
        Thu, 07 Mar 2019 20:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HI4tdjYhgKCF3hI9dB2bVFt8dEDjF5MRs9aEylbNYC4=;
        b=itIEC1hPhgQ3VK9o7gBBojLj1VKKUw2DBtWbw9hAMPUAGBCgz9hp8ySdpJN2ZlNrk6
         7eGc/mdGg/Z31MG/5S7lfCt8DK2G5gbbYJj2zyPz4Nh/ChN3yCiWP3anrG8A2A/ji0Xd
         gs4QqZNFfYWYTTK25VfY2b5El6OaCbc7JvujqU3fB/k3PmCxMxmHgYjrIkwNV84iLzit
         R9SpD53eIEyIykJ85qYAydiR72BAAYxqKW61rfavxkzdjrSllk+aE+n7NBMx5bMLC+6u
         by/IV0BDHnUJuUM45GgvileZMa2UwiWBCNFZcREK4uuww5+7e8emJ3PNi4NEy1ju4mEr
         BExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HI4tdjYhgKCF3hI9dB2bVFt8dEDjF5MRs9aEylbNYC4=;
        b=SXMR5ON7UYNQhZxn4JeZ0Ngv8sv/RQqlk5MI2oZp/C3W3wQfapYW20pYIPCjDkjaZ9
         oacz6BOxS6VeiGdBr0oHrqJB3TOsDtGHOTHjtWppAAqyAIYv9dWi+nQ5Vn0CuIoqFGhh
         Ek46iZUJ9dDnJMZrTzoUN8X4RwfsJQfK4BlLjbVcSobkwsKOdsur/mPaak61sia1k6c8
         MBMF48zvYXnDat//jbGJBbP6bds9g4hB4VWWNxo9YEZeUvex9U0PCdXZxcAEqIL/WXqP
         J6Qm9Ik1fu6AEYA6eyiSWgyqtkATXvzKhZ7iov6YYgYa7O2WsNCTfMDLnE6MqLsoIEc+
         cCsQ==
X-Gm-Message-State: APjAAAVT6kMM5MU4G1B8miioTWX/zqyR1rfWGFwptMh45VU4prcbKWZO
        m6za56N3U++Csu2EtQ9jf6g=
X-Google-Smtp-Source: APXvYqxaPIuBKDF7hSNPCFoFqqtVGJkVEn/D01LmrtfoLHS5pZL6dH9mFdkzo8z1e1gRKruqxmwtjQ==
X-Received: by 2002:a25:b2a4:: with SMTP id k36mr14437608ybj.446.1552020016306;
        Thu, 07 Mar 2019 20:40:16 -0800 (PST)
Received: from localhost.localdomain ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id z77sm2596233ywz.91.2019.03.07.20.40.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 20:40:15 -0800 (PST)
From:   Bo YU <tsu.yubo@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        ongliubraving@fb.com, yhs@fb.com, davem@davemloft.net
Cc:     Bo YU <tsu.yubo@gmail.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org, yuzibode@126.com
Subject: [PATCH] bpf: fix warning about using plain integer as NULL
Date:   Thu,  7 Mar 2019 23:39:56 -0500
Message-Id: <20190308043956.16906-1-tsu.yubo@gmail.com>
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

Signed-off-by: Bo YU <tsu.yubo@gmail.com>
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

