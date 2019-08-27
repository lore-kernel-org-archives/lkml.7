Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CE2C3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 378382080C
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566869832;
	bh=WewVrczqpbVIBj1hXAcPDCKMdOiFDQwGN7nsP+8+GlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i0N8mjH+OjbgpDkMsw4xzXpfVlqDAcR63SJtuKTvcRtjtabKm0Nkne1Ycc3Jq6dk4
	 A1/cEfEh7fS9yBdeZ0g2gQ54VzD12wQk909s6krhkF+KIpncDgnHupXwyFqScOwcn6
	 MUj3g0qHLXJ7PZ814qZbQsV54j/5mxJToWC1AgAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfH0BhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 21:37:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728810AbfH0BhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 21:37:08 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6333721848;
        Tue, 27 Aug 2019 01:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566869827;
        bh=WewVrczqpbVIBj1hXAcPDCKMdOiFDQwGN7nsP+8+GlQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lZjBRe6arRF1VuoRaPc4GJpjY08o7reaBWOC4/CfL4IyfzVknvGcvx3P5ymu83WPG
         37CBO4OE0qcUyecqbTmQ3BzEA1G8NPBv7IfcIJvvl9ZWxDvEAbUbJVhjnWIgwEacWH
         TzIhxiVwcCXRXm4+44ESvKgZi9M9O5KNBxV2aYMg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Benjamin Peterson <benjamin@python.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 08/33] perf trace beauty ioctl: Fix off-by-one error in cmd->string table
Date:   Mon, 26 Aug 2019 22:36:09 -0300
Message-Id: <20190827013634.3173-9-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190827013634.3173-1-acme@kernel.org>
References: <20190827013634.3173-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Peterson <benjamin@python.org>

While tracing a program that calls isatty(3), I noticed that strace
reported TCGETS for the request argument of the underlying ioctl(2)
syscall while perf trace reported TCSETS. strace is corrrect. The bug in
perf was due to the tty ioctl beauty table starting at 0x5400 rather
than 0x5401.

Committer testing:

  Using augmented_raw_syscalls.o and settings to make 'perf trace'
  use strace formatting, i.e. with this in ~/.perfconfig

  # cat ~/.perfconfig
  [trace]
	add_events = /home/acme/git/linux/tools/perf/examples/bpf/augmented_raw_syscalls.c
	show_zeros = yes
	show_duration = no
	no_inherit = yes
	show_timestamp = no
	show_arg_names = no
	args_alignment = 40
	show_prefix = yes

  # strace -e ioctl stty > /dev/null
  ioctl(0, TCGETS, {B38400 opost isig icanon echo ...}) = 0
  ioctl(1, TIOCGWINSZ, 0x7fff8a9b0860)    = -1 ENOTTY (Inappropriate ioctl for device)
  ioctl(1, TCGETS, 0x7fff8a9b0540)        = -1 ENOTTY (Inappropriate ioctl for device)
  +++ exited with 0 +++
  #

Before:

  # perf trace -e ioctl stty > /dev/null
  ioctl(0, TCSETS, 0x7fff2cf79f20)        = 0
  ioctl(1, TIOCSWINSZ, 0x7fff2cf79f40)    = -1 ENOTTY (Inappropriate ioctl for device)
  ioctl(1, TCSETS, 0x7fff2cf79c20)        = -1 ENOTTY (Inappropriate ioctl for device)
  #

After:

  # perf trace -e ioctl stty > /dev/null
  ioctl(0, TCGETS, 0x7ffed0763920)        = 0
  ioctl(1, TIOCGWINSZ, 0x7ffed0763940)    = -1 ENOTTY (Inappropriate ioctl for device)
  ioctl(1, TCGETS, 0x7ffed0763620)        = -1 ENOTTY (Inappropriate ioctl for device)
  #

Signed-off-by: Benjamin Peterson <benjamin@python.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 1cc47f2d46206d67285aea0ca7e8450af571da13 ("perf trace beauty ioctl: Improve 'cmd' beautifier")
Link: http://lkml.kernel.org/r/20190823033625.18814-1-benjamin@python.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/ioctl.c b/tools/perf/trace/beauty/ioctl.c
index 52242fa4072b..e19eb6ea361d 100644
--- a/tools/perf/trace/beauty/ioctl.c
+++ b/tools/perf/trace/beauty/ioctl.c
@@ -21,7 +21,7 @@
 static size_t ioctl__scnprintf_tty_cmd(int nr, int dir, char *bf, size_t size)
 {
 	static const char *ioctl_tty_cmd[] = {
-	"TCGETS", "TCSETS", "TCSETSW", "TCSETSF", "TCGETA", "TCSETA", "TCSETAW",
+	[_IOC_NR(TCGETS)] = "TCGETS", "TCSETS", "TCSETSW", "TCSETSF", "TCGETA", "TCSETA", "TCSETAW",
 	"TCSETAF", "TCSBRK", "TCXONC", "TCFLSH", "TIOCEXCL", "TIOCNXCL", "TIOCSCTTY",
 	"TIOCGPGRP", "TIOCSPGRP", "TIOCOUTQ", "TIOCSTI", "TIOCGWINSZ", "TIOCSWINSZ",
 	"TIOCMGET", "TIOCMBIS", "TIOCMBIC", "TIOCMSET", "TIOCGSOFTCAR", "TIOCSSOFTCAR",
-- 
2.21.0

