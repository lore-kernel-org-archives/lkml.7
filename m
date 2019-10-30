Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F44CCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F71821734
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572445845;
	bh=S5Tw7Z8qftyyZYiz2DVEWd/JEwXROqSdvVTEKK+A4Tw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=pBeJ/AU9nLLuSRYLLIxmxU7p1Oc4Qd3V9JLXUst5R+9vD/jJ2CsvJEpNy+FYViUYK
	 r8Ozbn0QXEf15Efcvmwdf0tm46Gvj5u+6uz/QeZzJdnZunlZWDMi5OVBHBz3xMn93L
	 3eN0URDf9kSONYKYqB/DdmMkSJYP6gtVyUktRmjo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfJ3Oao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 10:30:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfJ3Oan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:30:43 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8909A2087E;
        Wed, 30 Oct 2019 14:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572445843;
        bh=S5Tw7Z8qftyyZYiz2DVEWd/JEwXROqSdvVTEKK+A4Tw=;
        h=From:To:Cc:Subject:Date:From;
        b=ikVSX1Ldv+wRdChyKOspjMgvpcUguXBUqVvoG+TbQSOaU47YVqzrmhFRjaNgtuHB1
         jK1iAIlRWrBhCExn8WE/Ay95K7+cZpwHuhkFAZhLyd7zY9mKSUjGJ5ZzDKh1t2oFCO
         BJb90GygVSm06hpz3cgib+Uw/uG2DqE3o/bo9HSI=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: [PATCH v4 00/10] Rework REFCOUNT_FULL using atomic_fetch_* operations
Date:   Wed, 30 Oct 2019 14:30:25 +0000
Message-Id: <20191030143035.19440-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is version four of the patches I previously posted here:

  v1: https://lkml.kernel.org/r/20190802101000.12958-1-will@kernel.org
  v2: https://lkml.kernel.org/r/20190827163204.29903-1-will@kernel.org
  v3: https://lkml.kernel.org/r/20191007154703.5574-1-will@kernel.org

Changes since v3 include:

  - Add description of racy behaviour include/linux/refcount.h
  - Fix saturation behaviour in refcount_sub_and_test()
  - Added Acks and Tested-bys

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

Will Deacon (10):
  lib/refcount: Define constants for saturation and max refcount values
  lib/refcount: Ensure integer operands are treated as signed
  lib/refcount: Remove unused refcount_*_checked() variants
  lib/refcount: Move bulk of REFCOUNT_FULL implementation into header
  lib/refcount: Improve performance of generic REFCOUNT_FULL code
  lib/refcount: Move saturation warnings out of line
  lib/refcount: Consolidate REFCOUNT_{MAX,SATURATED} definitions
  refcount: Consolidate implementations of refcount_t
  lib/refcount: Remove unused 'refcount_error_report()' function
  drivers/lkdtm: Remove references to CONFIG_REFCOUNT_FULL

 arch/Kconfig                       |  21 ---
 arch/arm/Kconfig                   |   1 -
 arch/arm64/Kconfig                 |   1 -
 arch/s390/configs/debug_defconfig  |   1 -
 arch/x86/Kconfig                   |   1 -
 arch/x86/include/asm/asm.h         |   6 -
 arch/x86/include/asm/refcount.h    | 126 --------------
 arch/x86/mm/extable.c              |  49 ------
 drivers/gpu/drm/i915/Kconfig.debug |   1 -
 drivers/misc/lkdtm/refcount.c      |  11 +-
 include/linux/kernel.h             |   7 -
 include/linux/refcount.h           | 269 ++++++++++++++++++++++++-----
 kernel/panic.c                     |  11 --
 lib/refcount.c                     | 255 +++------------------------
 14 files changed, 257 insertions(+), 503 deletions(-)
 delete mode 100644 arch/x86/include/asm/refcount.h

-- 
2.24.0.rc0.303.g954a862665-goog

