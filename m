Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B9AC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14B22077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zug62ED/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfLKWeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 17:34:46 -0500
Received: from mail-yw1-f74.google.com ([209.85.161.74]:43972 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfLKWel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 17:34:41 -0500
Received: by mail-yw1-f74.google.com with SMTP id e124so391186ywc.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 14:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9RMTraS0Zyi1z70WafFMEjChZMSkEcb6BYR/zMAVpRk=;
        b=Zug62ED/rZ6MU18zqHoC2AZP8SDrH5cGX100lu0Z2eD5T/Li+NQTurecemxrmPyix4
         fO5JP1aafPiRtXqcCAd1fXvnqC2t+l+vhGQAcx/Pj0XoLQa5N4jl9jfW9xL2brOngDdT
         FustuWSs2UGUDABRbXjhK+vGP1pQ+HDWlvMNVCeUt+J+bj1EPpa64+TnfhtyGklWYt0W
         OyxghJBnHhef7hXeraIAA2cSSVkM5w2gczpr9PRlYu64Fq/3BAYuqxzPABqXyj+7I8wS
         yvDT22/puKvl1/Bc0P2CC32tcrSTLM+Z2h1nTB83/Ks03PqDbW+2t0yGXuguCvU9b6o/
         U9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9RMTraS0Zyi1z70WafFMEjChZMSkEcb6BYR/zMAVpRk=;
        b=bDITko0plL108dfofyIONWQw8wisn3dBUBOX0fxNwPgdXYtkjXf4ukYmDMB92Fottg
         JbK405JRgztw6oJSes0MZZsHEKD/jUSKJUfldDHa5ywMCxnWDOHkPHQ5lakxn036ssGq
         dGFzzI8+fhU4AWsiD802j6gDjxMV7+YBtyI3pedjPAQyh1ACCBkt63vB/7EQGVqU2sm7
         MCGsmLCUBG136jbQMhkjd/Nk19gFgWmPyL2WZ+x75Bk7cBe3+NfNIFrI5aAa7qtHKRYd
         WHe2yrCQ0lbH3PKYlKw13c16M5XQyJeoFUV26QI+HwfZJVgyjueu1lVAC+BFaHiADvCo
         WaNg==
X-Gm-Message-State: APjAAAVNvL9s+NIwccFWq3iga7XGea9FZIjWlfsDZoPMA6GxxynJaDcP
        3DNn3V/5/z5e4C8MjXhHIq4gMd9nVCCb
X-Google-Smtp-Source: APXvYqyTOAXBOqE4/mNwSkivQk9IjaFFqeApQ7AiGm35jI+iqW+PysIEWzIlF9ZMWMeVT4CFQMwp5yN28II4
X-Received: by 2002:a81:6344:: with SMTP id x65mr1665232ywb.271.1576103680204;
 Wed, 11 Dec 2019 14:34:40 -0800 (PST)
Date:   Wed, 11 Dec 2019 14:33:40 -0800
In-Reply-To: <20191211223344.165549-1-brianvv@google.com>
Message-Id: <20191211223344.165549-8-brianvv@google.com>
Mime-Version: 1.0
References: <20191211223344.165549-1-brianvv@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v3 bpf-next 07/11] tools/bpf: sync uapi header bpf.h
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Brian Vazquez <brianvv@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Yonghong Song <yhs@fb.com>, Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonghong Song <yhs@fb.com>

sync uapi header include/uapi/linux/bpf.h to
tools/include/uapi/linux/bpf.h

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/include/uapi/linux/bpf.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index dbbcf0b02970b..dab24a763e4bb 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -107,6 +107,10 @@ enum bpf_cmd {
 	BPF_MAP_LOOKUP_AND_DELETE_ELEM,
 	BPF_MAP_FREEZE,
 	BPF_BTF_GET_NEXT_ID,
+	BPF_MAP_LOOKUP_BATCH,
+	BPF_MAP_LOOKUP_AND_DELETE_BATCH,
+	BPF_MAP_UPDATE_BATCH,
+	BPF_MAP_DELETE_BATCH,
 };
 
 enum bpf_map_type {
@@ -403,6 +407,23 @@ union bpf_attr {
 		__u64		flags;
 	};
 
+	struct { /* struct used by BPF_MAP_*_BATCH commands */
+		__aligned_u64	in_batch;	/* start batch,
+						 * NULL to start from beginning
+						 */
+		__aligned_u64	out_batch;	/* output: next start batch */
+		__aligned_u64	keys;
+		__aligned_u64	values;
+		__u32		count;		/* input/output:
+						 * input: # of key/value
+						 * elements
+						 * output: # of filled elements
+						 */
+		__u32		map_fd;
+		__u64		elem_flags;
+		__u64		flags;
+	} batch;
+
 	struct { /* anonymous struct used by BPF_PROG_LOAD command */
 		__u32		prog_type;	/* one of enum bpf_prog_type */
 		__u32		insn_cnt;
-- 
2.24.1.735.g03f4e72817-goog

