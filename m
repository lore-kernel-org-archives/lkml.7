Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909EAC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6873A217D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbfICLmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 07:42:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35324 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729126AbfICLmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:42:22 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6A257356C5
        for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2019 11:42:21 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id x1so4985821wrn.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 04:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OAN7nnEOH+Yjifk4c+jX2lC/QmauX+hAkPf3AFHmQks=;
        b=TY/ghuzDmXSA6Yr7RbKjzaa/go2R9sYNBeE6CVUfRxICG6XPcVk/ljXQhAp7zXC3HK
         cEQ45IkVvA6VpL57ODbQ6svTBrhtu8vNc3GWO7xT+CuMVpz5/U0FSg5LbZNUjFS/7X/1
         xEDMWJmxTK81I3106jo/q6Za4TSrXaHhKkmayqTA/M//NOKdRV5w6KCX0aTwMmtHVB2C
         ExdlxKambJObp5i7x9ObAHggYRMCQH2M4uuAch6BDsxN7D90J+YdTClNNUGMQieSRTiX
         IYltplbjbdY8NnTGaHBzslriItV0YUAkFMbm5kK17XjhatJ3G+JHd1jqAddwShS7p34V
         Jp9A==
X-Gm-Message-State: APjAAAUH63SWMg66xgBHT2SbEWyhsW7KOVRa0dAfly/Gu6ZZzg+l3Bwf
        qpqoPypKAmLZ+yuFs15GoQKEi/79UWdGqmkaiBM3V0jx6o1fCnSLDx9BpLOBjr4/xBk7/xOw0Q9
        1/PQr0+GUIBffQ/VINCFcFaHl
X-Received: by 2002:a5d:6288:: with SMTP id k8mr28211443wru.209.1567510939823;
        Tue, 03 Sep 2019 04:42:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwxBZwbWA+ixdgpc74X3E/33uuCSu4TTuS7g05oqkicDMw4i1d0jy4fyCnvZ596KAZw2h29cw==
X-Received: by 2002:a5d:6288:: with SMTP id k8mr28211419wru.209.1567510939587;
        Tue, 03 Sep 2019 04:42:19 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id x6sm2087551wmf.38.2019.09.03.04.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 04:42:19 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v4 16/16] virtio-fs: add Documentation/filesystems/virtiofs.rst
Date:   Tue,  3 Sep 2019 13:42:03 +0200
Message-Id: <20190903114203.8278-11-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190903113640.7984-1-mszeredi@redhat.com>
References: <20190903113640.7984-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Hajnoczi <stefanha@redhat.com>

Add information about the new "virtiofs" file system.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 Documentation/filesystems/index.rst    | 10 +++++
 Documentation/filesystems/virtiofs.rst | 60 ++++++++++++++++++++++++++
 MAINTAINERS                            | 11 +++++
 3 files changed, 81 insertions(+)
 create mode 100644 Documentation/filesystems/virtiofs.rst

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 2de2fe2ab078..56e94bfc580f 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -32,3 +32,13 @@ filesystem implementations.
 
    journalling
    fscrypt
+
+Filesystems
+===========
+
+Documentation for filesystem implementations.
+
+.. toctree::
+   :maxdepth: 2
+
+   virtiofs
diff --git a/Documentation/filesystems/virtiofs.rst b/Documentation/filesystems/virtiofs.rst
new file mode 100644
index 000000000000..4f338e3cb3f7
--- /dev/null
+++ b/Documentation/filesystems/virtiofs.rst
@@ -0,0 +1,60 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================================================
+virtiofs: virtio-fs host<->guest shared file system
+===================================================
+
+- Copyright (C) 2019 Red Hat, Inc.
+
+Introduction
+============
+The virtiofs file system for Linux implements a driver for the paravirtualized
+VIRTIO "virtio-fs" device for guest<->host file system sharing.  It allows a
+guest to mount a directory that has been exported on the host.
+
+Guests often require access to files residing on the host or remote systems.
+Use cases include making files available to new guests during installation,
+booting from a root file system located on the host, persistent storage for
+stateless or ephemeral guests, and sharing a directory between guests.
+
+Although it is possible to use existing network file systems for some of these
+tasks, they require configuration steps that are hard to automate and they
+expose the storage network to the guest.  The virtio-fs device was designed to
+solve these problems by providing file system access without networking.
+
+Furthermore the virtio-fs device takes advantage of the co-location of the
+guest and host to increase performance and provide semantics that are not
+possible with network file systems.
+
+Usage
+=====
+Mount file system with tag ``myfs`` on ``/mnt``:
+
+.. code-block:: sh
+
+  guest# mount -t virtiofs myfs /mnt
+
+Please see https://virtio-fs.gitlab.io/ for details on how to configure QEMU
+and the virtiofsd daemon.
+
+Internals
+=========
+Since the virtio-fs device uses the FUSE protocol for file system requests, the
+virtiofs file system for Linux is integrated closely with the FUSE file system
+client.  The guest acts as the FUSE client while the host acts as the FUSE
+server.  The /dev/fuse interface between the kernel and userspace is replaced
+with the virtio-fs device interface.
+
+FUSE requests are placed into a virtqueue and processed by the host.  The
+response portion of the buffer is filled in by the host and the guest handles
+the request completion.
+
+Mapping /dev/fuse to virtqueues requires solving differences in semantics
+between /dev/fuse and virtqueues.  Each time the /dev/fuse device is read, the
+FUSE client may choose which request to transfer, making it possible to
+prioritize certain requests over others.  Virtqueues have queue semantics and
+it is not possible to change the order of requests that have been enqueued.
+This is especially important if the virtqueue becomes full since it is then
+impossible to add high priority requests.  In order to address this difference,
+the virtio-fs device uses a "hiprio" virtqueue specifically for requests that
+have priority over normal requests.
diff --git a/MAINTAINERS b/MAINTAINERS
index 9cbcf167bdd0..459b3fa8e25e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17117,6 +17117,17 @@ S:	Supported
 F:	drivers/s390/virtio/
 F:	arch/s390/include/uapi/asm/virtio-ccw.h
 
+VIRTIO FILE SYSTEM
+M:	Stefan Hajnoczi <stefanha@redhat.com>
+M:	Miklos Szeredi <miklos@szeredi.hu>
+L:	virtualization@lists.linux-foundation.org
+L:	linux-fsdevel@vger.kernel.org
+W:	https://virtio-fs.gitlab.io/
+S:	Supported
+F:	fs/fuse/virtio_fs.c
+F:	include/uapi/linux/virtio_fs.h
+F:	Documentation/filesystems/virtiofs.rst
+
 VIRTIO GPU DRIVER
 M:	David Airlie <airlied@linux.ie>
 M:	Gerd Hoffmann <kraxel@redhat.com>
-- 
2.21.0

