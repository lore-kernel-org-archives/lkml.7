Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38B4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 19:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87C2218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 19:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="mIUMk6wt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfCNTD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 15:03:57 -0400
Received: from mail.efficios.com ([167.114.142.138]:49844 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbfCNTD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 15:03:57 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id AA1A41C3A23;
        Thu, 14 Mar 2019 15:03:55 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id CzaDl6CrjRQd; Thu, 14 Mar 2019 15:03:55 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 45EE61C3A20;
        Thu, 14 Mar 2019 15:03:55 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 45EE61C3A20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1552590235;
        bh=uEw3dH27D7+nHJf39R/jZ5umhLbfH+2HmbBuKjXqNfE=;
        h=From:To:Date:Message-Id;
        b=mIUMk6wtsUha6x06uyXjDDq99SdmpTyzpiHs+EApHBFHdp83mADt+v+LroEvCjAQa
         qX3AA/zF9E6m8WUC8C2jUYbFNf+anHE+9N6haKX/EXAEnLHUNfY1+W9HC6uJKMK4V4
         h4Z0vEpvTWVY1al+/wliINuGjyeg1urNO+R2jZVgXkmF5oA6Fm1o6M5/v21s8Yj3IM
         47R5LNSS7NLN57MCSPEBfbLzj0Sr7NH5LG2aRY82s1MYbUml1EmFDpo0n8yioDRu15
         MR8PGxfuBt1rVh/Fp1u6DP3tn/F0Tn+tZr+e2LCy4bmjbnqkGTNfS9J+5nKrQ/baB6
         onuvhSPDIQ18w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id Dt6emO0tf4w4; Thu, 14 Mar 2019 15:03:55 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id 99B791C3A1A;
        Thu, 14 Mar 2019 15:03:54 -0400 (EDT)
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
Subject: [RFC PATCH 0/2] rseq/selftests: debugger single-stepping helper sections
Date:   Thu, 14 Mar 2019 15:03:44 -0400
Message-Id: <20190314190346.24744-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Those RFC patches improves the rseq selftests to properly expose data
sections helping debuggers to step over rseq critical sections.

* Add a new __rseq_exit_point_array section describing all rseq critical
  section exit points so debuggers can properly step over those. This is
  based on discussions with gdb and DynamoRIO developers.

* The __rseq_table section contains structures that are aligned on 32
  bytes, and in some cases the entries may not be aligned with the
  beginning of the section. Rename this section to __rseq_cs, and create
  a new __rseq_cs_ptr_array section containing packed 64-bit pointers to
  those __rseq_cs entries.

Thanks,

Mathieu


Mathieu Desnoyers (2):
  rseq/selftests: Add __rseq_exit_point_array section for debuggers
  rseq/selftests: Introduce __rseq_cs_ptr_array, rename __rseq_table to
    __rseq_cs

 tools/testing/selftests/rseq/rseq-arm.h   |  80 +++++++++++++++++++----
 tools/testing/selftests/rseq/rseq-arm64.h |  57 +++++++++++++++-
 tools/testing/selftests/rseq/rseq-mips.h  |  81 +++++++++++++++++++----
 tools/testing/selftests/rseq/rseq-ppc.h   |  80 +++++++++++++++++++++--
 tools/testing/selftests/rseq/rseq-s390.h  |  65 +++++++++++++++++-
 tools/testing/selftests/rseq/rseq-x86.h   | 105 +++++++++++++++++++++++++++++-
 6 files changed, 435 insertions(+), 33 deletions(-)

-- 
2.11.0

