Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AC9C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 07:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE3120836
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 07:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPEjXNC8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfCCHoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 02:44:25 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36245 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbfCCHoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 02:44:25 -0500
Received: by mail-pg1-f194.google.com with SMTP id r124so1028161pgr.3;
        Sat, 02 Mar 2019 23:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FTGLQuMzA6NXFSyBaP9yP3iqhOjyb5SMy1QH7j0ioDk=;
        b=nPEjXNC8eHDuVCCKg0hFBeTWLkXIf9gug1s8tDZkRAH4veV1F6D0HNzqgyWB5OXOvF
         VhnhkAxOpVeWFdWrklMSbvHgs66ptkg5mlf8xjj2ESbwi2ktE0F8KISHLct2AEyeWSn+
         /0NNxL5lRThwY+qOfPjXvNLIzsCOplg0rb2zcVSRD4XF1MFCyKJn//a1QMepNwUNQ5fJ
         QzQOe1jW9eaVBEwFicONRSh33lJGqSyPYRrDgciTA4GFfSt6Zgd3CJnBTZPMRr3YVhR8
         Fy6LHKqcir6trUMbU3gX7y89Ea22XKOXCP1Mp8PKrA6KYpcr2ZJXk7s07KiYrLOzJ5Nz
         qZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FTGLQuMzA6NXFSyBaP9yP3iqhOjyb5SMy1QH7j0ioDk=;
        b=Tw6N2qSulNb0HTye5qZbB47sgZmR1qnQqhvwH83SacCMgC73ZelIusNx8SatDiLVGB
         bs7Q0RmsRzZyAADtHg9VUF6nlLmbh0Dw4pw2SgF8+mWmtDYHtwUnrUhC7dx2r2vRGt4o
         C2T9rdoPBLpOAUwDQpeo1X2aE+S73+Kcpnp42JijP1h2H9M/V63XLZDwo0IfkONLJrF8
         St9my3D9cbqUWuxMXeoenPZM3JZT2N0fWIOMllvtQtrvC9u7pYlfUTpR0HKEDLxIbmqx
         RUfOXSOORNPLOo4Z5pssjr7SHWQUfkvqVDMjM73Bs3XM7b8nYkGQSncY7V33FmPbTG7L
         45Mg==
X-Gm-Message-State: APjAAAWYEVODciSPRIZNg0Ap7QHmDRFHqa0U81BTyWtfJerlBp/7gqXj
        ENpe7p7P3DbNfRl/+gQ7+eE=
X-Google-Smtp-Source: APXvYqy8++rSVrwPju2JVlF/IVz2MhoJ6re+mU8TZ7A9KEwvMCt5ualJFTnG1r9P5E0cIKGviivqXg==
X-Received: by 2002:a63:de48:: with SMTP id y8mr3745654pgi.253.1551599063897;
        Sat, 02 Mar 2019 23:44:23 -0800 (PST)
Received: from localhost.localdomain ([2001:268:c0a5:3b5c:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id f8sm3453113pgs.77.2019.03.02.23.44.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 23:44:22 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com, bgolaszewski@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v9 0/9] Introduce the for_each_set_clump8 macro
Date:   Sun,  3 Mar 2019 16:44:39 +0900
Message-Id: <cover.1551598603.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v9:
  - Return unsigned long for bitmap_get_value8 for consistency

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

William Breathitt Gray (9):
  bitops: Introduce the for_each_set_clump8 macro
  lib/test_bitmap.c: Add for_each_set_clump8 test cases
  gpio: 104-dio-48e: Utilize for_each_set_clump8 macro
  gpio: 104-idi-48: Utilize for_each_set_clump8 macro
  gpio: gpio-mm: Utilize for_each_set_clump8 macro
  gpio: ws16c48: Utilize for_each_set_clump8 macro
  gpio: pci-idio-16: Utilize for_each_set_clump8 macro
  gpio: pcie-idio-24: Utilize for_each_set_clump8 macro
  gpio: uniphier: Utilize for_each_set_clump8 macro

 drivers/gpio/gpio-104-dio-48e.c   |  73 ++++++--------------
 drivers/gpio/gpio-104-idi-48.c    |  37 +++-------
 drivers/gpio/gpio-gpio-mm.c       |  73 ++++++--------------
 drivers/gpio/gpio-pci-idio-16.c   |  75 ++++++++------------
 drivers/gpio/gpio-pcie-idio-24.c  | 111 +++++++++++-------------------
 drivers/gpio/gpio-uniphier.c      |  16 ++---
 drivers/gpio/gpio-ws16c48.c       |  72 ++++++-------------
 include/asm-generic/bitops/find.h |  14 ++++
 include/linux/bitops.h            |   5 ++
 lib/find_bit.c                    |  81 ++++++++++++++++++++++
 lib/test_bitmap.c                 |  65 +++++++++++++++++
 11 files changed, 313 insertions(+), 309 deletions(-)

-- 
2.21.0

