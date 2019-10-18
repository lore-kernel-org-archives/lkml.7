Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2EDCA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3CF221D7C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505562AbfJRR3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 13:29:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36272 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727068AbfJRR3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 13:29:13 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F2B7F69096
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 17:29:12 +0000 (UTC)
Received: by mail-qt1-f199.google.com with SMTP id n59so6571337qtd.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 10:29:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2oj75l9QzVi3O8swsxVYBJiXU84Ws6wegO8SmVESxbQ=;
        b=d+LDteULBbT5ypuOfFgo6Mi587joWTgxWXabPvZSnU8osQA+bzH0+9ExxmKb72qWMh
         XAGOEiU4k8lm8+xJpjRP59Wz+/Nuf5jDV8xtGHtDiQdaROy9hc134wyEbO8V6Q6CqjxZ
         DWYoqoYMRU3SX8piBznIlrBm3dL+i3NKGZobUMTG7jeHajOH605X8AvC4H7TxHdE5o4R
         BubjM9foAkO9KbGP8mFfjZz80KzEAvRJWZ+CN6udpuAtUnQl6mUdvQMta1ez6FBVcUkl
         zzfhx6W6Ejh9pqLWtRy0PZG1+vZ3SVIhjaRk5kI4EHRrjfKy4ixyTUEtrbP/mApRPgun
         qIqQ==
X-Gm-Message-State: APjAAAW6IaR309o7ESn+KKtPpiao8UJVDt7GvOufXXoeH8bGqV/+fu2j
        bOQbQunTGKR7joRcUP2Clcmq2eRVik6UpkOvpAiL+QqhTjFUsc+vSQr6Ts+2aoE6yR4yoxuvOHM
        npflBNG0SnvmF1Iik3kj6zxF/
X-Received: by 2002:ac8:70ce:: with SMTP id g14mr10793087qtp.215.1571419752219;
        Fri, 18 Oct 2019 10:29:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzfDp1Xn2DKDFOFHm9+c+k6Z7LtK3Pq8ebJ45zwI0obsNiJa/TYKBH4+5c+1bVr1cSveoWwKg==
X-Received: by 2002:ac8:70ce:: with SMTP id g14mr10793054qtp.215.1571419751848;
        Fri, 18 Oct 2019 10:29:11 -0700 (PDT)
Received: from labbott-redhat.redhat.com (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id a15sm2798852qkn.134.2019.10.18.10.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 10:29:11 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] tools: iio: Correctly add make dependency for iio_utils
Date:   Fri, 18 Oct 2019 13:29:08 -0400
Message-Id: <20191018172908.3761-1-labbott@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iio tools fail to build correctly with make parallelization:

$ make -s -j24
fixdep: error opening depfile: ./.iio_utils.o.d: No such file or directory
make[1]: *** [/home/labbott/linux_upstream/tools/build/Makefile.build:96: iio_utils.o] Error 2
make: *** [Makefile:43: iio_event_monitor-in.o] Error 2
make: *** Waiting for unfinished jobs....

This is because iio_utils.o is used across multiple targets.
Fix this by making iio_utils.o a proper dependency.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
I realize that we don't really need the parallelization for tools
because it's so small but when building with the distro we want to use
the same make command and -j wherever possible.

This same issue also appears in the gpio tools so if this looks like an
okay approach I'll fix it there as well.
---
 tools/iio/Build    |  1 +
 tools/iio/Makefile | 10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/iio/Build b/tools/iio/Build
index f74cbda64710..8d0f3af3723f 100644
--- a/tools/iio/Build
+++ b/tools/iio/Build
@@ -1,3 +1,4 @@
+iio_utils-y += iio_utils.o
 lsiio-y += lsiio.o iio_utils.o
 iio_event_monitor-y += iio_event_monitor.o iio_utils.o
 iio_generic_buffer-y += iio_generic_buffer.o iio_utils.o
diff --git a/tools/iio/Makefile b/tools/iio/Makefile
index e22378dba244..3de763d9ab70 100644
--- a/tools/iio/Makefile
+++ b/tools/iio/Makefile
@@ -32,20 +32,24 @@ $(OUTPUT)include/linux/iio: ../../include/uapi/linux/iio
 
 prepare: $(OUTPUT)include/linux/iio
 
+IIO_UTILS_IN := $(OUTPUT)iio_utils-in.o
+$(IIO_UTILS_IN): prepare FORCE
+	$(Q)$(MAKE) $(build)=iio_utils
+
 LSIIO_IN := $(OUTPUT)lsiio-in.o
-$(LSIIO_IN): prepare FORCE
+$(LSIIO_IN): prepare FORCE $(OUTPUT)iio_utils-in.o
 	$(Q)$(MAKE) $(build)=lsiio
 $(OUTPUT)lsiio: $(LSIIO_IN)
 	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
 
 IIO_EVENT_MONITOR_IN := $(OUTPUT)iio_event_monitor-in.o
-$(IIO_EVENT_MONITOR_IN): prepare FORCE
+$(IIO_EVENT_MONITOR_IN): prepare FORCE $(OUTPUT)iio_utils-in.o
 	$(Q)$(MAKE) $(build)=iio_event_monitor
 $(OUTPUT)iio_event_monitor: $(IIO_EVENT_MONITOR_IN)
 	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
 
 IIO_GENERIC_BUFFER_IN := $(OUTPUT)iio_generic_buffer-in.o
-$(IIO_GENERIC_BUFFER_IN): prepare FORCE
+$(IIO_GENERIC_BUFFER_IN): prepare FORCE $(OUTPUT)iio_utils-in.o
 	$(Q)$(MAKE) $(build)=iio_generic_buffer
 $(OUTPUT)iio_generic_buffer: $(IIO_GENERIC_BUFFER_IN)
 	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
-- 
2.21.0

