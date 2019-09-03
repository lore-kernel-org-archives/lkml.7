Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB13C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E170022CF7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbfICLgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 07:36:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33606 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbfICLgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:36:45 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 10ABB2A09BA
        for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2019 11:36:45 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id t16so10324987wro.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 04:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QGcPW4T34ae7tNxlUwxnVZ0/61lVgJvDaZezCMEfty0=;
        b=h+EntLs9FRIDRiMGByunJCRGfitUkbtZlYNEepZL9w9iHiQ+cHOvNaFpNsnoW23VPD
         A8UPTYJTiLvY68Xp1fQhwKxYm9XKNqNrB6DP30Fo4yOiVFgrLcUhV1P38OqBmoTCaXve
         vXk9HwhWbN4vR05klGOSkHVBjy1QAWq1ogjbDlpFuMTlnVsP84RBAyQXweTOXZdLSgRw
         3QIf9XbIi8/KySw+KvPVOOA0whCPMEELfWBSnEDcGZcsfnPZEuaTnf0kzL4l+RKIawZX
         H83i1gS2JyPt8dvyTTfOmtDhbA5tWvs5fyyquXlh0wd6ALKZNNMyl1z1uPYZt33XLI6L
         oq7A==
X-Gm-Message-State: APjAAAVe4tIDEgqig+rcmz3w0POtJIhP+7LkMoHG4y1Zqkp3xFx8+iu9
        93hTrvlJr9MDeLcAbfu+4s0dQD5XOVnuIj4d2lcbWHW99YJ50FxWnw6yjuHAb9Hn9AkW5y6XHtN
        bmxWU5fu/HEtMnhqe8AR4LuU3
X-Received: by 2002:a1c:d10b:: with SMTP id i11mr3687302wmg.8.1567510603833;
        Tue, 03 Sep 2019 04:36:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyzWjg0szrb+YUGwCwQvjNCX1ob1wbHEAcXkUzc8v8wkG64USQFu1THbZDWaltyHnhnlFKCgg==
X-Received: by 2002:a1c:d10b:: with SMTP id i11mr3687281wmg.8.1567510603655;
        Tue, 03 Sep 2019 04:36:43 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id v186sm40446906wmb.5.2019.09.03.04.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 04:36:43 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v4 00/16] virtio-fs: shared file system for virtual machines
Date:   Tue,  3 Sep 2019 13:36:24 +0200
Message-Id: <20190903113640.7984-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Posting latest version to virtio mailing list as well.  I guess patches 15
and 16 are most interesting to the virt community.

The reasons for creating a new fs are spelled out in the previous posting:

https://lore.kernel.org/linux-fsdevel/20190821173742.24574-1-vgoyal@redhat.com/

Git tree for this version is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#virtiofs-v4

Thanks,
Miklos

---
David Howells (3):
  vfs: Create fs_context-aware mount_bdev() replacement
  fuse: convert to use the new mount API
  vfs: subtype handling moved to fuse

Miklos Szeredi (2):
  fuse: delete dentry if timeout is zero
  fuse: dissociate DESTROY from fuseblk

Stefan Hajnoczi (7):
  fuse: export fuse_end_request()
  fuse: export fuse_len_args()
  fuse: export fuse_get_unique()
  fuse: extract fuse_fill_super_common()
  fuse: add fuse_iqueue_ops callbacks
  virtio-fs: add virtiofs filesystem
  virtio-fs: add Documentation/filesystems/virtiofs.rst

Vivek Goyal (4):
  fuse: export fuse_send_init_request()
  fuse: export fuse_dequeue_forget() function
  fuse: separate fuse device allocation and installation in fuse_conn
  fuse: allow skipping control interface and forced unmount

 Documentation/filesystems/index.rst    |   10 +
 Documentation/filesystems/virtiofs.rst |   60 ++
 MAINTAINERS                            |   11 +
 fs/fs_context.c                        |   16 +-
 fs/fuse/Kconfig                        |   11 +
 fs/fuse/Makefile                       |    1 +
 fs/fuse/cuse.c                         |    4 +-
 fs/fuse/dev.c                          |   93 +-
 fs/fuse/dir.c                          |   28 +-
 fs/fuse/fuse_i.h                       |  118 ++-
 fs/fuse/inode.c                        |  464 +++++-----
 fs/fuse/virtio_fs.c                    | 1072 ++++++++++++++++++++++++
 fs/namespace.c                         |    2 -
 fs/proc_namespace.c                    |    2 +-
 fs/super.c                             |  116 ++-
 include/linux/fs_context.h             |   10 +-
 include/uapi/linux/virtio_fs.h         |   19 +
 include/uapi/linux/virtio_ids.h        |    1 +
 18 files changed, 1774 insertions(+), 264 deletions(-)
 create mode 100644 Documentation/filesystems/virtiofs.rst
 create mode 100644 fs/fuse/virtio_fs.c
 create mode 100644 include/uapi/linux/virtio_fs.h

-- 
2.21.0

