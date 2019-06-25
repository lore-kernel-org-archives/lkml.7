Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA27C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E7621655
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lbX+nfUY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbfFYIT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:19:27 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:38083 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbfFYIT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:19:26 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id dbdb242e;
        Tue, 25 Jun 2019 07:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=mail; bh=kWUoj9v28udE5r2/CX6Yv8zFmGA=; b=lbX+nfUY68VhyU7l7SWj
        h4Zk+WhxCCdSipInEXBLHKkhvxOfA5yfdfgCWRer3JnCwGRbddHN+TjC3CgQ1DLm
        N0Ud9O42zWdqqT2Rmt04eODF8tCql1lKou1ZJ4ETHR7yKhIbUJmf+1mkrr4bicpv
        N5TTi863JFYvw5i4RA8SFKVve4kl27FikdV52JCuDizDAbpiD2AfZQddfrTGukUj
        +Fdw1MI99ec3wFMtc6RULtyRklUtAchJUgH56zSe1GuD+GHRF2hFCLLM7l15yCN9
        p3O3IMdRzKuXc4VHNeG/fU9kfzgF06TTkdNeTIGl+H4KfwWH2asf2aBZfJkyhye1
        qQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c7df1692 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Tue, 25 Jun 2019 07:45:32 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/2] timekeeping: cleanup _fast_ variety of functions
Date:   Tue, 25 Jun 2019 10:19:10 +0200
Message-Id: <20190625081912.14813-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

When Arnd and I discussed this prior, he thought it best that I separate
these two commits out into a separate patchset, because they might
require additional discussion or consideration from you. They seem
straightforward enough to me, but if deliberations require me to make
some tweaks, I'm happy to do so.

Thanks,
Jason

Jason A. Donenfeld (2):
  timekeeping: add missing non-_ns functions for fast accessors
  timekeeping: rename fast getter functions to be consistent

 Documentation/core-api/timekeeping.rst | 15 ++++---
 Documentation/trace/ftrace.rst         |  2 +-
 drivers/base/power/runtime.c           | 12 +++---
 drivers/gpu/drm/i915/i915_perf.c       |  2 +-
 fs/pstore/platform.c                   |  2 +-
 include/linux/pm_runtime.h             |  2 +-
 include/linux/timekeeping.h            | 28 +++++++++++--
 kernel/bpf/helpers.c                   |  2 +-
 kernel/debug/kdb/kdb_main.c            |  2 +-
 kernel/events/core.c                   |  4 +-
 kernel/rcu/rcuperf.c                   |  6 +--
 kernel/rcu/srcutree.c                  |  6 +--
 kernel/time/timekeeping.c              | 56 +++++++++++++-------------
 kernel/trace/trace.c                   |  6 +--
 kernel/watchdog_hld.c                  |  2 +-
 15 files changed, 85 insertions(+), 62 deletions(-)

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>

-- 
2.21.0

