Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD8BC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709B8205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="iopUZFix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfCETsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 14:48:13 -0500
Received: from mail.efficios.com ([167.114.142.138]:37092 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfCETsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 14:48:12 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 08C9DA18A5;
        Tue,  5 Mar 2019 14:48:11 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 5rf_BzUP9J_O; Tue,  5 Mar 2019 14:48:10 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 8F348A189B;
        Tue,  5 Mar 2019 14:48:10 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 8F348A189B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1551815290;
        bh=h8JgVuqtJDZCISeHUaAnBhAinaxFH15HV2pE72yxU1k=;
        h=From:To:Date:Message-Id;
        b=iopUZFix+yC290I4xsH7bmszLkozrTInpgXPVSSWTdunwACzMVyetqyJBnYauFwYt
         SnJn/7+4WcXetGAq4oIqKg2GWV0sloZBNubauYrvy8mMlmKK48yUDbvUMAU5PDC5c/
         QFm7yHRG5xpfKGMNQrqS7RYQfMjQoHmMX9GXCMbIYwaG5ifE/+54vGrB4O/zHydAyV
         qs0GCghMRVQ4Eb9gOHg7c3JorEPhUW4fC7uQ0iefc+zH/616gVE1s4v4KY/Y2tCDw2
         B6wCK9miaUWtAEpFif3a4JpUD4oMBOKU+n5xJzlV8YSPalYSa52HlUCj1qQkS3LwFo
         25Zbd0P3AQLKQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id GYZeBtQNbNpF; Tue,  5 Mar 2019 14:48:10 -0500 (EST)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id 2AE72A1893;
        Tue,  5 Mar 2019 14:48:10 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH for 5.1 0/3] Restartable Sequences updates for 5.1
Date:   Tue,  5 Mar 2019 14:47:52 -0500
Message-Id: <20190305194755.2602-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those changes aiming at 5.1 include one comment cleanup, the removal of
the rseq_len field from the task struct which serves no purpose
considering that the struct size is fixed by the ABI, and a selftest
improvement adapting the number of threads to the number of detected
CPUs, which is nicer for smaller systems.

Thanks,

Mathieu

Mathieu Desnoyers (3):
  rseq: cleanup: Reflect removal of event counter in comments
  rseq: cleanup: remove rseq_len from task_struct
  rseq/selftests: Adapt number of threads to the number of detected cpus

 arch/arm/kernel/signal.c                       | 3 +--
 arch/x86/kernel/signal.c                       | 5 +----
 include/linux/sched.h                          | 4 ----
 kernel/rseq.c                                  | 9 +++------
 tools/testing/selftests/rseq/run_param_test.sh | 7 +++++--
 5 files changed, 10 insertions(+), 18 deletions(-)

-- 
2.11.0

