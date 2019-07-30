Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62F0C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DFC208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="F/9ZL10J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbfG3SCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:02:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46165 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbfG3SCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:02:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UI2Nod3322121
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:02:23 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UI2Nod3322121
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564509743;
        bh=EsW3dmKtxM4mDO+IQ+ywUB3l0OsSKsaeqrOrc2g90FU=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=F/9ZL10JGvnKR8Fy1PBNF71psnbCIfa8qslfh28TcLrq4C677xrrr6M2x/90YRdZo
         9tXtADHNVqSgTGcB2ecWsm8Bilt/QKq84EnbVXcYN4/WC86gOxzKPFA6IttdGVyjtY
         QwqJbfeA0rNX4p7FHpEmxGpGeWdD6yV7y58SIOhNG5iMSOxvurCxmNcULfFXajeZPY
         ncezkpCigxoSgVfitmzWnOg16XBHAl+n/IAA+H1UCjCMuHc6JPT29waLma6bbMjpkZ
         VsGYKy+U3vEWtApoQ0UuUGzfYVLnIbEYY+4CK9yzGufL753J4qyQ284QTiUxDt9sDA
         uSgmBykkAjScg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UI2MTc3322118;
        Tue, 30 Jul 2019 11:02:22 -0700
Date:   Tue, 30 Jul 2019 11:02:22 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-m2hmxqrckxxw2ciki0tu889u@git.kernel.org>
Cc:     mingo@kernel.org, acme@redhat.com, hpa@zytor.com, jolsa@kernel.org,
        tglx@linutronix.de, adrian.hunter@intel.com, lclaudio@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org
Reply-To: tglx@linutronix.de, jolsa@kernel.org, mingo@kernel.org,
          hpa@zytor.com, acme@redhat.com, linux-kernel@vger.kernel.org,
          namhyung@kernel.org, lclaudio@redhat.com, adrian.hunter@intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace beauty: Beautify bind's sockaddr arg
Git-Commit-ID: 247dd65b909f1cd62a178febe3f6f8d5efdd7dd2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  247dd65b909f1cd62a178febe3f6f8d5efdd7dd2
Gitweb:     https://git.kernel.org/tip/247dd65b909f1cd62a178febe3f6f8d5efdd7dd2
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 16 Jul 2019 17:38:26 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:42 -0300

perf trace beauty: Beautify bind's sockaddr arg

By reusing the "connect" BPF collector.

Testing it system wide and stopping/starting sshd:

  # perf trace -e bind
  LLVM: dumping /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  DNS Res~er #18/15132 bind(243, { .family: PF_NETLINK }, 12)  = 0
  DNS Res~er #19/4833 bind(247, { .family: PF_NETLINK }, 12)  = 0
  DNS Res~er #19/4833 bind(238, { .family: PF_NETLINK }, 12)  = 0
  DNS Res~er #18/15132 bind(243, { .family: PF_NETLINK }, 12)  = 0
  DNS Res~er #18/10327 bind(258, { .family: PF_NETLINK }, 12)  = 0
  :6507/6507 bind(24, { .family: PF_NETLINK }, 12)   = 0
  DNS Res~er #19/4833 bind(238, { .family: PF_NETLINK }, 12)  = 0
  DNS Res~er #18/15132 bind(242, { .family: PF_NETLINK }, 12)  = 0
  sshd/6514 bind(3, { .family: PF_NETLINK }, 12)    = 0
  sshd/6514 bind(5, { .family: PF_INET, port: 22, addr: 0.0.0.0 }, 16) = 0
  sshd/6514 bind(7, { .family: PF_INET6, port: 22, addr: :: }, 28) = 0
  DNS Res~er #18/10327 bind(229, { .family: PF_NETLINK }, 12)  = 0
  DNS Res~er #18/15132 bind(231, { .family: PF_NETLINK }, 12)  = 0
  DNS Res~er #19/4833 bind(229, { .family: PF_NETLINK }, 12)  = 0
  ^C#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-m2hmxqrckxxw2ciki0tu889u@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 010aa9e9a561..d403b09812d1 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -710,8 +710,10 @@ static struct syscall_fmt {
 	  .arg = { [0] = { .scnprintf = SCA_X86_ARCH_PRCTL_CODE, /* code */ },
 		   [1] = { .scnprintf = SCA_PTR, /* arg2 */ }, }, },
 	{ .name	    = "bind",
+	  .bpf_prog_name = { .sys_enter = "!syscalls:sys_enter_connect", },
 	  .arg = { [0] = { .scnprintf = SCA_INT, /* fd */ },
-		   [1] = { .scnprintf = SCA_SOCKADDR, /* umyaddr */ }, }, },
+		   [1] = { .scnprintf = SCA_SOCKADDR, /* umyaddr */ },
+		   [2] = { .scnprintf = SCA_INT, /* addrlen */ }, }, },
 	{ .name	    = "bpf",
 	  .arg = { [0] = STRARRAY(cmd, bpf_cmd), }, },
 	{ .name	    = "brk",	    .hexret = true,
