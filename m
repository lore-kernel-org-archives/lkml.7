Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDCFC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94162075B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ig9NrpoL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbfCEUy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 15:54:56 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45948 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728598AbfCEUyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 15:54:51 -0500
Received: by mail-pg1-f194.google.com with SMTP id 125so6226274pgc.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 12:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yRzxxqyWBOZSHUPCrEH0/twSX4oAAXNjDpDvvJwFuKY=;
        b=Ig9NrpoLNuMDfa1+uWlGupfOqBCwIQ+ARCCn0xpftFCT3CL10AADvXWK6+JhSnvz4W
         p3k6GJJ2Z1mlHzqRsm5OHk/PK4cC6Dk23pAfM300lbS6bVkUcxds/Pspgzvci2Si0/bJ
         y2o8svN7nDilfgoFvx4QdJvS7od2QiEIx6knwSOtqD18tZf3je3SQirbipJ1VicIE/YN
         5YqWpTO+nOXUaf8LIxcqMDMEnEXrvTQue+vlk1lS0l+KCI+3g8eR/oiEmcNmeTkHFKAJ
         kM3pIRH9pB6Zwzc6w2xAocRDCHT/LJ7HDwAS7pjS4XowquDPevvezNeVxmLOQSos47n3
         OjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yRzxxqyWBOZSHUPCrEH0/twSX4oAAXNjDpDvvJwFuKY=;
        b=tn0gQzvba7cgZW7f7nr8hn12/PATQcAMk0yt5IWG38nN9MC0vynOJRUUSQtu52ZrIN
         fQFapS9a393h8tZfY+sbJBAaztrMAiEbtuTK+i6M60k157n/yiqaQxx7surWL3gZl+MM
         xVvUVF4s9+2CMN7kgW5kri9IExtNmFRsfSxCXy3BH3A8k88msjmUjhU4140wR/2BeAtR
         Ix4wVhZgxsvplKSFLGfmVxdL8DBMgx8oevWhAxymeW6yYEM0IB9kdTOXkHLoz65BWKoC
         gHwMKK3dWCeycukg90DZOFiXybjV8lIopzP7cXPnGYzDGTnDABK6P1R7BroCXakfdby2
         IIRg==
X-Gm-Message-State: APjAAAXRgEA7CjWtHhL2yk9r6jzUYRDFwPClWmjLUMUi88svtOLvJJSH
        sPq6lcVRjHurxTAEiypDs481NBb10gY=
X-Google-Smtp-Source: APXvYqxF7ykA/kf99QruolBopZYp5p4PGISA/FBp9efQscn5LVLJvQ9HEnAdWkYDlooRd84lKgzCzQ==
X-Received: by 2002:a63:7444:: with SMTP id e4mr3119864pgn.398.1551819289844;
        Tue, 05 Mar 2019 12:54:49 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id i4sm13411788pfo.158.2019.03.05.12.54.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Mar 2019 12:54:48 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Andrew F . Davis" <afd@ti.com>, Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel@lists.freedesktop.org
Subject: [RFC][PATCH 5/5 v2] kselftests: Add dma-heap test
Date:   Tue,  5 Mar 2019 12:54:33 -0800
Message-Id: <1551819273-640-6-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add very trivial allocation test for dma-heaps.

TODO: Need to actually do some validation on
the returned dma-buf.

Cc: Laura Abbott <labbott@redhat.com>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Liam Mark <lmark@codeaurora.org>
Cc: Brian Starkey <Brian.Starkey@arm.com>
Cc: Andrew F. Davis <afd@ti.com>
Cc: Chenbo Feng <fengc@google.com>
Cc: Alistair Strachan <astrachan@google.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2: Switched to use reworked dma-heap apis
---
 tools/testing/selftests/dmabuf-heaps/Makefile      | 11 +++
 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c | 96 ++++++++++++++++++++++
 2 files changed, 107 insertions(+)
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
index 0000000..06837a4
--- /dev/null
+++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+
+#include "../../../../include/uapi/linux/dma-heap.h"
+
+#define DEVPATH "/dev/dma_heap"
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
+	int heap_fd = -1, dmabuf_fd = -1;
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
+	/* DO SOMETHING WITH THE DMABUF HERE? */
+
+out:
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
+
+	return 0;
+}
-- 
2.7.4

