Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D8CC004E6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 20:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1CE120665
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 20:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZnXGrg/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfF0UYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 16:24:48 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:49602 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfF0UYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 16:24:43 -0400
Received: by mail-pf1-f202.google.com with SMTP id x9so2264803pfm.16
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 13:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Qx6zTmWl7cnoAmaxAa2U3PPxEaWd7SQs0w5RBVcvKMg=;
        b=ZnXGrg/aKIIKDp6JCvIE36LhXe8OA/r2R56GEOXCcPwriAo1jlO0FIzmIrwoTxDw76
         ra+QLeGO+fg1Wv5c7XdTWn9tnRCQtDvJ42Rz8GNNADc7349KibWK6OiEdRjS1xBtVNfs
         LCghjBV+8KURbqaWR0yjtXBT1MUJSZW1xLBAvvJcZeyt367gIvDQ2RCd/yNF7FhO3TTP
         3utIh4ij4wqpttrTr5zHm4VNkKigjhsqPTyWCHsl/xKIa2sHteRRmGJC23g9rCVdHw20
         APJXPEOAlAtyQMeCqidLrog+2jpeD+p9+U2QhaTmnvchzxrDKYMgFtqQMNogs1HzfYU0
         EM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Qx6zTmWl7cnoAmaxAa2U3PPxEaWd7SQs0w5RBVcvKMg=;
        b=tiFa+Qmi+A03hw1cLRmo2ZEJPCve8Z4MOJktmh/ZJC1ojIwbaJ+quHYPYTTj5agTKi
         4FvpkHNqVMld1mdv+7cvZ3B6mNuLLgCfLbXeSBNk5CMUTDPkHC3brySrUOPsTU6t346f
         ADGHVvyr5zvPp6cefsZGiETmOHkNQZdT71MX/VjJ6/auxrYkh8al3xaZkGwK3AuS9XUs
         FXpCs87JwPaYrWVXKTkWqW3p0VcqsQ4lPFO/Jd3NZd+iCIUTabPaRkTBp6efNoC/6iO8
         nZbjQm5T8RFPqo03iZ71UuEp/NYfuR70Vqs+v6Y9P6OD9Z6y7IN4L/lMc/xK8bXCp9Jv
         +Kpw==
X-Gm-Message-State: APjAAAVnftNEmzTWaQj8LeEDOxjjWWh7woiG9uyWqBh2XiGDO84XH7Oh
        h0wKnZcHCpxXlRlMOrgmd/4NGEBADs51
X-Google-Smtp-Source: APXvYqwO73/Wf8OjbR7AguARbIPpJbr9Skn1f30wxVASaYDnFEc20/KJItyzMesHlRyzSkcB+UUSWMjN07l/
X-Received: by 2002:a63:d354:: with SMTP id u20mr5374534pgi.129.1561667082596;
 Thu, 27 Jun 2019 13:24:42 -0700 (PDT)
Date:   Thu, 27 Jun 2019 13:24:15 -0700
In-Reply-To: <20190627202417.33370-1-brianvv@google.com>
Message-Id: <20190627202417.33370-5-brianvv@google.com>
Mime-Version: 1.0
References: <20190627202417.33370-1-brianvv@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH bpf-next v2 4/6] libbpf: support BPF_MAP_DUMP command
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
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 2c6d835620d25..e7641773cfb0f 100644
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

