Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DEFCA9EC9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 00:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFDF20650
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 00:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572913005;
	bh=9A1+8VaBCnwBvQdNduflqLMV3Wm1Bv5ZlP+d15INK7M=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=k7lMpiXEXDJH7XhvNFPBo8IZNwhqAoTrro6qeq0ZCJvpPRkCOUzgwk5VlqCOv82JE
	 LJYD82TIxvyRskULDM2Rav77vWV39UkEVWz3mQf7E902kCblr3EpqSKc6M5Xd7OK5b
	 BJ8cyJ4cTOD6P4cmp4B5lihDVgQlOK3HnOsbb67U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387535AbfKEAQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 19:16:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:41266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387415AbfKEAQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 19:16:44 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93C7D206DF;
        Tue,  5 Nov 2019 00:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572913003;
        bh=9A1+8VaBCnwBvQdNduflqLMV3Wm1Bv5ZlP+d15INK7M=;
        h=From:To:Cc:Subject:Date:From;
        b=TxcGcDv7fRNRDV0NVFxuF6ZuisIjLfNvTT9dt+gahfUA0x3QqxYyXE1AOhvLSOOFX
         BKxIWEXYU8mJ37jCTbHd5tVmigMAyV49GptmAztRhX7dkwKYnNi2UctBAiMXtYVFUB
         PWvpNEkkhmtKdzCMWbujnFLE+kzUu2ybHC2mjpvc=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 0/5] perf/probe: Support multiprobe and immediates
Date:   Tue,  5 Nov 2019 09:16:38 +0900
Message-Id: <157291299825.19771.5190465639558208592.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds multiprobe support on perf probe command.

This can be applied on top of my previous (sent last week)
bugfix series,

https://lkml.kernel.org/r/157241935028.32002.10228194508152968737.stgit@devnote2

Inlined functions or the lines which have multiple statements can
be compiled in multiple addresses. Current perf probe generates
different events for each address, but this is not useful for
users.

Since ftrace multiprobe per event support is on ftrace/for-next,
it is a time to push this series. To support multi-probe, this
adds below 4 patches + 1 minor fix.

 - Fix a rare case bug for missing scope-DIE in some inlined
   functions.
 - Modify the naming scheme of probe event to Line number based
   instead of function name based.
 - Add multi-probe support on perf probe. This also converts
   different register assignment on local variables for each
   probe point.
 - Add const value attribute support. It is possible that the
   compiler assigns a constant value for optimized function
   parameter or local variables. This handles such case.
 - Introduce a magic number assignment to non-exist local variable.
   Inlined functions can be embedded (inlined) in caller function
   and the parameter or local vars in such inlined function can be
   optimized out some place, but in some place we still can see
   those vars. For supporting multiprobe correctly, we need to
   fill out some value even if we can not find the given local vars.
   So this fills it with "0xdeade12d(dead end)" magic number.


Thank you,

---

Masami Hiramatsu (5):
      perf probe: Return a better scope DIE if there is no best scope
      perf probe: Generate event name with line number
      perf probe: Support multiprobe event
      perf probe: Support DW_AT_const_value constant value
      perf probe: Trace a magic number if variable is not found


 tools/perf/util/probe-event.c  |   19 +++++++-
 tools/perf/util/probe-event.h  |    3 +
 tools/perf/util/probe-file.c   |   14 ++++++
 tools/perf/util/probe-file.h   |    2 +
 tools/perf/util/probe-finder.c |   90 ++++++++++++++++++++++++++++++++++++++--
 tools/perf/util/probe-finder.h |    1 
 6 files changed, 121 insertions(+), 8 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
