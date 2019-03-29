Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF7DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9082173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dt7wegrq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbfC2QbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:31:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53450 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729454AbfC2QbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 12:31:15 -0400
Received: by mail-wm1-f67.google.com with SMTP id q16so3137051wmj.3;
        Fri, 29 Mar 2019 09:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AD4Zq+VXx0GYrhfI0Z8qq8G3N5JLcbGHvDtfK/HmkcA=;
        b=Dt7wegrq63Gkl5pZrk+X/YE/3PjOSYepqXHYxBpc9q0n2C6p5n2gQm4Y5H6gfSaqVE
         rjBAYwn7Zgfq1HAnBxHP9XXBG6xk1wblaoeJz5fvPrwEA60/wjdIh9kESCg8XrDtsYP9
         kImUyost3ZAqM9e9GcNBqiCf+eAkwG8LqJivawlQIRCY56Sqds3KQzSewEb5SqSsEhRN
         /jihnTJHESzVMyrK2ii21eEn7FUgpBzLoAfrwQI3siGZ9BUnljQasDvBDzBaQ6a1x30G
         PQYTHiQ8+/Fz4HWj5ESTU4233MjnQ443XVyt/K4v81vSQJ8pKt3miMGgz1xjCnFAeN0h
         DCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AD4Zq+VXx0GYrhfI0Z8qq8G3N5JLcbGHvDtfK/HmkcA=;
        b=totLsxN5gJuj5NryVOA/4fjksxb7gvSZlJlstbTTwSuD6RS6opLAE3pHe5l5TwLhrW
         w7/C94rxUWkw5vH6UQd6nhwxelxtHI/ancVCJGFdSlt1se39X6NjEOjxWACPfHVXXh+7
         ouQ/A3HQhlcPDmNuGTU+JgE88E5JBPorLF2hYcOw+bBwSAmtf0+lV3VPj9g5i/JZqoMr
         1nfg3+Jiw3oL20HLWhsfdu0ud9do8NV+PgTUunuul7KlnKcXO9EqbERRSoE2tbwc+2ht
         Pt4wnhb+imHlvdNKNSpMnyvzMFYAcCeplMYYxial0N3U9ZDiAxL84rBteQ7kVP06EpH2
         6Xww==
X-Gm-Message-State: APjAAAV2g1r0HKGSsOC5H4X59T1PUUcQ43tT0kpNLx+k7mzGJ9lgo2xe
        7BIXavJZmJpBYIrEMqGuzlx59JbG
X-Google-Smtp-Source: APXvYqxRxs7gSt+KXahfxzte6iVaBGMpJRTY5EDu2Oj5rhpCm1aVNZ5KzgDK06KskR5jgBVPXek52Q==
X-Received: by 2002:a7b:c147:: with SMTP id z7mr4243607wmi.67.1553877073945;
        Fri, 29 Mar 2019 09:31:13 -0700 (PDT)
Received: from kwango.redhat.com (ovpn-brq.redhat.com. [213.175.37.11])
        by smtp.gmail.com with ESMTPSA id t81sm4753041wmb.5.2019.03.29.09.31.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 09:31:12 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 5.1-rc3
Date:   Fri, 29 Mar 2019 17:32:13 +0100
Message-Id: <20190329163213.17081-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 8c2ffd9174779014c3fe1f96d9dc3641d9175f00:

  Linux 5.1-rc2 (2019-03-24 14:02:26 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.1-rc3

for you to fetch changes up to daf5cc27eed99afdea8d96e71b89ba41f5406ef6:

  ceph: fix use-after-free on symlink traversal (2019-03-27 19:00:37 +0100)

----------------------------------------------------------------
A patch to avoid choking on multipage bvecs in the messenger and
a small use-after-free fix.

----------------------------------------------------------------
Al Viro (1):
      ceph: fix use-after-free on symlink traversal

Ilya Dryomov (1):
      libceph: fix breakage caused by multipage bvecs

 fs/ceph/inode.c      | 2 +-
 net/ceph/messenger.c | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)
