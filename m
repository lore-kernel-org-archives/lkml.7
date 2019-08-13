Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7388C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 10:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B808206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 10:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y0RUcptj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfHMKX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 06:23:57 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:42544 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728914AbfHMKXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 06:23:52 -0400
Received: by mail-lf1-f53.google.com with SMTP id s19so13706284lfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 03:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mFrYdNufqJMBiXr6Fl+Xru3C6SYEreBVGiSnrc3weyc=;
        b=Y0RUcptj1nphOy9DUsYSiUGS5oC8t0JnfW7QiIiMtYxxcHAAIyv1N4Upb4ezqwLOrZ
         wuZg6ub802synfGnhYu7FTj6Q+z0l0UrajtxxBKWSW8G7D+qPTE7qJu0MjppbAHzzLYm
         0aOOHQIFsG4z6eviJ8yb8Cqdyw0y4/2IaU/kCNA0Qu0+tbdQv0fRSnCnCPEJJRJ6eat8
         WZgcxw37voDsQAoCE3tGerY8pE+0S3QnAax+CxfMuNScM6koos5vYuslETUmiTFak7pq
         p1gRy0yl2o4tUwFoqJ8fYbKrrGXdLOK5OILS8ajqrmb8qo+wJlZYxAc/vIIwa6vYzrYR
         bYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mFrYdNufqJMBiXr6Fl+Xru3C6SYEreBVGiSnrc3weyc=;
        b=JmhLeDbi5isvrggadAXW8jNkzi92eNuHEmvFaiMcpIQLpLP+dEH+Hqe4BxMwPsRbup
         x8LxZ4CHZbvadvftir50JMODM7GqOhE/nAxOzkCFTrxmFKyKOpWcIwek2uCJHdciGVHY
         i5VOd8cHvxDpvzSAbNmzJFVoyvO5edZS6wJt5WJw9XUt4LQXD4dXJF8OG5sKJ4pxyncH
         tRDbuRVTXkCgho31ies9cXYhDvTggf13lCUSoeXYcQIxY85LkvNnzvOK8Y5x9zKZeT5b
         FzHt6g20EyseULV6ZV0oXwbrjs/qWgObOUS3P0rDN9RSzg42FoKj/UWXBKl43fQ97E+e
         Kgjw==
X-Gm-Message-State: APjAAAVi6V+5+33QsF+bYV1V/N4o2njLX0xvn/m60zJuESJJxJmpcuLL
        O4O7TZKPiu3KQa8ZyXlHT5qy+A==
X-Google-Smtp-Source: APXvYqx5ubYdC+pwKtPbpWBtsKuHRSKAFyFuYvHkqHK34jLbYYqbtI1zkcH1ZbBt1JQOtwq91dYtuA==
X-Received: by 2002:a19:6041:: with SMTP id p1mr22325227lfk.6.1565691829914;
        Tue, 13 Aug 2019 03:23:49 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id e87sm24796942ljf.54.2019.08.13.03.23.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 03:23:49 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     magnus.karlsson@intel.com, bjorn.topel@intel.com
Cc:     davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
        jakub.kicinski@netronome.com, daniel@iogearbox.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        xdp-newbies@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH bpf-next 3/3] samples: bpf: syscal_nrs: use mmap2 if defined
Date:   Tue, 13 Aug 2019 13:23:18 +0300
Message-Id: <20190813102318.5521-4-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190813102318.5521-1-ivan.khoronzhuk@linaro.org>
References: <20190813102318.5521-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For arm32 xdp sockets mmap2 is preferred, so use it if it's defined.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/syscall_nrs.c  |  5 +++++
 samples/bpf/tracex5_kern.c | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/samples/bpf/syscall_nrs.c b/samples/bpf/syscall_nrs.c
index 516e255cbe8f..2dec94238350 100644
--- a/samples/bpf/syscall_nrs.c
+++ b/samples/bpf/syscall_nrs.c
@@ -9,5 +9,10 @@ void syscall_defines(void)
 	COMMENT("Linux system call numbers.");
 	SYSNR(__NR_write);
 	SYSNR(__NR_read);
+#ifdef __NR_mmap2
+	SYSNR(__NR_mmap2);
+#else
 	SYSNR(__NR_mmap);
+#endif
+
 }
diff --git a/samples/bpf/tracex5_kern.c b/samples/bpf/tracex5_kern.c
index f57f4e1ea1ec..300350ad299a 100644
--- a/samples/bpf/tracex5_kern.c
+++ b/samples/bpf/tracex5_kern.c
@@ -68,12 +68,23 @@ PROG(SYS__NR_read)(struct pt_regs *ctx)
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
+#else
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

