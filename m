Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9ECC2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 14:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB7B20882
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 14:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="w9o/nJsP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfL0OaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 09:30:05 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36246 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfL0OaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 09:30:05 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so8396367wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Dec 2019 06:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ZFCfc1E7yMgcAJciG6l7dUXwZ4x3kLHqDvF2Arxg6ok=;
        b=w9o/nJsPLEOZSknlgauPuVKVe6LOkPke3OkKZ37AjiUGmp/AkEXZEuXrxMD7RQv+G8
         2RHWwrAzu24af2Z8L0DQF+tHRJPMWogK9IMdrwjZBD1pjLyDP6m5oy4pHRMHPyA/qeR8
         OEObU/setq5dk3ViZdzgaInvyTULCBnpdaz8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ZFCfc1E7yMgcAJciG6l7dUXwZ4x3kLHqDvF2Arxg6ok=;
        b=SFt0XT/PprDTBQ2o+TQJtHqm3HE96hBQKk/hIFxRiBBfnDLYzHeLvsyKtoRzrRWhZI
         KNU+7u7atRAV3gIr0tkKNAvr9Gu8Oih5lh0ZUTUILYwxUpoYXEGRxon2JLcxZWN0uFJt
         4HBBkPOHJlyChAAQp/j0AH53WwG4Dx7BhFlq6lV8i0WL2RV3537xdKoI7MxX4CkQb9t5
         P5FFQIMNgX/nk7SCFrJrMOFkKrofVBhdBnxsH2cnvDUWnNsluIIeTWxjQrHT3fPPqvJn
         5pnw49sYl6Y4x5dKtTHQB2SVFK92CiK2yXPEq2SgDDzcYXYlP2OlPNDBXnIAoVDF6gew
         Zgxg==
X-Gm-Message-State: APjAAAX/Ix9XRVOZ3iHNacz+FxwoPnmMbWaK/8xLPvC21Wey4xO4c12d
        hSeDLacq+iqrvnB738Xqz5V1lg==
X-Google-Smtp-Source: APXvYqxPbJElumJDEtj6YlLoG4Wb/u5ns4UMg0mSV00CIeRPUgm6IEtUZLuJZwso0srFCCR1nARitw==
X-Received: by 2002:a7b:cf12:: with SMTP id l18mr20827094wmg.66.1577457003393;
        Fri, 27 Dec 2019 06:30:03 -0800 (PST)
Received: from localhost (host-92-23-123-10.as13285.net. [92.23.123.10])
        by smtp.gmail.com with ESMTPSA id s8sm33745752wrt.57.2019.12.27.06.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 06:30:02 -0800 (PST)
Date:   Fri, 27 Dec 2019 14:30:01 +0000
From:   Chris Down <chris@chrisdown.name>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 0/3] fs: inode: shmem: Reduce risk of inum overflow
Message-ID: <cover.1577456898.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Facebook production we are seeing heavy i_ino wraparounds on tmpfs.
On affected tiers, in excess of 10% of hosts show multiple files with
different content and the same inode number, with some servers even
having as many as 150 duplicated inode numbers with differing file
content.

This causes actual, tangible problems in production. For example, we
have complaints from those working on remote caches that their
application is reporting cache corruptions because it uses (device,
inodenum) to establish the identity of a particular cache object, but
because it's not unique any more, the application refuses to continue
and reports cache corruption. Even worse, sometimes applications may not
even detect the corruption but may continue anyway, causing phantom and
hard to debug behaviour.

In general, userspace applications expect that (device, inodenum) should
be enough to be uniquely point to one inode, which seems fair enough.
One might also need to check the generation, but in this case:

1. That's not currently exposed to userspace
   (ioctl(...FS_IOC_GETVERSION...) returns ENOTTY on tmpfs);
2. Even with generation, there shouldn't be two live inodes with the
   same inode number on one device.

In order to mitigate this, we take a two-pronged approach:

1. A mitigation that works both for 32- and 64-bit inodes: we reuse
   inode numbers from recycled slabs where possible (ie. where the
   filesystem uses their own private inode slabs instead of shared inode
   slabs), allowing us to significantly reduce the risk of 32 bit
   wraparound.
2. A fix that works on machines with 64-bit ino_t only: we allow users
   to mount tmpfs with a new inode64 option that uses the full width of
   ino_t. Other filesystems can also use get_next_ino_full to get
   similar behaviour as desired.

Chris Down (3):
  fs: inode: Recycle volatile inode numbers from private slabs
  fs: inode: Add API to retrieve global next ino using full ino_t width
  shmem: Add support for using full width of ino_t

 fs/hugetlbfs/inode.c     |  4 +++-
 fs/inode.c               | 44 +++++++++++++++++++++++++++++++++++++---
 include/linux/fs.h       |  1 +
 include/linux/shmem_fs.h |  1 +
 mm/shmem.c               | 41 ++++++++++++++++++++++++++++++++++++-
 5 files changed, 86 insertions(+), 5 deletions(-)

-- 
2.24.1

