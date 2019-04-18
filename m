Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA4BC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B07320821
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uwQ/UH7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389635AbfDRP5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:57:55 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46631 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbfDRP5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:57:54 -0400
Received: by mail-ed1-f68.google.com with SMTP id d1so2186712edd.13;
        Thu, 18 Apr 2019 08:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fz/33z2pmcQnZT8fZhBZ5rsQpuocNULIoiNU7dc5uD4=;
        b=uwQ/UH7hrcuhIB+dgbXMGF8uNPOK7R94BS0+9Rm+/FTTGzs4xgRCaHdW9L/JIfguoP
         SEVEST8nfmmzpGMUYqZZtNVS/tQi5HKYoqYaKH/7NSib8vx7ltoNPJTs0/j1m8t8Ckmm
         +/ZbXSy0f+a1GuxqqK14cHnm+n+LluYsrUXzGstGaAbe1CigCmUjWd8eUO/2v9Bjf5QK
         V4iPhopceZVgVfPRFv83s19XU36KPS+C79pnBjsYi07NTar43ybLCVukm5KG9crTu/8C
         3o7wj0jtppxtN1+6yYmzziRV7vNqclaiD2Fk61yNwmLMbQVD3Gix0QKHGlTNIoHC+8Ip
         v9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Fz/33z2pmcQnZT8fZhBZ5rsQpuocNULIoiNU7dc5uD4=;
        b=RD7PP2dA7bAZAJZXgp12F2t86vUroTtIcPXnPSmgyZIwsVQ/HtRgwz2YehNjNDVXxv
         HV2tyrjRWrBib8m2S5W9rkQcOWPOnE/jKdXSjHT6CFTmXhrjrl0h6pIvS0X1fgVlZ/Uy
         hVDQmDIGUzGtbOoSHR/AU5LFJgnD4Nh7+xt5gFJ6R3axE4R9J2KlTEmC8FtXxPeu9Ft6
         0qmu/1k7CnWtzy74mwRbuvOzX8gcGh7JaCDiUK0Ch3XInVfDoDLudIwDYxuGwBr/e5uy
         2QEPPWec6odNLmzKkIKZW6cvXt8j3XUdFrmnTTtCNfRqFg7n8k78xg8UWAFae8vwffZ+
         BOGw==
X-Gm-Message-State: APjAAAW45c177I/ETkcECogNg0JbjLjq1YXOGX82hPxboez62HIdSzgX
        QSVwB8vVddEqdMqkceL2EII=
X-Google-Smtp-Source: APXvYqyAgDB7g9NPKLyZXKMkrz8LXK3A01hATaxLnE7KWqeDW+LmUxcUzvJ8z4Zf5vU+tzj5rCgipg==
X-Received: by 2002:a17:906:29c1:: with SMTP id y1mr49962271eje.251.1555603072521;
        Thu, 18 Apr 2019 08:57:52 -0700 (PDT)
Received: from neptune.fritz.box ([178.19.216.175])
        by smtp.gmail.com with ESMTPSA id 31sm591274edf.18.2019.04.18.08.57.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 08:57:51 -0700 (PDT)
From:   Alban Crequy <alban.crequy@gmail.com>
X-Google-Original-From: Alban Crequy <alban@kinvolk.io>
To:     john.fastabend@gmail.com, ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alban@kinvolk.io, iago@kinvolk.io
Subject: [PATCH bpf-next v2 3/3] selftests: bpf: verifier: read netns_dev and netns_ino from struct bpf_sock_ops
Date:   Thu, 18 Apr 2019 17:56:52 +0200
Message-Id: <20190418155652.22181-3-alban@kinvolk.io>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190418155652.22181-1-alban@kinvolk.io>
References: <20190418155652.22181-1-alban@kinvolk.io>
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
> #905/p sockops accessing bpf_sock_ops->netns_dev and netns_ino, ok OK
> ...
> Summary: 1420 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Alban Crequy <alban@kinvolk.io>

---

Changes since v1:
- This is a new selftest (review from Song)
---
 tools/testing/selftests/bpf/verifier/var_off.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/var_off.c b/tools/testing/selftests/bpf/verifier/var_off.c
index 8504ac937809..1ad3f64145ba 100644
--- a/tools/testing/selftests/bpf/verifier/var_off.c
+++ b/tools/testing/selftests/bpf/verifier/var_off.c
@@ -246,3 +246,16 @@
 	.result = ACCEPT,
 	.prog_type = BPF_PROG_TYPE_LWT_IN,
 },
+{
+	"sockops accessing bpf_sock_ops->netns_dev and netns_ino, ok",
+	.insns = {
+	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_1, offsetof(struct bpf_sock_ops,
+							   netns_dev)),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_1, offsetof(struct bpf_sock_ops,
+							   netns_ino)),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_SOCK_OPS,
+},
-- 
2.20.1

