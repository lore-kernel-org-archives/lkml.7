Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E643AC33C8C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 12:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6DAA20866
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 12:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="L5GcoTDq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgAEMA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 07:00:28 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54662 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgAEMA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 07:00:28 -0500
Received: by mail-wm1-f66.google.com with SMTP id b19so12181760wmj.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 04:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=H1hJLNQee379aq3/tU9tTxHeBbBKoIXcCyb5gddw+z0=;
        b=L5GcoTDqP85Ra89Ye59ARpTSzZ7gnWy21JPPPuYzKAmIAQ4wHEeSQbNDVck2PAtAY7
         EmzVCQNNqNWBnCiZZc003gcKlJqV2ioKUakubuUccupOE9u8OG6XsA2Eo3r4hLLTp+So
         fP5BB0Vsc2VyZmTHpwRU+DrJI+J2yBuxSmqsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=H1hJLNQee379aq3/tU9tTxHeBbBKoIXcCyb5gddw+z0=;
        b=a/CWidO/D2FNdlUFybbBMGGmyp1olsUOg5YcpuToNMVKgpBOrwltdFB0fx5z6eY5TK
         tCbyBf9/W9VyLQ8J+wg/HUUiOgNZ4Y/u+aZOLEN//F3xXhHv4IuJw83OGOdjb2tTZS9i
         aBiPALVUFoKmjN4VVXXqZZxHOGgAI02Hp9QQtJoXqZTz6cepxmvwDzHg63fU13heukjs
         xoTxY3TR0HfH/gg50XK8SRAtu0t67ooF7GWv5cMPPco6ZKaws7hpwI5viV7tv4EviVBE
         G8QAoNGmVLGEUe/trVXU3CPzK2Fxke7URolDcZ7hoIgkbgZW+lCaRGhIyq32wahbeGVZ
         qlyA==
X-Gm-Message-State: APjAAAU2VWnS+A9lqPBtizeh4shd776m0B6GDT3f6aBzhVsEWEX0/uup
        SYbN6qJ5Ch/j3b6dgrkUaSaqpg==
X-Google-Smtp-Source: APXvYqw/XcK394/KTqhYIMffQmGHz8RF+wDGNHUwQorEma1YeLD6ubCO1gZEETPUwZ/OyDMO01qA1A==
X-Received: by 2002:a1c:67c3:: with SMTP id b186mr28504788wmc.36.1578225626039;
        Sun, 05 Jan 2020 04:00:26 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:e1d7])
        by smtp.gmail.com with ESMTPSA id a133sm19068415wme.29.2020.01.05.04.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 04:00:25 -0800 (PST)
Date:   Sun, 5 Jan 2020 12:00:24 +0000
From:   Chris Down <chris@chrisdown.name>
To:     linux-mm@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 0/2] fs: inode: shmem: Reduce risk of inum overflow
Message-ID: <cover.1578224757.git.chris@chrisdown.name>
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

1. Moving inum generation from being global to per-sb for tmpfs. This
   itself allows some reduction in i_ino churn. This works on both 64-
   and 32- bit machines.
2. Adding inode{64,32} for tmpfs. This fix is supported on machines with
   64-bit ino_t only: we allow users to mount tmpfs with a new inode64
   option that uses the full width of ino_t, or CONFIG_TMPFS_INODE64.

You can see how this compares to previous related patches which didn't
implement this per-superblock:

- https://patchwork.kernel.org/patch/11254001/
- https://patchwork.kernel.org/patch/11023915/

Chris Down (2):
  tmpfs: Add per-superblock i_ino support
  tmpfs: Support 64-bit inums per-sb

 Documentation/filesystems/tmpfs.txt | 11 ++++
 fs/Kconfig                          | 15 +++++
 include/linux/shmem_fs.h            |  2 +
 mm/shmem.c                          | 94 ++++++++++++++++++++++++++++-
 4 files changed, 121 insertions(+), 1 deletion(-)

-- 
2.24.1

