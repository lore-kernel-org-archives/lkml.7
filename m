Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BAACA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 09:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAEFD206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 09:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572080425;
	bh=lO8q1HD5nmiBCQj/9Imv1qUDSkBXLeaceV8L1xWBX7I=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=YGQIPmjU/mIeE1DbQp5V8k/svFbcx8kURubELyKiMKJ/shtBYqML3yWeUkprL5DDs
	 krHbezZGYI86g/SGevho/2DZxpL0mQPdcB4An7mx0Cso0SuLW9Y5y6IS5DNRecg3nJ
	 XFS7/VUQC75IH/FDyhCr2rcuzhCg6Yj5bOpXu0Yk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfJZJAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 05:00:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfJZJAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 05:00:23 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94660206DD;
        Sat, 26 Oct 2019 09:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572080422;
        bh=lO8q1HD5nmiBCQj/9Imv1qUDSkBXLeaceV8L1xWBX7I=;
        h=From:To:Cc:Subject:Date:From;
        b=gQ8beHjWKAL0ilPCJ+JpncbfcKER4Ct4Q3345VG8FKVa1QOe816gxPoo2VKpVO7oM
         +NglN9yrCMUHwnVzylCWS70Zcvcq76dtXfG5cvAZPuRIk946lLL7Z2Jek+p4LxNA62
         vjrLbqpzu40DFPXYGsHfVPr/ylP/PvjprD0/VmTY=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH V2 0/6] perf/probe: Additional fixes for range only functions
Date:   Sat, 26 Oct 2019 18:00:19 +0900
Message-Id: <157208041894.16551.2733647209130045685.stgit@devnote2>
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

I've updated examples in patch description in this v2.
No changes in the code itself. I ran it on Ubuntu 19.04
(linux-5.0.0-32-generic).

Please replace previous one with this.

Thank you,

---

Masami Hiramatsu (6):
      perf/probe: Fix wrong address verification
      perf/probe: Fix to probe a function which has no entry pc
      perf/probe: Fix to probe an inline function which has no entry pc
      perf/probe: Fix to list probe event with correct line number
      perf/probe: Fix to show inlined function callsite without entry_pc
      perf/probe: Fix to show ranges of variables in functions without entry_pc


 tools/perf/util/dwarf-aux.c    |    6 +++---
 tools/perf/util/probe-finder.c |   40 ++++++++++++++--------------------------
 2 files changed, 17 insertions(+), 29 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
