Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C197C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22EA620679
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXUPtQzX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731994AbfFTOKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 10:10:52 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46235 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfFTOKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 10:10:52 -0400
Received: by mail-lf1-f68.google.com with SMTP id z15so2510425lfh.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 07:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vBVALGJvMoZda/xAZTPe0nEp15ZYtYZ8dyYpsQnBNe8=;
        b=OXUPtQzXZtr7+q6/pvhfdlzXaRVXCZS4ol1oXc71P7n/BH2ltHkbGOYFqSqPrn2n+T
         lk2GFpi+HQHtQQq5EN2HZf9kamNZaT4FS3gw5a1J3NoeTDPPOMsqwvMbMXJ7oaAQO864
         nYxy2izA0MixazuOtlHDc89ug0QMwzfL27QSEjehucieHd28oAscEjZ6OVaUPwV2+vdc
         +BDT+mB2t5PmLIJ15iembPvbIYLv9BPRLvmxyjsR3V7T5jz/Isb/sK9e4fR8Ftr1zJEe
         80UY0YUhnAxJ/UTp2h4T+zRMtdHwhKpk0288/tS8+wqKMKsQpxIr/idwF4w9cN1BTqIG
         3B8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vBVALGJvMoZda/xAZTPe0nEp15ZYtYZ8dyYpsQnBNe8=;
        b=KI62p1k1/eRLPrlb3Z5TqT7ziDG5g7Vul3UPuOWbCv2m3ZFISYaSD3j95/dydhdAmo
         oxQaCECu8h9Yb0FtG++MesDQdp8WTY7yVfnvg+gUlav58fvV1Mann8323d+p3mjXLhID
         Mgmb9E8dZ6YpUJy/X4xEh4++H1x0Dn9dKhi3iWtaGgPEYvIq9P4iwrNOOw+frWVzllEe
         Qr2KYZkYeSno2ueXev/+rgXysNpwrsmQcjCQKvkMG+RwJlvmXDwscV+8YeRV6Ka/oEM6
         Cz0kouuy2aZVxvoZmPyfpkKDCw2iVGNgarYy9XCfLxE6kuAtG1wHSw6RJryd9IaPL1Um
         PSzA==
X-Gm-Message-State: APjAAAXLgbSJoCPH5M7xueIyrH/otAg6+Kmk6K4JAIsa3C+IQWI/H6V3
        TnvLLm8QsmcWx2dw7MmmaBj9l5pB
X-Google-Smtp-Source: APXvYqzp/ZU5oKhK7NBYAhFlniV4nUaNDrS/D0JgpJPHynmbIcIg93sVFdPPOreUV96mTCEJzxTrwA==
X-Received: by 2002:a19:6a07:: with SMTP id u7mr65076716lfu.74.1561039849716;
        Thu, 20 Jun 2019 07:10:49 -0700 (PDT)
Received: from localhost.localdomain (v902-804.aalto.fi. [130.233.11.55])
        by smtp.gmail.com with ESMTPSA id 27sm3524684ljw.97.2019.06.20.07.10.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 07:10:49 -0700 (PDT)
From:   Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 0/7] rslib: RS decoder is severely broken
Date:   Thu, 20 Jun 2019 17:10:32 +0300
Message-Id: <20190620141039.9874-1-ferdinand.blomqvist@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second revision of this series that fixes the bugs/flaws in
the RS decoder. This addresses all of Thomas' comments/suggestions.

Changes in v2:
- Replace code that requires the FPU (one small thing in test_rslib.c)
- More verbose changelog (patch 2/7)
- Clarifying comment (patch 7/7)
- Fixed some small whitespace issues (patches 1 and 5)

------

The Reed_Solomon library used in the kernel is based on Phil Karn's
fec library. When playing with this library I found a couple of bugs. It
turn out that all of these bugs, and some additional flaws, are present
in rslib.

The Reed-Solomon decoder has several bugs/flaws:

- Decoding of shortened codes is broken. The decoder only works as
  expected if there are no erasures.

- The decoder sometimes fails silently, i.e. it announces success but
  returns a word that is not a codeword.

- The return value of the decoder is incoherent with respect to how
  fixed erasures are counted. If the word to be decoded is a codeword,
  then the decoder always returns zero even if some erasures are given.
  On the other hand, if the word to be decoded contains errors, then the
  number of erasures is always included in the count of corrected
  symbols. So the decoder handles erasures without symbol corruption
  inconsistently. This inconsistency probably doesn't affect anyone
  using the decoder, but it is inconsistent with the documentation.

- The error positions returned in eras_pos include all erasures, but the
  corrections are only set in the correction buffer if there actually is
  a symbol error. So if there are erasures without symbol corruption,
  then the correction buffer will contain errors (unless initialized to
  zero before calling the decoder) or some values will be unset (if the
  correction buffer is uninitialized).

- Assumes that the syndromes provided by callers are in index form.
  This is simply undocumented.

- When correcting data in-place the decoder does not correct errors in
  the parity. On the other hand, when returning the errors in correction
  buffers, errors in the parity are included.

This series provides a module with tests for rslib and fixes all the
bugs/flaws. I am not sure that the provided self tests are written in
the 'right way'. I just looked at other self tests in lib and
implemented something similar.

The fixes are tested with the self tests. They should probably also be
tested with drivers etc. that use rslib, but it is unclear to me how to
do this.

I looked a bit on two of the drivers that use rslib:

drivers/mtd/nand/raw/cafe_nand.c
drivers/mtd/nand/raw/diskonchip.c

Both of them seem to do some additional error checking after calling
decode_rs16. Maybe this is needed because of the bugs in the decoder?

Ferdinand Blomqvist (7):
  rslib: Add tests for the encoder and decoder
  rslib: Fix decoding of shortened codes
  rslib: decode_rs: Fix length parameter check
  rslib: decode_rs: code cleanup
  rslib: Fix handling of of caller provided syndrome
  rslib: Update documentation
  rslib: Fix remaining decoder flaws

 lib/Kconfig.debug               |  12 +
 lib/reed_solomon/Makefile       |   2 +-
 lib/reed_solomon/decode_rs.c    | 115 +++++--
 lib/reed_solomon/reed_solomon.c |  12 +-
 lib/reed_solomon/test_rslib.c   | 516 ++++++++++++++++++++++++++++++++
 5 files changed, 622 insertions(+), 35 deletions(-)
 create mode 100644 lib/reed_solomon/test_rslib.c

-- 
2.17.2

