Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0A5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B732183F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fx3l2bTJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfC2AQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:16:24 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46350 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728796AbfC2AQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:16:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id 9so136555pfj.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 17:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w3P2bWwFGQsyszNzoMrmRSuwoYaZS7mV0ew0iOcbMjY=;
        b=fx3l2bTJcYBDMflkoPB6mZiVxiwLlj7sDRku8ZTndkS9AF5lwEnnEOkqBjv1L4DLMf
         SyE6dzsU2VxGsj/oKNfu/p4RZCM8WSM5a1bxCFf892K+pxOgSZsMqwY6BO2KVIqjN1no
         lV11MWVHQZufhZ+pSkMVWofGuRgxfhJx74kNi8DwoQ/2XgcJHUNEM3fypnqx1hmfEpKo
         Ed+yRTHgG9X8lXs1PC9YTCSPftWdjkckg1ffwjgRuQpdICz8AT5MbRC+g/SgmywU+hCT
         VKza+jGynqTcNwAQI1inD4Eutkbl/e9tZVwaBQrGIJch42xd0KRrSvO9HJTsW3yzrL0b
         /81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w3P2bWwFGQsyszNzoMrmRSuwoYaZS7mV0ew0iOcbMjY=;
        b=b11A/gOuJ/eXWXv/s0v4BUEIfrODCkuv+Mb9PWbIFO+zv8nev0fgXi+VaHVai+Uf9X
         EH5PTKjlI9wJqD6dX/KwS+gUfXq8OLihnaMML2pcRn5R/CoZe/58fE+7DchV+pwS6ZYH
         aXN6UKxdMOcyS+u8HpqWhgpL75CfLsJvkbGlAgy3T9cQQ1B/q0+NzK5wUspE2iDYHhZU
         rlaZPLhNlektEPqvD8b5eRd5Oci8z775Fc64dkjrwNvrakEc7Aq8cDZnOHhmYA4hrCZu
         uArj9eonq/+8IBa5AIJ1Xmfvlnrni64phQOa/Lbds2ALFbWFch8MesLO4buexdrFxft1
         aEJQ==
X-Gm-Message-State: APjAAAU6OORAvnOoQDvZFFerHmFwEJCJolV/7t2YkuUVUTDFO2Bfosnq
        IrNooOaIjVIMw9a6B2zu7n5+4YNGSzw=
X-Google-Smtp-Source: APXvYqwEFz87zAVsjaC/Keu5Z0JGD/6WcCDdiw2/LgYZjxmLTKlQoFwURvlp7iPk6Q95rzCABGcWQA==
X-Received: by 2002:aa7:8282:: with SMTP id s2mr26226935pfm.7.1553818578724;
        Thu, 28 Mar 2019 17:16:18 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id g5sm430137pfo.53.2019.03.28.17.16.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Mar 2019 17:16:17 -0700 (PDT)
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
        Xu YiPing <xuyiping@hisilicon.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        butao <butao@hisilicon.com>,
        "Xiaqing (A)" <saberlily.xia@hisilicon.com>,
        Yudongbin <yudongbin@hisilicon.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel@lists.freedesktop.org
Subject: [RFC][PATCH 6/6 v3] kselftests: Add dma-heap test
Date:   Thu, 28 Mar 2019 17:16:02 -0700
Message-Id: <1553818562-2516-7-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553818562-2516-1-git-send-email-john.stultz@linaro.org>
References: <1553818562-2516-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add very trivial allocation and import test for dma-heaps.

TODO: Still needs improvements

Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Liam Mark <lmark@codeaurora.org>
Cc: Pratik Patel <pratikp@codeaurora.org>
Cc: Brian Starkey <Brian.Starkey@arm.com>
Cc: Vincent Donnefort <Vincent.Donnefort@arm.com>
Cc: Sudipto Paul <Sudipto.Paul@arm.com>
Cc: Andrew F. Davis <afd@ti.com>
Cc: Xu YiPing <xuyiping@hisilicon.com>
Cc: "Chenfeng (puck)" <puck.chen@hisilicon.com>
Cc: butao <butao@hisilicon.com>
Cc: "Xiaqing (A)" <saberlily.xia@hisilicon.com>
Cc: Yudongbin <yudongbin@hisilicon.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Chenbo Feng <fengc@google.com>
Cc: Alistair Strachan <astrachan@google.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2: Switched to use reworked dma-heap apis

v3:
* Add simple mmap
* Utilize dma-buf testdev to test importing
---
 tools/testing/selftests/dmabuf-heaps/Makefile      |  11 ++
 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c | 169 +++++++++++++++++++++
 2 files changed, 180 insertions(+)
 create mode 100644 tools/testing/selftests/dmabuf-heaps/Makefile
 create mode 100644 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c

diff --git a/tools/testing/selftests/dmabuf-heaps/Makefile b/tools/testing/selftests/dmabuf-heaps/Makefile
new file mode 100644
index 0000000..c414ad3
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
index 0000000..df30465
--- /dev/null
+++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+
+#include "../../../../include/uapi/linux/dma-heap.h"
+#include "../../../../include/uapi/linux/dma-buf-testdev.h"
+
+#define DEVPATH "/dev/dma_heap"
+
+int dmabuf_importer_open(char *name)
+{
+	int ret, fd;
+	char buf[256];
+
+	ret = sprintf(buf, "/dev/%s", name);
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
+int dmabuf_importer_import(int importer_fd,  int dmabuf_fd, void *phys_addr)
+{
+	struct dma_buf_testdev_data data =  {
+		.fd = dmabuf_fd,
+		.phys = 0,
+	};
+
+	int ret;
+
+	if (phys_addr == NULL)
+		return -EINVAL;
+
+	ret = ioctl(importer_fd, DMA_BUF_TESTDEV_IOC_CONVERT, &data);
+	if (ret < 0)
+		return ret;
+
+	*(__u64 *)phys_addr = data.phys;
+
+	return ret;
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
+		.flags = flags,
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
+#define ONE_MEG (1024*1024)
+
+void do_test(char *heap_name)
+{
+	int heap_fd = -1, dmabuf_fd = -1, importer_fd = -1;
+	void *p;
+	int ret;
+	long phys;
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
+		abort();
+	}
+	printf("mmap passed\n");
+
+	memset(p, 1, ONE_MEG/2);
+	p = (char *)p + ONE_MEG/2;
+	memset(p, 0, ONE_MEG/2);
+	munmap(p, ONE_MEG);
+
+
+	importer_fd = dmabuf_importer_open("dma-buf-testdev");
+
+	ret = dmabuf_importer_import(importer_fd, dmabuf_fd, &phys);
+	if (ret) {
+		printf("Error importing to test device!\n");
+		goto out;
+	}
+	printf("Import passed!\n");
+
+	/* DO SOMETHING WITH THE DMABUF HERE? */
+
+out:
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
+	while ((dir = readdir(d)) != NULL)
+		do_test(dir->d_name);
+
+	return 0;
+}
-- 
2.7.4

