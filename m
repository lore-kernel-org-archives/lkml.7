Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35342C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 01:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F7C522313
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 01:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XuRXY+Uo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfKSBo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 20:44:28 -0500
Received: from mail-yb1-f201.google.com ([209.85.219.201]:50863 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbfKSBoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 20:44:24 -0500
Received: by mail-yb1-f201.google.com with SMTP id u10so13668657ybj.17
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 17:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+X4EfDiauElJOC7RvUHMTNrf0yIKJ6Yo/r1JySL4OmE=;
        b=XuRXY+Uojn4XMwzMfwawiXvnYay5fnux5+uJeb3ziZ3R5w/vbNhsqKzQ/EKcdHNva/
         bTVABpEbKe34fuMWa+rwVkf9oUB+ETllNbUdUuEV0kMV27/I5J46qEvTfjgr3geFNG+s
         VuSKrsE9MCPhH2N0/LwdjCjUe+e+7kT1wnb7rWBqjNaQZyzKPXI8ZtCdQjtjJ4NT+QVx
         GGYs8he60Apg56auefYNhlsWUk/3YYn80LCHN2SQIEPH+cUJtaYM/Gi894vrfxz39I65
         SfD/FmVf683ut0qb6rCIBdLpkfRwi72MeVlTL7TmwAh1xuxqQFLA90nnUry9c6MB5Zpy
         j0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+X4EfDiauElJOC7RvUHMTNrf0yIKJ6Yo/r1JySL4OmE=;
        b=KtJvRd4RF5BfsZcUtEVVOozbRis0JE+UQdIhd5DJ62wcDtcrnbVkURqYCaFgMihVxp
         sHRdFDZUuBpFjdxxejOmN6Q8+X/K3jZ0Jscb39pirxT0DgpEpuVL29+4H0vX8146bVCZ
         HpiXmPTi9pNjurqSX37nW6jVrr7FlXuVowCS01pTU9YTSRLNIjgS9BqVM+tB+YpexmY0
         g5jf3LAyA6n3jaQDctFjxGNSFTUAeIrB2MDiO9j2Z6lrsgM1Huhf8Mtp5EZl4R1lPn1l
         Wyq1femjkQjtTLpeM8zdsziGZDNY+WMmOEE9RVchZY3i/UJ71mcCXzCBWF0V6SC2TAaR
         ZSQg==
X-Gm-Message-State: APjAAAXx6J2h4wvkQAFsZrL63lGOvnQfjVNA/YJVQ5Fg//LRywEk2N9N
        pRr+tSNaMfVxKCXNhdMF5trSXEapWHxi
X-Google-Smtp-Source: APXvYqyTrKX/xD95yspop64YmtLkkWhLlkti3RyghsE1x1RjvOga6zkHUJod3Kf+PT0x/rL4hhHXbqUl7AWp
X-Received: by 2002:a81:36c9:: with SMTP id d192mr10218854ywa.304.1574127863941;
 Mon, 18 Nov 2019 17:44:23 -0800 (PST)
Date:   Mon, 18 Nov 2019 17:43:52 -0800
In-Reply-To: <20191119014357.98465-1-brianvv@google.com>
Message-Id: <20191119014357.98465-5-brianvv@google.com>
Mime-Version: 1.0
References: <20191119014357.98465-1-brianvv@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH bpf-next 4/9] bpf: add lookup and updated batch ops to arraymap
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

