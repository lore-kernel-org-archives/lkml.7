Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F57CECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59BAB21835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="gN0FgcFx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405979AbfJQLtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 07:49:15 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39892 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfJQLtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 07:49:14 -0400
Received: by mail-lj1-f195.google.com with SMTP id y3so2204062ljj.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 04:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6FKEoEtksLya6DHfOc7QmWACPInBFdwWglmBKOVW/8A=;
        b=gN0FgcFxl2+5+hNzCLQKNZ+X4pOQQM9SBjx677F3aDX4O0rtkz+RphkO6cJCy+mBAc
         0ZyHC6PtJYSEoEc/hhKZo/uOv5MVIbWrZLDQBcgbDkloQSuFjDZveZPbz8yFqHY6ZEwy
         ExdRwZA8QDfxsuJ5ehuLJdfQE/JWdxOvHpaPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6FKEoEtksLya6DHfOc7QmWACPInBFdwWglmBKOVW/8A=;
        b=BYoE9PN7qOJeKJbHLEZRqSFx3MJOC2O4aYXunp8RtYS1qzsHWNs3+f7m0qKCHTMD4f
         dm5dNVK9jG8SCsl2xSWsL0Ftw2tHv8YudCao9C+Y07PPg/wYS1sVt6Yksu1ztvZvJD5R
         1/R/6AUJ8OvRhIyfLUT9tuLLlxdh8oCG9Lh+9vxeH4C9EIP8kwY2wxT2CLFxvtw2Hdh7
         zk1Qd9FVZe6CwXkPVZjIRfwic78krnkeCX4PGnRztbrpuseRQURxwsoO6FFkw1VEp7Iu
         m4LkZxiPhYP/VsqKHlhsM7KWLtqWnwTVFhUDhKxGFi+V/8Jd4QjUhBLt+uAHl0BhYGlN
         f7iw==
X-Gm-Message-State: APjAAAWJt9dunoXWCUs+KoXIkRX8a9vxPur4sszIIosjQ8FOco6GPjw7
        EUZLn+wGsJgVdTUTANchYWAphUGOiolekqkm
X-Google-Smtp-Source: APXvYqwH6z0knFVZlzhAapP3XmtyBWwtK8p3HKnPSfyD6SY6TZlHYAgXjnEmvcGqR/wJYI5Uw3DWfQ==
X-Received: by 2002:a2e:858d:: with SMTP id b13mr2011262lji.71.1571312952464;
        Thu, 17 Oct 2019 04:49:12 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id x30sm920772ljd.39.2019.10.17.04.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 04:49:11 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gao Xiang <xiang@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel@pengutronix.de, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH 0/3] watchdog servicing during decompression
Date:   Thu, 17 Oct 2019 13:49:03 +0200
Message-Id: <20191017114906.30302-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many custom boards have an always-running external watchdog
circuit. When the timeout of that watchdog is small, one cannot boot a
compressed kernel since the board gets reset before it even starts
booting the kernel proper.

One way around that is to do the decompression in a bootloader which
knows how to service the watchdog. However, one reason to prefer using
the kernel's own decompressor is to be able to take advantage of
future compression enhancements (say, a faster implementation of the
current method, or switching over when a new method such a zstd is
invented) - often, the bootloader cannot be updated without physical
access or is locked down for other reasons, so the decompressor has to
be bundled with the kernel image for that to be possible.

This POC adds a linux/decompress/keepalive.h header which provides a
decompress_keepalive() macro. Wiring up any given decompressor just
amounts to including that header and adding decompress_keepalive() in
the main loop - for simplicity, this series just does it for lz4.

The actual decompress_keepalive() implementation is of course very
board-specific. The third patch adds a kconfig knob that handles a
common case (and in fact suffices for all the various boards I've come
across): An external watchdog serviced by toggling a gpio, with the
value of that gpio being settable in a memory-mapped register.

Rasmus Villemoes (3):
  decompress/keepalive.h: prepare for watchdog keepalive during kernel
    decompression
  lib: lz4: wire up watchdog keepalive during decompression
  decompress/keepalive.h: add config option for toggling a set of bits

 include/linux/decompress/keepalive.h | 22 +++++++++++++++++++
 init/Kconfig                         | 33 ++++++++++++++++++++++++++++
 lib/lz4/lz4_decompress.c             |  2 ++
 3 files changed, 57 insertions(+)
 create mode 100644 include/linux/decompress/keepalive.h

-- 
2.20.1

