Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F9AC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5A720652
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="hGo7GNsl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfFTUMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 16:12:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38016 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfFTUMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 16:12:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id d18so4299469wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 13:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=VdcQzV8hHMC+GRuwgzaDFOvFEcR/ZhcEtfsV1R6kHb8=;
        b=hGo7GNsl0HiAU1hbh21l1NCenJJkZ1nlyY5fyr0zbW26fbKOnDMzm57KcF5Xx3/Wnr
         ndluRH2IUzg5PONnj47mHCMA20HqhjLS+UVbGHhvarFPRGZ5FALySChqq1c7uxMeRDUl
         qsLXnFmUuxQc26hSXmwn/EPVDucDzwMuM6vVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=VdcQzV8hHMC+GRuwgzaDFOvFEcR/ZhcEtfsV1R6kHb8=;
        b=eRhHpRolJ6gQVHSx4Qr5BX8QPZaGIrpg38LZG6UKRiSDYWtmK9Nu5jTg0Bl2bBR6F6
         Z2beaNiBu76Fo0nJUSsVkyksp1u2zuVUiQv3N3JmS3+6YvFrF1GV+hPOALJ6CD8hIZRK
         2RPKtJvQBCfYcPYI4958qOsLStO01QhfvNfPs71HaPSBq1v7M0qZrh4tg3uT57IoJaJa
         O/at+fSMvjIH827PEwKB8PACU7ZSePabNz5qf5qLH7n6eElHnHlCR4lGGgrIaJGAxqHH
         KUP5LFKrbE+VjVf5Kvti6UJmdH/LDfxn6vH0pB6osO8x4OhAvA2JatJy2ryX1F4GRD91
         t9tg==
X-Gm-Message-State: APjAAAXzTKtZJwVcy2gqbIXm29FZPvwvRaYO8nvo/lUMddjygqyQGNgQ
        Q1W8J3saVNBMpO6Qn4bJYqFupA==
X-Google-Smtp-Source: APXvYqzXUHs9wonUOK9Hkbxxy7TRb1JC73kE59bmEu6hG9Wd4C7L5ywUm3wDVFja7kReKiD4gkaRZw==
X-Received: by 2002:a05:6000:c9:: with SMTP id q9mr27260078wrx.208.1561061541415;
        Thu, 20 Jun 2019 13:12:21 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id f204sm836104wme.18.2019.06.20.13.12.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 13:12:20 -0700 (PDT)
Date:   Thu, 20 Jun 2019 22:12:18 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs fixes for 5.2-rc6
Message-ID: <20190620201218.GB10138@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-5.2-rc6

Fix two regressions in this cycle, and a couple of older bugs.

Thanks,
Miklos

----------------------------------------------------------------
Amir Goldstein (2):
      ovl: fix wrong flags check in FS_IOC_FS[SG]ETXATTR ioctls
      ovl: make i_ino consistent with st_ino in more cases

Arnd Bergmann (1):
      ovl: fix bogus -Wmaybe-unitialized warning

Miklos Szeredi (1):
      ovl: don't fail with disconnected lower NFS

Nicolas Schier (1):
      ovl: fix typo in MODULE_PARM_DESC

---
 fs/overlayfs/copy_up.c |  2 +-
 fs/overlayfs/dir.c     |  2 +-
 fs/overlayfs/file.c    | 91 +++++++++++++++++++++++++++++++++++---------------
 fs/overlayfs/inode.c   | 12 +++----
 fs/overlayfs/super.c   | 42 ++++++++++-------------
 5 files changed, 90 insertions(+), 59 deletions(-)
