Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A5FC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 13:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514FF2073F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 13:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568986630;
	bh=Z1REnwlO8OtVXuKZT9ND6aimkzzs7Sq8R8i6J4CB3do=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Mr/ClF31KJyHIkwWKFocJUTNA+XVtkFfTy9AO+A6RdtT3crWXMEI8rjIiHrauOZ7U
	 PexQbPl3lfjvQRvxTyjJEKIjnI9q1BunpKigrb0XLFn9WDUG1CzYHdyyDdd4nqi0BX
	 ZHNJ7EwrYjjOMgw1PTmiSslYLrKdcab+WkZpltuE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfITNhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 09:37:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727337AbfITNhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 09:37:09 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75FF7206B6;
        Fri, 20 Sep 2019 13:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568986628;
        bh=Z1REnwlO8OtVXuKZT9ND6aimkzzs7Sq8R8i6J4CB3do=;
        h=Date:From:To:Cc:Subject:From;
        b=O3UKzfCC+TsLfehnXsoSMjdrm95806SCnnPQu7FbHexkWf7npPeViwvI2yvjeSZrI
         X6O4ywvwe3mqFkzfcHDWtWmZJ3rws3x6j9KD9acoLODQY8BcNaGbVFOg5ZB5gm+hTF
         Yz5NSUnLVv9GI/zhNx95kZhgXtS1VS6jT3exvSCA=
Date:   Fri, 20 Sep 2019 14:37:04 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, ndesaulniers@google.com
Subject: [GIT PULL] arm64: Fixes for -rc1
Message-ID: <20190920133703.zor3t4dvwam6uyqj@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

We've had a few arm64 fixes trickle in this week, so please can you pick
them up for -rc1? Nothing catastophic, but all things that should be
addressed.

Cheers,

Will

--->8

The following changes since commit e376897f424a1c807779a2635f62eb02d7e382f9:

  arm64: remove __iounmap (2019-09-04 13:12:26 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 799c85105233514309b201a2d2d7a7934458c999:

  arm64: Fix reference to docs for ARM64_TAGGED_ADDR_ABI (2019-09-18 11:33:20 +0100)

----------------------------------------------------------------
arm64 fixes for -rc1

- Fix clang build breakage with CONFIG_OPTIMIZE_INLINING=y

- Fix compilation of pointer tagging selftest

- Fix COND_SYSCALL definitions to work with CFI checks

- Fix stale documentation reference in our Kconfig

----------------------------------------------------------------
Andrey Konovalov (1):
      selftests, arm64: add kernel headers path for tags_test

Arnd Bergmann (1):
      arm64: fix unreachable code issue with cmpxchg

Jeremy Cline (1):
      arm64: Fix reference to docs for ARM64_TAGGED_ADDR_ABI

Sami Tolvanen (1):
      arm64: fix function types in COND_SYSCALL

 arch/arm64/Kconfig                       |  2 +-
 arch/arm64/include/asm/cmpxchg.h         |  6 +++---
 arch/arm64/include/asm/syscall_wrapper.h | 15 ++++++++++++---
 tools/testing/selftests/arm64/Makefile   |  1 +
 4 files changed, 17 insertions(+), 7 deletions(-)
