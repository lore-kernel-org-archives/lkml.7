Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BE9C47E49
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 23:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E549820882
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 23:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbfJUXUB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 19:20:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38266 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730420AbfJUXS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 19:18:57 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMgwp-0003pV-IH; Tue, 22 Oct 2019 01:18:47 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CFFA41C0086;
        Tue, 22 Oct 2019 01:18:46 +0200 (CEST)
Date:   Mon, 21 Oct 2019 23:18:46 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf trace: Use strtoul for the fcntl 'cmd' argument
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-mob96wyzri4r3rvyigqfjv0a@git.kernel.org>
References: <tip-mob96wyzri4r3rvyigqfjv0a@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157169992630.29376.7406698007090638319.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     82c38338e0850a01057960efc94c6130f1a0fdde
Gitweb:        https://git.kernel.org/tip/82c38338e0850a01057960efc94c6130f1a0fdde
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 18 Oct 2019 15:44:42 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 19 Oct 2019 15:35:02 -03:00

perf trace: Use strtoul for the fcntl 'cmd' argument

Since its values are in two ranges of values we ended up codifying it
using a 'struct strarrays', so now hook it up with STUL_STRARRAYS so
that we can do:

  # perf trace -e syscalls:*enter_fcntl --filter=cmd==SETLK||cmd==SETLKW
     0.000 sssd_kcm/19021 syscalls:sys_enter_fcntl(fd: 13</var/lib/sss/secrets/secrets.ldb>, cmd: SETLK, arg: 0x7ffcf0a4dee0)
     1.523 sssd_kcm/19021 syscalls:sys_enter_fcntl(fd: 13</var/lib/sss/secrets/secrets.ldb>, cmd: SETLK, arg: 0x7ffcf0a4de90)
     1.629 sssd_kcm/19021 syscalls:sys_enter_fcntl(fd: 13</var/lib/sss/secrets/secrets.ldb>, cmd: SETLK, arg: 0x7ffcf0a4de90)
     2.711 sssd_kcm/19021 syscalls:sys_enter_fcntl(fd: 13</var/lib/sss/secrets/secrets.ldb>, cmd: SETLK, arg: 0x7ffcf0a4de70)
  ^C#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-mob96wyzri4r3rvyigqfjv0a@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 265ea87..72ef3b3 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -894,7 +894,8 @@ static struct syscall_fmt syscall_fmts[] = {
 	{ .name	    = "fchownat",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* fd */ }, }, },
 	{ .name	    = "fcntl",
-	  .arg = { [1] = { .scnprintf = SCA_FCNTL_CMD, /* cmd */
+	  .arg = { [1] = { .scnprintf = SCA_FCNTL_CMD,  /* cmd */
+			   .strtoul   = STUL_STRARRAYS,
 			   .parm      = &strarrays__fcntl_cmds_arrays,
 			   .show_zero = true, },
 		   [2] = { .scnprintf =  SCA_FCNTL_ARG, /* arg */ }, }, },
