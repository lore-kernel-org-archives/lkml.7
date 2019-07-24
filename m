Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5F0C41517
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 00:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543C9229EB
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 00:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KY1gkI7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfGXAhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 20:37:16 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39111 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbfGXAhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 20:37:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so20243793pgi.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 17:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jWzGO3kzW7ffNMSQJH7PkuzBm+8bRr6ltixOP2NA/dg=;
        b=KY1gkI7SrnDx2GYC+fhCOK9fXj9Cz47JxT2JAhD5WFck2iBhoqyRJ37hWbw2Xk4b5x
         6uRHbzxfxiz8PirTyjdUb4pM+ddo5IsEX3FDOgCEUETmNUcwn1zIMM8Rq8SubT0kmcTp
         wtKamm+lYCMbqi0oJ2Zsh4CrscprnKJv095DfXRyVE+aM7rg7kXt+sLgZ+F9BE90hkfp
         Qj9WaHL7CfjNoN/TNNn9b41Vx7Qhh3lMQ8QZKzzlO3JRSixzek0myg4dgNRg1pZnVHgM
         E9Ttys4/AEhBLNVOgwUY/rl/OcBKJioeFooAnV41y2/q5iz6pDtrI1sp2Zo5LF+03mri
         KQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jWzGO3kzW7ffNMSQJH7PkuzBm+8bRr6ltixOP2NA/dg=;
        b=d7A6V+zBiQn2BNaXyyiDseTAJwJSJloTHJ0dUJt7sh296cYOpQlDRaRQb55DDAb4Rn
         Znm/y9jJX/j3uE1YACqZfCW4hL4GXMJt0vm3afGNK5Vs5iyiPg+iBNAQghlmrjZFkHPI
         yfrVNB9LXFknMzV/O8R4xKwJy24FpyU01NnByc4KUVrv0BmwWevndgHdNbOLIPaADFAQ
         miHM68LyoKF1+tOw4zSXebyKvvueFGBhYwLMxaHbQydvmvGJ7nOeQAB/3OzAlvQUJbQ2
         4RkJ/5Etkxhoq78JYB8oZB54NLLVZ4AP2CpTWpzyXGbHegAxHGyUC062m4+HVCz0oJ6D
         zjFw==
X-Gm-Message-State: APjAAAVlfA+9kzCEt87uwO6pzPBCw+wP8PmmfDLWesjngTCehd8JsUN3
        WAUzx8GIbeMpmfoHpLhUVMDpKZHO9sQ=
X-Google-Smtp-Source: APXvYqxSqz3BUlJUL+S3IqhOBEcFzuHqZEpkeurQfHhWWh/L00LvBh9HdTffHogTTNZ3mGmOb9WO4A==
X-Received: by 2002:a17:90a:3401:: with SMTP id o1mr84365628pjb.7.1563928632593;
        Tue, 23 Jul 2019 17:37:12 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id x26sm58890022pfq.69.2019.07.23.17.37.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 17:37:11 -0700 (PDT)
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
        Hridya Valsaraju <hridya@google.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v7 5/5] kselftests: Add dma-heap test
Date:   Wed, 24 Jul 2019 00:36:56 +0000
Message-Id: <20190724003656.59780-6-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190724003656.59780-1-john.stultz@linaro.org>
References: <20190724003656.59780-1-john.stultz@linaro.org>
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
Cc: Hridya Valsaraju <hridya@google.com>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
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
v6:
* Number of style/cleanups suggested by Brian
v7:
* Whitespace fixup for checkpatch
---
 tools/testing/selftests/dmabuf-heaps/Makefile |   9 +
 .../selftests/dmabuf-heaps/dmabuf-heap.c      | 235 ++++++++++++++++++
 2 files changed, 244 insertions(+)
 create mode 100644 tools/testing/selftests/dmabuf-heaps/Makefile
 create mode 100644 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c

diff --git a/tools/testing/selftests/dmabuf-heaps/Makefile b/tools/testing/selftests/dmabuf-heaps/Makefile
new file mode 100644
index 000000000000..8c4c36e2972d
--- /dev/null
+++ b/tools/testing/selftests/dmabuf-heaps/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+CFLAGS += -static -O3 -Wl,-no-as-needed -Wall
+#LDLIBS += -lrt -lpthread -lm
+
+# these are all "safe" tests that don't modify
+# system time or require escalated privileges
+TEST_GEN_PROGS = dmabuf-heap
+
+include ../lib.mk
diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
new file mode 100644
index 000000000000..f36778d2d463
--- /dev/null
+++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
@@ -0,0 +1,235 @@
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
+static int check_vgem(int fd)
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
+		return 0;
+
+	return !strcmp(name, "vgem");
+}
+
+static int open_vgem(void)
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
+		if (!check_vgem(fd)) {
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
+static int import_vgem_fd(int vgem_fd, int dma_buf_fd, uint32_t *handle)
+{
+	struct drm_prime_handle import_handle = {
+		.fd = dma_buf_fd,
+		.flags = 0,
+		.handle = 0,
+	 };
+	int ret;
+
+	ret = ioctl(vgem_fd, DRM_IOCTL_PRIME_FD_TO_HANDLE, &import_handle);
+	if (ret == 0)
+		*handle = import_handle.handle;
+	return ret;
+}
+
+static void close_handle(int vgem_fd, uint32_t handle)
+{
+	struct drm_gem_close close = {
+		.handle = handle,
+	};
+
+	ioctl(vgem_fd, DRM_IOCTL_GEM_CLOSE, &close);
+}
+
+
+static int dmabuf_heap_open(char *name)
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
+static int dmabuf_heap_alloc(int fd, size_t len, unsigned int flags,
+			     int *dmabuf_fd)
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
+static void dmabuf_sync(int fd, int start_stop)
+{
+	struct dma_buf_sync sync = {
+		.flags = start_stop | DMA_BUF_SYNC_RW,
+	};
+	int ret;
+
+	ret = ioctl(fd, DMA_BUF_IOCTL_SYNC, &sync);
+	if (ret)
+		printf("sync failed %d\n", errno);
+}
+
+#define ONE_MEG (1024*1024)
+
+static void do_test(char *heap_name)
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
+	if (ret) {
+		printf("Allocation Failed!\n");
+		goto out;
+	}
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
+	memset(p, 1, ONE_MEG / 2);
+	memset((char *)p + ONE_MEG / 2, 0, ONE_MEG / 2);
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
+	closedir(d);
+
+	return 0;
+}
-- 
2.17.1

