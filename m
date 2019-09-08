Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B49BC07533
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FC021920
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567946999;
	bh=XnMCGqNX4fqjv1YWON+5G92IJbWmNbmH9o/BmbQb2Vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mZydDsu5muasqTABURBKQt/mPylHghyrPPM4QwmLMkcsUqjrJrXtAqJoAl3qAHij1
	 F6fLE7jcGaS/DFOKwZHf+KGWUQLUgwZzMQBsTyjkRejQaqQLrmHzt6dKXZaq1anjFE
	 zaWRcfBqoRHx5LpTQy/MZfYC8GZpXMyl37AoAdtA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731879AbfIHMt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:49:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731838AbfIHMt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:49:56 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 684AE218AF;
        Sun,  8 Sep 2019 12:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567946995;
        bh=XnMCGqNX4fqjv1YWON+5G92IJbWmNbmH9o/BmbQb2Vc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QPU78k6zNS2RhRSdqnTRFqLSvO4bJsJe+vOZgXmEhIH/+SRulL+ug5priE2Z0XdQr
         0Iruy8NhOJqYtKV8U3m7SgBLKAbW6hNc+ToFuH2OGDVZlv/Sv7Tb3LxjHBcwGPfOcv
         1XkCY2dSb6uYUPCkChJ4ElJ0YRIeLa9ItTmiZ2uA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Ignatov <rdna@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 22/94] libbpf: set BTF FD for prog only when there is supported .BTF.ext data
Date:   Sun,  8 Sep 2019 13:41:18 +0100
Message-Id: <20190908121151.074226634@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121150.420989666@linuxfoundation.org>
References: <20190908121150.420989666@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 3415ec643e7bd644b03026efbe2f2b36cbe9b34b ]

5d01ab7bac46 ("libbpf: fix erroneous multi-closing of BTF FD")
introduced backwards-compatibility issue, manifesting itself as -E2BIG
error returned on program load due to unknown non-zero btf_fd attribute
value for BPF_PROG_LOAD sys_bpf() sub-command.

This patch fixes bug by ensuring that we only ever associate BTF FD with
program if there is a BTF.ext data that was successfully loaded into
kernel, which automatically means kernel supports func_info/line_info
and associated BTF FD for progs (checked and ensured also by BTF
sanitization code).

Fixes: 5d01ab7bac46 ("libbpf: fix erroneous multi-closing of BTF FD")
Reported-by: Andrey Ignatov <rdna@fb.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/libbpf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 21355f6be2434..0ccf6aa533ae9 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2071,7 +2071,11 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 	load_attr.license = license;
 	load_attr.kern_version = kern_version;
 	load_attr.prog_ifindex = prog->prog_ifindex;
-	btf_fd = bpf_object__btf_fd(prog->obj);
+	/* if .BTF.ext was loaded, kernel supports associated BTF for prog */
+	if (prog->obj->btf_ext)
+		btf_fd = bpf_object__btf_fd(prog->obj);
+	else
+		btf_fd = -1;
 	load_attr.prog_btf_fd = btf_fd >= 0 ? btf_fd : 0;
 	load_attr.func_info = prog->func_info;
 	load_attr.func_info_rec_size = prog->func_info_rec_size;
-- 
2.20.1



