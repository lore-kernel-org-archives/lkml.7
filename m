Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E648CA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 09:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F4D20856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 09:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571908353;
	bh=lDS+Iiks292xAR/BkIZdtQqFuWRD4PijXCpeCaa9LaI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=vPEVlorRrRDz/S4QvKBWv9AEqYm8TRxcsMO2/8p2x4MfRsPm+1pVW4WnKDY4Mq1bR
	 967S/C8VJZoUULDTG1pf85s9x7oXPSGksTtfEfy7Bn3N1WBbPaHg4x9mG4xBkX3dZ8
	 Q7QcfF/rbW/K/APybEs9R7mnyKL3bhDeOlOXLM5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389427AbfJXJMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 05:12:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727899AbfJXJMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 05:12:31 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2672D20856;
        Thu, 24 Oct 2019 09:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571908351;
        bh=lDS+Iiks292xAR/BkIZdtQqFuWRD4PijXCpeCaa9LaI=;
        h=From:To:Cc:Subject:Date:From;
        b=Oj7wylBfvXmuSQhN6loawNSkbvSIrFVx/fCDV6gxxZiukak3YeJVorfo/cRWnkyvu
         nWLQXIohJhe9v2YexiETFDBcevgaKeq8TTY6/OsPh6b1gNBHeKJa0SFqOlkZOedvi7
         DQnjwAh8s5t0JGbrc501Zdj2lNNGQI2hgUFgo9sY=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH 0/3] perf/probe: Fix available line bugs
Date:   Thu, 24 Oct 2019 18:12:27 +0900
Message-Id: <157190834681.1859.7399361844806238387.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some bugfixes related to showing available line (--line/-L)
option. I found that gcc generated some subprogram DIE with only
range attribute but no entry_pc or low_pc attributes.
In that case, perf probe failed to show the available lines in that
subprogram (function). To fix that, I introduced some bugfixes to
handle such cases correctly.

Thank you,

---

Masami Hiramatsu (3):
      perf/probe: Fix to find range-only function instance
      perf/probe: Walk function lines in lexical blocks
      perf/probe: Fix to show function entry line as probe-able


 tools/perf/util/dwarf-aux.c |   44 ++++++++++++++++++++++++++++++++++++-------
 tools/perf/util/dwarf-aux.h |    3 +++
 2 files changed, 40 insertions(+), 7 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
