Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50481C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213542053B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CFM+cxWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393706AbfFMRPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:15:55 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:35207 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728745AbfFLVs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 17:48:27 -0400
Received: by mail-qk1-f202.google.com with SMTP id u128so14871453qka.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 14:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=Nvc8GP9MwpE1zr8t87gJ0fcpzOb0fXOQ5uqc0xW6/0Q=;
        b=CFM+cxWoFmc9yDaNAE7a83xL7QFc9YTm1d3r0nGLutm/L7bwWMBMO/aYW9Ra3qxdIg
         DMoSKbZYPeOkVh4OZ3+668Tk2w5UmyTTlkms1/5jmALJ7X+IObkO8Y5KjoEewfwX9Y6l
         VBpfeqgLaz9T5oEt0oI6y/GAYj3vNyxCEFokMn3QdfbjONa3EkMiAuIKq6cpUYxvKHy4
         ox3tNpown9wxbafp0LInWBMQ9cPPxXkDLJ+RRWZMV+7123cYpGR8fexyAbfcJArrXKwv
         7datDbOhW8PT5e76rXmxX+ezn2jyGWHURYaH2J2CuDXNhDAuMUtaAlR/LJVIqj81itfg
         qScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=Nvc8GP9MwpE1zr8t87gJ0fcpzOb0fXOQ5uqc0xW6/0Q=;
        b=ZqJMyKWop3MZH0b5kXSzMU47qh2BSuh5tCdWfVt0/EjfiUx4kq6JhUakLPq+nWt1Ll
         ytgndyJoMX+cfAV+3GpQ/NcrsL0zuj+vzEzX+MzSq3wS7R12DJl0s5x7x2tp1v/PJ4Df
         zWw0hLGx5lJF6YhegapZfU7aUs4tpGxBuhw7I/SUZ9MWPy8T5ncxongz3J8kjbZEGlzr
         EeL3TBL1jfYmvTxXJbRTgD196QCFEjYLqWG9WyXBwATm7bIrE0PNmvg2ebHZuYiJSkS1
         3l6YXZmqbs+bg5Q82mL8SOAzn4ZXW/0vaRdiAdNaak4IuWblW3IKr4zOxbfAEl6427ND
         e8mg==
X-Gm-Message-State: APjAAAVcK8Tl2YDQuMnusSzIVFZYtkd5bZdTD8gPI1UPlSmNmf3tYSbD
        s4e4V6qMCB0zlvXrCIz4aFrIDxfXYQgiz3rr9+qMOXIGRRJC4QzFVgZM1mSYvPmFxLG/KdbeLxJ
        l/YbI1Sv5BaCVyc1aiGmHWsISJlhEh5tVFwVUIBeoGQoEpT18SFwpeKtx/tJLlP2H7es=
X-Google-Smtp-Source: APXvYqzJMmozSfx8Q7fCQKl2L3GsUVSJaTVVNbazAW0PNFqqQSITm9ChmjEnGQZnnfUdU/X3pecvZB1HbQ==
X-Received: by 2002:ac8:1087:: with SMTP id a7mr58423448qtj.141.1560376106489;
 Wed, 12 Jun 2019 14:48:26 -0700 (PDT)
Date:   Wed, 12 Jun 2019 14:48:20 -0700
Message-Id: <20190612214823.251491-1-fengc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v4 0/3] Improve the dma-buf tracking
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

Change in v3:
* Updated the commit message and added some comments for the
  DMA_BUF_SET_NAME iotcl

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

