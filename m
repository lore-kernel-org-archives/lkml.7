Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A654C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 01:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E18C922312
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 01:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K8RhSk35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfKSBoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 20:44:55 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:34323 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfKSBo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 20:44:29 -0500
Received: by mail-pg1-f201.google.com with SMTP id w9so14559700pgl.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 17:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tEe8RAW7MBg1zO9sfZasncxQxqg/PBFYBgYuXX6ANOY=;
        b=K8RhSk35hlwM4iwGeJGgh9tHYrYu24g+thHVrOM7cbaoj90XYuZ58wrRrHjYhJjnoK
         8FgzQrrWE5qvlelyBxxgg64bf3n1OwVDso0Cuf0r5aMXsiZcTqsurHAIrv3On2w3Sw8n
         SEX9mRdn2sfbOihaGzZntl3akYu7MmAhZe/eIVFoIJ2Ro6I+bju0nXSOmPJPq9ipGlJU
         LGPttvtIsETOnjAOUREOqjDzBamwNX2TdRYvUknKBzUaWjbe8PdoBhipodsJS8z520D5
         RtIEHNuqm+7jitIuO35ludXmuhie2vcVlnBTWtIcoxDj7C8cGTNZBdE298UedqMuePo5
         nWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tEe8RAW7MBg1zO9sfZasncxQxqg/PBFYBgYuXX6ANOY=;
        b=guM0stVUB55BVMmZi3N7cU5VQ3aHdiAGwsWpaM5CIuOpRQsj7q0Z96StiozHGgYGRh
         3n1VAG8zRjEuXiOVmfWtbDYeo2OpZCzP4UpmQPnpwATst347WOw/ZHp9p3rCvOirF9FI
         I1aiZBYguqbMKSeOAyDl9D+d30A+ZJWEdRbXj0YkAERERKRFo0a7wvC31nyQQ8V67DWn
         cjXYf2YTSuFIB3U4ZpJC0Pq68msbh2IP8mGBUQ/1vthDsfSeic9mxz+MHMVvQeinkNGs
         CG7UrzjYFisQY1gXYhNFZcsBkOdkvfZ5CNZK+cGipTOyHfV81lW6k1kLUxVHuG+x0amr
         Mk/w==
X-Gm-Message-State: APjAAAVVJaK4xBbaKm9bBOOUPxNmqallacbxsFLldEFdaLGATHSk7wxz
        3Dv70MuCAmwYAlx49BTT/HJXALWwbjni
X-Google-Smtp-Source: APXvYqw2w38HwDUij0Bk0tee7e4l618S+GHU2hzPUeItPDJElvv18erLem5jmOfiiBLpwHPzt+lSPjLQpo/X
X-Received: by 2002:a65:4381:: with SMTP id m1mr2637901pgp.43.1574127869013;
 Mon, 18 Nov 2019 17:44:29 -0800 (PST)
Date:   Mon, 18 Nov 2019 17:43:54 -0800
In-Reply-To: <20191119014357.98465-1-brianvv@google.com>
Message-Id: <20191119014357.98465-7-brianvv@google.com>
Mime-Version: 1.0
References: <20191119014357.98465-1-brianvv@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH bpf-next 6/9] tools/bpf: sync uapi header bpf.h
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Yonghong Song <yhs@fb.com>, Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sync uapi header include/uapi/linux/bpf.h to
tools/include/uapi/linux/bpf.h

Signed-off-by: Brian Vazquez <brianvv@google.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/include/uapi/linux/bpf.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 4842a134b202a..0f6ff0c4d79dd 100644
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
@@ -400,6 +404,23 @@ union bpf_attr {
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
2.24.0.432.g9d3f5f5b63-goog

