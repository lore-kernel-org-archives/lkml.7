Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDC8CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2705A2166E
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571665301;
	bh=h4roeVQopNAXQ1lzdZzA1DoqFjzUcHThkuLMm0te9DA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QO/9rQDQAxkuxxNKVS3kja1liIwTC66323WFsPThWf9fi6zSqNAamqTRIrlWUZ+/p
	 7nGa/G535LmUpxI32QFaSB1RB/9T8oMQdAEofsioDzZFMVFSvJ2/tZtXm8LAGAu8Af
	 JPkr9KWkYCSq3BYDp2CL1vRHk2LwKK2iB9wP1V+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbfJUNlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:41:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729719AbfJUNlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:41:37 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3908214AE;
        Mon, 21 Oct 2019 13:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665296;
        bh=h4roeVQopNAXQ1lzdZzA1DoqFjzUcHThkuLMm0te9DA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uxFaR9ZPe1PmZe2RhsPYpCHyZzRDsTqS95rg4s51g3fgJq5PnuaAoLARQrC+C572N
         YCCCojs3cXkv/faUNbFJ6U/aX59zUi9tjTxdJY0fuQqPo6+f4HXPHm2tZ6rxjXmUkV
         L1CpbJROAk6qwK5jNHYk5HW+g6ARGBgJKNmNpakY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 53/57] perf trace: Use strtoul for the fcntl 'cmd' argument
Date:   Mon, 21 Oct 2019 10:38:30 -0300
Message-Id: <20191021133834.25998-54-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
index 265ea876f00b..72ef3b395504 100644
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
-- 
2.21.0

