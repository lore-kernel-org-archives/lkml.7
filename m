Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D68C04AB7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 07:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3CE208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 07:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="azwnJ7Ad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfENH4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 03:56:00 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55311 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfENH4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 03:56:00 -0400
Received: by mail-wm1-f66.google.com with SMTP id x64so1719026wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 00:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=AZcNqe5qvtY4dcuVPf2hIhfe8ZNEonQhM7fP56+pLys=;
        b=azwnJ7Adc4FZ5DZhip+da3lj0FuE4ctMi8uwjjtF6REh0S/xbSWaaWoR3pl2lBJ6c/
         4/AFKediJhhtbToQwNWayxFyhA/SQ1iQO4sPNLbvA78Xll94OM4X3TAwfQNqRThw5/0p
         brF2Ue4q6T7QUBNvraTRt15t+C82uucOVWxmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=AZcNqe5qvtY4dcuVPf2hIhfe8ZNEonQhM7fP56+pLys=;
        b=DkJH3wLd4R1bVfPtb2Tub6PeSnn+SUtgqc3Swxg55tO0XkFn87uD2/KCiwkQagP7e7
         7Av1BwO5ZDb72IvM3Vp9/rQYA2ap98yoBzUMZZmaE3yMaJy2CRq4t4nLap8sbRvc/hBg
         I8hNRkHechTaYli8XK7kGNk1O3R4PEySbjJCb0m6JJoKVhAxxvsIxOqGz86JXzd4CMug
         BhgwJSgg5VZ2E32oY7IgTBKLkCa9HqTJy1q9uhWfeD4yrTyvJPdyTeW7eUy3SP3Ihd3S
         tvxupVaNlPeEgyoC8C2ZhH8qzhh26ZbWR5racvPmtpSnnhyYMgrSzsuzGqhFDnDbw6kY
         ZEmQ==
X-Gm-Message-State: APjAAAUnWHkN3ot8Qp3VPutB/w69lcEPkJLv1brejDfiFwCcjWpiVxQH
        LlQmKlFGBfjLi/jfzW6lpZD96w==
X-Google-Smtp-Source: APXvYqzy2E5+GTUUanOar5cUy7aboEwVSs6bEVbybGdEIZoPPQiyThOSHxOHiq40am/MaT6+1a5IrQ==
X-Received: by 2002:a1c:21c1:: with SMTP id h184mr1682103wmh.78.1557820558015;
        Tue, 14 May 2019 00:55:58 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (217-197-180-204.pool.digikabel.hu. [217.197.180.204])
        by smtp.gmail.com with ESMTPSA id t6sm2302733wmt.8.2019.05.14.00.55.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 00:55:57 -0700 (PDT)
Date:   Tue, 14 May 2019 09:55:55 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs update for 5.2
Message-ID: <20190514075555.GB7850@veci.piliscsaba.redhat.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-update-5.2

Just bug fixes in this small update.

Thanks,
Miklos

---
Amir Goldstein (4):
      ovl: fix missing upper fs freeze protection on copy up for ioctl
      ovl: support stacked SEEK_HOLE/SEEK_DATA
      ovl: do not generate duplicate fsnotify events for "fake" path
      ovl: relax WARN_ON() for overlapping layers use case

Jiufei Xue (1):
      ovl: check the capability before cred overridden

---
 fs/overlayfs/copy_up.c   |   6 +--
 fs/overlayfs/dir.c       |   2 +-
 fs/overlayfs/file.c      | 133 +++++++++++++++++++++++++++++++++++++----------
 fs/overlayfs/inode.c     |   3 +-
 fs/overlayfs/overlayfs.h |   2 +-
 5 files changed, 113 insertions(+), 33 deletions(-)
