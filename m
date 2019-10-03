Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D354CC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D4220830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570123198;
	bh=C6bM2lkrmxaRi+8ngCo47RBCDNww5tM1dx0eSaBFFeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rIYQ1qEDAwWxpiFzAujP6mr9HUsrbnJ7MB+eTSaPXGpoJ6AK5oA+7E3T0WVNa1MJm
	 aYQscBpaekzQsEhOpRQ8N1PiZcP+lKA0Lf8Cdwu3mnqjzF/PkR5Iuqz8pLeNL2tAIg
	 HMslzt4c4BLmglJJwzFbsAeucjso6U4xrFZBt+BQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388235AbfJCQTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:19:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388158AbfJCQTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:19:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D882E215EA;
        Thu,  3 Oct 2019 16:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119544;
        bh=C6bM2lkrmxaRi+8ngCo47RBCDNww5tM1dx0eSaBFFeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YhEcVcmVOcI/tbmI7X1Tk9G0lStUysjAhdqddK4qnQgMlO9pdalaQW3SldidJcMUZ
         ljLdvoQQQn694XCzUwrfvJNCSyUPdcHAE7KZuK0grfPqOt9kPqjommFjIUOK5/aLEO
         /+H6nUgqpmrMs0bB46f/TRqwyEuibozGA/7zTRnE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Benjamin Peterson <benjamin@python.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 103/211] perf trace beauty ioctl: Fix off-by-one error in cmd->string table
Date:   Thu,  3 Oct 2019 17:52:49 +0200
Message-Id: <20191003154510.188106056@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154447.010950442@linuxfoundation.org>
References: <20191003154447.010950442@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Peterson <benjamin@python.org>

[ Upstream commit b92675f4a9c02dd78052645597dac9e270679ddf ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/trace/beauty/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/ioctl.c b/tools/perf/trace/beauty/ioctl.c
index 1be3b4cf08270..82346ca06f171 100644
--- a/tools/perf/trace/beauty/ioctl.c
+++ b/tools/perf/trace/beauty/ioctl.c
@@ -22,7 +22,7 @@
 static size_t ioctl__scnprintf_tty_cmd(int nr, int dir, char *bf, size_t size)
 {
 	static const char *ioctl_tty_cmd[] = {
-	"TCGETS", "TCSETS", "TCSETSW", "TCSETSF", "TCGETA", "TCSETA", "TCSETAW",
+	[_IOC_NR(TCGETS)] = "TCGETS", "TCSETS", "TCSETSW", "TCSETSF", "TCGETA", "TCSETA", "TCSETAW",
 	"TCSETAF", "TCSBRK", "TCXONC", "TCFLSH", "TIOCEXCL", "TIOCNXCL", "TIOCSCTTY",
 	"TIOCGPGRP", "TIOCSPGRP", "TIOCOUTQ", "TIOCSTI", "TIOCGWINSZ", "TIOCSWINSZ",
 	"TIOCMGET", "TIOCMBIS", "TIOCMBIC", "TIOCMSET", "TIOCGSOFTCAR", "TIOCSSOFTCAR",
-- 
2.20.1



