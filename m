Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C9CC432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 09:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65C920872
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 09:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="BQn/6cK6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbfIYJ1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 05:27:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39150 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729785AbfIYJ0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 05:26:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id r3so5800954wrj.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 02:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=DSd1v0HUw/UkMj7k6RRXoGkCzVR4BXBAWnDfAwYmXTo=;
        b=BQn/6cK6ycjR1V9lYtL8otDKbL5qaW0Y9AhJ4HBz/L/YEzooTUo/n7ETXJ8Y3pQojL
         KHyRKp9/6iFOAJsWJ0NC/9hoTBqcuSxBnjTofRCf7zQx/h/oRo8h98ushpqf4A+VK0qu
         1UcTHC9XXBXQam0x/RY5FSRET2U0eE1mZZ5+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=DSd1v0HUw/UkMj7k6RRXoGkCzVR4BXBAWnDfAwYmXTo=;
        b=qBkM4Aj9oX+/ErpythjZfo8B6WSXbX9AnaZAJrtlNQSVXMaQF8MbCaRcfvNnEWvOLO
         QogxF5udqWzW3F8AWXIRgurdJf1aWRXs7ducH1LrjjRkSX6IxmX33+Szye3IblBZOAUn
         gUASyLSxMuP4bFcSZ1/ow9qi0eJceMnHDwOl8jYNsjViiO8RLSwGX+/MMwfVSPmjN2v5
         oVZsaUyFYkwlLsG/9R8Huw4BcCHcpnYOUY15zWQ/W/cv/e8yOXD1OBwm002emlOBgUcf
         uhah5Ti+OsQ3X+iIaG4g7RgMFx/+rwIDwL6MzaXe+yqDE40LMYDm0XwUWH0g1CzPl1BX
         gndg==
X-Gm-Message-State: APjAAAV/rOtWecoYi9vFJNuTaRXxMwjBpdbixUiiSHcGDhzPUfTIo7OH
        8WBK2uRBbxSrTIbQFIEWVMInwg==
X-Google-Smtp-Source: APXvYqzJkKHFS0F5JWCrfcZ655cyXDynPdpniWimRDtHR8R6YIcvoP24OOgWxQPBEkqn/bcZ7qHKJw==
X-Received: by 2002:adf:f78a:: with SMTP id q10mr8648154wrp.276.1569403607010;
        Wed, 25 Sep 2019 02:26:47 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (84-236-74-228.pool.digikabel.hu. [84.236.74.228])
        by smtp.gmail.com with ESMTPSA id r20sm7436015wrg.61.2019.09.25.02.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 02:26:46 -0700 (PDT)
Date:   Wed, 25 Sep 2019 11:26:39 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse update for 5.4
Message-ID: <20190925092639.GA1904@miu.piliscsaba.redhat.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-5.4

 - Continue separating the transport (user/kernel communication) and the
   filesystem layers of fuse.  Getting rid of most layering violations will
   allow for easier cleanup and optimization later on.

 - Prepare for the addition of the virtio-fs filesystem.  The actual
   filesystem will be introduced by a separate pull request.

 - Convert to new mount API.

 - Various fixes, optimizations and cleanups.

Thanks,
Miklos

---
Arnd Bergmann (1):
      fuse: unexport fuse_put_request

David Howells (2):
      fuse: convert to use the new mount API
      vfs: subtype handling moved to fuse

Eric Biggers (1):
      fuse: fix deadlock with aio poll and fuse_iqueue::waitq.lock

Khazhismel Kumykov (2):
      fuse: on 64-bit store time in d_fsdata directly
      fuse: kmemcg account fs data

Kirill Smelkov (1):
      fuse: require /dev/fuse reads to have enough buffer capacity (take 2)

Maxim Patlasov (1):
      fuse: cleanup fuse_wait_on_page_writeback

Michael S. Tsirkin (1):
      fuse: reserve byteswapped init opcodes

Miklos Szeredi (33):
      cuse: fix broken release
      fuse: flatten 'struct fuse_args'
      fuse: rearrange and resize fuse_args fields
      fuse: simplify 'nofail' request
      fuse: convert flush to simple api
      fuse: add noreply to fuse_args
      fuse: convert fuse_force_forget() to simple api
      fuse: add nocreds to fuse_args
      fuse: convert destroy to simple api
      fuse: add pages to fuse_args
      fuse: convert readlink to simple api
      fuse: move page alloc
      fuse: convert ioctl to simple api
      fuse: fuse_short_read(): don't take fuse_req as argument
      fuse: covert readpage to simple api
      fuse: convert sync write to simple api
      fuse: add simple background helper
      fuse: convert direct_io to simple api
      fuse: convert readpages to simple api
      fuse: convert readdir to simple api
      fuse: convert writepages to simple api
      fuse: convert init to simple api
      cuse: convert init to simple api
      fuse: convert release to simple api
      fuse: convert retrieve to simple api
      fuse: unexport request ops
      fuse: simplify request allocation
      fuse: clean up fuse_req
      fuse: stop copying args to fuse_req
      fuse: stop copying pages to fuse_req
      fuse: fix request limit
      fuse: delete dentry if timeout is zero
      fuse: dissociate DESTROY from fuseblk

Stefan Hajnoczi (5):
      fuse: export fuse_end_request()
      fuse: export fuse_len_args()
      fuse: export fuse_get_unique()
      fuse: extract fuse_fill_super_common()
      fuse: add fuse_iqueue_ops callbacks

Tejun Heo (1):
      fuse: fix beyond-end-of-page access in fuse_parse_cache()

Vasily Averin (1):
      fuse: fix missing unlock_page in fuse_writepage()

Vivek Goyal (4):
      fuse: export fuse_send_init_request()
      fuse: export fuse_dequeue_forget() function
      fuse: separate fuse device allocation and installation in fuse_conn
      fuse: allow skipping control interface and forced unmount

YueHaibing (1):
      fuse: Make fuse_args_to_req static

zhengbin (1):
      fuse: fix memleak in cuse_channel_open

---
 fs/fs_context.c            |   14 -
 fs/fuse/cuse.c             |  101 ++--
 fs/fuse/dev.c              |  654 ++++++++++-------------
 fs/fuse/dir.c              |  283 +++++-----
 fs/fuse/file.c             | 1227 ++++++++++++++++++++++++--------------------
 fs/fuse/fuse_i.h           |  350 ++++++-------
 fs/fuse/inode.c            |  553 +++++++++++---------
 fs/fuse/readdir.c          |   72 ++-
 fs/fuse/xattr.c            |   76 +--
 fs/namespace.c             |    2 -
 fs/proc_namespace.c        |    2 +-
 fs/super.c                 |    5 -
 include/linux/fs_context.h |    1 -
 include/uapi/linux/fuse.h  |    4 +
 14 files changed, 1730 insertions(+), 1614 deletions(-)
