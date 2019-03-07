Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD2CC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA7A2085A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551980756;
	bh=Ps99wA8nbvrEax99ttVzy/W597kJiSutr+4gDJnta6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D8I7qaTJXBT7l6q+TmKHf6ECIvdBL0/1jmCW9109cshGUG3L6J1C/RNic3WRx/8zm
	 RlR8YhLXewIGGgUDi0AtxFB6HBVvoSq5PIkw4PquKZnOThPXqbrhvI0PHHnczA05nA
	 HxHMPL0h/tYklI2lurvVwZUOvGTw6rwe1AR41ybc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfCGRpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:45:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:38024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbfCGRpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:45:53 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C10520661;
        Thu,  7 Mar 2019 17:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551980752;
        bh=Ps99wA8nbvrEax99ttVzy/W597kJiSutr+4gDJnta6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CsWPv3wVpHN/fgPYO82sw0x0hB321ccynmOwge0KGaSJ7+pUuga6KYTivsHdJLukx
         hIkC+Q+AQrHg+2QjQR8uqXPE7qOr2026jRlrunGkvOQCrdkM+cjZG7i93qkVf+OkEp
         uLDoWIUf67S8iTki1hw+KkhVDQSN8X2UCK60efNU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 16/35] perf beauty msg_flags: Add missing %s lost when adding prefix suppression logic
Date:   Thu,  7 Mar 2019 14:44:14 -0300
Message-Id: <20190307174433.28819-17-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307174433.28819-1-acme@kernel.org>
References: <20190307174433.28819-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When the prefix suppresion/enabling logic was added, I forgot to add an
extra %, which ended up chopping off the strings:

Before:

  # perf trace -e *mmsg --map-dump syscalls
  [299] = 1,
  [307] = 1,
  DNS Res~ver #3/14587 sendmmsg(106<socket:[3462393]>, 0x7f252b0fcaf0, 2, MSG_) = 2
  chronyd/1053 recvmmsg(4, 0x558542ca5740, 4, MSG_, NULL) = 1
  DNS Res~ver #2/14445 sendmmsg(106<socket:[3461475]>, 0x7f252ab09af0, 2, MSG_) = 2
  DNS Res~ver #2/14444 sendmmsg(146<socket:[3457863]>, 0x7f2521a7aaf0, 2, MSG_) = 2
  DNS Res~ver #2/14445 sendmmsg(106<socket:[3461475]>, 0x7f252ab09af0, 2, MSG_) = 2
  DNS Res~ver #3/14587 sendmmsg(148<socket:[3460636]>, 0x7f252b0fcaf0, 2, MSG_) = 2
  DNS Res~ver #2/14444 sendmmsg(146<socket:[3457863]>, 0x7f2521a7aaf0, 2, MSG_) = 2
  ^C#

After:

  # perf trace -e *mmsg --map-dump syscalls
  [299] = 1,
  [307] = 1,
  NetworkManager/17467 sendmmsg(22<socket:[3466493]>, 0x7f28927f9bb0, 2, MSG_NOSIGNAL) = 2
  pool/17478 sendmmsg(10<socket:[3466523]>, 0x7f2769f95e90, 2, MSG_NOSIGNAL) = 2
  DNS Res~ver #3/14587 sendmmsg(121<socket:[3466132]>, 0x7f252b0fcaf0, 2, MSG_NOSIGNAL) = 2
  chronyd/1053 recvmmsg(4, 0x558542ca5740, 4, MSG_DONTWAIT, NULL) = 1
  Socket Thread/17433 sendmmsg(121<socket:[3460903]>, 0x7f252668baf0, 2, MSG_NOSIGNAL) = 2
  ^C#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: c65c83ffe904 ("perf trace: Allow asking for not suppressing common string prefixes")
Link: https://lkml.kernel.org/n/tip-t2eu1rqx710k6jr4814mlzg7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/msg_flags.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/msg_flags.c b/tools/perf/trace/beauty/msg_flags.c
index d66c66315987..ea68db08b8e7 100644
--- a/tools/perf/trace/beauty/msg_flags.c
+++ b/tools/perf/trace/beauty/msg_flags.c
@@ -29,7 +29,7 @@ static size_t syscall_arg__scnprintf_msg_flags(char *bf, size_t size,
 		return scnprintf(bf, size, "NONE");
 #define	P_MSG_FLAG(n) \
 	if (flags & MSG_##n) { \
-		printed += scnprintf(bf + printed, size - printed, "%s%s", printed ? "|" : "", show_prefix ? prefix : "", #n); \
+		printed += scnprintf(bf + printed, size - printed, "%s%s%s", printed ? "|" : "", show_prefix ? prefix : "", #n); \
 		flags &= ~MSG_##n; \
 	}
 
-- 
2.20.1

