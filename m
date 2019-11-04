Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93E4CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F29621D81
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572905267;
	bh=TTB8UBu/Kwrk49Iibpo1M3U4PWEFdAC5mkCs13JqpWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vbzUH58exsbbD7edJ9geNkGgpi41EaLCzZxo9++qRH+pv6zH0R5SAXpfYMXD5Obt9
	 A6/s5rbc0kHgpNsHrCkfe4qNAtiwnAgTNtgp48GsVo3UPnRPhJoJYT7/s5POueAFKd
	 CibDIGQ8iT1JA3xgFgnxToICI9Tcczsesbx4NKN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389344AbfKDWHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:07:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:40230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390156AbfKDWHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:07:39 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7B56205C9;
        Mon,  4 Nov 2019 22:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572905258;
        bh=TTB8UBu/Kwrk49Iibpo1M3U4PWEFdAC5mkCs13JqpWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lTKalqJbWqQKYlxOzgpi6dB3FBBH6aKJ1XMpsnxxPAxmM2CwYcAg4GQ2PSVtDCZ0Z
         0pEA0w70Cel9Xet79NCaJJe5ZQiCRkQ2NE56PurQG4UnGxDewOY5mwtBc4Reu8I+xh
         XdoDRzZ92js68iDS6ZhDKeOAbLJ2CjA/SMKZdF+E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 082/163] tracing: Initialize iter->seq after zeroing in tracing_read_pipe()
Date:   Mon,  4 Nov 2019 22:44:32 +0100
Message-Id: <20191104212146.231843058@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212140.046021995@linuxfoundation.org>
References: <20191104212140.046021995@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Mladek <pmladek@suse.com>

[ Upstream commit d303de1fcf344ff7c15ed64c3f48a991c9958775 ]

A customer reported the following softlockup:

[899688.160002] NMI watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [test.sh:16464]
[899688.160002] CPU: 0 PID: 16464 Comm: test.sh Not tainted 4.12.14-6.23-azure #1 SLE12-SP4
[899688.160002] RIP: 0010:up_write+0x1a/0x30
[899688.160002] Kernel panic - not syncing: softlockup: hung tasks
[899688.160002] RIP: 0010:up_write+0x1a/0x30
[899688.160002] RSP: 0018:ffffa86784d4fde8 EFLAGS: 00000257 ORIG_RAX: ffffffffffffff12
[899688.160002] RAX: ffffffff970fea00 RBX: 0000000000000001 RCX: 0000000000000000
[899688.160002] RDX: ffffffff00000001 RSI: 0000000000000080 RDI: ffffffff970fea00
[899688.160002] RBP: ffffffffffffffff R08: ffffffffffffffff R09: 0000000000000000
[899688.160002] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8b59014720d8
[899688.160002] R13: ffff8b59014720c0 R14: ffff8b5901471090 R15: ffff8b5901470000
[899688.160002]  tracing_read_pipe+0x336/0x3c0
[899688.160002]  __vfs_read+0x26/0x140
[899688.160002]  vfs_read+0x87/0x130
[899688.160002]  SyS_read+0x42/0x90
[899688.160002]  do_syscall_64+0x74/0x160

It caught the process in the middle of trace_access_unlock(). There is
no loop. So, it must be looping in the caller tracing_read_pipe()
via the "waitagain" label.

Crashdump analyze uncovered that iter->seq was completely zeroed
at this point, including iter->seq.seq.size. It means that
print_trace_line() was never able to print anything and
there was no forward progress.

The culprit seems to be in the code:

	/* reset all but tr, trace, and overruns */
	memset(&iter->seq, 0,
	       sizeof(struct trace_iterator) -
	       offsetof(struct trace_iterator, seq));

It was added by the commit 53d0aa773053ab182877 ("ftrace:
add logic to record overruns"). It was v2.6.27-rc1.
It was the time when iter->seq looked like:

     struct trace_seq {
	unsigned char		buffer[PAGE_SIZE];
	unsigned int		len;
     };

There was no "size" variable and zeroing was perfectly fine.

The solution is to reinitialize the structure after or without
zeroing.

Link: http://lkml.kernel.org/r/20191011142134.11997-1-pmladek@suse.com

Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 04458ed44a557..a5e27f1c35a1f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6012,6 +6012,7 @@ waitagain:
 	       sizeof(struct trace_iterator) -
 	       offsetof(struct trace_iterator, seq));
 	cpumask_clear(iter->started);
+	trace_seq_init(&iter->seq);
 	iter->pos = -1;
 
 	trace_event_read_lock();
-- 
2.20.1



