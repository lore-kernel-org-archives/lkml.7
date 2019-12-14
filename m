Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7F3C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 15:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69EC6214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 15:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576337333;
	bh=3i3TJGlWnxTn79DIaJC4lzjFScVGz3jYaZBKCKe9FIk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=oTB/4r43YRC7gxBrcxQ7RBFg0aQ99cvOyWnSufVzW+TRSo1h5ZZmiKWLpz7j8VAAj
	 ieAYeIdwzXsxibuCeu3NvwTQcK9kcLom6dTrqsi5pXXDtIDRDdH+ZjXafE/FDAZPXU
	 RAadhn47aE2G+6eIUYOxTrZ1UY9OgLrNqirdzXUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfLNP2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 10:28:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:35370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbfLNP2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 10:28:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06707214AF;
        Sat, 14 Dec 2019 15:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576337330;
        bh=3i3TJGlWnxTn79DIaJC4lzjFScVGz3jYaZBKCKe9FIk=;
        h=Date:From:To:Cc:Subject:From;
        b=kIFbaNPOeiVez5C2G8X4UEY2h+MAyRcNQ432eHWbJJz5Mf2LLdePgwNSaZA0Aic0F
         E32rUtfQ4F+hMR7nxVnu90/siF8yvG0BwcrZqs5HRKiWUQQA1UGxWXt/DYYLEUJHmz
         SLRO3b+8TIWwmHgIhU8IB+fSaDB4fwco+RH6ieO8=
Date:   Sat, 14 Dec 2019 16:28:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.5-rc2
Message-ID: <20191214152848.GA3460394@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9455d25f4e3b3d009fa1b810862e5b06229530e4:

  Merge tag 'ntb-5.5' of git://github.com/jonmason/ntb (2019-12-07 18:38:17 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.5-rc2

for you to fetch changes up to 16981742717b04644a41052570fb502682a315d2:

  binder: fix incorrect calculation for num_valid (2019-12-14 09:10:47 +0100)

----------------------------------------------------------------
Char/Misc driver fixes for 5.5-rc2

Here are 6 small fixes for some reported char/misc driver issues:
 - fix build warnings with new 'awk' with the raid6 code
 - 4 interconnect driver bugfixes
 - binder fix for reported problem

All of these except the binder fix have been in linux-next with no
reported issues.  The binder fix is "new" but Todd says it is good as he
has tested it :)

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Georgi Djakov (3):
      interconnect: qcom: sdm845: Walk the list safely on node removal
      interconnect: qcom: qcs404: Walk the list safely on node removal
      interconnect: qcom: msm8974: Walk the list safely on node removal

Greg Kroah-Hartman (1):
      lib: raid6: fix awk build warnings

Krzysztof Kozlowski (1):
      interconnect: qcom: Fix Kconfig indentation

Todd Kjos (1):
      binder: fix incorrect calculation for num_valid

 drivers/android/binder.c            |  4 ++--
 drivers/interconnect/qcom/Kconfig   | 14 +++++++-------
 drivers/interconnect/qcom/msm8974.c |  8 ++++----
 drivers/interconnect/qcom/qcs404.c  |  8 ++++----
 drivers/interconnect/qcom/sdm845.c  |  4 ++--
 lib/raid6/unroll.awk                |  2 +-
 6 files changed, 20 insertions(+), 20 deletions(-)
