Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D5EC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 11:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F99208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 11:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574337550;
	bh=dMs8ol8f+wZrnFfGD030jmzuZV5c9X4hlWVt3fXaYKw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Zhfl3o4TWUoihQqICv25INuPLlttiIPJnYRCZMbFl9a8Z8Jt1j4MWYAZUJeqCeEaa
	 f5Wl0Zr2M1rCydqkUky8BxXDvy0pwzeymkqk2qNpjxJM6Ug2nLc7VStkjFRTIGM7gj
	 XrAR3iCiMc3118KcypcFMkn63si6l2naglAaI/Qs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfKUL7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 06:59:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:45330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfKUL7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 06:59:08 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48A7C20855;
        Thu, 21 Nov 2019 11:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574337547;
        bh=dMs8ol8f+wZrnFfGD030jmzuZV5c9X4hlWVt3fXaYKw=;
        h=From:To:Cc:Subject:Date:From;
        b=tiWuoNoJC6w/8PPspgtAuyC49vSWyiyIFEleScvcdqp8fuzstBLFedq/Q1StYO7zm
         3OJ1ZhMxUy3Nwp4g1s/w+trsEtdz6gJqiiu/B454sYMQK4E/n/2DSEmjkifnDNFaKh
         6BkYUUBJReF2K8Ra4HagZcnQ1eJ/G08Msc9wK8jM=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [RESEND PATCH v4 00/10] Rework REFCOUNT_FULL using atomic_fetch_* operations
Date:   Thu, 21 Nov 2019 11:58:52 +0000
Message-Id: <20191121115902.2551-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

This is a resend of version four of the patches I posted here:

  v4: https://lore.kernel.org/lkml/20191030143035.19440-1-will@kernel.org

Previous versions can be found at:

  v1: https://lkml.kernel.org/r/20190802101000.12958-1-will@kernel.org
  v2: https://lkml.kernel.org/r/20190827163204.29903-1-will@kernel.org
  v3: https://lkml.kernel.org/r/20191007154703.5574-1-will@kernel.org

I didn't receive any feedback last time around, other than some positive
noises from Kees, so please consider this for inclusion in mainline.

Thanks,

Will

Cc: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Hanjun Guo <guohanjun@huawei.com>

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
2.24.0.432.g9d3f5f5b63-goog

