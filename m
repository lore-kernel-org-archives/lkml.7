Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02027C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C276E208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="R1p1fRuc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732577AbfC0BsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 21:48:18 -0400
Received: from chill.innovation.ch ([216.218.245.220]:48314 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731934AbfC0BsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 21:48:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by chill.innovation.ch (Postfix) with ESMTP id 3862464013F;
        Tue, 26 Mar 2019 18:48:17 -0700 (PDT)
X-Virus-Scanned: amavisd-new at 
Received: from chill.innovation.ch ([127.0.0.1])
        by localhost (chill.innovation.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id G_IDRkml_2Eo; Tue, 26 Mar 2019 18:48:15 -0700 (PDT)
From:   =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch DBB6E640114
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1553651295;
        bh=jKJAI4BVg7Agjkv6HfZrBiBPJ9+GI2U7E3AkTvssGmA=;
        h=From:To:Cc:Subject:Date:From;
        b=R1p1fRucG2nLlZZHzhy4Ovm2Fb98NXzo3HKFfhJzXL+H5oOBuJa1w8nZhv/RRUFnn
         DxNHoHJHTbgRKa6HW07gR8K94caP+h9GzRBqm/77+BhTginGSeOR8XLwnld8xw9A6i
         DB1gK15N5hTtop7/yS8z6b5g4VKuOExtEIFy9vZbfrwpvpHv8dis16s9hHC8+vdSD8
         r5wHhqpeMlpahP+Kbti29pEmjHlHTrSGKuCJeznC8DJBi4cdMP5Y8MBMGdq8O7ZAEL
         uzcruqePoCh7xWTdnzE1wymP3pRad9GD7CJOp5bAC2nJIZTcAwWWiNOkOz0O22xoDF
         WeH/fsSmJmNsA==
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] Add Apple SPI keyboard and trackpad driver
Date:   Tue, 26 Mar 2019 18:48:03 -0700
Message-Id: <20190327014807.7472-1-ronald@innovation.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This changeset adds a driver for the SPI keyboard and trackpad on recent
MacBook's and MacBook Pro's. The driver has seen a fair amount of use
over the last 2 years (basically anybody running linux on these
machines), with only relatively small changes in the last year or so.
For those interested, the driver development has been hosted at
https://github.com/cb22/macbook12-spi-driver/ (as well as my clone at
https://github.com/roadrunner2/macbook12-spi-driver/).

The first patch is just a placeholder for now and is provided in case
somebody wants to compile the driver while it's being reviewed here; the
real patch has been submitted to dri-devel and is being discussed there,
with the intent/hope that I can get an Ack and permission to merge it
through the input subsystem tree here as part of this patch series.

The second and third patches add a new dev_print_hex_dump() helper as
the dev_xxx() analog of print_hex_dump().

The fourth patch finally contains the new applespi driver.

Changes in v3:
  Applied all feedback from review by Andy Shevchenko, including:
  - move dev_print_hex_dump() to driver core
  - clean up keyboard modifier bits testing/modifying
  - remove DEV() macro
  - minor style issues
  The full set of changes to applespi can be viewed at
  https://github.com/roadrunner2/macbook12-spi-driver/ as individual
  commits f832caa..3a6262e in the upstreaming-review branch.

Ronald Tschalär (4):
  drm/bridge: sil_sii8620: depend on INPUT instead of selecting it.
  lib/hexdump.c: factor out generic hexdump formatting for reuse.
  driver core: add dev_print_hex_dump() logging function.
  Input: add Apple SPI keyboard and trackpad driver.

 drivers/base/core.c               |   43 +
 drivers/gpu/drm/bridge/Kconfig    |    2 +-
 drivers/input/keyboard/Kconfig    |   15 +
 drivers/input/keyboard/Makefile   |    1 +
 drivers/input/keyboard/applespi.c | 1988 +++++++++++++++++++++++++++++
 include/linux/device.h            |   15 +
 include/linux/printk.h            |   12 +
 lib/hexdump.c                     |   95 +-
 8 files changed, 2146 insertions(+), 25 deletions(-)
 create mode 100644 drivers/input/keyboard/applespi.c

-- 
2.20.1

