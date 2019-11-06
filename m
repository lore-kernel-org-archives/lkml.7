Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6027C5DF65
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 04:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949192084C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 04:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TNerTCHd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731279AbfKFEXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 23:23:11 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41591 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729705AbfKFEXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 23:23:10 -0500
Received: by mail-pl1-f196.google.com with SMTP id d29so4452171plj.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 20:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UtTKts7n6PwB/KSUdkueiRv1jM81Y5uAXuxP+Ek2MAU=;
        b=TNerTCHdR/xBMOsoi2KWvCd5wto/Yno6XdqjK6FABEeKXtahodPeaWep+1SW5Quiln
         jt8R0OrM42dMW7h/4Xytu+ifBAwjfK/K+xaB4StGggJSl/GFeE1A15UV+qc7dRgOONge
         KFvX1PM2VGgAT1hk9v39Ox3ZxNhmYPkG3HCGUhEQWba/ym5/r+Pq6x0azkUfrxLfv4QE
         dw24QAOTz0Vp3B4DyjXBbJdwA7K6lXpNDZuXY3WE+kbcjJq8XqhJ3vgSSC5gXIQ4AzMj
         3+Z50L/ucPOlBlvmJu7S88huuIfH4sqevRAfC1h4s7ohHH0O4C6naJKXgB4BTHWIp4D8
         xhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UtTKts7n6PwB/KSUdkueiRv1jM81Y5uAXuxP+Ek2MAU=;
        b=BBqVR0xpmWQmSvaLVjmPPiTfgYgnPuoFEsguqzPtvS96pipN0IUOnTrwum8ehTQAiM
         pf43eUr1JNYJVbczW1FL8ZOaz8FpNB+vK4enacyWhEEdkVfbjklUi0DJAviOFxJXsnVj
         5xwjQU7Wzi5tdTTE4DK3/3HysjZp12Ep8XHZq8QSpKgMadJ6w3JYo2dlawVlU7RJcAhj
         qDjsFCRSpxKt2rsHPQCXDKQ7wMtG7hymLv3pwBHRFcq4lGgeETY5zJxaDnMoG6rZoo3i
         P1cK+343YBZnAyA0sKra/l4G76KuCRDf64+axVOyeA4fFMteDKLVMkbjPWnzpFKkcdaG
         iVUg==
X-Gm-Message-State: APjAAAXMsAA3Tfx+SPx8tKpGhqsbqt676Lr5M37EUbmtPV5eeWv6JhBT
        a8j8AlAC/JZ3jPy4LU/GD5igJSmIIFY=
X-Google-Smtp-Source: APXvYqxyDRrtA0GraHS6OeTmC5cm+tpYnMLVkj2j3n9+AfoWSwLV4JEpLjaz2cTZIBShxeGJcOfftA==
X-Received: by 2002:a17:902:322:: with SMTP id 31mr409718pld.293.1573014187513;
        Tue, 05 Nov 2019 20:23:07 -0800 (PST)
Received: from localhost.localdomain (c-67-170-172-113.hsd1.or.comcast.net. [67.170.172.113])
        by smtp.gmail.com with ESMTPSA id n15sm23730289pfq.146.2019.11.05.20.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 20:23:07 -0800 (PST)
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
        Sandeep Patil <sspatil@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Dave Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v15 5/5] kselftests: Add dma-heap test
Date:   Wed,  6 Nov 2019 04:22:52 +0000
Message-Id: <20191106042252.72452-6-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106042252.72452-1-john.stultz@linaro.org>
References: <20191106042252.72452-1-john.stultz@linaro.org>
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
Cc: Sandeep Patil <sspatil@google.com>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Dave Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Reviewed-by: Brian Starkey <brian.starkey@arm.com>
Acked-by: Sandeep Patil <sspatil@android.com>
Acked-by: Laura Abbott <labbott@redhat.com>
Tested-by: Ayan Kumar Halder <ayan.halder@arm.com>
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
v8:
* More checkpatch whitespace fixups
v9:
* Better handling error returns out to main, suggested
  by Brian Starkey
* Switch to using snprintf, suggested by Brian
v14:
* Fix a missing return value
* Add calls to test the GET_FEATURES ioctl
* Build fix reported by kernel test robot <lkp@intel.com>
  and fixed by Xiao Yang <ice_yangxiao@163.com>
* Minor Makefile cleanups
v15:
* Remove usage of dropped get_features ioctl
---
 tools/testing/selftests/dmabuf-heaps/Makefile |   6 +
 .../selftests/dmabuf-heaps/dmabuf-heap.c      | 238 ++++++++++++++++++
 2 files changed, 244 insertions(+)
 create mode 100644 tools/testing/selftests/dmabuf-heaps/Makefile
 create mode 100644 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c

diff --git a/tools/testing/selftests/dmabuf-heaps/Makefile b/tools/testing/selftests/dmabuf-heaps/Makefile
new file mode 100644
index 000000000000..607c2acd2082
--- /dev/null
+++ b/tools/testing/selftests/dmabuf-heaps/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+CFLAGS += -static -O3 -Wl,-no-as-needed -Wall -I../../../../usr/include
+
+TEST_GEN_PROGS = dmabuf-heap
+
+include ../lib.mk
diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
new file mode 100644
index 000000000000..efca067ba96c
--- /dev/null
+++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
@@ -0,0 +1,238 @@
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
+		snprintf(name, 80, "%s%u", drmstr, i);
+
+		fd = open(name, O_RDWR);
+		if (fd < 0)
+			continue;
+
+		if (!check_vgem(fd)) {
+			close(fd);
+			fd = -1;
+			continue;
+		} else {
+			break;
+		}
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
+static int dmabuf_heap_open(char *name)
+{
+	int ret, fd;
+	char buf[256];
+
+	ret = snprintf(buf, 256, "%s/%s", DEVPATH, name);
+	if (ret < 0) {
+		printf("snprintf failed!\n");
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
+	if (!dmabuf_fd)
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
+#define ONE_MEG (1024 * 1024)
+
+static int do_test(char *heap_name)
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
+		return -1;
+
+	printf("Allocating 1 MEG\n");
+	ret = dmabuf_heap_alloc(heap_fd, ONE_MEG, 0, &dmabuf_fd);
+	if (ret) {
+		printf("Allocation Failed!\n");
+		ret = -1;
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
+		ret = -1;
+		goto out;
+	}
+	printf("mmap passed\n");
+
+	dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_START);
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
+
+	return ret;
+}
+
+int main(void)
+{
+	DIR *d;
+	struct dirent *dir;
+	int ret = -1;
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
+		ret = do_test(dir->d_name);
+		if (ret)
+			break;
+	}
+	closedir(d);
+
+	return ret;
+}
-- 
2.17.1

