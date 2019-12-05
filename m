Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C30BC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 20:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE39622525
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 20:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575576592;
	bh=USSjoL2d/6C7E7Uvcfhh2dJ3WJSMBVDato15nqiHGcY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=fyzmIaIXPML0MyAnXYxvQVGfCXhelju2kIg/Q4V1l/z7jC5jWiHJrx/3QQ8xGDfvO
	 CNmYZYhnzmgoe4dqtNpkBF5Fc3zJcnvi9GMKKPRwi/6ttlQdjoHw9Rcno4wZZ1A6Mr
	 9bTyUrQtr+KhOSVqIzgjL+AtU7Xn2+j+qCtZnaP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbfLEUJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 15:09:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:37992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729396AbfLEUJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 15:09:51 -0500
Received: from linux-8ccs (ip-109-41-192-234.web.vodafone.de [109.41.192.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D0E0206D9;
        Thu,  5 Dec 2019 20:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575576590;
        bh=USSjoL2d/6C7E7Uvcfhh2dJ3WJSMBVDato15nqiHGcY=;
        h=Date:From:To:Cc:Subject:From;
        b=Lvbjy/VoUkB9I7HZT86JibUb68VpIuTNEsxO+Gd5vkbluSRhEnuXdwM/3rzK1Swze
         V3wuXRPZjmVTHUEjGVAB+T3wpP492DbVZiTvykGUgCqJEdQJN1vpwWUBhiuthKJXUi
         LJG1ajV0efHv8ZtRyb5G6nrp/JFBDujNo/uS+aT4=
Date:   Thu, 5 Dec 2019 21:09:45 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Modules updates for v5.5
Message-ID: <20191205200945.GA1750@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull below to receive modules updates for the 5.5 merge window.
Details can be found in the signed tag.

Thanks,

Jessica

---
The following changes since commit d6d5df1db6e9d7f8f76d2911707f7d5877251b02:

  Linux 5.4-rc5 (2019-10-27 13:19:19 -0400)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.5

for you to fetch changes up to 5d603311615f612320bb77bd2a82553ef1ced5b7:

  kernel/module.c: wakeup processes in module_wq on module unload (2019-11-15 11:23:12 +0100)

----------------------------------------------------------------
Modules updates for v5.5

Summary of modules changes for the 5.5 merge window:

- Refactor include/linux/export.h and remove code duplication between
  EXPORT_SYMBOL and EXPORT_SYMBOL_NS to make it more readable. The most
  notable change is that no namespace is represented by an empty string ""
  rather than NULL.

- Fix a module load/unload race where waiter(s) trying to load the same
  module weren't being woken up when a module finally goes away.

Signed-off-by: Jessica Yu <jeyu@kernel.org>

----------------------------------------------------------------
Konstantin Khorenko (1):
      kernel/module.c: wakeup processes in module_wq on module unload

Masahiro Yamada (1):
      export: avoid code duplication in include/linux/export.h

Zhenzhong Duan (1):
      moduleparam: fix parameter description mismatch

 include/linux/export.h      | 91 ++++++++++++++-------------------------------
 include/linux/moduleparam.h |  4 +-
 kernel/module.c             |  4 +-
 3 files changed, 33 insertions(+), 66 deletions(-)
