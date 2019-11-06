Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99726C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540D6222C9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="l5M21eoj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387567AbfKFDGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:06:40 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36930 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387468AbfKFDGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:06:37 -0500
Received: by mail-pf1-f195.google.com with SMTP id p24so11221949pfn.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1eu3UPlsBV/UY26NeNGjbz4l7EAQWTc1IzyHUwCN9e8=;
        b=l5M21eojm5ADgK30p3n29KBNvRjlQLyb5o3RSfzCBPtwd8xfYvXmO0h/XTmbszl+Cz
         Ip+WvAoeM0zYHC6lP/mwNI1cBLVX//0wIybOlWCY+9eZEZ2CrNzVv3NtsoMU3Yf7PtDQ
         umy/fXovlvyoOFOoyosnA6gBZtjlbWbc/glH+hq/GllGadGd7H52suxaBW4/Xj6Ke80N
         qeqpMcOGN1Tcpuu4sTD2W0I/EQr88ZYXI3mejfPC41ezvNJwsuCnUClc3vT3umE8KOa9
         WBOhSzXHctupm9vMwGbv34PHxVrEHipDQv2J7iSwb7IpO4v/DcVEg87xh2ckquQBw7mM
         Voog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1eu3UPlsBV/UY26NeNGjbz4l7EAQWTc1IzyHUwCN9e8=;
        b=cQ40l1ZWD+HSfWMekIrjhuqIo6/vMWyLWN+6GtrMbN6aIoIBLBquZ0nsPRDdwKEvGj
         fMM/nNqJG+zareI389GZ3PPknCD9S2MsJx+KCzZS3k5J7XLU46CVF0OW+3e8/gJIIPDt
         +JfKxfxb4MhHu7+SgV0TPKXQzYOCovKUexlBACaCnJ14dmF98t66W6t4TRr8JRUI1D89
         gCSRdxl7gq2fotpyp5ev7tM06aT9P+iWIM0TYjXMcn8WVGWnCa7s06Syqg0TmVzYS0op
         FtR68OrNUckqlYCl4eJ+FPk6hgyqU0QP/Q42ZuNweMhaB9w442oCFDLH3Kp2DIloDzjA
         UChg==
X-Gm-Message-State: APjAAAVx99TC+rd2LP4NUY9OkGRo6we5ONxjtGxi/KLKroQX/9Blr9qK
        O6iktJy2ZzVU7eEX8OZhqzSPCddXLkY=
X-Google-Smtp-Source: APXvYqwvxn/9sS9MC1m5ry0eE34Vul3uDKIsXO53cTh59yiwSYajJzdjlH7cpBZS3MzGAYufLnftpA==
X-Received: by 2002:a63:541e:: with SMTP id i30mr219652pgb.130.1573009596665;
        Tue, 05 Nov 2019 19:06:36 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:06:35 -0800 (PST)
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
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH 07/50] arm: Wire up dump_backtrace_{entry,stm}
Date:   Wed,  6 Nov 2019 03:04:58 +0000
Message-Id: <20191106030542.868541-8-dima@arista.com>
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

Now that c_backtrace() always emits correct loglvl, use it for printing.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: clang-built-linux@googlegroups.com
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/arm/kernel/traps.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index e4f4ec8a1899..16022b75a72f 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -66,13 +66,16 @@ void dump_backtrace_entry(unsigned long where, unsigned long from,
 			  unsigned long frame, const char *loglvl)
 {
 #ifdef CONFIG_KALLSYMS
-	printk("[<%08lx>] (%ps) from [<%08lx>] (%pS)\n", where, (void *)where, from, (void *)from);
+	printk("%s[<%08lx>] (%ps) from [<%08lx>] (%pS)\n",
+		loglvl, where, (void *)where, from, (void *)from);
 #else
-	printk("Function entered at [<%08lx>] from [<%08lx>]\n", where, from);
+	printk("%sFunction entered at [<%08lx>] from [<%08lx>]\n",
+		loglvl, where, from);
 #endif
 
 	if (in_entry_text(from))
-		dump_mem("", "Exception stack", frame + 4, frame + 4 + sizeof(struct pt_regs));
+		dump_mem(loglvl, "Exception stack",
+			frame + 4, frame + 4 + sizeof(struct pt_regs));
 }
 
 void dump_backtrace_stm(u32 *stack, u32 instruction, const char *loglvl)
@@ -87,12 +90,12 @@ void dump_backtrace_stm(u32 *stack, u32 instruction, const char *loglvl)
 			if (++x == 6) {
 				x = 0;
 				p = str;
-				printk("%s\n", str);
+				printk("%s%s\n", loglvl, str);
 			}
 		}
 	}
 	if (p != str)
-		printk("%s\n", str);
+		printk("%s%s\n", loglvl, str);
 }
 
 #ifndef CONFIG_ARM_UNWIND
-- 
2.23.0

