Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFCFC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 13:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA4E2068E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 13:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="zfvnKpIv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfK0Nff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 08:35:35 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55642 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbfK0Nfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 08:35:31 -0500
Received: by mail-wm1-f66.google.com with SMTP id a131so2811074wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 05:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wvtiCzTV9ngdllGdWC3MMOxHp8lFenXVYNh6sMVcpUw=;
        b=zfvnKpIvZtGUe2tCCwRfVeh8OZnjdOGc+KWdWidZxOyEU2jeILxbCw07Ezf7evm1hJ
         GNoH8sNDJfDzmhFbndvBYi35eai9X5FUy+Y2M/YEN5UvjyTYOWxUChCr3XUnaik7G+2C
         nHc8EOJ18f+XOlKQK9alu0uO5yXTeClDpBuWe9NQ8/xQjzNitQ+7g7rKux5x/OJfGohr
         qjgtBYv8pTHaBOEtcvW2R66VH2GPsruZlTkruTPvzLGRTME2Zp1powCF690WuNbNk8oF
         XmNWtayTZHwKVPfuow13X1mQZYrUoz120TxSpuvJBj4Db2MjqM5kvEkNfQfhpXkJt7Nc
         LvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wvtiCzTV9ngdllGdWC3MMOxHp8lFenXVYNh6sMVcpUw=;
        b=BYgYYj0RmU6MhHVrvXXSOI0D9wyPT7hyCL2ALjY3rEyIWzIkrNFW8MdBDrbvVIDej+
         OQwGRQoyWib1dr/8NeFAROR6TQKOAhiWk0M2B+e2vGDmeOB/kVFtr1WSmaaOKIuTEDQp
         styDSZe+Is8CAaHxVotDUUepKtm2TjjMIk1qPf8HuDxNojb06viqlS5eqynC49NBkeCW
         iU0WKJnB6xBnv6+/i0sxQQDsDS2smykh8zcYxTOdKcs/qnartjraSyqVE+oDMBXoPmgC
         RUfQuG+9nitdklkDYMJK+bsAXyhoYylXYzlqiSZFNP7AfOhrWGAcuhbwxBBnqv/9O2m+
         uaLg==
X-Gm-Message-State: APjAAAUO5JoCFqciqTdPwugzi5MYLe3Z774YGw7zAHQkMeIGnZYCmvO3
        qIT2RZPOt6BTFwfrt+ehw+T3QQ==
X-Google-Smtp-Source: APXvYqwQstKPL1NEjiApGQCa0hDVwQCIubyx0+Kd2dSNkHgw9aLYb86lXVSydUNNNx340g/lKfPhrA==
X-Received: by 2002:a1c:4944:: with SMTP id w65mr4304361wma.39.1574861728993;
        Wed, 27 Nov 2019 05:35:28 -0800 (PST)
Received: from debian-brgl.home (lfbn-1-7087-108.w90-116.abo.wanadoo.fr. [90.116.255.108])
        by smtp.gmail.com with ESMTPSA id k18sm19663687wrm.82.2019.11.27.05.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 05:35:28 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 8/8] tools: gpio: implement gpio-watch
Date:   Wed, 27 Nov 2019 14:35:10 +0100
Message-Id: <20191127133510.10614-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191127133510.10614-1-brgl@bgdev.pl>
References: <20191127133510.10614-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a simple program that allows to test the new LINECHANGED_FD ioctl().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 tools/gpio/.gitignore   |   1 +
 tools/gpio/Build        |   1 +
 tools/gpio/Makefile     |  11 +++-
 tools/gpio/gpio-watch.c | 114 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 126 insertions(+), 1 deletion(-)
 create mode 100644 tools/gpio/gpio-watch.c

diff --git a/tools/gpio/.gitignore b/tools/gpio/.gitignore
index a94c0e83b209..fffd32969d62 100644
--- a/tools/gpio/.gitignore
+++ b/tools/gpio/.gitignore
@@ -1,4 +1,5 @@
 gpio-event-mon
 gpio-hammer
 lsgpio
+gpio-watch
 include/linux/gpio.h
diff --git a/tools/gpio/Build b/tools/gpio/Build
index 4141f35837db..67c7b7f6a717 100644
--- a/tools/gpio/Build
+++ b/tools/gpio/Build
@@ -2,3 +2,4 @@ gpio-utils-y += gpio-utils.o
 lsgpio-y += lsgpio.o gpio-utils.o
 gpio-hammer-y += gpio-hammer.o gpio-utils.o
 gpio-event-mon-y += gpio-event-mon.o gpio-utils.o
+gpio-watch-y += gpio-watch.o
diff --git a/tools/gpio/Makefile b/tools/gpio/Makefile
index 6080de58861f..842287e42c83 100644
--- a/tools/gpio/Makefile
+++ b/tools/gpio/Makefile
@@ -18,7 +18,7 @@ MAKEFLAGS += -r
 
 override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
 
-ALL_TARGETS := lsgpio gpio-hammer gpio-event-mon
+ALL_TARGETS := lsgpio gpio-hammer gpio-event-mon gpio-watch
 ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
 
 all: $(ALL_PROGRAMS)
@@ -66,6 +66,15 @@ $(GPIO_EVENT_MON_IN): prepare FORCE $(OUTPUT)gpio-utils-in.o
 $(OUTPUT)gpio-event-mon: $(GPIO_EVENT_MON_IN)
 	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
 
+#
+# gpio-watch
+#
+GPIO_WATCH_IN := $(OUTPUT)gpio-watch-in.o
+$(GPIO_WATCH_IN): prepare FORCE
+	$(Q)$(MAKE) $(build)=gpio-watch
+$(OUTPUT)gpio-watch: $(GPIO_WATCH_IN)
+	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
+
 clean:
 	rm -f $(ALL_PROGRAMS)
 	rm -f $(OUTPUT)include/linux/gpio.h
diff --git a/tools/gpio/gpio-watch.c b/tools/gpio/gpio-watch.c
new file mode 100644
index 000000000000..7107ab24be52
--- /dev/null
+++ b/tools/gpio/gpio-watch.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * gpio-watch - monitor unrequested lines for property changes using the
+ *              character device
+ *
+ * Copyright (C) 2019 BayLibre SAS
+ * Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
+ */
+
+#include <ctype.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/gpio.h>
+#include <poll.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <unistd.h>
+
+static bool isnumber(const char *str)
+{
+	size_t sz = strlen(str);
+	int i;
+
+	for (i = 0; i < sz; i++) {
+		if (!isdigit(str[i]))
+			return false;
+	}
+
+	return true;
+}
+
+int main(int argc, char **argv)
+{
+	struct gpioline_changed_fd_request lc_req;
+	struct gpioline_changed chg;
+	struct pollfd pfd;
+	int fd, i, j, ret;
+	char *event;
+	ssize_t rd;
+
+	if (argc < 3)
+		goto err_usage;
+
+	fd = open(argv[1], O_RDWR | O_CLOEXEC);
+	if (fd < 0) {
+		perror("unable to open gpiochip");
+		return EXIT_FAILURE;
+	}
+
+	memset(&lc_req, 0, sizeof(lc_req));
+
+	for (i = 0, j = 2; i < argc - 2; i++, j++) {
+		if (!isnumber(argv[j]))
+			goto err_usage;
+
+		lc_req.lineoffsets[i] = atoi(argv[j]);
+	}
+
+	lc_req.num_lines = argc - 2;
+
+	ret = ioctl(fd, GPIO_GET_LINECHANGED_FD_IOCTL, &lc_req);
+	if (ret < 0) {
+		perror("unable to retrieve the linechanged fd");
+		return EXIT_FAILURE;
+	}
+
+	pfd.fd = lc_req.fd;
+	pfd.events = POLLIN | POLLPRI;
+
+	for (;;) {
+		ret = poll(&pfd, 1, 5000);
+		if (ret < 0) {
+			perror("error polling the linechanged fd");
+			return EXIT_FAILURE;
+		} else if (ret > 0) {
+			memset(&chg, 0, sizeof(chg));
+			rd = read(pfd.fd, &chg, sizeof(chg));
+			if (rd < 0 || rd != sizeof(chg)) {
+				if (rd != sizeof(chg))
+					errno = EIO;
+
+				perror("error reading line change event");
+				return EXIT_FAILURE;
+			}
+
+			switch (chg.event_type) {
+			case GPIOLINE_CHANGED_REQUESTED:
+				event = "requested";
+				break;
+			case GPIOLINE_CHANGED_RELEASED:
+				event = "released";
+				break;
+			case GPIOLINE_CHANGED_CONFIG:
+				event = "config changed";
+				break;
+			default:
+				fprintf(stderr,
+					"invalid event type received from the kernel\n");
+				return EXIT_FAILURE;
+			}
+
+			printf("line %u: %s\n", chg.line_offset, event);
+		}
+	}
+
+	return 0;
+
+err_usage:
+	printf("%s: <gpiochip> <line0> <line1> ...\n", argv[0]);
+	return EXIT_FAILURE;
+}
-- 
2.23.0

