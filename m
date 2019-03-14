Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D372C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24DD20693
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ucvx4teW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfCNM2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:28:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41815 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfCNM2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 08:28:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id d25so3716825pfn.8;
        Thu, 14 Mar 2019 05:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rcs1W5Jh624cN3abC6U54hsK7ZVCAgD4qFr+RxJnwoI=;
        b=ucvx4teWDRapdA2DUZ9Kz4dAnm0IXfdail/FxZyGhWkKFv/hVLISZlX+vY+nuWllhI
         b9PaU+lNzTXRc6Qh20CwP/7KuDl5KM6tjMril4hSlt4oAbNuzmWHyRWrKz2oO95Sgw/z
         RyytYaCLEqeWVfyl3opQ1ipR3jMLCHGVc9F8sgCqR5YiU4LNjs+eiMtw5mHy6+kTOxk+
         nRXm+idIXMMy3+qgd0mbu7BkO7x4vgGgSrc3SKWmrlMC89MoO0pq2XXFRVvY9/oooOIq
         7FHla0mHc5NkLEje6KRfobU129bgUmoSnloDvoZlaFraE/0SG8297uENCgWBovI0wTNS
         2T+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rcs1W5Jh624cN3abC6U54hsK7ZVCAgD4qFr+RxJnwoI=;
        b=nFoSKE5oHS0FYuiK3CS5LItnSRuqE/NGKNUkVZOEaudktCknxS3Mrs+ljBP+zZ0Qun
         IBcMEthYX0WdPfC+6xIKuwBKEDUl5qxHVOnpKXhrnnkzKHQIiyL3pCm3aSOI+cW9tHmG
         m0wfkWYoX9etx+upcpMANnxYDAiRwRxpN2BIcBcCkwRTi5HOGZJ5xPg6Qr79Tjy9F7VO
         uP30oaeJl/a2Ljlb9gZteAe9wdMDFzNuqQvwWf5wtjcGzk3NWfN2CH5/gfO2WhlRXb/o
         aEfS/+kw35rqGYTyOVkKzcbyqpC6QZsNfZkbYsSa4z8Y3gZDSVGYI0jDvA1DArka+Iym
         UgJg==
X-Gm-Message-State: APjAAAU9eHFQZAHPcqZXPr5DgGtcZ/O4VqEtRPcQvcYWbZ4qFOjFOmPE
        fOMxWw2H/ulCqDj4e5GUrVA=
X-Google-Smtp-Source: APXvYqzXssN3eikufA+LnFExGlKx7CTmGCdXPBFPF8edj/HXTe96DYLSwiUieK75lWipOj8ejMmh0w==
X-Received: by 2002:a17:902:8c84:: with SMTP id t4mr24716031plo.298.1552566531458;
        Thu, 14 Mar 2019 05:28:51 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a4:3974:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id m13sm30073685pff.175.2019.03.14.05.28.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 05:28:50 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com, bgolaszewski@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v10 00/10] Introduce the for_each_set_clump8 macro
Date:   Thu, 14 Mar 2019 21:29:32 +0900
Message-Id: <cover.1552566113.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v10:
  - Fix off-by-one error in bitmap initialization in the
    test_for_each_set_clump8 function
  - Fix typos in clump_exp array definition in test_bitmap.c ("0x28"
    should have been "0x38")
  - Utilize for_each_set_clump8 macro in intel_soc_dts_iosf.c

While adding GPIO get_multiple/set_multiple callback support for various
drivers, I noticed a pattern of looping manifesting that would be useful
standardized as a macro.

This patchset introduces the for_each_set_clump8 macro and utilizes it
in several GPIO drivers. The for_each_set_clump macro8 facilitates a
for-loop syntax that iterates over a memory region entire groups of set
bits at a time.

For example, suppose you would like to iterate over a 32-bit integer 8
bits at a time, skipping over 8-bit groups with no set bit, where
XXXXXXXX represents the current 8-bit group:

    Example:        10111110 00000000 11111111 00110011
    First loop:     10111110 00000000 11111111 XXXXXXXX
    Second loop:    10111110 00000000 XXXXXXXX 00110011
    Third loop:     XXXXXXXX 00000000 11111111 00110011

Each iteration of the loop returns the next 8-bit group that has at
least one set bit.

The for_each_set_clump8 macro has four parameters:

    * start: set to the bit offset of the current clump
    * clump: set to the current clump value
    * bits: bitmap to search within
    * size: bitmap size in number of bits

In this version of the patchset, the for_each_set_clump macro has been
reimplemented and simplified based on the suggestions provided by Rasmus
Villemoes and Andy Shevchenko in the version 4 submission.

In particular, the function of the for_each_set_clump macro has been
restricted to handle only 8-bit clumps; the drivers that use the
for_each_set_clump macro only handle 8-bit ports so a generic
for_each_set_clump implementation is not necessary. Thus, a solution for
large clumps (i.e. those larger than the width of a bitmap word) can be
postponed until a driver appears that actually requires such a generic
for_each_set_clump implementation.

For what it's worth, a semi-generic for_each_set_clump (i.e. for clumps
smaller than the width of a bitmap word) can be implemented by simply
replacing the hardcoded '8' and '0xFF' instances with respective
variables. I have not yet had a need for such an implementation, and
since it falls short of a true generic for_each_set_clump function, I
have decided to forgo such an implementation for now.

In addition, the bitmap_get_value8 and bitmap_set_value8 functions are
introduced to get and set 8-bit values respectively. Their use is based
on the behavior suggested in the patchset version 4 review.

William Breathitt Gray (10):
  bitops: Introduce the for_each_set_clump8 macro
  lib/test_bitmap.c: Add for_each_set_clump8 test cases
  gpio: 104-dio-48e: Utilize for_each_set_clump8 macro
  gpio: 104-idi-48: Utilize for_each_set_clump8 macro
  gpio: gpio-mm: Utilize for_each_set_clump8 macro
  gpio: ws16c48: Utilize for_each_set_clump8 macro
  gpio: pci-idio-16: Utilize for_each_set_clump8 macro
  gpio: pcie-idio-24: Utilize for_each_set_clump8 macro
  gpio: uniphier: Utilize for_each_set_clump8 macro
  thermal: intel: intel_soc_dts_iosf: Utilize for_each_set_clump8 macro

 drivers/gpio/gpio-104-dio-48e.c            |  73 ++++----------
 drivers/gpio/gpio-104-idi-48.c             |  37 ++-----
 drivers/gpio/gpio-gpio-mm.c                |  73 ++++----------
 drivers/gpio/gpio-pci-idio-16.c            |  75 ++++++--------
 drivers/gpio/gpio-pcie-idio-24.c           | 111 ++++++++-------------
 drivers/gpio/gpio-uniphier.c               |  16 ++-
 drivers/gpio/gpio-ws16c48.c                |  72 ++++---------
 drivers/thermal/intel/intel_soc_dts_iosf.c |  29 +++---
 drivers/thermal/intel/intel_soc_dts_iosf.h |   2 -
 include/asm-generic/bitops/find.h          |  14 +++
 include/linux/bitops.h                     |   5 +
 lib/find_bit.c                             |  81 +++++++++++++++
 lib/test_bitmap.c                          |  65 ++++++++++++
 13 files changed, 330 insertions(+), 323 deletions(-)

-- 
2.21.0

