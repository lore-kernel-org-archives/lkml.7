Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3FAC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5AE6218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SSaXIUdq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfGCRCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 13:02:14 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:38895 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbfGCRCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 13:02:12 -0400
Received: by mail-pg1-f201.google.com with SMTP id w5so1962630pgs.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 10:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SkPVxPTkLQnSJ+04pOruRJ+oHifbro+qasEP8Q6MwF4=;
        b=SSaXIUdqZIgZvFHvhwZvfBWgZIsMPL+K6OnKBFCRQjlPLpmeZzVc9rJIfRlNu+KnoX
         4ZWEd5V9nO/Q714zf0mRBjIva4Sxy8h04AdI3omElqxwP+BTy58PYe7rLDOj7gs2f1vd
         548JoeoIdOKvTeO46tkv7LBny1ufzCOq4q7nrnh7uttNUQVag3QljTBIofOwJfuHXIo6
         0pMHl/SNcBCngGWHqT00tRid+cjvSgiPhUrXnn5Hwa8MAjjdXnAqdMGxJ5DpJIF2Ndn9
         PWtH4zWlYaq8ICS1BUv6axZ3pkwVaSILw8SNHwsEddJzL/LRgfrLr3Plad7f1wUh9Bob
         KjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SkPVxPTkLQnSJ+04pOruRJ+oHifbro+qasEP8Q6MwF4=;
        b=uV/HxCtgYEmQkcT/r1wQ5VQtAAnQmRbmgLzPzM+8lUXAGnygoZufOznQCR9ioR41/y
         /D+FOXhedViXYWVeiJclhNMIkrFEwLn8HwfI1SPAivbIFXy9IZeKg4+KPem/RW3yPW2m
         pFG1BF247SffxPIMrboUAF/suOmRYtTplvRIymQL5Q73gMwfRUA0FLoPJ+5FSIWMpXyP
         WYD4VFiAR8h0lxCbysmo1DLqAjB9UUUbE5TKTxI3xZ3MwH+HGI4qjf5CSi8i9RWraqwc
         Jy3fMGy9AOsLBCeC9ABAfSLVFtYfMQVxNWqGvDAmvFQyR558/5xjBBOc606tJaeN4WFU
         8Gdw==
X-Gm-Message-State: APjAAAVc0yF3KndSJvTGFOqnLgyZrvI1oTbTTqu96iSF5DM9LRB31MXc
        l7YkKPy35+0FodmdRLXpvQBBw0wSnYVG
X-Google-Smtp-Source: APXvYqzwZOQDxqTS/N9MpFJsKgq9Ee3V0ekH5sugwFoCEzm1svFIvb3/pv1IUUqPpPyaGYaH+UAcaXa52Jgy
X-Received: by 2002:a63:a41:: with SMTP id z1mr37996608pgk.290.1562173331396;
 Wed, 03 Jul 2019 10:02:11 -0700 (PDT)
Date:   Wed,  3 Jul 2019 10:01:16 -0700
In-Reply-To: <20190703170118.196552-1-brianvv@google.com>
Message-Id: <20190703170118.196552-5-brianvv@google.com>
Mime-Version: 1.0
References: <20190703170118.196552-1-brianvv@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next RFC v3 4/6] libbpf: support BPF_MAP_DUMP command
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Petar Penkov <ppenkov@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make libbpf aware of new BPF_MAP_DUMP command and add bpf_map_dump and
bpf_map_dump_flags to use them from the library.

Suggested-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Brian Vazquez <brianvv@google.com>
---
 tools/lib/bpf/bpf.c      | 28 ++++++++++++++++++++++++++++
 tools/lib/bpf/bpf.h      |  4 ++++
 tools/lib/bpf/libbpf.map |  2 ++
 3 files changed, 34 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index c7d7993c44bb..c1139b7db756 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -368,6 +368,34 @@ int bpf_map_update_elem(int fd, const void *key, const void *value,
 	return sys_bpf(BPF_MAP_UPDATE_ELEM, &attr, sizeof(attr));
 }
 
+int bpf_map_dump(int fd, const void *prev_key, void *buf, void *buf_len)
+{
+	union bpf_attr attr;
+
+	memset(&attr, 0, sizeof(attr));
+	attr.dump.map_fd = fd;
+	attr.dump.prev_key = ptr_to_u64(prev_key);
+	attr.dump.buf = ptr_to_u64(buf);
+	attr.dump.buf_len = ptr_to_u64(buf_len);
+
+	return sys_bpf(BPF_MAP_DUMP, &attr, sizeof(attr));
+}
+
+int bpf_map_dump_flags(int fd, const void *prev_key, void *buf, void *buf_len,
+		       __u64 flags)
+{
+	union bpf_attr attr;
+
+	memset(&attr, 0, sizeof(attr));
+	attr.dump.map_fd = fd;
+	attr.dump.prev_key = ptr_to_u64(prev_key);
+	attr.dump.buf = ptr_to_u64(buf);
+	attr.dump.buf_len = ptr_to_u64(buf_len);
+	attr.dump.flags = flags;
+
+	return sys_bpf(BPF_MAP_DUMP, &attr, sizeof(attr));
+}
+
 int bpf_map_lookup_elem(int fd, const void *key, void *value)
 {
 	union bpf_attr attr;
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index ff42ca043dc8..86496443440e 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -112,6 +112,10 @@ LIBBPF_API int bpf_verify_program(enum bpf_prog_type type,
 LIBBPF_API int bpf_map_update_elem(int fd, const void *key, const void *value,
 				   __u64 flags);
 
+LIBBPF_API int bpf_map_dump(int fd, const void *prev_key, void *buf,
+				void *buf_len);
+LIBBPF_API int bpf_map_dump_flags(int fd, const void *prev_key, void *buf,
+				void *buf_len, __u64 flags);
 LIBBPF_API int bpf_map_lookup_elem(int fd, const void *key, void *value);
 LIBBPF_API int bpf_map_lookup_elem_flags(int fd, const void *key, void *value,
 					 __u64 flags);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 2c6d835620d2..e7641773cfb0 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -173,4 +173,6 @@ LIBBPF_0.0.4 {
 		btf__parse_elf;
 		bpf_object__load_xattr;
 		libbpf_num_possible_cpus;
+		bpf_map_dump;
+		bpf_map_dump_flags;
 } LIBBPF_0.0.3;
-- 
2.22.0.410.gd8fdbe21b5-goog

