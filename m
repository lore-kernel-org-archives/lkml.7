Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB20CA9EAF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 07:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4802087E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 07:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572419357;
	bh=wu1a035odmEKhNaKNAU3jTqvdQ+vw9LIaPSIO4MjlKs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=SDOFbjw8FV7juXflEYJXz+DjdM7ak3Kz2Bzl/cO/hjUQNac9SKEG4L54cmMAsifL9
	 KtgFQR4WnE1ERmhyvk36AOef7AVoId0k+4p6cAwDPa2Drj2eSoefX7py3/n+7KxJNI
	 lICvbXcesBuu2KSdCsF4Tr92jAH6u3QpPsMH4hgU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfJ3HJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 03:09:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbfJ3HJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 03:09:15 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAC4120874;
        Wed, 30 Oct 2019 07:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572419355;
        bh=wu1a035odmEKhNaKNAU3jTqvdQ+vw9LIaPSIO4MjlKs=;
        h=From:To:Cc:Subject:Date:From;
        b=dPSH0DIx7R/GZ1BjIa217l081dXfFM30mVsX77gTLBU+Ga3hvk/whgEgtKOzAr3ZC
         y1fedqc24gxgKejkMZ7v2xe8RDs6ZvkrLAP0iRogolfTA6/S67Q3yLwXARRy8QaWpD
         IDg2vLYCkKVWCPtxScxuBT/jtC4yihC9Prf5V2AY=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH 0/4] perf probe: Fixes bugs in show-lines and show vars etc.
Date:   Wed, 30 Oct 2019 16:09:10 +0900
Message-Id: <157241935028.32002.10228194508152968737.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

Here are some more patches for fixing bugs which I found
while testing it.

 - [1/4]: I found that the debuginfo had precise line information
	but including non-statement and end-of-sequence entries.
	Those must be ignored because not represent target line.

 - [2/4]: I also found that there is GNU_call_site DIEs in debuginfo,
	which represents the location which calls another function.
	Since it is not an instance of inlined function, it must be
	ignored while searching instances of inlined function.

 - [3/4]: However, while listing up the available lines, we also need
	to show the lines calling another function. So if call_line and
	call_file attribute are same as line information, it shows that
	line as available.

 - [4/4]: It's a small fix to skip overlapped location while showing
	available variables.


Thank you,

---

Masami Hiramatsu (4):
      perf probe: Skip end-of-sequence and non statement lines
      perf probe: Filter out instances except for inlined subroutine and subprogram
      perf probe: Fix to show calling lines of inlined functions
      perf probe: Skip overlapped location on searching variables


 tools/perf/util/dwarf-aux.c    |   36 +++++++++++++++++++++++++++++-------
 tools/perf/util/probe-finder.c |   20 ++++++++++++++++++++
 2 files changed, 49 insertions(+), 7 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
