Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C721BC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC822073A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574064707;
	bh=4+uT/URtHmAzVIJt/qrw/F10B2ZhX5Gsk0xCOlfou9k=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=j4lnVRQ4r5ZuoAUyZvi+2eE4AHeLQSr9RzPoJZeJRj4+IyzpiT3FYyxwtJ9cChxhS
	 AnPcNeLmTLO+JuoQABxbhbRgOjv2enp0Wm14LVe+Deg+gaE4pzuq5ucQGYvm9Sh1B4
	 wH1oNrbI2ZI9XnDmhUuL29/bX9L8JVV9zq27Wlvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfKRILq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 03:11:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:47526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbfKRILq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 03:11:46 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C6162068E;
        Mon, 18 Nov 2019 08:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574064705;
        bh=4+uT/URtHmAzVIJt/qrw/F10B2ZhX5Gsk0xCOlfou9k=;
        h=From:To:Cc:Subject:Date:From;
        b=JICocKpn5CiaU+WA4h7d9HgNluj5JuEubsVnNBYWKP7t7+KURdA16I35w4zPzSyHe
         ypOox0bJ2qpIfHZMenbBq3mkvt5jXBHT3QU/4jAQYm9kJjpBt+eNFJMxdUtHcJ9GQw
         1SnX4Rg3ifqpu5cnWLeVhrRUYtovLrRs3ve/hyag=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v3 0/7] perf/probe: Support multiprobe and immediates with fixes
Date:   Mon, 18 Nov 2019 17:11:40 +0900
Message-Id: <157406469983.24476.13195800716161845227.stgit@devnote2>
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

This is the 3rd version of the multiprobe support on perf probe
including some fixes about "representive lines"

The previous thread is here:

https://lkml.kernel.org/r/157314406866.4063.16995747442215702109.stgit@devnote2

On the previous thread, we discussed some issues about incorrect line
information shown by perf probe. I finally fixed those by introducing
an idea of "representive line" -- a line which has a unique address
(no other lines shares the same address) or a line which has the least
line number among lines sharing same address. Now perf probe only shows
such representive lines can be probed([1/7][3/7]), and if user tries to
probe other non representive lines, it shows which line user should
probe ([2/7]). The rest of patches in the series are same as v2 (except
for [4/7], example output is updated)

This can be applied on top of perf/core.

Thank you,

---

Masami Hiramatsu (7):
      perf probe: Show correct statement line number by perf probe -l
      perf probe: Verify given line is a representive line
      perf probe: Do not show non representive lines by perf-probe -L
      perf probe: Generate event name with line number
      perf probe: Support multiprobe event
      perf probe: Support DW_AT_const_value constant value
      perf probe: Trace a magic number if variable is not found


 tools/perf/util/dwarf-aux.c    |   62 ++++++++++++++++++++-
 tools/perf/util/probe-event.c  |   19 ++++++-
 tools/perf/util/probe-event.h  |    3 +
 tools/perf/util/probe-file.c   |   14 +++++
 tools/perf/util/probe-file.h   |    2 +
 tools/perf/util/probe-finder.c |  116 +++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/probe-finder.h |    1 
 7 files changed, 206 insertions(+), 11 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
