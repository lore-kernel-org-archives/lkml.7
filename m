Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D3BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 15:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C0321E6F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 15:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572018921;
	bh=Nw4tcBEy3DU9heHAkhjNFAQuKkoY5IaSyDmY66cQMCo=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Nmd8lKdGE86Bo5u0pGw4vNHugt+FvRiKphxOyeFOhZy9onrnA1C0XI2GcQrMKaLms
	 4/216bVzw0XsUsOVHpNYnwrWWt+bKHBz4gaFArY0IT3WXxEM1oEbhNkdqNZ6WXO9od
	 rp7YhfZQHsW76gB45B3FeSl1sWEROO5yapem8Oa4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395547AbfJYPzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 11:55:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388846AbfJYPzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 11:55:19 -0400
Received: from linux-8ccs (ip5f5adbc4.dynamic.kabel-deutschland.de [95.90.219.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5365B21D82;
        Fri, 25 Oct 2019 15:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572018918;
        bh=Nw4tcBEy3DU9heHAkhjNFAQuKkoY5IaSyDmY66cQMCo=;
        h=Date:From:To:Cc:Subject:From;
        b=chgH956Bw7NG2P8+Xa+XBs5lyvvGU5pYJ5dZbXv2GbxqGQbY+PZTHJ2Z5C9fyOt68
         f+b4GTMvps70lC4QGUB29wPxTtCELllUERclYCjUcTygR2SESPoKZwUXsfUJf+Asqy
         mPghncrIY8uPkb+W8Cg5qWekXDHhaxHS8u4DGsds=
Date:   Fri, 25 Oct 2019 17:55:13 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthias Maennich <maennich@google.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Modules fixes for v5.4-rc5
Message-ID: <20191025155512.GA30503@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this small set of fixes for v5.4-rc5. As usual, details
can be found in the signed tag.

Thanks!

Jessica

---

The following changes since commit 4f5cafb5cb8471e54afdc9054d973535614f7675:

  Linux 5.4-rc3 (2019-10-13 16:37:36 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.4-rc5

for you to fetch changes up to 09684950050be09ed6cd591e6fbf0c71d3473237:

  scripts/nsdeps: use alternative sed delimiter (2019-10-23 11:21:06 +0200)

----------------------------------------------------------------
Modules fixes for v5.4-rc5

- Revert __ksymtab_$namespace.$symbol naming scheme back to
  __ksymtab_$symbol, as it was causing issues with depmod. Instead,
  have modpost extract a symbol's namespace from __kstrtabns and
  __ksymtab_strings.

- Fix `make nsdeps` for out of tree kernel builds (make O=...) caused by
  unescaped '/'. Use a different sed delimiter to avoid this problem.

Signed-off-by: Jessica Yu <jeyu@kernel.org>

----------------------------------------------------------------
Jessica Yu (1):
      scripts/nsdeps: use alternative sed delimiter

Matthias Maennich (3):
      modpost: delegate updating namespaces to separate function
      modpost: make updating the symbol namespace explicit
      symbol namespaces: revert to previous __ksymtab name scheme

 include/linux/export.h | 14 +++++-------
 scripts/mod/modpost.c  | 59 ++++++++++++++++++++++++++++++++++----------------
 scripts/mod/modpost.h  |  1 +
 scripts/nsdeps         |  2 +-
 4 files changed, 47 insertions(+), 29 deletions(-)
