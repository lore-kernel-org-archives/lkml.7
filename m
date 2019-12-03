Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E1BC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E54206E4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575388883;
	bh=jkBUQrSgUgGuYi2/x35a9RIQ6ObfXrVeYYv/CvzsuXU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=AHDKaLYnBc48DKyXjEaxtjnwmxeblwHuKaBABAoQbILJgRNbQtcbyR7pVkLJwiOsy
	 JRxdPgL/xyftNnewM78ThoCSKQsDD03cBXrjwowvZc1WvLCFIAQ+LpUITuhBw+AiIy
	 OcFzRNQ7TaAvC8WZuZbVk4KiWfRI3MkCuZT2a8Vg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfLCQBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 11:01:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:54022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfLCQBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 11:01:21 -0500
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 021322068E;
        Tue,  3 Dec 2019 16:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575388880;
        bh=jkBUQrSgUgGuYi2/x35a9RIQ6ObfXrVeYYv/CvzsuXU=;
        h=From:To:Cc:Subject:Date:From;
        b=y7DFqDxbcjFqmQ0XKsnTaUo3pAot11Na+FXL9eM/vNox2nuaXCqJV8FgTQRlNVzhV
         W5l0TunIaIZwEkIurI97Ca4B14WkvKW0TGRDNpoyChXdBUuMSZEpygbuX3a/HN0UUL
         rwvXMBfeH+VUFdqq01kWVOmQIhGpjpkyzWD7lMKk=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 0/2] sched: Spare IPI on single task renice
Date:   Tue,  3 Dec 2019 17:01:04 +0100
Message-Id: <20191203160106.18806-1-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of patches to avoid disturbing nohz_full CPUs when a single
fair task get its priority changed. I should probably check other sched
policies as well...

Frederic Weisbecker (2):
  sched: Spare resched IPI when prio changes on a single fair task
  sched: Use fair:prio_changed() instead of ad-hoc implementation

 kernel/sched/core.c | 16 ++++++++--------
 kernel/sched/fair.c |  2 ++
 2 files changed, 10 insertions(+), 8 deletions(-)

-- 
2.23.0

