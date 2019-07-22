Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D3DC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F1C21903
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563817317;
	bh=gyk/uNUCjw6HVImlT52nY3RTfy+IEFZ/OkfMZsNiwMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ONeQ1kxewETYvgiqujk+tC1s3EuhyfAoAM2QEFld4mTcb0G5mYo979z4AW7lFQrsx
	 6ZC5WdOrHLAMXkBNGJKYK2Rz86+vduQkRMF9faFknkousS5WW/xBI7fXhNr9njJhEj
	 ZEO1PDwdB+k7olRa7XAfGuob1BqagjAG18IOA8ZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731924AbfGVRl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:41:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728762AbfGVRlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:41:55 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F8C521901;
        Mon, 22 Jul 2019 17:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563817314;
        bh=gyk/uNUCjw6HVImlT52nY3RTfy+IEFZ/OkfMZsNiwMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AMZAhUxMIAx6EYFE9eZ8JXYqqvD4uXVEBg8e5qA0VkP3HP114JgGALMEQxQ892VFj
         XB+EeH4cTEoC+JzXN1Y3/sTsXrr8YLneNkMdkT3sFIMzqlAoe8WLBVoBhOrOyDhbAz
         2PuxxTttAGXLiv/lZWqmblF+/kH8mj2UbQmS1kOg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 26/37] perf trace beauty: Beautify bind's sockaddr arg
Date:   Mon, 22 Jul 2019 14:38:28 -0300
Message-Id: <20190722173839.22898-27-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722173839.22898-1-acme@kernel.org>
References: <20190722173839.22898-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.21.0

