Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6BCC3A5A1
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 03:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208B623406
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 03:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=python.org header.i=@python.org header.b="cgi9YwqS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404245AbfHWDq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 23:46:56 -0400
Received: from mail.python.org ([188.166.95.178]:57968 "EHLO mail.python.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732929AbfHWDqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 23:46:55 -0400
X-Greylist: delayed 621 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Aug 2019 23:46:54 EDT
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com [66.111.4.227])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.python.org (Postfix) with ESMTPSA id 46F6Wg5B4XzpBSW;
        Thu, 22 Aug 2019 23:36:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=python.org; s=200901;
        t=1566531392; bh=CDubURVQzkE9HS3aSBAwGhw/+EAk4NT202GmBHhNOwM=;
        h=From:To:Cc:Subject:Date:From;
        b=cgi9YwqS332lSKx2f8UKapWer/pUFkQQP7Jh38bFzQcvjm6Zmbqg+/S4y8ryxdeAJ
         s9JktrB861diA5jLBegINe8qqz0b9omWKSUlau9dEUQ/hdu5BX/J+peRVvSN9JmGWf
         Xxt/W77qm+MJm44qth9H0ok/gP7qy2BBsnYyXwdI=
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4AE0721C39;
        Thu, 22 Aug 2019 23:36:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 22 Aug 2019 23:36:30 -0400
X-ME-Sender: <xms:PV9fXUh18pKP3YfAfekO2PaHCXvlkWevDg8KGDxc5IZomgTmPGt21g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudegjedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuvghnjhgrmhhi
    nhcurfgvthgvrhhsohhnuceosggvnhhjrghmihhnsehphihthhhonhdrohhrgheqnecukf
    hppedujeegrddvudehrdehrdduudegnecurfgrrhgrmhepmhgrihhlfhhrohhmpegstghp
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqddvtdduieekfeefjedquddule
    eitdeiheefqdgsvghnjhgrmhhinheppehphihthhhonhdrohhrghesfhgrshhtmhgrihhl
    rdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:PV9fXXfuOij21U7HU5weVyPC87FpAVktpTpfd5vGIDBOSs7b5fFQ1w>
    <xmx:PV9fXcigMzy8wY1Dn3veMcHbQbxTBS88TNNVP0NZIMHpQgQNi8A0cA>
    <xmx:PV9fXXffF-E1mfxBjkjzBkDyeuXsoolaHEpoE3iPQAuKFW8lKnRg6g>
    <xmx:Pl9fXZFvRURQfJGHZ_Vzh9QOXxXajd2A5x6IGpiyLgpXxHvAI1z8UQ>
Received: from localhost.localdomain (114.sub-174-215-5.myvzw.com [174.215.5.114])
        by mail.messagingengine.com (Postfix) with ESMTPA id AC950D6005D;
        Thu, 22 Aug 2019 23:36:28 -0400 (EDT)
From:   Benjamin Peterson <benjamin@python.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] perf trace beauty ioctl: fix off-by-one error in table
Date:   Thu, 22 Aug 2019 20:36:25 -0700
Message-Id: <20190823033625.18814-1-benjamin@python.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While tracing a program that calls isatty(3), I noticed that strace reported
TCGETS for the request argument of the underlying ioctl(2) syscall while perf
trace reported TCSETS. strace is corrrect. The bug in perf was due to the tty
ioctl beauty table starting at 0x5400 rather than 0x5401.

Fixes: 1cc47f2d46206d67285aea0ca7e8450af571da13 ("perf trace beauty ioctl: Improve 'cmd' beautifier")
Signed-off-by: Benjamin Peterson <benjamin@python.org>
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
2.20.1

