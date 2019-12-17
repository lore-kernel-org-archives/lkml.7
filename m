Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D818CC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 03:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF292176D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 03:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nJg1EkAd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfLQDUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 22:20:44 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:43601 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfLQDUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 22:20:44 -0500
Received: by mail-pg1-f172.google.com with SMTP id k197so4842093pga.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 19:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8OIkbBGm2/UIWBdt/4gwjBTwZSPsO7hELscBafMhK08=;
        b=nJg1EkAd+ybAc6ZVbt6WYAZhn496n6O8pCjF99UpEZqCsit12oo2aWCdEA5q3vCptt
         DjW3f1lXd8ueQyTxe1kcmll7UpvHQZKpHuaq7b/PGmL5GpRChdp/6n94XfA7LH6YliAF
         kQvcfuaJ6EdK/iL1qU1n5DtD2dza2rvZjsB2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8OIkbBGm2/UIWBdt/4gwjBTwZSPsO7hELscBafMhK08=;
        b=ecZo03NS37ckmH1zvQDW2egzOtrYBPxIwQAXuMATXZArkVejOM/hbB7wwS47Pxdu8b
         799rifnaJPZx03jUB7qv8TiZ3ra7OA6TD4dNob5fmM1DYTWTPYtMyQFZDqKmMbJ2uFOB
         0BJ3wdNZWUKq2ZZvDgMFJXY7Xa+1NzfmHb5fIPmwFN1cwYAvq+A7Sp2cmYUGeQ157Y0v
         av5G5ffNYhSaeLBl59Qd3Ee2oIGp+kwVbP0S6rNVvWYvIIm7J7+8jv7brZCAwnAVBkHu
         I8VYMyKE+dU4xZ1FrH9B4EwgKbzr6oGdv9zlryFZJ/bpGL/p6HrbodUVbY8DQIgy7qAj
         s9Aw==
X-Gm-Message-State: APjAAAXMmR16rvXHzb2jmRfhmYXxIsCysTWee49xl/jzMm0/JJ+TWg77
        8a2wQZal6MuYyZIiqJ8XJG77pUEmevQ=
X-Google-Smtp-Source: APXvYqy2vER++9HLpfOhE1FDCXib9wTZt6yt1GUjs+8EGFMHkytRVF6m4bcdXYLUJlDpk+/M6P/GuA==
X-Received: by 2002:a65:4c82:: with SMTP id m2mr21937460pgt.432.1576552843221;
        Mon, 16 Dec 2019 19:20:43 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:250d:e71d:5a0a:9afe])
        by smtp.gmail.com with ESMTPSA id j3sm24387455pfi.8.2019.12.16.19.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 19:20:42 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Hans Verkuil <hans.verkuil@cisco.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC][PATCH 00/15] Implement V4L2_BUF_FLAG_NO_CACHE_* flags
Date:   Tue, 17 Dec 2019 12:20:19 +0900
Message-Id: <20191217032034.54897-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	RFC

	This is a reworked version of the vb2 cache hints
(V4L2_BUF_FLAG_NO_CACHE_INVALIDATE / V4L2_BUF_FLAG_NO_CACHE_CLEAN)
support patch series which previsouly was developed by Sakari and
Laurent [0].

The patch set attempts to preserve the existing behvaiour - cache
sync is performed in ->prepare() and ->finish() (unless the buffer
is DMA exported). User space can request “default behavior” override
with cache management hints, which are handled on a per-buffer basis
and should be supplied with v4l2_buffer ->flags during buffer
preparation. There are two possible hints:

- V4L2_BUF_FLAG_NO_CACHE_INVALIDATE
	No cache sync on ->finish()

- V4L2_BUF_FLAG_NO_CACHE_CLEAN
	No cache sync on ->prepare()

In order to keep things on the safe side, we also require driver
to explicitly state which of its queues (if any) support user space
cache management hints (such queues should have ->allow_cache_hints
bit set).

The patch set also (to some extent) simplifies allocators' ->prepare()
and ->finish() callbacks. Namely, we move cache management decision
making to the upper - core - layer. For example, if, previously, we
would have something like this

	vb2_buffer_done()
	  vb2_dc_finish()
	    if (buf->db_attach)
	       return;

where each allocators' ->finish() callback would either bail
out (DMA exported buffer, for instance) or sync, now that "bail
out or sync" decision is made before we call into the allocator.

Along with cache management hints, user space is also able to
adjust queue's memory consistency attributes. Memory consistency
attribute (dma_attrs) is per-queue, yet it plays its role on the
allocator level, when we allocate buffers’ private memory (planes).
For the time being, only one consistency attribute is supported:
DMA_ATTR_NON_CONSISTENT.

[0] https://www.mail-archive.com/linux-media@vger.kernel.org/msg112459.html

Sergey Senozhatsky (15):
  videobuf2: add cache management members
  videobuf2: handle V4L2 buffer cache flags
  videobuf2: add V4L2_FLAG_MEMORY_NON_CONSISTENT flag
  videobuf2: add queue memory consistency parameter
  videobuf2: handle V4L2_FLAG_MEMORY_NON_CONSISTENT in REQBUFS
  videobuf2: handle V4L2_FLAG_MEMORY_NON_CONSISTENT in CREATE_BUFS
  videobuf2: factor out planes prepare/finish functions
  videobuf2: do not sync caches when we are allowed not to
  videobuf2: check ->synced flag in prepare() and finish()
  videobuf2: let user-space know when driver supports cache hints
  videobuf2: add begin/end cpu_access callbacks to dma-contig
  videobuf2: add begin/end cpu_access callbacks to dma-sg
  videobuf2: do not sync buffers for DMABUF queues
  videobuf2: don't test db_attach in dma-contig prepare and finish
  videobuf2: don't test db_attach in dma-sg prepare and finish

 Documentation/media/uapi/v4l/buffer.rst       |  19 ++++
 .../media/uapi/v4l/vidioc-create-bufs.rst     |   8 +-
 .../media/uapi/v4l/vidioc-reqbufs.rst         |  19 +++-
 .../media/common/videobuf2/videobuf2-core.c   | 107 +++++++++++++-----
 .../common/videobuf2/videobuf2-dma-contig.c   |  39 ++++++-
 .../media/common/videobuf2/videobuf2-dma-sg.c |  30 +++--
 .../media/common/videobuf2/videobuf2-v4l2.c   |  59 +++++++++-
 drivers/media/dvb-core/dvb_vb2.c              |   2 +-
 drivers/media/v4l2-core/v4l2-ioctl.c          |   5 +-
 include/media/videobuf2-core.h                |  17 ++-
 include/uapi/linux/videodev2.h                |  11 +-
 11 files changed, 259 insertions(+), 57 deletions(-)

-- 
2.24.1.735.g03f4e72817-goog

