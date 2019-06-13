Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10335C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 22:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAEA21537
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 22:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vhZllg9m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfFMWeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 18:34:13 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:33925 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfFMWeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 18:34:12 -0400
Received: by mail-pf1-f202.google.com with SMTP id i2so301797pfe.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 15:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=fhW1GX7remjs81G+bm5ttCdAu6C2vugZvVnklwydC+E=;
        b=vhZllg9maQh/sutXE6shnbCLNUnYp04MtK5t9uFyrUBT+S7FLXAsLBeCE5V5LRxz4B
         ClUduRinRB3yzpaw8b18iXtzA5+47pEbFuMHXdoikHLhzAYrmvKom99d8TWmvC5O56Dv
         8SOHAJ2hQtsYz0uVdv4uODGpym/mheWtk5+IdHAXlOaYaohhwRm0hIvbHX8VI+MaMAW8
         R8TVQaClY4M4wxzX0xftjdqNsCMs5BXNSZrlyANg+wZJ7i5cGknzvPPh9q6FCDJlOSoJ
         Yjf+UKKZXkLHZ9PcuJc9veypiNiwErtnGY2eM5OmtkSQpvqjhPvQmDIMdWTXpp4MsmoM
         4xmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=fhW1GX7remjs81G+bm5ttCdAu6C2vugZvVnklwydC+E=;
        b=Sqz/xL/FjCxp7p319uQL687yrInDRd6Kyx3IaKQg5/80ydPJiba8Kflar1hrbnha1e
         JRSHM5VBm+ILAf4KEFfHeRcxrj8SP1F/3FUeAa8FlxUITC/FFFUgUmaBdNTOANx5N2+y
         9LxGbywOn92bHBcKs+e7iK/bV4QuBjTUGlVPLU3qKNfZIMKnJqJmZE/QLpSgWwUJ2d8z
         xaInCPLlRRlwH4WAAFaQCobltVIHBfVFp7Y00zPVtc0P3cBkIf4GpfBYy0uGp6pfCBID
         3WJTvoQbbEo37tl4O6JMrpJaDcTWC09EiXV5kr0y4Bw2i/L59NRNO4M19+7NGVCbdQsn
         6Wiw==
X-Gm-Message-State: APjAAAWPmcZYFFlQfR5MkwQSLNQMAoahzWEn2w8EK22b6l84Dg0F2fmu
        InkUgB+IXvAq7eSHhsntcs3qAuZJnfm+7QbbCTDxTHVrK6V70oeZQyN3/Swlcf1RlXloLHqho9E
        bw7uLRJTBaEjzanEBATeWc3Asx3UN8endTSZxetInmWWqLBA/4rDz5OCGhNLOwCl6pXI=
X-Google-Smtp-Source: APXvYqxa9Xtwo7UxarcBonvAJZhkfNfXSMdC9caTJicxJ68u2r0YFaGYL8amFfGcqgiWPj9i9B6I976OVw==
X-Received: by 2002:a63:31d8:: with SMTP id x207mr31012219pgx.403.1560465251712;
 Thu, 13 Jun 2019 15:34:11 -0700 (PDT)
Date:   Thu, 13 Jun 2019 15:34:05 -0700
Message-Id: <20190613223408.139221-1-fengc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v5 0/3] Improve the dma-buf tracking
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

Change in v4:
* Updated the commit message and added some comments for the
  DMA_BUF_SET_NAME iotcl

Change in v5:
* Add the missing kfree for the dma-buf name ioctl.

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

