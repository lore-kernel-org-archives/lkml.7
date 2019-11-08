Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79062C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 10:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA3B218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 10:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573209158;
	bh=Zrz2muJg2Wi+GRQmY5YrG97htwFJeAI4OLuBB+7I9q8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Qcu00nCguaLatywKZMWPoigwPvr0fyc89mEPst6sUiveLi9q+ExRY7HtjypFlySHe
	 5MjeWMUXnVPbfzg2lJok17BDVOYI54NknvBIs7MI6awqLv1Qcsd2ICFYMZXn++telO
	 nm+ZxfAIPkCMdyo67vrxYnymovh4gmWwdQsVHXpk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbfKHKch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 05:32:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:57400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfKHKcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 05:32:36 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2560221848;
        Fri,  8 Nov 2019 10:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573209156;
        bh=Zrz2muJg2Wi+GRQmY5YrG97htwFJeAI4OLuBB+7I9q8=;
        h=Date:From:To:Cc:Subject:From;
        b=VHgT/2EnB2SWziDwi5HEB34jb3w3+2Aq7SjBroebo0+uAw9zbBJ03g96pSSzC9sFK
         /c8qvBba/M45Qc4t7Kq1b6JhqeNY6yYVApR+hUWyCyKpWSqZFTjiXpx+2Yl5xdN5xn
         dQymNY83aVUX4OcEePulA5Y9b8AGI+V3S2HzOWSo=
Date:   Fri, 8 Nov 2019 10:32:31 +0000
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel Mailing List 
        <linux-arm-kernel@lists.infradead.org>
Subject: [GIT PULL] arm64: Fix for -rc7
Message-ID: <20191108103231.GA19153@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this single arm64 fix for -rc7. It's a revert of 747a70e60b72
("arm64: Fix copy-on-write referencing in HugeTLB"), not because that
patch was wrong, but because it was broken by aa57157be69f ("arm64: Ensure
VM_WRITE|VM_SHARED ptes are clean by default") which we merged in -rc6.

We spotted the issue in Android (AOSP), where one of the JIT threads gets
stuck on a write fault during boot because the faulting pte is marked as
PTE_DIRTY | PTE_WRITE | PTE_RDONLY and the fault handler decides that
there's nothing to do thanks to pte_same() masking out PTE_RDONLY.

Thanks to John Stultz for reporting this and testing this so quickly, and
to Steve Capper for confirming that the HugeTLB tests continue to pass.

Cheers,

Will

--->8

The following changes since commit 1cf45b8fdbb87040e1d1bd793891089f4678aa41:

  arm64: apply ARM64_ERRATUM_843419 workaround for Brahma-B53 core (2019-11-01 10:47:37 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 6767df245f4736d0cf0c6fb7cf9cf94b27414245:

  arm64: Do not mask out PTE_RDONLY in pte_same() (2019-11-06 19:31:56 +0000)

----------------------------------------------------------------
arm64 fix for -rc7

- Fix pte_same() to avoid getting stuck on write fault

----------------------------------------------------------------
Catalin Marinas (1):
      arm64: Do not mask out PTE_RDONLY in pte_same()

 arch/arm64/include/asm/pgtable.h | 17 -----------------
 1 file changed, 17 deletions(-)
