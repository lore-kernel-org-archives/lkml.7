Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED641C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7DA217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553709816;
	bh=8Hux6TbSRnoEgQ9f+YXXsBoJwgZklORkaD1SDS0Dcbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2pIa0abvOQQ/oPXjHjL0Ye9WxW5sC+gNPPwVsv4Z1tFKLLPZTRDungyu6jl+RtMua
	 3UBWnab1JNvrw41pjPWd89aAqf2uItLrwR8w0uRL/ueTXLmnJ35S28rwLutapp6ad6
	 XC9y+PJP297ARmZDGJa6gCLs/BjAVVYUvoCu+0tg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732609AbfC0SDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:03:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732545AbfC0SDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:03:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6070321734;
        Wed, 27 Mar 2019 18:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709812;
        bh=8Hux6TbSRnoEgQ9f+YXXsBoJwgZklORkaD1SDS0Dcbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WcjcU8E0P8OQwCCuWuw4ZpzQnthLOjVSBJt5DkyYtTMh6/Yq/EEnL6ISg2wUwV22L
         jrjNARKuTWYsLj+cDDl1btQ7ifTMG7/ONHOOZeobHRiTZj7lAQ/Crh2oZ04pBU23Bj
         dJWVXz/lpYdAKJB0FTOmZUHqZm11RLyOsLP/+cxc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 052/262] perf beauty msg_flags: Add missing %s lost when adding prefix suppression logic
Date:   Wed, 27 Mar 2019 13:58:27 -0400
Message-Id: <20190327180158.10245-52-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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

