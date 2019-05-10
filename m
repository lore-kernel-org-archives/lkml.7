Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FE9C04AB1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 00:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A92F2182B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 00:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tSZ3t6N4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfEJAAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 20:00:39 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:43807 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfEJAAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 20:00:38 -0400
Received: by mail-qt1-f202.google.com with SMTP id q32so4436936qtk.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 17:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=M35jpHh+HUdAc93UKOjDO7JbyHiHSckhQH2gYDGobXY=;
        b=tSZ3t6N4Z1hNAMYvgS92eIL566ndUhmt5xsPPoUSXPzweWrogmxc+KJ10EVf3pttkF
         merVBSZHG0xLznvz4TKUL7L/GZ2cjBzn9Uqwa07TqFu+hek4xO0PQZfpn+9AYYxEqHRe
         iG61HVtIimI9EQNzmCMq2HhMo1YFeWooHmUb1dCm4Km/pTzPbAhRn7WUXoNAQprfpOYl
         KpalQjheFynt2AC8LlfdwPcJT2Dd9exlL1kqGHdpBmSVkj/RAc0c7GLZHzWoZStRx/DU
         OVyvgiKkjGPP01EUrs0iwK5npCTDem8hdHBbtbZEpi9IcUifRkYzYt5ron+RYMbsxchS
         oAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=M35jpHh+HUdAc93UKOjDO7JbyHiHSckhQH2gYDGobXY=;
        b=bOMphADQCPN2fUDeqQeOxcCeTkOZqZkuWNfYZ3xUsusnw0qFqntBWWP8WIGMIkgAM2
         TxhCgsqzzvdVbOnwo0kBxKdkU4sV0ToIG+TxqgXao8O/9kypOEaomWewUzGHrHh8m8g5
         2jJA/GGaNmnL/4j9EYFSlCAdN5igDs17ZPUT4XLLGHBqE6krtEydJB30RNmB0FREoTO3
         TcfRbOucStMduwt2BV1RJJXMBOkWyTnnwzg6Er/TqHexhJP45/LzsK97wL0/xzg3cFdo
         HmSbq0niUMfBinh22kfbPv9W/3guZiLbV4nCXBzZN/9+xiOav4gLX5zp1dgwQ55eJJ0l
         0TSQ==
X-Gm-Message-State: APjAAAXEIJW3rjAjpnRmheixQWkagktIqUdPXEuQL2hXXN11Gj8HgGa4
        lufgFDGUuy9biUb5rpSJsza9PZa7vF+1x87H8lf36YfF+8WOfbmy01YPYmbyGMfFJsMQliw9HTs
        SqbFdvhEOLo9UG3U9xsJ8x1geF+fskWaFJ6WWDp2p86EbLh1zAeeI0DjaT+QQl0RYfqQ=
X-Google-Smtp-Source: APXvYqxnWMeG08te3Sc05EXGTxd8eHwJqSeZWK3/hm9AqvlKOJ36EdgmCBMpQKg7lKin0TXW98MNSIkgsQ==
X-Received: by 2002:ac8:29af:: with SMTP id 44mr6461067qts.352.1557446435276;
 Thu, 09 May 2019 17:00:35 -0700 (PDT)
Date:   Thu,  9 May 2019 17:00:29 -0700
Message-Id: <20190510000032.40749-1-fengc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [dma-buf v3 0/3] Improve the dma-buf tracking
From:   Chenbo Feng <fengc@google.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>, erickreyes@google.com,
        kernel-team@android.com
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

