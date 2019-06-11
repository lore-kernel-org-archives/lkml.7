Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D82C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 00:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CEB2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 00:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kmOt5FFc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390882AbfFKACe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 20:02:34 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:44826 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390557AbfFKACd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 20:02:33 -0400
Received: by mail-pg1-f202.google.com with SMTP id a21so7889814pgh.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 17:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=M35jpHh+HUdAc93UKOjDO7JbyHiHSckhQH2gYDGobXY=;
        b=kmOt5FFcxJJcGbgX/KhbCPUkNJRtfC5SMHXTm1h8fiJNch0lsXUvnJM+rymoJnYK+M
         /9i448oQsz9LkakuACRu2808YeoiGQWVOXnOaRsyISwhCPK8dP9o1miiBce5frGWE16z
         eGHzXgV/sirfWV3aYlwKlCVRz8JLalQNNdlrgqf9Kk4okfh7+/qEmYCsVmvDyQQYCeq5
         eHBMKdhUJ4uO5yV4bLwIo6RYC+dEkR71ldwMuJ4oc5OgIdl0EfB1YFOsZhanV9n4KLVA
         PxmWWkH9kRJjk7Cph1crz80X/0wZ+pmtVZn24/1sSr59fSCDJU9Md8pOSeNyHY/QtHrB
         lvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=M35jpHh+HUdAc93UKOjDO7JbyHiHSckhQH2gYDGobXY=;
        b=hm91I0odM2v75B2eNWtCBmMDYgPsO7pMXFNBRdaVKqEfLBYIZvheLg+tpwVws1gp7i
         ckzrv7fJMqM6mck/411+d70NGTBiBI9qihgGVTMad/WflbLybQ5LF9TN+YV0Br4MRj4e
         gMzn9hdArAeMf9zMZ9myymZnUx2AVL9iyTZc/lr1rrWG5k95II7pN2XCQDkN7taeY5+r
         N5kM6BRyXufvhs/GMhYonkLoXIBFRE7B+IH8M/1FFqaa5jbWybP1SHAUDeFZEJ+4zRS7
         XWfDiL5yEVQ/AAexOmC2VQtv0gnDHGf4yJSUNb3mE/UXDOi3bvL6xXAm+VeDcEqougaw
         J4oQ==
X-Gm-Message-State: APjAAAXji0AgfESXC7IfYdTrWYKIPnhMS5x7T8xS8HJlJL3GUUcvoMsr
        0MmS3QQhrSjEV434c8rGHRRyUuH8ydSM9CMbjzso9M7mriHazZUt0luah7OT4rF0xXvXd7u/J5t
        0KhUJwHy14eSyrcCYKAlUBMOCAgSlPsLtEQ4V/Do0uD1Y9cNirKCPYNmYoV+MCwwuuAo=
X-Google-Smtp-Source: APXvYqyfLWy8/cRwYnRZm5yHmhPI6BbqzCZmmDpXbOdd4TYiHsQMuSPBN5pfybvxaruojFUflETihkyrWA==
X-Received: by 2002:a63:6105:: with SMTP id v5mr17769974pgb.312.1560211352554;
 Mon, 10 Jun 2019 17:02:32 -0700 (PDT)
Date:   Mon, 10 Jun 2019 17:02:27 -0700
Message-Id: <20190611000230.152670-1-fengc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [RESEND PATCH v3 0/3] Improve the dma-buf tracking
From:   Chenbo Feng <fengc@google.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sumit Semwal <sumit.semwal@linaro.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, all dma-bufs share the same anonymous inode. While we can count
how many dma-buf fds or mappings a process has, we can't get the size of
the backing buffers or tell if two entries point to the same dma-buf. And
in debugfs, we can get a per-buffer breakdown of size and reference count,
but can't tell which processes are actually holding the references to each
buffer.

To resolve the issue above and provide better method for userspace to track
the dma-buf usage across different processes, the following changes are
proposed in dma-buf kernel side. First of all, replace the singleton inode
inside the dma-buf subsystem with a mini-filesystem, and assign each
dma-buf a unique inode out of this filesystem.  With this change, calling
stat(2) on each entry gives the caller a unique ID (st_ino), the buffer's
size (st_size), and even the number of pages assigned to each dma-buffer.
Secoundly, add the inode information to /sys/kernel/debug/dma_buf/bufinfo
so in the case where a buffer is mmap()ed into a process=E2=80=99s address =
space
but all remaining fds have been closed, we can still get the dma-buf
information and try to accociate it with the process by searching the
proc/pid/maps and looking for the corresponding inode number exposed in
dma-buf debug fs. Thirdly, created an ioctl to assign names to dma-bufs
which lets userspace assign short names (e.g., "CAMERA") to buffers. This
information can be extremely helpful for tracking and accounting shared
buffers based on their usage and original purpose. Last but not least, add
dma-buf information to /proc/pid/fdinfo by adding a show_fdinfo() handler
to dma_buf_file_operations. The handler will print the file_count and name
of each buffer.

Change in v2:
* Add a check to prevent changing dma-buf name when it is attached to
  devices.
* Fixed some compile warnings

Change in v3:
* Removed the GET_DMA_BUF_NAME ioctls, add the dma_buf pointer to dentry
  d_fsdata so the name can be displayed in proc/pid/maps and
  proc/pid/map_files.

Greg Hackmann (3):
  dma-buf: give each buffer a full-fledged inode
  dma-buf: add DMA_BUF_{GET,SET}_NAME ioctls
  dma-buf: add show_fdinfo handler

 drivers/dma-buf/dma-buf.c    | 122 +++++++++++++++++++++++++++++++++--
 include/linux/dma-buf.h      |   5 +-
 include/uapi/linux/dma-buf.h |   3 +
 include/uapi/linux/magic.h   |   1 +
 4 files changed, 124 insertions(+), 7 deletions(-)

--=20
2.21.0.1020.gf2820cf01a-goog

