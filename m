Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1DAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1642D20811
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmvlKSmU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbfCYGVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 02:21:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39972 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729568AbfCYGVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 02:21:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id u9so5741469pgo.7;
        Sun, 24 Mar 2019 23:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VZA1AZswyx/+wZFoZFplEQGVijJC6Vlo9vlJ16dUfdw=;
        b=DmvlKSmUTcMrBrvSpkNYWKnL4gBGpDWKwwOnj4bASFnlNgyTEoUQO/fst7FrcmPocB
         bV/+oufq7crPAjkZ8F+s/cWgBH2K6R/SLil/0ENIblyNLbfAEDEEGVY3AuZBfUZIf6fx
         qwfOBDzFiZDKtn89fWoPzRDkZNbCIB002RZf1A/UBOz244+PHZqoaTjBAu8VYAZeGzmN
         eqHRJzbTsSPR0+kjExrv9mW6sc+pAHNKnygWhyJ7SWtzDMHOWUKfybZtx+A1dAXBXDh7
         5LLp/VPHf+7CPJPfKTgf/mkYx+0z9TOhwSZz9YFMBR+PvDtRJNNTSMGlfsdz9dHeZQEo
         c9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VZA1AZswyx/+wZFoZFplEQGVijJC6Vlo9vlJ16dUfdw=;
        b=GgTa4MMUFhWADvGzLlGzjhGhr34fJ+2x/og51K5rTj3WmpP1Q2K8FGUDYQpdNhM/Pj
         OpHqWYCbHoJw4Sjb9WV/lT+16Vd54iG2eXmlEOi5o7bwtH/oyxWjevegNoLKPMM+emB4
         E0yERV9VZwi+ymR1PVfBF5//aVRACdbAJmdiyPYdaJCcibq9U/95n1TZATwwztXnlbKf
         JfrLJQZdIe9PnCRsa7rptVWKyvWSHLyQt/LO+eu64X3dkO23RkGSw8zSLZZjoPesX4oV
         j9hrfnzf0ayeAwNCicDvNd4clGdQiY494zQfl2Gl3y8r/WNWZ+vfgjXTzAgiCfFGE3x5
         gLaA==
X-Gm-Message-State: APjAAAVMmoObLj2VJXIaRlKm6O2P5AHDh5Nx8GQ8ALSBmnPxcKzGvdBN
        UyOJf63oa4HeLHA9byKcwhh3NQNX
X-Google-Smtp-Source: APXvYqwxlqnel+mfaGuoAogvMouTlmbxaIih05IIEsz4W3ijq/UUXCgDDOWTv+rH7BP3KpNaoof19A==
X-Received: by 2002:a63:5854:: with SMTP id i20mr12338464pgm.171.1553494869493;
        Sun, 24 Mar 2019 23:21:09 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:e068:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id x13sm16580197pgr.87.2019.03.24.23.21.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 23:21:08 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v12 00/11] Introduce the for_each_set_clump8 macro
Date:   Mon, 25 Mar 2019 15:20:44 +0900
Message-Id: <cover.1553494625.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v12:
  - Rebase changes (bitmap_set_value8 definition change in wrong commit)

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

William Breathitt Gray (11):
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
  gpio: 74x164: Utilize the for_each_set_clump8 macro

 drivers/gpio/gpio-104-dio-48e.c            |  73 ++++----------
 drivers/gpio/gpio-104-idi-48.c             |  37 ++-----
 drivers/gpio/gpio-74x164.c                 |  20 ++--
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
 14 files changed, 340 insertions(+), 333 deletions(-)

-- 
2.21.0

