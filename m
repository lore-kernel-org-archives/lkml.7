Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85983C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD7C222CF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570119480;
	bh=FERkCSeCrTfeA7B2Qv/31CeQdyCYPtev+CqxmGRT/hQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=qcTQAoA+1H+yeEFt3d+do7zaABSEjzAkLsIYXY2j8QLVUUd+cnxHYZAU2tuh6Irfy
	 kdkMTDUapEdQbYJk7dlgeeURddMWtJLXFvY+hZBz0I8vh/2vEWCP4KmGny2CT/pky7
	 zBMdUVBIBM0pSiqbAjBVyWDrfQbInqW0/ziQFF/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732978AbfJCQR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:17:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389349AbfJCQRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:17:54 -0400
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11C6A215EA;
        Thu,  3 Oct 2019 16:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119473;
        bh=FERkCSeCrTfeA7B2Qv/31CeQdyCYPtev+CqxmGRT/hQ=;
        h=From:To:Cc:Subject:Date:From;
        b=l/z3fhRPTCw2Y7dHHmkDZx8PVF2MLMwofuA1vBfi5IjMaa+vFG+JtkBCCAL8f6If8
         eayCiWI4iyKiyr85gyQ3RKeATIZJ8RutysJUziJGRfuqAwdouYnB6ZByk0xPhd/C4+
         frbm2d4k57p/VfRX4JvUg/0+ZqgagDUuDzLNwE/k=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Rik van Riel <riel@redhat.com>
Subject: [PATCH 0/2] vtime: Remove pair of seqcount on context switch
Date:   Thu,  3 Oct 2019 18:17:43 +0200
Message-Id: <20191003161745.28464-1-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extracted from a larger queue that fixes kcpustat on nohz_full, these
two patches have value on their own as they remove two write barriers
on nohz_full context switch.

Frederic Weisbecker (2):
  vtime: Rename vtime_account_system() to vtime_account_kernel()
  vtime: Spare a seqcount lock/unlock cycle on context switch

 arch/ia64/kernel/time.c          |  4 +--
 arch/powerpc/kernel/time.c       |  6 ++--
 arch/s390/kernel/vtime.c         |  4 +--
 include/linux/context_tracking.h |  4 +--
 include/linux/vtime.h            | 38 ++++++++++++------------
 kernel/sched/cputime.c           | 50 ++++++++++++++++++--------------
 6 files changed, 57 insertions(+), 49 deletions(-)

-- 
2.23.0

