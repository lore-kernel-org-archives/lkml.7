Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82773C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 19:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6C821537
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 19:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RblqYiQ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfFHTEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 15:04:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32829 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbfFHTEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 15:04:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so5328583wru.0;
        Sat, 08 Jun 2019 12:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A3Hudhze4ozjG5nDlaCCw5DZCvRef03puHwfaHxWkTk=;
        b=RblqYiQ7DnCzvDoe2qNNYKDkb1xlqJtaFqAHNiNZFCeXdQSBQ7Sh80gGKiKAyqVsOw
         laWoZOR8K2bYhiIutSWHlgvlq7YA3yoq+7alfoWxkGlEgLFpTci3fAxGT+/3XTSlQXdH
         xkyCFGCl5UgPHe4tpdWecRlIMl6lL9kr8uaU+SSOhgvgPe3NfPRSu7gkfzZpKQm7OpXK
         oQIvxsE2phcxJ35vzsuHN9kzpwud+RwMcckQFnVlKRjGFPbLobtwGYKijgQM7U3y4Lu+
         59kFsk3v3PXgs9Zo7GKHEayORMs1NolT5pMnGvYLhfJZM3KcvgI7zg9ktldsJtckAr7T
         KI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A3Hudhze4ozjG5nDlaCCw5DZCvRef03puHwfaHxWkTk=;
        b=NcNXMZAl0x0ZGWvt/3sHZs0fNF+EauH9Uqa9Yz6jkddUqUSWfxIn9mfmkvFIRgig3k
         84GzM9Ha0+WJTmSmFV93ccX21nTltbwOOBmPFTkwGflnK/ZySnLsGNO9hrcAldLPnBR5
         aXhRhTNzbr3gNEziylW6WdQfA5Hd6wWz8onWGFelUD7BsXfSNF3wWS1B3baKyJtJ8+z7
         PCo+ZBfk8Uy4nhY5ThKS5m1uuRG97UKbd/npE+3nJlyQAN+u6j5VboiLKSkY2Ou3pYcv
         /Lt1jn83r210/gY2uoAAOQVHp7bYNHtSFcIl88uIVcQYVc08Vv6tYrg0kkOtVDhmg2+w
         dpzQ==
X-Gm-Message-State: APjAAAWAM+6p6IK9xXV3KUdldcJ8HMCf80Pus3mVmXgFSwTTRsukGacs
        Sh4xmzA1F8dAaKyRPhJkOfhz76F5
X-Google-Smtp-Source: APXvYqzsI3eay4SJpxc6HMysG8GiIaym+9fSnDnGjwhZmJvwS04ahED3cgLuDiFP9FbRVWrqQv0TKA==
X-Received: by 2002:adf:f951:: with SMTP id q17mr11373995wrr.173.1560020680217;
        Sat, 08 Jun 2019 12:04:40 -0700 (PDT)
Received: from kwango.local (ip-89-102-68-197.net.upcbroadband.cz. [89.102.68.197])
        by smtp.gmail.com with ESMTPSA id l4sm4294060wmh.18.2019.06.08.12.04.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 08 Jun 2019 12:04:39 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 5.2-rc4
Date:   Sat,  8 Jun 2019 21:04:38 +0200
Message-Id: <20190608190438.7665-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a:

  Linux 5.2-rc3 (2019-06-02 13:55:33 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.2-rc4

for you to fetch changes up to 7b2f936fc8282ab56d4d21247f2f9c21607c085c:

  ceph: fix error handling in ceph_get_caps() (2019-06-05 20:34:39 +0200)

----------------------------------------------------------------
A change to call iput() asynchronously to avoid a possible deadlock
when iput_final() needs to wait for in-flight I/O (e.g. readahead) and
a fixup for a cleanup that went into -rc1.

----------------------------------------------------------------
Yan, Zheng (3):
      ceph: single workqueue for inode related works
      ceph: avoid iput_final() while holding mutex or in dispatch thread
      ceph: fix error handling in ceph_get_caps()

 fs/ceph/caps.c       |  34 ++++++-----
 fs/ceph/file.c       |   2 +-
 fs/ceph/inode.c      | 155 +++++++++++++++++++++++++++------------------------
 fs/ceph/mds_client.c |  28 ++++++----
 fs/ceph/quota.c      |   9 ++-
 fs/ceph/snap.c       |  16 ++++--
 fs/ceph/super.c      |  28 +++-------
 fs/ceph/super.h      |  19 ++++---
 8 files changed, 156 insertions(+), 135 deletions(-)
