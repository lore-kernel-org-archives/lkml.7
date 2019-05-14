Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2915C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 07:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C842086A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 07:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="na4L8GTv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfENHvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 03:51:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39114 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfENHvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 03:51:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id n25so1687427wmk.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 00:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=o2QrQ5MNnq1cgP4oiv+YPRRhyT5fmlVNWM93IrsnoBE=;
        b=na4L8GTvwX3E/LspfijFBcyq+JAEBsE0fBRMg5K2igjXXcyQHYgMxkRcJUPY9ZHJWI
         W65nVU9XFlg1BIQqhsB8wkAsWk0FRBsf0YLyOXdSvnYSkeOuDKq9dyojMZnTfkv5nYjw
         XHNzAy0urMon+03CuuLmPY/Hpo9R93yByZ1ZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=o2QrQ5MNnq1cgP4oiv+YPRRhyT5fmlVNWM93IrsnoBE=;
        b=ZIMFWD/blsB+dSMnfPsSqgISNOq5KK9jgrQ7mPVvUUpaIrDmEDzwPuepYPw8LIM2wn
         ACwPI3TTOsQKUecN5ipRSdRJSChKKOCumPv5vP7jgD8bL65ZHCykHhbWqu4a9f9SpA/c
         jf6azJ3+QyHjbEPb7MeuNAnuTRb8N1hFvCO0Mx4q4y7XlKfDV+D8vDPIivbCLUlPc999
         vkmlsKyAtbkj/8smIXcEzOg69DTy9GkjrSM8AeG+3B0YW56MSZ241Qh2tgMw9/W6Elay
         XjQLJCFejR8Qya8cKXDfZ7XWtRHPRtsWqXFf+POHEwTqo34TLHYDj40MzYKaAsUq54fN
         fQLQ==
X-Gm-Message-State: APjAAAWtEZa2v+U397YMZul+LQlRSHDkaoFOSkxIVfUfVm8cZg2X8P2H
        AX7Xr0BPOHG4jb3tO3jebKgsZQ==
X-Google-Smtp-Source: APXvYqzm0Fhyc/9vjwd4b7jS4AfGOI/rolMAEaQqKPCXi/4mpEGUes7Qj1u8NCCnxzwZi/pdiI6LAA==
X-Received: by 2002:a1c:ab0b:: with SMTP id u11mr18271669wme.26.1557820304213;
        Tue, 14 May 2019 00:51:44 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (217-197-180-204.pool.digikabel.hu. [217.197.180.204])
        by smtp.gmail.com with ESMTPSA id c130sm6197113wmf.47.2019.05.14.00.51.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 14 May 2019 00:51:43 -0700 (PDT)
Date:   Tue, 14 May 2019 09:51:36 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse update for 5.2
Message-ID: <20190514075136.GA7850@veci.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-5.2

Add more caching controls for userspace filesystems to use, as well as bug
fixes and cleanups.

Thanks,
Miklos

---
Alan Somers (3):
      fuse: document fuse_fsync_in.fsync_flags
      fuse: fix changelog entry for protocol 7.12
      fuse: fix changelog entry for protocol 7.9

David Howells (1):
      fuse: Convert fusectl to use the new mount API

Ian Abbott (1):
      fuse: Add ioctl flag for x32 compat ioctl

Kirill Smelkov (5):
      fuse: convert printk -> pr_*
      fuse: allow filesystems to have precise control over data cache
      fuse: retrieve: cap requested size to negotiated max_write
      fuse: require /dev/fuse reads to have enough buffer capacity
      fuse: Add FOPEN_STREAM to use stream_open()

Liu Bo (1):
      fuse: honor RLIMIT_FSIZE in fuse_file_fallocate

Miklos Szeredi (1):
      fuse: fix writepages on 32bit

zhangliguang (1):
      fuse: clean up fuse_alloc_inode

---
 fs/fuse/control.c         | 20 +++++++++++++++-----
 fs/fuse/cuse.c            | 13 +++++++------
 fs/fuse/dev.c             | 16 +++++++++++++---
 fs/fuse/file.c            | 22 ++++++++++++++++++----
 fs/fuse/fuse_i.h          |  7 +++++++
 fs/fuse/inode.c           | 23 ++++++++++++-----------
 include/uapi/linux/fuse.h | 22 ++++++++++++++++++++--
 7 files changed, 92 insertions(+), 31 deletions(-)
