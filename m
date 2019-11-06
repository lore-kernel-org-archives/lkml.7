Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BBAC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609C4217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="HuIy9JyT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388128AbfKFDIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:08:11 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36732 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388109AbfKFDII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:08:08 -0500
Received: by mail-pl1-f194.google.com with SMTP id g9so10746301plp.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=krw2DtLP1PZT1tOzmGJzp2RNOS969yxXgVGVTB3Wv1I=;
        b=HuIy9JyTSJFk1D8S7+9ga2Mb8iqy3kxl/lUwYkfCkCXoxIpNvQq5J9ZSkXHljBUO8N
         zTMMEcpvLkIbRcmQXbzJGN0tYz1lQZh5MDJPkn4TFt2Kz1I/V+PQyWp/OrXi3MXP6Gu6
         hA9j128uI/02BTasdH22ZUTR1eeFge+Pasoo9V3tK6ivRaxekep+lFlsEWm2aV3wAtlN
         NoDtvR7p6q/VO81Kbxr5T+qALJ5lMPBNrMN8TGHVEQ07QoSbHjVP4KsN862gK77CMNXD
         zVARabiX7+q/Nls/zGIugLfJGK5j9NKssu6s7JM65lQ6lzGs71BvbMuv8xvfuTmrDGe2
         GzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=krw2DtLP1PZT1tOzmGJzp2RNOS969yxXgVGVTB3Wv1I=;
        b=Ux1lyh+61qz+JYAddiWLUISXZc4ZhVwCeZK9J90+DagWacoPmYNT/Dj8JjM4eLPKCB
         AHynry4TU8JLaCGftAXs1jUbIh/DCdr/F+YEphnvfWVraXmsqkFmbEb048/qpLn+y/sp
         om+rOs9kZi5z3xw/pbXbS4SfAH7YQKFQ5mnk+ITZE+5pNbcGyIhe4vblmHRBcqjvIBWA
         TN0qqG39nSlxWbF5cnvtEZmeEUYBs3SCCzLXeveRjeIfDuWGjEK7RzuOgiRJDK2dfAxm
         TcwLe2LkRegGZ54dlqiSpnfIUjZ4UDi8+DbZoUE3E0yFSwSSmfRTsFd6EVQvYpagyOg3
         VHYw==
X-Gm-Message-State: APjAAAXGQKiSj9nMY9ekCJ/QZpgSHI94j1TRQYyHZxy+uw2bHkEerTkE
        f6Q1rkpHj0pLrl6hDWxQjamnKPKxBm8=
X-Google-Smtp-Source: APXvYqyO1p53T40L80Ujgk/Io74DhgrdvKnmGaAVMffSPhWQ0dtW+TPMufZos2YV/EyOBb0aZCE/zQ==
X-Received: by 2002:a17:902:9347:: with SMTP id g7mr140515plp.291.1573009686827;
        Tue, 05 Nov 2019 19:08:06 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:08:06 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: [PATCH 31/50] sh: Add loglvl to printk_address()
Date:   Wed,  6 Nov 2019 03:05:22 +0000
Message-Id: <20191106030542.868541-32-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106030542.868541-1-dima@arista.com>
References: <20191106030542.868541-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the log-level of show_stack() depends on a platform
realization. It creates situations where the headers are printed with
lower log level or higher than the stacktrace (depending on
a platform or user).

Furthermore, it forces the logic decision from user to an architecture
side. In result, some users as sysrq/kdb/etc are doing tricks with
temporary rising console_loglevel while printing their messages.
And in result it not only may print unwanted messages from other CPUs,
but also omit printing at all in the unlucky case where the printk()
was deferred.

Introducing log-level parameter and KERN_UNSUPPRESSED [1] seems
an easier approach than introducing more printk buffers.
Also, it will consolidate printings with headers.

Add log level argument to printk_address() as a preparation to introduce
show_stack_loglvl().

As a good side-effect show_fault_oops() now prints the address with
KERN_EMREG as the rest of output, making sure there won't be situation
where "PC: " is printed without actual address.

Cc: Rich Felker <dalias@libc.org>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/sh/include/asm/kdebug.h | 3 ++-
 arch/sh/kernel/dumpstack.c   | 6 +++---
 arch/sh/mm/fault.c           | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/sh/include/asm/kdebug.h b/arch/sh/include/asm/kdebug.h
index de8693fabb1d..960545306afa 100644
--- a/arch/sh/include/asm/kdebug.h
+++ b/arch/sh/include/asm/kdebug.h
@@ -12,7 +12,8 @@ enum die_val {
 };
 
 /* arch/sh/kernel/dumpstack.c */
-extern void printk_address(unsigned long address, int reliable);
+extern void printk_address(unsigned long address, int reliable,
+			   const char *loglvl);
 extern void dump_mem(const char *str, const char *loglvl,
 		     unsigned long bottom, unsigned long top);
 
diff --git a/arch/sh/kernel/dumpstack.c b/arch/sh/kernel/dumpstack.c
index 2c1a78e5776b..959064b90055 100644
--- a/arch/sh/kernel/dumpstack.c
+++ b/arch/sh/kernel/dumpstack.c
@@ -44,9 +44,9 @@ void dump_mem(const char *str, const char *loglvl,
 	}
 }
 
-void printk_address(unsigned long address, int reliable)
+void printk_address(unsigned long address, int reliable, const char *loglvl)
 {
-	printk(" [<%p>] %s%pS\n", (void *) address,
+	printk("%s [<%p>] %s%pS\n", loglvl, (void *) address,
 			reliable ? "" : "? ", (void *) address);
 }
 
@@ -118,7 +118,7 @@ static int print_trace_stack(void *data, char *name)
  */
 static void print_trace_address(void *data, unsigned long addr, int reliable)
 {
-	printk_address(addr, reliable);
+	printk_address(addr, reliable, (char *)data);
 }
 
 static const struct stacktrace_ops print_trace_ops = {
diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
index 5f51456f4fc7..b11f0c5e65b6 100644
--- a/arch/sh/mm/fault.c
+++ b/arch/sh/mm/fault.c
@@ -196,7 +196,7 @@ show_fault_oops(struct pt_regs *regs, unsigned long address)
 
 	printk(KERN_CONT " at %08lx\n", address);
 	printk(KERN_ALERT "PC:");
-	printk_address(regs->pc, 1);
+	printk_address(regs->pc, 1, KERN_ALERT);
 
 	show_pte(NULL, address);
 }
-- 
2.23.0

