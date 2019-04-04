Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43016C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA702054F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369017;
	bh=CqeR2CI6/9xaSTcwyumMPxTrXsljIx0W6R1OwqHd2wM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sV2+NqvLP6a1EbKrdSVUYD1X4kyR0FVdpfVzTwQtR6pdLnl3xaxur5qs/YW3xPGP2
	 Jj5+Em1VVTvO+UDcd+ESxSV+Vi/GX4wGzR3tVUlvB3G+DE/gwz8wmWxwzNHhr9+JLr
	 itZjF6r4n0eWzQm+zE1g+3tOyWJsbgshLEB/6/uw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732986AbfDDJKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:10:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732970AbfDDJKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:10:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D50A32177E;
        Thu,  4 Apr 2019 09:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369012;
        bh=CqeR2CI6/9xaSTcwyumMPxTrXsljIx0W6R1OwqHd2wM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k8o4Yec1CgRBEOJCVnUsygUZZyOwtG4onLpuTKHhszcXZR95d++scguEcagdnw4t/
         GL5fVnduMha/ly+wSYnIKLzPrhYhUxAPnB8acebTMrKFuAO2nwK8roY0CUAI0anRB7
         9dmPsDqtnHKRfc1/ilyoriNq9t5EEc+s5kLhyxVs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 048/246] perf beauty msg_flags: Add missing %s lost when adding prefix suppression logic
Date:   Thu,  4 Apr 2019 10:45:48 +0200
Message-Id: <20190404084620.703993088@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c3b81a500f35241a4c16febe0a015e572cf2c492 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.19.1



