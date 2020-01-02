Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E540AC2D0C2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 18:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D6424653
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 18:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="qtNWNXMM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgABSsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 13:48:53 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37954 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbgABSsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 13:48:53 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so40216542wrh.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 10:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=l3OFUy01IjMTwLawSkNlT+41eTpZsTGyEW7Ge4pw1qY=;
        b=qtNWNXMMQTNt7Sb4Zvbx17CBYbUPk2/vRRHkvI75iGywSr+V5K8Gv2PuD7pJrMYRaq
         6rsyHiNoZP1LGcEBaYTmWq7MVC3j1+MZrfiBJVJ3yX8cXmSGmjZGlFzEtjDxQ3ugLkjO
         krmzdDTn460P90D+mSKzb5LwTQkGd4LsBXwZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=l3OFUy01IjMTwLawSkNlT+41eTpZsTGyEW7Ge4pw1qY=;
        b=cThRt/y6wyXA1MzZc4u0leLbcfDrEKvfXR2VopsfvLhKvxtP8bJ9RZaAZaVaWlDPSO
         Fu1qzpIvYnraOnMZvnpTEWScLGahv/OIjVF8gDKseIKSZ5wh01doSDk+SwFBrRS8x8x8
         B6wSnLSZ73KWnZ6WRWLGKxVwy5DjdytB7yIc4Tj3VPUaOnSnlbiP7w7CJ9syQy8yvu+U
         Z7zXD3RMdWVRzBPGPEZCnZ35YBxcU+T8ra+Pm1MhJqivIAAlFhysy5YB0pVJS0GOQaWH
         9252wn5iv21VSuFZENv0kcesBtwu7599NTCNqO8DZKtmmjFMspgKkT9zZuLtA3dcqjml
         KZoQ==
X-Gm-Message-State: APjAAAVKpW6Bj7mrujU/+isl3GRVqX6/3FhKmPQhs9W9pQwQTWQcE2r9
        DBybfRriTYdVx658SpSNyvfbqw==
X-Google-Smtp-Source: APXvYqy1UAmfBdnjTWdf3/Z+GH+D1RLQd7a2V36/mVwYTjcK5sdem56Dc/B4rWSGbykqPRb8SzE/Ig==
X-Received: by 2002:adf:fe50:: with SMTP id m16mr80050680wrs.217.1577990930961;
        Thu, 02 Jan 2020 10:48:50 -0800 (PST)
Received: from localhost ([2620:10d:c092:200::1:3256])
        by smtp.gmail.com with ESMTPSA id n1sm56012389wrw.52.2020.01.02.10.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 10:48:50 -0800 (PST)
Date:   Thu, 2 Jan 2020 18:48:50 +0000
From:   Chris Down <chris@chrisdown.name>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v2 0/2] tmpfs: Reduce risk of inum overflow
Message-ID: <cover.1577990599.git.chris@chrisdown.name>
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

Chris Down (2):
  tmpfs: Add per-superblock i_ino support
  tmpfs: Support 64-bit inums per-sb

 Documentation/filesystems/tmpfs.txt |  11 +++
 fs/Kconfig                          |  18 +++++
 include/linux/shmem_fs.h            |   2 +
 mm/shmem.c                          | 110 ++++++++++++++++++++++++++--
 4 files changed, 133 insertions(+), 8 deletions(-)

-- 
2.24.1
