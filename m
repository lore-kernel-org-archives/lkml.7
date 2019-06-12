Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B10C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D22A206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b5NRZZzX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437558AbfFLJg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 05:36:56 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40004 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729856AbfFLJgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 05:36:55 -0400
Received: by mail-pl1-f194.google.com with SMTP id a93so6409285pla.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 02:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0HM5SoliJDA3x8dLqRFVSpErY9ZjZiu/7dZDibCRUD8=;
        b=b5NRZZzXPxl6w5LwxAXkKuxZxHCocavnaojtqAEHIs6N4i7nDPLyLD58i1cyvDL8Oc
         RWOwGw4rr9cfAgZHPk0O5X8/wXR0Okm742qRAazPUelI3Hz9knF4mslU2kgihImuw6gr
         MRfXTfkKhmzsekl2p8UGUrZTXTf9aKDL4boY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0HM5SoliJDA3x8dLqRFVSpErY9ZjZiu/7dZDibCRUD8=;
        b=p3+1/lTJ+j8XZ3f/0PEoauyHKc4nib7j8W1yjjyLi+n0cYiSQILSnhbFD6BSSM3zzO
         OXd6eTrslxwdhTvn51kboiDellxsFxV/raHyiXUT0DKmSpmddQCu+eQfMQ+SRMRQdCdb
         jmiO4f1Bk722XWZ9504yLVAYJZtQbI59HY5Y1ioouGybypU+74+TJ5mxP6yXkBCtiYMF
         EI8k/YdeckuQc64RE197XM9tJH6A2PSYbxtsMTQqz/oc/O2m2wo99tam1tkp1ALxmT7e
         qIryjLfAqfnRQqVBMVHzkUa6f/J4TSwJbhHD3oSd2xE9Cq+sTiSMZSx6edkBEEaFoLED
         kL1Q==
X-Gm-Message-State: APjAAAWaCXC7+bKpSrUtjaMesnWrPAf8zmXaYQf7bWSfBbXre44cjatR
        5WpRYx/zTVWLXBJRMpbwups6Pw==
X-Google-Smtp-Source: APXvYqzfN1W92Yom13ePXXUnOfpx/PPaFrT4AeV13Y9+7ejaBWM9SLtJUijheYJzWC+qlCzeOJZCQQ==
X-Received: by 2002:a17:902:da4:: with SMTP id 33mr21908077plv.209.1560332215116;
        Wed, 12 Jun 2019 02:36:55 -0700 (PDT)
Received: from tfiga.tok.corp.google.com ([2401:fa00:4:4:6d27:f13:a0fa:d4b6])
        by smtp.gmail.com with ESMTPSA id t4sm4521209pjq.19.2019.06.12.02.36.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 02:36:54 -0700 (PDT)
From:   Tomasz Figa <tfiga@chromium.org>
To:     linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hirokazu Honda <hiroh@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>
Subject: [PATCH] media: Clarify the meaning of file descriptors in VIDIOC_DQBUF
Date:   Wed, 12 Jun 2019 18:36:48 +0900
Message-Id: <20190612093648.47412-1-tfiga@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the application calls VIDIOC_DQBUF with the DMABUF memory type, the
v4l2_buffer structure (or v4l2_plane structures) are filled with DMA-buf
file descriptors. However, the current documentation does not explain
whether those are new file descriptors referring to the same DMA-bufs or
just the same integers as passed to VIDIOC_QBUF back in time. Clarify
the documentation that it's the latter.

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
---
 Documentation/media/uapi/v4l/vidioc-qbuf.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/media/uapi/v4l/vidioc-qbuf.rst b/Documentation/media/uapi/v4l/vidioc-qbuf.rst
index dbf7b445a27b..407302d80684 100644
--- a/Documentation/media/uapi/v4l/vidioc-qbuf.rst
+++ b/Documentation/media/uapi/v4l/vidioc-qbuf.rst
@@ -139,6 +139,14 @@ may continue as normal, but should be aware that data in the dequeued
 buffer might be corrupted. When using the multi-planar API, the planes
 array must be passed in as well.
 
+If the application sets the ``memory`` field to ``V4L2_MEMORY_DMABUF`` to
+dequeue a :ref:`DMABUF <dmabuf>` buffer, the driver fills the ``m.fd`` field
+with a file descriptor numerically the same as the one given to ``VIDIOC_QBUF``
+when the buffer was enqueued. No new file descriptor is created at dequeue time
+and the value is only for the application convenience. When the multi-planar
+API is used the ``m.fd`` fields of the passed array of struct
+:c:type:`v4l2_plane` are filled instead.
+
 By default ``VIDIOC_DQBUF`` blocks when no buffer is in the outgoing
 queue. When the ``O_NONBLOCK`` flag was given to the
 :ref:`open() <func-open>` function, ``VIDIOC_DQBUF`` returns
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

