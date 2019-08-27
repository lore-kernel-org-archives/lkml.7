Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C9EC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9981B21883
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566923552;
	bh=syeDJupZgVAE2WtUCwwh/CpX7PZCRSVKeOF42SJPq5o=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=hWTyDnzhQfWwRPoQAPb3mmgPHtAvufgP1XBWNmWVlqRrCA1ssCF+9YZ9Fm7V3Fd5x
	 /4xU1B526h/46s74uiZzE5lfpFMgvdOPcvHtSUy+URXKfpGmHw1Dis8SaLrr5KrD3L
	 9/ogouMnO7qFQmSZzbhrFCEmiDg1iHaLJ962to04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbfH0Qcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 12:32:31 -0400
Received: from foss.arm.com ([217.140.110.172]:47544 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbfH0Qcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:32:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CE42337;
        Tue, 27 Aug 2019 09:32:30 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 51CAB3F59C;
        Tue, 27 Aug 2019 09:32:29 -0700 (PDT)
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: [PATCH v2 0/6] Rework REFCOUNT_FULL using atomic_fetch_* operations
Date:   Tue, 27 Aug 2019 17:31:58 +0100
Message-Id: <20190827163204.29903-1-will@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is version two of the patches I previously posted here:

  https://lkml.kernel.org/r/20190802101000.12958-1-will@kernel.org

Changes since v1 include:

  * Avoid duplicate WARNs when incrementing from zero
  * Some crude lktdm perf results to motivate the change:

    # perf stat -r 3 -B -- echo {ATOMIC,REFCOUNT}_TIMING >/sys/kernel/debug/provoke-crash/DIRECT

    # arm64
    ATOMIC_TIMING:					46.50451 +- 0.00134 seconds time elapsed  ( +-  0.00% )
    REFCOUNT_TIMING (REFCOUNT_FULL, mainline):		77.57522 +- 0.00982 seconds time elapsed  ( +-  0.01% )
    REFCOUNT_TIMING (REFCOUNT_FULL, this series):	48.7181 +- 0.0256 seconds time elapsed  ( +-  0.05% )

    # x86
    ATOMIC_TIMING:					31.6225 +- 0.0776 seconds time elapsed  ( +-  0.25% )
    REFCOUNT_TIMING (!REFCOUNT_FULL, mainline/x86 asm): 31.6689 +- 0.0901 seconds time elapsed  ( +-  0.28% )
    REFCOUNT_TIMING (REFCOUNT_FULL, mainline):		53.203 +- 0.138 seconds time elapsed  ( +-  0.26% )
    REFCOUNT_TIMING (REFCOUNT_FULL, this series):	31.7408 +- 0.0486 seconds time elapsed  ( +-  0.15% )

Cheers,

Will

Cc: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Jan Glauber <jglauber@marvell.com>

--->8

Will Deacon (6):
  lib/refcount: Define constants for saturation and max refcount values
  lib/refcount: Ensure integer operands are treated as signed
  lib/refcount: Remove unused refcount_*_checked() variants
  lib/refcount: Move bulk of REFCOUNT_FULL implementation into header
  lib/refcount: Improve performance of generic REFCOUNT_FULL code
  lib/refcount: Consolidate REFCOUNT_{MAX,SATURATED} definitions

 drivers/misc/lkdtm/refcount.c |   8 --
 include/linux/refcount.h      | 236 +++++++++++++++++++++++++++++++++++++----
 lib/refcount.c                | 237 +-----------------------------------------
 3 files changed, 218 insertions(+), 263 deletions(-)

-- 
2.11.0

