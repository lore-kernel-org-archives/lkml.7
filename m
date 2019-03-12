Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBED3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1479205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEEQY+oe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbfCLRun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:50:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47002 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbfCLRuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:50:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id 33so1188960wrb.13;
        Tue, 12 Mar 2019 10:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U5H87K+0hZuPhmG7X2EXyxxT6697Qv0pSATHJuibIJs=;
        b=JEEQY+oeurvv/BpaezxaL/Y3G3ZesGFv2obTNfLftR3gX6JHfWkAbZ0L5fAjMNOvCc
         8jmNk9UTBbMmbNMn5DMgJf8vLiVK5+SwWV/13A4+V1J+JyQi1W9gU8vrWwLdBXWf48c5
         RIlwulFFo5AYRJAMenO6uEYd+Q2IpprMlPFv/bWkN3LlFvcAAP+1Wr4UkqsLfkMOy62v
         TVppokQd43YK+TSwXSQtBZ5I56reVOD2H4ZzlKDSY+P6jwvg2iial3Qr94JlDnV3F3rF
         gtbJMO+4QnWlfxe0t1QgN9nGG1dONxBn2k9q+11xwBpHecyfrrqGlonP/kLA52yZGkUI
         LHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U5H87K+0hZuPhmG7X2EXyxxT6697Qv0pSATHJuibIJs=;
        b=uE6Y9bAiGSeSgdpHEzR+FluCGWCH8hnAcPX8Lh+w2MtS5oHC6Qf/OQEQvmuxuN9+Ou
         a9uS7aVU1DEqfgWT+Q2KcpFNoShMXNunulHcG9zd8YeSp9EXZaHGeTk8Uk1M7A5OgFTH
         f0NBAq0L7mZukFd5EOFgW6ZjqQEfqaAmDsGd0l5Y/fs59PKWkVEObclVNnSoqYcPKnez
         c9ZDoKI15gMREp2E7SREWgdQQ3d1Ra8IdExGp+kv0SCPJgibDVCy/jFlG23N2tGNDxfZ
         9T/SGCwzKl+smLX8HB+ePJvDhr13OtqtB1vGa5PjpeWcyqCExMPJd/bKdR81nofT6yxy
         kNow==
X-Gm-Message-State: APjAAAWP50NQKBqa/5UTC4O69UT0kk9gbL9keYllVx3y/h6sQ2MnDLJz
        V9NCFn5p37nFplu9qtrld0O+TySR
X-Google-Smtp-Source: APXvYqynE3a8iN/rVAVk5sUcUFShHACSMSJ9BLBy0hV7JdvfHRA+C0vUkfdKzRNXW0cmcTAxoQ3pFw==
X-Received: by 2002:a5d:6643:: with SMTP id f3mr4463920wrw.120.1552413038565;
        Tue, 12 Mar 2019 10:50:38 -0700 (PDT)
Received: from kwango.redhat.com (ip-89-102-68-132.net.upcbroadband.cz. [89.102.68.132])
        by smtp.gmail.com with ESMTPSA id y5sm3426621wmg.31.2019.03.12.10.50.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 10:50:37 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph updates for 5.1-rc1
Date:   Tue, 12 Mar 2019 18:50:17 +0100
Message-Id: <20190312175017.27764-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 1c163f4c7b3f621efff9b28a47abb36f7378d783:

  Linux 5.0 (2019-03-03 15:21:29 -0800)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.1-rc1

for you to fetch changes up to d11ae8e0a76afc506071831854348f2ea1f3290e:

  Documentation: modern versions of ceph are not backed by btrfs (2019-03-05 18:55:18 +0100)

----------------------------------------------------------------
The highlights are:

- rbd will now ignore discards that aren't aligned and big enough to
  actually free up some space (myself).  This is controlled by the new
  alloc_size map option and can be disabled if needed.

- support for rbd deep-flatten feature (myself).  Deep-flatten allows
  "rbd flatten" to fully disconnect the clone image and its snapshots
  from the parent and make the parent snapshot removable.

- a new round of cap handling improvements (Zheng Yan).  The kernel
  client should now be much more prompt about releasing its caps and
  it is possible to put a limit on the number of caps held.

- support for getting ceph.dir.pin extended attribute (Zheng Yan)

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      libceph: use struct_size() for kmalloc() in crush_decode()

Ilya Dryomov (11):
      rbd: get rid of obj_req->obj_request_count
      rbd: handle DISCARD and WRITE_ZEROES separately
      rbd: round off and ignore discards that are too small
      rbd: remove experimental designation from kernel layering
      rbd: clear ->xferred on error from rbd_obj_issue_copyup()
      rbd: factor out __rbd_osd_req_create()
      rbd: stop copying num_osd_ops in rbd_obj_issue_copyup()
      rbd: introduce rbd_obj_issue_copyup_ops()
      rbd: copyup with an empty snapshot context (aka deep-copyup)
      rbd: whole-object write and zeroout should copyup when snapshots exist
      rbd: advertise support for RBD_FEATURE_DEEP_FLATTEN

Jeff Layton (1):
      Documentation: modern versions of ceph are not backed by btrfs

Yan, Zheng (12):
      ceph: set special inode's blocksize to page size
      ceph: decode feature bits in session message
      ceph: split large reconnect into multiple messages
      ceph: map snapid to anonymous bdev ID
      ceph: support versioned reply
      ceph: support getting ceph.dir.pin vxattr
      ceph: send cap releases more aggressively
      ceph: touch existing cap when handling reply
      ceph: remove dentry_lru file from debugfs
      ceph: delete stale dentry when last reference is dropped
      ceph: periodically trim stale dentries
      ceph: add mount option to limit caps count

zhengbin (1):
      ceph: pass inclusive lend parameter to filemap_write_and_wait_range()

 Documentation/filesystems/ceph.txt |  14 +-
 drivers/block/rbd.c                | 400 +++++++++++++++------
 fs/ceph/caps.c                     |  72 ++--
 fs/ceph/debugfs.c                  |  27 --
 fs/ceph/dir.c                      | 455 +++++++++++++++++++-----
 fs/ceph/file.c                     |  13 +-
 fs/ceph/inode.c                    |  52 +--
 fs/ceph/mds_client.c               | 698 ++++++++++++++++++++++++++++++-------
 fs/ceph/mds_client.h               |  43 ++-
 fs/ceph/snap.c                     | 159 ++++++++-
 fs/ceph/super.c                    |  21 +-
 fs/ceph/super.h                    |  43 ++-
 fs/ceph/xattr.c                    |  20 +-
 include/linux/ceph/types.h         |   1 +
 net/ceph/osdmap.c                  |   5 +-
 15 files changed, 1597 insertions(+), 426 deletions(-)
