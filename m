Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EEACA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 08:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D19C5208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 08:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ULfIUbNv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbfKAIN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 04:13:56 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:32262 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730277AbfKAINz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 04:13:55 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id xA18BsBN023869;
        Fri, 1 Nov 2019 17:11:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com xA18BsBN023869
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1572595915;
        bh=s5TW0F5kiM6Ii1qhgS3EYy+jvOIj8HD4h2NhZklMb0E=;
        h=From:To:Cc:Subject:Date:From;
        b=ULfIUbNvYDv8iOxNWNrQODXFHJ4+Xh0h93HMEG2YAkA9aQIpqyPE+lSmIfcmFP1gV
         LQcduXM9YsFhX3YMdpvz5RNrPHvsT9GB+qC+DuB7saSq7w2Nkzqy5Yqfb6liAIpNdd
         Q+taUATi98kBcFlhNMQnMGl2oN3kv//phjwjNZqdGTZlh3s/sUOa4tdRyQm6ecdIli
         b7ObC94Ixlnk3jvUbbQ4Cqht33jsI4gO7zg7PjCM4pzZ2IJLBQTv4nkiGyeu7kKxmT
         0MQE8G9t5XcoMxfxIwHGHtmDov2eOBM2HSb1qtRe/HGlfcLXv87vRuF288Y1eMgS7J
         8DBgfkRs9abIw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        David Gibson <david@gibson.dropbear.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] libfdt: prepare for (U)INT32_MAX addition
Date:   Fri,  1 Nov 2019 17:11:45 +0900
Message-Id: <20191101081148.23274-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


As you may know, libfdt in the upstream DTC project
added referenced to (U)INT32_MAX.

The kernel code has three files to adjust:

include/linux/libfdt_env.h
arch/powerpc/boot/libfdt_env.h
arch/arm/boot/compressed/libfdt_env.h

Instead of fixing arch/arm/boot/compressed/libfdt_env.h,
it is pretty easy to refactor the ARM decompressor
to reuse <linux/lbifdt_env.h>
So, 2/3 simplifies the Makefile and deletes its own
libfdt_env.h

On the other hand, the PPC boot-wrapper is a can of worms.
I give up refactoring it.
Let's keep it closed, and just update arch/powerpc/boot/libfdt_env.h


Changes in v2:
 - Fix ppc libfdt_env.h

Masahiro Yamada (3):
  libfdt: add SPDX-License-Identifier to libfdt wrappers
  ARM: decompressor: simplify libfdt builds
  libfdt: define INT32_MAX and UINT32_MAX in libfdt_env.h

 arch/arm/boot/compressed/.gitignore     |  9 -------
 arch/arm/boot/compressed/Makefile       | 33 +++++++------------------
 arch/arm/boot/compressed/atags_to_fdt.c |  1 +
 arch/arm/boot/compressed/fdt.c          |  2 ++
 arch/arm/boot/compressed/fdt_ro.c       |  2 ++
 arch/arm/boot/compressed/fdt_rw.c       |  2 ++
 arch/arm/boot/compressed/fdt_wip.c      |  2 ++
 arch/arm/boot/compressed/libfdt_env.h   | 22 -----------------
 arch/powerpc/boot/libfdt_env.h          |  2 ++
 include/linux/libfdt_env.h              |  3 +++
 lib/fdt.c                               |  1 +
 lib/fdt_empty_tree.c                    |  1 +
 lib/fdt_ro.c                            |  1 +
 lib/fdt_rw.c                            |  1 +
 lib/fdt_strerror.c                      |  1 +
 lib/fdt_sw.c                            |  1 +
 lib/fdt_wip.c                           |  1 +
 17 files changed, 30 insertions(+), 55 deletions(-)
 create mode 100644 arch/arm/boot/compressed/fdt.c
 create mode 100644 arch/arm/boot/compressed/fdt_ro.c
 create mode 100644 arch/arm/boot/compressed/fdt_rw.c
 create mode 100644 arch/arm/boot/compressed/fdt_wip.c
 delete mode 100644 arch/arm/boot/compressed/libfdt_env.h

-- 
2.17.1

