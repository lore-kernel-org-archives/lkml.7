Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86769C73C68
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 05:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692972083D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 05:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfGJFWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 01:22:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbfGJFWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 01:22:14 -0400
Received: from [10.44.0.22] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 093D920665;
        Wed, 10 Jul 2019 05:22:11 +0000 (UTC)
From:   Greg Ungerer <gerg@linux-m68k.org>
Subject: [git pull] m68knommu changes for v5.3
To:     torvalds@linux-foundation.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>
Message-ID: <cf9d62c7-2b47-e234-ee35-2562b125a411@linux-m68k.org>
Date:   Wed, 10 Jul 2019 15:22:09 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Can you please pull the m68knommu git tree, for-next branch.

A series of cleanups for the FLAT format binary loader, binfmt_flat,
from Christoph. The end goal is to support no-MMU on RISC-V, and the
last patch enables that.

Regards
Greg



The following changes since commit 4b972a01a7da614b4796475f933094751a295a2f:

   Linux 5.2-rc6 (2019-06-22 16:01:36 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git for-next

for you to fetch changes up to ad97f9df0fee4ddc9ef056dda4dcbc6630d9f972:

   riscv: add binfmt_flat support (2019-06-24 09:16:47 +1000)

----------------------------------------------------------------
Christoph Hellwig (17):
       binfmt_flat: remove flat_reloc_valid
       binfmt_flat: remove flat_set_persistent
       binfmt_flat: provide a default version of flat_get_relocate_addr
       binfmt_flat: remove flat_old_ram_flag
       binfmt_flat: replace flat_argvp_envp_on_stack with a Kconfig variable
       binfmt_flat: remove the uapi <linux/flat.h> header
       binfmt_flat: remove the unused OLD_FLAT_FLAG_RAM definition
       binfmt_flat: consolidate two version of flat_v2_reloc_t
       binfmt_flat: use fixed size type for the on-disk format
       binfmt_flat: add endianess annotations
       binfmt_flat: add a ARCH_HAS_BINFMT_FLAT option
       binfmt_flat: make support for old format binaries optional
       binfmt_flat: provide an asm-generic/flat.h
       binfmt_flat: remove the persistent argument from flat_get_addr_from_rp
       binfmt_flat: move the MAX_SHARED_LIBS definition to binfmt_flat.c
       binfmt_flat: don't offset the data start
       riscv: add binfmt_flat support

  arch/arm/Kconfig                                   |  2 +
  arch/arm/include/asm/Kbuild                        |  1 +
  arch/c6x/Kconfig                                   |  1 +
  arch/c6x/include/asm/flat.h                        |  7 +-
  arch/h8300/Kconfig                                 |  3 +
  arch/h8300/include/asm/flat.h                      |  7 +-
  arch/m68k/Kconfig                                  |  2 +
  arch/m68k/include/asm/flat.h                       | 30 +------
  arch/microblaze/Kconfig                            |  1 +
  arch/microblaze/include/asm/flat.h                 |  7 +-
  arch/riscv/Kconfig                                 |  1 +
  arch/riscv/include/asm/Kbuild                      |  1 +
  arch/sh/Kconfig                                    |  1 +
  arch/sh/include/asm/flat.h                         |  7 +-
  arch/xtensa/Kconfig                                |  1 +
  arch/xtensa/include/asm/flat.h                     |  7 +-
  fs/Kconfig.binfmt                                  | 18 +++-
  fs/binfmt_flat.c                                   | 99 ++++++++++++++--------
  .../arm/include/asm => include/asm-generic}/flat.h | 19 +----
  include/linux/flat.h                               | 58 +++++++++----
  include/uapi/linux/flat.h                          | 59 -------------
  21 files changed, 145 insertions(+), 187 deletions(-)
  rename {arch/arm/include/asm => include/asm-generic}/flat.h (55%)
  delete mode 100644 include/uapi/linux/flat.h
