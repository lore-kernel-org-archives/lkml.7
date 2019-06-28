Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4D7C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E902133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzIGgqNT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfF1K4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 06:56:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46493 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfF1K4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 06:56:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id 81so2777627pfy.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 03:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=LM2PVia9yDuQIUSxGyow67X1AUByhEzDsc/mtFV8kis=;
        b=BzIGgqNT1CtN4hJKhGSmJlhMJtsU6OqvK5SJwf3nBV6IIeszUWI8pIBLmhHj7vMhCm
         3bxtB5HUpJBEQzEilF0iqZODPCkczcfcIyLtWmeJAGeQbftOtyIF/aWaBfIfjP5cFG/d
         S+3F/FdP2PmCs7WelKbcK4V9rJoQ8Sxix28X7vybbs595P0WIAJbEsoB+gW+0AAUBYIS
         UtNJRhd2dPhU59kEjZRKOoAZE+3e5iEOieJlFo4dQjd1pyBeistW1QXTdWt05aPcpURW
         jI9mOrRoeC7kLbRt00i3biQEYTZzlZXyEy6sgHbQm6WyVuzffO5XFvq/VA7A3Uqadv03
         Koig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LM2PVia9yDuQIUSxGyow67X1AUByhEzDsc/mtFV8kis=;
        b=XBXpx+FlJrYnjotXXD11Tm5mmmBsWpSbou06rTj3RNTkgbO+1zVlRbqxwV+MKxi5C8
         Oj1H9h/JA6A2PM/R0v1GNpCdio5eK0LvCo2qjGxDB81a47afh9BS1T53xEI6n5WU3Urt
         UIF40VjMeS0zmaa1VC7OekMG30vOzxz4Tzu5KIEs2na5GsZi7GczsHGiPU//0pQhkKXJ
         0kJAJN19SAAmy8hRtWGf+nwiaHihEVXJnQu4ufiX/NlmjJR/JBBXtcXsi91OFfPJbqbz
         BbrhGp0luns0YXvBaR67tpW4KlfwpLAWoF2/RsqCdJ50hePoeIFBpWRU0XaH6kUdabhk
         hUjg==
X-Gm-Message-State: APjAAAVEPr94LLIZRmhhhy4um0N+sbVcjnxl4P/1/ENZwQawtrAmF21p
        arjad+SP6G6Vd1S8DIrGqQ==
X-Google-Smtp-Source: APXvYqzP/F0lR+ugnr/ZQIEHq7TVhrBHg4m1heAwQUnI0e9Ax9kKRroDXUfCS8sUeuUgI0Yz1tbn4w==
X-Received: by 2002:a63:5a0a:: with SMTP id o10mr8887616pgb.282.1561719404192;
        Fri, 28 Jun 2019 03:56:44 -0700 (PDT)
Received: from DESKTOP (softbank060156123150.bbtec.net. [60.156.123.150])
        by smtp.gmail.com with ESMTPSA id q198sm3153032pfq.155.2019.06.28.03.56.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Jun 2019 03:56:43 -0700 (PDT)
Date:   Fri, 28 Jun 2019 19:56:40 +0900
From:   Takeshi Misawa <jeliantsurux@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] tracing: Fix memory leak in tracing_err_log_open()
Message-ID: <20190628105640.GA1863@DESKTOP>
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

Thanks for reviewing.

> Actually, I think it is safer to have the condition be:
> 
>         if (file->f_mode & FMODE_READ)
> 
> As that would match the open.
> 
> Can you send a v2?

I send a v2 patch.

Regards.
---
 kernel/trace/trace.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 83e08b78dbee..4122ccde6ec2 100644
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
+	if (file->f_mode & FMODE_READ)
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

