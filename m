Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24A6C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C125C21841
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rqq9g03P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387637AbfGXQ6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 12:58:42 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:55181 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbfGXQ6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:58:37 -0400
Received: by mail-qk1-f201.google.com with SMTP id b139so39812301qkc.21
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 09:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=glKaPZF0kuawPUQxXbpKIp+157oyf0yYPp3UELzJQsg=;
        b=rqq9g03PpRhF3ymvIyKsJZzyqpeGHYdT7zGj3bnG5I1MzwqawSR6jYQY47lcFaPh8u
         AC4HC3jBJ8Q6HPjbVfvzmz4thwjP+kPTjr2j5uQJzkIhru+IeBl/CNrBF8HUEJPBemGj
         YCZ8sgHUbNal4hCkX93eIDVTkVotYLPT72iFfHt7htZalJIeNAPgZOBv4v1Aggm/iBAF
         E4vT2Eug6Gz2suAsgF+EumINRAuFJHHIgZphdq8fz7jesmzD+kw6OvLpLQVJ3v4oNRKf
         6h7BMZEYGDGnq0Cb8crL9rOnzJd0xO2wfJjOb3bwSjthqNd8+O6dl4tNFBv5bU8iEhTG
         811w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=glKaPZF0kuawPUQxXbpKIp+157oyf0yYPp3UELzJQsg=;
        b=Zla3+6VSZKJhVU45hoZ+hStPlKRc7N3ga0GpgZtAB2jLH2mmARbbikrBWN/aFq9d9+
         9DmvAKbB3EF0daAvn9grk25V7DO4WqSpQl/tR9ZUFbj7u4r62HJFeCpeD6HwBqxAdqgv
         01k0dgwoM85HTTpmBodPwccqHTgUgecl/BLBSjQpo33RUTvoF55tNtXNQGvElyCM5/Tj
         so1E6TyD8nt5S9z0MXEQAWthK7hI0yPTPZaBHwj+0KE87VtAwY3sPAKNSBj5KIKv7ai1
         ufZO5ZSdao4+R8VmO+gfX+5taI8ZV1I+5WBCc/lDeBrvsIYz8579LV9GPgfoN7QjIyQ2
         eCVQ==
X-Gm-Message-State: APjAAAXc9xu0Z2ubMLczTPxvgT8kskIZJJZHH2pGBLWip28bp2uhuLcd
        Y/sdS1L4PrbVgXcrayYhcTiMoI8YdwFb
X-Google-Smtp-Source: APXvYqwGhYKsmoggPNt4NsKlJiqWSzOCNjflzOiZPEzbK6MDkFFQIP6wyFXKUEoZQwNfArLV+zvI15TnxLV0
X-Received: by 2002:a0c:8a76:: with SMTP id 51mr60440819qvu.210.1563987516337;
 Wed, 24 Jul 2019 09:58:36 -0700 (PDT)
Date:   Wed, 24 Jul 2019 09:58:01 -0700
In-Reply-To: <20190724165803.87470-1-brianvv@google.com>
Message-Id: <20190724165803.87470-5-brianvv@google.com>
Mime-Version: 1.0
References: <20190724165803.87470-1-brianvv@google.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH bpf-next 4/6] libbpf: support BPF_MAP_DUMP command
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
 tools/lib/bpf/bpf.c | 28 ++++++++++++++++++++++++++++
 tools/lib/bpf/bpf.h |  4 ++++
 2 files changed, 32 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index c7d7993c44bb0..c1139b7db756a 100644
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
index ff42ca043dc8f..86496443440e9 100644
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
-- 
2.22.0.657.g960e92d24f-goog

