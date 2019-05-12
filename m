Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FF1C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 07:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767FA21019
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 07:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ac0IRXE4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfELHep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 03:34:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40858 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfELHen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 03:34:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id u17so5467345pfn.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 00:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=USOysBqI3w7kudCtlGC42AJABhskc6i9dJ6S/ZjbPA4=;
        b=Ac0IRXE4pn8Mn9Cr3DcRk73L0HTIv9YbCcG3dsDAonQiqZpAOThIzWzMno9E6936c2
         KwIlS9kV7PFpLs01EtkRR4LEIczZFxMbu8QK0lvG6oUcPec6vIAZrmJcId+EDrpQuc5F
         UIElgzu/NIRbyQh4vf12IS/1BmNP/B7INjOM/pmNtLUscne7keiZWWzgI4jArNArfyZO
         uOmmdQPHyvkpis/PXIX4WWX32W+WVMSj0da5r0jcfVWhoLFUbFjkZWEKVNxOsm08OY7y
         8dwnJXHWwMknoD070M1rpLnT3oVNvzx7MlAb7x+/Fg9v9oboGQRVCEG+JrJ532TB2nRO
         efrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=USOysBqI3w7kudCtlGC42AJABhskc6i9dJ6S/ZjbPA4=;
        b=aFhtE9t8bN7yOxAFhp6JbNC44vBkxZXASlpyoqaSTd/Kp1KFQXkfU0L7AEqsLZJVRH
         ayCSOga5y/lVV1QMRo3FBmrU8no/j3gcFhaXUA34iXg9cHlMrwXWXyHMSIN5VQp8l9OO
         jZsShVKQwNXTrV36GMN3EfFiiSJYR+RqQ7Bl9fP0HV3t4IJwvW6BCHGCWrbycmrVNZUT
         vSDyUegQbP0/1JHWWhHob42TpAvCGOv0UonBF+kUyHFeDyl6oL8wHZ1MTmZOtpbgAcQg
         GZPJAIoYCoW8bTDtmTjSO+A5j2IlSjsh3wiOWzMeacsTYcCTK76r0QSSvaG1zArKoz/M
         OnzQ==
X-Gm-Message-State: APjAAAVmVoPvJTLhe1ngQ240etxCuqdkm/kVPZvjm+0p20yAAAkTt3nY
        dY9wVvhAxBikOdLLofKCKMT0L5bBGUU=
X-Google-Smtp-Source: APXvYqxLNI2ZA7OpYVomyBOTC5N5fpW0mBcMJx4fBBQJJzhGBpwSPUdhP2POU8koYXZ05SsTuHUI1g==
X-Received: by 2002:a63:5443:: with SMTP id e3mr24300584pgm.265.1557646481730;
        Sun, 12 May 2019 00:34:41 -0700 (PDT)
Received: from localhost.localdomain ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id e123sm5492242pgc.29.2019.05.12.00.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 00:34:40 -0700 (PDT)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Minwoo Im <minwoo.im.dev@gmail.com>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>
Subject: [PATCH V3 1/5] nvme: Make trace common for host and target both
Date:   Sun, 12 May 2019 16:34:09 +0900
Message-Id: <20190512073413.32050-2-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190512073413.32050-1-minwoo.im.dev@gmail.com>
References: <20190512073413.32050-1-minwoo.im.dev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support target-side trace, nvme-trace should be commonized for host
and target both.  Of course, not every single tracepoints are necessary
by both of them, but we don't need to have more than one trace module
for host and target.

Cc: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: James Smart <james.smart@broadcom.com>
Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 MAINTAINERS                     | 2 ++
 drivers/nvme/Makefile           | 3 +++
 drivers/nvme/host/Makefile      | 1 -
 drivers/nvme/host/core.c        | 3 +--
 drivers/nvme/host/pci.c         | 2 +-
 drivers/nvme/{host => }/trace.c | 5 +++++
 drivers/nvme/{host => }/trace.h | 2 +-
 7 files changed, 13 insertions(+), 5 deletions(-)
 rename drivers/nvme/{host => }/trace.c (95%)
 rename drivers/nvme/{host => }/trace.h (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 09f43f1bdd15..5974cadafcf7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11084,6 +11084,7 @@ L:	linux-nvme@lists.infradead.org
 T:	git://git.infradead.org/nvme.git
 W:	http://git.infradead.org/nvme.git
 S:	Supported
+F:	drivers/nvme/
 F:	drivers/nvme/host/
 F:	include/linux/nvme.h
 F:	include/uapi/linux/nvme_ioctl.h
@@ -11105,6 +11106,7 @@ L:	linux-nvme@lists.infradead.org
 T:	git://git.infradead.org/nvme.git
 W:	http://git.infradead.org/nvme.git
 S:	Supported
+F:	drivers/nvme/
 F:	drivers/nvme/target/
 
 NVMEM FRAMEWORK
diff --git a/drivers/nvme/Makefile b/drivers/nvme/Makefile
index 0096a7fd1431..12f193502d46 100644
--- a/drivers/nvme/Makefile
+++ b/drivers/nvme/Makefile
@@ -1,3 +1,6 @@
 
+ccflags-y		+= -I$(src)
+obj-$(CONFIG_TRACING)	+= trace.o
+
 obj-y		+= host/
 obj-y		+= target/
diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index 8a4b671c5f0c..46453352bfa0 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -10,7 +10,6 @@ obj-$(CONFIG_NVME_FC)			+= nvme-fc.o
 obj-$(CONFIG_NVME_TCP)			+= nvme-tcp.o
 
 nvme-core-y				:= core.o
-nvme-core-$(CONFIG_TRACING)		+= trace.o
 nvme-core-$(CONFIG_NVME_MULTIPATH)	+= multipath.o
 nvme-core-$(CONFIG_NVM)			+= lightnvm.o
 nvme-core-$(CONFIG_FAULT_INJECTION_DEBUG_FS)	+= fault_inject.o
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index eebaeadaa800..ae76c0b78a5f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -21,8 +21,7 @@
 #include <linux/pm_qos.h>
 #include <asm/unaligned.h>
 
-#define CREATE_TRACE_POINTS
-#include "trace.h"
+#include "../trace.h"
 
 #include "nvme.h"
 #include "fabrics.h"
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2a8708c9ac18..d90b66543d25 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -24,7 +24,7 @@
 #include <linux/sed-opal.h>
 #include <linux/pci-p2pdma.h>
 
-#include "trace.h"
+#include "../trace.h"
 #include "nvme.h"
 
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/trace.c
similarity index 95%
rename from drivers/nvme/host/trace.c
rename to drivers/nvme/trace.c
index 5f24ea7a28eb..a2c8186d122d 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/trace.c
@@ -5,6 +5,8 @@
  */
 
 #include <asm/unaligned.h>
+
+#define CREATE_TRACE_POINTS
 #include "trace.h"
 
 static const char *nvme_trace_create_sq(struct trace_seq *p, u8 *cdw10)
@@ -147,4 +149,7 @@ const char *nvme_trace_disk_name(struct trace_seq *p, char *name)
 }
 EXPORT_SYMBOL_GPL(nvme_trace_disk_name);
 
+EXPORT_TRACEPOINT_SYMBOL_GPL(nvme_setup_cmd);
+EXPORT_TRACEPOINT_SYMBOL_GPL(nvme_complete_rq);
+EXPORT_TRACEPOINT_SYMBOL_GPL(nvme_async_event);
 EXPORT_TRACEPOINT_SYMBOL_GPL(nvme_sq);
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/trace.h
similarity index 99%
rename from drivers/nvme/host/trace.h
rename to drivers/nvme/trace.h
index 97d3c77365b8..acf10c7a5bef 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/trace.h
@@ -14,7 +14,7 @@
 #include <linux/tracepoint.h>
 #include <linux/trace_seq.h>
 
-#include "nvme.h"
+#include "host/nvme.h"
 
 #define nvme_admin_opcode_name(opcode)	{ opcode, #opcode }
 #define show_admin_opcode_name(val)					\
-- 
2.17.1

