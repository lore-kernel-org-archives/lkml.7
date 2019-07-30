Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BC3C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C582171F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564508817;
	bh=XxM24s4XSayOjNPRJ7HKhR4zMsXlLabaIKs2PVhefD8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ziL7N0lSY8JhaTZpimkykYxAjw3kiTcKJTfSPWoEvpTnp9tEfWMsZ0KLi5r7dvRLT
	 25gRns9BiSfDc0wIhBqOI1MOQfRr7rdUxhbsRFRwzDpg0Sidz363QqL3KpKisfZOwO
	 wqJhEDhCMbfWN2fQmYv4AJ90R1ZtxAqs1V/SF/xQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbfG3Rqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:46:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbfG3Rqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:46:55 -0400
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C08F7216C8;
        Tue, 30 Jul 2019 17:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564508814;
        bh=XxM24s4XSayOjNPRJ7HKhR4zMsXlLabaIKs2PVhefD8=;
        h=Date:From:To:Cc:Subject:From;
        b=N4R7R1vSfUZLkDaIYHS0DO5SLEgIBeQOk438LX7yu37suVf2Jn0AUR3JAwfiNM3Qv
         T3iiAAYpjH4xY+QbnGNdHtQZHeEjR9H+808iWwuvRR+tc9qr7u/b22DPLmdbbuypGJ
         egKR8Ry3or+UFcVy5zczFkQU/VS0wFgpvHcyR884=
Date:   Tue, 30 Jul 2019 10:46:53 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] f2fs-for-5.4-rc3
Message-ID: <20190730174653.GA76478@jaegeuk-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you please merge this to address some fixes introduced in 5.4-rc1?

Thanks,

The following changes since commit 964a4eacef67503a1154f7e0a75f52fbdce52022:

  Merge tag 'dlm-5.3' of git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm (2019-07-12 17:37:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.4-rc3

for you to fetch changes up to 38fb6d0ea34299d97b031ed64fe994158b6f8eb3:

  f2fs: use EINVAL for superblock with invalid magic (2019-07-28 22:59:14 -0700)

----------------------------------------------------------------
f2fs-for-5.4-rc3

This set of patches adjust to follow recent setflags changes and fix two
regression introduced since 5.4-rc1.

----------------------------------------------------------------
Eric Biggers (3):
      f2fs: use generic checking and prep function for FS_IOC_SETFLAGS
      f2fs: use generic checking function for FS_IOC_FSSETXATTR
      f2fs: remove redundant check from f2fs_setflags_common()

Icenowy Zheng (1):
      f2fs: use EINVAL for superblock with invalid magic

Jaegeuk Kim (1):
      f2fs: fix to read source block before invalidating it

 fs/f2fs/file.c  | 63 +++++++++++++++++++--------------------------------
 fs/f2fs/gc.c    | 70 ++++++++++++++++++++++++++++-----------------------------
 fs/f2fs/super.c | 48 +++++++++++++++++++--------------------
 3 files changed, 81 insertions(+), 100 deletions(-)
