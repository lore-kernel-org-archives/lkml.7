Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D91C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 11:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259CC2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 11:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkgGzLnh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfF0LlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 07:41:22 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40365 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfF0LlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 07:41:22 -0400
Received: by mail-pl1-f196.google.com with SMTP id a93so1163318pla.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 04:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=sHz/AfhQwEVWkqaotDnf7ZzBPyziK/3d7LRXEfP5eGA=;
        b=AkgGzLnhHXCQnmw6FduZTWDTYYGIPuKqiNiLKtexcTOQApmJfihPxJW3ca7yzF8EL+
         uQc0ADCowfRL/9/rtuAPqtn6kTpgLru9T+AH4ra94+U9swoWF9vc5dxTUdvuThkt9YZ+
         e/eUOfApp2hPTNVi+79QXOOk8otpq4m7ZOK8W08MGwlLR8bUPc06SFe4JgudoJCiJZ+s
         ptcZTIPbqH3LcuCK8dbaIGDEiuSKSTu58+4spKJMplZj/08AetfbbWavkdM1vml7O72R
         2WYqSkKtAkQ/lqf/mb6IJWtQzCyp7Mn5iAb9xruyjZ8X+8jaiHX3Jlp4mCzg+djDOfsL
         buqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sHz/AfhQwEVWkqaotDnf7ZzBPyziK/3d7LRXEfP5eGA=;
        b=VEczQaH/NK2CU6jSAjNsJUx/83Mf5oD6WxzSra89RdVtOJZxmsD5p/sCZYiY0Mp/At
         PckNIk70FnZyyN2DY/JT4nRmLLOdNtpPCV5791UtOE/1HepZzYgKm4qHXdFg3z/hWZau
         hEzKhuidhjTzJeqgRTVV6nadEOfAd2X0r/6YZHNW39z02l70Z3t+YmUtyPBdZR7GmX95
         8czedNM4eBrIhkJDs/uIU0Np2LhApmhvrAkzbBylr2krK+E2DuJVL/3Dm3W4CEYee3m2
         Q1d8PkrAdNPvDUz25pzc1Mc0/5bGMB14mSw1M16BYbFMLzZF4Q7ErosdQTta4RziINgU
         PEeQ==
X-Gm-Message-State: APjAAAXMaIaVTyjX9GdK1NIO6cK9gBCvzesetjZpWvdGR3KpoO97dxlo
        bBN79RiPElfMfxwTRR7/tw==
X-Google-Smtp-Source: APXvYqx7R0Tn+WVu4DUHf30QWa/pZQgT6H2A8qoLrDmHcMgb7nqHLTSmX/BtCFJZu0ur3PS/CqP3eQ==
X-Received: by 2002:a17:902:2be8:: with SMTP id l95mr3869213plb.231.1561635681618;
        Thu, 27 Jun 2019 04:41:21 -0700 (PDT)
Received: from DESKTOP (softbank126011121060.bbtec.net. [126.11.121.60])
        by smtp.gmail.com with ESMTPSA id t7sm3551663pjq.15.2019.06.27.04.41.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jun 2019 04:41:20 -0700 (PDT)
Date:   Thu, 27 Jun 2019 20:41:16 +0900
From:   Takeshi Misawa <jeliantsurux@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: Fix memory leak in tracing_err_log_open()
Message-ID: <20190627114116.GA2533@DESKTOP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If tracing_err_log_open() call seq_open(), allocated memory is not freed.

kmemleak report:

unreferenced object 0xffff92c0781d1100 (size 128):
  comm "tail", pid 15116, jiffies 4295163855 (age 22.704s)
  hex dump (first 32 bytes):
    00 f0 08 e5 c0 92 ff ff 00 10 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000000d0687d5>] kmem_cache_alloc+0x11f/0x1e0
    [<000000003e3039a8>] seq_open+0x2f/0x90
    [<000000008dd36b7d>] tracing_err_log_open+0x67/0x140
    [<000000005a431ae2>] do_dentry_open+0x1df/0x3a0
    [<00000000a2910603>] vfs_open+0x2f/0x40
    [<0000000038b0a383>] path_openat+0x2e8/0x1690
    [<00000000fe025bda>] do_filp_open+0x9b/0x110
    [<00000000483a5091>] do_sys_open+0x1ba/0x260
    [<00000000c558b5fd>] __x64_sys_openat+0x20/0x30
    [<000000006881ec07>] do_syscall_64+0x5a/0x130
    [<00000000571c2e94>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fix this by calling seq_release() in tracing_err_log_fops.release().

Signed-off-by: Takeshi Misawa <jeliantsurux@gmail.com>
---
Dear Steven Rostedt

I found kmemleak in tracing subsystem, and try to create a patch.
Please consider this memory leak and patch.

Regards.
---
 kernel/trace/trace.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 83e08b78dbee..574648798978 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7126,12 +7126,24 @@ static ssize_t tracing_err_log_write(struct file *file,
 	return count;
 }
 
+static int tracing_err_log_release(struct inode *inode, struct file *file)
+{
+	struct trace_array *tr = inode->i_private;
+
+	trace_array_put(tr);
+
+	if (file->private_data)
+		seq_release(inode, file);
+
+	return 0;
+}
+
 static const struct file_operations tracing_err_log_fops = {
 	.open           = tracing_err_log_open,
 	.write		= tracing_err_log_write,
 	.read           = seq_read,
 	.llseek         = seq_lseek,
-	.release	= tracing_release_generic_tr,
+	.release        = tracing_err_log_release,
 };
 
 static int tracing_buffers_open(struct inode *inode, struct file *filp)
-- 
2.17.1

