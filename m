Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E479C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B9D206CC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574347455;
	bh=1Qk5HeJMxRAqIMfETtKX9MkDQlQjopSGtDl5zCocUT8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=s/WkMS2z7ZHKwlnGaEhLmo4CCFK1ai8fUPJX/20RfXHW0C7IVfWhuONByazWlG+E/
	 EDFeM2JzrV8Uksc98T4jLUtvHBnaKoeeFIOtMXVwIMlmA8aAo/1BcE5jkifw9uMNOe
	 lM6R+CFcObmSMvEmVf1K56GUNCEQqwTg/c+XqC2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfKUOoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 09:44:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:59810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfKUOoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 09:44:13 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AA80206B6;
        Thu, 21 Nov 2019 14:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574347453;
        bh=1Qk5HeJMxRAqIMfETtKX9MkDQlQjopSGtDl5zCocUT8=;
        h=Date:From:To:Cc:Subject:From;
        b=PfWCmFp5fy5zWJFIF3HdDpyRz/FwjHFC2Bm6yqOOrhcVXjiZXGslTVG5IppnOemXD
         2hWwaxLgFjuvf3FXd2tgl35gUoZF4cgqAyw3eS1JD8qEk7EczZ4hE0Cu1+Xsk8PwE2
         svwg3VP2o+HeZBc0dyWaRZy3m0pt7Hk7IaD1cVZI=
Date:   Thu, 21 Nov 2019 14:44:08 +0000
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel Mailing List 
        <linux-arm-kernel@lists.infradead.org>, gregkh@linuxfoundation.org
Subject: [GIT PULL] arm64: Another fix for 5.4
Message-ID: <20191121144408.GA3751@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

After I thought we were done for 5.4, we had a report this week of a nasty
issue that has been shown to leak data between different user address spaces
thanks to corruption of entries in the TLB. In hindsight, we should have
spotted this in review when the PAN code was merged back in v4.3, but
hindsight is 20/20 and I'm trying not to beat myself up too much about it
despite being fairly miserable.

Anyway, the fix is "obvious" but the actual failure is more more subtle,
and is described in the commit message. I've included a fairly mechanical
follow-up patch here as well, which moves this checking out into the C
wrappers which is what we do for {get,put}_user() already and allows us
to remove these bloody assembly macros entirely. The patches have passed
kernelci [1] [2] [3] and CKI [4] tests over night, as well as some
targetted testing [5] for this particular issue.

The first patch is tagged for stable and should be applied to 4.14, 4.19
and 5.3. I have separate backports for 4.4 and 4.9, which I'll send out
once this has landed in your tree (although the original patch applies
cleanly, it won't build for those two trees).

Thanks to Pavel Tatashin for reporting this and Mark Rutland for helping
to diagnose the issue and review/test the solution. Please pull.

Will

[1] https://lore.kernel.org/lkml/5dd5f064.1c69fb81.5e209.59cf@mx.google.com
[2] https://lore.kernel.org/lkml/5dd5faae.1c69fb81.9bfcb.6f62@mx.google.com
[3] https://lore.kernel.org/lkml/5dd5fab1.1c69fb81.22bb5.755e@mx.google.com
[4] https://lore.kernel.org/lkml/cki.1CBC43ABCD.523Q7TUX64@redhat.com
[5] https://lore.kernel.org/lkml/CA+CK2bCX+QGMPzhjj-UmVNb1jG8Z6WNW=L0GiVsTpGrhyqb9tA@mail.gmail.com

--->8

The following changes since commit 65e1f38d9a2f07d4b81f369864c105880e47bd5a:

  scripts/tools-support-relr.sh: un-quote variables (2019-11-13 10:52:05 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to e50be648aaa3da196d4f4ed49d1c5d4ec105fa4a:

  arm64: uaccess: Remove uaccess_*_not_uao asm macros (2019-11-20 18:51:54 +0000)

----------------------------------------------------------------
arm64 fix for 5.4

- Ensure PAN is re-enabled following user fault in uaccess routines

----------------------------------------------------------------
Pavel Tatashin (2):
      arm64: uaccess: Ensure PAN is re-enabled after unhandled uaccess fault
      arm64: uaccess: Remove uaccess_*_not_uao asm macros

 arch/arm64/include/asm/asm-uaccess.h | 17 -----------------
 arch/arm64/include/asm/uaccess.h     | 27 ++++++++++++++++++++++-----
 arch/arm64/lib/clear_user.S          |  2 --
 arch/arm64/lib/copy_from_user.S      |  2 --
 arch/arm64/lib/copy_in_user.S        |  2 --
 arch/arm64/lib/copy_to_user.S        |  2 --
 arch/arm64/lib/uaccess_flushcache.c  |  6 +++++-
 7 files changed, 27 insertions(+), 31 deletions(-)
