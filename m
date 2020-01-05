Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B79C33C8C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 12:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ACFD217F4
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 12:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="s9D99V0h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgAEMFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 07:05:25 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46206 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbgAEMFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 07:05:25 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so46525947wrl.13
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 04:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=H1hJLNQee379aq3/tU9tTxHeBbBKoIXcCyb5gddw+z0=;
        b=s9D99V0hhwG8BrJ6pW+LVYSffkdsoaBLwNeOukJHDMIXgSD6bHgOQzR65WF7hdzmWF
         4igDoTk2Jrc30WIXJjWsJvUibhNZACpbR9WKX7169TL7ASJL/qcm1BM/8Gb+MM4kLEe/
         VlFkIr8G08H9znscjvgmDqE19S23KbBnTyYrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=H1hJLNQee379aq3/tU9tTxHeBbBKoIXcCyb5gddw+z0=;
        b=jiPugxOppo2M9vurPp1VzzBr9xcYsZMjeccrjlNOAoHrVFQ9aspwkK5Uq6iv5f/EjW
         IOpQ79YQQ9vBdkVAHB4WYHkkxKeMy3Gf1vg4AXmxTCWlX2sdc9TCN79VE5DhrXu6T7hC
         P93ZtTulwctzeprm5XMGi2etDWreSyg7asPWo/DiVUZSO2tWoYERF+3LOOLfr68TJ3Ib
         IeicG1e5URzjrBUKYvsiY19OuulqazI2RtBmwMS6LCApneiCn59QlvgBkS5qdW01xkXc
         PIYV3Gj7GDg1yWSigma6ZAXsZFJpqOJsN9+rPddcMJ8SYo+j4M2FTtjTMnVbFKJJlr40
         DfNw==
X-Gm-Message-State: APjAAAX9+GdH/9EECpxjZJ9VRA7wxC87K6GCLUx8RHEZ4lX1cRQioZ12
        xN9EdFdPzS40dRd7FRH/ZcclBH6+VmI=
X-Google-Smtp-Source: APXvYqy0G+txcVO2FRvfPrzeMAhObxnRpEQHoeswgwkjOKalPYou8MtvQe2UloqhBRZl+eSQ80pw9g==
X-Received: by 2002:a5d:5403:: with SMTP id g3mr8357673wrv.302.1578225923244;
        Sun, 05 Jan 2020 04:05:23 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:e1d7])
        by smtp.gmail.com with ESMTPSA id p5sm69068815wrt.79.2020.01.05.04.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 04:05:22 -0800 (PST)
Date:   Sun, 5 Jan 2020 12:05:22 +0000
From:   Chris Down <chris@chrisdown.name>
To:     linux-mm@kvack.org
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 0/2] fs: inode: shmem: Reduce risk of inum overflow
Message-ID: <cover.1578225806.git.chris@chrisdown.name>
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

