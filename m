Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF26C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 17:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2DDF21473
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 17:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLrQKjaj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731831AbfGORou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 13:44:50 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45270 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730235AbfGORot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 13:44:49 -0400
Received: by mail-lj1-f193.google.com with SMTP id m23so17098856lje.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 10:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lN7NolkvgcEAi2xoTGIqWk3kYzQk+ol6Awu1yLItqUA=;
        b=ZLrQKjaj7huMHrfrkDQqhRaPPeLbmbgXI5QvCRdJEPV7lBgNacx2aDqK1gtjTkLxpk
         8fxivqeUkGQTFlcVEnjw6Jvvgn5XNfKXhp7AinsJ9jLrYfKckS8WLiMb9vV1M6C84ifq
         u3mGPGGpr+Q0p3o1i7yfLr692BFeIvadk/FvCC6Je53GAgh+K8uB3HndKud08fHIBLFc
         4AkCGIgjz5LsDc5nMxvrP07VO/9rgz/6d9zbcprP7YPAOy1D/2Syjm09lJAIsjLPmrsl
         2vLyGpvRnBzd+y5zrU59d55vM2pwVDmwbFB4aSLtXgDoNaVVtmIyMa7CsnkcnrKLR8ec
         npkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lN7NolkvgcEAi2xoTGIqWk3kYzQk+ol6Awu1yLItqUA=;
        b=F4AzshWqNpnoS0ItnDCgtFTvJFzpTdv75FphQqBZ/jVjJirLww07ysLmpwZ9cq1SuD
         qYrk6a2hrSG/VsKAJWanBLvMCW1kidIx7HzuNcdbxTIr6uqMIKozmABgfqq5/aVmb1vN
         sWsgMhWtHMjZe+PB4P/HPbwRGSeKdin6aEyGrX52uVB6ocuzkDguJhi0PaSEs1OBm3tn
         C+zW6BXEtgDKb5LRFrXJRBzp/h/LNqKOFkDRDUef+fsmdhTz5ht/Tq78P6UU/9RqukSQ
         jQMqUza8omI907cKlg21vgygTXBCIv2lmFs4HGb2keRIB4Xuop/Fhl4oC9qo2W9LGQJX
         7aMw==
X-Gm-Message-State: APjAAAWLbtq0BV3HuSRtkKlMuOSPGsTqiB3ds/ljY18PWH02wPHguYCF
        lWruKxh/QdYw1bKOrspd/fQFsgj5
X-Google-Smtp-Source: APXvYqwl5QVR0MSi4chrtMnfImvMNFt4ODmIHWF8jWRqUtLjAVwkhUFOFPeRIEX+8kqysR6t4Tvbww==
X-Received: by 2002:a2e:298a:: with SMTP id p10mr14429150ljp.74.1563212687922;
        Mon, 15 Jul 2019 10:44:47 -0700 (PDT)
Received: from octofox.cadence.com (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id t21sm2431287lfl.17.2019.07.15.10.44.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 10:44:47 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 0/7] xtensa updates for v5.3
Date:   Mon, 15 Jul 2019 10:44:27 -0700
Message-Id: <20190715174427.6144-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following batch of updates for the Xtensa architecture:

The following changes since commit 9e0babf2c06c73cda2c0cd37a1653d823adb40ec:

  Linux 5.2-rc5 (2019-06-16 08:49:45 -1000)

are available in the git repository at:

  git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20190715

for you to fetch changes up to 775f1f7eacede583ec25ed56e58c4483f2b29265:

  xtensa: virt: add defconfig and DTS (2019-07-08 14:32:06 -0700)

----------------------------------------------------------------
Xtensa updates for v5.3:

- clean up PCI support code;
- add defconfig and DTS for the 'virt' board;
- abstract 'entry' and 'retw' uses in xtensa assembly in preparation for
  XEA3/NX pipeline support;
- random small cleanups.

----------------------------------------------------------------
Guenter Roeck (1):
      xtensa/PCI: Remove unused variable

Markus Elfring (1):
      xtensa: One function call less in bootmem_init()

Max Filippov (5):
      xtensa: drop dead PCI support code
      xtensa: use generic pcibios_set_master and pcibios_enable_device
      xtensa: remove arch/xtensa/include/asm/types.h
      xtensa: abstract 'entry' and 'retw' in assembly code
      xtensa: virt: add defconfig and DTS

 arch/xtensa/boot/dts/virt.dts      |  72 +++++++++++++++++++++
 arch/xtensa/configs/virt_defconfig | 113 +++++++++++++++++++++++++++++++++
 arch/xtensa/include/asm/asmmacro.h |  46 ++++++++++++++
 arch/xtensa/include/asm/platform.h |  10 ---
 arch/xtensa/include/asm/types.h    |  23 -------
 arch/xtensa/kernel/coprocessor.S   |   7 ++-
 arch/xtensa/kernel/entry.S         |  11 ++--
 arch/xtensa/kernel/mcount.S        |  11 ++--
 arch/xtensa/kernel/pci.c           | 124 -------------------------------------
 arch/xtensa/kernel/platform.c      |   2 -
 arch/xtensa/kernel/setup.c         |   4 --
 arch/xtensa/lib/checksum.S         |  12 ++--
 arch/xtensa/lib/memcopy.S          |  38 ++++++------
 arch/xtensa/lib/memset.S           |  10 +--
 arch/xtensa/lib/strncpy_user.S     |  16 ++---
 arch/xtensa/lib/strnlen_user.S     |  14 ++---
 arch/xtensa/lib/usercopy.S         |  12 ++--
 arch/xtensa/mm/init.c              |   5 +-
 arch/xtensa/mm/misc.S              |  78 +++++++++++------------
 19 files changed, 339 insertions(+), 269 deletions(-)
 create mode 100644 arch/xtensa/boot/dts/virt.dts
 create mode 100644 arch/xtensa/configs/virt_defconfig
 delete mode 100644 arch/xtensa/include/asm/types.h

-- 
Thanks.
-- Max
