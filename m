Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCB5C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 12:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE33206C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 12:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IWRo0YgI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731832AbfHOMOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 08:14:48 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41548 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731776AbfHOMOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 08:14:32 -0400
Received: by mail-lf1-f65.google.com with SMTP id 62so1488656lfa.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 05:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aIVfXCW1+kiXSGueAdzDW1yyefj6NecEzYan4H+pqQc=;
        b=IWRo0YgIC5PrnJ7KHBk5p2MKI1bMnA25MrpR3+u6sXtARJMClbHlRjCEeBl8LlYmw+
         CuA31luU5HMV8WIcc8wNZzm3INx7zoxVpNydrj/gZHlq3e6d7oTsqmtP/NkFCyrMsRvF
         36oQVwiV3yUfI0TdJSpqkg73xRcBNxJBbyaqRQE+Xe/z1xejqHw1z1j67k8meNUe1BVU
         Mb7yn4eVM87G0tC/eNq9T/gJtQiOquVYAIS0t5nmxbHTyZkgyvRm0tyaatmWjeeghO1g
         3Ab7WzGzwRqzwZ5zQS5gisf5Nnj7vvq543McaqHLPDAo0FNTP+icYMYi/mj7t2rAzo1k
         ybsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aIVfXCW1+kiXSGueAdzDW1yyefj6NecEzYan4H+pqQc=;
        b=Vj+mhMFkQJh2s409zueciYQlb1RzzVkGj92Y09Ranewdoe20zX9qZH4+8ExvUEU3pF
         ZfGdtNHaXs650qZKMQ554Y/wRAizEYmueCC8FpQBRPyOdRoukhLp96B3yBtbR+5wt6Jb
         ZWc/34mTyFEmZ2AnPKVXc5zeCH0WgqjxM7Ffv/XvyVj/LProOyR/nAioYY8ZCQRHGmPG
         8Rijal/4lknRgXEdqVgjyJNFHKeb1rwoCkQJig2vKWbSosTUUvTPk1+DjgLDIDg67TUZ
         j6IYc/M+K/s0B4FfSbkTrYvoDgV2N4mjYy6NnlbXmcTRh0EwS6Xi3Dh4FD2qfhjDb42+
         O25w==
X-Gm-Message-State: APjAAAWZlqgEwjWWPQa+4uz04/UnV1llNtXLekifsqGPvu3y0eD9xeMj
        0U6VJAQzS+qitkB4LgXPrCB3vA==
X-Google-Smtp-Source: APXvYqzfFMtyr4sHYyHuVpFusHpNj+KZyw1KwJMVehQBwCRbpnsZoYpaoPpgtFyivFAAYDHobXOLkA==
X-Received: by 2002:ac2:599b:: with SMTP id w27mr2300688lfn.75.1565871270040;
        Thu, 15 Aug 2019 05:14:30 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id q25sm462060ljg.30.2019.08.15.05.14.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 15 Aug 2019 05:14:29 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     magnus.karlsson@intel.com, bjorn.topel@intel.com
Cc:     davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
        jakub.kicinski@netronome.com, daniel@iogearbox.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        xdp-newbies@vger.kernel.org, linux-kernel@vger.kernel.org,
        jlemon@flugsvamp.com, yhs@fb.com, andrii.nakryiko@gmail.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH bpf-next v2 3/3] samples: bpf: syscal_nrs: use mmap2 if defined
Date:   Thu, 15 Aug 2019 15:13:56 +0300
Message-Id: <20190815121356.8848-4-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190815121356.8848-1-ivan.khoronzhuk@linaro.org>
References: <20190815121356.8848-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For arm32 xdp sockets mmap2 is preferred, so use it if it's defined.
Declaration of __NR_mmap can be skipped and it breaks build.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/syscall_nrs.c  |  6 ++++++
 samples/bpf/tracex5_kern.c | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/samples/bpf/syscall_nrs.c b/samples/bpf/syscall_nrs.c
index 516e255cbe8f..88f940052450 100644
--- a/samples/bpf/syscall_nrs.c
+++ b/samples/bpf/syscall_nrs.c
@@ -9,5 +9,11 @@ void syscall_defines(void)
 	COMMENT("Linux system call numbers.");
 	SYSNR(__NR_write);
 	SYSNR(__NR_read);
+#ifdef __NR_mmap2
+	SYSNR(__NR_mmap2);
+#endif
+#ifdef __NR_mmap
 	SYSNR(__NR_mmap);
+#endif
+
 }
diff --git a/samples/bpf/tracex5_kern.c b/samples/bpf/tracex5_kern.c
index f57f4e1ea1ec..35cb0eed3be5 100644
--- a/samples/bpf/tracex5_kern.c
+++ b/samples/bpf/tracex5_kern.c
@@ -68,12 +68,25 @@ PROG(SYS__NR_read)(struct pt_regs *ctx)
 	return 0;
 }
 
+#ifdef __NR_mmap2
+PROG(SYS__NR_mmap2)(struct pt_regs *ctx)
+{
+	char fmt[] = "mmap2\n";
+
+	bpf_trace_printk(fmt, sizeof(fmt));
+	return 0;
+}
+#endif
+
+#ifdef __NR_mmap
 PROG(SYS__NR_mmap)(struct pt_regs *ctx)
 {
 	char fmt[] = "mmap\n";
+
 	bpf_trace_printk(fmt, sizeof(fmt));
 	return 0;
 }
+#endif
 
 char _license[] SEC("license") = "GPL";
 u32 _version SEC("version") = LINUX_VERSION_CODE;
-- 
2.17.1

