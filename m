Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE0DC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 19:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 859932245D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 19:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KKfy6cGF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfKSTaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 14:30:55 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:50011 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbfKSTay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 14:30:54 -0500
Received: by mail-pg1-f201.google.com with SMTP id 14so7133971pgv.16
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 11:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+X4EfDiauElJOC7RvUHMTNrf0yIKJ6Yo/r1JySL4OmE=;
        b=KKfy6cGFJzrvbZ+zaVtoIK6lbKkij8Ez+QP+UrABS7jTH6fWRYIOLXrUNxMuEhYho2
         gIJ0Z3z9EY5uAfnR/RT2mxFOPeuEJXtf0gOs2iwNjq7C89kcDwoPU+pkr6Fv7S2kIllI
         cgnJ4vZ95Lh6qUuqJ/b9vUDGOMJMIfF8TbS9XjBvp0KfxklTpcbFSSHiC/EoGqm4VvGT
         xheYmmAUWYh+0a+EgLJGRRBp61JZWwI/gvzpV9x8oFIiT98N8UwQNBptCNGx50kVH004
         1+eZVNTge9RNKalRpnP80Z9HZjoDuuoslzDpFkhj0dZ0CTDwUuoGXV0HxvGcGYxjt6Rv
         G3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+X4EfDiauElJOC7RvUHMTNrf0yIKJ6Yo/r1JySL4OmE=;
        b=BCp9BR79inSvGTNri9NsSRAht5Mggy8v8PxSy8TRtW6T03/iB839etFGzX0Q6iG3LZ
         kghbOYERmjrjMxSHIaDIcJ0r177oXnLiuSzVoCaYE3YFWilFqNHVKakSBFW8CHI0S6kS
         IhTzXUyC5YoOG+pHxew5QYEKM5ayJB8PDXI5EugTqvWu/QetA3DLCcos9+L+XN2ntR1X
         +46LwHB4TBo+zSiFlb+hdKG6vApZTFWRYIL/xDbBSCTBmVlAZWjgXFuYD+lzF9QLhExc
         0lHiRuAPdQFcnMbuD+Z/jBIr81r7xU1qmJqZLq+ACsA4MV78Dg80TFc/CLm9m+1pp6m7
         bUHw==
X-Gm-Message-State: APjAAAUKs3XClztmRN2QjJIAUE9LxNkA72hjk6c18TjudHgdkJmbteXM
        xG+X5bazHs5GTD+xkwFmgCWqI6/VL2zj
X-Google-Smtp-Source: APXvYqzXkr5QL8TzNPUeAu0p3xccRyiDCHLjKy9+fE96m5hofERZicATy3cDVLslLNxJKgSdiDuS1g9cr/Kq
X-Received: by 2002:a63:3587:: with SMTP id c129mr7516833pga.211.1574191853520;
 Tue, 19 Nov 2019 11:30:53 -0800 (PST)
Date:   Tue, 19 Nov 2019 11:30:31 -0800
In-Reply-To: <20191119193036.92831-1-brianvv@google.com>
Message-Id: <20191119193036.92831-5-brianvv@google.com>
Mime-Version: 1.0
References: <20191119193036.92831-1-brianvv@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v2 bpf-next 4/9] bpf: add lookup and updated batch ops to arraymap
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

This adds the generic batch ops functionality to bpf arraymap, note that
since deletion is not a valid operation for arraymap, only batch and
lookup are added.

Signed-off-by: Brian Vazquez <brianvv@google.com>
---
 kernel/bpf/arraymap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 1c65ce0098a95..680d4e99ef583 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -457,6 +457,8 @@ const struct bpf_map_ops array_map_ops = {
 	.map_direct_value_meta = array_map_direct_value_meta,
 	.map_seq_show_elem = array_map_seq_show_elem,
 	.map_check_btf = array_map_check_btf,
+	.map_lookup_batch = generic_map_lookup_batch,
+	.map_update_batch = generic_map_update_batch,
 };
 
 const struct bpf_map_ops percpu_array_map_ops = {
-- 
2.24.0.432.g9d3f5f5b63-goog

