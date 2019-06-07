Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEB2C28EBD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 03:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE91B207E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 03:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ID9VizCe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfFGDHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 23:07:35 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33926 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbfFGDHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 23:07:34 -0400
Received: by mail-pl1-f194.google.com with SMTP id i2so252492plt.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 20:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7gMsJqAYXuRzQsFdsz8WPSG1GT19bUg864CaxQch3Xs=;
        b=ID9VizCeitG2CQi+89Qd5XMiNv6nybtzcsi62xZnegrpa3iulFExXPnlTcbawOHagp
         4h+Uus46sWdz/xeattw3RHHWAOoiB22PeuvnRvTB4rVLSrB+02zIK5RkpI237hopCtnH
         CvyGEqhjGFJERqCkpGcnTPRSsxoNpmvqkHRHLIboH5K96aZt027hYtnyLqcjhoQR43RF
         XEc6PYwJpBnjrhN4xvbDxcuVQV1oXQPvGrQtvzmtRaiXESUzWmkpXkMqnaMcSVuBuUbH
         0IQ61W6vuHgrv7qU/M1jYJKCSti7Ep/+C21Ck9OqAQ7YaN0N/ZfgQatXxeOhB5XPb3qD
         esfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7gMsJqAYXuRzQsFdsz8WPSG1GT19bUg864CaxQch3Xs=;
        b=eNkTXbufvR2wzcVorWFqB783ttcdPVxQrrvbn0NKVmv4Bj2IJNfc4l1S5FeM+9QwhA
         A53gGg+1uW09k72WLOvs/gGV0tDxSHCm7w1lKqTOGIHRP2nYAUVRgKxqE+8780egcah/
         1iQj5fZFVoMQ+c3UG2m+nr2TpiejNAx4NhzQt8mrjoGJQi5/1UDJ/tRxLcOUE/yDWazx
         Qbxf9x4+1PchDVPJUglEHlFHJfnvk1Z8kdVhsqqaeAmJf2LP8v9YeecKQ2JnVzktcwq7
         HOMouqseYnJec8n3+31egMYNUIav+YYR5/794P0dKz3gJsON0i+g6WqSU5O19SGUN/xs
         thrQ==
X-Gm-Message-State: APjAAAWUi9FtpTqHSYL9qf6BgVnoDTf6o52h0gzgYDy8tBYziV9esEBV
        /ujGT8uGuhat4ZjtSqATx+l/RCCBRjU=
X-Google-Smtp-Source: APXvYqy80/s2LEn8mGEudG2OG0rk8rffOjJOEUngYObDDxl+7XS7TrTok7kxOS+7EDg0TEoHqlCiXw==
X-Received: by 2002:a17:902:4a:: with SMTP id 68mr53751022pla.235.1559876852575;
        Thu, 06 Jun 2019 20:07:32 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id f4sm506575pfn.118.2019.06.06.20.07.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 20:07:31 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v5 5/5] kselftests: Add dma-heap test
Date:   Fri,  7 Jun 2019 03:07:19 +0000
Message-Id: <20190607030719.77286-6-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190607030719.77286-1-john.stultz@linaro.org>
References: <20190607030719.77286-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add very trivial allocation and import test for dma-heaps,
utilizing the vgem driver as a test importer.

A good chunk of this code taken from:
  tools/testing/selftests/android/ion/ionmap_test.c
  Originally by Laura Abbott <labbott@redhat.com>

Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Liam Mark <lmark@codeaurora.org>
Cc: Pratik Patel <pratikp@codeaurora.org>
Cc: Brian Starkey <Brian.Starkey@arm.com>
Cc: Vincent Donnefort <Vincent.Donnefort@arm.com>
Cc: Sudipto Paul <Sudipto.Paul@arm.com>
Cc: Andrew F. Davis <afd@ti.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Chenbo Feng <fengc@google.com>
Cc: Alistair Strachan <astrachan@google.com>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Change-Id: Ib98569fdda6378eb086b8092fb5d6bd419b8d431
---
v2:
* Switched to use reworked dma-heap apis
v3:
* Add simple mmap
* Utilize dma-buf testdev to test importing
v4:
* Rework to use vgem
* Pass in fd_flags to match interface changes
* Skip . and .. dirs
---
 tools/testing/selftests/dmabuf-heaps/Makefile |  11 +
 .../selftests/dmabuf-heaps/dmabuf-heap.c      | 232 ++++++++++++++++++
 2 files changed, 243 insertions(+)
 create mode 100644 tools/testing/selftests/dmabuf-heaps/Makefile
 create mode 100644 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c

diff --git a/tools/testing/selftests/dmabuf-heaps/Makefile b/tools/testing/selftests/dmabuf-heaps/Makefile
new file mode 100644
index 000000000000..c414ad36b4bf
--- /dev/null
+++ b/tools/testing/selftests/dmabuf-heaps/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+CFLAGS += -static -O3 -Wl,-no-as-needed -Wall
+#LDLIBS += -lrt -lpthread -lm
+
+# these are all "safe" tests that don't modify
+# system time or require escalated privileges
+TEST_GEN_PROGS = dmabuf-heap
+
+
+include ../lib.mk
+
diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
new file mode 100644
index 000000000000..33d4b105c673
--- /dev/null
+++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+
+#include <linux/dma-buf.h>
+#include <drm/drm.h>
+
+
+#include "../../../../include/uapi/linux/dma-heap.h"
+
+#define DEVPATH "/dev/dma_heap"
+
+int check_vgem(int fd)
+{
+	drm_version_t version = { 0 };
+	char name[5];
+	int ret;
+
+	version.name_len = 4;
+	version.name = name;
+
+	ret = ioctl(fd, DRM_IOCTL_VERSION, &version);
+	if (ret)
+		return 1;
+
+	return strcmp(name, "vgem");
+}
+
+int open_vgem(void)
+{
+	int i, fd;
+	const char *drmstr = "/dev/dri/card";
+
+	fd = -1;
+	for (i = 0; i < 16; i++) {
+		char name[80];
+
+		sprintf(name, "%s%u", drmstr, i);
+
+		fd = open(name, O_RDWR);
+		if (fd < 0)
+			continue;
+
+		if (check_vgem(fd)) {
+			close(fd);
+			continue;
+		} else {
+			break;
+		}
+
+	}
+	return fd;
+}
+
+int import_vgem_fd(int vgem_fd, int dma_buf_fd, uint32_t *handle)
+{
+	struct drm_prime_handle import_handle = { 0 };
+	int ret;
+
+	import_handle.fd = dma_buf_fd;
+	import_handle.flags = 0;
+	import_handle.handle = 0;
+
+	ret = ioctl(vgem_fd, DRM_IOCTL_PRIME_FD_TO_HANDLE, &import_handle);
+	if (ret == 0)
+		*handle = import_handle.handle;
+	return ret;
+}
+
+void close_handle(int vgem_fd, uint32_t handle)
+{
+	struct drm_gem_close close = { 0 };
+
+	close.handle = handle;
+	ioctl(vgem_fd, DRM_IOCTL_GEM_CLOSE, &close);
+}
+
+
+int dmabuf_heap_open(char *name)
+{
+	int ret, fd;
+	char buf[256];
+
+	ret = sprintf(buf, "%s/%s", DEVPATH, name);
+	if (ret < 0) {
+		printf("sprintf failed!\n");
+		return ret;
+	}
+
+	fd = open(buf, O_RDWR);
+	if (fd < 0)
+		printf("open %s failed!\n", buf);
+	return fd;
+}
+
+int dmabuf_heap_alloc(int fd, size_t len, unsigned int flags, int *dmabuf_fd)
+{
+	struct dma_heap_allocation_data data = {
+		.len = len,
+		.fd_flags = O_RDWR | O_CLOEXEC,
+		.heap_flags = flags,
+	};
+	int ret;
+
+	if (dmabuf_fd == NULL)
+		return -EINVAL;
+
+	ret = ioctl(fd, DMA_HEAP_IOC_ALLOC, &data);
+	if (ret < 0)
+		return ret;
+	*dmabuf_fd = (int)data.fd;
+	return ret;
+}
+
+void dmabuf_sync(int fd, int start_stop)
+{
+	struct dma_buf_sync sync = { 0 };
+	int ret;
+
+	sync.flags = start_stop | DMA_BUF_SYNC_RW;
+	ret = ioctl(fd, DMA_BUF_IOCTL_SYNC, &sync);
+	if (ret)
+		printf("sync failed %d\n", errno);
+
+}
+
+#define ONE_MEG (1024*1024)
+
+void do_test(char *heap_name)
+{
+	int heap_fd = -1, dmabuf_fd = -1, importer_fd = -1;
+	uint32_t handle = 0;
+	void *p = NULL;
+	int ret;
+
+	printf("Testing heap: %s\n", heap_name);
+
+	heap_fd = dmabuf_heap_open(heap_name);
+	if (heap_fd < 0)
+		return;
+
+	printf("Allocating 1 MEG\n");
+	ret = dmabuf_heap_alloc(heap_fd, ONE_MEG, 0, &dmabuf_fd);
+	if (ret)
+		goto out;
+
+	/* mmap and write a simple pattern */
+	p = mmap(NULL,
+		 ONE_MEG,
+		 PROT_READ | PROT_WRITE,
+		 MAP_SHARED,
+		 dmabuf_fd,
+		 0);
+	if (p == MAP_FAILED) {
+		printf("mmap() failed: %m\n");
+		goto out;
+	}
+	printf("mmap passed\n");
+
+
+	dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_START);
+
+	memset(p, 1, ONE_MEG/2);
+	memset((char *)p+ONE_MEG/2, 0, ONE_MEG/2);
+	dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_END);
+
+	importer_fd = open_vgem();
+	if (importer_fd < 0) {
+		ret = importer_fd;
+		printf("Failed to open vgem\n");
+		goto out;
+	}
+
+	ret = import_vgem_fd(importer_fd, dmabuf_fd, &handle);
+	if (ret < 0) {
+		printf("Failed to import buffer\n");
+		goto out;
+	}
+	printf("import passed\n");
+
+	dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_START);
+	memset(p, 0xff, ONE_MEG);
+	dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_END);
+	printf("syncs passed\n");
+
+	close_handle(importer_fd, handle);
+	ret = 0;
+
+out:
+	if (p)
+		munmap(p, ONE_MEG);
+	if (importer_fd >= 0)
+		close(importer_fd);
+	if (dmabuf_fd >= 0)
+		close(dmabuf_fd);
+	if (heap_fd >= 0)
+		close(heap_fd);
+}
+
+
+int main(void)
+{
+	DIR *d;
+	struct dirent *dir;
+
+	d = opendir(DEVPATH);
+	if (!d) {
+		printf("No %s directory?\n", DEVPATH);
+		return -1;
+	}
+
+	while ((dir = readdir(d)) != NULL) {
+		if (!strncmp(dir->d_name, ".", 2))
+			continue;
+		if (!strncmp(dir->d_name, "..", 3))
+			continue;
+
+		do_test(dir->d_name);
+	}
+
+	return 0;
+}
-- 
2.17.1

