Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B17C004E6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 20:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B08F20665
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 20:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lCTvipls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfF0UZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 16:25:09 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:55669 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfF0UYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 16:24:41 -0400
Received: by mail-pl1-f202.google.com with SMTP id q11so2044430pll.22
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 13:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZJbz/C3e+sb5O/hI+5UE82UL50nEjTNC67t2N91YPtY=;
        b=lCTviplsuxpS22jrClW1mL6aRTLXQXF+1uQJl4GrP6ELiwrIM8+E29QIF7dhjFLGfi
         L6OYMLcLR2eAiHqKQuu83jwzMnjqC5d8Apw/sEF4B89WA6KsBhICw+c7ZFjW194I2AKo
         vxPW6ly4lbZGqGoPxV6yi0G/Vr/JY/b2bQILBmVoE2LEgToG3BoC8Bms2fPRezw3FAs6
         rs55e9Cxo/7e9nAqAkEepnKDI9q6NhBx6QmhfqaQ900R2wEifq7T8W4DPfu6MGZT+Khf
         btHFXN3aHvhR6hYd745qdaYxuXS86cfNwyWHwJRzvRmhaRolW+lpmW328cecxh0/DACC
         ucIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZJbz/C3e+sb5O/hI+5UE82UL50nEjTNC67t2N91YPtY=;
        b=YC7M11fXq+xGELN2sjutJZ0lgYGk7rFu7/2gzx1QnSNnSKL6Ny9CONW4tF8Lkbuvq0
         buxZDziUo0L9/K57WxM0eMt+yiu/1SxZdgOhcB0pqRWzvUHtaIuYtnicSyJh2slgj5j1
         CIumR5IT55lEn1Q0L4wsFzyl1mJQzGubvUI+IaJYIgnjF9yhTA/ZXV5tt0axWbuEezuD
         CcBLdaGjMFbVRKdde3oaGCN88YFRJT/aLX3pjH9Am4/SCoF/8BsK44EoH7KdYywpsK2B
         UbQMlfTX4nuMgVApjQF2zx/HPYCvZh3aUcRnpvmGZXiLsJOMY2MvVhMmZTn8YiPp69uu
         BBSA==
X-Gm-Message-State: APjAAAU62j8xQMeSbssSgDA2zO3+F/2sHj+fKwsI/g9/zDzy2NXXXmsv
        L2d4wzJsdQkSee1rC26/hydOYlcbD+7D
X-Google-Smtp-Source: APXvYqxPs9/hX31AxgdEdEA6GWdFRzA3e8KBAWPjSOpGxJSpn8o6xpvG+ON50dqck6rcViGHvFWvoMlbXgXp
X-Received: by 2002:a63:5c1c:: with SMTP id q28mr5467792pgb.288.1561667080410;
 Thu, 27 Jun 2019 13:24:40 -0700 (PDT)
Date:   Thu, 27 Jun 2019 13:24:14 -0700
In-Reply-To: <20190627202417.33370-1-brianvv@google.com>
Message-Id: <20190627202417.33370-4-brianvv@google.com>
Mime-Version: 1.0
References: <20190627202417.33370-1-brianvv@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH bpf-next v2 3/6] bpf: keep bpf.h in sync with tools/
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

Adds bpf_attr.dump structure to libbpf.

Suggested-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Brian Vazquez <brianvv@google.com>
---
 tools/include/uapi/linux/bpf.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index b077507efa3f3..1d753958874df 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -106,6 +106,7 @@ enum bpf_cmd {
 	BPF_TASK_FD_QUERY,
 	BPF_MAP_LOOKUP_AND_DELETE_ELEM,
 	BPF_MAP_FREEZE,
+	BPF_MAP_DUMP,
 };
 
 enum bpf_map_type {
@@ -385,6 +386,14 @@ union bpf_attr {
 		__u64		flags;
 	};
 
+	struct { /* struct used by BPF_MAP_DUMP command */
+		__u32		map_fd;
+		__aligned_u64	prev_key;
+		__aligned_u64	buf;
+		__aligned_u64	buf_len; /* input/output: len of buf */
+		__u64		flags;
+	} dump;
+
 	struct { /* anonymous struct used by BPF_PROG_LOAD command */
 		__u32		prog_type;	/* one of enum bpf_prog_type */
 		__u32		insn_cnt;
-- 
2.22.0.410.gd8fdbe21b5-goog

