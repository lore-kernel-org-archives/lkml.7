Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C7CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C982082C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxjGz47F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731027AbfC3SaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 14:30:11 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34682 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730675AbfC3SaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 14:30:10 -0400
Received: by mail-lf1-f66.google.com with SMTP id y18so3574827lfe.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 11:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Q92E7vMhR72b13ilIGnUBU/3ZroPOzD9sO7tAwEn/eI=;
        b=HxjGz47FQpw1zfPZMzruKHtVibBw4NqLSBIK9dW/pAfisbeD0SMA2Qcs1hTQnTfcs8
         /F+NyPvMa09pHFWW9I/p65zmGeqmqtXb2TgKAMpXBxfbLg/SkvbxQtDVw1AFfG5cChmB
         jqf6/gw/A/YGvkZTdyXsV4Y9G7wXR2xYwnq27uOmuJ4orirdXJ7UvuRotAjKilnwb4gE
         WUzbCnwS6k7iMu5j9RbnlHOpppxQCzoXyzgJPnigce8OIqgTEmIef4jOaxYXutgtLuti
         Q9RlW/epZ5XipgrNiG3bT/u9Ch/ACCo86sm2yL/ZR+EmMOENudNmMrQ9STJvdK90x3xJ
         +6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Q92E7vMhR72b13ilIGnUBU/3ZroPOzD9sO7tAwEn/eI=;
        b=D+CpCH4WQTfQQ4d9qi011W8pD2ZBipAwxc5UXFJgP1s/U36kI/vHwui2sfVA6YGIDQ
         sir/pjKilev6wOY0t8u5aqgBXP5VLLguBBtZ5H2J7EfPpLwGU0diVrVqLLy4fN2cZH9a
         iU0smE8iPcHsYLfdpxh/Cm06pc4ATsqo7Prp5mNvxTFgV15WjYsOfR6d7ej3rNGOWArV
         AAhyHP7VFN7Na+24u+TdqjHXDf5dnsAkNSy0X5de3GC8cqS5TNVfwBPe/aEfeVHS9M8I
         I+Z917s6IbPEyw47jrhCpUheTbVU3/SC6PwBLkas34YCzg+le+UZEQrLa1p6P9j1xvOP
         4zAA==
X-Gm-Message-State: APjAAAWYhO43akfUr4HSwIdBJmmHJQA4aOLLmG/BPkww4mJVCtXtOVWl
        e5kKxnlGsZ5ufLwrZ/1BopI25cA1
X-Google-Smtp-Source: APXvYqxi2zFIcInCBGsFBg41AGQuWYDTvO7fcg8BPZ2yaqZhNivER9aLObdWJsktbpU8wgwgi4NdNQ==
X-Received: by 2002:ac2:4152:: with SMTP id c18mr8642885lfi.84.1553970608464;
        Sat, 30 Mar 2019 11:30:08 -0700 (PDT)
Received: from localhost.localdomain (v902-731.aalto.fi. [130.233.10.238])
        by smtp.gmail.com with ESMTPSA id o7sm1060058ljj.23.2019.03.30.11.30.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 11:30:07 -0700 (PDT)
From:   Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH 0/7] rslib: RS decoder is severely broken
Date:   Sat, 30 Mar 2019 20:29:40 +0200
Message-Id: <20190330182947.8823-1-ferdinand.blomqvist@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Reed_Solomon library used in the kernel is based on Phil Karn's
fec library. When playing with this library I found a couple of bugs. It
turn out that all of these bugs, and some additional flaws, are present
in rslib.

The Reed-Solomon decoder has several bugs/flaws:

- Decoding of shortened codes is broken.

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
 lib/reed_solomon/decode_rs.c    | 112 +++++--
 lib/reed_solomon/reed_solomon.c |  12 +-
 lib/reed_solomon/test_rslib.c   | 519 ++++++++++++++++++++++++++++++++
 5 files changed, 622 insertions(+), 35 deletions(-)
 create mode 100644 lib/reed_solomon/test_rslib.c

-- 
2.17.2

