Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F49C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 19:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6ED72245F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 19:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qRnAj9sL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfKSTbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 14:31:23 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:46290 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbfKSTa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 14:30:59 -0500
Received: by mail-pf1-f202.google.com with SMTP id 187so17529442pfu.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 11:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jXrWlSvxSIV7SLutAc92WU1LozEt5/o5gmsENSdeMlw=;
        b=qRnAj9sLFjfyidZkY77ZuLNvqnfOM2c7OsFHowTq1B61urCpWGgj83PZqUwv5U68j9
         nmbEI+CVIVaMsYYe7ObuAZuMsvdEgJcWUcmUpWqODQKgoVp4beMP4FHCd/GVTG5XMZ/f
         Dg8ad+YPlG7acNGLIInEzKl2qcrLhEYv0aIIWJ7hUcnXBaGP2yBNDg9GRZc4eNNhWMmB
         nbvi4sxTJTtMIcGb+pnb7UEcsm5lMb6mPQB1eShne6yUnHElJDYs2tPrnrSnvEtZlRCj
         dt1iusYpASeJ8MG0scyYp1twH2lT10O1Xa13zwoRQ1RBfonUk3C0quB6b2pe1QhIDQwI
         diEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jXrWlSvxSIV7SLutAc92WU1LozEt5/o5gmsENSdeMlw=;
        b=FU8ZzwSaWkbKJXdQ0RBFwgB6UEodYVYe6QnFp+84Z0tShTZRwilNC8pI+PZZcAbsMI
         HbVF8Sp+S1LIivSrFOKzR7Y9xyR3l8pKdCi+TVdAijOr03gKmXh7zbJiYURj6ILoesrH
         lwXmWhX59x+zelOvLF3iB06i9FultiiHuZyrkkMt57zZc6DwsfZc9yUXiBtR4Y6/oHF2
         H/a7P0qWbO9J7AoXsrA/X7hHZLHMgVekKFY0+gtR9FjZlvwIDSBtaw3Qp9sQ2pmPhrD0
         gYKWA0V/iV/R11k5vDfY0/xEFaPgHgKGfYWxpsTScG4dBLMUrAX0OW+PuXz7EU80z7Sk
         ZJyA==
X-Gm-Message-State: APjAAAXL7hVU4+XYzyuoH/0SpFrYkMqUc2n5TIJsjd2S/y9YlNuQodI6
        +w4VaQMMwfcoaPpcrvjrdtAhGr6pv0II
X-Google-Smtp-Source: APXvYqwL5tKN6MLbbinOhEr3EbjZs9T1WyD1ZfcTtUFtgeNZqCEfxlfny6rPELtrE4bo+lnFpV2eVPVoR/k8
X-Received: by 2002:a63:ff66:: with SMTP id s38mr7329802pgk.84.1574191858436;
 Tue, 19 Nov 2019 11:30:58 -0800 (PST)
Date:   Tue, 19 Nov 2019 11:30:33 -0800
In-Reply-To: <20191119193036.92831-1-brianvv@google.com>
Message-Id: <20191119193036.92831-7-brianvv@google.com>
Mime-Version: 1.0
References: <20191119193036.92831-1-brianvv@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v2 bpf-next 6/9] tools/bpf: sync uapi header bpf.h
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
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

