Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAC7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B831214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="fVMmOVRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfCLIpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:45:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54715 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfCLIo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 04:44:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id f3so1671170wmj.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 01:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=FAPOV31EHgmj7keyQ1DV8jgwUpCfM9dI3mHEsY66UyY=;
        b=fVMmOVRpZtDUDRi2Q2hzWioTMLZDK/8HfQOQcTafPQpc+r39SASm/ZS+cZuIoky2dT
         LuipQTfuRb3W/tfqYKXNo6bJikpA/hto8G+R110w19VYTmBTr3Xcxa2D2LijypdZ1S5C
         ipF3Kb/u6P7/3Mj1uNKYp8sWDFsu2VyOGGYCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FAPOV31EHgmj7keyQ1DV8jgwUpCfM9dI3mHEsY66UyY=;
        b=SVm0mPzcwM+MKQYrVQ1vJobfteU5cEZcD8IfzOsVsiE1ZBe228Q+9rlYUvQrATnD5B
         SrNOr4SVOQZolK+ciPdJeD7pnavER0gS1bFw/LLbd8jiGtmGCh0yShad0kvN3T/+hY9N
         9cGTRP01kgKjpMMxl9SdRfOn5fNAm67Thm6Dv078w5P9RhuG/fFwwQGOy0hQOAOUq4NW
         OtTLDs1ayvc6BgWZkf5438XhZ8cxyVBngi8xudCmSXRpQIrg5gfreqI0/rh0ViUNoMI5
         j6vbDetW31OCrZOuOs8OE9D8dcAXWkfXa7JGxeZ3Pwk/rtVgRKMG9KZMXCvt2+znk1kV
         AlSw==
X-Gm-Message-State: APjAAAWo8p4D8h1y+SCuRbcxwJVqqjHKhu5HU5T3E1MvbkcLVVDAah86
        N6sYt8CwPzycbmArXrN0U29UWOsanrg=
X-Google-Smtp-Source: APXvYqxHO3N6Gkx2tWgPgX2eiCFwC6HANLVpP2EmgjbTU8qUemXiHs95DKILohxaMK3vqYwkJio1zQ==
X-Received: by 2002:a1c:d0c9:: with SMTP id h192mr1552914wmg.103.1552380296207;
        Tue, 12 Mar 2019 01:44:56 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (84-236-15-74.pool.digikabel.hu. [84.236.15.74])
        by smtp.gmail.com with ESMTPSA id t2sm1261032wmi.37.2019.03.12.01.44.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 01:44:55 -0700 (PDT)
Date:   Tue, 12 Mar 2019 09:44:49 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse update for 5.1
Message-ID: <20190312084449.GA30899@veci.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-5.1

Scalability and performance improvements, as well as minor bug fixes and
cleanups.

Thanks,
Miklos

----------------------------------------------------------------
Chad Austin (2):
      fuse: support clients that don't implement 'opendir'
      fuse: cache readdir calls if filesystem opts out of opendir

Kirill Tkhai (12):
      fuse: Replace page without copying in fuse_writepage_in_flight()
      fuse: Remove stale comment in end_requests()
      fuse: Kill fasync only if interrupt is queued in queue_interrupt()
      fuse: Optimize request_end() by not taking fiq->waitq.lock
      fuse: Wake up req->waitq of only if not background
      fuse: Do some refactoring in fuse_dev_do_write()
      fuse: Verify userspace asks to requeue interrupt that we really sent
      fuse: Add fuse_inode argument to fuse_prepare_release()
      fuse: Convert fc->attr_version into atomic64_t
      fuse: Introduce fi->lock to protect write related fields
      fuse: Protect fi->nlookup with fi->lock
      fuse: Protect ff->reserved_req via corresponding fi->lock

Martin Raiber (1):
      fuse: Switch to using async direct IO for FOPEN_DIRECT_IO

Miklos Szeredi (10):
      fuse: extract fuse_find_writeback() helper
      fuse: clean up fuse_writepage_in_flight()
      fuse: only reuse auxiliary request in fuse_writepage_in_flight()
      fuse: fix leaked aux requests
      fuse: clean up aborted
      fuse: use atomic64_t for khctr
      fuse: use iov_iter based generic splice helpers
      fuse add copy_file_range to direct io fops
      fuse: multiplex cached/direct_io file operations
      fuse: lift bad inode checks into callers

---
 fs/fuse/control.c         |   4 +-
 fs/fuse/cuse.c            |   7 +-
 fs/fuse/dev.c             | 115 +++++++++-------
 fs/fuse/dir.c             |  54 +++-----
 fs/fuse/file.c            | 342 ++++++++++++++++++++++++++--------------------
 fs/fuse/fuse_i.h          |  28 ++--
 fs/fuse/inode.c           |  26 ++--
 fs/fuse/readdir.c         |   4 +-
 include/uapi/linux/fuse.h |   7 +-
 9 files changed, 327 insertions(+), 260 deletions(-)
