Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF95C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9C221537
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfFNPDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 11:03:03 -0400
Received: from foss.arm.com ([217.140.110.172]:36250 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbfFNPDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 11:03:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72CD4346;
        Fri, 14 Jun 2019 08:03:02 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFB093F246;
        Fri, 14 Jun 2019 08:03:01 -0700 (PDT)
Date:   Fri, 14 Jun 2019 16:02:59 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com
Subject: [GIT PULL] arm64: fixes for -rc5
Message-ID: <20190614150259.GC29231@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are some arm64 fixes for -rc5. The only non-trivial change (in
terms of the diffstat) is fixing our SVE ptrace API for big-endian
machines, but the majority of this is actually the addition of
much-needed comments and updates to the documentation to try to avoid
this mess biting us again in future.

There are still a couple of small things on the horizon, but nothing
major at this point.

Please pull. Thanks,

Will

--->8

The following changes since commit ebcc5928c5d925b1c8d968d9c89cdb0d0186db17:

  arm64: Silence gcc warnings about arch ABI drift (2019-06-06 13:28:45 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 41040cf7c5f0f26c368bc5d3016fed3a9ca6dba4:

  arm64/sve: Fix missing SVE/FPSIMD endianness conversions (2019-06-13 10:07:19 +0100)

----------------------------------------------------------------
arm64 fixes for -rc5

- Fix broken SVE ptrace API when running in a big-endian configuration

- Fix performance regression due to off-by-one in TLBI range checking

- Fix build regression when using Clang

----------------------------------------------------------------
Dave Martin (1):
      arm64/sve: Fix missing SVE/FPSIMD endianness conversions

Nathan Chancellor (1):
      arm64: Don't unconditionally add -Wno-psabi to KBUILD_CFLAGS

Will Deacon (1):
      arm64: tlbflush: Ensure start/end of address range are aligned to stride

 Documentation/arm64/sve.txt              | 16 ++++++++++++
 arch/arm64/Makefile                      |  2 +-
 arch/arm64/include/asm/tlbflush.h        |  3 +++
 arch/arm64/include/uapi/asm/kvm.h        |  7 ++++++
 arch/arm64/include/uapi/asm/ptrace.h     |  4 +++
 arch/arm64/include/uapi/asm/sigcontext.h | 14 +++++++++++
 arch/arm64/kernel/fpsimd.c               | 42 +++++++++++++++++++++++++-------
 7 files changed, 78 insertions(+), 10 deletions(-)
