Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF65C49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69105206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391015AbfIJPML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 11:12:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:63479 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728878AbfIJPML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 11:12:11 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EAD754F1DC
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 15:12:10 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id r21so3691wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 08:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ok77DmKuwYWR/+jMK4WhAD9NHGM7EdwE9jFD8NQZ75U=;
        b=dCbyODeOo4jwTSvPLs903syDG7DeTJXC49/Aqu4mHwDieZkYKJdIO/AjW5j0oDyZvU
         ehO7hhC95WSL16/zaFbkxE7RwWfJB1VF7MJDPs3+7e9nL1vo6EGWwuXOhj3lGVJ6W1m3
         0KwzkqU67okiS11e70F+vPBVDAvcZpzTdrd+KAnSW9ZJpocFbQBJvSAgSOtmtcIR/TxE
         RixCj5aNJ08da72BhwF3EpY0MEOYqUBNUHGc8a9Qo4FB5+04XKaqoO/aVQ7iHfzpI8Fp
         STSd+nzV/mO/LNAYLeA5zQfJEyi90rVsnNzLtiHM4GprMHAG7AzTbcnAe2QcVOxF03vU
         25gA==
X-Gm-Message-State: APjAAAXrud3zb9vKW7y4G2mHTPvYtE/AzBUCWmc/rtSCx+a5ZycucyjP
        k9++weuX+EA9cisdM0HblnngGz0oR9Pv2e5sKGbZbQRzxkOw5/jOLVaHoxZB6z3n4GYfxPPFoV1
        OnfNJDCQ30u+1qePBzUNsyTPT
X-Received: by 2002:a05:600c:2486:: with SMTP id 6mr6189wms.82.1568128329750;
        Tue, 10 Sep 2019 08:12:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxK83YfDzuT86HuZ3H/O3I8zo0LHSV3sHVESFxazSBMilYCRv10NdhmlMdluFQ8LY8sP7dS5g==
X-Received: by 2002:a05:600c:2486:: with SMTP id 6mr6171wms.82.1568128329429;
        Tue, 10 Sep 2019 08:12:09 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id g185sm12803wme.10.2019.09.10.08.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 08:12:08 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v5 0/4] virtio-fs: shared file system for virtual machines
Date:   Tue, 10 Sep 2019 17:12:02 +0200
Message-Id: <20190910151206.4671-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Git tree for this version is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#virtiofs-v5

Only post patches that actually add virtiofs (virtiofs-v5-base..virtiofs-v5).

I've folded the series from Vivek and fixed a couple of TODO comments
myself.  AFAICS two issues remain that need to be resolved in the short
term, one way or the other: freeze/restore and full virtqueue.

Thanks,
Miklos
---

Dr. David Alan Gilbert (1):
  fuse: reserve values for mapping protocol

Michael S. Tsirkin (1):
  fuse: reserve byteswapped init opcodes

Stefan Hajnoczi (2):
  virtio-fs: add Documentation/filesystems/virtiofs.rst
  virtio-fs: add virtiofs filesystem

 Documentation/filesystems/index.rst    |   10 +
 Documentation/filesystems/virtiofs.rst |   60 ++
 MAINTAINERS                            |   11 +
 fs/fuse/Kconfig                        |   11 +
 fs/fuse/Makefile                       |    1 +
 fs/fuse/fuse_i.h                       |    9 +
 fs/fuse/inode.c                        |    4 +
 fs/fuse/virtio_fs.c                    | 1191 ++++++++++++++++++++++++
 include/uapi/linux/fuse.h              |   12 +-
 include/uapi/linux/virtio_fs.h         |   19 +
 include/uapi/linux/virtio_ids.h        |    1 +
 11 files changed, 1328 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/filesystems/virtiofs.rst
 create mode 100644 fs/fuse/virtio_fs.c
 create mode 100644 include/uapi/linux/virtio_fs.h

-- 
2.21.0

