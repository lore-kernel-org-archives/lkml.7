Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023E0C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 23:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C894B2089E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 23:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b4QVZJcm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfFUXRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 19:17:12 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:53632 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfFUXRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 19:17:07 -0400
Received: by mail-qt1-f202.google.com with SMTP id h47so9631136qtc.20
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 16:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZJbz/C3e+sb5O/hI+5UE82UL50nEjTNC67t2N91YPtY=;
        b=b4QVZJcm4rzj68pH617zJHeAgNJm1LfNtYh0VU7Q9sMs7IbDt7O3+gLB9i+TQRnn8R
         isezYD5TuX4HIILEoC+ZDjgwi2NfSx4Bsde50eNKR2G1RNbKE/2O2GTEiK9QW/tGpKGI
         lO7QYYUcdoJuA1++3R/My85hSzs84tepI/ghmjcNszmGUxyMBBmFCXgeUsJtjss/BeRs
         Ku72dI/5CSMZ9R7lofjFbXZSIFwifeRdmfrwxvfEO2g5PQCdX3mZNilglita4A9ADGJV
         DryJY4lfbugkC26ZIDq1rerUemGvBbfqr8T6BtgAl7J2Rcd8XuoHcDnD+HJNZI9C1/EP
         b3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZJbz/C3e+sb5O/hI+5UE82UL50nEjTNC67t2N91YPtY=;
        b=B2HpUZuEnz8Z+49m4icoesRjZVgk2EPTZ29cxys+HLN7IBkuOIUsKElig5YpgjoPxp
         C9yxQbMmGtonr1oMuN7XI/5ts0UhhUDFwuRQpu3j7HmiDbw0Ve11FPXWxZVa3oKfhThV
         IyI/+Th/xKukFXWpUx0yml0wqugUJWJ2W+8BcwTAPI5TXZuKW+keZsY5as3Va8ouFi5G
         1XjK/7D/ffNQurgLwdLwig5erUH+csSAIliXgaCSLG/EKx8FrlIJwdfoAdoqvc9mTsVW
         lzDeMalf+9zizonVrZzBqrd8l3x2Z/gWv0r3BP57u08a4AG6B7Tg/NdL/oMzuOjLL4St
         atqQ==
X-Gm-Message-State: APjAAAVbeFoTllEau70CvCvZHZEOTiG8dz2FJ0TV3XjiQ8tWYenxCKus
        gccXs/PXLqSAt4rGSLIgBNGuwah0FvCp
X-Google-Smtp-Source: APXvYqz/kKS6ujFbJd9+Guln2Rv6wk32UtbxZI5wpIlNdPvxaAXL5XvbwBo72Xmr42Ln2+xYuAIhyz3zyaoK
X-Received: by 2002:ae9:ebd0:: with SMTP id b199mr19266600qkg.56.1561159025911;
 Fri, 21 Jun 2019 16:17:05 -0700 (PDT)
Date:   Fri, 21 Jun 2019 16:16:47 -0700
In-Reply-To: <20190621231650.32073-1-brianvv@google.com>
Message-Id: <20190621231650.32073-4-brianvv@google.com>
Mime-Version: 1.0
References: <20190621231650.32073-1-brianvv@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH 3/6] bpf: keep bpf.h in sync with tools/
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

