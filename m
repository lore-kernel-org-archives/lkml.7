Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDF7C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 07:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C6820836
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 07:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2AmtxJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfCCHrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 02:47:11 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40054 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfCCHrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 02:47:10 -0500
Received: by mail-pg1-f194.google.com with SMTP id u9so1021445pgo.7;
        Sat, 02 Mar 2019 23:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/u5JpEMLgwr02V2gRriGLKXF7uaEOCF/6ycWX9ITlAs=;
        b=O2AmtxJ9ymOakpmW6FGMiDGlbJreMI/5BVJwpfFNtsF+JxOcG2B5YkZvosloqx4KTF
         LUM9/9Ar5FTYleUx2lDT+ix9SJuwcpeqUNY2TK1YzGTBhDmYqbnyxa78j/Qpe3dICGcy
         0G9gzTQlDyp1YADZP/1SUi43QFAtB79lnoffKnTIqIUVRFGfgQgEyy0/oq7OAvFkuGYV
         ZIAMwC6mg5OlbwJLuB/iHtYDZcg8P6mz9WKaXOvMoKp9SJ5xweV6IR19H+XybHtfHxDN
         +s7t1BbMgP4+nGqXrslvvP4Fh3mos9gyxyWzpYUARQGoBIna7gnfTk51/nLCO/GW2Cbo
         /epQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/u5JpEMLgwr02V2gRriGLKXF7uaEOCF/6ycWX9ITlAs=;
        b=SOVkGVZXG/xtXuc38hGB20MStiEPYsnuCmRwLbUR7F/y38Kol3mpQrbMWCqGbSLtqE
         eTl+aprByD3wYSZKgBic9a36YVJk0coH6qhI+eCq4FVyTcIpvGDjuwxqp2bWBScPhhqu
         QyAH3suN+EDdJhRPZUYJh3mTJMueDxNTEVxZfdu2r575wV+iesbnv9LMCdmmdgyZEdZ9
         oFoSBLpYdlKiWKjTbArl26A+vzpGCuci0HuAvMSZePGJgJiHkGPJYlnnxlC8jnA2VvOh
         /8QbAi/2h23R8yWsdxIMZ0NVHjuhvMg7Zcl1SgUDaJY4Kschk+pjVYSujtjXa5qcSZ5O
         rBsw==
X-Gm-Message-State: AHQUAub+YBwC6owssfy4RuOBawoSIAFyvlquOR3lV0N7JgeGS7pO3jGY
        5fNLVw9rXuQqxo/UXSRuj9Y=
X-Google-Smtp-Source: AHgI3Iaj+sn6BL0GKzJAadiy7NCWEMW/nkLhoOIBPdbI9atRtCA/wl0fp/cx10YHoVqCUqh6gbcEzQ==
X-Received: by 2002:a62:cf81:: with SMTP id b123mr14403062pfg.29.1551599229655;
        Sat, 02 Mar 2019 23:47:09 -0800 (PST)
Received: from localhost.localdomain ([2001:268:c0a5:3b5c:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id c13sm4332927pfm.34.2019.03.02.23.47.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 23:47:09 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com, bgolaszewski@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v9 0/9] Introduce the for_each_set_clump8 macro
Date:   Sun,  3 Mar 2019 16:47:58 +0900
Message-Id: <cover.1551598603.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190303074758.Xtgar1uR_VrmkKZogaoahkY90MrNxbqd9CmX37UJmkg@z>

Changes in v9:
  - Utilize for_each_set_clump8 in uniphier_gpio_set_multiple

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

