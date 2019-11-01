Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6922CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 14:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE45C21734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 14:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572618767;
	bh=awMAnw9Qq2gBQEeEgcYC7CS6pz44jp0V0kf6PkvwF+c=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=dW/PNW/cyBRq12V18jYJTqvXAhKFoq3ujiPAaUKDGgKzfZkuf6IEVEs0Ak0V7cKPg
	 wBEXeM7TbYCYea3L4CPORkwaXCD/A0VUZL1E7sNkEyju+NCBQzyEpQZBRIqaCgNgGG
	 nsrBY2R9DxR5/wg0v2277tcFdkFeAUsMUjH/KnnU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfKAOcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 10:32:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbfKAOcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 10:32:46 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7153120862;
        Fri,  1 Nov 2019 14:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572618765;
        bh=awMAnw9Qq2gBQEeEgcYC7CS6pz44jp0V0kf6PkvwF+c=;
        h=Date:From:To:Cc:Subject:From;
        b=ry9apcOW3hjwZVKiKAmkcHGbORCoYyIuehNaDmc/LW5REQPkKsJObcxnWHdyYbg/f
         vt2KQcCJU/bGqsctJdzBipw1NzQ56ctc2kuHWYdehk12LpkkBK/W4aqMCFwA1witTG
         FjGBtkfEZE2I/sGiS4Uzui1t4iN7dkfwLL741jqc=
Date:   Fri, 1 Nov 2019 14:32:40 +0000
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel Mailing List 
        <linux-arm-kernel@lists.infradead.org>, peterz@infradead.org
Subject: [GIT PULL] arm64: Fixes for -rc6
Message-ID: <20191101143240.GA3287@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these arm64 fixes for -rc6. They're almost exclusively
related to CPU errata in CPUs from Broadcom and Qualcomm where the
workarounds were either not being enabled when they should have been or
enabled when they shouldn't have been. The only "interesting" fix is
ensuring that writeable, shared mappings are initially mapped as clean
since we inadvertently broke the logic back in v4.14 and then noticed
the problem via code inspection the other day.

The only critical issue we have outstanding is a sporadic NULL
dereference in the scheduler, which doesn't appear to be arm64-specific
and PeterZ is tearing his hair out over it at the moment.

Cheers,

Will

--->8

The following changes since commit 777d062e5bee0e3c0751cdcbce116a76ee2310ec:

  Merge branch 'errata/tx2-219' into for-next/fixes (2019-10-17 13:42:42 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 1cf45b8fdbb87040e1d1bd793891089f4678aa41:

  arm64: apply ARM64_ERRATUM_843419 workaround for Brahma-B53 core (2019-11-01 10:47:37 +0000)

----------------------------------------------------------------
arm64 fixes for -rc6

- Enable CPU errata workarounds for Broadcom Brahma-B53

- Enable CPU errata workarounds for Qualcomm Hydra/Kryo CPUs

- Fix initial dirty status of writeable, shared mappings

----------------------------------------------------------------
Bjorn Andersson (2):
      arm64: cpufeature: Enable Qualcomm Falkor/Kryo errata 1003
      arm64: cpufeature: Enable Qualcomm Falkor errata 1009 for Kryo

Catalin Marinas (1):
      arm64: Ensure VM_WRITE|VM_SHARED ptes are clean by default

Doug Berger (1):
      arm64: apply ARM64_ERRATUM_845719 workaround for Brahma-B53 core

Florian Fainelli (2):
      arm64: Brahma-B53 is SSB and spectre v2 safe
      arm64: apply ARM64_ERRATUM_843419 workaround for Brahma-B53 core

 Documentation/arm64/silicon-errata.rst |  7 +++-
 arch/arm64/include/asm/cputype.h       |  2 ++
 arch/arm64/include/asm/pgtable-prot.h  | 15 +++++----
 arch/arm64/kernel/cpu_errata.c         | 59 +++++++++++++++++++++++++++-------
 4 files changed, 64 insertions(+), 19 deletions(-)
