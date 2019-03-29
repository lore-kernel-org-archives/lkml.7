Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D95C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 03:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC25A2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 03:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORW5BN34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbfC2DC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 23:02:56 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43509 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfC2DC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 23:02:56 -0400
Received: by mail-pl1-f196.google.com with SMTP id m10so296759plt.10;
        Thu, 28 Mar 2019 20:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UjnfdwamcKCvdCdclf1O0h9o8hu8IZ1eKNVDHWa1+Cc=;
        b=ORW5BN34nhsEGHWws7FM3zBAAM8vRob6AXhbmf3iUlpYhbO3/K7Olduf51W8i/tt3n
         eTkoHzNzbhd5zxO5wyOh9ZtelR8SMTojVeGo5Zru92u9HlmnN4m5kbGIJneXd2BMjz8J
         WjFPgOx3o87F11jIQVG4upw7G/8VtAde31YQf/ONPe7w9Lex/Vb3kna3UKr895gP9s+j
         bMe+pdCfyiM1aaOEWMdq69tt7w9xTKC53wnxpYg1vLLM8bqN1mv51fedjiVzExfq39u2
         6nFtwKbdACTaQr4ppDulkouUqDgka6SH2epkFguDWmu7RBw/xI1/LOyVIRto7tURKifK
         2kbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UjnfdwamcKCvdCdclf1O0h9o8hu8IZ1eKNVDHWa1+Cc=;
        b=A/EC+v4CX2/hKFnMt4pOgxFzebmI7ILv4wausMaUa5aljE1j1hnGCHMS3hjDcOA6F6
         4/H0dh11HEpKFUyYXmgUI+d0H9olZteah1IBBErJ9X6zqRFya9qMXCtQoMHNTaVSvEYX
         168zWvMAHykjSbfZib5ZVb8GPOCfVgM4bJnXp9SEbz6OWmanR2YTbCy8nTD0nXfblU1T
         Pm/dwVDBd35Z31p46dCREsI+d9ZarBFjnSO+u2LCehXKRtpXDpdPrzkdHOuyRc47d6Sy
         xAMnBMMPkCwf5ztc11aJJ4xY+4PX4NRxkfVd/W2ZDjcswIuB09tBMtQIE8LiaiAl3W6+
         1POw==
X-Gm-Message-State: APjAAAV8mU+QjBRKGzNOq7ma8cNnXEwbqdtow/mkIZ3UnAdC2DCnzoQV
        ikLn5PgJUbC2jBSM5cRLag4=
X-Google-Smtp-Source: APXvYqxCnhX1quMYnpw+IcUytnVZ34vtD9FUcPibn6VAyav7RvOyhB4IRT2gXEGVPMLxrunZ7ppCqw==
X-Received: by 2002:a17:902:42:: with SMTP id 60mr46115333pla.132.1553828575060;
        Thu, 28 Mar 2019 20:02:55 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:ba2:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id v82sm749926pfa.170.2019.03.28.20.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 20:02:53 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v14 00/11] Introduce the for_each_set_clump8 macro
Date:   Fri, 29 Mar 2019 12:03:30 +0900
Message-Id: <cover.1553828158.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v14:
  - Redefine bitmap_get_value8, bitmap_set_value8, and find_next_clump8
    as static inline functions
  - Rename 'idx' variable to 'index' in the bitmap_get_value8 and
    bitmap_set_value8 functions
  - Remove superfluous parens in gen_74x164_set_multiple

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
  gpio: 74x164: Utilize the for_each_set_clump8 macro
  thermal: intel: intel_soc_dts_iosf: Utilize for_each_set_clump8 macro

 drivers/gpio/gpio-104-dio-48e.c            |  73 ++++----------
 drivers/gpio/gpio-104-idi-48.c             |  36 ++-----
 drivers/gpio/gpio-74x164.c                 |  19 ++--
 drivers/gpio/gpio-gpio-mm.c                |  73 ++++----------
 drivers/gpio/gpio-pci-idio-16.c            |  75 +++++---------
 drivers/gpio/gpio-pcie-idio-24.c           | 109 ++++++++-------------
 drivers/gpio/gpio-uniphier.c               |  16 ++-
 drivers/gpio/gpio-ws16c48.c                |  73 ++++----------
 drivers/thermal/intel/intel_soc_dts_iosf.c |  29 +++---
 drivers/thermal/intel/intel_soc_dts_iosf.h |   2 -
 include/asm-generic/bitops/find.h          |  61 ++++++++++++
 include/linux/bitops.h                     |   5 +
 lib/test_bitmap.c                          |  65 ++++++++++++
 13 files changed, 299 insertions(+), 337 deletions(-)

-- 
2.21.0

