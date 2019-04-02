Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49414C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F7120856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554220974;
	bh=MDDT/wYnA7bV3zOilWOFj0myGxKMnx93Xh3xsRdJ8vw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=dXtjLXKOX01yAMSS8OX3UDn7qR0jyT4zVnv+Q9ag+hy0C+uWWgLErbfHUnCGTdc07
	 /UeP2Hst0XeItca6W5o9314RglvWMkuXr01M3V5LaQNeA2ELX8RGrbucOTXeNY6QMJ
	 ne5VGyHUHNc9fShm9Kd86BhY1R1I55WG4xVTukN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbfDBQCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:02:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729060AbfDBQCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:02:52 -0400
Received: from lenoir.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDA282082C;
        Tue,  2 Apr 2019 16:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554220971;
        bh=MDDT/wYnA7bV3zOilWOFj0myGxKMnx93Xh3xsRdJ8vw=;
        h=From:To:Cc:Subject:Date:From;
        b=MfAlFM2Rv+3hG6U0ni8960y6s3xow85DQf3KIiGYf4J3SC81kXvvA+n4lRpHsDdmJ
         SMkb5VofvdqyhwH/zdQpQQgXqXj3fy1yvjWFC6YfAFphA+qMYrQ5tqXu1hbrAMXwgr
         xX28/vo2cCDwsUvosYsx76sJfHNDjetVa2CLiXrU=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/4] lockdep cleanups and optimizations.
Date:   Tue,  2 Apr 2019 18:02:40 +0200
Message-Id: <20190402160244.32434-1-frederic@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are lockdep bits that got accumulated in my softirq queue but
are independant.

Patches 1 and 2 are cleanups. 3 and 4 are IRQ locking validation
optimization.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	lockdep/core

HEAD: dd2ea3a0bffdc3e140dd4af085bae7f9f9a08d6d

Thanks,
	Frederic
---

Frederic Weisbecker (4):
      locking/lockdep: Move valid_state() inside CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING
      locking/lockdep: Map remaining magic numbers to lock usage mask names
      locking/lockdep: Use expanded masks on find_usage_*() functions
      locking/lockdep: Test all incompatible scenario at once in check_irq_usage()


 kernel/locking/lockdep.c           | 249 ++++++++++++++++++++++++-------------
 kernel/locking/lockdep_internals.h |   6 +
 2 files changed, 172 insertions(+), 83 deletions(-)
