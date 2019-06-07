Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B106AC468BD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B67220B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kinvolk.io header.i=@kinvolk.io header.b="A52/UPha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbfFGOLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 10:11:38 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42421 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729472AbfFGOLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:11:17 -0400
Received: by mail-ed1-f66.google.com with SMTP id z25so3213788edq.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 07:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a4BYbY0H/gJ/SBV0pW9HBq0oWfzuEg4LxLjaui3637c=;
        b=A52/UPhaDFmKTtTG9exlP6gH+yrRJmVwrdz56ohUfKW1gwkj+x4/Dq2PHUdpuj6YZT
         3/pvcYZolg2Xqok2Jijpnu95I/Og/Kfeehoz+bDcnwAmyAxlDjhYJnx0Xz2dbAz90qQP
         Fa2uO6BTJrDA/X2hHq0xwrOt4Te63fRj1iUjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a4BYbY0H/gJ/SBV0pW9HBq0oWfzuEg4LxLjaui3637c=;
        b=hFsUW8S37tJisbsa9zfkrc573JSPQ0eqbzxqWV94TF7kHP7ezAvHqTqTUezUXHDjZ9
         lMNDwEnPRWeJSvbna6bM4N1UsbeqfFVW25FiUQrlaw9yiPwt93vjgsKQnL6ncYkMTUvE
         n+DR/Pyz9Lv7vjOh8IJ/Ty4ge9aLJkMxgXOzN5npcUsYu5em1zAPregmjCema0JMEyXt
         S9NPTB548tHAeibMu5u8PoVYubIPjHipCmIkO5HmnG0haAnyCHKJYGCtmydwlbKnmzbn
         RZ+Usmp1cn0bS2z/x3t/Pi5f3vUXEaoe/VqrW/SGNSfKUPCVhimTZvtudNJx8G8qjKlY
         yacA==
X-Gm-Message-State: APjAAAW89gpo+41q6ZrpYqxWTSHwfRFHOKO7LsSU8/T88ah13jq4zYb0
        4BcAVX9hUZFGq06kujdPyq2nUQ==
X-Google-Smtp-Source: APXvYqwLVNr+7w9/STmzWhSBQ6bLcxrBsjntrXkA1h+OPVqNKlLghZ1xop6URIiy5ZgptgoOzJHl7A==
X-Received: by 2002:a17:906:7388:: with SMTP id f8mr47614254ejl.231.1559916675852;
        Fri, 07 Jun 2019 07:11:15 -0700 (PDT)
Received: from locke-xps13.fritz.box (dslb-002-205-069-198.002.205.pools.vodafone-ip.de. [2.205.69.198])
        by smtp.gmail.com with ESMTPSA id a40sm546116edd.1.2019.06.07.07.11.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 07:11:15 -0700 (PDT)
From:   =?UTF-8?q?Iago=20L=C3=B3pez=20Galeiras?= <iago@kinvolk.io>
To:     john.fastabend@gmail.com, ast@kernel.org, daniel@iogearbox.net
Cc:     alban@kinvolk.io, krzesimir@kinvolk.io, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v5 4/4] selftests: bpf: verifier: read netns_dev and netns_ino from struct bpf_sock_ops
Date:   Fri,  7 Jun 2019 16:11:06 +0200
Message-Id: <20190607141106.32148-5-iago@kinvolk.io>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607141106.32148-1-iago@kinvolk.io>
References: <20190607141106.32148-1-iago@kinvolk.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alban Crequy <alban@kinvolk.io>

Tested with:
> $ sudo ./test_verifier
> ...
> #905/p sockops accessing bpf_sock_ops->netns_dev, ok OK
> #906/p sockops accessing bpf_sock_ops->netns_ino, ok OK
> ...
> Summary: 1421 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Alban Crequy <alban@kinvolk.io>

---

Changes since v1:
- This is a new selftest (review from Song)

Changes since v2:
- test partial reads on netns_dev (review from Y Song)
- split in two tests
---
 .../testing/selftests/bpf/verifier/var_off.c  | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/var_off.c b/tools/testing/selftests/bpf/verifier/var_off.c
index 8504ac937809..9e4c6c78eb9d 100644
--- a/tools/testing/selftests/bpf/verifier/var_off.c
+++ b/tools/testing/selftests/bpf/verifier/var_off.c
@@ -246,3 +246,56 @@
 	.result = ACCEPT,
 	.prog_type = BPF_PROG_TYPE_LWT_IN,
 },
+{
+	"sockops accessing bpf_sock_ops->netns_dev, ok",
+	.insns = {
+	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_1, offsetof(struct bpf_sock_ops,
+							   netns_dev)),
+
+	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_1, offsetof(struct bpf_sock_ops,
+							   netns_dev)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_1, offsetof(struct bpf_sock_ops,
+							   netns_dev) + 4),
+
+	BPF_LDX_MEM(BPF_H, BPF_REG_4, BPF_REG_1, offsetof(struct bpf_sock_ops,
+							   netns_dev)),
+	BPF_LDX_MEM(BPF_H, BPF_REG_4, BPF_REG_1, offsetof(struct bpf_sock_ops,
+							   netns_dev) + 2),
+	BPF_LDX_MEM(BPF_H, BPF_REG_4, BPF_REG_1, offsetof(struct bpf_sock_ops,
+							   netns_dev) + 4),
+	BPF_LDX_MEM(BPF_H, BPF_REG_4, BPF_REG_1, offsetof(struct bpf_sock_ops,
+							   netns_dev) + 6),
+
+	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_1, offsetof(struct bpf_sock_ops,
+							   netns_dev)),
+	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_1, offsetof(struct bpf_sock_ops,
+							   netns_dev) + 1),
+	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_1, offsetof(struct bpf_sock_ops,
+							   netns_dev) + 2),
+	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_1, offsetof(struct bpf_sock_ops,
+							   netns_dev) + 3),
+	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_1, offsetof(struct bpf_sock_ops,
+							   netns_dev) + 4),
+	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_1, offsetof(struct bpf_sock_ops,
+							   netns_dev) + 5),
+	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_1, offsetof(struct bpf_sock_ops,
+							   netns_dev) + 6),
+	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_1, offsetof(struct bpf_sock_ops,
+							   netns_dev) + 7),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_SOCK_OPS,
+},
+{
+	"sockops accessing bpf_sock_ops->netns_ino, ok",
+	.insns = {
+	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_1, offsetof(struct bpf_sock_ops,
+							   netns_ino)),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_SOCK_OPS,
+},
-- 
2.21.0

