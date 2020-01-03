Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4C1C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 17:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E5A320848
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 17:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="CPGcTX4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgACRaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 12:30:19 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36868 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbgACRaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 12:30:19 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so30522195wru.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 09:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=14DHRqjq6UbdTIX5dem/5OxqwGhXov1jquEng4bxQ7Y=;
        b=CPGcTX4kIjO9icc8sWv1If3f+TsdB2RJjJRa4rP/WhdrabOprxLdiu7kwaEEiDqhLc
         Axvtqxn74Y3g2yYdougj+N9fa3lN/bzFsoLsqVXNf78yWe8bkD38SjImmHxOc5s2T8e4
         aHp8j049xZtNDnikBS4ssVIy8C8u+9JnzdpHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=14DHRqjq6UbdTIX5dem/5OxqwGhXov1jquEng4bxQ7Y=;
        b=jJsi5HsXAKnb5VTJIC4gQxVd2rAxKK50P2+/upoukyfsf8w4/cVu5BFPxBxZ2tvUVm
         oE+IVRXCDNv8aw25qxeMxCfPESSZZ0bzwmE2R6zREiI9ToEzObAUui862DbeAOjlFP8D
         VHuMYrW/+iCnkvtkZB0G4czTCTaUls5uKqIjL+s3Omb3l+42qCTWKnisFLN1KKscMbIH
         Q48wHICL/Na77i5XOgNhnCwALwMuAVfT8AHbsClJIgHW/QDUB2rEF5L/YuQy1cZ2xHzu
         u8HZkS9zzeccToZXgsHhE1V9+s1+9oMXRTgAzvpnt/IyKnPpkFySJqnd06cv3fMwgSUN
         qcVg==
X-Gm-Message-State: APjAAAW3TeD4XRZvpOQA4xPh5mOuScz8nfPmp6H2el8lKLzRcvss4i3C
        cwzkNC10fvTOv21AjxmSPCVH4Q==
X-Google-Smtp-Source: APXvYqyju+UyXDDEqLAN1HLw2GATxjDJNHoFZTA6nb2/tfCIV0BHMyUI5vIxNIInZsjasbglFhX2TA==
X-Received: by 2002:adf:ef4e:: with SMTP id c14mr90454955wrp.142.1578072617676;
        Fri, 03 Jan 2020 09:30:17 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:5238])
        by smtp.gmail.com with ESMTPSA id a9sm12339697wmm.15.2020.01.03.09.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 09:30:17 -0800 (PST)
Date:   Fri, 3 Jan 2020 17:30:16 +0000
From:   Chris Down <chris@chrisdown.name>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v3 0/2] fs: inode: shmem: Reduce risk of inum overflow
Message-ID: <cover.1578072481.git.chris@chrisdown.name>
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

 Documentation/filesystems/tmpfs.txt | 11 ++++
 fs/Kconfig                          | 15 +++++
 include/linux/shmem_fs.h            |  2 +
 mm/shmem.c                          | 97 ++++++++++++++++++++++++++++-
 4 files changed, 124 insertions(+), 1 deletion(-)

-- 
2.24.1

