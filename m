Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FD5C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 08:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9AF5222BF
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 08:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="j1zcQmac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbfIZInq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 04:43:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52937 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729737AbfIZInp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 04:43:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id r19so1694254wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 01:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=cN2NPqRYs3tBNQa1c8AtsjOKLzDwXPQVX4d3Hltt1+M=;
        b=j1zcQmac4gVMNI5y1iyw2avduzgCw5EpSxbraalEUWvBwKV+rqhtheOK2isBX31L40
         z3skdraT7Ulhpo8dxbJnjsiUfFvDmTNQs+SWUBsrTVN5bhatfVTs5OTzdUNo6nGiWPPk
         1V1R+vl2ZU3rYSnNu1OIsqlg+m/FQ5Kr9v7Bk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=cN2NPqRYs3tBNQa1c8AtsjOKLzDwXPQVX4d3Hltt1+M=;
        b=uKeLFaUJFRkBXrDk8u50SeUMBwn6noYJ2grgNIdNLOOUErMs0hmeejNdIn93x6wzjq
         M5Qro7bkaSschM3G8Ly/9TwAzl+PjD5bo7Nm6GgzDE+GcjqWpoYstHxt/+C/kn1useC8
         iBipZzao8o+tfaRrgzyLQOXR95T2gaghcVSb+SyypAOIK81FMNgzXVrc5FywmDuXTwR5
         c3jsJBgypKJdRLn9BXHFMDQtNnNnjBKUDK7XIezLPozZZWnRzj3DFLSSnFL8KqaiAq5c
         t8JNckjUZG/teow+O2L2wZPGZGw3vInZ1Fsm7BUYdNRlA9awqBN2ZX7td+YKJHw+8lmT
         zlvg==
X-Gm-Message-State: APjAAAUqpp1NGVUZeUVFFoN9rX3cNjdPTmgCGEZIFXacs9zX4+qrLz4Y
        hgOjGJwKE3/km/gWJ3LFFYLY+Q==
X-Google-Smtp-Source: APXvYqxK6uPnV3U+YMRKjGqkiV6ZOkb2t9eNU9MnqnqVduBXtSHl4BFMknRHhIHP2oH1lp3kpoYcDQ==
X-Received: by 2002:a7b:cb8b:: with SMTP id m11mr2021577wmi.145.1569487422931;
        Thu, 26 Sep 2019 01:43:42 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (84-236-74-228.pool.digikabel.hu. [84.236.74.228])
        by smtp.gmail.com with ESMTPSA id s1sm3391619wrg.80.2019.09.26.01.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 01:43:42 -0700 (PDT)
Date:   Thu, 26 Sep 2019 10:43:40 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: [GIT PULL] add virtio-fs
Message-ID: <20190926084340.GB1904@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/virtio-fs-5.4

[There's a trivial merge conflict under Documentation/]

Virtio-fs allows exporting directory trees on the host and mounting them in
guest(s).

This isn't actually a new filesystem, but a glue layer between the fuse
filesystem and a virtio based back-end.

It's similar in functionality to the existing virtio-9p solution, but
significantly faster in benchmarks and has better POSIX compliance.
Further permformance improvements can be achieved by sharing the page cache
between host and guest, allowing for faster I/O and reduced memory use.

Kata Containers have been including the out-of-tree virtio-fs (with the
shared page cache patches as well) since version 1.7 as an experimental
feature.  They have been active in development and plan to switch from
virtio-9p to virtio-fs as their default solution.  There has been interest
from other sources as well.

The userspace infrastructure is slated to be merged into qemu once the
kernel part hits mainline.

This was developed by Vivek Goyal, Dave Gilbert and Stefan Hajnoczi.

Thanks,
Miklos

---
Dr. David Alan Gilbert (1):
      fuse: reserve values for mapping protocol

Stefan Hajnoczi (2):
      virtio-fs: add Documentation/filesystems/virtiofs.rst
      virtio-fs: add virtiofs filesystem

---
 Documentation/filesystems/index.rst    |   10 +
 Documentation/filesystems/virtiofs.rst |   60 ++
 MAINTAINERS                            |   12 +
 fs/fuse/Kconfig                        |   11 +
 fs/fuse/Makefile                       |    1 +
 fs/fuse/fuse_i.h                       |    9 +
 fs/fuse/inode.c                        |    4 +
 fs/fuse/virtio_fs.c                    | 1195 ++++++++++++++++++++++++++++++++
 include/uapi/linux/fuse.h              |    8 +-
 include/uapi/linux/virtio_fs.h         |   19 +
 include/uapi/linux/virtio_ids.h        |    1 +
 11 files changed, 1329 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/filesystems/virtiofs.rst
 create mode 100644 fs/fuse/virtio_fs.c
 create mode 100644 include/uapi/linux/virtio_fs.h
