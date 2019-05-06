Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1224C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F60A20C01
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RgL6sD0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfEFQcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 12:32:03 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:56307 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbfEFQcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 12:32:01 -0400
Received: by mail-ua1-f74.google.com with SMTP id j14so236952ual.22
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 09:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SWVsw2knEHBiqwTje+QZ95uhvJ0Eq8KQC+Uh3mHLIrs=;
        b=RgL6sD0qMVVBo2W6IqHUBM5jj9VtirOB0KEMhgfz8sMUxbZ1FQX2voyY3kT1G83YUB
         c2NHug1MaUbvaiT2/kwsYJcX1LID/13F0wNOf2AHICLEHy5XvFyjYislt0SYk+XJ6yKP
         649zRPJ+NdSdXSoussFiI5QFPPYrqQUh3ojhtBNMt1d4e4tKjAnQkQjx5Eh1zuXQvQIM
         JcTGFQAzGxQj9nG+dHgIo2BfMYCnSXgaj1ghPhO7L6oN78p0fysyobcM96NyuviAQaqi
         YZLFqu1hahvJ559CgByQZZLzdRPUlocjvpj3Ingemtoy/aM5Di1UnW6jML/TVEYZ07jc
         pviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SWVsw2knEHBiqwTje+QZ95uhvJ0Eq8KQC+Uh3mHLIrs=;
        b=QVG4rU8DmBahYGwWAfZRNTcIjsDU8p+8spdnTGVmV/HvvVkHSfAoEwZCHTg+VYB6C9
         N31LSOnLDBnnsauSocxuzf3RPfqg/CPGQYD2R1x8eCS5C7aicEo03/K7E+gU+uQ52lap
         4wIdaU//igMXTImD6mcfDHruLvx/Xkb+R/8mfht8Az52yC6JT0wzjK3x2IH+MjCQfoaQ
         laGiA1Gau6bfXYPOkDKEnueC8VIzSlCQI+Vu1BFaOl+xM2XA0vWpW2mJbbXsekvbHUUh
         pjRFSPUo2qoiZz8q8qPUPHRhGNt8fc9Fwn6/hMwA4zhhJlrRAoOZhL24HQXWi13cW7l8
         vgGQ==
X-Gm-Message-State: APjAAAVVbz/yKuOXgkiH4xhYSa20zj/kD3juoD/bR1ay9pNiO3gxu2mn
        1xy3JdfsVU6ocxXN5Q7GOZewhaxRirCL2iBr
X-Google-Smtp-Source: APXvYqzqHfit8S9j9GkAK338RCzBXfh/l/pOO+ozkZWr4c4UHEKzTSoAg+io9ZiclURMXMIijYhqt5pgUoOVGv8c
X-Received: by 2002:a67:f6c4:: with SMTP id v4mr13696595vso.182.1557160319808;
 Mon, 06 May 2019 09:31:59 -0700 (PDT)
Date:   Mon,  6 May 2019 18:31:03 +0200
In-Reply-To: <cover.1557160186.git.andreyknvl@google.com>
Message-Id: <e31d9364eb0c2eba8ce246a558422e811d82d21b.1557160186.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1557160186.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v15 17/17] selftests, arm64: add a selftest for passing tagged
 pointers to kernel
From:   Andrey Konovalov <andreyknvl@google.com>
To:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a part of a series that extends arm64 kernel ABI to allow to
pass tagged user pointers (with the top byte set to something else other
than 0x00) as syscall arguments.

This patch adds a simple test, that calls the uname syscall with a
tagged user pointer as an argument. Without the kernel accepting tagged
user pointers the test fails with EFAULT.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 tools/testing/selftests/arm64/.gitignore      |  1 +
 tools/testing/selftests/arm64/Makefile        | 11 ++++++++++
 .../testing/selftests/arm64/run_tags_test.sh  | 12 +++++++++++
 tools/testing/selftests/arm64/tags_test.c     | 21 +++++++++++++++++++
 4 files changed, 45 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/.gitignore
 create mode 100644 tools/testing/selftests/arm64/Makefile
 create mode 100755 tools/testing/selftests/arm64/run_tags_test.sh
 create mode 100644 tools/testing/selftests/arm64/tags_test.c

diff --git a/tools/testing/selftests/arm64/.gitignore b/tools/testing/selftests/arm64/.gitignore
new file mode 100644
index 000000000000..e8fae8d61ed6
--- /dev/null
+++ b/tools/testing/selftests/arm64/.gitignore
@@ -0,0 +1 @@
+tags_test
diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
new file mode 100644
index 000000000000..a61b2e743e99
--- /dev/null
+++ b/tools/testing/selftests/arm64/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# ARCH can be overridden by the user for cross compiling
+ARCH ?= $(shell uname -m 2>/dev/null || echo not)
+
+ifneq (,$(filter $(ARCH),aarch64 arm64))
+TEST_GEN_PROGS := tags_test
+TEST_PROGS := run_tags_test.sh
+endif
+
+include ../lib.mk
diff --git a/tools/testing/selftests/arm64/run_tags_test.sh b/tools/testing/selftests/arm64/run_tags_test.sh
new file mode 100755
index 000000000000..745f11379930
--- /dev/null
+++ b/tools/testing/selftests/arm64/run_tags_test.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+echo "--------------------"
+echo "running tags test"
+echo "--------------------"
+./tags_test
+if [ $? -ne 0 ]; then
+	echo "[FAIL]"
+else
+	echo "[PASS]"
+fi
diff --git a/tools/testing/selftests/arm64/tags_test.c b/tools/testing/selftests/arm64/tags_test.c
new file mode 100644
index 000000000000..2bd1830a7ebe
--- /dev/null
+++ b/tools/testing/selftests/arm64/tags_test.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <stdint.h>
+#include <sys/utsname.h>
+
+#define SHIFT_TAG(tag)		((uint64_t)(tag) << 56)
+#define SET_TAG(ptr, tag)	(((uint64_t)(ptr) & ~SHIFT_TAG(0xff)) | \
+					SHIFT_TAG(tag))
+
+int main(void)
+{
+	struct utsname *ptr = (struct utsname *)malloc(sizeof(*ptr));
+	void *tagged_ptr = (void *)SET_TAG(ptr, 0x42);
+	int err = uname(tagged_ptr);
+
+	free(ptr);
+	return err;
+}
-- 
2.21.0.1020.gf2820cf01a-goog

